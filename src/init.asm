
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return months[m - 1];
}

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 38             	sub    $0x38,%esp
  int pid, wpid;
  if (getpid() != 1) {
  14:	e8 5a 06 00 00       	call   673 <getpid>
  19:	83 f8 01             	cmp    $0x1,%eax
  1c:	74 13                	je     31 <main+0x31>
    (void)fprintf(stderr, "init: already running\n");
  1e:	56                   	push   %esi
  1f:	56                   	push   %esi
  20:	68 e4 0e 00 00       	push   $0xee4
  25:	6a 02                	push   $0x2
  27:	e8 24 0b 00 00       	call   b50 <fprintf>
    exit();
  2c:	e8 c2 05 00 00       	call   5f3 <exit>
  }

  mkdir("/dev");
  31:	83 ec 0c             	sub    $0xc,%esp
  34:	68 fb 0e 00 00       	push   $0xefb
  39:	e8 1d 06 00 00       	call   65b <mkdir>
  mkdir("/var");
  3e:	c7 04 24 00 0f 00 00 	movl   $0xf00,(%esp)
  45:	e8 11 06 00 00       	call   65b <mkdir>

  if(open("/dev/console", O_RDWR) < 0){
  4a:	59                   	pop    %ecx
  4b:	5b                   	pop    %ebx
  4c:	6a 02                	push   $0x2
  4e:	68 05 0f 00 00       	push   $0xf05
  53:	e8 db 05 00 00       	call   633 <open>
  58:	83 c4 10             	add    $0x10,%esp
  5b:	85 c0                	test   %eax,%eax
  5d:	0f 88 33 02 00 00    	js     296 <main+0x296>
    mknod("/dev/console", 1, 1);
    open("/dev/console", O_RDWR);
  }

  mknod("/dev/null", 2, 0);
  63:	51                   	push   %ecx
  mknod("/dev/zero", 4, 0);

  mkdir("/root");
  mkdir("/etc");

  dup(0);  // stdout
  64:	31 db                	xor    %ebx,%ebx
  dup(0);  // stderr
  66:	31 f6                	xor    %esi,%esi
  mknod("/dev/null", 2, 0);
  68:	6a 00                	push   $0x0
  6a:	6a 02                	push   $0x2
  6c:	68 12 0f 00 00       	push   $0xf12
  71:	e8 c5 05 00 00       	call   63b <mknod>
  mknod("/dev/kmem", 3, 0);
  76:	83 c4 0c             	add    $0xc,%esp
  79:	6a 00                	push   $0x0
  7b:	6a 03                	push   $0x3
  7d:	68 1c 0f 00 00       	push   $0xf1c
  82:	e8 b4 05 00 00       	call   63b <mknod>
  mknod("/dev/zero", 4, 0);
  87:	83 c4 0c             	add    $0xc,%esp
  8a:	6a 00                	push   $0x0
  8c:	6a 04                	push   $0x4
  8e:	68 26 0f 00 00       	push   $0xf26
  93:	e8 a3 05 00 00       	call   63b <mknod>
  mkdir("/root");
  98:	c7 04 24 30 0f 00 00 	movl   $0xf30,(%esp)
  9f:	e8 b7 05 00 00       	call   65b <mkdir>
  mkdir("/etc");
  a4:	c7 04 24 36 0f 00 00 	movl   $0xf36,(%esp)
  ab:	e8 ab 05 00 00       	call   65b <mkdir>
  dup(0);  // stdout
  b0:	89 1c 24             	mov    %ebx,(%esp)
  b3:	e8 b3 05 00 00       	call   66b <dup>
  dup(0);  // stderr
  b8:	89 34 24             	mov    %esi,(%esp)
  bb:	e8 ab 05 00 00       	call   66b <dup>
  printf("clearing /tmp\n");
  c0:	c7 04 24 3b 0f 00 00 	movl   $0xf3b,(%esp)
  c7:	e8 a4 07 00 00       	call   870 <printf>
  unlink("/tmp"); mkdir("/tmp");
  cc:	c7 04 24 4a 0f 00 00 	movl   $0xf4a,(%esp)
  d3:	e8 6b 05 00 00       	call   643 <unlink>
  d8:	c7 04 24 4a 0f 00 00 	movl   $0xf4a,(%esp)
  df:	e8 77 05 00 00       	call   65b <mkdir>
   *
   */


  int fd;
  fd = open("/etc/issue", O_WRONLY | O_CREATE);
  e4:	5f                   	pop    %edi
  e5:	58                   	pop    %eax
  e6:	68 01 02 00 00       	push   $0x201
  eb:	68 4f 0f 00 00       	push   $0xf4f
  f0:	e8 3e 05 00 00       	call   633 <open>
  if (fd < 0) {
  f5:	83 c4 10             	add    $0x10,%esp
  fd = open("/etc/issue", O_WRONLY | O_CREATE);
  f8:	89 c3                	mov    %eax,%ebx
  if (fd < 0) {
  fa:	85 c0                	test   %eax,%eax
  fc:	0f 88 7f 01 00 00    	js     281 <main+0x281>
    printf("Failed to create file\n");
  }
  char *issue = "Sugar/Unix 0.11 (Codename ALFA)\n";
  write(fd, issue, 34);
 102:	50                   	push   %eax
 103:	6a 22                	push   $0x22
 105:	68 48 10 00 00       	push   $0x1048
 10a:	53                   	push   %ebx
 10b:	e8 03 05 00 00       	call   613 <write>

  fd = open("/etc/passwd", O_WRONLY | O_CREATE);
 110:	58                   	pop    %eax
 111:	5a                   	pop    %edx
 112:	68 01 02 00 00       	push   $0x201
 117:	68 71 0f 00 00       	push   $0xf71
 11c:	e8 12 05 00 00       	call   633 <open>
  if (fd < 0) {
 121:	83 c4 10             	add    $0x10,%esp
  fd = open("/etc/passwd", O_WRONLY | O_CREATE);
 124:	89 c3                	mov    %eax,%ebx
  if (fd < 0) {
 126:	85 c0                	test   %eax,%eax
 128:	0f 88 8d 01 00 00    	js     2bb <main+0x2bb>
    printf("Failed to create file\n");
  }
  char *passwd = "root::0:0:Super User:/:/bin/sh\n";
  write(fd, passwd, 40);
 12e:	56                   	push   %esi
 12f:	6a 28                	push   $0x28
 131:	68 6c 10 00 00       	push   $0x106c
 136:	53                   	push   %ebx
 137:	e8 d7 04 00 00       	call   613 <write>

  fd = open("/etc/motd", O_WRONLY | O_CREATE);
 13c:	5f                   	pop    %edi
 13d:	58                   	pop    %eax
 13e:	68 01 02 00 00       	push   $0x201
 143:	68 7d 0f 00 00       	push   $0xf7d
 148:	e8 e6 04 00 00       	call   633 <open>
  if (fd < 0) {
 14d:	83 c4 10             	add    $0x10,%esp
  fd = open("/etc/motd", O_WRONLY | O_CREATE);
 150:	89 c3                	mov    %eax,%ebx
  if (fd < 0) {
 152:	85 c0                	test   %eax,%eax
 154:	0f 88 12 01 00 00    	js     26c <main+0x26c>
    printf("Failed to create file\n");
  }
  char *entry = "\nWelcome to Sugar/Unix!\n";
  write(fd, entry, 24);
 15a:	51                   	push   %ecx
 15b:	6a 18                	push   $0x18
 15d:	68 87 0f 00 00       	push   $0xf87
 162:	53                   	push   %ebx
 163:	e8 ab 04 00 00       	call   613 <write>

  close(fd);
 168:	89 1c 24             	mov    %ebx,(%esp)
 16b:	e8 ab 04 00 00       	call   61b <close>

  struct rtcdate r;

  if (gettime(&r) == 0) {
 170:	8d 45 d0             	lea    -0x30(%ebp),%eax
 173:	89 04 24             	mov    %eax,(%esp)
 176:	e8 28 05 00 00       	call   6a3 <gettime>
 17b:	83 c4 10             	add    $0x10,%esp
 17e:	85 c0                	test   %eax,%eax
 180:	0f 84 8b 00 00 00    	je     211 <main+0x211>
           r.hour,
           r.minute,
           r.second,
           r.year);
  }
  printf("\nSugar/Unix login\n\n");
 186:	83 ec 0c             	sub    $0xc,%esp
 189:	68 a0 0f 00 00       	push   $0xfa0
 18e:	e8 dd 06 00 00       	call   870 <printf>
 193:	83 c4 10             	add    $0x10,%esp
 196:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 19d:	00 
 19e:	66 90                	xchg   %ax,%ax

  for(;;){
    pid = fork();
 1a0:	e8 46 04 00 00       	call   5eb <fork>
 1a5:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
 1a7:	85 c0                	test   %eax,%eax
 1a9:	78 54                	js     1ff <main+0x1ff>
      printf("init: fork failed\n");
    }
    if(pid == 0){
 1ab:	75 21                	jne    1ce <main+0x1ce>
      exec("/bin/login", argv);
 1ad:	83 ec 08             	sub    $0x8,%esp
 1b0:	68 30 15 00 00       	push   $0x1530
 1b5:	68 c7 0f 00 00       	push   $0xfc7
 1ba:	e8 6c 04 00 00       	call   62b <exec>
      printf("init: exec login failed\n");
 1bf:	c7 04 24 d2 0f 00 00 	movl   $0xfd2,(%esp)
 1c6:	e8 a5 06 00 00       	call   870 <printf>
 1cb:	83 c4 10             	add    $0x10,%esp
    }
    while((wpid=wait()) >= 0 && wpid != pid)
 1ce:	e8 28 04 00 00       	call   5fb <wait>
 1d3:	39 c3                	cmp    %eax,%ebx
 1d5:	74 c9                	je     1a0 <main+0x1a0>
 1d7:	85 c0                	test   %eax,%eax
 1d9:	78 c5                	js     1a0 <main+0x1a0>
      printf("zombie!\n");
 1db:	83 ec 0c             	sub    $0xc,%esp
 1de:	68 eb 0f 00 00       	push   $0xfeb
 1e3:	e8 88 06 00 00       	call   870 <printf>
 1e8:	83 c4 10             	add    $0x10,%esp
    while((wpid=wait()) >= 0 && wpid != pid)
 1eb:	e8 0b 04 00 00       	call   5fb <wait>
 1f0:	39 c3                	cmp    %eax,%ebx
 1f2:	75 e3                	jne    1d7 <main+0x1d7>
    pid = fork();
 1f4:	e8 f2 03 00 00       	call   5eb <fork>
 1f9:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
 1fb:	85 c0                	test   %eax,%eax
 1fd:	79 ac                	jns    1ab <main+0x1ab>
      printf("init: fork failed\n");
 1ff:	83 ec 0c             	sub    $0xc,%esp
 202:	68 b4 0f 00 00       	push   $0xfb4
 207:	e8 64 06 00 00       	call   870 <printf>
 20c:	83 c4 10             	add    $0x10,%esp
 20f:	eb bd                	jmp    1ce <main+0x1ce>
    printf("%02s %02s %02d %02d:%02d:%02d UTC %02d\n",
 211:	8b 45 d8             	mov    -0x28(%ebp),%eax
 214:	8b 75 e4             	mov    -0x1c(%ebp),%esi
 217:	8b 55 d0             	mov    -0x30(%ebp),%edx
 21a:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 21d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
           monthname(r.month),
 220:	8b 45 e0             	mov    -0x20(%ebp),%eax
    printf("%02s %02s %02d %02d:%02d:%02d UTC %02d\n",
 223:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  if (m < 1 || m > 12)
 226:	8d 48 ff             	lea    -0x1(%eax),%ecx
 229:	83 f9 0b             	cmp    $0xb,%ecx
 22c:	0f 87 9e 00 00 00    	ja     2d0 <main+0x2d0>
  return months[m - 1];
 232:	8b 0c 8d c0 10 00 00 	mov    0x10c0(,%ecx,4),%ecx
 239:	89 55 c0             	mov    %edx,-0x40(%ebp)
    printf("%02s %02s %02d %02d:%02d:%02d UTC %02d\n",
 23c:	52                   	push   %edx
 23d:	53                   	push   %ebx
 23e:	50                   	push   %eax
 23f:	56                   	push   %esi
 240:	89 4d bc             	mov    %ecx,-0x44(%ebp)
 243:	e8 98 00 00 00       	call   2e0 <get_weekday>
 248:	8b 55 c0             	mov    -0x40(%ebp),%edx
 24b:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 24e:	83 c4 10             	add    $0x10,%esp
 251:	56                   	push   %esi
 252:	52                   	push   %edx
 253:	57                   	push   %edi
 254:	ff 75 c4             	push   -0x3c(%ebp)
 257:	53                   	push   %ebx
 258:	51                   	push   %ecx
 259:	50                   	push   %eax
 25a:	68 8c 10 00 00       	push   $0x108c
 25f:	e8 0c 06 00 00       	call   870 <printf>
 264:	83 c4 20             	add    $0x20,%esp
 267:	e9 1a ff ff ff       	jmp    186 <main+0x186>
    printf("Failed to create file\n");
 26c:	83 ec 0c             	sub    $0xc,%esp
 26f:	68 5a 0f 00 00       	push   $0xf5a
 274:	e8 f7 05 00 00       	call   870 <printf>
 279:	83 c4 10             	add    $0x10,%esp
 27c:	e9 d9 fe ff ff       	jmp    15a <main+0x15a>
    printf("Failed to create file\n");
 281:	83 ec 0c             	sub    $0xc,%esp
 284:	68 5a 0f 00 00       	push   $0xf5a
 289:	e8 e2 05 00 00       	call   870 <printf>
 28e:	83 c4 10             	add    $0x10,%esp
 291:	e9 6c fe ff ff       	jmp    102 <main+0x102>
    mknod("/dev/console", 1, 1);
 296:	50                   	push   %eax
 297:	6a 01                	push   $0x1
 299:	6a 01                	push   $0x1
 29b:	68 05 0f 00 00       	push   $0xf05
 2a0:	e8 96 03 00 00       	call   63b <mknod>
    open("/dev/console", O_RDWR);
 2a5:	58                   	pop    %eax
 2a6:	5a                   	pop    %edx
 2a7:	6a 02                	push   $0x2
 2a9:	68 05 0f 00 00       	push   $0xf05
 2ae:	e8 80 03 00 00       	call   633 <open>
 2b3:	83 c4 10             	add    $0x10,%esp
 2b6:	e9 a8 fd ff ff       	jmp    63 <main+0x63>
    printf("Failed to create file\n");
 2bb:	83 ec 0c             	sub    $0xc,%esp
 2be:	68 5a 0f 00 00       	push   $0xf5a
 2c3:	e8 a8 05 00 00       	call   870 <printf>
 2c8:	83 c4 10             	add    $0x10,%esp
 2cb:	e9 5e fe ff ff       	jmp    12e <main+0x12e>
    return "???";
 2d0:	b9 e0 0e 00 00       	mov    $0xee0,%ecx
 2d5:	e9 5f ff ff ff       	jmp    239 <main+0x239>
 2da:	66 90                	xchg   %ax,%ax
 2dc:	66 90                	xchg   %ax,%ax
 2de:	66 90                	xchg   %ax,%ax

000002e0 <get_weekday>:
char* get_weekday(int y, int m, int d) {
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	57                   	push   %edi
 2e4:	56                   	push   %esi
 2e5:	8b 75 0c             	mov    0xc(%ebp),%esi
 2e8:	53                   	push   %ebx
 2e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (m < 3) {
 2ec:	83 fe 02             	cmp    $0x2,%esi
 2ef:	7f 06                	jg     2f7 <get_weekday+0x17>
    m += 12;
 2f1:	83 c6 0c             	add    $0xc,%esi
    y -= 1;
 2f4:	83 eb 01             	sub    $0x1,%ebx
  int h = (d + 2*m + 3*(m+1)/5 + y + y/4 - y/100 + y/400) % 7;
 2f7:	8d 7c 76 03          	lea    0x3(%esi,%esi,2),%edi
 2fb:	b8 67 66 66 66       	mov    $0x66666667,%eax
 300:	f7 ef                	imul   %edi
 302:	8b 45 10             	mov    0x10(%ebp),%eax
 305:	c1 ff 1f             	sar    $0x1f,%edi
 308:	8d 04 70             	lea    (%eax,%esi,2),%eax
 30b:	d1 fa                	sar    $1,%edx
 30d:	29 fa                	sub    %edi,%edx
 30f:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
 312:	8d 43 03             	lea    0x3(%ebx),%eax
 315:	01 d9                	add    %ebx,%ecx
 317:	85 db                	test   %ebx,%ebx
 319:	0f 49 c3             	cmovns %ebx,%eax
 31c:	c1 f8 02             	sar    $0x2,%eax
 31f:	01 c1                	add    %eax,%ecx
 321:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
 326:	f7 eb                	imul   %ebx
 328:	c1 fb 1f             	sar    $0x1f,%ebx
 32b:	89 d8                	mov    %ebx,%eax
 32d:	89 d6                	mov    %edx,%esi
 32f:	c1 fa 07             	sar    $0x7,%edx
 332:	c1 fe 05             	sar    $0x5,%esi
 335:	29 da                	sub    %ebx,%edx
}
 337:	5b                   	pop    %ebx
  int h = (d + 2*m + 3*(m+1)/5 + y + y/4 - y/100 + y/400) % 7;
 338:	29 f0                	sub    %esi,%eax
}
 33a:	5e                   	pop    %esi
 33b:	5f                   	pop    %edi
  int h = (d + 2*m + 3*(m+1)/5 + y + y/4 - y/100 + y/400) % 7;
 33c:	01 c1                	add    %eax,%ecx
 33e:	b8 93 24 49 92       	mov    $0x92492493,%eax
}
 343:	5d                   	pop    %ebp
  int h = (d + 2*m + 3*(m+1)/5 + y + y/4 - y/100 + y/400) % 7;
 344:	01 d1                	add    %edx,%ecx
 346:	f7 e9                	imul   %ecx
 348:	89 c8                	mov    %ecx,%eax
 34a:	c1 f8 1f             	sar    $0x1f,%eax
 34d:	01 ca                	add    %ecx,%edx
 34f:	c1 fa 02             	sar    $0x2,%edx
 352:	29 c2                	sub    %eax,%edx
 354:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
 35b:	29 d0                	sub    %edx,%eax
 35d:	29 c1                	sub    %eax,%ecx
  return days[h];
 35f:	8b 04 8d f0 10 00 00 	mov    0x10f0(,%ecx,4),%eax
}
 366:	c3                   	ret
 367:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 36e:	00 
 36f:	90                   	nop

00000370 <monthname>:
char* monthname(int m) {
 370:	55                   	push   %ebp
 371:	ba e0 0e 00 00       	mov    $0xee0,%edx
 376:	89 e5                	mov    %esp,%ebp
  if (m < 1 || m > 12)
 378:	8b 45 08             	mov    0x8(%ebp),%eax
 37b:	83 e8 01             	sub    $0x1,%eax
 37e:	83 f8 0b             	cmp    $0xb,%eax
 381:	77 07                	ja     38a <monthname+0x1a>
  return months[m - 1];
 383:	8b 14 85 c0 10 00 00 	mov    0x10c0(,%eax,4),%edx
}
 38a:	89 d0                	mov    %edx,%eax
 38c:	5d                   	pop    %ebp
 38d:	c3                   	ret
 38e:	66 90                	xchg   %ax,%ax
 390:	66 90                	xchg   %ax,%ax
 392:	66 90                	xchg   %ax,%ax
 394:	66 90                	xchg   %ax,%ax
 396:	66 90                	xchg   %ax,%ax
 398:	66 90                	xchg   %ax,%ax
 39a:	66 90                	xchg   %ax,%ax
 39c:	66 90                	xchg   %ax,%ax
 39e:	66 90                	xchg   %ax,%ax

000003a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 3a0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 3a1:	31 c0                	xor    %eax,%eax
{
 3a3:	89 e5                	mov    %esp,%ebp
 3a5:	53                   	push   %ebx
 3a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 3ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 3b0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 3b4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 3b7:	83 c0 01             	add    $0x1,%eax
 3ba:	84 d2                	test   %dl,%dl
 3bc:	75 f2                	jne    3b0 <strcpy+0x10>
    ;
  return os;
}
 3be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3c1:	89 c8                	mov    %ecx,%eax
 3c3:	c9                   	leave
 3c4:	c3                   	ret
 3c5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3cc:	00 
 3cd:	8d 76 00             	lea    0x0(%esi),%esi

000003d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	53                   	push   %ebx
 3d4:	8b 55 08             	mov    0x8(%ebp),%edx
 3d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 3da:	0f b6 02             	movzbl (%edx),%eax
 3dd:	84 c0                	test   %al,%al
 3df:	75 2f                	jne    410 <strcmp+0x40>
 3e1:	eb 4a                	jmp    42d <strcmp+0x5d>
 3e3:	eb 1b                	jmp    400 <strcmp+0x30>
 3e5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3ec:	00 
 3ed:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3f4:	00 
 3f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3fc:	00 
 3fd:	8d 76 00             	lea    0x0(%esi),%esi
 400:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 404:	83 c2 01             	add    $0x1,%edx
 407:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 40a:	84 c0                	test   %al,%al
 40c:	74 12                	je     420 <strcmp+0x50>
 40e:	89 d9                	mov    %ebx,%ecx
 410:	0f b6 19             	movzbl (%ecx),%ebx
 413:	38 c3                	cmp    %al,%bl
 415:	74 e9                	je     400 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 417:	29 d8                	sub    %ebx,%eax
}
 419:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 41c:	c9                   	leave
 41d:	c3                   	ret
 41e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 420:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 424:	31 c0                	xor    %eax,%eax
 426:	29 d8                	sub    %ebx,%eax
}
 428:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 42b:	c9                   	leave
 42c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 42d:	0f b6 19             	movzbl (%ecx),%ebx
 430:	31 c0                	xor    %eax,%eax
 432:	eb e3                	jmp    417 <strcmp+0x47>
 434:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 43b:	00 
 43c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000440 <strlen>:

uint
strlen(char *s)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 446:	80 3a 00             	cmpb   $0x0,(%edx)
 449:	74 15                	je     460 <strlen+0x20>
 44b:	31 c0                	xor    %eax,%eax
 44d:	8d 76 00             	lea    0x0(%esi),%esi
 450:	83 c0 01             	add    $0x1,%eax
 453:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 457:	89 c1                	mov    %eax,%ecx
 459:	75 f5                	jne    450 <strlen+0x10>
    ;
  return n;
}
 45b:	89 c8                	mov    %ecx,%eax
 45d:	5d                   	pop    %ebp
 45e:	c3                   	ret
 45f:	90                   	nop
  for(n = 0; s[n]; n++)
 460:	31 c9                	xor    %ecx,%ecx
}
 462:	5d                   	pop    %ebp
 463:	89 c8                	mov    %ecx,%eax
 465:	c3                   	ret
 466:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 46d:	00 
 46e:	66 90                	xchg   %ax,%ax

