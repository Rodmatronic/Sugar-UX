#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"
#include "../sys/fcntl.h"
#include "../sys/date.h"

int
main(int argc, char *argv[])
{
    if(getuid()) {
        printf("mknod: Operation not permitted\n");
        return 1;
    }
    if (argc < 4) {
        fprintf(2, "Usage: mknod NAME [MAJOR MINOR]\n");
        exit();
    } else {
        char *name = argv[1];
        int major = 0;
        int minor = 0;
        major = atoi(argv[2]);
        minor = atoi(argv[3]);
        mknod(name, major, minor);
    }
    exit();
}