#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"

int
main(int argc, char *argv[])
{
  if(getuid()) {
    printf("reboot: Operation not permitted\n");
    return 1;
  }
  printf("%s reboot: Reboot by %s\n", getenv("LOGNAME"), getenv("LOGNAME"));
  reboot();
  return 0;
}
