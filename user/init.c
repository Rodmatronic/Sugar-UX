#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"
#include "../sys/fcntl.h"
#include "../sys/date.h"
char *argv[] = { "login", 0 };
char *dateargv[] = { "date", "", 0 }; 
#define stderr 2
#define version "1.00"

/*
 * 0 = Powering off
 * 1 = Single user
 * 2 = Multi user
 * 3 = Multi user with networking
 * 4 - Not used
 * 5 = Not used
 * 6 = Reboot
  */
int runlevel = 3;

int
main(void)
{
  int pid, wpid;
  if (getpid() != 1) {
    (void)fprintf(stderr, "init: already running\n");
    exit(0);
  }

  // No home until LOGIN sets it up
  setenv("HOME", "/", 1);
  // Default PATH
  setenv("PATH", "/bin:/usr/bin:/sbin", 1);
  // PWD initially
  setenv("PWD", "/", 1);
  // vt100 is a safe bet
  setenv("TERM", "vt100", 1);
  setenv("USER", "root", 1);
  setenv("LOGNAME", "root", 1);
  setenv("SHELL", "/bin/sh", 1);

  // boot-time directories
  mkdir("/dev");
  mkdir("/var");

  // /dev/console is essential, do checks
  if(open("/dev/console", O_RDWR) < 0){
    mknod("/dev/console", 1, 1);
    open("/dev/console", O_RDWR);
  }
  dup(0);  // stdout
  dup(0);  // stderr

  printf("INIT: version %s booting\n", version);

  // Make device nodes. NOTE: random and urandom are identical.
  mknod("/dev/null", 2, 0);
  mknod("/dev/kmem", 3, 0);
  mknod("/dev/zero", 4, 0);
  mknod("/dev/random", 5, 0);
  link("/dev/random", "/dev/urandom");

  mkdir("/root");
  printf("clearing /tmp\n");
  unlink("/tmp"); mkdir("/tmp");

  // Do we have hostname?
  if(open("/etc/hostname", O_RDWR) < 0){
    char *name = "sugar";
    printf("init: WARNING: hostname not set.\nUsing sane default: %s\n", name);
    sethostname(name, strlen(name));
    setenv("HOSTNAME", name, 1);
  } else {
    char name[64];
    int fd = open("/etc/hostname", O_RDWR);
    if (fd < 0) {
      printf("Failed to open /etc/hostname\n");
      exit(EXIT_FAILURE);
    }
    read(fd, name, sizeof(name));
    close(fd);
    sethostname(name, strlen(name));
    setenv("HOSTNAME", name, 1);
  }
  struct utsname u;
  if (gethostname(&u) < 0) {
    printf("Failed to get hostname\n");
    exit(EXIT_FAILURE);
  }

  // Fully booted
  runlevel = 3;
  printf("Entering runlevel: %d\n", runlevel);

  int datepid = fork();
  if (datepid == 0) {
    exec("/bin/date", dateargv);
    exit(EXIT_SUCCESS);
  } else if (datepid > 0) {
    wait();
  } else {
    printf("init: fork failed for date\n");
  }

  printf("\nSugar/Unix login\n(Default user is 'sugar' with blank pass. Root pass is 'root')\n");

  for(;;){
    pid = fork();
    if(pid < 0){
      printf("init: fork failed\n");
    }
    if(pid == 0){
      exec("/bin/login", argv);
      printf("init: exec login failed\n");
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf("zombie!\n");
  }
}
