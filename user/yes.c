#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"

int
main(int argc, char **argv)
{
        for (;;)
                printf("%s\n", argc>1? argv[1]: "y");
}

