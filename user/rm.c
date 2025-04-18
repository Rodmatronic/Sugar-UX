#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"

int
main(int argc, char *argv[])
{
  int i;

  if(argc < 2){
    printf("Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
      printf("%s: No such file or directory\n", argv[i]);
      break;
    }
  }

  exit();
}
