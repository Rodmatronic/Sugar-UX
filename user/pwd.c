#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"
#include "../sys/fcntl.h"
#include "../sys/file.h"

char name[512];
int
main()
{
    getcwd(name, sizeof(name));
    printf("%s\n", name);
    return 0;
}
