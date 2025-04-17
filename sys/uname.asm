
_uname:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
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
  11:	81 ec 78 01 00 00    	sub    $0x178,%esp
  17:	8b 31                	mov    (%ecx),%esi
  19:	8b 79 04             	mov    0x4(%ecx),%edi
  int option_r = 0;
  int option_v = 0;
  int option_m = 0;

  // Manual option parsing
  for (int i = 1; i < argc; i++) {
  1c:	83 fe 01             	cmp    $0x1,%esi
  1f:	0f 8e 6b 01 00 00    	jle    190 <main+0x190>
  int option_m = 0;
  25:	c7 85 8c fe ff ff 00 	movl   $0x0,-0x174(%ebp)
  2c:	00 00 00 
  for (int i = 1; i < argc; i++) {
  2f:	bb 01 00 00 00       	mov    $0x1,%ebx
  int option_v = 0;
  34:	c7 85 88 fe ff ff 00 	movl   $0x0,-0x178(%ebp)
  3b:	00 00 00 
  int option_r = 0;
  3e:	c7 85 94 fe ff ff 00 	movl   $0x0,-0x16c(%ebp)
  45:	00 00 00 
  int option_n = 0;
  48:	c7 85 80 fe ff ff 00 	movl   $0x0,-0x180(%ebp)
  4f:	00 00 00 
  int option_s = 0;
  52:	c7 85 84 fe ff ff 00 	movl   $0x0,-0x17c(%ebp)
  59:	00 00 00 
  int print_all = 0;
  5c:	c7 85 90 fe ff ff 00 	movl   $0x0,-0x170(%ebp)
  63:	00 00 00 
    if (argv[i][0] == '-') {
  66:	8b 04 9f             	mov    (%edi,%ebx,4),%eax
  69:	80 38 2d             	cmpb   $0x2d,(%eax)
  6c:	0f 85 0b 01 00 00    	jne    17d <main+0x17d>
      char *p = &argv[i][1];
      while (*p) {
  72:	0f be 50 01          	movsbl 0x1(%eax),%edx
      char *p = &argv[i][1];
  76:	8d 48 01             	lea    0x1(%eax),%ecx
      while (*p) {
  79:	84 d2                	test   %dl,%dl
  7b:	74 48                	je     c5 <main+0xc5>
  7d:	8d 76 00             	lea    0x0(%esi),%esi
        switch (*p) {
  80:	8d 42 9f             	lea    -0x61(%edx),%eax
  83:	3c 15                	cmp    $0x15,%al
  85:	77 11                	ja     98 <main+0x98>
  87:	0f b6 c0             	movzbl %al,%eax
  8a:	ff 24 85 54 0e 00 00 	jmp    *0xe54(,%eax,4)
  91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
          case 'n': option_n = 1; break;
          case 'r': option_r = 1; break;
          case 'v': option_v = 1; break;
          case 'm': option_m = 1; break;
          default:
            fprintf(2, "uname: invalid option '%c'\n", *p);
  98:	83 ec 04             	sub    $0x4,%esp
  9b:	52                   	push   %edx
  9c:	68 e8 0d 00 00       	push   $0xde8
  a1:	6a 02                	push   $0x2
  a3:	e8 c8 09 00 00       	call   a70 <fprintf>
            exit();
  a8:	e8 66 04 00 00       	call   513 <exit>
  ad:	8d 76 00             	lea    0x0(%esi),%esi
          case 'v': option_v = 1; break;
  b0:	c7 85 88 fe ff ff 01 	movl   $0x1,-0x178(%ebp)
  b7:	00 00 00 
      while (*p) {
  ba:	0f be 51 01          	movsbl 0x1(%ecx),%edx
        }
        p++;
  be:	83 c1 01             	add    $0x1,%ecx
      while (*p) {
  c1:	84 d2                	test   %dl,%dl
  c3:	75 bb                	jne    80 <main+0x80>
  for (int i = 1; i < argc; i++) {
  c5:	83 c3 01             	add    $0x1,%ebx
  c8:	39 de                	cmp    %ebx,%esi
  ca:	75 9a                	jne    66 <main+0x66>
      fprintf(2, "uname: extra operand '%s'\n", argv[i]);
      exit();
    }
  }

  if (uname(&name) < 0) {
  cc:	83 ec 0c             	sub    $0xc,%esp
  cf:	8d 9d a3 fe ff ff    	lea    -0x15d(%ebp),%ebx
  d5:	53                   	push   %ebx
  d6:	e8 f8 04 00 00       	call   5d3 <uname>
  db:	83 c4 10             	add    $0x10,%esp
  de:	85 c0                	test   %eax,%eax
  e0:	0f 88 c0 00 00 00    	js     1a6 <main+0x1a6>
    fprintf(2, "uname: system call failed\n");
    exit();
  }

  if (print_all) {
  e6:	83 bd 90 fe ff ff 00 	cmpl   $0x0,-0x170(%ebp)
  ed:	0f 84 09 01 00 00    	je     1fc <main+0x1fc>
    printf("%s %s %s %s %s\n", 
  f3:	50                   	push   %eax
  f4:	50                   	push   %eax
  f5:	8d 45 a7             	lea    -0x59(%ebp),%eax
  f8:	50                   	push   %eax
  f9:	8d 85 66 ff ff ff    	lea    -0x9a(%ebp),%eax
  ff:	50                   	push   %eax
 100:	8d 85 25 ff ff ff    	lea    -0xdb(%ebp),%eax
 106:	50                   	push   %eax
 107:	8d 85 e4 fe ff ff    	lea    -0x11c(%ebp),%eax
 10d:	50                   	push   %eax
 10e:	53                   	push   %ebx
 10f:	68 3a 0e 00 00       	push   $0xe3a
 114:	e8 77 06 00 00       	call   790 <printf>
 119:	83 c4 20             	add    $0x20,%esp
    if (!(option_s | option_n | option_r | option_v | option_m)) {
      printf("%s\n", name.sysname);
    }
  }

  exit();
 11c:	e8 f2 03 00 00       	call   513 <exit>
 121:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
          case 'r': option_r = 1; break;
 128:	c7 85 94 fe ff ff 01 	movl   $0x1,-0x16c(%ebp)
 12f:	00 00 00 
 132:	eb 86                	jmp    ba <main+0xba>
 134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          case 'm': option_m = 1; break;
 138:	c7 85 8c fe ff ff 01 	movl   $0x1,-0x174(%ebp)
 13f:	00 00 00 
 142:	e9 73 ff ff ff       	jmp    ba <main+0xba>
 147:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 14e:	00 
 14f:	90                   	nop
          case 'a': print_all = 1; break;
 150:	c7 85 90 fe ff ff 01 	movl   $0x1,-0x170(%ebp)
 157:	00 00 00 
 15a:	e9 5b ff ff ff       	jmp    ba <main+0xba>
        switch (*p) {
 15f:	c7 85 84 fe ff ff 01 	movl   $0x1,-0x17c(%ebp)
 166:	00 00 00 
 169:	e9 4c ff ff ff       	jmp    ba <main+0xba>
          case 'n': option_n = 1; break;
 16e:	c7 85 80 fe ff ff 01 	movl   $0x1,-0x180(%ebp)
 175:	00 00 00 
 178:	e9 3d ff ff ff       	jmp    ba <main+0xba>
      fprintf(2, "uname: extra operand '%s'\n", argv[i]);
 17d:	52                   	push   %edx
 17e:	50                   	push   %eax
 17f:	68 04 0e 00 00       	push   $0xe04
 184:	6a 02                	push   $0x2
 186:	e8 e5 08 00 00       	call   a70 <fprintf>
      exit();
 18b:	e8 83 03 00 00       	call   513 <exit>
  if (uname(&name) < 0) {
 190:	83 ec 0c             	sub    $0xc,%esp
 193:	8d 9d a3 fe ff ff    	lea    -0x15d(%ebp),%ebx
 199:	53                   	push   %ebx
 19a:	e8 34 04 00 00       	call   5d3 <uname>
 19f:	83 c4 10             	add    $0x10,%esp
 1a2:	85 c0                	test   %eax,%eax
 1a4:	79 13                	jns    1b9 <main+0x1b9>
    fprintf(2, "uname: system call failed\n");
 1a6:	50                   	push   %eax
 1a7:	50                   	push   %eax
 1a8:	68 1f 0e 00 00       	push   $0xe1f
 1ad:	6a 02                	push   $0x2
 1af:	e8 bc 08 00 00       	call   a70 <fprintf>
    exit();
 1b4:	e8 5a 03 00 00       	call   513 <exit>
  int option_n = 0;
 1b9:	31 c0                	xor    %eax,%eax
 1bb:	89 85 94 fe ff ff    	mov    %eax,-0x16c(%ebp)
  int option_s = 0;
 1c1:	89 85 80 fe ff ff    	mov    %eax,-0x180(%ebp)
 1c7:	89 85 84 fe ff ff    	mov    %eax,-0x17c(%ebp)
    if (!(option_s | option_n | option_r | option_v | option_m)) {
 1cd:	8b 85 80 fe ff ff    	mov    -0x180(%ebp),%eax
 1d3:	8b bd 94 fe ff ff    	mov    -0x16c(%ebp),%edi
 1d9:	09 f8                	or     %edi,%eax
 1db:	0b 85 84 fe ff ff    	or     -0x17c(%ebp),%eax
 1e1:	0f 85 35 ff ff ff    	jne    11c <main+0x11c>
      printf("%s\n", name.sysname);
 1e7:	52                   	push   %edx
 1e8:	52                   	push   %edx
 1e9:	53                   	push   %ebx
 1ea:	68 46 0e 00 00       	push   $0xe46
 1ef:	e8 9c 05 00 00       	call   790 <printf>
 1f4:	83 c4 10             	add    $0x10,%esp
 1f7:	e9 20 ff ff ff       	jmp    11c <main+0x11c>
    if (option_s) printf("%s\n", name.sysname);
 1fc:	83 bd 84 fe ff ff 00 	cmpl   $0x0,-0x17c(%ebp)
 203:	74 10                	je     215 <main+0x215>
 205:	50                   	push   %eax
 206:	50                   	push   %eax
 207:	53                   	push   %ebx
 208:	68 46 0e 00 00       	push   $0xe46
 20d:	e8 7e 05 00 00       	call   790 <printf>
 212:	83 c4 10             	add    $0x10,%esp
    if (option_n) printf("%s\n", name.nodename);
 215:	83 bd 80 fe ff ff 00 	cmpl   $0x0,-0x180(%ebp)
 21c:	74 16                	je     234 <main+0x234>
 21e:	8d 85 e4 fe ff ff    	lea    -0x11c(%ebp),%eax
 224:	57                   	push   %edi
 225:	57                   	push   %edi
 226:	50                   	push   %eax
 227:	68 46 0e 00 00       	push   $0xe46
 22c:	e8 5f 05 00 00       	call   790 <printf>
 231:	83 c4 10             	add    $0x10,%esp
    if (option_r) printf("%s\n", name.release);
 234:	83 bd 94 fe ff ff 00 	cmpl   $0x0,-0x16c(%ebp)
 23b:	74 16                	je     253 <main+0x253>
 23d:	8d 85 25 ff ff ff    	lea    -0xdb(%ebp),%eax
 243:	56                   	push   %esi
 244:	56                   	push   %esi
 245:	50                   	push   %eax
 246:	68 46 0e 00 00       	push   $0xe46
 24b:	e8 40 05 00 00       	call   790 <printf>
 250:	83 c4 10             	add    $0x10,%esp
    if (option_v) printf("%s\n", name.version);
 253:	83 bd 88 fe ff ff 00 	cmpl   $0x0,-0x178(%ebp)
 25a:	74 3b                	je     297 <main+0x297>
 25c:	8d 85 66 ff ff ff    	lea    -0x9a(%ebp),%eax
 262:	53                   	push   %ebx
 263:	53                   	push   %ebx
 264:	50                   	push   %eax
 265:	68 46 0e 00 00       	push   $0xe46
 26a:	e8 21 05 00 00       	call   790 <printf>
    if (option_m) printf("%s\n", name.machine);
 26f:	83 c4 10             	add    $0x10,%esp
 272:	83 bd 8c fe ff ff 00 	cmpl   $0x0,-0x174(%ebp)
 279:	0f 84 9d fe ff ff    	je     11c <main+0x11c>
 27f:	8d 45 a7             	lea    -0x59(%ebp),%eax
 282:	51                   	push   %ecx
 283:	51                   	push   %ecx
 284:	50                   	push   %eax
 285:	68 46 0e 00 00       	push   $0xe46
 28a:	e8 01 05 00 00       	call   790 <printf>
 28f:	83 c4 10             	add    $0x10,%esp
 292:	e9 85 fe ff ff       	jmp    11c <main+0x11c>
 297:	83 bd 8c fe ff ff 00 	cmpl   $0x0,-0x174(%ebp)
 29e:	0f 84 29 ff ff ff    	je     1cd <main+0x1cd>
 2a4:	eb d9                	jmp    27f <main+0x27f>
 2a6:	66 90                	xchg   %ax,%ax
 2a8:	66 90                	xchg   %ax,%ax
 2aa:	66 90                	xchg   %ax,%ax
 2ac:	66 90                	xchg   %ax,%ax
 2ae:	66 90                	xchg   %ax,%ax
 2b0:	66 90                	xchg   %ax,%ax
 2b2:	66 90                	xchg   %ax,%ax
 2b4:	66 90                	xchg   %ax,%ax
 2b6:	66 90                	xchg   %ax,%ax
 2b8:	66 90                	xchg   %ax,%ax
 2ba:	66 90                	xchg   %ax,%ax
 2bc:	66 90                	xchg   %ax,%ax
 2be:	66 90                	xchg   %ax,%ax

000002c0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 2c0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2c1:	31 c0                	xor    %eax,%eax
{
 2c3:	89 e5                	mov    %esp,%ebp
 2c5:	53                   	push   %ebx
 2c6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2c9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 2cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 2d0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 2d4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 2d7:	83 c0 01             	add    $0x1,%eax
 2da:	84 d2                	test   %dl,%dl
 2dc:	75 f2                	jne    2d0 <strcpy+0x10>
    ;
  return os;
}
 2de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2e1:	89 c8                	mov    %ecx,%eax
 2e3:	c9                   	leave
 2e4:	c3                   	ret
 2e5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ec:	00 
 2ed:	8d 76 00             	lea    0x0(%esi),%esi

000002f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	53                   	push   %ebx
 2f4:	8b 55 08             	mov    0x8(%ebp),%edx
 2f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 2fa:	0f b6 02             	movzbl (%edx),%eax
 2fd:	84 c0                	test   %al,%al
 2ff:	75 2f                	jne    330 <strcmp+0x40>
 301:	eb 4a                	jmp    34d <strcmp+0x5d>
 303:	eb 1b                	jmp    320 <strcmp+0x30>
 305:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 30c:	00 
 30d:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 314:	00 
 315:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 31c:	00 
 31d:	8d 76 00             	lea    0x0(%esi),%esi
 320:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 324:	83 c2 01             	add    $0x1,%edx
 327:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 32a:	84 c0                	test   %al,%al
 32c:	74 12                	je     340 <strcmp+0x50>
 32e:	89 d9                	mov    %ebx,%ecx
 330:	0f b6 19             	movzbl (%ecx),%ebx
 333:	38 c3                	cmp    %al,%bl
 335:	74 e9                	je     320 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 337:	29 d8                	sub    %ebx,%eax
}
 339:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 33c:	c9                   	leave
 33d:	c3                   	ret
 33e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 340:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 344:	31 c0                	xor    %eax,%eax
 346:	29 d8                	sub    %ebx,%eax
}
 348:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 34b:	c9                   	leave
 34c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 34d:	0f b6 19             	movzbl (%ecx),%ebx
 350:	31 c0                	xor    %eax,%eax
 352:	eb e3                	jmp    337 <strcmp+0x47>
 354:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 35b:	00 
 35c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000360 <strlen>:

uint
strlen(char *s)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 366:	80 3a 00             	cmpb   $0x0,(%edx)
 369:	74 15                	je     380 <strlen+0x20>
 36b:	31 c0                	xor    %eax,%eax
 36d:	8d 76 00             	lea    0x0(%esi),%esi
 370:	83 c0 01             	add    $0x1,%eax
 373:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 377:	89 c1                	mov    %eax,%ecx
 379:	75 f5                	jne    370 <strlen+0x10>
    ;
  return n;
}
 37b:	89 c8                	mov    %ecx,%eax
 37d:	5d                   	pop    %ebp
 37e:	c3                   	ret
 37f:	90                   	nop
  for(n = 0; s[n]; n++)
 380:	31 c9                	xor    %ecx,%ecx
}
 382:	5d                   	pop    %ebp
 383:	89 c8                	mov    %ecx,%eax
 385:	c3                   	ret
 386:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 38d:	00 
 38e:	66 90                	xchg   %ax,%ax

00000390 <memset>:

void*
memset(void *dst, int c, uint n)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 397:	8b 4d 10             	mov    0x10(%ebp),%ecx
 39a:	8b 45 0c             	mov    0xc(%ebp),%eax
 39d:	89 d7                	mov    %edx,%edi
 39f:	fc                   	cld
 3a0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3a2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 3a5:	89 d0                	mov    %edx,%eax
 3a7:	c9                   	leave
 3a8:	c3                   	ret
 3a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003b0 <strchr>:

char*
strchr(const char *s, char c)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	8b 45 08             	mov    0x8(%ebp),%eax
 3b6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 3ba:	0f b6 10             	movzbl (%eax),%edx
 3bd:	84 d2                	test   %dl,%dl
 3bf:	75 1a                	jne    3db <strchr+0x2b>
 3c1:	eb 25                	jmp    3e8 <strchr+0x38>
 3c3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3ca:	00 
 3cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 3d0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 3d4:	83 c0 01             	add    $0x1,%eax
 3d7:	84 d2                	test   %dl,%dl
 3d9:	74 0d                	je     3e8 <strchr+0x38>
    if(*s == c)
 3db:	38 d1                	cmp    %dl,%cl
 3dd:	75 f1                	jne    3d0 <strchr+0x20>
      return (char*)s;
  return 0;
}
 3df:	5d                   	pop    %ebp
 3e0:	c3                   	ret
 3e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 3e8:	31 c0                	xor    %eax,%eax
}
 3ea:	5d                   	pop    %ebp
 3eb:	c3                   	ret
 3ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003f0 <gets>:

char*
gets(char *buf, int max)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 3f5:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 3f8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 3f9:	31 db                	xor    %ebx,%ebx
{
 3fb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 3fe:	eb 27                	jmp    427 <gets+0x37>
    cc = read(0, &c, 1);
 400:	83 ec 04             	sub    $0x4,%esp
 403:	6a 01                	push   $0x1
 405:	56                   	push   %esi
 406:	6a 00                	push   $0x0
 408:	e8 1e 01 00 00       	call   52b <read>
    if(cc < 1)
 40d:	83 c4 10             	add    $0x10,%esp
 410:	85 c0                	test   %eax,%eax
 412:	7e 1d                	jle    431 <gets+0x41>
      break;
    buf[i++] = c;
 414:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 418:	8b 55 08             	mov    0x8(%ebp),%edx
 41b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 41f:	3c 0a                	cmp    $0xa,%al
 421:	74 10                	je     433 <gets+0x43>
 423:	3c 0d                	cmp    $0xd,%al
 425:	74 0c                	je     433 <gets+0x43>
  for(i=0; i+1 < max; ){
 427:	89 df                	mov    %ebx,%edi
 429:	83 c3 01             	add    $0x1,%ebx
 42c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 42f:	7c cf                	jl     400 <gets+0x10>
 431:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 433:	8b 45 08             	mov    0x8(%ebp),%eax
 436:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 43a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 43d:	5b                   	pop    %ebx
 43e:	5e                   	pop    %esi
 43f:	5f                   	pop    %edi
 440:	5d                   	pop    %ebp
 441:	c3                   	ret
 442:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 449:	00 
 44a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000450 <stat>:

int
stat(char *n, struct stat *st)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	56                   	push   %esi
 454:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 455:	83 ec 08             	sub    $0x8,%esp
 458:	6a 00                	push   $0x0
 45a:	ff 75 08             	push   0x8(%ebp)
 45d:	e8 f1 00 00 00       	call   553 <open>
  if(fd < 0)
 462:	83 c4 10             	add    $0x10,%esp
 465:	85 c0                	test   %eax,%eax
 467:	78 27                	js     490 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 469:	83 ec 08             	sub    $0x8,%esp
 46c:	ff 75 0c             	push   0xc(%ebp)
 46f:	89 c3                	mov    %eax,%ebx
 471:	50                   	push   %eax
 472:	e8 f4 00 00 00       	call   56b <fstat>
  close(fd);
 477:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 47a:	89 c6                	mov    %eax,%esi
  close(fd);
 47c:	e8 ba 00 00 00       	call   53b <close>
  return r;
 481:	83 c4 10             	add    $0x10,%esp
}
 484:	8d 65 f8             	lea    -0x8(%ebp),%esp
 487:	89 f0                	mov    %esi,%eax
 489:	5b                   	pop    %ebx
 48a:	5e                   	pop    %esi
 48b:	5d                   	pop    %ebp
 48c:	c3                   	ret
 48d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 490:	be ff ff ff ff       	mov    $0xffffffff,%esi
 495:	eb ed                	jmp    484 <stat+0x34>
 497:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 49e:	00 
 49f:	90                   	nop

000004a0 <atoi>:

int
atoi(const char *s)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	53                   	push   %ebx
 4a4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4a7:	0f be 02             	movsbl (%edx),%eax
 4aa:	8d 48 d0             	lea    -0x30(%eax),%ecx
 4ad:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 4b0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 4b5:	77 1e                	ja     4d5 <atoi+0x35>
 4b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4be:	00 
 4bf:	90                   	nop
    n = n*10 + *s++ - '0';
 4c0:	83 c2 01             	add    $0x1,%edx
 4c3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 4c6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 4ca:	0f be 02             	movsbl (%edx),%eax
 4cd:	8d 58 d0             	lea    -0x30(%eax),%ebx
 4d0:	80 fb 09             	cmp    $0x9,%bl
 4d3:	76 eb                	jbe    4c0 <atoi+0x20>
  return n;
}
 4d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4d8:	89 c8                	mov    %ecx,%eax
 4da:	c9                   	leave
 4db:	c3                   	ret
 4dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004e0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	8b 45 10             	mov    0x10(%ebp),%eax
 4e7:	8b 55 08             	mov    0x8(%ebp),%edx
 4ea:	56                   	push   %esi
 4eb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4ee:	85 c0                	test   %eax,%eax
 4f0:	7e 13                	jle    505 <memmove+0x25>
 4f2:	01 d0                	add    %edx,%eax
  dst = vdst;
 4f4:	89 d7                	mov    %edx,%edi
 4f6:	66 90                	xchg   %ax,%ax
 4f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4ff:	00 
    *dst++ = *src++;
 500:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 501:	39 f8                	cmp    %edi,%eax
 503:	75 fb                	jne    500 <memmove+0x20>
  return vdst;
}
 505:	5e                   	pop    %esi
 506:	89 d0                	mov    %edx,%eax
 508:	5f                   	pop    %edi
 509:	5d                   	pop    %ebp
 50a:	c3                   	ret

0000050b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 50b:	b8 01 00 00 00       	mov    $0x1,%eax
 510:	cd 40                	int    $0x40
 512:	c3                   	ret

00000513 <exit>:
SYSCALL(exit)
 513:	b8 02 00 00 00       	mov    $0x2,%eax
 518:	cd 40                	int    $0x40
 51a:	c3                   	ret

0000051b <wait>:
SYSCALL(wait)
 51b:	b8 03 00 00 00       	mov    $0x3,%eax
 520:	cd 40                	int    $0x40
 522:	c3                   	ret

00000523 <pipe>:
SYSCALL(pipe)
 523:	b8 04 00 00 00       	mov    $0x4,%eax
 528:	cd 40                	int    $0x40
 52a:	c3                   	ret

0000052b <read>:
SYSCALL(read)
 52b:	b8 05 00 00 00       	mov    $0x5,%eax
 530:	cd 40                	int    $0x40
 532:	c3                   	ret

00000533 <write>:
SYSCALL(write)
 533:	b8 10 00 00 00       	mov    $0x10,%eax
 538:	cd 40                	int    $0x40
 53a:	c3                   	ret

0000053b <close>:
SYSCALL(close)
 53b:	b8 15 00 00 00       	mov    $0x15,%eax
 540:	cd 40                	int    $0x40
 542:	c3                   	ret

00000543 <kill>:
SYSCALL(kill)
 543:	b8 06 00 00 00       	mov    $0x6,%eax
 548:	cd 40                	int    $0x40
 54a:	c3                   	ret

0000054b <exec>:
SYSCALL(exec)
 54b:	b8 07 00 00 00       	mov    $0x7,%eax
 550:	cd 40                	int    $0x40
 552:	c3                   	ret

00000553 <open>:
SYSCALL(open)
 553:	b8 0f 00 00 00       	mov    $0xf,%eax
 558:	cd 40                	int    $0x40
 55a:	c3                   	ret

0000055b <mknod>:
SYSCALL(mknod)
 55b:	b8 11 00 00 00       	mov    $0x11,%eax
 560:	cd 40                	int    $0x40
 562:	c3                   	ret

00000563 <unlink>:
SYSCALL(unlink)
 563:	b8 12 00 00 00       	mov    $0x12,%eax
 568:	cd 40                	int    $0x40
 56a:	c3                   	ret

0000056b <fstat>:
SYSCALL(fstat)
 56b:	b8 08 00 00 00       	mov    $0x8,%eax
 570:	cd 40                	int    $0x40
 572:	c3                   	ret

00000573 <link>:
SYSCALL(link)
 573:	b8 13 00 00 00       	mov    $0x13,%eax
 578:	cd 40                	int    $0x40
 57a:	c3                   	ret

0000057b <mkdir>:
SYSCALL(mkdir)
 57b:	b8 14 00 00 00       	mov    $0x14,%eax
 580:	cd 40                	int    $0x40
 582:	c3                   	ret

00000583 <chdir>:
SYSCALL(chdir)
 583:	b8 09 00 00 00       	mov    $0x9,%eax
 588:	cd 40                	int    $0x40
 58a:	c3                   	ret

0000058b <dup>:
SYSCALL(dup)
 58b:	b8 0a 00 00 00       	mov    $0xa,%eax
 590:	cd 40                	int    $0x40
 592:	c3                   	ret

00000593 <getpid>:
SYSCALL(getpid)
 593:	b8 0b 00 00 00       	mov    $0xb,%eax
 598:	cd 40                	int    $0x40
 59a:	c3                   	ret

0000059b <sbrk>:
SYSCALL(sbrk)
 59b:	b8 0c 00 00 00       	mov    $0xc,%eax
 5a0:	cd 40                	int    $0x40
 5a2:	c3                   	ret

000005a3 <sleep>:
SYSCALL(sleep)
 5a3:	b8 0d 00 00 00       	mov    $0xd,%eax
 5a8:	cd 40                	int    $0x40
 5aa:	c3                   	ret

000005ab <uptime>:
SYSCALL(uptime)
 5ab:	b8 0e 00 00 00       	mov    $0xe,%eax
 5b0:	cd 40                	int    $0x40
 5b2:	c3                   	ret

000005b3 <bstat>:
SYSCALL(bstat)
 5b3:	b8 16 00 00 00       	mov    $0x16,%eax
 5b8:	cd 40                	int    $0x40
 5ba:	c3                   	ret

000005bb <swap>:
SYSCALL(swap)
 5bb:	b8 17 00 00 00       	mov    $0x17,%eax
 5c0:	cd 40                	int    $0x40
 5c2:	c3                   	ret

000005c3 <gettime>:
SYSCALL(gettime)
 5c3:	b8 18 00 00 00       	mov    $0x18,%eax
 5c8:	cd 40                	int    $0x40
 5ca:	c3                   	ret

000005cb <setcursor>:
SYSCALL(setcursor)
 5cb:	b8 19 00 00 00       	mov    $0x19,%eax
 5d0:	cd 40                	int    $0x40
 5d2:	c3                   	ret

000005d3 <uname>:
SYSCALL(uname)
 5d3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 5d8:	cd 40                	int    $0x40
 5da:	c3                   	ret

000005db <echo>:
SYSCALL(echo)
 5db:	b8 1b 00 00 00       	mov    $0x1b,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret
 5e3:	66 90                	xchg   %ax,%ax
 5e5:	66 90                	xchg   %ax,%ax
 5e7:	66 90                	xchg   %ax,%ax
 5e9:	66 90                	xchg   %ax,%ax
 5eb:	66 90                	xchg   %ax,%ax
 5ed:	66 90                	xchg   %ax,%ax
 5ef:	66 90                	xchg   %ax,%ax
 5f1:	66 90                	xchg   %ax,%ax
 5f3:	66 90                	xchg   %ax,%ax
 5f5:	66 90                	xchg   %ax,%ax
 5f7:	66 90                	xchg   %ax,%ax
 5f9:	66 90                	xchg   %ax,%ax
 5fb:	66 90                	xchg   %ax,%ax
 5fd:	66 90                	xchg   %ax,%ax
 5ff:	90                   	nop

00000600 <printint.constprop.0>:
{
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn, int width, char pad_char)
 600:	55                   	push   %ebp
 601:	89 e5                	mov    %esp,%ebp
 603:	57                   	push   %edi
 604:	56                   	push   %esi
 605:	89 c6                	mov    %eax,%esi
 607:	53                   	push   %ebx
 608:	89 d3                	mov    %edx,%ebx
 60a:	83 ec 3c             	sub    $0x3c,%esp
 60d:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 611:	85 f6                	test   %esi,%esi
 613:	0f 89 d7 00 00 00    	jns    6f0 <printint.constprop.0+0xf0>
 619:	83 e1 01             	and    $0x1,%ecx
 61c:	0f 84 ce 00 00 00    	je     6f0 <printint.constprop.0+0xf0>
    neg = 1;
 622:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 629:	f7 de                	neg    %esi
 62b:	89 f1                	mov    %esi,%ecx
  } else {
    x = xx;
  }

  i = 0;
 62d:	88 45 bf             	mov    %al,-0x41(%ebp)
 630:	31 ff                	xor    %edi,%edi
 632:	8d 75 d7             	lea    -0x29(%ebp),%esi
 635:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 63c:	00 
 63d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 640:	89 c8                	mov    %ecx,%eax
 642:	31 d2                	xor    %edx,%edx
 644:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 647:	83 c7 01             	add    $0x1,%edi
 64a:	f7 f3                	div    %ebx
 64c:	0f b6 92 5c 0f 00 00 	movzbl 0xf5c(%edx),%edx
 653:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 656:	89 ca                	mov    %ecx,%edx
 658:	89 c1                	mov    %eax,%ecx
 65a:	39 da                	cmp    %ebx,%edx
 65c:	73 e2                	jae    640 <printint.constprop.0+0x40>

  if(neg)
 65e:	8b 55 c0             	mov    -0x40(%ebp),%edx
 661:	0f b6 45 bf          	movzbl -0x41(%ebp),%eax
 665:	85 d2                	test   %edx,%edx
 667:	74 0b                	je     674 <printint.constprop.0+0x74>
    buf[i++] = '-';
 669:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
 66c:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 671:	8d 79 02             	lea    0x2(%ecx),%edi

  // Pad with pad_char until we hit the required width
  while(i < width)
 674:	39 7d 08             	cmp    %edi,0x8(%ebp)
 677:	0f 8e 83 00 00 00    	jle    700 <printint.constprop.0+0x100>
 67d:	8b 55 08             	mov    0x8(%ebp),%edx
 680:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 683:	01 df                	add    %ebx,%edi
 685:	01 da                	add    %ebx,%edx
 687:	89 d1                	mov    %edx,%ecx
 689:	29 f9                	sub    %edi,%ecx
 68b:	83 e1 01             	and    $0x1,%ecx
 68e:	74 10                	je     6a0 <printint.constprop.0+0xa0>
    buf[i++] = pad_char;
 690:	88 07                	mov    %al,(%edi)
  while(i < width)
 692:	83 c7 01             	add    $0x1,%edi
 695:	39 d7                	cmp    %edx,%edi
 697:	74 13                	je     6ac <printint.constprop.0+0xac>
 699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = pad_char;
 6a0:	88 07                	mov    %al,(%edi)
  while(i < width)
 6a2:	83 c7 02             	add    $0x2,%edi
    buf[i++] = pad_char;
 6a5:	88 47 ff             	mov    %al,-0x1(%edi)
  while(i < width)
 6a8:	39 d7                	cmp    %edx,%edi
 6aa:	75 f4                	jne    6a0 <printint.constprop.0+0xa0>
 6ac:	8b 45 08             	mov    0x8(%ebp),%eax
 6af:	8d 78 ff             	lea    -0x1(%eax),%edi

  while(--i >= 0)
 6b2:	01 df                	add    %ebx,%edi
 6b4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6bb:	00 
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 6c0:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 6c3:	83 ec 04             	sub    $0x4,%esp
 6c6:	88 45 d7             	mov    %al,-0x29(%ebp)
 6c9:	6a 01                	push   $0x1
 6cb:	56                   	push   %esi
 6cc:	6a 01                	push   $0x1
 6ce:	e8 60 fe ff ff       	call   533 <write>
  while(--i >= 0)
 6d3:	89 f8                	mov    %edi,%eax
 6d5:	83 c4 10             	add    $0x10,%esp
 6d8:	83 ef 01             	sub    $0x1,%edi
 6db:	39 d8                	cmp    %ebx,%eax
 6dd:	75 e1                	jne    6c0 <printint.constprop.0+0xc0>
}
 6df:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6e2:	5b                   	pop    %ebx
 6e3:	5e                   	pop    %esi
 6e4:	5f                   	pop    %edi
 6e5:	5d                   	pop    %ebp
 6e6:	c3                   	ret
 6e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6ee:	00 
 6ef:	90                   	nop
  neg = 0;
 6f0:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = xx;
 6f7:	89 f1                	mov    %esi,%ecx
 6f9:	e9 2f ff ff ff       	jmp    62d <printint.constprop.0+0x2d>
 6fe:	66 90                	xchg   %ax,%ax
  while(--i >= 0)
 700:	83 ef 01             	sub    $0x1,%edi
 703:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 706:	eb aa                	jmp    6b2 <printint.constprop.0+0xb2>
 708:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 70f:	00 

00000710 <strncpy>:
{
 710:	55                   	push   %ebp
 711:	31 c0                	xor    %eax,%eax
 713:	89 e5                	mov    %esp,%ebp
 715:	56                   	push   %esi
 716:	8b 4d 08             	mov    0x8(%ebp),%ecx
 719:	8b 75 0c             	mov    0xc(%ebp),%esi
 71c:	53                   	push   %ebx
 71d:	8b 5d 10             	mov    0x10(%ebp),%ebx
  for (i = 0; i < n && src[i]; i++)
 720:	85 db                	test   %ebx,%ebx
 722:	7f 26                	jg     74a <strncpy+0x3a>
 724:	eb 58                	jmp    77e <strncpy+0x6e>
 726:	eb 18                	jmp    740 <strncpy+0x30>
 728:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 72f:	00 
 730:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 737:	00 
 738:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 73f:	00 
    dest[i] = src[i];
 740:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  for (i = 0; i < n && src[i]; i++)
 743:	83 c0 01             	add    $0x1,%eax
 746:	39 c3                	cmp    %eax,%ebx
 748:	74 34                	je     77e <strncpy+0x6e>
 74a:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
 74e:	84 d2                	test   %dl,%dl
 750:	75 ee                	jne    740 <strncpy+0x30>
  for (; i < n; i++)
 752:	39 c3                	cmp    %eax,%ebx
 754:	7e 28                	jle    77e <strncpy+0x6e>
 756:	01 c8                	add    %ecx,%eax
 758:	01 d9                	add    %ebx,%ecx
 75a:	89 ca                	mov    %ecx,%edx
 75c:	29 c2                	sub    %eax,%edx
 75e:	83 e2 01             	and    $0x1,%edx
 761:	74 0d                	je     770 <strncpy+0x60>
    dest[i] = '\0';
 763:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
 766:	83 c0 01             	add    $0x1,%eax
 769:	39 c8                	cmp    %ecx,%eax
 76b:	74 11                	je     77e <strncpy+0x6e>
 76d:	8d 76 00             	lea    0x0(%esi),%esi
    dest[i] = '\0';
 770:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
 773:	83 c0 02             	add    $0x2,%eax
    dest[i] = '\0';
 776:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  for (; i < n; i++)
 77a:	39 c8                	cmp    %ecx,%eax
 77c:	75 f2                	jne    770 <strncpy+0x60>
}
 77e:	5b                   	pop    %ebx
 77f:	5e                   	pop    %esi
 780:	5d                   	pop    %ebp
 781:	c3                   	ret
 782:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 789:	00 
 78a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000790 <printf>:

void
printf(char *fmt, ...)
{
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	57                   	push   %edi
 794:	56                   	push   %esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 795:	8d 75 0c             	lea    0xc(%ebp),%esi
{
 798:	53                   	push   %ebx
 799:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  for(i = 0; fmt[i]; i++){
 79c:	8b 55 08             	mov    0x8(%ebp),%edx
  ap = (uint*)(void*)&fmt + 1;
 79f:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 7a2:	0f b6 02             	movzbl (%edx),%eax
 7a5:	84 c0                	test   %al,%al
 7a7:	0f 84 88 00 00 00    	je     835 <printf+0xa5>
 7ad:	8d 7a 01             	lea    0x1(%edx),%edi
    c = fmt[i] & 0xff;
 7b0:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
      if (c == '\f') {
 7b3:	83 fa 0c             	cmp    $0xc,%edx
 7b6:	0f 84 d4 01 00 00    	je     990 <printf+0x200>
        setcursor();
      } else if(c == '%'){
 7bc:	83 fa 25             	cmp    $0x25,%edx
 7bf:	0f 85 0b 02 00 00    	jne    9d0 <printf+0x240>
  for(i = 0; fmt[i]; i++){
 7c5:	0f b6 1f             	movzbl (%edi),%ebx
 7c8:	83 c7 01             	add    $0x1,%edi
 7cb:	84 db                	test   %bl,%bl
 7cd:	74 66                	je     835 <printf+0xa5>
    c = fmt[i] & 0xff;
 7cf:	0f b6 c3             	movzbl %bl,%eax
 7d2:	ba 20 00 00 00       	mov    $0x20,%edx
 7d7:	31 c9                	xor    %ecx,%ecx
        pad_char = ' ';
      } else {
        putc(1, c);
      }
    } else if(state == '%'){
      if(c == '0'){
 7d9:	83 f8 78             	cmp    $0x78,%eax
 7dc:	7f 22                	jg     800 <printf+0x70>
 7de:	83 f8 62             	cmp    $0x62,%eax
 7e1:	0f 8e b9 01 00 00    	jle    9a0 <printf+0x210>
 7e7:	83 e8 63             	sub    $0x63,%eax
 7ea:	83 f8 15             	cmp    $0x15,%eax
 7ed:	77 11                	ja     800 <printf+0x70>
 7ef:	ff 24 85 ac 0e 00 00 	jmp    *0xeac(,%eax,4)
 7f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7fd:	00 
 7fe:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 800:	83 ec 04             	sub    $0x4,%esp
 803:	8d 75 e7             	lea    -0x19(%ebp),%esi
 806:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 80a:	6a 01                	push   $0x1
 80c:	56                   	push   %esi
 80d:	6a 01                	push   $0x1
 80f:	e8 1f fd ff ff       	call   533 <write>
 814:	83 c4 0c             	add    $0xc,%esp
 817:	88 5d e7             	mov    %bl,-0x19(%ebp)
 81a:	6a 01                	push   $0x1
 81c:	56                   	push   %esi
 81d:	6a 01                	push   $0x1
 81f:	e8 0f fd ff ff       	call   533 <write>
      } else if(c == '%'){
        putc(1, '%');
        state = 0;
      } else {
        putc(1, '%');
        putc(1, c);
 824:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 827:	0f b6 07             	movzbl (%edi),%eax
 82a:	83 c7 01             	add    $0x1,%edi
 82d:	84 c0                	test   %al,%al
 82f:	0f 85 7b ff ff ff    	jne    7b0 <printf+0x20>
        state = 0;
      }
    }
  }
}
 835:	8d 65 f4             	lea    -0xc(%ebp),%esp
 838:	5b                   	pop    %ebx
 839:	5e                   	pop    %esi
 83a:	5f                   	pop    %edi
 83b:	5d                   	pop    %ebp
 83c:	c3                   	ret
 83d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 16, 0, width, pad_char);
 840:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 843:	83 ec 08             	sub    $0x8,%esp
 846:	8b 06                	mov    (%esi),%eax
 848:	52                   	push   %edx
 849:	ba 10 00 00 00       	mov    $0x10,%edx
 84e:	51                   	push   %ecx
 84f:	31 c9                	xor    %ecx,%ecx
        printint(1, *ap, 10, 1, width, pad_char);
 851:	e8 aa fd ff ff       	call   600 <printint.constprop.0>
        ap++;
 856:	83 c6 04             	add    $0x4,%esi
 859:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 85c:	0f b6 07             	movzbl (%edi),%eax
 85f:	83 c7 01             	add    $0x1,%edi
 862:	83 c4 10             	add    $0x10,%esp
 865:	84 c0                	test   %al,%al
 867:	0f 85 43 ff ff ff    	jne    7b0 <printf+0x20>
}
 86d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 870:	5b                   	pop    %ebx
 871:	5e                   	pop    %esi
 872:	5f                   	pop    %edi
 873:	5d                   	pop    %ebp
 874:	c3                   	ret
 875:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 10, 1, width, pad_char);
 878:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 87b:	83 ec 08             	sub    $0x8,%esp
 87e:	8b 06                	mov    (%esi),%eax
 880:	52                   	push   %edx
 881:	ba 0a 00 00 00       	mov    $0xa,%edx
 886:	51                   	push   %ecx
 887:	b9 01 00 00 00       	mov    $0x1,%ecx
 88c:	eb c3                	jmp    851 <printf+0xc1>
 88e:	66 90                	xchg   %ax,%ax
        s = (char*)*ap;
 890:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 893:	8b 06                	mov    (%esi),%eax
        ap++;
 895:	83 c6 04             	add    $0x4,%esi
 898:	89 75 d4             	mov    %esi,-0x2c(%ebp)
        if(s == 0)
 89b:	85 c0                	test   %eax,%eax
 89d:	0f 85 9d 01 00 00    	jne    a40 <printf+0x2b0>
 8a3:	c6 45 d0 28          	movb   $0x28,-0x30(%ebp)
          s = "(null)";
 8a7:	b8 4a 0e 00 00       	mov    $0xe4a,%eax
        int len = 0;
 8ac:	31 db                	xor    %ebx,%ebx
 8ae:	66 90                	xchg   %ax,%ax
        for (char *t = s; *t; t++) len++;
 8b0:	83 c3 01             	add    $0x1,%ebx
 8b3:	80 3c 18 00          	cmpb   $0x0,(%eax,%ebx,1)
 8b7:	75 f7                	jne    8b0 <printf+0x120>
        for (int j = len; j < width; j++)
 8b9:	39 cb                	cmp    %ecx,%ebx
 8bb:	0f 8d 9c 01 00 00    	jge    a5d <printf+0x2cd>
 8c1:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 8c4:	8d 75 e7             	lea    -0x19(%ebp),%esi
 8c7:	89 45 c8             	mov    %eax,-0x38(%ebp)
 8ca:	89 7d cc             	mov    %edi,-0x34(%ebp)
 8cd:	89 df                	mov    %ebx,%edi
 8cf:	89 d3                	mov    %edx,%ebx
 8d1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8d8:	00 
 8d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 8e0:	83 ec 04             	sub    $0x4,%esp
 8e3:	88 5d e7             	mov    %bl,-0x19(%ebp)
        for (int j = len; j < width; j++)
 8e6:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 8e9:	6a 01                	push   $0x1
 8eb:	56                   	push   %esi
 8ec:	6a 01                	push   $0x1
 8ee:	e8 40 fc ff ff       	call   533 <write>
        for (int j = len; j < width; j++)
 8f3:	8b 45 d0             	mov    -0x30(%ebp),%eax
 8f6:	83 c4 10             	add    $0x10,%esp
 8f9:	39 c7                	cmp    %eax,%edi
 8fb:	7c e3                	jl     8e0 <printf+0x150>
        while(*s != 0){
 8fd:	8b 45 c8             	mov    -0x38(%ebp),%eax
 900:	8b 7d cc             	mov    -0x34(%ebp),%edi
 903:	0f b6 08             	movzbl (%eax),%ecx
 906:	88 4d d0             	mov    %cl,-0x30(%ebp)
 909:	84 c9                	test   %cl,%cl
 90b:	0f 84 16 ff ff ff    	je     827 <printf+0x97>
 911:	89 c3                	mov    %eax,%ebx
 913:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 917:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 91e:	00 
 91f:	90                   	nop
  write(fd, &c, 1);
 920:	83 ec 04             	sub    $0x4,%esp
 923:	88 45 e7             	mov    %al,-0x19(%ebp)
          putc(1, *s++);
 926:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 929:	6a 01                	push   $0x1
 92b:	56                   	push   %esi
 92c:	6a 01                	push   $0x1
 92e:	e8 00 fc ff ff       	call   533 <write>
        while(*s != 0){
 933:	0f b6 03             	movzbl (%ebx),%eax
 936:	83 c4 10             	add    $0x10,%esp
 939:	84 c0                	test   %al,%al
 93b:	75 e3                	jne    920 <printf+0x190>
 93d:	e9 e5 fe ff ff       	jmp    827 <printf+0x97>
 942:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        char ch = *ap++;
 948:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 94b:	83 ec 04             	sub    $0x4,%esp
 94e:	8d 75 e7             	lea    -0x19(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 951:	83 c7 01             	add    $0x1,%edi
        char ch = *ap++;
 954:	8d 58 04             	lea    0x4(%eax),%ebx
 957:	8b 00                	mov    (%eax),%eax
 959:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 95c:	6a 01                	push   $0x1
 95e:	56                   	push   %esi
 95f:	6a 01                	push   $0x1
 961:	e8 cd fb ff ff       	call   533 <write>
  for(i = 0; fmt[i]; i++){
 966:	0f b6 47 ff          	movzbl -0x1(%edi),%eax
 96a:	83 c4 10             	add    $0x10,%esp
 96d:	84 c0                	test   %al,%al
 96f:	0f 84 c0 fe ff ff    	je     835 <printf+0xa5>
    c = fmt[i] & 0xff;
 975:	0f b6 d0             	movzbl %al,%edx
        char ch = *ap++;
 978:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      if (c == '\f') {
 97b:	83 fa 0c             	cmp    $0xc,%edx
 97e:	0f 85 38 fe ff ff    	jne    7bc <printf+0x2c>
 984:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 98b:	00 
 98c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        setcursor();
 990:	e8 36 fc ff ff       	call   5cb <setcursor>
 995:	e9 8d fe ff ff       	jmp    827 <printf+0x97>
 99a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 9a0:	83 f8 30             	cmp    $0x30,%eax
 9a3:	74 7b                	je     a20 <printf+0x290>
 9a5:	7f 49                	jg     9f0 <printf+0x260>
 9a7:	83 f8 25             	cmp    $0x25,%eax
 9aa:	0f 85 50 fe ff ff    	jne    800 <printf+0x70>
  write(fd, &c, 1);
 9b0:	83 ec 04             	sub    $0x4,%esp
 9b3:	8d 75 e7             	lea    -0x19(%ebp),%esi
 9b6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 9ba:	6a 01                	push   $0x1
 9bc:	56                   	push   %esi
 9bd:	6a 01                	push   $0x1
 9bf:	e8 6f fb ff ff       	call   533 <write>
        state = 0;
 9c4:	83 c4 10             	add    $0x10,%esp
 9c7:	e9 5b fe ff ff       	jmp    827 <printf+0x97>
 9cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 9d0:	83 ec 04             	sub    $0x4,%esp
 9d3:	8d 75 e7             	lea    -0x19(%ebp),%esi
 9d6:	88 45 e7             	mov    %al,-0x19(%ebp)
 9d9:	6a 01                	push   $0x1
 9db:	56                   	push   %esi
 9dc:	6a 01                	push   $0x1
 9de:	e8 50 fb ff ff       	call   533 <write>
  for(i = 0; fmt[i]; i++){
 9e3:	e9 74 fe ff ff       	jmp    85c <printf+0xcc>
 9e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 9ef:	00 
 9f0:	8d 70 cf             	lea    -0x31(%eax),%esi
 9f3:	83 fe 08             	cmp    $0x8,%esi
 9f6:	0f 87 04 fe ff ff    	ja     800 <printf+0x70>
 9fc:	0f b6 1f             	movzbl (%edi),%ebx
        width = width * 10 + (c - '0');
 9ff:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
  for(i = 0; fmt[i]; i++){
 a02:	83 c7 01             	add    $0x1,%edi
        width = width * 10 + (c - '0');
 a05:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  for(i = 0; fmt[i]; i++){
 a09:	84 db                	test   %bl,%bl
 a0b:	0f 84 24 fe ff ff    	je     835 <printf+0xa5>
    c = fmt[i] & 0xff;
 a11:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 a14:	e9 c0 fd ff ff       	jmp    7d9 <printf+0x49>
 a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 a20:	0f b6 1f             	movzbl (%edi),%ebx
 a23:	83 c7 01             	add    $0x1,%edi
 a26:	84 db                	test   %bl,%bl
 a28:	0f 84 07 fe ff ff    	je     835 <printf+0xa5>
    c = fmt[i] & 0xff;
 a2e:	0f b6 c3             	movzbl %bl,%eax
 a31:	ba 30 00 00 00       	mov    $0x30,%edx
 a36:	e9 9e fd ff ff       	jmp    7d9 <printf+0x49>
 a3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        for (char *t = s; *t; t++) len++;
 a40:	0f b6 18             	movzbl (%eax),%ebx
 a43:	88 5d d0             	mov    %bl,-0x30(%ebp)
 a46:	84 db                	test   %bl,%bl
 a48:	0f 85 5e fe ff ff    	jne    8ac <printf+0x11c>
        int len = 0;
 a4e:	31 db                	xor    %ebx,%ebx
        for (int j = len; j < width; j++)
 a50:	85 c9                	test   %ecx,%ecx
 a52:	0f 8f 69 fe ff ff    	jg     8c1 <printf+0x131>
 a58:	e9 ca fd ff ff       	jmp    827 <printf+0x97>
 a5d:	89 c2                	mov    %eax,%edx
 a5f:	8d 75 e7             	lea    -0x19(%ebp),%esi
 a62:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 a66:	89 d3                	mov    %edx,%ebx
 a68:	e9 b3 fe ff ff       	jmp    920 <printf+0x190>
 a6d:	8d 76 00             	lea    0x0(%esi),%esi

00000a70 <fprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
fprintf(int fd, char *fmt, ...)
{
 a70:	55                   	push   %ebp
 a71:	89 e5                	mov    %esp,%ebp
 a73:	57                   	push   %edi
 a74:	56                   	push   %esi
 a75:	53                   	push   %ebx
 a76:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 a79:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 a7c:	0f b6 13             	movzbl (%ebx),%edx
 a7f:	83 c3 01             	add    $0x1,%ebx
 a82:	84 d2                	test   %dl,%dl
 a84:	0f 84 81 00 00 00    	je     b0b <fprintf+0x9b>
 a8a:	8d 75 10             	lea    0x10(%ebp),%esi
 a8d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 a90:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if (c == '\f') { // Detect formfeed character
 a93:	83 f8 0c             	cmp    $0xc,%eax
 a96:	0f 84 04 01 00 00    	je     ba0 <fprintf+0x130>
        setcursor();
      } else
      if(c == '%'){
 a9c:	83 f8 25             	cmp    $0x25,%eax
 a9f:	0f 85 5b 01 00 00    	jne    c00 <fprintf+0x190>
  for(i = 0; fmt[i]; i++){
 aa5:	0f b6 13             	movzbl (%ebx),%edx
 aa8:	84 d2                	test   %dl,%dl
 aaa:	74 5f                	je     b0b <fprintf+0x9b>
    c = fmt[i] & 0xff;
 aac:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 aaf:	80 fa 25             	cmp    $0x25,%dl
 ab2:	0f 84 78 01 00 00    	je     c30 <fprintf+0x1c0>
 ab8:	83 e8 63             	sub    $0x63,%eax
 abb:	83 f8 15             	cmp    $0x15,%eax
 abe:	77 10                	ja     ad0 <fprintf+0x60>
 ac0:	ff 24 85 04 0f 00 00 	jmp    *0xf04(,%eax,4)
 ac7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 ace:	00 
 acf:	90                   	nop
  write(fd, &c, 1);
 ad0:	83 ec 04             	sub    $0x4,%esp
 ad3:	8d 7d e7             	lea    -0x19(%ebp),%edi
 ad6:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 ad9:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 add:	6a 01                	push   $0x1
 adf:	57                   	push   %edi
 ae0:	ff 75 08             	push   0x8(%ebp)
 ae3:	e8 4b fa ff ff       	call   533 <write>
        putc(fd, c);
 ae8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 aec:	83 c4 0c             	add    $0xc,%esp
 aef:	88 55 e7             	mov    %dl,-0x19(%ebp)
 af2:	6a 01                	push   $0x1
 af4:	57                   	push   %edi
 af5:	ff 75 08             	push   0x8(%ebp)
 af8:	e8 36 fa ff ff       	call   533 <write>
  for(i = 0; fmt[i]; i++){
 afd:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 b01:	83 c3 02             	add    $0x2,%ebx
 b04:	83 c4 10             	add    $0x10,%esp
 b07:	84 d2                	test   %dl,%dl
 b09:	75 85                	jne    a90 <fprintf+0x20>
      }
      state = 0;
    }
  }
}
 b0b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 b0e:	5b                   	pop    %ebx
 b0f:	5e                   	pop    %esi
 b10:	5f                   	pop    %edi
 b11:	5d                   	pop    %ebp
 b12:	c3                   	ret
 b13:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(1, *ap, 16, 0, width, pad_char);
 b18:	83 ec 08             	sub    $0x8,%esp
 b1b:	8b 06                	mov    (%esi),%eax
 b1d:	31 c9                	xor    %ecx,%ecx
 b1f:	ba 10 00 00 00       	mov    $0x10,%edx
 b24:	6a 20                	push   $0x20
 b26:	6a 00                	push   $0x0
 b28:	e8 d3 fa ff ff       	call   600 <printint.constprop.0>
        ap++;
 b2d:	83 c6 04             	add    $0x4,%esi
  for(i = 0; fmt[i]; i++){
 b30:	eb cb                	jmp    afd <fprintf+0x8d>
 b32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s = (char*)*ap;
 b38:	8b 3e                	mov    (%esi),%edi
        ap++;
 b3a:	83 c6 04             	add    $0x4,%esi
        if(s == 0)
 b3d:	85 ff                	test   %edi,%edi
 b3f:	0f 84 fb 00 00 00    	je     c40 <fprintf+0x1d0>
        while(*s != 0){
 b45:	0f b6 07             	movzbl (%edi),%eax
 b48:	84 c0                	test   %al,%al
 b4a:	74 36                	je     b82 <fprintf+0x112>
 b4c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 b4f:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 b52:	8b 75 08             	mov    0x8(%ebp),%esi
 b55:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 b58:	89 fb                	mov    %edi,%ebx
 b5a:	89 cf                	mov    %ecx,%edi
 b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 b60:	83 ec 04             	sub    $0x4,%esp
 b63:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 b66:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 b69:	6a 01                	push   $0x1
 b6b:	57                   	push   %edi
 b6c:	56                   	push   %esi
 b6d:	e8 c1 f9 ff ff       	call   533 <write>
        while(*s != 0){
 b72:	0f b6 03             	movzbl (%ebx),%eax
 b75:	83 c4 10             	add    $0x10,%esp
 b78:	84 c0                	test   %al,%al
 b7a:	75 e4                	jne    b60 <fprintf+0xf0>
 b7c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 b7f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 b82:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 b86:	83 c3 02             	add    $0x2,%ebx
 b89:	84 d2                	test   %dl,%dl
 b8b:	0f 84 7a ff ff ff    	je     b0b <fprintf+0x9b>
    c = fmt[i] & 0xff;
 b91:	0f b6 c2             	movzbl %dl,%eax
      if (c == '\f') { // Detect formfeed character
 b94:	83 f8 0c             	cmp    $0xc,%eax
 b97:	0f 85 ff fe ff ff    	jne    a9c <fprintf+0x2c>
 b9d:	8d 76 00             	lea    0x0(%esi),%esi
        setcursor();
 ba0:	e8 26 fa ff ff       	call   5cb <setcursor>
  for(i = 0; fmt[i]; i++){
 ba5:	0f b6 13             	movzbl (%ebx),%edx
 ba8:	83 c3 01             	add    $0x1,%ebx
 bab:	84 d2                	test   %dl,%dl
 bad:	0f 85 dd fe ff ff    	jne    a90 <fprintf+0x20>
 bb3:	e9 53 ff ff ff       	jmp    b0b <fprintf+0x9b>
 bb8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 bbf:	00 
        printint(1, *ap, 10, 1, width, pad_char);
 bc0:	83 ec 08             	sub    $0x8,%esp
 bc3:	8b 06                	mov    (%esi),%eax
 bc5:	b9 01 00 00 00       	mov    $0x1,%ecx
 bca:	ba 0a 00 00 00       	mov    $0xa,%edx
 bcf:	6a 20                	push   $0x20
 bd1:	6a 00                	push   $0x0
 bd3:	e9 50 ff ff ff       	jmp    b28 <fprintf+0xb8>
 bd8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 bdf:	00 
        putc(fd, *ap);
 be0:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
 be2:	83 ec 04             	sub    $0x4,%esp
 be5:	8d 7d e7             	lea    -0x19(%ebp),%edi
        putc(fd, *ap);
 be8:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 beb:	6a 01                	push   $0x1
 bed:	57                   	push   %edi
 bee:	ff 75 08             	push   0x8(%ebp)
 bf1:	e8 3d f9 ff ff       	call   533 <write>
 bf6:	e9 32 ff ff ff       	jmp    b2d <fprintf+0xbd>
 bfb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 c00:	83 ec 04             	sub    $0x4,%esp
 c03:	8d 45 e7             	lea    -0x19(%ebp),%eax
 c06:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 c09:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 c0c:	6a 01                	push   $0x1
 c0e:	50                   	push   %eax
 c0f:	ff 75 08             	push   0x8(%ebp)
 c12:	e8 1c f9 ff ff       	call   533 <write>
  for(i = 0; fmt[i]; i++){
 c17:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 c1b:	83 c4 10             	add    $0x10,%esp
 c1e:	84 d2                	test   %dl,%dl
 c20:	0f 85 6a fe ff ff    	jne    a90 <fprintf+0x20>
}
 c26:	8d 65 f4             	lea    -0xc(%ebp),%esp
 c29:	5b                   	pop    %ebx
 c2a:	5e                   	pop    %esi
 c2b:	5f                   	pop    %edi
 c2c:	5d                   	pop    %ebp
 c2d:	c3                   	ret
 c2e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 c30:	83 ec 04             	sub    $0x4,%esp
 c33:	88 55 e7             	mov    %dl,-0x19(%ebp)
 c36:	8d 7d e7             	lea    -0x19(%ebp),%edi
 c39:	6a 01                	push   $0x1
 c3b:	e9 b4 fe ff ff       	jmp    af4 <fprintf+0x84>
          s = "(null)";
 c40:	bf 4a 0e 00 00       	mov    $0xe4a,%edi
 c45:	b8 28 00 00 00       	mov    $0x28,%eax
 c4a:	e9 fd fe ff ff       	jmp    b4c <fprintf+0xdc>
 c4f:	66 90                	xchg   %ax,%ax
 c51:	66 90                	xchg   %ax,%ax
 c53:	66 90                	xchg   %ax,%ax
 c55:	66 90                	xchg   %ax,%ax
 c57:	66 90                	xchg   %ax,%ax
 c59:	66 90                	xchg   %ax,%ax
 c5b:	66 90                	xchg   %ax,%ax
 c5d:	66 90                	xchg   %ax,%ax
 c5f:	90                   	nop

00000c60 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 c60:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c61:	a1 80 12 00 00       	mov    0x1280,%eax
{
 c66:	89 e5                	mov    %esp,%ebp
 c68:	57                   	push   %edi
 c69:	56                   	push   %esi
 c6a:	53                   	push   %ebx
 c6b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 c6e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c71:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 c78:	00 
 c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 c80:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c82:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c84:	39 ca                	cmp    %ecx,%edx
 c86:	73 30                	jae    cb8 <free+0x58>
 c88:	39 c1                	cmp    %eax,%ecx
 c8a:	72 04                	jb     c90 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c8c:	39 c2                	cmp    %eax,%edx
 c8e:	72 f0                	jb     c80 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 c90:	8b 73 fc             	mov    -0x4(%ebx),%esi
 c93:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 c96:	39 f8                	cmp    %edi,%eax
 c98:	74 36                	je     cd0 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 c9a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 c9d:	8b 42 04             	mov    0x4(%edx),%eax
 ca0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 ca3:	39 f1                	cmp    %esi,%ecx
 ca5:	74 40                	je     ce7 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 ca7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 ca9:	5b                   	pop    %ebx
  freep = p;
 caa:	89 15 80 12 00 00    	mov    %edx,0x1280
}
 cb0:	5e                   	pop    %esi
 cb1:	5f                   	pop    %edi
 cb2:	5d                   	pop    %ebp
 cb3:	c3                   	ret
 cb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 cb8:	39 c2                	cmp    %eax,%edx
 cba:	72 c4                	jb     c80 <free+0x20>
 cbc:	39 c1                	cmp    %eax,%ecx
 cbe:	73 c0                	jae    c80 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 cc0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 cc3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 cc6:	39 f8                	cmp    %edi,%eax
 cc8:	75 d0                	jne    c9a <free+0x3a>
 cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 cd0:	03 70 04             	add    0x4(%eax),%esi
 cd3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 cd6:	8b 02                	mov    (%edx),%eax
 cd8:	8b 00                	mov    (%eax),%eax
 cda:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 cdd:	8b 42 04             	mov    0x4(%edx),%eax
 ce0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 ce3:	39 f1                	cmp    %esi,%ecx
 ce5:	75 c0                	jne    ca7 <free+0x47>
    p->s.size += bp->s.size;
 ce7:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 cea:	89 15 80 12 00 00    	mov    %edx,0x1280
    p->s.size += bp->s.size;
 cf0:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 cf3:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 cf6:	89 0a                	mov    %ecx,(%edx)
}
 cf8:	5b                   	pop    %ebx
 cf9:	5e                   	pop    %esi
 cfa:	5f                   	pop    %edi
 cfb:	5d                   	pop    %ebp
 cfc:	c3                   	ret
 cfd:	8d 76 00             	lea    0x0(%esi),%esi

00000d00 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 d00:	55                   	push   %ebp
 d01:	89 e5                	mov    %esp,%ebp
 d03:	57                   	push   %edi
 d04:	56                   	push   %esi
 d05:	53                   	push   %ebx
 d06:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d09:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 d0c:	8b 15 80 12 00 00    	mov    0x1280,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d12:	8d 78 07             	lea    0x7(%eax),%edi
 d15:	c1 ef 03             	shr    $0x3,%edi
 d18:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 d1b:	85 d2                	test   %edx,%edx
 d1d:	0f 84 8d 00 00 00    	je     db0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d23:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 d25:	8b 48 04             	mov    0x4(%eax),%ecx
 d28:	39 f9                	cmp    %edi,%ecx
 d2a:	73 64                	jae    d90 <malloc+0x90>
  if(nu < 4096)
 d2c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 d31:	39 df                	cmp    %ebx,%edi
 d33:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 d36:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 d3d:	eb 0a                	jmp    d49 <malloc+0x49>
 d3f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d40:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 d42:	8b 48 04             	mov    0x4(%eax),%ecx
 d45:	39 f9                	cmp    %edi,%ecx
 d47:	73 47                	jae    d90 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 d49:	89 c2                	mov    %eax,%edx
 d4b:	39 05 80 12 00 00    	cmp    %eax,0x1280
 d51:	75 ed                	jne    d40 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 d53:	83 ec 0c             	sub    $0xc,%esp
 d56:	56                   	push   %esi
 d57:	e8 3f f8 ff ff       	call   59b <sbrk>
  if(p == (char*)-1)
 d5c:	83 c4 10             	add    $0x10,%esp
 d5f:	83 f8 ff             	cmp    $0xffffffff,%eax
 d62:	74 1c                	je     d80 <malloc+0x80>
  hp->s.size = nu;
 d64:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 d67:	83 ec 0c             	sub    $0xc,%esp
 d6a:	83 c0 08             	add    $0x8,%eax
 d6d:	50                   	push   %eax
 d6e:	e8 ed fe ff ff       	call   c60 <free>
  return freep;
 d73:	8b 15 80 12 00 00    	mov    0x1280,%edx
      if((p = morecore(nunits)) == 0)
 d79:	83 c4 10             	add    $0x10,%esp
 d7c:	85 d2                	test   %edx,%edx
 d7e:	75 c0                	jne    d40 <malloc+0x40>
        return 0;
  }
}
 d80:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 d83:	31 c0                	xor    %eax,%eax
}
 d85:	5b                   	pop    %ebx
 d86:	5e                   	pop    %esi
 d87:	5f                   	pop    %edi
 d88:	5d                   	pop    %ebp
 d89:	c3                   	ret
 d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 d90:	39 cf                	cmp    %ecx,%edi
 d92:	74 4c                	je     de0 <malloc+0xe0>
        p->s.size -= nunits;
 d94:	29 f9                	sub    %edi,%ecx
 d96:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 d99:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 d9c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 d9f:	89 15 80 12 00 00    	mov    %edx,0x1280
}
 da5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 da8:	83 c0 08             	add    $0x8,%eax
}
 dab:	5b                   	pop    %ebx
 dac:	5e                   	pop    %esi
 dad:	5f                   	pop    %edi
 dae:	5d                   	pop    %ebp
 daf:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 db0:	c7 05 80 12 00 00 84 	movl   $0x1284,0x1280
 db7:	12 00 00 
    base.s.size = 0;
 dba:	b8 84 12 00 00       	mov    $0x1284,%eax
    base.s.ptr = freep = prevp = &base;
 dbf:	c7 05 84 12 00 00 84 	movl   $0x1284,0x1284
 dc6:	12 00 00 
    base.s.size = 0;
 dc9:	c7 05 88 12 00 00 00 	movl   $0x0,0x1288
 dd0:	00 00 00 
    if(p->s.size >= nunits){
 dd3:	e9 54 ff ff ff       	jmp    d2c <malloc+0x2c>
 dd8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 ddf:	00 
        prevp->s.ptr = p->s.ptr;
 de0:	8b 08                	mov    (%eax),%ecx
 de2:	89 0a                	mov    %ecx,(%edx)
 de4:	eb b9                	jmp    d9f <malloc+0x9f>
