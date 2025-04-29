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
    printf("What manual page do you want?\n");
    exit(1);
  }

  char path[128];
  snprintf(path, sizeof(path), "/usr/share/man/%s.man", argv[1]);

  struct stat st;
  if (stat(path, &st) < 0) {
    printf("No manual entry for %s\n", argv[1]);
    exit(1);
  }

  char *margv[] = { "more", path, 0 };
  exec("/bin/more", margv);
  printf("exec more failed\n");
  exit(1);
}