#ifndef USER_H
#define USER_H

struct stat;
struct rtcdate;

#include "types.h"

// system calls
int  fork(void);
int  exit(void) __attribute__((noreturn));
int  wait(void);
int  pipe(int*);
int  write(int, void*, int);
int  read(int, void*, int);
int  close(int);
int  kill(int);
int  exec(char*, char**);
int  open(char*, int);
int  mknod(char*, short, short);
int  unlink(char*);
int  fstat(int fd, struct stat*);
int  link(char*, char*);
int  mkdir(char*);
int  chdir(char*);
int  dup(int);
int  getpid(void);
char* sbrk(int);
int  sleep(int);
int  uptime(void);
int  bstat(void);
int  swap(void*);

// ulib.c
int	    stat(char*, struct stat*);
char*	strcpy(char*, char*);
void*	memmove(void*, void*, int);
char*	strchr(const char*, char c);
int	    strcmp(const char*, const char*);
void	printf(char*, ...);
void	fprintf(int fd, char*, ...);
char*	gets(char*, int max);
uint	strlen(char*);
void*	memset(void*, int, uint);
void*	malloc(uint);
void	free(void*);
int	    atoi(const char*);

int	    gettime(struct rtcdate*);
void	setcursor(void);
int	    uname(struct utsname *);
void	strncpy(char *dest, const char *src, int n);
int	    echo(int enable);
int     getuid(void);
int     setuid(int);
int     gethostname(struct utsname *);
int     sethostname(const char*, int);
int     clear(void);

#endif