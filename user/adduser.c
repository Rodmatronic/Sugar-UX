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
        fprintf(2, "adduser: must be run as root\n");
        exit(EXIT_FAILURE);
    }

    char username[50], fullname[50], password[50], confirm[50];
    char old_content[MAX_FILE];
    int content_len = 0;
    int new_uid = 0;

    username:;

    printf("Username: ");
    gets(username, sizeof(username));
    username[strlen(username)-1] = 0;

    if (strlen(username) == 0) {
        fprintf(2, "adduser: ERROR: You must enter a username!\n");
        goto username;
    }

    // Read existing passwd content
    int fd = open("/etc/passwd", O_RDONLY);
    if (fd >= 0) {
        content_len = read(fd, old_content, sizeof(old_content)-1);
        if (content_len < 0) content_len = 0;
        old_content[content_len] = 0;
        close(fd);
    }

    // Process existing entries
    char *line = old_content;
    while (line < old_content + content_len) {
        char *end = strchr(line, '\n');
        if (!end) end = old_content + content_len;
        
        int line_len = end - line;
        // Check line length to prevent overflow
        if (line_len >= MAX_LINE) {
            fprintf(2, "adduser: line too long in /etc/passwd\n");
            exit(EXIT_FAILURE);
        }

        char line_copy[MAX_LINE];
        memmove(line_copy, line, line_len);
        line_copy[line_len] = 0;
    
        // Parse the COPY instead of original buffer
        char *fields[7];
        char *p = line_copy;
        for (int i = 0; i < 7; i++) {
            fields[i] = p;
            while (*p && *p != ':' && p < line_copy + line_len) p++;
            if (*p == ':') *p++ = 0; // Only modify the copy
        }
    
        if (strcmp(fields[0], username) == 0) {
            fprintf(2, "adduser: ERROR: User '%s' exists!\n", username);
            goto username;
        }
        
        int uid = atoi(fields[2]);  
        new_uid = uid + 1;      
        line = end + 1;
    }

    printf("Full name: ");
    gets(fullname, sizeof(fullname));
    fullname[strlen(fullname)-1] = 0;

    passwd:;
    // Get password with confirmation
    echo(0);
    printf("Enter password: ");
    gets(password, sizeof(password));
    password[strlen(password)-1] = 0;
    printf("\nEnter password again: ");
    gets(confirm, sizeof(confirm));
    confirm[strlen(confirm)-1] = 0;
    echo(1);

    if (strcmp(password, confirm) != 0) {
        fprintf(2, "\nPasswords did not match!\n");
        goto passwd;
    }

    // Create home directory
    char home_dir[MAX_LINE];
    snprintf(home_dir, sizeof(home_dir), "/home/%s", username);
    if (mkdir(home_dir) < 0) {
        fprintf(2, "Failed to create %s\n", home_dir);
        exit(EXIT_FAILURE);
    }

    // Create new passwd entry
    char new_entry[MAX_LINE];
    int entry_len = snprintf(new_entry, sizeof(new_entry),
        "%s:%s:%d:%d:%s:%s:/bin/sh\n",
        username, password, new_uid, new_uid, fullname, home_dir);

    // Write back old content + new entry
    int pw_fd = open("/etc/passwd", O_WRONLY | O_CREAT);
    if (pw_fd < 0) {
        fprintf(2, "Can't write passwd\n");
        exit(EXIT_FAILURE);
    }

    // Write original content
    if (content_len > 0) {
        if (write(pw_fd, old_content, content_len) != content_len) {
            fprintf(2, "Write failed\n");
            close(pw_fd);
            exit(EXIT_FAILURE);
        }
    }

    // Append new entry
    if (write(pw_fd, new_entry, entry_len) != entry_len) {
        fprintf(2, "Write failed\n");
        close(pw_fd);
        exit(EXIT_FAILURE);
    }

    close(pw_fd);
    printf("\nUser %s added successfully!\n", username);
    exit(EXIT_SUCCESS);
}