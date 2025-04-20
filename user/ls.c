#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"
#include "../sys/fs.h"

#define MAX_ENTRIES 512

char*
fmtname(char *path) {
    static char buf[DIRSIZ+1];
    char *p;

    // Find first character after last slash.
    for(p = path + strlen(path); p >= path && *p != '/'; p--)
        ;
    p++;

    // Return name without padding
    int len = strlen(p);
    if (len >= DIRSIZ)
        len = DIRSIZ;
    memmove(buf, p, len);
    buf[len] = '\0';
    return buf;
}

void ls(char *path) {
    char buf[512], *p;
    int fd;
    struct dirent de;
    struct stat st;

    if((fd = open(path, 0)) < 0){
        fprintf(2, "ls: cannot open %s\n", path);
        return;
    }

    if(fstat(fd, &st) < 0){
        fprintf(2, "ls: cannot stat %s\n", path);
        close(fd);
        return;
    }

    switch(st.type){
    case T_FILE:
        printf("%s\n", fmtname(path));
        break;

    case T_DIR:
        if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
            fprintf(2, "ls: path too long\n");
            break;
        }
        strcpy(buf, path);
        p = buf + strlen(buf);
        *p++ = '/';

        char names[MAX_ENTRIES][DIRSIZ+1];
        int num_entries = 0;

        while(read(fd, &de, sizeof(de)) == sizeof(de)){
            if(de.inum == 0)
                continue;
            memmove(p, de.name, DIRSIZ);
            p[DIRSIZ] = 0;
            if(stat(buf, &st) < 0){
                fprintf(2, "ls: cannot stat %s\n", buf);
                continue;
            }

            char entry_name[DIRSIZ+1];
            memmove(entry_name, de.name, DIRSIZ);
            entry_name[DIRSIZ] = '\0';

            int len = strlen(entry_name);
            if (len == 0)
                continue;

            if (num_entries < MAX_ENTRIES) {
                strncpy(names[num_entries], entry_name, DIRSIZ);
                names[num_entries][DIRSIZ] = '\0';
                num_entries++;
            }
        }

        // Sort entries
        int i, j;
        for (i = 0; i < num_entries - 1; i++) {
            for (j = 0; j < num_entries - i - 1; j++) {
                if (strcmp(names[j], names[j+1]) > 0) {
                    char temp[DIRSIZ+1];
                    strcpy(temp, names[j]);
                    strcpy(names[j], names[j+1]);
                    strcpy(names[j+1], temp);
                }
            }
        }

        int max_len = 0;
        for (i = 0; i < num_entries; i++) {
            int len = strlen(names[i]);
            if (len > max_len)
                max_len = len;
        }
        if (max_len == 0)
            max_len = 1;

        int terminal_width = 80;
        int col_width = max_len + 2;
        int cols = terminal_width / col_width -1;

        if (cols == 0)
            cols = 1;

        int rows = (num_entries + cols - 2) / cols;

        for (i = 0; i < rows; i++) {
            for (j = 0; j < cols; j++) {
                int index = i * cols + j;
                if (index >= num_entries)
                    break;

                printf("%s", names[index]);
                int len = strlen(names[index]);
                int padding = col_width - len;
                for (int k = 0; k < padding; k++)
                    printf(" ");
            }
            printf("\n");
        }
        break;
    }
    close(fd);
}

int main(int argc, char *argv[]) {
    int i;

    if(argc < 2){
        ls(".");
        exit();
    }
    for(i=1; i<argc; i++)
        ls(argv[i]);
    exit();
}
