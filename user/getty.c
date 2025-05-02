#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"
#include "../sys/fcntl.h"

int main(int argc, char *argv[]) {
    if(argc < 2) {
        fprintf(2, "Usage: getty /dev/ttyX\n");
        exit(EXIT_FAILURE);
    }

    // Open specified TTY
    int fd = open(argv[1], O_RDWR);
    if(fd < 0) {
        fprintf(2, "getty: cannot open %s\n", argv[1]);
        exit(EXIT_FAILURE);
    }

    // Set stdio to TTY
    close(0);
    close(1);
    close(2);
    dup(fd);
    dup(fd);
    dup(fd);
    close(fd);

    // Execute login
    char *login_argv[] = { "login", 0 };
    exec("/usr/bin/login", login_argv);
    printf("getty: exec failed\n");
    exit(EXIT_FAILURE);
}