00000470 <memset>:

void*
memset(void *dst, int c, uint n)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	57                   	push   %edi
 474:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 477:	8b 4d 10             	mov    0x10(%ebp),%ecx
 47a:	8b 45 0c             	mov    0xc(%ebp),%eax
 47d:	89 d7                	mov    %edx,%edi
 47f:	fc                   	cld
 480:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 482:	8b 7d fc             	mov    -0x4(%ebp),%edi
 485:	89 d0                	mov    %edx,%eax
 487:	c9                   	leave
 488:	c3                   	ret
 489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000490 <strchr>:

char*
strchr(const char *s, char c)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	8b 45 08             	mov    0x8(%ebp),%eax
 496:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 49a:	0f b6 10             	movzbl (%eax),%edx
 49d:	84 d2                	test   %dl,%dl
 49f:	75 1a                	jne    4bb <strchr+0x2b>
 4a1:	eb 25                	jmp    4c8 <strchr+0x38>
 4a3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4aa:	00 
 4ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 4b0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 4b4:	83 c0 01             	add    $0x1,%eax
 4b7:	84 d2                	test   %dl,%dl
 4b9:	74 0d                	je     4c8 <strchr+0x38>
    if(*s == c)
 4bb:	38 d1                	cmp    %dl,%cl
 4bd:	75 f1                	jne    4b0 <strchr+0x20>
      return (char*)s;
  return 0;
}
 4bf:	5d                   	pop    %ebp
 4c0:	c3                   	ret
 4c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 4c8:	31 c0                	xor    %eax,%eax
}
 4ca:	5d                   	pop    %ebp
 4cb:	c3                   	ret
 4cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004d0 <gets>:

