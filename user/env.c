#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"
#include "../sys/fcntl.h"
#include "../sys/date.h"

int
main(int argc, char *argv[])
{
    if (argc == 1) {
        char buf[1024];
        if (listenv(buf, sizeof(buf)) == 0)
            printf("%s", buf);
        exit();
    }
    if (argc == 2) {
        // Parse NAME=VALUE
        char *eq = 0;
        for (char *p = argv[1]; *p; p++) {
            if (*p == '=') {
                eq = p;
                break;
            }
        }
        if (eq) {
            *eq = 0; // Split into two strings
            char *name = argv[1];
            char *value = eq + 1;
            setenv(name, value, 1);
            char buf[1024];
            if (listenv(buf, sizeof(buf)) == 0)
                printf("%s", buf);
            exit();
        }
    }
    printf("Usage: env [NAME=VALUE]\n");
    exit();
}