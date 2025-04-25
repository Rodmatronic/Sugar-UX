#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"

#define MAX_LINE 256


/*
 *
 *
 * TODO!!: Crypt
 *
 * 
 */


int main() {
  char * user = "root";
  char pass[50], line[256];
  int fd;

  printf("Password: ");
  echo(0);
  gets(pass, sizeof(pass));
  pass[strlen(pass)-1] = 0;
  echo(1);
  printf("\n");

  // Check /etc/passwd
  if ((fd = open("/etc/passwd", 0)) < 0) {
    fprintf(2, "su: no passwd file\n");
    exit(EXIT_FAILURE);
  }

  int match = 0;
  char *fields[7];
  char c;
  int pos = 0;
  while (read(fd, &c, 1) == 1) {
      // Accumulate characters until newline or buffer full
      if (c != '\n' && pos < MAX_LINE - 1) {
          line[pos++] = c;
      } else {
          line[pos] = 0;  // Null-terminate the line
          pos = 0;
  
          // Split line into colon-separated fields
          char *p = line;
          for (int i = 0; i < 7; i++) {
              fields[i] = p;
              while (*p && *p != ':' && *p != '\n') p++;
              *p++ = 0;  // Terminate field
          }
  
          // Check username and password (fields 0 and 1)
          if (strcmp(fields[0], user) == 0 && strcmp(fields[1], pass) == 0) {
              match = 1;
              break;
          }
      }
  }

  if (match) {
    setenv("HOME", fields[5], 1);
    int uid = atoi(fields[2]);
    if (setuid(uid) < 0) {
      //fprintf(2, "su: permission denied\n");
      //exit();
    }
    char *argv[] = { "sh", 0 };
    exec("/bin/sh", argv);
    fprintf(2, "su: exec failed\n");
  } else {
    fprintf(2, "su: sorry\n");
  }

  exit(EXIT_SUCCESS);
}