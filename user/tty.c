#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"

int main() {
    char tty[128];
    ttyname(0, tty, 256);  // Get TTY name
    printf("%s\n", tty);
    exit(EXIT_SUCCESS);
}
