#include "../sys/types.h"
#include "../sys/user.h"
#include "../sys/fcntl.h"

#define LINES_TO_PRINT 10

void
head(int fd)
{
  char ch;
  int lines = 0;

  while (read(fd, &ch, 1) == 1) {
    write(1, &ch, 1);
    if (ch == '\n') {
      lines++;
      if (lines >= LINES_TO_PRINT)
        break;
    }
  }
  exit(EXIT_SUCCESS);
}

int
main(int argc, char *argv[])
{
  if (argc <= 1) {
    head(0); // Read from stdin
  } else {
    int fd = open(argv[1], O_RDONLY);
    if (fd < 0) {
      write(2, "Cannot open file\n", 17);
      exit(EXIT_FAILURE);
    }
    head(fd);
    close(fd);
  }
  exit(EXIT_SUCCESS);
}