char*
gets(char *buf, int max)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	57                   	push   %edi
 4d4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 4d5:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 4d8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 4d9:	31 db                	xor    %ebx,%ebx
{
 4db:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 4de:	eb 27                	jmp    507 <gets+0x37>
    cc = read(0, &c, 1);
 4e0:	83 ec 04             	sub    $0x4,%esp
 4e3:	6a 01                	push   $0x1
 4e5:	56                   	push   %esi
 4e6:	6a 00                	push   $0x0
 4e8:	e8 1e 01 00 00       	call   60b <read>
    if(cc < 1)
 4ed:	83 c4 10             	add    $0x10,%esp
 4f0:	85 c0                	test   %eax,%eax
 4f2:	7e 1d                	jle    511 <gets+0x41>
      break;
    buf[i++] = c;
 4f4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 4f8:	8b 55 08             	mov    0x8(%ebp),%edx
 4fb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 4ff:	3c 0a                	cmp    $0xa,%al
 501:	74 10                	je     513 <gets+0x43>
 503:	3c 0d                	cmp    $0xd,%al
 505:	74 0c                	je     513 <gets+0x43>
  for(i=0; i+1 < max; ){
 507:	89 df                	mov    %ebx,%edi
 509:	83 c3 01             	add    $0x1,%ebx
 50c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 50f:	7c cf                	jl     4e0 <gets+0x10>
 511:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 513:	8b 45 08             	mov    0x8(%ebp),%eax
 516:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 51a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 51d:	5b                   	pop    %ebx
 51e:	5e                   	pop    %esi
 51f:	5f                   	pop    %edi
 520:	5d                   	pop    %ebp
 521:	c3                   	ret
 522:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 529:	00 
 52a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000530 <stat>:

int
stat(char *n, struct stat *st)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	56                   	push   %esi
 534:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 535:	83 ec 08             	sub    $0x8,%esp
 538:	6a 00                	push   $0x0
 53a:	ff 75 08             	push   0x8(%ebp)
 53d:	e8 f1 00 00 00       	call   633 <open>
  if(fd < 0)
 542:	83 c4 10             	add    $0x10,%esp
 545:	85 c0                	test   %eax,%eax
 547:	78 27                	js     570 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 549:	83 ec 08             	sub    $0x8,%esp
 54c:	ff 75 0c             	push   0xc(%ebp)
 54f:	89 c3                	mov    %eax,%ebx
 551:	50                   	push   %eax
 552:	e8 f4 00 00 00       	call   64b <fstat>
  close(fd);
 557:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 55a:	89 c6                	mov    %eax,%esi
  close(fd);
 55c:	e8 ba 00 00 00       	call   61b <close>
  return r;
 561:	83 c4 10             	add    $0x10,%esp
}
 564:	8d 65 f8             	lea    -0x8(%ebp),%esp
 567:	89 f0                	mov    %esi,%eax
 569:	5b                   	pop    %ebx
 56a:	5e                   	pop    %esi
 56b:	5d                   	pop    %ebp
 56c:	c3                   	ret
 56d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 570:	be ff ff ff ff       	mov    $0xffffffff,%esi
 575:	eb ed                	jmp    564 <stat+0x34>
 577:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 57e:	00 
 57f:	90                   	nop

00000580 <atoi>:

int
atoi(const char *s)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	53                   	push   %ebx
 584:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 587:	0f be 02             	movsbl (%edx),%eax
 58a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 58d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 590:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 595:	77 1e                	ja     5b5 <atoi+0x35>
 597:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 59e:	00 
 59f:	90                   	nop
    n = n*10 + *s++ - '0';
 5a0:	83 c2 01             	add    $0x1,%edx
 5a3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 5a6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 5aa:	0f be 02             	movsbl (%edx),%eax
 5ad:	8d 58 d0             	lea    -0x30(%eax),%ebx
 5b0:	80 fb 09             	cmp    $0x9,%bl
 5b3:	76 eb                	jbe    5a0 <atoi+0x20>
  return n;
}
 5b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5b8:	89 c8                	mov    %ecx,%eax
 5ba:	c9                   	leave
 5bb:	c3                   	ret
 5bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000005c0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	57                   	push   %edi
 5c4:	8b 45 10             	mov    0x10(%ebp),%eax
 5c7:	8b 55 08             	mov    0x8(%ebp),%edx
 5ca:	56                   	push   %esi
 5cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5ce:	85 c0                	test   %eax,%eax
 5d0:	7e 13                	jle    5e5 <memmove+0x25>
 5d2:	01 d0                	add    %edx,%eax
  dst = vdst;
 5d4:	89 d7                	mov    %edx,%edi
 5d6:	66 90                	xchg   %ax,%ax
 5d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5df:	00 
    *dst++ = *src++;
 5e0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 5e1:	39 f8                	cmp    %edi,%eax
 5e3:	75 fb                	jne    5e0 <memmove+0x20>
  return vdst;
}
 5e5:	5e                   	pop    %esi
 5e6:	89 d0                	mov    %edx,%eax
 5e8:	5f                   	pop    %edi
 5e9:	5d                   	pop    %ebp
 5ea:	c3                   	ret

