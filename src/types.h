#ifndef TYPES_H
#define TYPES_H

typedef unsigned int   uint;
typedef unsigned short ushort;
typedef unsigned char  uchar;
typedef uint pde_t;

struct utsname {
  char sysname[65];
  char nodename[65];
  char release[65];
  char version[65];
  char machine[65];
};

#define EOF (-1)
#define NULL ((void*)0)
//#define stderr 2

#endif
