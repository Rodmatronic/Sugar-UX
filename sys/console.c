// Console input and output.
// Input is from the keyboard or serial port.
// Output is written to the screen and serial port.

#include "types.h"
#include "defs.h"
#include "param.h"
#include "traps.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "fs.h"
#include "file.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"
#include "kbd.h"

static void consputc(int c, int colour, int tty);
static void cgaputc(int colour, int c, int tty);
static int echo = 1;
static int panicked = 0;

struct terminal terminals[NTERMINALS];
int active_terminal = 0;

#define kcolour 0x8E00
#define ucolour 0x0700

static struct {
  struct spinlock lock;
  int locking;
} cons;

void
console_echo(int enable)
{
  struct proc *p = myproc();
  
  // Validate TTY index
  if(p->tty < 0 || p->tty >= NTERMINALS) {
    return;
  }

  acquire(&terminals[p->tty].input_lock);
  terminals[p->tty].echo = enable;
  release(&terminals[p->tty].input_lock);
}

static void
printint(int xx, int base, int sign)
{
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

    while(--i >= 0)
    consputc(buf[i], kcolour, 0); // Hardcode to TTY0
}
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
kprintf(char *fmt, ...)
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    if(c != '%'){
      consputc(c, kcolour, 0);
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
        consputc(*s, kcolour, 0);
      break;
    case '%':
      consputc('%', kcolour, 0);
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%', kcolour, 0);
      consputc(c, kcolour, 0);
      break;
    }
  }

  if(locking)
    release(&cons.lock);
}

void
panic(char *s)
{
  cli();
  cons.locking = 0;
  kprintf("panic: %s\n", s);
  int ticks = sys_uptime();
  int total_seconds = ticks / 100;  // Convert ticks to seconds
  int minutes = total_seconds / 60;
  int seconds = total_seconds % 60;
  kprintf("uptime:  %dm%ds\n", minutes, seconds);
  struct proc *curproc = myproc();
  kprintf("process: %s\nstate:   0x%x\n", curproc->name, curproc->state);
  kprintf("System Halted. Please contact your System Administrator with the above info.");

  panicked = 1; // freeze other CPU
  for(;;);
}

//PAGEBREAK: 50
#define BACKSPACE 0x100
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory
#define IS_ASCII_CHAR(c) ((c >= 0x00 && c <= 0x1F) || (c >= 0xE2 && c <= 0xE5))

void
switch_terminal(int new_tty)
{
  if (new_tty >= 0 && new_tty < NTERMINALS) {
    active_terminal = new_tty;
    // Update CGA memory to new terminal's buffer
    memmove(crt, terminals[new_tty].crt_buffer, sizeof(crt[0])*80*25);
  }

  // Save current terminal's cursor and screen state is already maintained
  // Load new terminal's state
  struct terminal *term = &terminals[new_tty];
  memmove(crt, term->crt_buffer, sizeof(term->crt_buffer));
  int pos = term->cursor_pos;
  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos >> 8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  active_terminal = new_tty;
  crt[pos] = '\0' | ucolour;
}

static void
cgaputc(int colour, int c, int tty)
{
  struct terminal *term = &terminals[tty];
  int pos = term->cursor_pos;
  ushort *active_crt = crt;  // Physical CGA memory

  // Handle character processing
  if(c == '\n') {
    pos += 80 - pos%80;
  } else if(c == BACKSPACE) {
    if(pos > 0) --pos;
  } else if(c == 0x09) {  // Tab
    pos += 8 - (pos%8);
  } else if(c >= ' ' && c < 0x7F) {
    term->crt_buffer[pos] = c | colour;
    if(tty == active_terminal)
      active_crt[pos] = c | colour;
    pos++;
  } else if(c == 0x7F) {  // Delete
    term->crt_buffer[pos] = ' ' | colour;
    if(tty == active_terminal)
      active_crt[pos] = ' ' | colour;
    pos++;
  } else if(c == '\r') {
    pos -= pos % 80;
  } else if(c == '\b') {
    if(pos > 0) --pos;
  } else if(!IS_ASCII_CHAR(c)) {
    term->crt_buffer[pos] = (c&0xff) | colour;
    if(tty == active_terminal)
      active_crt[pos] = (c&0xff) | colour;
    pos++;
  } else if (c >= 0x00 && c <= 0x1F) {  // Handle remaining control characters
    // Display as ^ followed by corresponding character
    term->crt_buffer[pos] = '^' | colour;
    if(tty == active_terminal)
      active_crt[pos] = '^' | colour;
    pos++;
    char disp_char = (c == 0x00) ? '@' : c + 0x40; // Handle 0x00 as ^@
    term->crt_buffer[pos] = disp_char | colour;
    if(tty == active_terminal)
      active_crt[pos] = disp_char | colour;
    pos++;
  }

  if((pos/80) >= 25) {
    memmove(term->crt_buffer, term->crt_buffer + 80, sizeof(term->crt_buffer[0])*24*80);
    if(tty == active_terminal)
      memmove(active_crt, active_crt + 80, sizeof(active_crt[0])*24*80);
    
    pos -= 80;
    memset(term->crt_buffer + pos, 0, sizeof(term->crt_buffer[0])*(25*80 - pos));
    if(tty == active_terminal)
      memset(active_crt + pos, 0, sizeof(active_crt[0])*(25*80 - pos));
  }

  term->cursor_pos = pos;
  if(tty == active_terminal) {
    outb(CRTPORT, 14);
    outb(CRTPORT+1, pos>>8);
    outb(CRTPORT, 15);
    outb(CRTPORT+1, pos);
    crt[pos] = '\0' | ucolour;
  }
}

