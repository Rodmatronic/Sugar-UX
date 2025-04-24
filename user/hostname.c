#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"
#include "../sys/fcntl.h"

int
main(int argc, char **argv)
{
  struct utsname name;
  if (argc <= 1) {
    if (gethostname(&name) < 0) {
      fprintf(2, "cannot determine hostname\n");
      return 1;
    }
    printf("%s\n", name.nodename);
    return 0;
  } else {
    if(getuid()) {
      printf("hostname: Operation not permitted\n");
      return 1;
    }
    /* Set hostname to operand */
    char *name = argv[1];
    if (sethostname(name, strlen(name)) != 0) {
      fprintf(2, "cannot set name to %s\n", name);
      return 1;
    }
    int fd = open("/etc/hostname", O_RDWR | O_CREATE);
    setenv("HOSTNAME", name, 1);
    write(fd, name, strlen(name));
    close(fd);
  }
  return 0;
}
