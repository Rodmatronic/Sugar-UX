#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"

char buf[512];

void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
    if (write(1, buf, n) != n) {
      printf("cat: write error\n");
      exit(EXIT_FAILURE);
    }
  }
  if(n < 0){
    printf("cat: read error\n");
    exit(EXIT_FAILURE);
  }
}

int
main(int argc, char *argv[])
{
  int fd, i;
  struct stat st;

  if(argc <= 1){
    cat(0);
    exit(EXIT_SUCCESS);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf("cat: cannot open %s\n", argv[i]);
      exit(EXIT_FAILURE);
    }

    if(fstat(fd, &st) < 0){
      printf("cat: cannot stat %s\n", argv[i]);
      close(fd);
      exit(EXIT_FAILURE);
    }

    if(st.type == T_DIR){
      printf("cat: %s is a directory\n", argv[i]);
      close(fd);
      exit(EXIT_FAILURE);
    }

    cat(fd);
    close(fd);
  }
  exit(EXIT_SUCCESS);
}
