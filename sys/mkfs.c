#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <assert.h>

#define stat xv6_stat  // avoid clash with host struct stat
#include "types.h"
#include "fs.h"
#include "stat.h"
#include "param.h"

#ifndef static_assert
#define static_assert(a, b) do { switch (0) case 0: case (a): ; } while (0)
#endif

#define NINODES 200

// Disk layout:
// [ boot block | sb block | log | inode blocks | free bit map | data blocks ]

int nbitmap = FSSIZE/(BSIZE*8) + 1;
int ninodeblocks = NINODES / IPB + 1;
int nlog = LOGSIZE;
int nmeta;    // Number of meta blocks (boot, sb, nlog, inode, bitmap)
int nblocks;  // Number of data blocks

int fsfd;
struct superblock sb;
char zeroes[BSIZE];
uint freeinode = 1;
uint freeblock;


void balloc(int);
void wsect(uint, void*);
void winode(uint, struct dinode*);
void rinode(uint inum, struct dinode *ip);
void rsect(uint sec, void *buf);
uint ialloc(ushort type);
void iappend(uint inum, void *p, int n);

// convert to intel byte order
ushort
xshort(ushort x)
{
  ushort y;
  uchar *a = (uchar*)&y;
  a[0] = x;
  a[1] = x >> 8;
  return y;
}

uint
xint(uint x)
{
  uint y;
  uchar *a = (uchar*)&y;
  a[0] = x;
  a[1] = x >> 8;
  a[2] = x >> 16;
  a[3] = x >> 24;
  return y;
}

// Add "." and ".." entries to a directory inode
void
add_dot_entries(uint dir_ino, uint parent_ino)
{
  struct dirent de;
  bzero(&de, sizeof(de));
  de.inum = xshort(dir_ino);
  strcpy(de.name, ".");
  iappend(dir_ino, &de, sizeof(de));

  bzero(&de, sizeof(de));
  de.inum = xshort(parent_ino);
  strcpy(de.name, "..");
  iappend(dir_ino, &de, sizeof(de));
}

