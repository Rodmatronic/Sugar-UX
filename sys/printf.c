#include "types.h"
#include "stat.h"
#include "user.h"

#define PRINTF_BUF_SIZE 512

static char printf_buf[PRINTF_BUF_SIZE];
static int printf_buf_index = 0;
static void printf_putc(int fd, char c);

static void
flush(int fd)
{
    if(printf_buf_index > 0) {
        write(fd, printf_buf, printf_buf_index);
        printf_buf_index = 0;
    }
}

void
strncpy(char *dest, const char *src, int n)
{
  int i;
  for (i = 0; i < n && src[i]; i++)
    dest[i] = src[i];
  for (; i < n; i++)
    dest[i] = '\0';
}

void
putc(int c)
{
  printf_putc(1, c);
}

static void
printf_putc(int fd, char c)
{
  if(printf_buf_index >= PRINTF_BUF_SIZE) {
      flush(fd);
  }
  printf_buf[printf_buf_index++] = c;
}

static void
printint(int fd, int xx, int base, int sgn, int width, char pad_char)
{
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);

  if(neg)
    buf[i++] = '-';

  // Pad with pad_char until we hit the required width
  while(i < width)
    buf[i++] = pad_char;

  while(--i >= 0)
    printf_putc(fd, buf[i]);
}

int
puts(const char *s)
{
  int count = 0;
  if (s == 0)
      s = "(null)";
  while (*s) {
      printf_putc(1, *s);
      s++;
      count++;
  }
  printf_putc(1, '\n');
  count++;
  flush(1);
  return count;
}

// Minimal snprintf: supports %s, %d, %x, %c, and %%
int
snprintf(char *buf, int size, const char *fmt, ...)
{
    char *s;
    int c, n = 0, state = 0;
    uint *ap = (uint*)(void*)&fmt + 1;
    char numbuf[16];

    for (int fi = 0; fmt[fi] && n < size - 1; fi++) {
        c = fmt[fi] & 0xff;
        if (state == 0) {
            if (c == '%') {
                state = '%';
            } else {
                buf[n++] = c;
            }
        } else if (state == '%') {
            if (c == 'd') {
                int val = *ap++;
                int neg = 0;
                uint uval;
                if (val < 0) {
                    neg = 1;
                    uval = -val;
                } else {
                    uval = val;
                }
                int j = 0;
                do {
                    numbuf[j++] = '0' + (uval % 10);
                    uval /= 10;
                } while (uval && j < sizeof(numbuf));
                if (neg && j < sizeof(numbuf))
                    numbuf[j++] = '-';
                while (j-- && n < size - 1)
                    buf[n++] = numbuf[j];
                state = 0;
            } else if (c == 'x') {
                uint val = *ap++;
                int j = 0;
                do {
                    int digit = val % 16;
                    numbuf[j++] = (digit < 10) ? ('0' + digit) : ('a' + digit - 10);
                    val /= 16;
                } while (val && j < sizeof(numbuf));
                while (j-- && n < size - 1)
                    buf[n++] = numbuf[j];
                state = 0;
            } else if (c == 's') {
                s = (char*)*ap++;
                if (!s) s = "(null)";
                while (*s && n < size - 1)
                    buf[n++] = *s++;
                state = 0;
            } else if (c == 'c') {
                char ch = *ap++;
                if (n < size - 1)
                    buf[n++] = ch;
                state = 0;
            } else if (c == '%') {
                if (n < size - 1)
                    buf[n++] = '%';
                state = 0;
            } else {
                // Unknown format, just print it
                if (n < size - 1)
                    buf[n++] = '%';
                if (n < size - 1)
                    buf[n++] = c;
                state = 0;
            }
        }
    }
    buf[n] = 0;
    return n;
}

void
printf(char *fmt, ...)
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  int width = 0;
  int precision = -1;
  char pad_char = ' ';

  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
        width = 0;
        pad_char = ' ';
        precision = -1;
      } else {
        printf_putc(1, c);
      }
    } else if(state == '%'){
      if(c == '0'){
        pad_char = '0';
      } else if(c >= '1' && c <= '9'){
        width = width * 10 + (c - '0');
      } else if(c == '.'){
        // Handle precision
        i++;
        c = fmt[i];
        if(c == '*'){
          precision = *ap++;
          i++;
        } else {
          precision = 0;
          while(c >= '0' && c <= '9'){
            precision = precision * 10 + (c - '0');
            i++;
            c = fmt[i];
          }
        }
        i--; // Adjust position for format specifier
      } else if(c == 'd'){
        printint(1, *ap, 10, 1, width, pad_char);
        ap++;
        state = 0;
      } else if(c == 'x' || c == 'p'){
        printint(1, *ap, 16, 0, width, pad_char);
        ap++;
        state = 0;
      } else if(c == 'o'){
        printint(1, *ap, 8, 0, width, pad_char);
        ap++;
        state = 0;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        
        // Calculate printable length
        int len = 0;
        char *t = s;
        while(*t && (precision < 0 || len < precision)){
          len++;
          t++;
        }

        // Right-pad with spaces
        for(int j = len; j < width; j++)
          printf_putc(1, pad_char);

        // Output characters
        for(int j = 0; j < len; j++)
          printf_putc(1, s[j]);

        state = 0;
      } else if(c == 'c'){
        printf_putc(1, *ap++);
        state = 0;
      } else if(c == '%'){
        printf_putc(1, '%');
        state = 0;
      } else {
        printf_putc(1, '%');
        printf_putc(1, c);
        state = 0;
      }
    }
  }

  // Flush the buffer at the end
  flush(1);
}

// Print to the given fd
void
fprintf(int fd, char *fmt, ...)
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  int width = 0;
  char pad_char = ' ';

  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
        width = 0;
        pad_char = ' ';
      } else {
        printf_putc(fd, c);
      }
    } else if(state == '%'){
      if(c == '0'){
        pad_char = '0';
      } else if(c >= '1' && c <= '9'){
        width = width * 10 + (c - '0');
        continue; // keep parsing digits
      } else if(c == 'd'){
        printint(fd, *ap, 10, 1, width, pad_char);
        ap++;
        state = 0;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0, width, pad_char);
        ap++;
        state = 0;
      } else if(c == 'o'){
        printint(1, *ap, 8, 0, width, pad_char);
        ap++;
        state = 0;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        int len = 0;
        for (char *t = s; *t; t++) len++;
        for (int j = len; j < width; j++)
          printf_putc(fd, pad_char);
        while(*s != 0){
          printf_putc(fd, *s++);
        }
        state = 0;
      } else if(c == 'c'){
        char ch = *ap++;
        printf_putc(fd, ch);
        state = 0;
      } else if(c == '%'){
        printf_putc(fd, '%');
        state = 0;
      } else {
        printf_putc(fd, '%');
        printf_putc(fd, c);
        state = 0;
      }
    }
  }

  // Flush the buffer at the end
  flush(1);
}
