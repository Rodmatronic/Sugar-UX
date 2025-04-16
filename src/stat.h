#define T_DIR  1   // Directory
#define T_FILE 2   // File
#define T_DEV  3   // Device
#define S_IFMT  00170000
#define S_IFDIR  0040000

struct stat {
  unsigned short st_mode;
  short type;  // Type of file
  int dev;     // File system's disk device
  uint ino;    // Inode number
  short nlink; // Number of links to file
  uint size;   // Size of file in bytes
  int devn, inum, i[18];
};