int
main(int argc, char *argv[])
{
  int i, cc, fd;
  uint rootino, inum, off;
  struct dirent de;
  char buf[BSIZE];
  struct dinode din;
  struct dinode root_ino;
  struct dinode sugar_ino;

  static_assert(sizeof(int) == 4, "Integers must be 4 bytes!");

  if(argc < 2){
    fprintf(stderr, "Usage: mkfs fs.img files...\n");
    exit(1);
  }

  assert((BSIZE % sizeof(struct dinode)) == 0);
  assert((BSIZE % sizeof(struct dirent)) == 0);

  fsfd = open(argv[1], O_RDWR|O_CREAT|O_TRUNC, 0666);
  if(fsfd < 0){
    perror(argv[1]);
    exit(1);
  }

  // 1 fs block = 1 disk sector
  nmeta = 2 + nlog + ninodeblocks + nbitmap;
  nblocks = FSSIZE - nmeta;

  sb.size = xint(FSSIZE);
  sb.nblocks = xint(nblocks);
  sb.ninodes = xint(NINODES);
  sb.nlog = xint(nlog);
  sb.logstart = xint(2);
  sb.inodestart = xint(2+nlog);
  sb.bmapstart = xint(2+nlog+ninodeblocks);

  printf("nmeta %d (boot, super, log blocks %u inode blocks %u, bitmap blocks %u) blocks %d total %d\n",
         nmeta, nlog, ninodeblocks, nbitmap, nblocks, FSSIZE);

  freeblock = nmeta;     // the first free block that we can allocate

  for(i = 0; i < FSSIZE; i++)
    wsect(i, zeroes);

  memset(buf, 0, sizeof(buf));
  memmove(buf, &sb, sizeof(sb));
  wsect(1, buf);

  rootino = ialloc(T_DIR);
  assert(rootino == ROOTINO);
  
  // Set UID for root directory
  rinode(rootino, &root_ino); // Read dinode from disk
  root_ino.uid = 0;           // Set UID to root
  winode(rootino, &root_ino); // Write back to disk

  add_dot_entries(rootino, rootino);

    uint binino = ialloc(T_DIR);
  assert(binino != 0);

  // Add 'bin' entry to root directory
  bzero(&de, sizeof(de));
  de.inum = xshort(binino);
  strcpy(de.name, "bin");
  iappend(rootino, &de, sizeof(de));

  add_dot_entries(binino, rootino);

  // Add 'etc' entry to root directory
  uint etcino = ialloc(T_DIR);
  assert(etcino != 0);
  
  bzero(&de, sizeof(de));
  de.inum = xshort(etcino);
  strcpy(de.name, "etc");
  iappend(rootino, &de, sizeof(de));

  add_dot_entries(etcino, rootino);

  // Add 'usr' entry to root directory
  uint usrino = ialloc(T_DIR);
  assert(usrino != 0);
  
  bzero(&de, sizeof(de));
  de.inum = xshort(usrino);
  strcpy(de.name, "usr");
  iappend(rootino, &de, sizeof(de));

  add_dot_entries(usrino, rootino);

  // Add 'bin' entry to usr directory
  uint usrbinino = ialloc(T_DIR);
  assert(usrbinino != 0);
  
  bzero(&de, sizeof(de));
  de.inum = xshort(usrbinino);
  strcpy(de.name, "bin");
  iappend(usrino, &de, sizeof(de));

  add_dot_entries(usrbinino, usrino);

  // Add 'home' entry to root directory
  uint homeino = ialloc(T_DIR);
  assert(homeino != 0);
  
  bzero(&de, sizeof(de));
  de.inum = xshort(homeino);
  strcpy(de.name, "home");
  iappend(rootino, &de, sizeof(de));

  add_dot_entries(homeino, rootino);

  // Add 'sbin' entry to root directory
  uint sbinino = ialloc(T_DIR);
  assert(sbinino != 0);
  
  bzero(&de, sizeof(de));
  de.inum = xshort(sbinino);
  strcpy(de.name, "sbin");
  iappend(rootino, &de, sizeof(de));

  add_dot_entries(sbinino, rootino);

  // Add 'sugar' entry to home directory
  uint sugarino = ialloc(T_DIR);
  assert(homeino != 0);
  
  bzero(&de, sizeof(de));
  de.inum = xshort(sugarino);
  strcpy(de.name, "sugar");
  iappend(homeino, &de, sizeof(de));

  add_dot_entries(sugarino, homeino);
  
  rinode(sugarino, &sugar_ino); // Read dinode from disk
  sugar_ino.uid = 0;           // Set UID to sugar
  winode(sugarino, &sugar_ino);

for (i = 2; i < argc; i++) {
    assert(index(argv[i], '/') == 0); // No slashes

    if ((fd = open(argv[i], 0)) < 0) {
        perror(argv[i]);
        exit(1);
    }

    // Handle leading '_'
    char *name = argv[i];
    if (name[0] == '_')
        name++;

    inum = ialloc(T_FILE);

    // Create directory entry
    bzero(&de, sizeof(de));
    de.inum = xshort(inum);
    strncpy(de.name, name, DIRSIZ);

    // Special cases
    if (strcmp(name, "init") == 0) {
        iappend(rootino, &de, sizeof(de));
    } else if (strcmp(name, "README") == 0) {
        iappend(rootino, &de, sizeof(de));
    } else if (strcmp(name, "LICENSE") == 0) {
      iappend(rootino, &de, sizeof(de));
    } else if (strcmp(name, "profile") == 0) {
      iappend(etcino, &de, sizeof(de));
    } else if (strcmp(name, "~passwd") == 0) {
    iappend(etcino, &de, sizeof(de));
    } else if (strcmp(name, "motd") == 0) {
      iappend(etcino, &de, sizeof(de));
    } else if (strcmp(name, "issue") == 0) {
      iappend(etcino, &de, sizeof(de));
    } else if (strcmp(name, "groups") == 0) {
      iappend(etcino, &de, sizeof(de));
    } else if (strcmp(name, "rc") == 0) {
      iappend(etcino, &de, sizeof(de));
    } else if (strcmp(name, "nologin") == 0) {
      iappend(sbinino, &de, sizeof(de));
    } else if (strcmp(name, "halt") == 0) {
      iappend(sbinino, &de, sizeof(de));
    } else if (strcmp(name, "reboot") == 0) {
      iappend(sbinino, &de, sizeof(de));
    } else if (strcmp(name, "mknod") == 0) {
      iappend(sbinino, &de, sizeof(de));
    } else if (strcmp(name, "getty") == 0) {
      iappend(sbinino, &de, sizeof(de));
    } else if (strcmp(name, "adduser") == 0) {
      iappend(usrbinino, &de, sizeof(de));
    } else if (strcmp(name, "whereis") == 0) {
      iappend(usrbinino, &de, sizeof(de));
    } else if (strcmp(name, "true") == 0) {
      iappend(usrbinino, &de, sizeof(de));
    } else if (strcmp(name, "false") == 0) {
      iappend(usrbinino, &de, sizeof(de));
    } else if (strcmp(name, "tty") == 0) {
      iappend(usrbinino, &de, sizeof(de));
    } else if (strcmp(name, "login") == 0) {
      iappend(usrbinino, &de, sizeof(de));
    } else if (strcmp(name, "env") == 0) {
      iappend(usrbinino, &de, sizeof(de));
    } else if (strcmp(name, "whoami") == 0) {
      iappend(usrbinino, &de, sizeof(de));
    } else if (strcmp(name, "su") == 0) {
      iappend(usrbinino, &de, sizeof(de));
    } else if (strcmp(name, "hexdump") == 0) {
      iappend(usrbinino, &de, sizeof(de));
    } else if (strcmp(name, "grep") == 0) {
      iappend(usrbinino, &de, sizeof(de));
    } else if (strcmp(name, "getuid") == 0) {
      iappend(usrbinino, &de, sizeof(de));
    } else if (strcmp(name, "passwd") == 0) {
      iappend(usrbinino, &de, sizeof(de));
    } else if (strcmp(name, "more") == 0) {
      iappend(usrbinino, &de, sizeof(de));
    } else if (strcmp(name, "head") == 0) {
      iappend(usrbinino, &de, sizeof(de));
    } else if (strcmp(name, "man") == 0) {
      iappend(usrbinino, &de, sizeof(de));
    } else if (strcmp(name, "clear") == 0) {
      iappend(usrbinino, &de, sizeof(de));
    } else if (strcmp(name, "yes") == 0) {
      iappend(usrbinino, &de, sizeof(de));
    } else if (strcmp(name, "basename") == 0) {
      iappend(usrbinino, &de, sizeof(de));
    } else if (strcmp(name, "uname") == 0) {
      iappend(usrbinino, &de, sizeof(de));
    } else if (strcmp(name, "uptime") == 0) {
      iappend(usrbinino, &de, sizeof(de));
    } else {
        iappend(binino, &de, sizeof(de));
    }

    // Append file contents
    while ((cc = read(fd, buf, sizeof(buf))) > 0)
        iappend(inum, buf, cc);

    close(fd);
}

  // fix size of root inode dir
  rinode(rootino, &din);
  off = xint(din.size);
  off = ((off/BSIZE) + 1) * BSIZE;
  din.size = xint(off);
  winode(rootino, &din);

  balloc(freeblock);

  exit(0);
}

