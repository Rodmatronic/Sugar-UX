#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"
#include "../sys/fcntl.h"

int main(int argc, char *argv[]) {
    if(argc < 2) {
        printf("Usage: getty /dev/ttyX\n");
        exit(1);
    }

    // Open specified TTY
    int fd = open(argv[1], O_RDWR);
    if(fd < 0) {
        printf("getty: cannot open %s\n", argv[1]);
        exit(1);
    }

    // Set stdio to TTY
    close(0);
    close(1);
    close(2);
    dup(fd);
    dup(fd);
    dup(fd);
    close(fd);

    printf("\nSugar/Unix login (%s)\n(Default user is 'sugar' with blank pass. Root pass is 'root')\n", argv[1]);

    // Execute login
    char *login_argv[] = { "login", 0 };
    exec("/bin/login", login_argv);
    printf("getty: exec failed\n");
    exit(1);
}