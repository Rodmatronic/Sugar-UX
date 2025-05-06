#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"
#include "../sys/fcntl.h"
#include "../sys/date.h"

#define MAX_PATH_LEN 512
#define MAX_ENV_VALUE 128

int
main(int argc, char *argv[])
{
    if (argc != 2) {
        fprintf(2, "Usage: whereis program\n");
        exit(EXIT_FAILURE);
    }

    char *command = argv[1];
    char * path_env = getenv("PATH");
    char path[MAX_PATH_LEN];
    char buf[MAX_PATH_LEN];
    int found = 0;

    // Check if command contains a '/'
    if (strchr(command, '/') != 0) {
        int fd = open(command, O_RDONLY);
        if (fd >= 0) {
            printf("%s\n", command);
            close(fd);
            found = 1;
        }
    } else {
        // Retrieve PATH environment variable
        if (path_env < 0) {
            fprintf(2, "whereis: PATH not set\n");
            exit(EXIT_FAILURE);
        }

        char *p = path_env;
        while (*p) {
            char *q = strchr(p, ':');
            if (!q) q = p + strlen(p);

            int len = q - p;
            if (len >= MAX_PATH_LEN) {
                p = q + (*q == ':' ? 1 : 0);
                continue;
            }

            memmove(buf, p, len);
            buf[len] = '\0';
            // Handle empty path as current directory
            if (len == 0) {
                strcpy(buf, ".");
            }

            p = q;
            if (*p == ':') p++;

            // Build full path
            if (strlen(buf) + strlen(command) + 2 > MAX_PATH_LEN) {
                continue;  // Skip if too long
            }
            strcpy(path, buf);
            strcat(path, "/");
            strcat(path, command);

            // Check if the file exists
            int fd = open(path, O_RDONLY);
            if (fd >= 0) {
                printf("%s\n", path);
                close(fd);
                found = 1;
            }
        }
    }

    if (!found) {
        exit(EXIT_FAILURE);
    }

    exit(EXIT_SUCCESS);
}