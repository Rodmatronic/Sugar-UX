#include "syscall.h"
#include "traps.h"

#define SYSCALL(name) \
  .globl name; \
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
SYSCALL(exit)
SYSCALL(wait)
SYSCALL(pipe)
SYSCALL(read)
SYSCALL(write)
SYSCALL(close)
SYSCALL(kill)
SYSCALL(exec)
SYSCALL(open)
SYSCALL(mknod)
SYSCALL(unlink)
SYSCALL(fstat)
SYSCALL(link)
SYSCALL(mkdir)
SYSCALL(chdir)
SYSCALL(dup)
SYSCALL(getpid)
SYSCALL(sbrk)
SYSCALL(sleep)
SYSCALL(uptime)
SYSCALL(bstat)
SYSCALL(swap)
SYSCALL(gettime)
SYSCALL(setcursor)
SYSCALL(uname)
SYSCALL(echo)
SYSCALL(getuid)
SYSCALL(setuid)
SYSCALL(gethostname)
SYSCALL(sethostname)
SYSCALL(clear)
SYSCALL(setenv)
SYSCALL(sys_getenv)
SYSCALL(listenv)
SYSCALL(halt)
SYSCALL(reboot)
SYSCALL(ttyname)
SYSCALL(getcwd)
SYSCALL(usleep)