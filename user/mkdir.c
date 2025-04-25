#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"

int
main(int argc, char *argv[])
{
  int i;

  if(argc < 2){
    printf("Usage: mkdir files...\n");
    exit(EXIT_FAILURE);
  }

  for(i = 1; i < argc; i++){
    if (argv[i] >= 14) {
      fprintf(2, "mkdir: %s: File name too long\n", argv[i]);
    }
    if(mkdir(argv[i]) < 0){
      printf("mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit(EXIT_SUCCESS);
}
