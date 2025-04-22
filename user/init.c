#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"
#include "../sys/fcntl.h"
#include "../sys/date.h"
char *argv[] = { "login", 0 };

#define stderr 2

// Use Zeller's Congruence to get weekday name
char* get_weekday(int y, int m, int d) {
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
char* monthname(int m) {
  static char* months[] = {
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
  };

  if (m < 1 || m > 12)
    return "???";

  return months[m - 1];
}

int
main(void)
{
  int pid, wpid;
  if (getpid() != 1) {
    (void)fprintf(stderr, "init: already running\n");
    exit();
  }

  // No home until LOGIN sets it up
  setenv("HOME", "/");
  // Default PATH
  setenv("PATH", "/bin:/usr/bin:/sbin");
  // PWD initially
  setenv("PWD", "/");
  // vt100 is a safe bet
  setenv("TERM", "vt100");
  setenv("USER", "root");
  setenv("LOGNAME", "root");
  setenv("SHELL", "/bin/sh");

  // boot-time directories
  mkdir("/dev");
  mkdir("/var");

  // /dev/console is essential, do checks
  if(open("/dev/console", O_RDWR) < 0){
    mknod("/dev/console", 1, 1);
    open("/dev/console", O_RDWR);
  }

  // Make device nodes. NOTE: random and urandom are identical.
  mknod("/dev/null", 2, 0);
  mknod("/dev/kmem", 3, 0);
  mknod("/dev/zero", 4, 0);
  mknod("/dev/random", 5, 0);
  link("/dev/random", "/dev/urandom");

  mkdir("/root");

  dup(0);  // stdout
  dup(0);  // stderr
  printf("clearing /tmp\n");
  unlink("/tmp"); mkdir("/tmp");

  // Do we have hostname?
  if(open("/etc/hostname", O_RDWR) < 0){
    char *name = "sugar";
    printf("init: WARNING: hostname not set.\nUsing sane default: %s\n", name);
    sethostname(name, strlen(name));
    setenv("HOSTNAME", name);
  } else {
    char name[64];
    int fd = open("/etc/hostname", O_RDWR);
    if (fd < 0) {
      printf("Failed to open /etc/hostname\n");
      exit();
    }
    read(fd, name, sizeof(name));
    close(fd);
    sethostname(name, strlen(name));
    setenv("HOSTNAME", name);
  }
  struct utsname u;
  if (gethostname(&u) < 0) {
    printf("Failed to get hostname\n");
    exit();
  }

  struct rtcdate r;

  if (gettime(&r) == 0) {
    printf("%02s %02s %02d %02d:%02d:%02d UTC %02d\n",
           get_weekday(r.year, r.month, r.day),
           monthname(r.month),
           r.day,
           r.hour,
           r.minute,
           r.second,
           r.year);
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
