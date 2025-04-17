#include "../sys/user.h"
#include "../sys/types.h"

int 
main() {
  printf("%d\n", getuid());
  exit();
}