#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

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
  safestrcpy(u->sysname, "Sugar/Unix", sizeof(u->sysname));
  safestrcpy(u->nodename, "localhost", sizeof(u->nodename)); // TODO: Make this use hostname.
  safestrcpy(u->release, "0.12-RELEASE", sizeof(u->release));
  safestrcpy(u->version, "Sugar/Unix (Codename ALFA)", sizeof(u->version));
  safestrcpy(u->machine, "i386", sizeof(u->machine));

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
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
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
