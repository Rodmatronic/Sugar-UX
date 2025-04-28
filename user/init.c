#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"
#include "../sys/fcntl.h"
#include "../sys/date.h"
char *argv[] = { "login", 0 };
char *shargv[] = { "sh", 0 };
char *dateargv[] = { "date", "", 0 }; 
char *mvargv[] = { "mv", "/etc/~passwd", "/etc/passwd", 0 }; 

#define stderr 2
#define version "1.00"
#define ttynum  10
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
  int pid = 0, wpid = 0;
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

  int mvpid = fork();
  if (mvpid == 0) {
    exec("/bin/mv", mvargv);
    exit(EXIT_SUCCESS);
  } else if (mvpid > 0) {
    wait();
  } else {
    printf("init: fork failed for mv\n");
  }

  // Create TTY devices
  for(int i=0; i<ttynum; i++) {
    char path[20];
    snprintf(path, sizeof(path), "/dev/tty%d", i);
    mknod(path, 6, i);
  }

  // Open console
  int con = open("/dev/tty0", O_RDWR);
  dup(con);  // stdout
  dup(con);  // stderr

  printf("INIT: version %s booting\n", version);

  char prompt[8];
  printf("'s' for single user mode, any other key to continue\n");
  gets(prompt, sizeof(prompt));
  if (prompt[0] == 's' || prompt[0] == 'S') {
    runlevel = 1;
    printf("Entering runlevel: %d\n", runlevel);
    int shpid = fork();
    if (shpid == 0) {
      exec("/bin/sh", shargv);
      exit(EXIT_SUCCESS);
    } else if (shpid > 0) {
      wait();
    } else {
      printf("init: fork failed for sh!\n");
    }
  }

  // Make device nodes. NOTE: random and urandom are identical.
  mknod("/dev/null", 2, 0);
  mknod("/dev/kmem", 3, 0);
  mknod("/dev/zero", 4, 0);
  mknod("/dev/random", 5, 0);
  mknod("/dev/tty", 6, 255);
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

  char *tty_prefix = "/dev/tty";
  for(int i=0; i<ttynum; i++) { // Make getty processes
      if(fork() == 0) {
          char tty_path[20];
          snprintf(tty_path, sizeof(tty_path), "%s%d", tty_prefix, i);
          char *getty_argv[] = { "getty", tty_path, 0 };
          exec("/sbin/getty", getty_argv);
          printf("init: failed to start getty on %s\n", tty_path);
          exit(1);
      }
  }

  for(;;){
    while((wpid=wait()) >= 0 && wpid != pid)
      printf("zombie!\n");
  }
}
