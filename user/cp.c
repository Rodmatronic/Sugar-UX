#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"
#include "../sys/fcntl.h"

#define BUFFER_SIZE 512

int
copy_file(char *src, char *dst)
{
  int fd_src, fd_dst;
  char buf[BUFFER_SIZE];
  struct stat st;
  int n;
  char fullpath[128];
  char *filename = basename(src);
  int i, j;

  if ((fd_src = open(src, 0)) < 0) {
    fprintf(2, "cp: cannot open '%s'\n", src);
    return -1;
  }

  // Handle . and ./ cases
  if (strcmp(dst, ".") == 0) {
    i = 0;
    fullpath[i++] = '.';
    fullpath[i++] = '/';
    for(j = 0; filename[j]; j++)
      fullpath[i++] = filename[j];
    fullpath[i] = 0;
    dst = fullpath;
  }
  else if (strcmp(dst, "./") == 0) {
    i = 0;
    for(j = 0; dst[j]; j++)
      fullpath[i++] = dst[j];
    for(j = 0; filename[j]; j++)
      fullpath[i++] = filename[j];
    fullpath[i] = 0;
    dst = fullpath;
  }
  // Handle existing directory case
  else if (stat(dst, &st) >= 0 && (st.type & T_DIR)) {
    i = 0;
    for(j = 0; dst[j]; j++)
      fullpath[i++] = dst[j];
    if (fullpath[i-1] != '/')
      fullpath[i++] = '/';
    for(j = 0; filename[j]; j++)
      fullpath[i++] = filename[j];
    fullpath[i] = 0;
    dst = fullpath;
  }

  if ((fd_dst = open(dst, O_CREATE | O_WRONLY)) < 0) {
    fprintf(2, "cp: cannot create '%s'\n", dst);
    close(fd_src);
    return -1;
  }

  while ((n = read(fd_src, buf, BUFFER_SIZE)) > 0) {
    if (write(fd_dst, buf, n) != n) {
      fprintf(2, "cp: write error copying '%s'\n", src);
      close(fd_src);
      close(fd_dst);
      return -1;
    }
  }

  close(fd_src);
  close(fd_dst);
  return 0;
}

int
main(int argc, char *argv[])
{
  struct stat st;

  if (argc != 3) {
    fprintf(2, "Usage: cp source_file destination\n");
    exit(EXIT_FAILURE);
  }

  // Check if source exists
  if (stat(argv[1], &st) < 0) {
    fprintf(2, "cp: cannot stat '%s': No such file or directory\n", argv[1]);
    exit(EXIT_FAILURE);
  }

  // Check if source is a regular file
  if ((st.type & T_FILE) == 0) {
    fprintf(2, "cp: '%s' is not a regular file\n", argv[1]);
    exit(EXIT_FAILURE);
  }

  if (copy_file(argv[1], argv[2]) < 0) {
    exit(EXIT_FAILURE);
  }

  exit(EXIT_SUCCESS);
}