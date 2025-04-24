#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"
#include "../sys/fs.h"
#include "../sys/fcntl.h"

// Recursively delete directory contents
void
rmrf(char *path)
{
    int fd;
    struct dirent de;
    struct stat st;

    // Check if path exists
    if (stat(path, &st) < 0) {
        printf("rm: cannot access '%s'\n", path);
        return;
    }

    // If not a directory, just unlink
    if (st.type != T_DIR) {
        if (unlink(path) < 0)
            printf("rm: failed to delete '%s'\n", path);
        return;
    }

    // Open directory
    if ((fd = open(path, O_RDONLY)) < 0) {
        printf("rm: cannot open '%s'\n", path);
        return;
    }

    // Delete directory contents
    while (read(fd, &de, sizeof(de)) == sizeof(de)) {
        if (de.inum == 0) continue;  // Skip empty entries
        if (strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0) continue;

        // Build subpath (e.g., "dir/file.txt")
        char subpath[512];
        strcpy(subpath, path);
        strcat(subpath, "/");
        strcat(subpath, de.name);

        // Recursive delete
        rmrf(subpath);
    }

    close(fd);

    // Remove empty directory
    if (unlink(path) < 0)
        printf("rm: failed to remove '%s'\n", path);
}

int
main(int argc, char *argv[])
{
    int i, recursive = 0;

    // Parse -r flag
    if (argc >= 2 && strcmp(argv[1], "-r") == 0) {
        recursive = 1;
        i = 2;  // Skip "-r" argument
        if (i >= argc) {
            printf("rm: missing operand after '-r'\n");
            exit();
        }
    } else {
        i = 1;
    }

    if (i >= argc) {
        printf("Usage: rm [-r] files...\n");
        exit();
    }

    // Process each file/directory
    for (; i < argc; i++) {
        struct stat st;
        char *name = argv[i];

        if (stat(name, &st) < 0) {
            printf("rm: cannot access '%s'\n", name);
            continue;
        }

        if (st.type == T_DIR && !recursive) {
            printf("rm: cannot remove '%s': Is a directory\n", name);
            continue;
        }

        if (st.type == T_DIR) {
            rmrf(name);  // Recursive delete
        } else {
            if (unlink(name) < 0)
                printf("rm: failed to delete '%s'\n", name);
        }
    }

  exit();
}