void
wsect(uint sec, void *buf)
{
  if(lseek(fsfd, sec * BSIZE, 0) != sec * BSIZE){
    perror("lseek");
    exit(1);
  }
  if(write(fsfd, buf, BSIZE) != BSIZE){
    perror("write");
    exit(1);
  }
}

void
winode(uint inum, struct dinode *ip)
{
  char buf[BSIZE];
  uint bn;
  struct dinode *dip;

  bn = IBLOCK(inum, sb);
  rsect(bn, buf);
  dip = ((struct dinode*)buf) + (inum % IPB);
  *dip = *ip;
  wsect(bn, buf);
}

void
rinode(uint inum, struct dinode *ip)
{
  char buf[BSIZE];
  uint bn;
  struct dinode *dip;

  bn = IBLOCK(inum, sb);
  rsect(bn, buf);
  dip = ((struct dinode*)buf) + (inum % IPB);
  *ip = *dip;
}

void
rsect(uint sec, void *buf)
{
  if(lseek(fsfd, sec * BSIZE, 0) != sec * BSIZE){
    perror("lseek");
    exit(1);
  }
  if(read(fsfd, buf, BSIZE) != BSIZE){
    perror("read");
    exit(1);
  }
}

uint
ialloc(ushort type)
{
  uint inum = freeinode++;
  struct dinode din;

  bzero(&din, sizeof(din));
  din.type = xshort(type);
  din.nlink = xshort(1);
  din.size = xint(0);
  winode(inum, &din);
  return inum;
}

void
balloc(int used)
{
  uchar buf[BSIZE];
  int i;

  printf("balloc: first %d blocks have been allocated\n", used);
  assert(used < BSIZE*8);
  bzero(buf, BSIZE);
  for(i = 0; i < used; i++){
    buf[i/8] = buf[i/8] | (0x1 << (i%8));
  }
  printf("balloc: write bitmap block at sector %d\n", sb.bmapstart);
  wsect(sb.bmapstart, buf);
}

#define min(a, b) ((a) < (b) ? (a) : (b))

void
iappend(uint inum, void *xp, int n)
{
  char *p = (char*)xp;
  uint fbn, off, n1;
  struct dinode din;
  char buf[BSIZE];
  uint indirect[NINDIRECT];
  uint x;

  rinode(inum, &din);
  off = xint(din.size);
  //printf("append inum %d at off %d sz %d\n", inum, off, n);
  while(n > 0){
    fbn = off / BSIZE;
    assert(fbn < MAXFILE);
    if(fbn < NDIRECT){
      if(xint(din.addrs[fbn]) == 0){
        din.addrs[fbn] = xint(freeblock++);
      }
      x = xint(din.addrs[fbn]);
    } else {
      if(xint(din.addrs[NDIRECT]) == 0){
        din.addrs[NDIRECT] = xint(freeblock++);
      }
      rsect(xint(din.addrs[NDIRECT]), (char*)indirect);
      if(indirect[fbn - NDIRECT] == 0){
        indirect[fbn - NDIRECT] = xint(freeblock++);
        wsect(xint(din.addrs[NDIRECT]), (char*)indirect);
      }
      x = xint(indirect[fbn-NDIRECT]);
    }
    n1 = min(n, (fbn + 1) * BSIZE - off);
    rsect(x, buf);
    bcopy(p, buf + off - (fbn * BSIZE), n1);
    wsect(x, buf);
    n -= n1;
    off += n1;
    p += n1;
  }
  din.size = xint(off);
  winode(inum, &din);
}
