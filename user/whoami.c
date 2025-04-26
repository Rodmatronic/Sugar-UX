#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"

#define MAX_LINE 256

int main()
{
  int uid = getuid();
  int fd;
  char line[MAX_LINE];
  char *fields[7];
  int found = 0;

  if((fd = open("/etc/passwd", 0)) < 0) {
    fprintf(2, "whoami: cannot access /etc/passwd\n");
    exit(EXIT_FAILURE);
  }

  // Parse passwd file
  int pos = 0;
  char c;
  while(read(fd, &c, 1) == 1) {
    if(c != '\n' && pos < MAX_LINE-1) {
      line[pos++] = c;
    } else {
      line[pos] = '\0';
      pos = 0;
      
      // Split into colon-separated fields
      char *p = line;
      for(int i=0; i<7; i++) {
        fields[i] = p;
        while(*p && *p != ':' && *p != '\n') p++;
        *p++ = '\0';
      }

      // Check UID match
      if(atoi(fields[2]) == uid) {
        printf("%s\n", fields[0]);
        found = 1;
        break;
      }
    }
  }
  close(fd);

  if(!found)
    printf("unknown\n");

  exit(EXIT_SUCCESS);
}