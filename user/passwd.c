#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"
#include "../sys/fcntl.h"

#define MAX_LINE 256
#define MAX_FILE 4096

int
main(int argc, char *argv[])
{
    if (getuid() != 0) {
        printf("passwd: Operation not permitted\n");
        exit(EXIT_FAILURE);
    }

    if (argc != 2) {
        printf("Usage: passwd username\n");
        exit(EXIT_FAILURE);
    }

    char *username = argv[1];
    char old_content[MAX_FILE];
    int content_len = 0;

    // Read existing passwd content
    int fd = open("/etc/passwd", O_RDONLY);
    if (fd >= 0) {
        content_len = read(fd, old_content, sizeof(old_content)-1);
        if (content_len < 0) content_len = 0;
        old_content[content_len] = 0;
        close(fd);
    } else {
        fprintf(2, "failed to open /etc/passwd\n");
        exit(EXIT_FAILURE);
    }

    char new_content[MAX_FILE];
    new_content[0] = 0;
    char *current_line = old_content;
    int user_found = 0;

    while (current_line < old_content + content_len) {
        char *end = strchr(current_line, '\n');
        if (!end) end = old_content + content_len;

        char line_copy[MAX_LINE];
        int line_len = end - current_line;
        memmove(line_copy, current_line, line_len);
        line_copy[line_len] = 0;

        // Parse the line into fields
        char *fields[7];
        char *p = line_copy;
        for (int i = 0; i < 7; i++) {
            fields[i] = p;
            while (*p && *p != ':' && p < line_copy + line_len) p++;
            if (*p == ':') *p++ = 0;
        }

        if (strcmp(fields[0], username) == 0) {
            user_found = 1;
            char password[50], confirm[50];

            // Disable echo for password input
            echo(0);
            printf("New password: ");
            gets(password, sizeof(password));
            password[strlen(password)-1] = 0;
            printf("\nRetype new password: ");
            gets(confirm, sizeof(confirm));
            confirm[strlen(confirm)-1] = 0;
            echo(1);

            if (strcmp(password, confirm) != 0) {
                printf("Passwords don't match!\n");
                exit(EXIT_FAILURE);
            }

            // Rebuild the line with new password
            snprintf(line_copy, sizeof(line_copy), "%s:%s:%s:%s:%s:%s:%s",
                fields[0], password, fields[2], fields[3], fields[4], fields[5], fields[6]);
            line_len = strlen(line_copy);
        }

        // Append the processed line to new_content
        strncat(new_content, line_copy, line_len);
        strcat(new_content, "\n");

        current_line = end + 1;
    }

    if (!user_found) {
        printf("passwd: user '%s' does not exist\n", username);
        exit(EXIT_FAILURE);
    }

    // Write the new content back to /etc/passwd
    fd = open("/etc/passwd", O_WRONLY | O_CREAT);
    if (fd < 0) {
        fprintf(2, "failed to open /etc/passwd for writing\n");
        exit(EXIT_FAILURE);
    }

    int new_len = strlen(new_content);
    if (write(fd, new_content, new_len) != new_len) {
        fprintf(2, "failed to write to /etc/passwd\n");
        close(fd);
        exit(EXIT_FAILURE);
    }

    close(fd);
    printf("\npasswd: password updated successfully\n");
    exit(EXIT_SUCCESS);
}