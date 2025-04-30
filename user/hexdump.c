// hexdump - modified from catk coreutils
// Written by Rodmatronics

#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"
#include "../sys/fcntl.h"
#include "../sys/file.h"

void
hexdump(int fd)
{
    unsigned char buffer[16];
    int bytes_read = 0;
    uint offset = 0;

    while ((bytes_read = read(fd, buffer, sizeof(buffer))) > 0) {
        // Print the offset
        printf("%08x  ", offset);

        // Print the hex values grouped as 4 bytes per number
        for (int i = 0; i < bytes_read; i += 4) {
            if (i + 3 < bytes_read) {
                // Print 4 bytes as a single 32-bit number
                printf("%02x%02x %02x%02x ", buffer[i + 1], buffer[i], buffer[i + 3], buffer[i + 2]);
            } else {
                for (int j = i; j < bytes_read; j++) {
                    printf("%02x", buffer[j]);
                }
                for (int j = bytes_read; j < i + 4; j++) {
                    printf("  "); // Add padding for missing bytes
                }
                printf(" ");
            }
        }

        // Add spacing for incomplete lines
        if (bytes_read < sizeof(buffer)) {
            for (int i = bytes_read; i < sizeof(buffer); i += 4) {
                printf("         ");
            }
        }
        printf("\n");

        offset += bytes_read;
    }
}

int
main(int argc, char *argv[])
{
    int fd;
    if (argc != 2) {
        printf("Usage: %s file\n", argv[0]);
        return -1;
    }

    fd = open(argv[1], O_RDONLY);
    if (fd < 0) {
        printf("hexdump: no such file or directory");
        return -1;
    }

    hexdump(fd);
    close(fd);

    return 0;
}