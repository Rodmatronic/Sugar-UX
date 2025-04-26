#ifndef PROC_H
#define PROC_H

#include "spinlock.h"

// Per-CPU state
struct cpu {
  uchar apicid;                // Local APIC ID
  struct context *scheduler;   // swtch() here to enter scheduler
  struct taskstate ts;         // Used by x86 to find stack for interrupt
  struct segdesc gdt[NSEGS];   // x86 global descriptor table
  volatile uint started;       // Has the CPU started?
  int ncli;                    // Depth of pushcli nesting.
  int intena;                  // Were interrupts enabled before pushcli?
  struct proc *proc;           // The process running on this cpu or null
};

extern struct cpu cpus[NCPU];
extern int ncpu;

//PAGEBREAK: 17
// Saved registers for kernel context switches.
// Don't need to save all the segment registers (%cs, etc),
// because they are constant across kernel contexts.
// Don't need to save %eax, %ecx, %edx, because the
// x86 convention is that the caller has saved them.
// Contexts are stored at the bottom of the stack they
// describe; the stack pointer is the address of the context.
// The layout of the context matches the layout of the stack in swtch.S
// at the "Switch stacks" comment. Switch doesn't save eip explicitly,
// but it is on the stack and allocproc() manipulates it.
struct context {
  uint edi;
  uint esi;
  uint ebx;
  uint ebp;
  uint eip;
};

enum procstate { UNUSED, EMBRYO, SLEEPING, RUNNABLE, RUNNING, ZOMBIE };

#define MAX_ENV_VARS 128
#define MAX_ENV_NAME 32
#define MAX_ENV_VALUE 128

struct env_var {
  char name[MAX_ENV_NAME];
  char value[MAX_ENV_VALUE];
};

// Per-process state
struct proc {
  int uid;                     // User ID
  uint sz;                     // Size of process memory (bytes)
  pde_t* pgdir;                // Page table
  char *kstack;                // Bottom of kernel stack for this process
  enum procstate state;        // Process state
  int pid;                     // Process ID
  struct proc *parent;         // Parent process
  struct trapframe *tf;        // Trap frame for current syscall
  struct context *context;     // swtch() here to run process
  void *chan;                  // If non-zero, sleeping on chan
  int killed;                  // If non-zero, have been killed
  struct file *ofile[NOFILE];  // Open files
  struct inode *cwd;           // Current directory
  char name[16];               // Process name (debugging)
  struct env_var env[MAX_ENV_VARS];  // Environment variables
  int env_count;               // Number of environment variables
  int exit_status;             // Exit status for wait()
  int tty;                     // TTY number for this process
};

#define INPUT_BUF 128
struct input {
  char buf[INPUT_BUF];
  uint r;  // Read index
  uint w;  // Write index
  uint e;  // Edit index
};

#define C(x)  ((x)-'@')  // Control-x

#define NTERMINALS 13

struct terminal {
  struct spinlock input_lock;
  struct {
    char buf[INPUT_BUF];
    uint r;
    uint w;
    uint e;
  } input;
  ushort crt_buffer[80*25];
  int cursor_pos;
  int echo;
  int color;
};

static struct terminal terminals[NTERMINALS];
static int active_terminal = 0;

struct ptable {
  struct spinlock lock;
  struct proc proc[NPROC];
};

extern struct ptable ptable; // Declared ptable as an extern variable of this type to avoid proc.c conflict

void console_echo(int enable);
int sys_uptime(void);

// Process memory is laid out contiguously, low addresses first:
//   text
//   original data and bss
//   fixed-size stack
//   expandable heap

#endif