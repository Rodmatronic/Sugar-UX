#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"

int
main (int argc, char **argv)
{
  struct utsname name;
  if (argc <= 1) {
    gethostname(&name);
    if (name.nodename == NULL) {
      fprintf(2, "cannot determine hostname");
    }
    printf("%s\n", name.nodename);
    return 1;
  } else {
    if(getuid())
    {
      printf("You must be root to set the host name\n");
      return -1;
    }
    /* Set hostname to operand.  */
    char const *name = argv[1];
    if (sethostname (name, strlen (name)) != 0)
      fprintf(2, "cannot set name to %s");
    }

  return 1;
}
