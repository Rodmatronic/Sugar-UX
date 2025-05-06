#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "file.h"
#include "stat.h"
#include "config.h"

// Default hostname
char hostname[MAXHOSTNAMELEN] = "localhost";
void sys_setcursor(void);

int
sys_usleep(void)
{
    int usec;
    if (argint(0, &usec) < 0)
      return -1;
  
    // Convert to ticks
    int ticks_needed = usec / 10000; // each tick ~10,000 us
  
    if (ticks_needed == 0)
      ticks_needed = 1; // minimum sleep = 1 tick
  
    acquire(&tickslock);
    uint ticks0 = ticks;
    while (ticks - ticks0 < ticks_needed)
      sleep(&ticks, &tickslock);
    release(&tickslock);
    return 0;
}

int
sys_ttyname(void)
{
  int fd;
  char *buf;
  int buflen;
  struct file *f;

  // Retrieve fd, buffer pointer, and buffer length
  if (argint(0, &fd) < 0 || argptr(1, &buf, 1) < 0 || argint(2, &buflen) < 0)
    return -1;

  struct proc *p = myproc();

  // Validate file descriptor
  if (fd < 0 || fd >= NOFILE || (f = p->ofile[fd]) == 0)
    return -1;

  // Check if it's a TTY device
  if (f->type != FD_INODE || !(f->ip->type == T_DEV && f->ip->major == TTY_MAJOR))
    return -1;

  int tty_num = f->ip->minor; // Terminal number from minor device number

  // Construct "/dev/ttyX" (e.g., "/dev/tty0")
  char tty_name[10] = "/dev/tty0"; // Max length 9 + null terminator
  tty_name[8] = '0' + tty_num; // Replace last character with terminal number
  tty_name[9] = '\0';

  // Check buffer length
  if (buflen < strlen(tty_name) + 1)
    return -1;

  // Copy to user buffer
  safestrcpy(buf, tty_name, buflen);
  return 0;
}

int
sys_reboot(void)
{
  if (myproc()->uid != 0) { // Normally the program running this would check, this is a failsafe
    kprintf("Only root can reset the system!\n");
    return -1;
  }

  kprintf("rebooting...\n");

  outb(0x64, 0xFE); // Send reset command

  for (;;) asm volatile("hlt");
  return 0;
}

int
sys_halt(void)
{
  if (myproc()->uid != 0) { // Normally the program running this would check, this is a failsafe
    kprintf("Only root can halt the system!\n");
    return -1;
  }

  asm volatile("cli");  // Disable interrupts
  kprintf("\nThe operating system has halted.\n\n");
  for(;;) asm volatile("hlt");
  return 0;
}


int
sys_setenv(void)
{
  char *name, *value;
  if (argstr(0, &name) < 0 || argstr(1, &value) < 0)
    return -1;

  struct proc *p = myproc();
  for (int i = 0; i < p->env_count; i++) {
    if (strncmp(p->env[i].name, name, MAX_ENV_NAME) == 0) {
      safestrcpy(p->env[i].value, value, MAX_ENV_VALUE);
      return 0;
    }
  }

  if (p->env_count >= MAX_ENV_VARS)
    return -1;

  safestrcpy(p->env[p->env_count].name, name, MAX_ENV_NAME);
  safestrcpy(p->env[p->env_count].value, value, MAX_ENV_VALUE);
  p->env_count++;
  return 0;
}

int
sys_getenv(void)
{
  char *name, *value;
  if (argstr(0, &name) < 0 || argptr(1, &value, MAX_ENV_VALUE) < 0)
    return -1;

  struct proc *p = myproc();
  for (int i = 0; i < p->env_count; i++) {
    if (strncmp(p->env[i].name, name, MAX_ENV_NAME) == 0) {
      safestrcpy(value, p->env[i].value, MAX_ENV_VALUE);
      return 0;
    }
  }

  // Variable not found: Clear the output buffer to avoid returning junk
  safestrcpy(value, "", MAX_ENV_VALUE);
  return 0;
}

static int
strnlen_safe(const char *s, int max)
{
  int i = 0;
  while(i < max && s[i])
    i++;
  return i;
}

