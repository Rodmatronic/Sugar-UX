
_reboot:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 10             	sub    $0x10,%esp
  printf("System REBOOT\n");
  11:	68 68 0b 00 00       	push   $0xb68
  16:	e8 f5 04 00 00       	call   510 <printf>
}
  1b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  1e:	31 c0                	xor    %eax,%eax
  20:	c9                   	leave
  21:	8d 61 fc             	lea    -0x4(%ecx),%esp
  24:	c3                   	ret
  25:	66 90                	xchg   %ax,%ax
  27:	66 90                	xchg   %ax,%ax
  29:	66 90                	xchg   %ax,%ax
  2b:	66 90                	xchg   %ax,%ax
  2d:	66 90                	xchg   %ax,%ax
  2f:	66 90                	xchg   %ax,%ax
  31:	66 90                	xchg   %ax,%ax
  33:	66 90                	xchg   %ax,%ax
  35:	66 90                	xchg   %ax,%ax
  37:	66 90                	xchg   %ax,%ax
  39:	66 90                	xchg   %ax,%ax
  3b:	66 90                	xchg   %ax,%ax
  3d:	66 90                	xchg   %ax,%ax
  3f:	90                   	nop

00000040 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  40:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  41:	31 c0                	xor    %eax,%eax
{
  43:	89 e5                	mov    %esp,%ebp
  45:	53                   	push   %ebx
  46:	8b 4d 08             	mov    0x8(%ebp),%ecx
  49:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  50:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  54:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  57:	83 c0 01             	add    $0x1,%eax
  5a:	84 d2                	test   %dl,%dl
  5c:	75 f2                	jne    50 <strcpy+0x10>
    ;
  return os;
}
  5e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  61:	89 c8                	mov    %ecx,%eax
  63:	c9                   	leave
  64:	c3                   	ret
  65:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  6c:	00 
  6d:	8d 76 00             	lea    0x0(%esi),%esi

00000070 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	53                   	push   %ebx
  74:	8b 55 08             	mov    0x8(%ebp),%edx
  77:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  7a:	0f b6 02             	movzbl (%edx),%eax
  7d:	84 c0                	test   %al,%al
  7f:	75 2f                	jne    b0 <strcmp+0x40>
  81:	eb 4a                	jmp    cd <strcmp+0x5d>
  83:	eb 1b                	jmp    a0 <strcmp+0x30>
  85:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  8c:	00 
  8d:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  94:	00 
  95:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  9c:	00 
  9d:	8d 76 00             	lea    0x0(%esi),%esi
  a0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  a4:	83 c2 01             	add    $0x1,%edx
  a7:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
  aa:	84 c0                	test   %al,%al
  ac:	74 12                	je     c0 <strcmp+0x50>
  ae:	89 d9                	mov    %ebx,%ecx
  b0:	0f b6 19             	movzbl (%ecx),%ebx
  b3:	38 c3                	cmp    %al,%bl
  b5:	74 e9                	je     a0 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
  b7:	29 d8                	sub    %ebx,%eax
}
  b9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  bc:	c9                   	leave
  bd:	c3                   	ret
  be:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
  c0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  c4:	31 c0                	xor    %eax,%eax
  c6:	29 d8                	sub    %ebx,%eax
}
  c8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  cb:	c9                   	leave
  cc:	c3                   	ret
  return (uchar)*p - (uchar)*q;
  cd:	0f b6 19             	movzbl (%ecx),%ebx
  d0:	31 c0                	xor    %eax,%eax
  d2:	eb e3                	jmp    b7 <strcmp+0x47>
  d4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  db:	00 
  dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000000e0 <strlen>:

uint
strlen(char *s)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  e6:	80 3a 00             	cmpb   $0x0,(%edx)
  e9:	74 15                	je     100 <strlen+0x20>
  eb:	31 c0                	xor    %eax,%eax
  ed:	8d 76 00             	lea    0x0(%esi),%esi
  f0:	83 c0 01             	add    $0x1,%eax
  f3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  f7:	89 c1                	mov    %eax,%ecx
  f9:	75 f5                	jne    f0 <strlen+0x10>
    ;
  return n;
}
  fb:	89 c8                	mov    %ecx,%eax
  fd:	5d                   	pop    %ebp
  fe:	c3                   	ret
  ff:	90                   	nop
  for(n = 0; s[n]; n++)
 100:	31 c9                	xor    %ecx,%ecx
}
 102:	5d                   	pop    %ebp
 103:	89 c8                	mov    %ecx,%eax
 105:	c3                   	ret
 106:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 10d:	00 
 10e:	66 90                	xchg   %ax,%ax

00000110 <memset>:

void*
memset(void *dst, int c, uint n)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 117:	8b 4d 10             	mov    0x10(%ebp),%ecx
 11a:	8b 45 0c             	mov    0xc(%ebp),%eax
 11d:	89 d7                	mov    %edx,%edi
 11f:	fc                   	cld
 120:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 122:	8b 7d fc             	mov    -0x4(%ebp),%edi
 125:	89 d0                	mov    %edx,%eax
 127:	c9                   	leave
 128:	c3                   	ret
 129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000130 <strchr>:

char*
strchr(const char *s, char c)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	8b 45 08             	mov    0x8(%ebp),%eax
 136:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 13a:	0f b6 10             	movzbl (%eax),%edx
 13d:	84 d2                	test   %dl,%dl
 13f:	75 1a                	jne    15b <strchr+0x2b>
 141:	eb 25                	jmp    168 <strchr+0x38>
 143:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 14a:	00 
 14b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 150:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 154:	83 c0 01             	add    $0x1,%eax
 157:	84 d2                	test   %dl,%dl
 159:	74 0d                	je     168 <strchr+0x38>
    if(*s == c)
 15b:	38 d1                	cmp    %dl,%cl
 15d:	75 f1                	jne    150 <strchr+0x20>
      return (char*)s;
  return 0;
}
 15f:	5d                   	pop    %ebp
 160:	c3                   	ret
 161:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 168:	31 c0                	xor    %eax,%eax
}
 16a:	5d                   	pop    %ebp
 16b:	c3                   	ret
 16c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000170 <gets>:

char*
gets(char *buf, int max)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	57                   	push   %edi
 174:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 175:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 178:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 179:	31 db                	xor    %ebx,%ebx
{
 17b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 17e:	eb 27                	jmp    1a7 <gets+0x37>
    cc = read(0, &c, 1);
 180:	83 ec 04             	sub    $0x4,%esp
 183:	6a 01                	push   $0x1
 185:	56                   	push   %esi
 186:	6a 00                	push   $0x0
 188:	e8 1e 01 00 00       	call   2ab <read>
    if(cc < 1)
 18d:	83 c4 10             	add    $0x10,%esp
 190:	85 c0                	test   %eax,%eax
 192:	7e 1d                	jle    1b1 <gets+0x41>
      break;
    buf[i++] = c;
 194:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 198:	8b 55 08             	mov    0x8(%ebp),%edx
 19b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 19f:	3c 0a                	cmp    $0xa,%al
 1a1:	74 10                	je     1b3 <gets+0x43>
 1a3:	3c 0d                	cmp    $0xd,%al
 1a5:	74 0c                	je     1b3 <gets+0x43>
  for(i=0; i+1 < max; ){
 1a7:	89 df                	mov    %ebx,%edi
 1a9:	83 c3 01             	add    $0x1,%ebx
 1ac:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1af:	7c cf                	jl     180 <gets+0x10>
 1b1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 1b3:	8b 45 08             	mov    0x8(%ebp),%eax
 1b6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 1ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1bd:	5b                   	pop    %ebx
 1be:	5e                   	pop    %esi
 1bf:	5f                   	pop    %edi
 1c0:	5d                   	pop    %ebp
 1c1:	c3                   	ret
 1c2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1c9:	00 
 1ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001d0 <stat>:

int
stat(char *n, struct stat *st)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	56                   	push   %esi
 1d4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d5:	83 ec 08             	sub    $0x8,%esp
 1d8:	6a 00                	push   $0x0
 1da:	ff 75 08             	push   0x8(%ebp)
 1dd:	e8 f1 00 00 00       	call   2d3 <open>
  if(fd < 0)
 1e2:	83 c4 10             	add    $0x10,%esp
 1e5:	85 c0                	test   %eax,%eax
 1e7:	78 27                	js     210 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 1e9:	83 ec 08             	sub    $0x8,%esp
 1ec:	ff 75 0c             	push   0xc(%ebp)
 1ef:	89 c3                	mov    %eax,%ebx
 1f1:	50                   	push   %eax
 1f2:	e8 f4 00 00 00       	call   2eb <fstat>
  close(fd);
 1f7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1fa:	89 c6                	mov    %eax,%esi
  close(fd);
 1fc:	e8 ba 00 00 00       	call   2bb <close>
  return r;
 201:	83 c4 10             	add    $0x10,%esp
}
 204:	8d 65 f8             	lea    -0x8(%ebp),%esp
 207:	89 f0                	mov    %esi,%eax
 209:	5b                   	pop    %ebx
 20a:	5e                   	pop    %esi
 20b:	5d                   	pop    %ebp
 20c:	c3                   	ret
 20d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 210:	be ff ff ff ff       	mov    $0xffffffff,%esi
 215:	eb ed                	jmp    204 <stat+0x34>
 217:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 21e:	00 
 21f:	90                   	nop

00000220 <atoi>:

int
atoi(const char *s)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	53                   	push   %ebx
 224:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 227:	0f be 02             	movsbl (%edx),%eax
 22a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 22d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 230:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 235:	77 1e                	ja     255 <atoi+0x35>
 237:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 23e:	00 
 23f:	90                   	nop
    n = n*10 + *s++ - '0';
 240:	83 c2 01             	add    $0x1,%edx
 243:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 246:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 24a:	0f be 02             	movsbl (%edx),%eax
 24d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 250:	80 fb 09             	cmp    $0x9,%bl
 253:	76 eb                	jbe    240 <atoi+0x20>
  return n;
}
 255:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 258:	89 c8                	mov    %ecx,%eax
 25a:	c9                   	leave
 25b:	c3                   	ret
 25c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000260 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	57                   	push   %edi
 264:	8b 45 10             	mov    0x10(%ebp),%eax
 267:	8b 55 08             	mov    0x8(%ebp),%edx
 26a:	56                   	push   %esi
 26b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 26e:	85 c0                	test   %eax,%eax
 270:	7e 13                	jle    285 <memmove+0x25>
 272:	01 d0                	add    %edx,%eax
  dst = vdst;
 274:	89 d7                	mov    %edx,%edi
 276:	66 90                	xchg   %ax,%ax
 278:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 27f:	00 
    *dst++ = *src++;
 280:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 281:	39 f8                	cmp    %edi,%eax
 283:	75 fb                	jne    280 <memmove+0x20>
  return vdst;
}
 285:	5e                   	pop    %esi
 286:	89 d0                	mov    %edx,%eax
 288:	5f                   	pop    %edi
 289:	5d                   	pop    %ebp
 28a:	c3                   	ret

0000028b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 28b:	b8 01 00 00 00       	mov    $0x1,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret

00000293 <exit>:
SYSCALL(exit)
 293:	b8 02 00 00 00       	mov    $0x2,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret

0000029b <wait>:
SYSCALL(wait)
 29b:	b8 03 00 00 00       	mov    $0x3,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret

000002a3 <pipe>:
SYSCALL(pipe)
 2a3:	b8 04 00 00 00       	mov    $0x4,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret

000002ab <read>:
SYSCALL(read)
 2ab:	b8 05 00 00 00       	mov    $0x5,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret

000002b3 <write>:
SYSCALL(write)
 2b3:	b8 10 00 00 00       	mov    $0x10,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret

000002bb <close>:
SYSCALL(close)
 2bb:	b8 15 00 00 00       	mov    $0x15,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret

000002c3 <kill>:
SYSCALL(kill)
 2c3:	b8 06 00 00 00       	mov    $0x6,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret

000002cb <exec>:
SYSCALL(exec)
 2cb:	b8 07 00 00 00       	mov    $0x7,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret

000002d3 <open>:
SYSCALL(open)
 2d3:	b8 0f 00 00 00       	mov    $0xf,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret

000002db <mknod>:
SYSCALL(mknod)
 2db:	b8 11 00 00 00       	mov    $0x11,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret

000002e3 <unlink>:
SYSCALL(unlink)
 2e3:	b8 12 00 00 00       	mov    $0x12,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret

000002eb <fstat>:
SYSCALL(fstat)
 2eb:	b8 08 00 00 00       	mov    $0x8,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret

000002f3 <link>:
SYSCALL(link)
 2f3:	b8 13 00 00 00       	mov    $0x13,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret

000002fb <mkdir>:
SYSCALL(mkdir)
 2fb:	b8 14 00 00 00       	mov    $0x14,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret

00000303 <chdir>:
SYSCALL(chdir)
 303:	b8 09 00 00 00       	mov    $0x9,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret

0000030b <dup>:
SYSCALL(dup)
 30b:	b8 0a 00 00 00       	mov    $0xa,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret

00000313 <getpid>:
SYSCALL(getpid)
 313:	b8 0b 00 00 00       	mov    $0xb,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret

0000031b <sbrk>:
SYSCALL(sbrk)
 31b:	b8 0c 00 00 00       	mov    $0xc,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret

00000323 <sleep>:
SYSCALL(sleep)
 323:	b8 0d 00 00 00       	mov    $0xd,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret

0000032b <uptime>:
SYSCALL(uptime)
 32b:	b8 0e 00 00 00       	mov    $0xe,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret

00000333 <bstat>:
SYSCALL(bstat)
 333:	b8 16 00 00 00       	mov    $0x16,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret

0000033b <swap>:
SYSCALL(swap)
 33b:	b8 17 00 00 00       	mov    $0x17,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret

00000343 <gettime>:
SYSCALL(gettime)
 343:	b8 18 00 00 00       	mov    $0x18,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret

0000034b <setcursor>:
SYSCALL(setcursor)
 34b:	b8 19 00 00 00       	mov    $0x19,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <uname>:
SYSCALL(uname)
 353:	b8 1a 00 00 00       	mov    $0x1a,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <echo>:
SYSCALL(echo)
 35b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret
 363:	66 90                	xchg   %ax,%ax
 365:	66 90                	xchg   %ax,%ax
 367:	66 90                	xchg   %ax,%ax
 369:	66 90                	xchg   %ax,%ax
 36b:	66 90                	xchg   %ax,%ax
 36d:	66 90                	xchg   %ax,%ax
 36f:	66 90                	xchg   %ax,%ax
 371:	66 90                	xchg   %ax,%ax
 373:	66 90                	xchg   %ax,%ax
 375:	66 90                	xchg   %ax,%ax
 377:	66 90                	xchg   %ax,%ax
 379:	66 90                	xchg   %ax,%ax
 37b:	66 90                	xchg   %ax,%ax
 37d:	66 90                	xchg   %ax,%ax
 37f:	90                   	nop

00000380 <printint.constprop.0>:
{
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn, int width, char pad_char)
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	56                   	push   %esi
 385:	89 c6                	mov    %eax,%esi
 387:	53                   	push   %ebx
 388:	89 d3                	mov    %edx,%ebx
 38a:	83 ec 3c             	sub    $0x3c,%esp
 38d:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 391:	85 f6                	test   %esi,%esi
 393:	0f 89 d7 00 00 00    	jns    470 <printint.constprop.0+0xf0>
 399:	83 e1 01             	and    $0x1,%ecx
 39c:	0f 84 ce 00 00 00    	je     470 <printint.constprop.0+0xf0>
    neg = 1;
 3a2:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 3a9:	f7 de                	neg    %esi
 3ab:	89 f1                	mov    %esi,%ecx
  } else {
    x = xx;
  }

  i = 0;
 3ad:	88 45 bf             	mov    %al,-0x41(%ebp)
 3b0:	31 ff                	xor    %edi,%edi
 3b2:	8d 75 d7             	lea    -0x29(%ebp),%esi
 3b5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3bc:	00 
 3bd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 3c0:	89 c8                	mov    %ecx,%eax
 3c2:	31 d2                	xor    %edx,%edx
 3c4:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 3c7:	83 c7 01             	add    $0x1,%edi
 3ca:	f7 f3                	div    %ebx
 3cc:	0f b6 92 30 0c 00 00 	movzbl 0xc30(%edx),%edx
 3d3:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 3d6:	89 ca                	mov    %ecx,%edx
 3d8:	89 c1                	mov    %eax,%ecx
 3da:	39 da                	cmp    %ebx,%edx
 3dc:	73 e2                	jae    3c0 <printint.constprop.0+0x40>

  if(neg)
 3de:	8b 55 c0             	mov    -0x40(%ebp),%edx
 3e1:	0f b6 45 bf          	movzbl -0x41(%ebp),%eax
 3e5:	85 d2                	test   %edx,%edx
 3e7:	74 0b                	je     3f4 <printint.constprop.0+0x74>
    buf[i++] = '-';
 3e9:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
 3ec:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 3f1:	8d 79 02             	lea    0x2(%ecx),%edi

  // Pad with pad_char until we hit the required width
  while(i < width)
 3f4:	39 7d 08             	cmp    %edi,0x8(%ebp)
 3f7:	0f 8e 83 00 00 00    	jle    480 <printint.constprop.0+0x100>
 3fd:	8b 55 08             	mov    0x8(%ebp),%edx
 400:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 403:	01 df                	add    %ebx,%edi
 405:	01 da                	add    %ebx,%edx
 407:	89 d1                	mov    %edx,%ecx
 409:	29 f9                	sub    %edi,%ecx
 40b:	83 e1 01             	and    $0x1,%ecx
 40e:	74 10                	je     420 <printint.constprop.0+0xa0>
    buf[i++] = pad_char;
 410:	88 07                	mov    %al,(%edi)
  while(i < width)
 412:	83 c7 01             	add    $0x1,%edi
 415:	39 d7                	cmp    %edx,%edi
 417:	74 13                	je     42c <printint.constprop.0+0xac>
 419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = pad_char;
 420:	88 07                	mov    %al,(%edi)
  while(i < width)
 422:	83 c7 02             	add    $0x2,%edi
    buf[i++] = pad_char;
 425:	88 47 ff             	mov    %al,-0x1(%edi)
  while(i < width)
 428:	39 d7                	cmp    %edx,%edi
 42a:	75 f4                	jne    420 <printint.constprop.0+0xa0>
 42c:	8b 45 08             	mov    0x8(%ebp),%eax
 42f:	8d 78 ff             	lea    -0x1(%eax),%edi

  while(--i >= 0)
 432:	01 df                	add    %ebx,%edi
 434:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 43b:	00 
 43c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 440:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 443:	83 ec 04             	sub    $0x4,%esp
 446:	88 45 d7             	mov    %al,-0x29(%ebp)
 449:	6a 01                	push   $0x1
 44b:	56                   	push   %esi
 44c:	6a 01                	push   $0x1
 44e:	e8 60 fe ff ff       	call   2b3 <write>
  while(--i >= 0)
 453:	89 f8                	mov    %edi,%eax
 455:	83 c4 10             	add    $0x10,%esp
 458:	83 ef 01             	sub    $0x1,%edi
 45b:	39 d8                	cmp    %ebx,%eax
 45d:	75 e1                	jne    440 <printint.constprop.0+0xc0>
}
 45f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 462:	5b                   	pop    %ebx
 463:	5e                   	pop    %esi
 464:	5f                   	pop    %edi
 465:	5d                   	pop    %ebp
 466:	c3                   	ret
 467:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 46e:	00 
 46f:	90                   	nop
  neg = 0;
 470:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = xx;
 477:	89 f1                	mov    %esi,%ecx
 479:	e9 2f ff ff ff       	jmp    3ad <printint.constprop.0+0x2d>
 47e:	66 90                	xchg   %ax,%ax
  while(--i >= 0)
 480:	83 ef 01             	sub    $0x1,%edi
 483:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 486:	eb aa                	jmp    432 <printint.constprop.0+0xb2>
 488:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 48f:	00 

