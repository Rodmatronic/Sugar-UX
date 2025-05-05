#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"
#include "../sys/fcntl.h"

#define MAX_LINE 256
#define MAX_FILE 4096

int
main(int argc, char *argv[])
{
    char *target_user;
    int is_self = 0;

    if (argc == 1) {
        // No arguments: change current user's password
        static char user[32];
        if (getenv("USER", user) < 0 || user[0] == 0) {
            fprintf(2, "passwd: cannot determine current user\n");
            exit(EXIT_FAILURE);
        }
        target_user = user;
        is_self = 1;
    } else if (argc == 2) {
        // passwd [username]: must be root
        if (getuid() != 0) {
            printf("passwd: Operation not permitted\n");
            exit(EXIT_FAILURE);
        }
        target_user = argv[1];
    } else {
        fprintf(2, "Usage: passwd [USER]\n");
        exit(EXIT_FAILURE);
    }

    char old_content[MAX_FILE];
    int content_len = 0;

    // Read existing passwd content
    int fd = open("/etc/passwd", O_RDONLY);
    if (fd < 0) {
        fprintf(2, "passwd: cannot open /etc/passwd\n");
        exit(EXIT_FAILURE);
    }

    content_len = read(fd, old_content, sizeof(old_content) - 1);
    close(fd);
    if (content_len < 0) {
        fprintf(2, "passwd: read error\n");
        exit(EXIT_FAILURE);
    }
    old_content[content_len] = '\0';

    char new_content[MAX_FILE];
    int new_len = 0;
    int user_found = 0;

    char *line = old_content;
    while (line < old_content + content_len) {
        char *end = strchr(line, '\n');
        if (!end) end = old_content + content_len;

        int line_len = end - line;
        char line_copy[MAX_LINE];
        memmove(line_copy, line, line_len);
        line_copy[line_len] = '\0';

        // Split line into fields
        char *fields[7];
        char *p = line_copy;
        for (int i = 0; i < 7; ++i) {
            fields[i] = p;
            while (*p && *p != ':') p++;
            if (*p == ':') *p++ = 0;
        }

        if (strcmp(fields[0], target_user) == 0) {
            user_found = 1;
            char password[50], confirm[50];

            passwd:;

            // Disable echo for password input
            echo(0);
            printf("New password: ");
            gets(password, sizeof(password));
            password[strlen(password)-1] = 0;
            printf("\nRetype new password: ");
            gets(confirm, sizeof(confirm));
            confirm[strlen(confirm)-1] = 0;
            echo(1);
            printf("\n");

            if (strcmp(password, confirm) != 0) {
                fprintf(2, "Passwords don't match!\n");
                goto passwd;
            }

            // Rebuild the line with new password
            char new_line[MAX_LINE];
            int n = snprintf(new_line, sizeof(new_line), "%s:%s:%s:%s:%s:%s:%s\n",
                             fields[0], password, fields[2], fields[3],
                             fields[4], fields[5], fields[6]);
            if (n >= sizeof(new_line)) {
                fprintf(2, "passwd: line too long\n");
                exit(EXIT_FAILURE);
            }

            // Append to new_content
            if (new_len + n > MAX_FILE) {
                fprintf(2, "passwd: file too large\n");
                exit(EXIT_FAILURE);
            }
            memmove(new_content + new_len, new_line, n);
            new_len += n;
        } else {
            // Copy original line to new_content with newline
            if (new_len + line_len + 1 > MAX_FILE) {
                fprintf(2, "passwd: file too large\n");
                exit(EXIT_FAILURE);
            }
            memmove(new_content + new_len, line, line_len);
            new_len += line_len;
            new_content[new_len++] = '\n';
        }

        line = end + 1; // Move to next line
    }

    if (!user_found) {
        fprintf(2, "passwd: user '%s' does not exist\n", target_user);
        exit(EXIT_FAILURE);
    }

    // Write new_content back to /etc/passwd
    fd = open("/etc/passwd", O_WRONLY);
    if (fd < 0) {
        fprintf(2, "passwd: failed to open passwd for writing\n");
        exit(EXIT_FAILURE);
    }

    if (write(fd, new_content, new_len) != new_len) {
        fprintf(2, "passwd: write error\n");
        close(fd);
        exit(EXIT_FAILURE);
    }

    close(fd);
    exit(EXIT_SUCCESS);
}