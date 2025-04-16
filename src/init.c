#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
#include "date.h"
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

  mkdir("/dev");
  mkdir("/var");

  if(open("/dev/console", O_RDWR) < 0){
    mknod("/dev/console", 1, 1);
    open("/dev/console", O_RDWR);
  }

  mknod("/dev/null", 2, 0);
  mknod("/dev/kmem", 3, 0);
  mknod("/dev/zero", 4, 0);

  mkdir("/root");
  mkdir("/etc");

  dup(0);  // stdout
  dup(0);  // stderr
  printf("clearing /tmp\n");
  unlink("/tmp"); mkdir("/tmp");


  /*
   *
   * TODO: Don't let me work on this at 3 in the morning
   *
   * real TODO: Just make mkfs handle this...
   *
   */


  int fd;
  fd = open("/etc/issue", O_WRONLY | O_CREATE);
  if (fd < 0) {
    printf("Failed to create file\n");
  }
  char *issue = "Sugar/Unix 0.11 (Codename ALFA)\n";
  write(fd, issue, 34);

  fd = open("/etc/passwd", O_WRONLY | O_CREATE);
  if (fd < 0) {
    printf("Failed to create file\n");
  }
  char *passwd = "root::0:0:Super User:/:/bin/sh\n";
  write(fd, passwd, 40);

  fd = open("/etc/motd", O_WRONLY | O_CREATE);
  if (fd < 0) {
    printf("Failed to create file\n");
  }
  char *entry = "\nWelcome to Sugar/Unix!\n";
  write(fd, entry, 24);

  close(fd);

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
  printf("\nSugar/Unix login\n\n");

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