00000490 <strncpy>:
{
 490:	55                   	push   %ebp
 491:	31 c0                	xor    %eax,%eax
 493:	89 e5                	mov    %esp,%ebp
 495:	56                   	push   %esi
 496:	8b 4d 08             	mov    0x8(%ebp),%ecx
 499:	8b 75 0c             	mov    0xc(%ebp),%esi
 49c:	53                   	push   %ebx
 49d:	8b 5d 10             	mov    0x10(%ebp),%ebx
  for (i = 0; i < n && src[i]; i++)
 4a0:	85 db                	test   %ebx,%ebx
 4a2:	7f 26                	jg     4ca <strncpy+0x3a>
 4a4:	eb 58                	jmp    4fe <strncpy+0x6e>
 4a6:	eb 18                	jmp    4c0 <strncpy+0x30>
 4a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4af:	00 
 4b0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4b7:	00 
 4b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4bf:	00 
    dest[i] = src[i];
 4c0:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  for (i = 0; i < n && src[i]; i++)
 4c3:	83 c0 01             	add    $0x1,%eax
 4c6:	39 c3                	cmp    %eax,%ebx
 4c8:	74 34                	je     4fe <strncpy+0x6e>
 4ca:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
 4ce:	84 d2                	test   %dl,%dl
 4d0:	75 ee                	jne    4c0 <strncpy+0x30>
  for (; i < n; i++)
 4d2:	39 c3                	cmp    %eax,%ebx
 4d4:	7e 28                	jle    4fe <strncpy+0x6e>
 4d6:	01 c8                	add    %ecx,%eax
 4d8:	01 d9                	add    %ebx,%ecx
 4da:	89 ca                	mov    %ecx,%edx
 4dc:	29 c2                	sub    %eax,%edx
 4de:	83 e2 01             	and    $0x1,%edx
 4e1:	74 0d                	je     4f0 <strncpy+0x60>
    dest[i] = '\0';
 4e3:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
 4e6:	83 c0 01             	add    $0x1,%eax
 4e9:	39 c8                	cmp    %ecx,%eax
 4eb:	74 11                	je     4fe <strncpy+0x6e>
 4ed:	8d 76 00             	lea    0x0(%esi),%esi
    dest[i] = '\0';
 4f0:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
 4f3:	83 c0 02             	add    $0x2,%eax
    dest[i] = '\0';
 4f6:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  for (; i < n; i++)
 4fa:	39 c8                	cmp    %ecx,%eax
 4fc:	75 f2                	jne    4f0 <strncpy+0x60>
}
 4fe:	5b                   	pop    %ebx
 4ff:	5e                   	pop    %esi
 500:	5d                   	pop    %ebp
 501:	c3                   	ret
 502:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 509:	00 
 50a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000510 <printf>:

