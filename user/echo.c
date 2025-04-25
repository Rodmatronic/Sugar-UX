#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"

int
main(int argc, char *argv[])
{
  int i = 1;
  int nflag = 0;

  if(argc < 2){
    printf("\n");
    exit(EXIT_SUCCESS);
  }

  if(argc > 1 && strcmp(argv[1], "-n") == 0){
    nflag = 1;
    i = 2;
  }

  for(; i < argc; i++)
    printf("%s%s", argv[i], i+1 < argc ? " " : (nflag ? "" : "\n"));
  if(nflag)
    printf(""); // No newline
  exit(EXIT_SUCCESS);
}