#include "types.h"
#include "stat.h"
#include "user.h"

void
strncpy(char *dest, const char *src, int n)
{
  int i;
  for (i = 0; i < n && src[i]; i++)
    dest[i] = src[i];
  for (; i < n; i++)
    dest[i] = '\0';
}

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn, int width, char pad_char)
{
  static char digits[] = "0123456789ABCDEF";
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
    putc(fd, buf[i]);
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
  char pad_char = ' ';

  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if (c == '\f') {
        setcursor();
      } else if(c == '%'){
        state = '%';
        width = 0;
        pad_char = ' ';
      } else {
        putc(1, c);
      }
    } else if(state == '%'){
      if(c == '0'){
        pad_char = '0';
      } else if(c >= '1' && c <= '9'){
        width = width * 10 + (c - '0');
        continue; // keep parsing digits
      } else if(c == 'd'){
        printint(1, *ap, 10, 1, width, pad_char);
        ap++;
        state = 0;
      } else if(c == 'x' || c == 'p'){
        printint(1, *ap, 16, 0, width, pad_char);
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
          putc(1, pad_char);
        while(*s != 0){
          putc(1, *s++);
        }
        state = 0;
      } else if(c == 'c'){
        char ch = *ap++;
        putc(1, ch);
        state = 0;
      } else if(c == '%'){
        putc(1, '%');
        state = 0;
      } else {
        putc(1, '%');
        putc(1, c);
        state = 0;
      }
    }
  }
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
fprintf(int fd, char *fmt, ...)
{
  char *s;
  int c, i, state;
  uint *ap;

  int width = 0;
  char pad_char = ' ';

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if (c == '\f') { // Detect formfeed character
        setcursor();
      } else
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(1, *ap, 10, 1, width, pad_char);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(1, *ap, 16, 0, width, pad_char);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    }
  }
}

