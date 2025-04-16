
#include "types.h"
#include "user.h"
#include "fcntl.h"

#define LINES_PER_PAGE 24

void wait_prompt() {
  write(1, "--More--", 8);
  char c;
  if (read(0, &c, 1) < 1)
    exit(); // quit if can't read input
  write(1, "\n", 1);
  if (c == 'q') exit();
}

void more(int fd) {
  char ch;
  int lines = 0;

  while (read(fd, &ch, 1) == 1) {
    write(1, &ch, 1);
    if (ch == '\n') {
      lines++;
      if (lines >= LINES_PER_PAGE) {
        wait_prompt();
        lines = 0;
      }
    }
  }
  exit();
}

int main(int argc, char *argv[]) {
  if (argc <= 1) {
    more(0); // stdin
  } else {
    int fd = open(argv[1], 0);
    if (fd < 0) {
      write(2, "Cannot open file\n", 17);
      exit();
    }
    more(fd);
    close(fd);
  }
  exit();
}

