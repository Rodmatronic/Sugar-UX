#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"

int
main(int argc, char **argv)
{
  int i;

  if(argc < 2){
    printf("Usage: kill pid...\n");
    exit(EXIT_FAILURE);
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  exit(EXIT_SUCCESS);
}
