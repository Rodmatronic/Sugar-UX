#ifndef USER_H
#define USER_H

struct stat;
struct rtcdate;

#include "types.h"
#define EXIT_SUCCESS 0
#define EXIT_FAILURE 1

// system calls
int  fork(void);
int  exit(int __status) __attribute__((noreturn));
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
int     strncmp(const char *p, const char *q, int size);
void	printf(char*, ...);
void	fprintf(int fd, char*, ...);
char*	gets(char*, int max);
int     getc(int fd);
uint	strlen(char*);
void*	memset(void*, int, uint);
void*	malloc(uint);
void	free(void*);
int	    atoi(const char*);
char*   strtok(char *str, const char *delim);
int     strcspn(const char *s, const char *reject);
int     strspn(const char *s, const char *accept);
int     snprintf(char *buf, int size, const char *fmt, ...);
char*   strdup(const char *s);
int     isdigit(int c);
long    strtol(const char *nptr, char **endptr, int base);
char*   strncat(char*, const char*, int);

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
int     setenv(const char *name, const char *value, int);
int     getenv(const char *name, char *value);
int     listenv(char *buf, int buflen);
int     halt(void);
int     reboot(void);
void    strcat(char *dest, const char *src);
int     ttyname(int fd, char *buf, int buflen);

#endif