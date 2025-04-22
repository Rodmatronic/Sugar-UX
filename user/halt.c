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
    printf("halt: Operation not permitted\n");
    return 1;
  }
  char user[128];
  char hostname[128];
  getenv("LOGNAME", user);
  getenv("HOSTNAME", hostname);
  printf("%s halt: Halted by %s\n", hostname, user);
  halt();
  return 0;
}
