#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"

int
main(int argc, char **argv)
{
        register char *p1, *p2, *p3;

        if (argc < 2) {
                printf("\n");
                exit(EXIT_SUCCESS);
        }
        p1 = argv[1];
        p2 = p1;
        while (*p1) {
                if (*p1++ == '/')
                        p2 = p1;
        }
        if (argc>2) {
                for(p3=argv[2]; *p3; p3++)
                        ;
                while(p1>p2 && p3>argv[2])
                        if(*--p3 != *--p1)
                                goto output;
                *p1 = '\0';
        }
output:
        printf("%s", p2);
        write(1, "\n", 1);
        exit(EXIT_SUCCESS);
}

