#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"

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
      printf("You must be root to set the host name\n");
      return 1;
    }
    /* Set hostname to operand */
    char *name = argv[1];
    if (sethostname(name, strlen(name)) != 0) {
      fprintf(2, "cannot set name to %s\n", name);
      return 1;
    }
  }
  return 0;
}
