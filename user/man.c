#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"
#include "../sys/fcntl.h"
#include "../sys/date.h"

// Manpage viewer (for TTYs)

int
main(int argc, char *argv[])
{
  if (argc < 2) {
    fprintf(2, "What manual page do you want?\n");
    exit(EXIT_FAILURE);
  }

  char path[128];
  snprintf(path, sizeof(path), "/usr/share/man/%s.man", argv[1]);

  struct stat st;
  if (stat(path, &st) < 0) {
    fprintf(2, "No manual entry for %s\n", argv[1]);
    exit(EXIT_FAILURE);
  }

  char *margv[] = { "more", path, 0 };
  exec("/bin/more", margv);
  printf("exec more failed\n");
  exit(EXIT_SUCCESS);
}