void
printf(char *fmt, ...)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	57                   	push   %edi
 514:	56                   	push   %esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 515:	8d 75 0c             	lea    0xc(%ebp),%esi
{
 518:	53                   	push   %ebx
 519:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  for(i = 0; fmt[i]; i++){
 51c:	8b 55 08             	mov    0x8(%ebp),%edx
  ap = (uint*)(void*)&fmt + 1;
 51f:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 522:	0f b6 02             	movzbl (%edx),%eax
 525:	84 c0                	test   %al,%al
 527:	0f 84 88 00 00 00    	je     5b5 <printf+0xa5>
 52d:	8d 7a 01             	lea    0x1(%edx),%edi
    c = fmt[i] & 0xff;
 530:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
      if (c == '\f') {
 533:	83 fa 0c             	cmp    $0xc,%edx
 536:	0f 84 d4 01 00 00    	je     710 <printf+0x200>
        setcursor();
      } else if(c == '%'){
 53c:	83 fa 25             	cmp    $0x25,%edx
 53f:	0f 85 0b 02 00 00    	jne    750 <printf+0x240>
  for(i = 0; fmt[i]; i++){
 545:	0f b6 1f             	movzbl (%edi),%ebx
 548:	83 c7 01             	add    $0x1,%edi
 54b:	84 db                	test   %bl,%bl
 54d:	74 66                	je     5b5 <printf+0xa5>
    c = fmt[i] & 0xff;
 54f:	0f b6 c3             	movzbl %bl,%eax
 552:	ba 20 00 00 00       	mov    $0x20,%edx
 557:	31 c9                	xor    %ecx,%ecx
        pad_char = ' ';
      } else {
        putc(1, c);
      }
    } else if(state == '%'){
      if(c == '0'){
 559:	83 f8 78             	cmp    $0x78,%eax
 55c:	7f 22                	jg     580 <printf+0x70>
 55e:	83 f8 62             	cmp    $0x62,%eax
 561:	0f 8e b9 01 00 00    	jle    720 <printf+0x210>
 567:	83 e8 63             	sub    $0x63,%eax
 56a:	83 f8 15             	cmp    $0x15,%eax
 56d:	77 11                	ja     580 <printf+0x70>
 56f:	ff 24 85 80 0b 00 00 	jmp    *0xb80(,%eax,4)
 576:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 57d:	00 
 57e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 580:	83 ec 04             	sub    $0x4,%esp
 583:	8d 75 e7             	lea    -0x19(%ebp),%esi
 586:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 58a:	6a 01                	push   $0x1
 58c:	56                   	push   %esi
 58d:	6a 01                	push   $0x1
 58f:	e8 1f fd ff ff       	call   2b3 <write>
 594:	83 c4 0c             	add    $0xc,%esp
 597:	88 5d e7             	mov    %bl,-0x19(%ebp)
 59a:	6a 01                	push   $0x1
 59c:	56                   	push   %esi
 59d:	6a 01                	push   $0x1
 59f:	e8 0f fd ff ff       	call   2b3 <write>
      } else if(c == '%'){
        putc(1, '%');
        state = 0;
      } else {
        putc(1, '%');
        putc(1, c);
 5a4:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 5a7:	0f b6 07             	movzbl (%edi),%eax
 5aa:	83 c7 01             	add    $0x1,%edi
 5ad:	84 c0                	test   %al,%al
 5af:	0f 85 7b ff ff ff    	jne    530 <printf+0x20>
        state = 0;
      }
    }
  }
}
 5b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5b8:	5b                   	pop    %ebx
 5b9:	5e                   	pop    %esi
 5ba:	5f                   	pop    %edi
 5bb:	5d                   	pop    %ebp
 5bc:	c3                   	ret
 5bd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 16, 0, width, pad_char);
 5c0:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 5c3:	83 ec 08             	sub    $0x8,%esp
 5c6:	8b 06                	mov    (%esi),%eax
 5c8:	52                   	push   %edx
 5c9:	ba 10 00 00 00       	mov    $0x10,%edx
 5ce:	51                   	push   %ecx
 5cf:	31 c9                	xor    %ecx,%ecx
        printint(1, *ap, 10, 1, width, pad_char);
 5d1:	e8 aa fd ff ff       	call   380 <printint.constprop.0>
        ap++;
 5d6:	83 c6 04             	add    $0x4,%esi
 5d9:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 5dc:	0f b6 07             	movzbl (%edi),%eax
 5df:	83 c7 01             	add    $0x1,%edi
 5e2:	83 c4 10             	add    $0x10,%esp
 5e5:	84 c0                	test   %al,%al
 5e7:	0f 85 43 ff ff ff    	jne    530 <printf+0x20>
}
 5ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5f0:	5b                   	pop    %ebx
 5f1:	5e                   	pop    %esi
 5f2:	5f                   	pop    %edi
 5f3:	5d                   	pop    %ebp
 5f4:	c3                   	ret
 5f5:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 10, 1, width, pad_char);
 5f8:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 5fb:	83 ec 08             	sub    $0x8,%esp
 5fe:	8b 06                	mov    (%esi),%eax
 600:	52                   	push   %edx
 601:	ba 0a 00 00 00       	mov    $0xa,%edx
 606:	51                   	push   %ecx
 607:	b9 01 00 00 00       	mov    $0x1,%ecx
 60c:	eb c3                	jmp    5d1 <printf+0xc1>
 60e:	66 90                	xchg   %ax,%ax
        s = (char*)*ap;
 610:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 613:	8b 06                	mov    (%esi),%eax
        ap++;
 615:	83 c6 04             	add    $0x4,%esi
 618:	89 75 d4             	mov    %esi,-0x2c(%ebp)
        if(s == 0)
 61b:	85 c0                	test   %eax,%eax
 61d:	0f 85 9d 01 00 00    	jne    7c0 <printf+0x2b0>
 623:	c6 45 d0 28          	movb   $0x28,-0x30(%ebp)
          s = "(null)";
 627:	b8 77 0b 00 00       	mov    $0xb77,%eax
        int len = 0;
 62c:	31 db                	xor    %ebx,%ebx
 62e:	66 90                	xchg   %ax,%ax
        for (char *t = s; *t; t++) len++;
 630:	83 c3 01             	add    $0x1,%ebx
 633:	80 3c 18 00          	cmpb   $0x0,(%eax,%ebx,1)
 637:	75 f7                	jne    630 <printf+0x120>
        for (int j = len; j < width; j++)
 639:	39 cb                	cmp    %ecx,%ebx
 63b:	0f 8d 9c 01 00 00    	jge    7dd <printf+0x2cd>
 641:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 644:	8d 75 e7             	lea    -0x19(%ebp),%esi
 647:	89 45 c8             	mov    %eax,-0x38(%ebp)
 64a:	89 7d cc             	mov    %edi,-0x34(%ebp)
 64d:	89 df                	mov    %ebx,%edi
 64f:	89 d3                	mov    %edx,%ebx
 651:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 658:	00 
 659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 660:	83 ec 04             	sub    $0x4,%esp
 663:	88 5d e7             	mov    %bl,-0x19(%ebp)
        for (int j = len; j < width; j++)
 666:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 669:	6a 01                	push   $0x1
 66b:	56                   	push   %esi
 66c:	6a 01                	push   $0x1
 66e:	e8 40 fc ff ff       	call   2b3 <write>
        for (int j = len; j < width; j++)
 673:	8b 45 d0             	mov    -0x30(%ebp),%eax
 676:	83 c4 10             	add    $0x10,%esp
 679:	39 c7                	cmp    %eax,%edi
 67b:	7c e3                	jl     660 <printf+0x150>
        while(*s != 0){
 67d:	8b 45 c8             	mov    -0x38(%ebp),%eax
 680:	8b 7d cc             	mov    -0x34(%ebp),%edi
 683:	0f b6 08             	movzbl (%eax),%ecx
 686:	88 4d d0             	mov    %cl,-0x30(%ebp)
 689:	84 c9                	test   %cl,%cl
 68b:	0f 84 16 ff ff ff    	je     5a7 <printf+0x97>
 691:	89 c3                	mov    %eax,%ebx
 693:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 697:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 69e:	00 
 69f:	90                   	nop
  write(fd, &c, 1);
 6a0:	83 ec 04             	sub    $0x4,%esp
 6a3:	88 45 e7             	mov    %al,-0x19(%ebp)
          putc(1, *s++);
 6a6:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 6a9:	6a 01                	push   $0x1
 6ab:	56                   	push   %esi
 6ac:	6a 01                	push   $0x1
 6ae:	e8 00 fc ff ff       	call   2b3 <write>
        while(*s != 0){
 6b3:	0f b6 03             	movzbl (%ebx),%eax
 6b6:	83 c4 10             	add    $0x10,%esp
 6b9:	84 c0                	test   %al,%al
 6bb:	75 e3                	jne    6a0 <printf+0x190>
 6bd:	e9 e5 fe ff ff       	jmp    5a7 <printf+0x97>
 6c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        char ch = *ap++;
 6c8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 6cb:	83 ec 04             	sub    $0x4,%esp
 6ce:	8d 75 e7             	lea    -0x19(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 6d1:	83 c7 01             	add    $0x1,%edi
        char ch = *ap++;
 6d4:	8d 58 04             	lea    0x4(%eax),%ebx
 6d7:	8b 00                	mov    (%eax),%eax
 6d9:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6dc:	6a 01                	push   $0x1
 6de:	56                   	push   %esi
 6df:	6a 01                	push   $0x1
 6e1:	e8 cd fb ff ff       	call   2b3 <write>
  for(i = 0; fmt[i]; i++){
 6e6:	0f b6 47 ff          	movzbl -0x1(%edi),%eax
 6ea:	83 c4 10             	add    $0x10,%esp
 6ed:	84 c0                	test   %al,%al
 6ef:	0f 84 c0 fe ff ff    	je     5b5 <printf+0xa5>
    c = fmt[i] & 0xff;
 6f5:	0f b6 d0             	movzbl %al,%edx
        char ch = *ap++;
 6f8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      if (c == '\f') {
 6fb:	83 fa 0c             	cmp    $0xc,%edx
 6fe:	0f 85 38 fe ff ff    	jne    53c <printf+0x2c>
 704:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 70b:	00 
 70c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        setcursor();
 710:	e8 36 fc ff ff       	call   34b <setcursor>
 715:	e9 8d fe ff ff       	jmp    5a7 <printf+0x97>
 71a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 720:	83 f8 30             	cmp    $0x30,%eax
 723:	74 7b                	je     7a0 <printf+0x290>
 725:	7f 49                	jg     770 <printf+0x260>
 727:	83 f8 25             	cmp    $0x25,%eax
 72a:	0f 85 50 fe ff ff    	jne    580 <printf+0x70>
  write(fd, &c, 1);
 730:	83 ec 04             	sub    $0x4,%esp
 733:	8d 75 e7             	lea    -0x19(%ebp),%esi
 736:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 73a:	6a 01                	push   $0x1
 73c:	56                   	push   %esi
 73d:	6a 01                	push   $0x1
 73f:	e8 6f fb ff ff       	call   2b3 <write>
        state = 0;
 744:	83 c4 10             	add    $0x10,%esp
 747:	e9 5b fe ff ff       	jmp    5a7 <printf+0x97>
 74c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 750:	83 ec 04             	sub    $0x4,%esp
 753:	8d 75 e7             	lea    -0x19(%ebp),%esi
 756:	88 45 e7             	mov    %al,-0x19(%ebp)
 759:	6a 01                	push   $0x1
 75b:	56                   	push   %esi
 75c:	6a 01                	push   $0x1
 75e:	e8 50 fb ff ff       	call   2b3 <write>
  for(i = 0; fmt[i]; i++){
 763:	e9 74 fe ff ff       	jmp    5dc <printf+0xcc>
 768:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 76f:	00 
 770:	8d 70 cf             	lea    -0x31(%eax),%esi
 773:	83 fe 08             	cmp    $0x8,%esi
 776:	0f 87 04 fe ff ff    	ja     580 <printf+0x70>
 77c:	0f b6 1f             	movzbl (%edi),%ebx
        width = width * 10 + (c - '0');
 77f:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
  for(i = 0; fmt[i]; i++){
 782:	83 c7 01             	add    $0x1,%edi
        width = width * 10 + (c - '0');
 785:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  for(i = 0; fmt[i]; i++){
 789:	84 db                	test   %bl,%bl
 78b:	0f 84 24 fe ff ff    	je     5b5 <printf+0xa5>
    c = fmt[i] & 0xff;
 791:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 794:	e9 c0 fd ff ff       	jmp    559 <printf+0x49>
 799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 7a0:	0f b6 1f             	movzbl (%edi),%ebx
 7a3:	83 c7 01             	add    $0x1,%edi
 7a6:	84 db                	test   %bl,%bl
 7a8:	0f 84 07 fe ff ff    	je     5b5 <printf+0xa5>
    c = fmt[i] & 0xff;
 7ae:	0f b6 c3             	movzbl %bl,%eax
 7b1:	ba 30 00 00 00       	mov    $0x30,%edx
 7b6:	e9 9e fd ff ff       	jmp    559 <printf+0x49>
 7bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        for (char *t = s; *t; t++) len++;
 7c0:	0f b6 18             	movzbl (%eax),%ebx
 7c3:	88 5d d0             	mov    %bl,-0x30(%ebp)
 7c6:	84 db                	test   %bl,%bl
 7c8:	0f 85 5e fe ff ff    	jne    62c <printf+0x11c>
        int len = 0;
 7ce:	31 db                	xor    %ebx,%ebx
        for (int j = len; j < width; j++)
 7d0:	85 c9                	test   %ecx,%ecx
 7d2:	0f 8f 69 fe ff ff    	jg     641 <printf+0x131>
 7d8:	e9 ca fd ff ff       	jmp    5a7 <printf+0x97>
 7dd:	89 c2                	mov    %eax,%edx
 7df:	8d 75 e7             	lea    -0x19(%ebp),%esi
 7e2:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 7e6:	89 d3                	mov    %edx,%ebx
 7e8:	e9 b3 fe ff ff       	jmp    6a0 <printf+0x190>
 7ed:	8d 76 00             	lea    0x0(%esi),%esi

000007f0 <fprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
fprintf(int fd, char *fmt, ...)
{
 7f0:	55                   	push   %ebp
 7f1:	89 e5                	mov    %esp,%ebp
 7f3:	57                   	push   %edi
 7f4:	56                   	push   %esi
 7f5:	53                   	push   %ebx
 7f6:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7f9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 7fc:	0f b6 13             	movzbl (%ebx),%edx
 7ff:	83 c3 01             	add    $0x1,%ebx
 802:	84 d2                	test   %dl,%dl
 804:	0f 84 81 00 00 00    	je     88b <fprintf+0x9b>
 80a:	8d 75 10             	lea    0x10(%ebp),%esi
 80d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 810:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if (c == '\f') { // Detect formfeed character
 813:	83 f8 0c             	cmp    $0xc,%eax
 816:	0f 84 04 01 00 00    	je     920 <fprintf+0x130>
        setcursor();
      } else
      if(c == '%'){
 81c:	83 f8 25             	cmp    $0x25,%eax
 81f:	0f 85 5b 01 00 00    	jne    980 <fprintf+0x190>
  for(i = 0; fmt[i]; i++){
 825:	0f b6 13             	movzbl (%ebx),%edx
 828:	84 d2                	test   %dl,%dl
 82a:	74 5f                	je     88b <fprintf+0x9b>
    c = fmt[i] & 0xff;
 82c:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 82f:	80 fa 25             	cmp    $0x25,%dl
 832:	0f 84 78 01 00 00    	je     9b0 <fprintf+0x1c0>
 838:	83 e8 63             	sub    $0x63,%eax
 83b:	83 f8 15             	cmp    $0x15,%eax
 83e:	77 10                	ja     850 <fprintf+0x60>
 840:	ff 24 85 d8 0b 00 00 	jmp    *0xbd8(,%eax,4)
 847:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 84e:	00 
 84f:	90                   	nop
  write(fd, &c, 1);
 850:	83 ec 04             	sub    $0x4,%esp
 853:	8d 7d e7             	lea    -0x19(%ebp),%edi
 856:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 859:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 85d:	6a 01                	push   $0x1
 85f:	57                   	push   %edi
 860:	ff 75 08             	push   0x8(%ebp)
 863:	e8 4b fa ff ff       	call   2b3 <write>
        putc(fd, c);
 868:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 86c:	83 c4 0c             	add    $0xc,%esp
 86f:	88 55 e7             	mov    %dl,-0x19(%ebp)
 872:	6a 01                	push   $0x1
 874:	57                   	push   %edi
 875:	ff 75 08             	push   0x8(%ebp)
 878:	e8 36 fa ff ff       	call   2b3 <write>
  for(i = 0; fmt[i]; i++){
 87d:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 881:	83 c3 02             	add    $0x2,%ebx
 884:	83 c4 10             	add    $0x10,%esp
 887:	84 d2                	test   %dl,%dl
 889:	75 85                	jne    810 <fprintf+0x20>
      }
      state = 0;
    }
  }
}
 88b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 88e:	5b                   	pop    %ebx
 88f:	5e                   	pop    %esi
 890:	5f                   	pop    %edi
 891:	5d                   	pop    %ebp
 892:	c3                   	ret
 893:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(1, *ap, 16, 0, width, pad_char);
 898:	83 ec 08             	sub    $0x8,%esp
 89b:	8b 06                	mov    (%esi),%eax
 89d:	31 c9                	xor    %ecx,%ecx
 89f:	ba 10 00 00 00       	mov    $0x10,%edx
 8a4:	6a 20                	push   $0x20
 8a6:	6a 00                	push   $0x0
 8a8:	e8 d3 fa ff ff       	call   380 <printint.constprop.0>
        ap++;
 8ad:	83 c6 04             	add    $0x4,%esi
  for(i = 0; fmt[i]; i++){
 8b0:	eb cb                	jmp    87d <fprintf+0x8d>
 8b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s = (char*)*ap;
 8b8:	8b 3e                	mov    (%esi),%edi
        ap++;
 8ba:	83 c6 04             	add    $0x4,%esi
        if(s == 0)
 8bd:	85 ff                	test   %edi,%edi
 8bf:	0f 84 fb 00 00 00    	je     9c0 <fprintf+0x1d0>
        while(*s != 0){
 8c5:	0f b6 07             	movzbl (%edi),%eax
 8c8:	84 c0                	test   %al,%al
 8ca:	74 36                	je     902 <fprintf+0x112>
 8cc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 8cf:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 8d2:	8b 75 08             	mov    0x8(%ebp),%esi
 8d5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 8d8:	89 fb                	mov    %edi,%ebx
 8da:	89 cf                	mov    %ecx,%edi
 8dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 8e0:	83 ec 04             	sub    $0x4,%esp
 8e3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 8e6:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 8e9:	6a 01                	push   $0x1
 8eb:	57                   	push   %edi
 8ec:	56                   	push   %esi
 8ed:	e8 c1 f9 ff ff       	call   2b3 <write>
        while(*s != 0){
 8f2:	0f b6 03             	movzbl (%ebx),%eax
 8f5:	83 c4 10             	add    $0x10,%esp
 8f8:	84 c0                	test   %al,%al
 8fa:	75 e4                	jne    8e0 <fprintf+0xf0>
 8fc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 8ff:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 902:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 906:	83 c3 02             	add    $0x2,%ebx
 909:	84 d2                	test   %dl,%dl
 90b:	0f 84 7a ff ff ff    	je     88b <fprintf+0x9b>
    c = fmt[i] & 0xff;
 911:	0f b6 c2             	movzbl %dl,%eax
      if (c == '\f') { // Detect formfeed character
 914:	83 f8 0c             	cmp    $0xc,%eax
 917:	0f 85 ff fe ff ff    	jne    81c <fprintf+0x2c>
 91d:	8d 76 00             	lea    0x0(%esi),%esi
        setcursor();
 920:	e8 26 fa ff ff       	call   34b <setcursor>
  for(i = 0; fmt[i]; i++){
 925:	0f b6 13             	movzbl (%ebx),%edx
 928:	83 c3 01             	add    $0x1,%ebx
 92b:	84 d2                	test   %dl,%dl
 92d:	0f 85 dd fe ff ff    	jne    810 <fprintf+0x20>
 933:	e9 53 ff ff ff       	jmp    88b <fprintf+0x9b>
 938:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 93f:	00 
        printint(1, *ap, 10, 1, width, pad_char);
 940:	83 ec 08             	sub    $0x8,%esp
 943:	8b 06                	mov    (%esi),%eax
 945:	b9 01 00 00 00       	mov    $0x1,%ecx
 94a:	ba 0a 00 00 00       	mov    $0xa,%edx
 94f:	6a 20                	push   $0x20
 951:	6a 00                	push   $0x0
 953:	e9 50 ff ff ff       	jmp    8a8 <fprintf+0xb8>
 958:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 95f:	00 
        putc(fd, *ap);
 960:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
 962:	83 ec 04             	sub    $0x4,%esp
 965:	8d 7d e7             	lea    -0x19(%ebp),%edi
        putc(fd, *ap);
 968:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 96b:	6a 01                	push   $0x1
 96d:	57                   	push   %edi
 96e:	ff 75 08             	push   0x8(%ebp)
 971:	e8 3d f9 ff ff       	call   2b3 <write>
 976:	e9 32 ff ff ff       	jmp    8ad <fprintf+0xbd>
 97b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 980:	83 ec 04             	sub    $0x4,%esp
 983:	8d 45 e7             	lea    -0x19(%ebp),%eax
 986:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 989:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 98c:	6a 01                	push   $0x1
 98e:	50                   	push   %eax
 98f:	ff 75 08             	push   0x8(%ebp)
 992:	e8 1c f9 ff ff       	call   2b3 <write>
  for(i = 0; fmt[i]; i++){
 997:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 99b:	83 c4 10             	add    $0x10,%esp
 99e:	84 d2                	test   %dl,%dl
 9a0:	0f 85 6a fe ff ff    	jne    810 <fprintf+0x20>
}
 9a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9a9:	5b                   	pop    %ebx
 9aa:	5e                   	pop    %esi
 9ab:	5f                   	pop    %edi
 9ac:	5d                   	pop    %ebp
 9ad:	c3                   	ret
 9ae:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 9b0:	83 ec 04             	sub    $0x4,%esp
 9b3:	88 55 e7             	mov    %dl,-0x19(%ebp)
 9b6:	8d 7d e7             	lea    -0x19(%ebp),%edi
 9b9:	6a 01                	push   $0x1
 9bb:	e9 b4 fe ff ff       	jmp    874 <fprintf+0x84>
          s = "(null)";
 9c0:	bf 77 0b 00 00       	mov    $0xb77,%edi
 9c5:	b8 28 00 00 00       	mov    $0x28,%eax
 9ca:	e9 fd fe ff ff       	jmp    8cc <fprintf+0xdc>
 9cf:	66 90                	xchg   %ax,%ax
 9d1:	66 90                	xchg   %ax,%ax
 9d3:	66 90                	xchg   %ax,%ax
 9d5:	66 90                	xchg   %ax,%ax
 9d7:	66 90                	xchg   %ax,%ax
 9d9:	66 90                	xchg   %ax,%ax
 9db:	66 90                	xchg   %ax,%ax
 9dd:	66 90                	xchg   %ax,%ax
 9df:	90                   	nop

000009e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9e1:	a1 50 0f 00 00       	mov    0xf50,%eax
{
 9e6:	89 e5                	mov    %esp,%ebp
 9e8:	57                   	push   %edi
 9e9:	56                   	push   %esi
 9ea:	53                   	push   %ebx
 9eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 9ee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9f1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 9f8:	00 
 9f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a00:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a02:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a04:	39 ca                	cmp    %ecx,%edx
 a06:	73 30                	jae    a38 <free+0x58>
 a08:	39 c1                	cmp    %eax,%ecx
 a0a:	72 04                	jb     a10 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a0c:	39 c2                	cmp    %eax,%edx
 a0e:	72 f0                	jb     a00 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a10:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a13:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a16:	39 f8                	cmp    %edi,%eax
 a18:	74 36                	je     a50 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 a1a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 a1d:	8b 42 04             	mov    0x4(%edx),%eax
 a20:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 a23:	39 f1                	cmp    %esi,%ecx
 a25:	74 40                	je     a67 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 a27:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 a29:	5b                   	pop    %ebx
  freep = p;
 a2a:	89 15 50 0f 00 00    	mov    %edx,0xf50
}
 a30:	5e                   	pop    %esi
 a31:	5f                   	pop    %edi
 a32:	5d                   	pop    %ebp
 a33:	c3                   	ret
 a34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a38:	39 c2                	cmp    %eax,%edx
 a3a:	72 c4                	jb     a00 <free+0x20>
 a3c:	39 c1                	cmp    %eax,%ecx
 a3e:	73 c0                	jae    a00 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 a40:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a43:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a46:	39 f8                	cmp    %edi,%eax
 a48:	75 d0                	jne    a1a <free+0x3a>
 a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 a50:	03 70 04             	add    0x4(%eax),%esi
 a53:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 a56:	8b 02                	mov    (%edx),%eax
 a58:	8b 00                	mov    (%eax),%eax
 a5a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 a5d:	8b 42 04             	mov    0x4(%edx),%eax
 a60:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 a63:	39 f1                	cmp    %esi,%ecx
 a65:	75 c0                	jne    a27 <free+0x47>
    p->s.size += bp->s.size;
 a67:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 a6a:	89 15 50 0f 00 00    	mov    %edx,0xf50
    p->s.size += bp->s.size;
 a70:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 a73:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 a76:	89 0a                	mov    %ecx,(%edx)
}
 a78:	5b                   	pop    %ebx
 a79:	5e                   	pop    %esi
 a7a:	5f                   	pop    %edi
 a7b:	5d                   	pop    %ebp
 a7c:	c3                   	ret
 a7d:	8d 76 00             	lea    0x0(%esi),%esi

00000a80 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a80:	55                   	push   %ebp
 a81:	89 e5                	mov    %esp,%ebp
 a83:	57                   	push   %edi
 a84:	56                   	push   %esi
 a85:	53                   	push   %ebx
 a86:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a89:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 a8c:	8b 15 50 0f 00 00    	mov    0xf50,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a92:	8d 78 07             	lea    0x7(%eax),%edi
 a95:	c1 ef 03             	shr    $0x3,%edi
 a98:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 a9b:	85 d2                	test   %edx,%edx
 a9d:	0f 84 8d 00 00 00    	je     b30 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aa3:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 aa5:	8b 48 04             	mov    0x4(%eax),%ecx
 aa8:	39 f9                	cmp    %edi,%ecx
 aaa:	73 64                	jae    b10 <malloc+0x90>
  if(nu < 4096)
 aac:	bb 00 10 00 00       	mov    $0x1000,%ebx
 ab1:	39 df                	cmp    %ebx,%edi
 ab3:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 ab6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 abd:	eb 0a                	jmp    ac9 <malloc+0x49>
 abf:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ac0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 ac2:	8b 48 04             	mov    0x4(%eax),%ecx
 ac5:	39 f9                	cmp    %edi,%ecx
 ac7:	73 47                	jae    b10 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ac9:	89 c2                	mov    %eax,%edx
 acb:	39 05 50 0f 00 00    	cmp    %eax,0xf50
 ad1:	75 ed                	jne    ac0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 ad3:	83 ec 0c             	sub    $0xc,%esp
 ad6:	56                   	push   %esi
 ad7:	e8 3f f8 ff ff       	call   31b <sbrk>
  if(p == (char*)-1)
 adc:	83 c4 10             	add    $0x10,%esp
 adf:	83 f8 ff             	cmp    $0xffffffff,%eax
 ae2:	74 1c                	je     b00 <malloc+0x80>
  hp->s.size = nu;
 ae4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 ae7:	83 ec 0c             	sub    $0xc,%esp
 aea:	83 c0 08             	add    $0x8,%eax
 aed:	50                   	push   %eax
 aee:	e8 ed fe ff ff       	call   9e0 <free>
  return freep;
 af3:	8b 15 50 0f 00 00    	mov    0xf50,%edx
      if((p = morecore(nunits)) == 0)
 af9:	83 c4 10             	add    $0x10,%esp
 afc:	85 d2                	test   %edx,%edx
 afe:	75 c0                	jne    ac0 <malloc+0x40>
        return 0;
  }
}
 b00:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 b03:	31 c0                	xor    %eax,%eax
}
 b05:	5b                   	pop    %ebx
 b06:	5e                   	pop    %esi
 b07:	5f                   	pop    %edi
 b08:	5d                   	pop    %ebp
 b09:	c3                   	ret
 b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 b10:	39 cf                	cmp    %ecx,%edi
 b12:	74 4c                	je     b60 <malloc+0xe0>
        p->s.size -= nunits;
 b14:	29 f9                	sub    %edi,%ecx
 b16:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 b19:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 b1c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 b1f:	89 15 50 0f 00 00    	mov    %edx,0xf50
}
 b25:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 b28:	83 c0 08             	add    $0x8,%eax
}
 b2b:	5b                   	pop    %ebx
 b2c:	5e                   	pop    %esi
 b2d:	5f                   	pop    %edi
 b2e:	5d                   	pop    %ebp
 b2f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 b30:	c7 05 50 0f 00 00 54 	movl   $0xf54,0xf50
 b37:	0f 00 00 
    base.s.size = 0;
 b3a:	b8 54 0f 00 00       	mov    $0xf54,%eax
    base.s.ptr = freep = prevp = &base;
 b3f:	c7 05 54 0f 00 00 54 	movl   $0xf54,0xf54
 b46:	0f 00 00 
    base.s.size = 0;
 b49:	c7 05 58 0f 00 00 00 	movl   $0x0,0xf58
 b50:	00 00 00 
    if(p->s.size >= nunits){
 b53:	e9 54 ff ff ff       	jmp    aac <malloc+0x2c>
 b58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 b5f:	00 
        prevp->s.ptr = p->s.ptr;
 b60:	8b 08                	mov    (%eax),%ecx
 b62:	89 0a                	mov    %ecx,(%edx)
 b64:	eb b9                	jmp    b1f <malloc+0x9f>
