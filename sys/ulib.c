#include "types.h"
#include "stat.h"
#include "fcntl.h"
#include "user.h"
#include "x86.h"

// Natural order string comparison: compares numbers numerically
int
natcmp(const char *a, const char *b)
{
    while (*a && *b) {
        if (isdigit(*a) && isdigit(*b)) {
            // Compare numbers as integers
            int ai = 0, bi = 0;
            while (isdigit(*a)) {
                ai = ai * 10 + (*a - '0');
                a++;
            }
            while (isdigit(*b)) {
                bi = bi * 10 + (*b - '0');
                b++;
            }
            if (ai != bi)
                return ai - bi;
        } else {
            if (*a != *b)
                return *a - *b;
            a++;
            b++;
        }
    }
    return *a - *b;
}

char*
fmtname(char *path)
{
    static char buf[14+1];
    char *p;

    // Find first character after last slash.
    for(p = path + strlen(path); p >= path && *p != '/'; p--)
        ;
    p++;

    // Return name without padding
    int len = strlen(p);
    if (len >= 14)
        len = 14;
    memmove(buf, p, len);
    buf[len] = '\0';
    return buf;
}

// Use Zeller's Congruence to get weekday name
char*
get_weekday(int y, int m, int d)
{
  static char* days[] = {
    "Sat", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri"
  };

  if (m < 3) {
    m += 12;
    y -= 1;
  }

  int h = (d + 2*m + 3*(m+1)/5 + y + y/4 - y/100 + y/400) % 7;
  return days[h];
}

// Convert month number to name
char*
monthname(int m)
{
  static char* months[] = {
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
  };

  if (m < 1 || m > 12)
    return "???";

  return months[m - 1];
}

char*
basename(char *path)
{
  char *p = path + strlen(path);
  while(p > path && *(p-1) != '/')
    p--;
  return p;
}

char*
strncat(char *dest, const char *src, int n)
{
  char *orig = dest;

  // Find end of destination
  while(*dest)
    dest++;

  // Copy up to n bytes
  while(n-- > 0 && (*dest = *src)) {
    dest++;
    src++;
  }

  // Always null-terminate
  *dest = '\0';
  
  return orig;
}

long
strtol(const char *nptr, char **endptr, int base)
{
    const char *p = nptr;
    long val = 0;
    int sign = 1;

    // Skip whitespace
    while (*p == ' ' || *p == '\t')
        p++;

    // Handle sign
    if (*p == '-') {
        sign = -1;
        p++;
    } else if (*p == '+') {
        p++;
    }

    if (base == 10) {
        while (*p >= '0' && *p <= '9') {
            val = val * 10 + (*p - '0');
            p++;
        }
    }

    if (endptr != 0)
        *endptr = (char*)p;

    return sign * val;
}

int
isdigit(int c)
{
  return c >= '0' && c <= '9';
}

char*
strdup(const char *s)
{
    int len = strlen((char*)s);
    char *copy = malloc(len + 1);
    if (!copy)
        return 0;
    strcpy(copy, (char*)s);
    return copy;
}

int
strspn(const char *s, const char *accept)
{
    int i = 0;
    while (s[i]) {
        const char *a = accept;
        int found = 0;
        while (*a) {
            if (s[i] == *a) {
                found = 1;
                break;
            }
            a++;
        }
        if (!found)
            break;
        i++;
    }
    return i;
}

int
strcspn(const char *s, const char *reject)
{
    int i = 0;
    while (s[i]) {
        const char *r = reject;
        while (*r) {
            if (s[i] == *r)
                return i;
            r++;
        }
        i++;
    }
    return i;
}

char*
strtok(char *str, const char *delim)
{
    static char *last;
    if (str)
        last = str;
    if (!last)
        return 0;

    // Skip leading delimiters
    char *s = last;
    while (*s && strchr(delim, *s))
        s++;
    if (!*s) {
        last = 0;
        return 0;
    }

    char *tok = s;
    // Find end of token
    while (*s && !strchr(delim, *s))
        s++;
    if (*s) {
        *s = 0;
        last = s + 1;
    } else {
        last = 0;
    }
    return tok;
}

void
strcat(char *dest, const char *src)
{
  while (*dest) dest++;
  while ((*dest++ = *src++));
}

char*
strcpy(char *s, char *t)
{
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    ;
  return os;
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    p++, q++;
  return (uchar)*p - (uchar)*q;
}

int
strncmp(const char *p, const char *q, int size)
{
  while(*p && *p == *q)
    p++, q++;
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
    ;
  return n;
}

void*
memset(void *dst, int c, uint n)
{
  stosb(dst, c, n);
  return dst;
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
}

int 
getc(int fd)
{
  char c;
  if(read(fd, &c, 1) <= 0) return -1;  // EOF/error
  return (unsigned char)c;
}

char*
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
  return buf;
}

int
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
  close(fd);
  return r;
}

int
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
  return vdst;
}