static void
consputc(int c, int colour, int tty)
{
  if(panicked){
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(colour, c, tty);
}

void
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;
  int tty = active_terminal;

  acquire(&terminals[tty].input_lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
      case C('U'):  // Kill line.
        while(terminals[tty].input.e != terminals[tty].input.w &&
            terminals[tty].input.buf[(terminals[tty].input.e-1) % INPUT_BUF] != '\n'){
        terminals[tty].input.e--;
        if (terminals[tty].echo) {
          consputc(c, terminals[tty].color, active_terminal); // Echo to active TTY
        }
      }
      break;
    case KEY_F1:  // Switch to previous terminal
      switch_terminal((active_terminal - 1 + NTERMINALS) % NTERMINALS);
      break;
    case KEY_F2:  // Switch to next terminal
      switch_terminal((active_terminal + 1) % NTERMINALS);
      break;
    case C('H'): case '\x7f':  // Backspace
      if(terminals[tty].input.e != terminals[tty].input.w){
        terminals[tty].input.e--;
        if (terminals[tty].echo) {
          // Erase character: [BACKSPACE][SPACE][BACKSPACE]
          consputc(BACKSPACE, terminals[tty].color, tty);
          consputc(' ', terminals[tty].color, tty);
          consputc(BACKSPACE, terminals[tty].color, tty);
        }
      }
      break;
    default:
      if(c != 0 && terminals[tty].input.e - terminals[tty].input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        terminals[tty].input.buf[terminals[tty].input.e++ % INPUT_BUF] = c;
        if (terminals[tty].echo) {
          consputc(c, terminals[tty].color, tty);
        }
        if(c == '\n' || c == C('D') || terminals[tty].input.e == terminals[tty].input.r + INPUT_BUF){
          terminals[tty].input.w = terminals[tty].input.e;
          wakeup(&terminals[tty].input.r);
        }
      }
      break;
    }
  }
  release(&terminals[tty].input_lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
  struct proc *p = myproc();
  int tty = p->tty;
  uint target;
  int c;

  iunlock(ip);
  target = n;
  acquire(&terminals[tty].input_lock);
  while(n > 0){
    while(terminals[tty].input.r == terminals[tty].input.w){
      if(p->killed){
        release(&terminals[tty].input_lock);
        ilock(ip);
        return -1;
      }
      sleep(&terminals[tty].input.r, &terminals[tty].input_lock);
    }
    c = terminals[tty].input.buf[terminals[tty].input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        terminals[tty].input.r--;
      }
      break;
    }
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&terminals[tty].input_lock);
  ilock(ip);

  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
  int i;
  struct proc *p = myproc();

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
    consputc(buf[i] & 0xff, ucolour, p->tty);
  release(&cons.lock);
  ilock(ip);

  return n;
}

int consoleread_tty(int tty, char *dst, int n);

int
ttyread(struct inode *ip, char *dst, int n)
{
  int tty = ip->minor;
  // Use active terminal for /dev/tty
  if (tty == 255) {
    tty = active_terminal; // Directly use global active terminal
  }
  return consoleread_tty(tty, dst, n);
}

int
ttywrite(struct inode *ip, char *buf, int n)
{
  int tty = ip->minor;
  // Use active terminal for /dev/tty
  if (tty == 255) {
    tty = active_terminal; // Directly use global active terminal
  }
  for(int i=0; i<n; i++)
    consputc(buf[i] & 0xff, ucolour, tty);
  return n;
}

int
consoleread_tty(int tty, char *dst, int n)
{
  uint target;
  int c;
  struct proc *p = myproc();

  acquire(&terminals[tty].input_lock);
  target = n;
  while(n > 0){
    while(terminals[tty].input.r == terminals[tty].input.w){
      if(p->killed){
        release(&terminals[tty].input_lock);
        return -1;
      }
      sleep(&terminals[tty].input.r, &terminals[tty].input_lock);
    }
    c = terminals[tty].input.buf[terminals[tty].input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
        terminals[tty].input.r--;
      }
      break;
    }
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  
  }
  release(&terminals[tty].input_lock);
  return target - n;
}

void
ttyclear(void)
{
  struct proc *p = myproc();
  int tty = p->tty;
  memset(terminals[active_terminal].crt_buffer, 0, sizeof(terminals[active_terminal].crt_buffer));
  terminals[active_terminal].cursor_pos = 0;
}

void
consoleinit(void)
{
  for (int i = 0; i < NTERMINALS; i++) {
    initlock(&terminals[i].input_lock, "console");
    terminals[i].echo = 1;
    terminals[i].color = ucolour;
    memset(terminals[i].crt_buffer, 0, sizeof(terminals[i].crt_buffer));
  }

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  devsw[TTY_MAJOR].write = ttywrite;
  devsw[TTY_MAJOR].read = ttyread;
  ioapicenable(IRQ_KBD, 0);
}

