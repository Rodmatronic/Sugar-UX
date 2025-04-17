#include "types.h"
#include "stat.h"
#include "fcntl.h"
#include "date.h"
#include "syscall.h"
#include "defs.h"

int
sys_gettime(void)
{
  struct rtcdate *r;

  if(argptr(0, (char**)&r, sizeof(*r)) < 0)
    return -1;

  cmostime(r);
  return 0;
}
