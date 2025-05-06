#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"

/*
 *
 * TODO: Make this send message to all terminals
 *
 */

int
main(void)
{
  if(getuid()) {
    fprintf(2, "halt: Operation not permitted\n");
    return 1;
  }
  printf("%s halt: Halted by %s\n", getenv("HOSTNAME"), getenv("LOGNAME"));
  halt();
  return 1;
}