000005eb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5eb:	b8 01 00 00 00       	mov    $0x1,%eax
 5f0:	cd 40                	int    $0x40
 5f2:	c3                   	ret

000005f3 <exit>:
SYSCALL(exit)
 5f3:	b8 02 00 00 00       	mov    $0x2,%eax
 5f8:	cd 40                	int    $0x40
 5fa:	c3                   	ret

000005fb <wait>:
SYSCALL(wait)
 5fb:	b8 03 00 00 00       	mov    $0x3,%eax
 600:	cd 40                	int    $0x40
 602:	c3                   	ret

00000603 <pipe>:
SYSCALL(pipe)
 603:	b8 04 00 00 00       	mov    $0x4,%eax
 608:	cd 40                	int    $0x40
 60a:	c3                   	ret

0000060b <read>:
SYSCALL(read)
 60b:	b8 05 00 00 00       	mov    $0x5,%eax
 610:	cd 40                	int    $0x40
 612:	c3                   	ret

00000613 <write>:
SYSCALL(write)
 613:	b8 10 00 00 00       	mov    $0x10,%eax
 618:	cd 40                	int    $0x40
 61a:	c3                   	ret

0000061b <close>:
SYSCALL(close)
 61b:	b8 15 00 00 00       	mov    $0x15,%eax
 620:	cd 40                	int    $0x40
 622:	c3                   	ret

00000623 <kill>:
SYSCALL(kill)
 623:	b8 06 00 00 00       	mov    $0x6,%eax
 628:	cd 40                	int    $0x40
 62a:	c3                   	ret

0000062b <exec>:
SYSCALL(exec)
 62b:	b8 07 00 00 00       	mov    $0x7,%eax
 630:	cd 40                	int    $0x40
 632:	c3                   	ret

00000633 <open>:
SYSCALL(open)
 633:	b8 0f 00 00 00       	mov    $0xf,%eax
 638:	cd 40                	int    $0x40
 63a:	c3                   	ret

0000063b <mknod>:
SYSCALL(mknod)
 63b:	b8 11 00 00 00       	mov    $0x11,%eax
 640:	cd 40                	int    $0x40
 642:	c3                   	ret

00000643 <unlink>:
SYSCALL(unlink)
 643:	b8 12 00 00 00       	mov    $0x12,%eax
 648:	cd 40                	int    $0x40
 64a:	c3                   	ret

0000064b <fstat>:
SYSCALL(fstat)
 64b:	b8 08 00 00 00       	mov    $0x8,%eax
 650:	cd 40                	int    $0x40
 652:	c3                   	ret

00000653 <link>:
SYSCALL(link)
 653:	b8 13 00 00 00       	mov    $0x13,%eax
 658:	cd 40                	int    $0x40
 65a:	c3                   	ret

0000065b <mkdir>:
SYSCALL(mkdir)
 65b:	b8 14 00 00 00       	mov    $0x14,%eax
 660:	cd 40                	int    $0x40
 662:	c3                   	ret

00000663 <chdir>:
SYSCALL(chdir)
 663:	b8 09 00 00 00       	mov    $0x9,%eax
 668:	cd 40                	int    $0x40
 66a:	c3                   	ret

0000066b <dup>:
SYSCALL(dup)
 66b:	b8 0a 00 00 00       	mov    $0xa,%eax
 670:	cd 40                	int    $0x40
 672:	c3                   	ret

00000673 <getpid>:
SYSCALL(getpid)
 673:	b8 0b 00 00 00       	mov    $0xb,%eax
 678:	cd 40                	int    $0x40
 67a:	c3                   	ret

0000067b <sbrk>:
SYSCALL(sbrk)
 67b:	b8 0c 00 00 00       	mov    $0xc,%eax
 680:	cd 40                	int    $0x40
 682:	c3                   	ret

00000683 <sleep>:
SYSCALL(sleep)
 683:	b8 0d 00 00 00       	mov    $0xd,%eax
 688:	cd 40                	int    $0x40
 68a:	c3                   	ret

0000068b <uptime>:
SYSCALL(uptime)
 68b:	b8 0e 00 00 00       	mov    $0xe,%eax
 690:	cd 40                	int    $0x40
 692:	c3                   	ret

00000693 <bstat>:
SYSCALL(bstat)
 693:	b8 16 00 00 00       	mov    $0x16,%eax
 698:	cd 40                	int    $0x40
 69a:	c3                   	ret

0000069b <swap>:
SYSCALL(swap)
 69b:	b8 17 00 00 00       	mov    $0x17,%eax
 6a0:	cd 40                	int    $0x40
 6a2:	c3                   	ret

000006a3 <gettime>:
SYSCALL(gettime)
 6a3:	b8 18 00 00 00       	mov    $0x18,%eax
 6a8:	cd 40                	int    $0x40
 6aa:	c3                   	ret

000006ab <setcursor>:
SYSCALL(setcursor)
 6ab:	b8 19 00 00 00       	mov    $0x19,%eax
 6b0:	cd 40                	int    $0x40
 6b2:	c3                   	ret

000006b3 <uname>:
SYSCALL(uname)
 6b3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 6b8:	cd 40                	int    $0x40
 6ba:	c3                   	ret

000006bb <echo>:
SYSCALL(echo)
 6bb:	b8 1b 00 00 00       	mov    $0x1b,%eax
 6c0:	cd 40                	int    $0x40
 6c2:	c3                   	ret
 6c3:	66 90                	xchg   %ax,%ax
 6c5:	66 90                	xchg   %ax,%ax
 6c7:	66 90                	xchg   %ax,%ax
 6c9:	66 90                	xchg   %ax,%ax
 6cb:	66 90                	xchg   %ax,%ax
 6cd:	66 90                	xchg   %ax,%ax
 6cf:	66 90                	xchg   %ax,%ax
 6d1:	66 90                	xchg   %ax,%ax
 6d3:	66 90                	xchg   %ax,%ax
 6d5:	66 90                	xchg   %ax,%ax
 6d7:	66 90                	xchg   %ax,%ax
 6d9:	66 90                	xchg   %ax,%ax
 6db:	66 90                	xchg   %ax,%ax
 6dd:	66 90                	xchg   %ax,%ax
 6df:	90                   	nop

