#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"
#include "../sys/fcntl.h"
#include "../sys/file.h"

char dot[] = ".";
char dotdot[] = "..";
char root[] = "/";
char name[512];
int file, off = -1;
struct stat x;
struct entry { 
  ushort jnum;    // Corrected to match xv6's dirent
  char name[14];  // 14-byte name
} y;

void ckroot();
void prname();
void cat();

void ckroot() {
    int n;
    if ((n = stat(y.name, &x)) < 0) prname();
    if ((n = chdir(root)) < 0) prname();
    write(1, root, 1);
    prname();
}

void prname() {
    if (off < 0) off = 0;
    name[off] = '\n';
    write(1, name, off + 1);
    exit();
}

void cat() {
    int i = 0;
    while (y.name[i] != 0 && i < sizeof(y.name)) i++;
    if (off + i + 1 >= sizeof(name)) prname();
    for (int j = off; j >= 0; j--)
        name[j + i + 1] = name[j];
    off += i + 1;
    for (int j = 0; j < i; j++)
        name[j] = y.name[j];
    name[i] = '/';
}

int main() {
    int n;
loop0:
    stat(dot, &x);
    if (x.ino == 1) { // Already at root
        write(1, root, 1);
        prname();
    }
    if ((file = open(dotdot, O_RDONLY)) < 0) prname();
loop1:
    if ((n = read(file, &y, sizeof(y))) < sizeof(y)) prname();
    if (y.jnum != x.ino) goto loop1;
    close(file);
    if (y.jnum == 1) ckroot(); // Handle root case
    cat();
    chdir(dotdot);
    goto loop0;
}
