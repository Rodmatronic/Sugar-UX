#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"

int
main(int argc, char *argv[])
{
  int i;
  struct stat st;

  if(argc < 2){
    printf("Usage: rmdir directory...\n");
    exit(EXIT_FAILURE);
  }

  for(i = 1; i < argc; i++){
    if(stat(argv[i], &st) < 0){
      printf("rmdir: cannot access '%s': No such file or directory\n", argv[i]);
      continue;
    }

    // Check if it's a directory
    if((st.type & T_DIR) == 0){
      printf("rmdir: failed to remove '%s': Not a directory\n", argv[i]);
      continue;
    }

    if(unlink(argv[i]) < 0){
      printf("rmdir: failed to remove '%s'\n", argv[i]);
      continue;
    }
  }

  exit(EXIT_SUCCESS);
}