000006e0 <printint.constprop.0>:
{
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn, int width, char pad_char)
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	57                   	push   %edi
 6e4:	56                   	push   %esi
 6e5:	89 c6                	mov    %eax,%esi
 6e7:	53                   	push   %ebx
 6e8:	89 d3                	mov    %edx,%ebx
 6ea:	83 ec 3c             	sub    $0x3c,%esp
 6ed:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6f1:	85 f6                	test   %esi,%esi
 6f3:	0f 89 d7 00 00 00    	jns    7d0 <printint.constprop.0+0xf0>
 6f9:	83 e1 01             	and    $0x1,%ecx
 6fc:	0f 84 ce 00 00 00    	je     7d0 <printint.constprop.0+0xf0>
    neg = 1;
 702:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 709:	f7 de                	neg    %esi
 70b:	89 f1                	mov    %esi,%ecx
  } else {
    x = xx;
  }

  i = 0;
 70d:	88 45 bf             	mov    %al,-0x41(%ebp)
 710:	31 ff                	xor    %edi,%edi
 712:	8d 75 d7             	lea    -0x29(%ebp),%esi
 715:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 71c:	00 
 71d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 720:	89 c8                	mov    %ecx,%eax
 722:	31 d2                	xor    %edx,%edx
 724:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 727:	83 c7 01             	add    $0x1,%edi
 72a:	f7 f3                	div    %ebx
 72c:	0f b6 92 bc 11 00 00 	movzbl 0x11bc(%edx),%edx
 733:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 736:	89 ca                	mov    %ecx,%edx
 738:	89 c1                	mov    %eax,%ecx
 73a:	39 da                	cmp    %ebx,%edx
 73c:	73 e2                	jae    720 <printint.constprop.0+0x40>

  if(neg)
 73e:	8b 55 c0             	mov    -0x40(%ebp),%edx
 741:	0f b6 45 bf          	movzbl -0x41(%ebp),%eax
 745:	85 d2                	test   %edx,%edx
 747:	74 0b                	je     754 <printint.constprop.0+0x74>
    buf[i++] = '-';
 749:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
 74c:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 751:	8d 79 02             	lea    0x2(%ecx),%edi

  // Pad with pad_char until we hit the required width
  while(i < width)
 754:	39 7d 08             	cmp    %edi,0x8(%ebp)
 757:	0f 8e 83 00 00 00    	jle    7e0 <printint.constprop.0+0x100>
 75d:	8b 55 08             	mov    0x8(%ebp),%edx
 760:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 763:	01 df                	add    %ebx,%edi
 765:	01 da                	add    %ebx,%edx
 767:	89 d1                	mov    %edx,%ecx
 769:	29 f9                	sub    %edi,%ecx
 76b:	83 e1 01             	and    $0x1,%ecx
 76e:	74 10                	je     780 <printint.constprop.0+0xa0>
    buf[i++] = pad_char;
 770:	88 07                	mov    %al,(%edi)
  while(i < width)
 772:	83 c7 01             	add    $0x1,%edi
 775:	39 d7                	cmp    %edx,%edi
 777:	74 13                	je     78c <printint.constprop.0+0xac>
 779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = pad_char;
 780:	88 07                	mov    %al,(%edi)
  while(i < width)
 782:	83 c7 02             	add    $0x2,%edi
    buf[i++] = pad_char;
 785:	88 47 ff             	mov    %al,-0x1(%edi)
  while(i < width)
 788:	39 d7                	cmp    %edx,%edi
 78a:	75 f4                	jne    780 <printint.constprop.0+0xa0>
 78c:	8b 45 08             	mov    0x8(%ebp),%eax
 78f:	8d 78 ff             	lea    -0x1(%eax),%edi

  while(--i >= 0)
 792:	01 df                	add    %ebx,%edi
 794:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 79b:	00 
 79c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 7a0:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 7a3:	83 ec 04             	sub    $0x4,%esp
 7a6:	88 45 d7             	mov    %al,-0x29(%ebp)
 7a9:	6a 01                	push   $0x1
 7ab:	56                   	push   %esi
 7ac:	6a 01                	push   $0x1
 7ae:	e8 60 fe ff ff       	call   613 <write>
  while(--i >= 0)
 7b3:	89 f8                	mov    %edi,%eax
 7b5:	83 c4 10             	add    $0x10,%esp
 7b8:	83 ef 01             	sub    $0x1,%edi
 7bb:	39 d8                	cmp    %ebx,%eax
 7bd:	75 e1                	jne    7a0 <printint.constprop.0+0xc0>
}
 7bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7c2:	5b                   	pop    %ebx
 7c3:	5e                   	pop    %esi
 7c4:	5f                   	pop    %edi
 7c5:	5d                   	pop    %ebp
 7c6:	c3                   	ret
 7c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7ce:	00 
 7cf:	90                   	nop
  neg = 0;
 7d0:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = xx;
 7d7:	89 f1                	mov    %esi,%ecx
 7d9:	e9 2f ff ff ff       	jmp    70d <printint.constprop.0+0x2d>
 7de:	66 90                	xchg   %ax,%ax
  while(--i >= 0)
 7e0:	83 ef 01             	sub    $0x1,%edi
 7e3:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 7e6:	eb aa                	jmp    792 <printint.constprop.0+0xb2>
 7e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7ef:	00 

000007f0 <strncpy>:
{
 7f0:	55                   	push   %ebp
 7f1:	31 c0                	xor    %eax,%eax
 7f3:	89 e5                	mov    %esp,%ebp
 7f5:	56                   	push   %esi
 7f6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 7f9:	8b 75 0c             	mov    0xc(%ebp),%esi
 7fc:	53                   	push   %ebx
 7fd:	8b 5d 10             	mov    0x10(%ebp),%ebx
  for (i = 0; i < n && src[i]; i++)
 800:	85 db                	test   %ebx,%ebx
 802:	7f 26                	jg     82a <strncpy+0x3a>
 804:	eb 58                	jmp    85e <strncpy+0x6e>
 806:	eb 18                	jmp    820 <strncpy+0x30>
 808:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 80f:	00 
 810:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 817:	00 
 818:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 81f:	00 
    dest[i] = src[i];
 820:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  for (i = 0; i < n && src[i]; i++)
 823:	83 c0 01             	add    $0x1,%eax
 826:	39 c3                	cmp    %eax,%ebx
 828:	74 34                	je     85e <strncpy+0x6e>
 82a:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
 82e:	84 d2                	test   %dl,%dl
 830:	75 ee                	jne    820 <strncpy+0x30>
  for (; i < n; i++)
 832:	39 c3                	cmp    %eax,%ebx
 834:	7e 28                	jle    85e <strncpy+0x6e>
 836:	01 c8                	add    %ecx,%eax
 838:	01 d9                	add    %ebx,%ecx
 83a:	89 ca                	mov    %ecx,%edx
 83c:	29 c2                	sub    %eax,%edx
 83e:	83 e2 01             	and    $0x1,%edx
 841:	74 0d                	je     850 <strncpy+0x60>
    dest[i] = '\0';
 843:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
 846:	83 c0 01             	add    $0x1,%eax
 849:	39 c8                	cmp    %ecx,%eax
 84b:	74 11                	je     85e <strncpy+0x6e>
 84d:	8d 76 00             	lea    0x0(%esi),%esi
    dest[i] = '\0';
 850:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
 853:	83 c0 02             	add    $0x2,%eax
    dest[i] = '\0';
 856:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  for (; i < n; i++)
 85a:	39 c8                	cmp    %ecx,%eax
 85c:	75 f2                	jne    850 <strncpy+0x60>
}
 85e:	5b                   	pop    %ebx
 85f:	5e                   	pop    %esi
 860:	5d                   	pop    %ebp
 861:	c3                   	ret
 862:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 869:	00 
 86a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000870 <printf>:

void
printf(char *fmt, ...)
{
 870:	55                   	push   %ebp
 871:	89 e5                	mov    %esp,%ebp
 873:	57                   	push   %edi
 874:	56                   	push   %esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 875:	8d 75 0c             	lea    0xc(%ebp),%esi
{
 878:	53                   	push   %ebx
 879:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  for(i = 0; fmt[i]; i++){
 87c:	8b 55 08             	mov    0x8(%ebp),%edx
  ap = (uint*)(void*)&fmt + 1;
 87f:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 882:	0f b6 02             	movzbl (%edx),%eax
 885:	84 c0                	test   %al,%al
 887:	0f 84 88 00 00 00    	je     915 <printf+0xa5>
 88d:	8d 7a 01             	lea    0x1(%edx),%edi
    c = fmt[i] & 0xff;
 890:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
      if (c == '\f') {
 893:	83 fa 0c             	cmp    $0xc,%edx
 896:	0f 84 d4 01 00 00    	je     a70 <printf+0x200>
        setcursor();
      } else if(c == '%'){
 89c:	83 fa 25             	cmp    $0x25,%edx
 89f:	0f 85 0b 02 00 00    	jne    ab0 <printf+0x240>
  for(i = 0; fmt[i]; i++){
 8a5:	0f b6 1f             	movzbl (%edi),%ebx
 8a8:	83 c7 01             	add    $0x1,%edi
 8ab:	84 db                	test   %bl,%bl
 8ad:	74 66                	je     915 <printf+0xa5>
    c = fmt[i] & 0xff;
 8af:	0f b6 c3             	movzbl %bl,%eax
 8b2:	ba 20 00 00 00       	mov    $0x20,%edx
 8b7:	31 c9                	xor    %ecx,%ecx
        pad_char = ' ';
      } else {
        putc(1, c);
      }
    } else if(state == '%'){
      if(c == '0'){
 8b9:	83 f8 78             	cmp    $0x78,%eax
 8bc:	7f 22                	jg     8e0 <printf+0x70>
 8be:	83 f8 62             	cmp    $0x62,%eax
 8c1:	0f 8e b9 01 00 00    	jle    a80 <printf+0x210>
 8c7:	83 e8 63             	sub    $0x63,%eax
 8ca:	83 f8 15             	cmp    $0x15,%eax
 8cd:	77 11                	ja     8e0 <printf+0x70>
 8cf:	ff 24 85 0c 11 00 00 	jmp    *0x110c(,%eax,4)
 8d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8dd:	00 
 8de:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 8e0:	83 ec 04             	sub    $0x4,%esp
 8e3:	8d 75 e7             	lea    -0x19(%ebp),%esi
 8e6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 8ea:	6a 01                	push   $0x1
 8ec:	56                   	push   %esi
 8ed:	6a 01                	push   $0x1
 8ef:	e8 1f fd ff ff       	call   613 <write>
 8f4:	83 c4 0c             	add    $0xc,%esp
 8f7:	88 5d e7             	mov    %bl,-0x19(%ebp)
 8fa:	6a 01                	push   $0x1
 8fc:	56                   	push   %esi
 8fd:	6a 01                	push   $0x1
 8ff:	e8 0f fd ff ff       	call   613 <write>
      } else if(c == '%'){
        putc(1, '%');
        state = 0;
      } else {
        putc(1, '%');
        putc(1, c);
 904:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 907:	0f b6 07             	movzbl (%edi),%eax
 90a:	83 c7 01             	add    $0x1,%edi
 90d:	84 c0                	test   %al,%al
 90f:	0f 85 7b ff ff ff    	jne    890 <printf+0x20>
        state = 0;
      }
    }
  }
}
 915:	8d 65 f4             	lea    -0xc(%ebp),%esp
 918:	5b                   	pop    %ebx
 919:	5e                   	pop    %esi
 91a:	5f                   	pop    %edi
 91b:	5d                   	pop    %ebp
 91c:	c3                   	ret
 91d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 16, 0, width, pad_char);
 920:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 923:	83 ec 08             	sub    $0x8,%esp
 926:	8b 06                	mov    (%esi),%eax
 928:	52                   	push   %edx
 929:	ba 10 00 00 00       	mov    $0x10,%edx
 92e:	51                   	push   %ecx
 92f:	31 c9                	xor    %ecx,%ecx
        printint(1, *ap, 10, 1, width, pad_char);
 931:	e8 aa fd ff ff       	call   6e0 <printint.constprop.0>
        ap++;
 936:	83 c6 04             	add    $0x4,%esi
 939:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 93c:	0f b6 07             	movzbl (%edi),%eax
 93f:	83 c7 01             	add    $0x1,%edi
 942:	83 c4 10             	add    $0x10,%esp
 945:	84 c0                	test   %al,%al
 947:	0f 85 43 ff ff ff    	jne    890 <printf+0x20>
}
 94d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 950:	5b                   	pop    %ebx
 951:	5e                   	pop    %esi
 952:	5f                   	pop    %edi
 953:	5d                   	pop    %ebp
 954:	c3                   	ret
 955:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 10, 1, width, pad_char);
 958:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 95b:	83 ec 08             	sub    $0x8,%esp
 95e:	8b 06                	mov    (%esi),%eax
 960:	52                   	push   %edx
 961:	ba 0a 00 00 00       	mov    $0xa,%edx
 966:	51                   	push   %ecx
 967:	b9 01 00 00 00       	mov    $0x1,%ecx
 96c:	eb c3                	jmp    931 <printf+0xc1>
 96e:	66 90                	xchg   %ax,%ax
        s = (char*)*ap;
 970:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 973:	8b 06                	mov    (%esi),%eax
        ap++;
 975:	83 c6 04             	add    $0x4,%esi
 978:	89 75 d4             	mov    %esi,-0x2c(%ebp)
        if(s == 0)
 97b:	85 c0                	test   %eax,%eax
 97d:	0f 85 9d 01 00 00    	jne    b20 <printf+0x2b0>
 983:	c6 45 d0 28          	movb   $0x28,-0x30(%ebp)
          s = "(null)";
 987:	b8 40 10 00 00       	mov    $0x1040,%eax
        int len = 0;
 98c:	31 db                	xor    %ebx,%ebx
 98e:	66 90                	xchg   %ax,%ax
        for (char *t = s; *t; t++) len++;
 990:	83 c3 01             	add    $0x1,%ebx
 993:	80 3c 18 00          	cmpb   $0x0,(%eax,%ebx,1)
 997:	75 f7                	jne    990 <printf+0x120>
        for (int j = len; j < width; j++)
 999:	39 cb                	cmp    %ecx,%ebx
 99b:	0f 8d 9c 01 00 00    	jge    b3d <printf+0x2cd>
 9a1:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 9a4:	8d 75 e7             	lea    -0x19(%ebp),%esi
 9a7:	89 45 c8             	mov    %eax,-0x38(%ebp)
 9aa:	89 7d cc             	mov    %edi,-0x34(%ebp)
 9ad:	89 df                	mov    %ebx,%edi
 9af:	89 d3                	mov    %edx,%ebx
 9b1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 9b8:	00 
 9b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 9c0:	83 ec 04             	sub    $0x4,%esp
 9c3:	88 5d e7             	mov    %bl,-0x19(%ebp)
        for (int j = len; j < width; j++)
 9c6:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 9c9:	6a 01                	push   $0x1
 9cb:	56                   	push   %esi
 9cc:	6a 01                	push   $0x1
 9ce:	e8 40 fc ff ff       	call   613 <write>
        for (int j = len; j < width; j++)
 9d3:	8b 45 d0             	mov    -0x30(%ebp),%eax
 9d6:	83 c4 10             	add    $0x10,%esp
 9d9:	39 c7                	cmp    %eax,%edi
 9db:	7c e3                	jl     9c0 <printf+0x150>
        while(*s != 0){
 9dd:	8b 45 c8             	mov    -0x38(%ebp),%eax
 9e0:	8b 7d cc             	mov    -0x34(%ebp),%edi
 9e3:	0f b6 08             	movzbl (%eax),%ecx
 9e6:	88 4d d0             	mov    %cl,-0x30(%ebp)
 9e9:	84 c9                	test   %cl,%cl
 9eb:	0f 84 16 ff ff ff    	je     907 <printf+0x97>
 9f1:	89 c3                	mov    %eax,%ebx
 9f3:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 9f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 9fe:	00 
 9ff:	90                   	nop
  write(fd, &c, 1);
 a00:	83 ec 04             	sub    $0x4,%esp
 a03:	88 45 e7             	mov    %al,-0x19(%ebp)
          putc(1, *s++);
 a06:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 a09:	6a 01                	push   $0x1
 a0b:	56                   	push   %esi
 a0c:	6a 01                	push   $0x1
 a0e:	e8 00 fc ff ff       	call   613 <write>
        while(*s != 0){
 a13:	0f b6 03             	movzbl (%ebx),%eax
 a16:	83 c4 10             	add    $0x10,%esp
 a19:	84 c0                	test   %al,%al
 a1b:	75 e3                	jne    a00 <printf+0x190>
 a1d:	e9 e5 fe ff ff       	jmp    907 <printf+0x97>
 a22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        char ch = *ap++;
 a28:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 a2b:	83 ec 04             	sub    $0x4,%esp
 a2e:	8d 75 e7             	lea    -0x19(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 a31:	83 c7 01             	add    $0x1,%edi
        char ch = *ap++;
 a34:	8d 58 04             	lea    0x4(%eax),%ebx
 a37:	8b 00                	mov    (%eax),%eax
 a39:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 a3c:	6a 01                	push   $0x1
 a3e:	56                   	push   %esi
 a3f:	6a 01                	push   $0x1
 a41:	e8 cd fb ff ff       	call   613 <write>
  for(i = 0; fmt[i]; i++){
 a46:	0f b6 47 ff          	movzbl -0x1(%edi),%eax
 a4a:	83 c4 10             	add    $0x10,%esp
 a4d:	84 c0                	test   %al,%al
 a4f:	0f 84 c0 fe ff ff    	je     915 <printf+0xa5>
    c = fmt[i] & 0xff;
 a55:	0f b6 d0             	movzbl %al,%edx
        char ch = *ap++;
 a58:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      if (c == '\f') {
 a5b:	83 fa 0c             	cmp    $0xc,%edx
 a5e:	0f 85 38 fe ff ff    	jne    89c <printf+0x2c>
 a64:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a6b:	00 
 a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        setcursor();
 a70:	e8 36 fc ff ff       	call   6ab <setcursor>
 a75:	e9 8d fe ff ff       	jmp    907 <printf+0x97>
 a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 a80:	83 f8 30             	cmp    $0x30,%eax
 a83:	74 7b                	je     b00 <printf+0x290>
 a85:	7f 49                	jg     ad0 <printf+0x260>
 a87:	83 f8 25             	cmp    $0x25,%eax
 a8a:	0f 85 50 fe ff ff    	jne    8e0 <printf+0x70>
  write(fd, &c, 1);
 a90:	83 ec 04             	sub    $0x4,%esp
 a93:	8d 75 e7             	lea    -0x19(%ebp),%esi
 a96:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 a9a:	6a 01                	push   $0x1
 a9c:	56                   	push   %esi
 a9d:	6a 01                	push   $0x1
 a9f:	e8 6f fb ff ff       	call   613 <write>
        state = 0;
 aa4:	83 c4 10             	add    $0x10,%esp
 aa7:	e9 5b fe ff ff       	jmp    907 <printf+0x97>
 aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 ab0:	83 ec 04             	sub    $0x4,%esp
 ab3:	8d 75 e7             	lea    -0x19(%ebp),%esi
 ab6:	88 45 e7             	mov    %al,-0x19(%ebp)
 ab9:	6a 01                	push   $0x1
 abb:	56                   	push   %esi
 abc:	6a 01                	push   $0x1
 abe:	e8 50 fb ff ff       	call   613 <write>
  for(i = 0; fmt[i]; i++){
 ac3:	e9 74 fe ff ff       	jmp    93c <printf+0xcc>
 ac8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 acf:	00 
 ad0:	8d 70 cf             	lea    -0x31(%eax),%esi
 ad3:	83 fe 08             	cmp    $0x8,%esi
 ad6:	0f 87 04 fe ff ff    	ja     8e0 <printf+0x70>
 adc:	0f b6 1f             	movzbl (%edi),%ebx
        width = width * 10 + (c - '0');
 adf:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
  for(i = 0; fmt[i]; i++){
 ae2:	83 c7 01             	add    $0x1,%edi
        width = width * 10 + (c - '0');
 ae5:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  for(i = 0; fmt[i]; i++){
 ae9:	84 db                	test   %bl,%bl
 aeb:	0f 84 24 fe ff ff    	je     915 <printf+0xa5>
    c = fmt[i] & 0xff;
 af1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 af4:	e9 c0 fd ff ff       	jmp    8b9 <printf+0x49>
 af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 b00:	0f b6 1f             	movzbl (%edi),%ebx
 b03:	83 c7 01             	add    $0x1,%edi
 b06:	84 db                	test   %bl,%bl
 b08:	0f 84 07 fe ff ff    	je     915 <printf+0xa5>
    c = fmt[i] & 0xff;
 b0e:	0f b6 c3             	movzbl %bl,%eax
 b11:	ba 30 00 00 00       	mov    $0x30,%edx
 b16:	e9 9e fd ff ff       	jmp    8b9 <printf+0x49>
 b1b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        for (char *t = s; *t; t++) len++;
 b20:	0f b6 18             	movzbl (%eax),%ebx
 b23:	88 5d d0             	mov    %bl,-0x30(%ebp)
 b26:	84 db                	test   %bl,%bl
 b28:	0f 85 5e fe ff ff    	jne    98c <printf+0x11c>
        int len = 0;
 b2e:	31 db                	xor    %ebx,%ebx
        for (int j = len; j < width; j++)
 b30:	85 c9                	test   %ecx,%ecx
 b32:	0f 8f 69 fe ff ff    	jg     9a1 <printf+0x131>
 b38:	e9 ca fd ff ff       	jmp    907 <printf+0x97>
 b3d:	89 c2                	mov    %eax,%edx
 b3f:	8d 75 e7             	lea    -0x19(%ebp),%esi
 b42:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 b46:	89 d3                	mov    %edx,%ebx
 b48:	e9 b3 fe ff ff       	jmp    a00 <printf+0x190>
 b4d:	8d 76 00             	lea    0x0(%esi),%esi

00000b50 <fprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
fprintf(int fd, char *fmt, ...)
{
 b50:	55                   	push   %ebp
 b51:	89 e5                	mov    %esp,%ebp
 b53:	57                   	push   %edi
 b54:	56                   	push   %esi
 b55:	53                   	push   %ebx
 b56:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 b59:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 b5c:	0f b6 13             	movzbl (%ebx),%edx
 b5f:	83 c3 01             	add    $0x1,%ebx
 b62:	84 d2                	test   %dl,%dl
 b64:	0f 84 81 00 00 00    	je     beb <fprintf+0x9b>
 b6a:	8d 75 10             	lea    0x10(%ebp),%esi
 b6d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 b70:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if (c == '\f') { // Detect formfeed character
 b73:	83 f8 0c             	cmp    $0xc,%eax
 b76:	0f 84 04 01 00 00    	je     c80 <fprintf+0x130>
        setcursor();
      } else
      if(c == '%'){
 b7c:	83 f8 25             	cmp    $0x25,%eax
 b7f:	0f 85 5b 01 00 00    	jne    ce0 <fprintf+0x190>
  for(i = 0; fmt[i]; i++){
 b85:	0f b6 13             	movzbl (%ebx),%edx
 b88:	84 d2                	test   %dl,%dl
 b8a:	74 5f                	je     beb <fprintf+0x9b>
    c = fmt[i] & 0xff;
 b8c:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 b8f:	80 fa 25             	cmp    $0x25,%dl
 b92:	0f 84 78 01 00 00    	je     d10 <fprintf+0x1c0>
 b98:	83 e8 63             	sub    $0x63,%eax
 b9b:	83 f8 15             	cmp    $0x15,%eax
 b9e:	77 10                	ja     bb0 <fprintf+0x60>
 ba0:	ff 24 85 64 11 00 00 	jmp    *0x1164(,%eax,4)
 ba7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 bae:	00 
 baf:	90                   	nop
  write(fd, &c, 1);
 bb0:	83 ec 04             	sub    $0x4,%esp
 bb3:	8d 7d e7             	lea    -0x19(%ebp),%edi
 bb6:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 bb9:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 bbd:	6a 01                	push   $0x1
 bbf:	57                   	push   %edi
 bc0:	ff 75 08             	push   0x8(%ebp)
 bc3:	e8 4b fa ff ff       	call   613 <write>
        putc(fd, c);
 bc8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 bcc:	83 c4 0c             	add    $0xc,%esp
 bcf:	88 55 e7             	mov    %dl,-0x19(%ebp)
 bd2:	6a 01                	push   $0x1
 bd4:	57                   	push   %edi
 bd5:	ff 75 08             	push   0x8(%ebp)
 bd8:	e8 36 fa ff ff       	call   613 <write>
  for(i = 0; fmt[i]; i++){
 bdd:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 be1:	83 c3 02             	add    $0x2,%ebx
 be4:	83 c4 10             	add    $0x10,%esp
 be7:	84 d2                	test   %dl,%dl
 be9:	75 85                	jne    b70 <fprintf+0x20>
      }
      state = 0;
    }
  }
}
 beb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 bee:	5b                   	pop    %ebx
 bef:	5e                   	pop    %esi
 bf0:	5f                   	pop    %edi
 bf1:	5d                   	pop    %ebp
 bf2:	c3                   	ret
 bf3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(1, *ap, 16, 0, width, pad_char);
 bf8:	83 ec 08             	sub    $0x8,%esp
 bfb:	8b 06                	mov    (%esi),%eax
 bfd:	31 c9                	xor    %ecx,%ecx
 bff:	ba 10 00 00 00       	mov    $0x10,%edx
 c04:	6a 20                	push   $0x20
 c06:	6a 00                	push   $0x0
 c08:	e8 d3 fa ff ff       	call   6e0 <printint.constprop.0>
        ap++;
 c0d:	83 c6 04             	add    $0x4,%esi
  for(i = 0; fmt[i]; i++){
 c10:	eb cb                	jmp    bdd <fprintf+0x8d>
 c12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s = (char*)*ap;
 c18:	8b 3e                	mov    (%esi),%edi
        ap++;
 c1a:	83 c6 04             	add    $0x4,%esi
        if(s == 0)
 c1d:	85 ff                	test   %edi,%edi
 c1f:	0f 84 fb 00 00 00    	je     d20 <fprintf+0x1d0>
        while(*s != 0){
 c25:	0f b6 07             	movzbl (%edi),%eax
 c28:	84 c0                	test   %al,%al
 c2a:	74 36                	je     c62 <fprintf+0x112>
 c2c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 c2f:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 c32:	8b 75 08             	mov    0x8(%ebp),%esi
 c35:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 c38:	89 fb                	mov    %edi,%ebx
 c3a:	89 cf                	mov    %ecx,%edi
 c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 c40:	83 ec 04             	sub    $0x4,%esp
 c43:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 c46:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 c49:	6a 01                	push   $0x1
 c4b:	57                   	push   %edi
 c4c:	56                   	push   %esi
 c4d:	e8 c1 f9 ff ff       	call   613 <write>
        while(*s != 0){
 c52:	0f b6 03             	movzbl (%ebx),%eax
 c55:	83 c4 10             	add    $0x10,%esp
 c58:	84 c0                	test   %al,%al
 c5a:	75 e4                	jne    c40 <fprintf+0xf0>
 c5c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 c5f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 c62:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 c66:	83 c3 02             	add    $0x2,%ebx
 c69:	84 d2                	test   %dl,%dl
 c6b:	0f 84 7a ff ff ff    	je     beb <fprintf+0x9b>
    c = fmt[i] & 0xff;
 c71:	0f b6 c2             	movzbl %dl,%eax
      if (c == '\f') { // Detect formfeed character
 c74:	83 f8 0c             	cmp    $0xc,%eax
 c77:	0f 85 ff fe ff ff    	jne    b7c <fprintf+0x2c>
 c7d:	8d 76 00             	lea    0x0(%esi),%esi
        setcursor();
 c80:	e8 26 fa ff ff       	call   6ab <setcursor>
  for(i = 0; fmt[i]; i++){
 c85:	0f b6 13             	movzbl (%ebx),%edx
 c88:	83 c3 01             	add    $0x1,%ebx
 c8b:	84 d2                	test   %dl,%dl
 c8d:	0f 85 dd fe ff ff    	jne    b70 <fprintf+0x20>
 c93:	e9 53 ff ff ff       	jmp    beb <fprintf+0x9b>
 c98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 c9f:	00 
        printint(1, *ap, 10, 1, width, pad_char);
 ca0:	83 ec 08             	sub    $0x8,%esp
 ca3:	8b 06                	mov    (%esi),%eax
 ca5:	b9 01 00 00 00       	mov    $0x1,%ecx
 caa:	ba 0a 00 00 00       	mov    $0xa,%edx
 caf:	6a 20                	push   $0x20
 cb1:	6a 00                	push   $0x0
 cb3:	e9 50 ff ff ff       	jmp    c08 <fprintf+0xb8>
 cb8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 cbf:	00 
        putc(fd, *ap);
 cc0:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
 cc2:	83 ec 04             	sub    $0x4,%esp
 cc5:	8d 7d e7             	lea    -0x19(%ebp),%edi
        putc(fd, *ap);
 cc8:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 ccb:	6a 01                	push   $0x1
 ccd:	57                   	push   %edi
 cce:	ff 75 08             	push   0x8(%ebp)
 cd1:	e8 3d f9 ff ff       	call   613 <write>
 cd6:	e9 32 ff ff ff       	jmp    c0d <fprintf+0xbd>
 cdb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 ce0:	83 ec 04             	sub    $0x4,%esp
 ce3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 ce6:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 ce9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 cec:	6a 01                	push   $0x1
 cee:	50                   	push   %eax
 cef:	ff 75 08             	push   0x8(%ebp)
 cf2:	e8 1c f9 ff ff       	call   613 <write>
  for(i = 0; fmt[i]; i++){
 cf7:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 cfb:	83 c4 10             	add    $0x10,%esp
 cfe:	84 d2                	test   %dl,%dl
 d00:	0f 85 6a fe ff ff    	jne    b70 <fprintf+0x20>
}
 d06:	8d 65 f4             	lea    -0xc(%ebp),%esp
 d09:	5b                   	pop    %ebx
 d0a:	5e                   	pop    %esi
 d0b:	5f                   	pop    %edi
 d0c:	5d                   	pop    %ebp
 d0d:	c3                   	ret
 d0e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 d10:	83 ec 04             	sub    $0x4,%esp
 d13:	88 55 e7             	mov    %dl,-0x19(%ebp)
 d16:	8d 7d e7             	lea    -0x19(%ebp),%edi
 d19:	6a 01                	push   $0x1
 d1b:	e9 b4 fe ff ff       	jmp    bd4 <fprintf+0x84>
          s = "(null)";
 d20:	bf 40 10 00 00       	mov    $0x1040,%edi
 d25:	b8 28 00 00 00       	mov    $0x28,%eax
 d2a:	e9 fd fe ff ff       	jmp    c2c <fprintf+0xdc>
 d2f:	66 90                	xchg   %ax,%ax
 d31:	66 90                	xchg   %ax,%ax
 d33:	66 90                	xchg   %ax,%ax
 d35:	66 90                	xchg   %ax,%ax
 d37:	66 90                	xchg   %ax,%ax
 d39:	66 90                	xchg   %ax,%ax
 d3b:	66 90                	xchg   %ax,%ax
 d3d:	66 90                	xchg   %ax,%ax
 d3f:	90                   	nop

00000d40 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 d40:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d41:	a1 38 15 00 00       	mov    0x1538,%eax
{
 d46:	89 e5                	mov    %esp,%ebp
 d48:	57                   	push   %edi
 d49:	56                   	push   %esi
 d4a:	53                   	push   %ebx
 d4b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 d4e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d51:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 d58:	00 
 d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 d60:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d62:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d64:	39 ca                	cmp    %ecx,%edx
 d66:	73 30                	jae    d98 <free+0x58>
 d68:	39 c1                	cmp    %eax,%ecx
 d6a:	72 04                	jb     d70 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d6c:	39 c2                	cmp    %eax,%edx
 d6e:	72 f0                	jb     d60 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 d70:	8b 73 fc             	mov    -0x4(%ebx),%esi
 d73:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 d76:	39 f8                	cmp    %edi,%eax
 d78:	74 36                	je     db0 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 d7a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 d7d:	8b 42 04             	mov    0x4(%edx),%eax
 d80:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 d83:	39 f1                	cmp    %esi,%ecx
 d85:	74 40                	je     dc7 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 d87:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 d89:	5b                   	pop    %ebx
  freep = p;
 d8a:	89 15 38 15 00 00    	mov    %edx,0x1538
}
 d90:	5e                   	pop    %esi
 d91:	5f                   	pop    %edi
 d92:	5d                   	pop    %ebp
 d93:	c3                   	ret
 d94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d98:	39 c2                	cmp    %eax,%edx
 d9a:	72 c4                	jb     d60 <free+0x20>
 d9c:	39 c1                	cmp    %eax,%ecx
 d9e:	73 c0                	jae    d60 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 da0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 da3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 da6:	39 f8                	cmp    %edi,%eax
 da8:	75 d0                	jne    d7a <free+0x3a>
 daa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 db0:	03 70 04             	add    0x4(%eax),%esi
 db3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 db6:	8b 02                	mov    (%edx),%eax
 db8:	8b 00                	mov    (%eax),%eax
 dba:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 dbd:	8b 42 04             	mov    0x4(%edx),%eax
 dc0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 dc3:	39 f1                	cmp    %esi,%ecx
 dc5:	75 c0                	jne    d87 <free+0x47>
    p->s.size += bp->s.size;
 dc7:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 dca:	89 15 38 15 00 00    	mov    %edx,0x1538
    p->s.size += bp->s.size;
 dd0:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 dd3:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 dd6:	89 0a                	mov    %ecx,(%edx)
}
 dd8:	5b                   	pop    %ebx
 dd9:	5e                   	pop    %esi
 dda:	5f                   	pop    %edi
 ddb:	5d                   	pop    %ebp
 ddc:	c3                   	ret
 ddd:	8d 76 00             	lea    0x0(%esi),%esi

00000de0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 de0:	55                   	push   %ebp
 de1:	89 e5                	mov    %esp,%ebp
 de3:	57                   	push   %edi
 de4:	56                   	push   %esi
 de5:	53                   	push   %ebx
 de6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 de9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 dec:	8b 15 38 15 00 00    	mov    0x1538,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 df2:	8d 78 07             	lea    0x7(%eax),%edi
 df5:	c1 ef 03             	shr    $0x3,%edi
 df8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 dfb:	85 d2                	test   %edx,%edx
 dfd:	0f 84 8d 00 00 00    	je     e90 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e03:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 e05:	8b 48 04             	mov    0x4(%eax),%ecx
 e08:	39 f9                	cmp    %edi,%ecx
 e0a:	73 64                	jae    e70 <malloc+0x90>
  if(nu < 4096)
 e0c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 e11:	39 df                	cmp    %ebx,%edi
 e13:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 e16:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 e1d:	eb 0a                	jmp    e29 <malloc+0x49>
 e1f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e20:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 e22:	8b 48 04             	mov    0x4(%eax),%ecx
 e25:	39 f9                	cmp    %edi,%ecx
 e27:	73 47                	jae    e70 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 e29:	89 c2                	mov    %eax,%edx
 e2b:	39 05 38 15 00 00    	cmp    %eax,0x1538
 e31:	75 ed                	jne    e20 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 e33:	83 ec 0c             	sub    $0xc,%esp
 e36:	56                   	push   %esi
 e37:	e8 3f f8 ff ff       	call   67b <sbrk>
  if(p == (char*)-1)
 e3c:	83 c4 10             	add    $0x10,%esp
 e3f:	83 f8 ff             	cmp    $0xffffffff,%eax
 e42:	74 1c                	je     e60 <malloc+0x80>
  hp->s.size = nu;
 e44:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 e47:	83 ec 0c             	sub    $0xc,%esp
 e4a:	83 c0 08             	add    $0x8,%eax
 e4d:	50                   	push   %eax
 e4e:	e8 ed fe ff ff       	call   d40 <free>
  return freep;
 e53:	8b 15 38 15 00 00    	mov    0x1538,%edx
      if((p = morecore(nunits)) == 0)
 e59:	83 c4 10             	add    $0x10,%esp
 e5c:	85 d2                	test   %edx,%edx
 e5e:	75 c0                	jne    e20 <malloc+0x40>
        return 0;
  }
}
 e60:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 e63:	31 c0                	xor    %eax,%eax
}
 e65:	5b                   	pop    %ebx
 e66:	5e                   	pop    %esi
 e67:	5f                   	pop    %edi
 e68:	5d                   	pop    %ebp
 e69:	c3                   	ret
 e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 e70:	39 cf                	cmp    %ecx,%edi
 e72:	74 4c                	je     ec0 <malloc+0xe0>
        p->s.size -= nunits;
 e74:	29 f9                	sub    %edi,%ecx
 e76:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 e79:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 e7c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 e7f:	89 15 38 15 00 00    	mov    %edx,0x1538
}
 e85:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 e88:	83 c0 08             	add    $0x8,%eax
}
 e8b:	5b                   	pop    %ebx
 e8c:	5e                   	pop    %esi
 e8d:	5f                   	pop    %edi
 e8e:	5d                   	pop    %ebp
 e8f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 e90:	c7 05 38 15 00 00 3c 	movl   $0x153c,0x1538
 e97:	15 00 00 
    base.s.size = 0;
 e9a:	b8 3c 15 00 00       	mov    $0x153c,%eax
    base.s.ptr = freep = prevp = &base;
 e9f:	c7 05 3c 15 00 00 3c 	movl   $0x153c,0x153c
 ea6:	15 00 00 
    base.s.size = 0;
 ea9:	c7 05 40 15 00 00 00 	movl   $0x0,0x1540
 eb0:	00 00 00 
    if(p->s.size >= nunits){
 eb3:	e9 54 ff ff ff       	jmp    e0c <malloc+0x2c>
 eb8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 ebf:	00 
        prevp->s.ptr = p->s.ptr;
 ec0:	8b 08                	mov    (%eax),%ecx
 ec2:	89 0a                	mov    %ecx,(%edx)
 ec4:	eb b9                	jmp    e7f <malloc+0x9f>
