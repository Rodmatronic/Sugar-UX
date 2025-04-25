#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"

int
main(int argc, char *argv[])
{
  if(argc != 3){
    printf("usage: ln old new\n");
    exit(EXIT_FAILURE);
  }
  if(link(argv[1], argv[2]) < 0)
    printf("link %s %s: failed\n", argv[1], argv[2]);
  exit(EXIT_SUCCESS);
}
