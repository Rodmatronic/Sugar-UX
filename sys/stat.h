#define T_DIR  1   // Directory
#define T_FILE 2   // File
#define T_DEV  3   // Device
#ifndef S_IFMT
#define S_IFMT  00170000
#endif
#ifndef S_IFDIR
#define S_IFDIR 0040000
#define stderr 2
#endif

struct stat {
  unsigned short st_mode;
  short type;  // Type of file
  int dev;     // File system's disk device
  uint ino;    // Inode number
  short nlink; // Number of links to file
  uint size;   // Size of file in bytes
  int devn, inum, i[18];
};