int
sys_listenv(void)
{
  char *ubuf;
  int buflen;
  if (argptr(0, &ubuf, 1) < 0 || argint(1, &buflen) < 0)
    return -1;

  struct proc *p = myproc();
  int pos = 0;
  for (int i = 0; i < p->env_count; i++) {
    int n = safestrnlen(p->env[i].name, MAX_ENV_NAME);
    if (pos + n + 1 >= buflen) break;
    safestrcpy(ubuf + pos, p->env[i].name, buflen - pos);
    pos += n;
    ubuf[pos++] = '=';
    n = safestrnlen(p->env[i].value, MAX_ENV_VALUE);
    if (pos + n + 1 >= buflen) break;
    safestrcpy(ubuf + pos, p->env[i].value, buflen - pos);
    pos += n;
    ubuf[pos++] = '\n';
  }
  if (pos < buflen)
    ubuf[pos] = 0;
  return 0;
}

int
sys_clear(void)
{
  ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory
  int i;
  for(i = 0; i < 80*25; i++)
    crt[i] = ' ' | 0x0700;
  ttyclear();
  return 0;
}

int
sys_gethostname(void)
{
  struct utsname *u;
  char *addr;

  // Get the user-space pointer argument
  if(argptr(0, &addr, sizeof(*u)) < 0)
    return -1;
  u = (struct utsname *)addr;

  // Copy hostname to user space
  safestrcpy(u->nodename, hostname, sizeof(u->nodename));
  return 0;
}

int
sys_sethostname(void)
{
  char *name;
  int len;

  // Get arguments from user space
  if(argstr(0, &name) < 0 || argint(1, &len) < 0)
    return -1;

  // Validate length
  if(len <= 0 || len >= MAXHOSTNAMELEN)
    return -1;

  // Only root can change hostname
  if(myproc()->uid != 0)
    return -1;

  // Copy new hostname
  safestrcpy(hostname, name, MAXHOSTNAMELEN);
  return 0;
}

int
sys_getuid(void) {
  return myproc()->uid;
}

int
sys_setuid(void) {
  int uid;
  if (argint(0, &uid) < 0) return -1;

  struct proc *p = myproc();
  // Allow only root (UID 0) to change UID
  //if (p->uid != 0) return -1;
  p->uid = uid;
  return 0;
}

int
sys_echo(void) {
  int enable;
  if (argint(0, &enable) < 0) return -1;
  console_echo(enable); // Defined in console.c
  return 0;
}

int sys_uname(void) {
  struct utsname *u;
  char *addr;

  // Get the user-space pointer argument
  if(argptr(0, &addr, sizeof(*u)) < 0)
    return -1;
  u = (struct utsname *)addr;

  // Copy strings to user space
  safestrcpy(u->sysname, KERNEL_NAME, sizeof(u->sysname));
  safestrcpy(u->nodename, hostname, sizeof(u->nodename));
  safestrcpy(u->release, RELEASE, sizeof(u->release));
  safestrcpy(u->version, VERSION, sizeof(u->version));
  safestrcpy(u->machine, MACHINE, sizeof(u->machine));

  return 0;
}

void
sys_setcursor(void) 
{
  // Set cursor to (0,0) via VGA ports
  outb(0x3D4, 0x0F);
  outb(0x3D5, 0x00);
  outb(0x3D4, 0x0E);
  outb(0x3D5, 0x00);
}

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(int status)
{
  exit(status);
  panic("exit: system call returned");
  return 0;  // not reached
}

int
sys_wait(void)
{
  int *status;
  if(argptr(0, (void*)&status, sizeof(*status)) < 0)
    return -1;
  return wait(status);
}

int
sys_kill(void) {
  int pid;
  if (argint(0, &pid) < 0) return -1;

  struct proc *p;
  struct proc *current = myproc();

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
    if (p->pid == pid) {
      // Check if current user is root or the owner
      if (current->uid != 0 && current->uid != p->uid) return -1;
      p->killed = 1;
      if (p->state == SLEEPING) p->state = RUNNABLE;
      return 0;
    }
  }
  return -1;
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}
