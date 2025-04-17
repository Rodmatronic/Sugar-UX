
_mkdir:     file format elf32-i386


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
   d:	57                   	push   %edi
   e:	bf 01 00 00 00       	mov    $0x1,%edi
  13:	56                   	push   %esi
  14:	53                   	push   %ebx
  15:	51                   	push   %ecx
  16:	83 ec 08             	sub    $0x8,%esp
  19:	8b 59 04             	mov    0x4(%ecx),%ebx
  1c:	8b 31                	mov    (%ecx),%esi
  1e:	83 c3 04             	add    $0x4,%ebx
  int i;

  if(argc < 2){
  21:	83 fe 01             	cmp    $0x1,%esi
  24:	7e 3d                	jle    63 <main+0x63>
  26:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  2d:	00 
  2e:	66 90                	xchg   %ax,%ax
    printf("Usage: mkdir files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
    if(mkdir(argv[i]) < 0){
  30:	83 ec 0c             	sub    $0xc,%esp
  33:	ff 33                	push   (%ebx)
  35:	e8 01 03 00 00       	call   33b <mkdir>
  3a:	83 c4 10             	add    $0x10,%esp
  3d:	85 c0                	test   %eax,%eax
  3f:	78 0f                	js     50 <main+0x50>
  for(i = 1; i < argc; i++){
  41:	83 c7 01             	add    $0x1,%edi
  44:	83 c3 04             	add    $0x4,%ebx
  47:	39 fe                	cmp    %edi,%esi
  49:	75 e5                	jne    30 <main+0x30>
      printf("mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit();
  4b:	e8 83 02 00 00       	call   2d3 <exit>
      printf("mkdir: %s failed to create\n", argv[i]);
  50:	50                   	push   %eax
  51:	50                   	push   %eax
  52:	ff 33                	push   (%ebx)
  54:	68 bf 0b 00 00       	push   $0xbbf
  59:	e8 f2 04 00 00       	call   550 <printf>
      break;
  5e:	83 c4 10             	add    $0x10,%esp
  61:	eb e8                	jmp    4b <main+0x4b>
    printf("Usage: mkdir files...\n");
  63:	83 ec 0c             	sub    $0xc,%esp
  66:	68 a8 0b 00 00       	push   $0xba8
  6b:	e8 e0 04 00 00       	call   550 <printf>
    exit();
  70:	e8 5e 02 00 00       	call   2d3 <exit>
  75:	66 90                	xchg   %ax,%ax
  77:	66 90                	xchg   %ax,%ax
  79:	66 90                	xchg   %ax,%ax
  7b:	66 90                	xchg   %ax,%ax
  7d:	66 90                	xchg   %ax,%ax
  7f:	90                   	nop

00000080 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  80:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  81:	31 c0                	xor    %eax,%eax
{
  83:	89 e5                	mov    %esp,%ebp
  85:	53                   	push   %ebx
  86:	8b 4d 08             	mov    0x8(%ebp),%ecx
  89:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  90:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  94:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  97:	83 c0 01             	add    $0x1,%eax
  9a:	84 d2                	test   %dl,%dl
  9c:	75 f2                	jne    90 <strcpy+0x10>
    ;
  return os;
}
  9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  a1:	89 c8                	mov    %ecx,%eax
  a3:	c9                   	leave
  a4:	c3                   	ret
  a5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  ac:	00 
  ad:	8d 76 00             	lea    0x0(%esi),%esi

000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	53                   	push   %ebx
  b4:	8b 55 08             	mov    0x8(%ebp),%edx
  b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  ba:	0f b6 02             	movzbl (%edx),%eax
  bd:	84 c0                	test   %al,%al
  bf:	75 2f                	jne    f0 <strcmp+0x40>
  c1:	eb 4a                	jmp    10d <strcmp+0x5d>
  c3:	eb 1b                	jmp    e0 <strcmp+0x30>
  c5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  cc:	00 
  cd:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  d4:	00 
  d5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  dc:	00 
  dd:	8d 76 00             	lea    0x0(%esi),%esi
  e0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  e4:	83 c2 01             	add    $0x1,%edx
  e7:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
  ea:	84 c0                	test   %al,%al
  ec:	74 12                	je     100 <strcmp+0x50>
  ee:	89 d9                	mov    %ebx,%ecx
  f0:	0f b6 19             	movzbl (%ecx),%ebx
  f3:	38 c3                	cmp    %al,%bl
  f5:	74 e9                	je     e0 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
  f7:	29 d8                	sub    %ebx,%eax
}
  f9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  fc:	c9                   	leave
  fd:	c3                   	ret
  fe:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 100:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 104:	31 c0                	xor    %eax,%eax
 106:	29 d8                	sub    %ebx,%eax
}
 108:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 10b:	c9                   	leave
 10c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 10d:	0f b6 19             	movzbl (%ecx),%ebx
 110:	31 c0                	xor    %eax,%eax
 112:	eb e3                	jmp    f7 <strcmp+0x47>
 114:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 11b:	00 
 11c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000120 <strlen>:

uint
strlen(char *s)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 126:	80 3a 00             	cmpb   $0x0,(%edx)
 129:	74 15                	je     140 <strlen+0x20>
 12b:	31 c0                	xor    %eax,%eax
 12d:	8d 76 00             	lea    0x0(%esi),%esi
 130:	83 c0 01             	add    $0x1,%eax
 133:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 137:	89 c1                	mov    %eax,%ecx
 139:	75 f5                	jne    130 <strlen+0x10>
    ;
  return n;
}
 13b:	89 c8                	mov    %ecx,%eax
 13d:	5d                   	pop    %ebp
 13e:	c3                   	ret
 13f:	90                   	nop
  for(n = 0; s[n]; n++)
 140:	31 c9                	xor    %ecx,%ecx
}
 142:	5d                   	pop    %ebp
 143:	89 c8                	mov    %ecx,%eax
 145:	c3                   	ret
 146:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 14d:	00 
 14e:	66 90                	xchg   %ax,%ax

00000150 <memset>:

void*
memset(void *dst, int c, uint n)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	57                   	push   %edi
 154:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 157:	8b 4d 10             	mov    0x10(%ebp),%ecx
 15a:	8b 45 0c             	mov    0xc(%ebp),%eax
 15d:	89 d7                	mov    %edx,%edi
 15f:	fc                   	cld
 160:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 162:	8b 7d fc             	mov    -0x4(%ebp),%edi
 165:	89 d0                	mov    %edx,%eax
 167:	c9                   	leave
 168:	c3                   	ret
 169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000170 <strchr>:

char*
strchr(const char *s, char c)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	8b 45 08             	mov    0x8(%ebp),%eax
 176:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 17a:	0f b6 10             	movzbl (%eax),%edx
 17d:	84 d2                	test   %dl,%dl
 17f:	75 1a                	jne    19b <strchr+0x2b>
 181:	eb 25                	jmp    1a8 <strchr+0x38>
 183:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 18a:	00 
 18b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 190:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 194:	83 c0 01             	add    $0x1,%eax
 197:	84 d2                	test   %dl,%dl
 199:	74 0d                	je     1a8 <strchr+0x38>
    if(*s == c)
 19b:	38 d1                	cmp    %dl,%cl
 19d:	75 f1                	jne    190 <strchr+0x20>
      return (char*)s;
  return 0;
}
 19f:	5d                   	pop    %ebp
 1a0:	c3                   	ret
 1a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 1a8:	31 c0                	xor    %eax,%eax
}
 1aa:	5d                   	pop    %ebp
 1ab:	c3                   	ret
 1ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001b0 <gets>:

char*
gets(char *buf, int max)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	57                   	push   %edi
 1b4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 1b5:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 1b8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 1b9:	31 db                	xor    %ebx,%ebx
{
 1bb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 1be:	eb 27                	jmp    1e7 <gets+0x37>
    cc = read(0, &c, 1);
 1c0:	83 ec 04             	sub    $0x4,%esp
 1c3:	6a 01                	push   $0x1
 1c5:	56                   	push   %esi
 1c6:	6a 00                	push   $0x0
 1c8:	e8 1e 01 00 00       	call   2eb <read>
    if(cc < 1)
 1cd:	83 c4 10             	add    $0x10,%esp
 1d0:	85 c0                	test   %eax,%eax
 1d2:	7e 1d                	jle    1f1 <gets+0x41>
      break;
    buf[i++] = c;
 1d4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1d8:	8b 55 08             	mov    0x8(%ebp),%edx
 1db:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 1df:	3c 0a                	cmp    $0xa,%al
 1e1:	74 10                	je     1f3 <gets+0x43>
 1e3:	3c 0d                	cmp    $0xd,%al
 1e5:	74 0c                	je     1f3 <gets+0x43>
  for(i=0; i+1 < max; ){
 1e7:	89 df                	mov    %ebx,%edi
 1e9:	83 c3 01             	add    $0x1,%ebx
 1ec:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1ef:	7c cf                	jl     1c0 <gets+0x10>
 1f1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 1fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1fd:	5b                   	pop    %ebx
 1fe:	5e                   	pop    %esi
 1ff:	5f                   	pop    %edi
 200:	5d                   	pop    %ebp
 201:	c3                   	ret
 202:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 209:	00 
 20a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000210 <stat>:

int
stat(char *n, struct stat *st)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	56                   	push   %esi
 214:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 215:	83 ec 08             	sub    $0x8,%esp
 218:	6a 00                	push   $0x0
 21a:	ff 75 08             	push   0x8(%ebp)
 21d:	e8 f1 00 00 00       	call   313 <open>
  if(fd < 0)
 222:	83 c4 10             	add    $0x10,%esp
 225:	85 c0                	test   %eax,%eax
 227:	78 27                	js     250 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 229:	83 ec 08             	sub    $0x8,%esp
 22c:	ff 75 0c             	push   0xc(%ebp)
 22f:	89 c3                	mov    %eax,%ebx
 231:	50                   	push   %eax
 232:	e8 f4 00 00 00       	call   32b <fstat>
  close(fd);
 237:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 23a:	89 c6                	mov    %eax,%esi
  close(fd);
 23c:	e8 ba 00 00 00       	call   2fb <close>
  return r;
 241:	83 c4 10             	add    $0x10,%esp
}
 244:	8d 65 f8             	lea    -0x8(%ebp),%esp
 247:	89 f0                	mov    %esi,%eax
 249:	5b                   	pop    %ebx
 24a:	5e                   	pop    %esi
 24b:	5d                   	pop    %ebp
 24c:	c3                   	ret
 24d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 250:	be ff ff ff ff       	mov    $0xffffffff,%esi
 255:	eb ed                	jmp    244 <stat+0x34>
 257:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 25e:	00 
 25f:	90                   	nop

00000260 <atoi>:

int
atoi(const char *s)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	53                   	push   %ebx
 264:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 267:	0f be 02             	movsbl (%edx),%eax
 26a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 26d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 270:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 275:	77 1e                	ja     295 <atoi+0x35>
 277:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 27e:	00 
 27f:	90                   	nop
    n = n*10 + *s++ - '0';
 280:	83 c2 01             	add    $0x1,%edx
 283:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 286:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 28a:	0f be 02             	movsbl (%edx),%eax
 28d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 290:	80 fb 09             	cmp    $0x9,%bl
 293:	76 eb                	jbe    280 <atoi+0x20>
  return n;
}
 295:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 298:	89 c8                	mov    %ecx,%eax
 29a:	c9                   	leave
 29b:	c3                   	ret
 29c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002a0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	57                   	push   %edi
 2a4:	8b 45 10             	mov    0x10(%ebp),%eax
 2a7:	8b 55 08             	mov    0x8(%ebp),%edx
 2aa:	56                   	push   %esi
 2ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ae:	85 c0                	test   %eax,%eax
 2b0:	7e 13                	jle    2c5 <memmove+0x25>
 2b2:	01 d0                	add    %edx,%eax
  dst = vdst;
 2b4:	89 d7                	mov    %edx,%edi
 2b6:	66 90                	xchg   %ax,%ax
 2b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2bf:	00 
    *dst++ = *src++;
 2c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2c1:	39 f8                	cmp    %edi,%eax
 2c3:	75 fb                	jne    2c0 <memmove+0x20>
  return vdst;
}
 2c5:	5e                   	pop    %esi
 2c6:	89 d0                	mov    %edx,%eax
 2c8:	5f                   	pop    %edi
 2c9:	5d                   	pop    %ebp
 2ca:	c3                   	ret

000002cb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2cb:	b8 01 00 00 00       	mov    $0x1,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret

000002d3 <exit>:
SYSCALL(exit)
 2d3:	b8 02 00 00 00       	mov    $0x2,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret

000002db <wait>:
SYSCALL(wait)
 2db:	b8 03 00 00 00       	mov    $0x3,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret

000002e3 <pipe>:
SYSCALL(pipe)
 2e3:	b8 04 00 00 00       	mov    $0x4,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret

000002eb <read>:
SYSCALL(read)
 2eb:	b8 05 00 00 00       	mov    $0x5,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret

000002f3 <write>:
SYSCALL(write)
 2f3:	b8 10 00 00 00       	mov    $0x10,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret

000002fb <close>:
SYSCALL(close)
 2fb:	b8 15 00 00 00       	mov    $0x15,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret

00000303 <kill>:
SYSCALL(kill)
 303:	b8 06 00 00 00       	mov    $0x6,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret

0000030b <exec>:
SYSCALL(exec)
 30b:	b8 07 00 00 00       	mov    $0x7,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret

00000313 <open>:
SYSCALL(open)
 313:	b8 0f 00 00 00       	mov    $0xf,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret

0000031b <mknod>:
SYSCALL(mknod)
 31b:	b8 11 00 00 00       	mov    $0x11,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret

00000323 <unlink>:
SYSCALL(unlink)
 323:	b8 12 00 00 00       	mov    $0x12,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret

0000032b <fstat>:
SYSCALL(fstat)
 32b:	b8 08 00 00 00       	mov    $0x8,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret

00000333 <link>:
SYSCALL(link)
 333:	b8 13 00 00 00       	mov    $0x13,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret

0000033b <mkdir>:
SYSCALL(mkdir)
 33b:	b8 14 00 00 00       	mov    $0x14,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret

00000343 <chdir>:
SYSCALL(chdir)
 343:	b8 09 00 00 00       	mov    $0x9,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret

0000034b <dup>:
SYSCALL(dup)
 34b:	b8 0a 00 00 00       	mov    $0xa,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <getpid>:
SYSCALL(getpid)
 353:	b8 0b 00 00 00       	mov    $0xb,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <sbrk>:
SYSCALL(sbrk)
 35b:	b8 0c 00 00 00       	mov    $0xc,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <sleep>:
SYSCALL(sleep)
 363:	b8 0d 00 00 00       	mov    $0xd,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <uptime>:
SYSCALL(uptime)
 36b:	b8 0e 00 00 00       	mov    $0xe,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <bstat>:
SYSCALL(bstat)
 373:	b8 16 00 00 00       	mov    $0x16,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <swap>:
SYSCALL(swap)
 37b:	b8 17 00 00 00       	mov    $0x17,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

00000383 <gettime>:
SYSCALL(gettime)
 383:	b8 18 00 00 00       	mov    $0x18,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

0000038b <setcursor>:
SYSCALL(setcursor)
 38b:	b8 19 00 00 00       	mov    $0x19,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <uname>:
SYSCALL(uname)
 393:	b8 1a 00 00 00       	mov    $0x1a,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <echo>:
SYSCALL(echo)
 39b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret
 3a3:	66 90                	xchg   %ax,%ax
 3a5:	66 90                	xchg   %ax,%ax
 3a7:	66 90                	xchg   %ax,%ax
 3a9:	66 90                	xchg   %ax,%ax
 3ab:	66 90                	xchg   %ax,%ax
 3ad:	66 90                	xchg   %ax,%ax
 3af:	66 90                	xchg   %ax,%ax
 3b1:	66 90                	xchg   %ax,%ax
 3b3:	66 90                	xchg   %ax,%ax
 3b5:	66 90                	xchg   %ax,%ax
 3b7:	66 90                	xchg   %ax,%ax
 3b9:	66 90                	xchg   %ax,%ax
 3bb:	66 90                	xchg   %ax,%ax
 3bd:	66 90                	xchg   %ax,%ax
 3bf:	90                   	nop

000003c0 <printint.constprop.0>:
{
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn, int width, char pad_char)
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	57                   	push   %edi
 3c4:	56                   	push   %esi
 3c5:	89 c6                	mov    %eax,%esi
 3c7:	53                   	push   %ebx
 3c8:	89 d3                	mov    %edx,%ebx
 3ca:	83 ec 3c             	sub    $0x3c,%esp
 3cd:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3d1:	85 f6                	test   %esi,%esi
 3d3:	0f 89 d7 00 00 00    	jns    4b0 <printint.constprop.0+0xf0>
 3d9:	83 e1 01             	and    $0x1,%ecx
 3dc:	0f 84 ce 00 00 00    	je     4b0 <printint.constprop.0+0xf0>
    neg = 1;
 3e2:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 3e9:	f7 de                	neg    %esi
 3eb:	89 f1                	mov    %esi,%ecx
  } else {
    x = xx;
  }

  i = 0;
 3ed:	88 45 bf             	mov    %al,-0x41(%ebp)
 3f0:	31 ff                	xor    %edi,%edi
 3f2:	8d 75 d7             	lea    -0x29(%ebp),%esi
 3f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3fc:	00 
 3fd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 400:	89 c8                	mov    %ecx,%eax
 402:	31 d2                	xor    %edx,%edx
 404:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 407:	83 c7 01             	add    $0x1,%edi
 40a:	f7 f3                	div    %ebx
 40c:	0f b6 92 94 0c 00 00 	movzbl 0xc94(%edx),%edx
 413:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 416:	89 ca                	mov    %ecx,%edx
 418:	89 c1                	mov    %eax,%ecx
 41a:	39 da                	cmp    %ebx,%edx
 41c:	73 e2                	jae    400 <printint.constprop.0+0x40>

  if(neg)
 41e:	8b 55 c0             	mov    -0x40(%ebp),%edx
 421:	0f b6 45 bf          	movzbl -0x41(%ebp),%eax
 425:	85 d2                	test   %edx,%edx
 427:	74 0b                	je     434 <printint.constprop.0+0x74>
    buf[i++] = '-';
 429:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
 42c:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 431:	8d 79 02             	lea    0x2(%ecx),%edi

  // Pad with pad_char until we hit the required width
  while(i < width)
 434:	39 7d 08             	cmp    %edi,0x8(%ebp)
 437:	0f 8e 83 00 00 00    	jle    4c0 <printint.constprop.0+0x100>
 43d:	8b 55 08             	mov    0x8(%ebp),%edx
 440:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 443:	01 df                	add    %ebx,%edi
 445:	01 da                	add    %ebx,%edx
 447:	89 d1                	mov    %edx,%ecx
 449:	29 f9                	sub    %edi,%ecx
 44b:	83 e1 01             	and    $0x1,%ecx
 44e:	74 10                	je     460 <printint.constprop.0+0xa0>
    buf[i++] = pad_char;
 450:	88 07                	mov    %al,(%edi)
  while(i < width)
 452:	83 c7 01             	add    $0x1,%edi
 455:	39 d7                	cmp    %edx,%edi
 457:	74 13                	je     46c <printint.constprop.0+0xac>
 459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = pad_char;
 460:	88 07                	mov    %al,(%edi)
  while(i < width)
 462:	83 c7 02             	add    $0x2,%edi
    buf[i++] = pad_char;
 465:	88 47 ff             	mov    %al,-0x1(%edi)
  while(i < width)
 468:	39 d7                	cmp    %edx,%edi
 46a:	75 f4                	jne    460 <printint.constprop.0+0xa0>
 46c:	8b 45 08             	mov    0x8(%ebp),%eax
 46f:	8d 78 ff             	lea    -0x1(%eax),%edi

  while(--i >= 0)
 472:	01 df                	add    %ebx,%edi
 474:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 47b:	00 
 47c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 480:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 483:	83 ec 04             	sub    $0x4,%esp
 486:	88 45 d7             	mov    %al,-0x29(%ebp)
 489:	6a 01                	push   $0x1
 48b:	56                   	push   %esi
 48c:	6a 01                	push   $0x1
 48e:	e8 60 fe ff ff       	call   2f3 <write>
  while(--i >= 0)
 493:	89 f8                	mov    %edi,%eax
 495:	83 c4 10             	add    $0x10,%esp
 498:	83 ef 01             	sub    $0x1,%edi
 49b:	39 d8                	cmp    %ebx,%eax
 49d:	75 e1                	jne    480 <printint.constprop.0+0xc0>
}
 49f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4a2:	5b                   	pop    %ebx
 4a3:	5e                   	pop    %esi
 4a4:	5f                   	pop    %edi
 4a5:	5d                   	pop    %ebp
 4a6:	c3                   	ret
 4a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4ae:	00 
 4af:	90                   	nop
  neg = 0;
 4b0:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = xx;
 4b7:	89 f1                	mov    %esi,%ecx
 4b9:	e9 2f ff ff ff       	jmp    3ed <printint.constprop.0+0x2d>
 4be:	66 90                	xchg   %ax,%ax
  while(--i >= 0)
 4c0:	83 ef 01             	sub    $0x1,%edi
 4c3:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 4c6:	eb aa                	jmp    472 <printint.constprop.0+0xb2>
 4c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4cf:	00 

000004d0 <strncpy>:
{
 4d0:	55                   	push   %ebp
 4d1:	31 c0                	xor    %eax,%eax
 4d3:	89 e5                	mov    %esp,%ebp
 4d5:	56                   	push   %esi
 4d6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 4d9:	8b 75 0c             	mov    0xc(%ebp),%esi
 4dc:	53                   	push   %ebx
 4dd:	8b 5d 10             	mov    0x10(%ebp),%ebx
  for (i = 0; i < n && src[i]; i++)
 4e0:	85 db                	test   %ebx,%ebx
 4e2:	7f 26                	jg     50a <strncpy+0x3a>
 4e4:	eb 58                	jmp    53e <strncpy+0x6e>
 4e6:	eb 18                	jmp    500 <strncpy+0x30>
 4e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4ef:	00 
 4f0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4f7:	00 
 4f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4ff:	00 
    dest[i] = src[i];
 500:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  for (i = 0; i < n && src[i]; i++)
 503:	83 c0 01             	add    $0x1,%eax
 506:	39 c3                	cmp    %eax,%ebx
 508:	74 34                	je     53e <strncpy+0x6e>
 50a:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
 50e:	84 d2                	test   %dl,%dl
 510:	75 ee                	jne    500 <strncpy+0x30>
  for (; i < n; i++)
 512:	39 c3                	cmp    %eax,%ebx
 514:	7e 28                	jle    53e <strncpy+0x6e>
 516:	01 c8                	add    %ecx,%eax
 518:	01 d9                	add    %ebx,%ecx
 51a:	89 ca                	mov    %ecx,%edx
 51c:	29 c2                	sub    %eax,%edx
 51e:	83 e2 01             	and    $0x1,%edx
 521:	74 0d                	je     530 <strncpy+0x60>
    dest[i] = '\0';
 523:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
 526:	83 c0 01             	add    $0x1,%eax
 529:	39 c8                	cmp    %ecx,%eax
 52b:	74 11                	je     53e <strncpy+0x6e>
 52d:	8d 76 00             	lea    0x0(%esi),%esi
    dest[i] = '\0';
 530:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
 533:	83 c0 02             	add    $0x2,%eax
    dest[i] = '\0';
 536:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  for (; i < n; i++)
 53a:	39 c8                	cmp    %ecx,%eax
 53c:	75 f2                	jne    530 <strncpy+0x60>
}
 53e:	5b                   	pop    %ebx
 53f:	5e                   	pop    %esi
 540:	5d                   	pop    %ebp
 541:	c3                   	ret
 542:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 549:	00 
 54a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000550 <printf>:

void
printf(char *fmt, ...)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	57                   	push   %edi
 554:	56                   	push   %esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 555:	8d 75 0c             	lea    0xc(%ebp),%esi
{
 558:	53                   	push   %ebx
 559:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  for(i = 0; fmt[i]; i++){
 55c:	8b 55 08             	mov    0x8(%ebp),%edx
  ap = (uint*)(void*)&fmt + 1;
 55f:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 562:	0f b6 02             	movzbl (%edx),%eax
 565:	84 c0                	test   %al,%al
 567:	0f 84 88 00 00 00    	je     5f5 <printf+0xa5>
 56d:	8d 7a 01             	lea    0x1(%edx),%edi
    c = fmt[i] & 0xff;
 570:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
      if (c == '\f') {
 573:	83 fa 0c             	cmp    $0xc,%edx
 576:	0f 84 d4 01 00 00    	je     750 <printf+0x200>
        setcursor();
      } else if(c == '%'){
 57c:	83 fa 25             	cmp    $0x25,%edx
 57f:	0f 85 0b 02 00 00    	jne    790 <printf+0x240>
  for(i = 0; fmt[i]; i++){
 585:	0f b6 1f             	movzbl (%edi),%ebx
 588:	83 c7 01             	add    $0x1,%edi
 58b:	84 db                	test   %bl,%bl
 58d:	74 66                	je     5f5 <printf+0xa5>
    c = fmt[i] & 0xff;
 58f:	0f b6 c3             	movzbl %bl,%eax
 592:	ba 20 00 00 00       	mov    $0x20,%edx
 597:	31 c9                	xor    %ecx,%ecx
        pad_char = ' ';
      } else {
        putc(1, c);
      }
    } else if(state == '%'){
      if(c == '0'){
 599:	83 f8 78             	cmp    $0x78,%eax
 59c:	7f 22                	jg     5c0 <printf+0x70>
 59e:	83 f8 62             	cmp    $0x62,%eax
 5a1:	0f 8e b9 01 00 00    	jle    760 <printf+0x210>
 5a7:	83 e8 63             	sub    $0x63,%eax
 5aa:	83 f8 15             	cmp    $0x15,%eax
 5ad:	77 11                	ja     5c0 <printf+0x70>
 5af:	ff 24 85 e4 0b 00 00 	jmp    *0xbe4(,%eax,4)
 5b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5bd:	00 
 5be:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 5c0:	83 ec 04             	sub    $0x4,%esp
 5c3:	8d 75 e7             	lea    -0x19(%ebp),%esi
 5c6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5ca:	6a 01                	push   $0x1
 5cc:	56                   	push   %esi
 5cd:	6a 01                	push   $0x1
 5cf:	e8 1f fd ff ff       	call   2f3 <write>
 5d4:	83 c4 0c             	add    $0xc,%esp
 5d7:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5da:	6a 01                	push   $0x1
 5dc:	56                   	push   %esi
 5dd:	6a 01                	push   $0x1
 5df:	e8 0f fd ff ff       	call   2f3 <write>
      } else if(c == '%'){
        putc(1, '%');
        state = 0;
      } else {
        putc(1, '%');
        putc(1, c);
 5e4:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 5e7:	0f b6 07             	movzbl (%edi),%eax
 5ea:	83 c7 01             	add    $0x1,%edi
 5ed:	84 c0                	test   %al,%al
 5ef:	0f 85 7b ff ff ff    	jne    570 <printf+0x20>
        state = 0;
      }
    }
  }
}
 5f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5f8:	5b                   	pop    %ebx
 5f9:	5e                   	pop    %esi
 5fa:	5f                   	pop    %edi
 5fb:	5d                   	pop    %ebp
 5fc:	c3                   	ret
 5fd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 16, 0, width, pad_char);
 600:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 603:	83 ec 08             	sub    $0x8,%esp
 606:	8b 06                	mov    (%esi),%eax
 608:	52                   	push   %edx
 609:	ba 10 00 00 00       	mov    $0x10,%edx
 60e:	51                   	push   %ecx
 60f:	31 c9                	xor    %ecx,%ecx
        printint(1, *ap, 10, 1, width, pad_char);
 611:	e8 aa fd ff ff       	call   3c0 <printint.constprop.0>
        ap++;
 616:	83 c6 04             	add    $0x4,%esi
 619:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 61c:	0f b6 07             	movzbl (%edi),%eax
 61f:	83 c7 01             	add    $0x1,%edi
 622:	83 c4 10             	add    $0x10,%esp
 625:	84 c0                	test   %al,%al
 627:	0f 85 43 ff ff ff    	jne    570 <printf+0x20>
}
 62d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 630:	5b                   	pop    %ebx
 631:	5e                   	pop    %esi
 632:	5f                   	pop    %edi
 633:	5d                   	pop    %ebp
 634:	c3                   	ret
 635:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 10, 1, width, pad_char);
 638:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 63b:	83 ec 08             	sub    $0x8,%esp
 63e:	8b 06                	mov    (%esi),%eax
 640:	52                   	push   %edx
 641:	ba 0a 00 00 00       	mov    $0xa,%edx
 646:	51                   	push   %ecx
 647:	b9 01 00 00 00       	mov    $0x1,%ecx
 64c:	eb c3                	jmp    611 <printf+0xc1>
 64e:	66 90                	xchg   %ax,%ax
        s = (char*)*ap;
 650:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 653:	8b 06                	mov    (%esi),%eax
        ap++;
 655:	83 c6 04             	add    $0x4,%esi
 658:	89 75 d4             	mov    %esi,-0x2c(%ebp)
        if(s == 0)
 65b:	85 c0                	test   %eax,%eax
 65d:	0f 85 9d 01 00 00    	jne    800 <printf+0x2b0>
 663:	c6 45 d0 28          	movb   $0x28,-0x30(%ebp)
          s = "(null)";
 667:	b8 db 0b 00 00       	mov    $0xbdb,%eax
        int len = 0;
 66c:	31 db                	xor    %ebx,%ebx
 66e:	66 90                	xchg   %ax,%ax
        for (char *t = s; *t; t++) len++;
 670:	83 c3 01             	add    $0x1,%ebx
 673:	80 3c 18 00          	cmpb   $0x0,(%eax,%ebx,1)
 677:	75 f7                	jne    670 <printf+0x120>
        for (int j = len; j < width; j++)
 679:	39 cb                	cmp    %ecx,%ebx
 67b:	0f 8d 9c 01 00 00    	jge    81d <printf+0x2cd>
 681:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 684:	8d 75 e7             	lea    -0x19(%ebp),%esi
 687:	89 45 c8             	mov    %eax,-0x38(%ebp)
 68a:	89 7d cc             	mov    %edi,-0x34(%ebp)
 68d:	89 df                	mov    %ebx,%edi
 68f:	89 d3                	mov    %edx,%ebx
 691:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 698:	00 
 699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 6a0:	83 ec 04             	sub    $0x4,%esp
 6a3:	88 5d e7             	mov    %bl,-0x19(%ebp)
        for (int j = len; j < width; j++)
 6a6:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 6a9:	6a 01                	push   $0x1
 6ab:	56                   	push   %esi
 6ac:	6a 01                	push   $0x1
 6ae:	e8 40 fc ff ff       	call   2f3 <write>
        for (int j = len; j < width; j++)
 6b3:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6b6:	83 c4 10             	add    $0x10,%esp
 6b9:	39 c7                	cmp    %eax,%edi
 6bb:	7c e3                	jl     6a0 <printf+0x150>
        while(*s != 0){
 6bd:	8b 45 c8             	mov    -0x38(%ebp),%eax
 6c0:	8b 7d cc             	mov    -0x34(%ebp),%edi
 6c3:	0f b6 08             	movzbl (%eax),%ecx
 6c6:	88 4d d0             	mov    %cl,-0x30(%ebp)
 6c9:	84 c9                	test   %cl,%cl
 6cb:	0f 84 16 ff ff ff    	je     5e7 <printf+0x97>
 6d1:	89 c3                	mov    %eax,%ebx
 6d3:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 6d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6de:	00 
 6df:	90                   	nop
  write(fd, &c, 1);
 6e0:	83 ec 04             	sub    $0x4,%esp
 6e3:	88 45 e7             	mov    %al,-0x19(%ebp)
          putc(1, *s++);
 6e6:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 6e9:	6a 01                	push   $0x1
 6eb:	56                   	push   %esi
 6ec:	6a 01                	push   $0x1
 6ee:	e8 00 fc ff ff       	call   2f3 <write>
        while(*s != 0){
 6f3:	0f b6 03             	movzbl (%ebx),%eax
 6f6:	83 c4 10             	add    $0x10,%esp
 6f9:	84 c0                	test   %al,%al
 6fb:	75 e3                	jne    6e0 <printf+0x190>
 6fd:	e9 e5 fe ff ff       	jmp    5e7 <printf+0x97>
 702:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        char ch = *ap++;
 708:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 70b:	83 ec 04             	sub    $0x4,%esp
 70e:	8d 75 e7             	lea    -0x19(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 711:	83 c7 01             	add    $0x1,%edi
        char ch = *ap++;
 714:	8d 58 04             	lea    0x4(%eax),%ebx
 717:	8b 00                	mov    (%eax),%eax
 719:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 71c:	6a 01                	push   $0x1
 71e:	56                   	push   %esi
 71f:	6a 01                	push   $0x1
 721:	e8 cd fb ff ff       	call   2f3 <write>
  for(i = 0; fmt[i]; i++){
 726:	0f b6 47 ff          	movzbl -0x1(%edi),%eax
 72a:	83 c4 10             	add    $0x10,%esp
 72d:	84 c0                	test   %al,%al
 72f:	0f 84 c0 fe ff ff    	je     5f5 <printf+0xa5>
    c = fmt[i] & 0xff;
 735:	0f b6 d0             	movzbl %al,%edx
        char ch = *ap++;
 738:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      if (c == '\f') {
 73b:	83 fa 0c             	cmp    $0xc,%edx
 73e:	0f 85 38 fe ff ff    	jne    57c <printf+0x2c>
 744:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 74b:	00 
 74c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        setcursor();
 750:	e8 36 fc ff ff       	call   38b <setcursor>
 755:	e9 8d fe ff ff       	jmp    5e7 <printf+0x97>
 75a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 760:	83 f8 30             	cmp    $0x30,%eax
 763:	74 7b                	je     7e0 <printf+0x290>
 765:	7f 49                	jg     7b0 <printf+0x260>
 767:	83 f8 25             	cmp    $0x25,%eax
 76a:	0f 85 50 fe ff ff    	jne    5c0 <printf+0x70>
  write(fd, &c, 1);
 770:	83 ec 04             	sub    $0x4,%esp
 773:	8d 75 e7             	lea    -0x19(%ebp),%esi
 776:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 77a:	6a 01                	push   $0x1
 77c:	56                   	push   %esi
 77d:	6a 01                	push   $0x1
 77f:	e8 6f fb ff ff       	call   2f3 <write>
        state = 0;
 784:	83 c4 10             	add    $0x10,%esp
 787:	e9 5b fe ff ff       	jmp    5e7 <printf+0x97>
 78c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 790:	83 ec 04             	sub    $0x4,%esp
 793:	8d 75 e7             	lea    -0x19(%ebp),%esi
 796:	88 45 e7             	mov    %al,-0x19(%ebp)
 799:	6a 01                	push   $0x1
 79b:	56                   	push   %esi
 79c:	6a 01                	push   $0x1
 79e:	e8 50 fb ff ff       	call   2f3 <write>
  for(i = 0; fmt[i]; i++){
 7a3:	e9 74 fe ff ff       	jmp    61c <printf+0xcc>
 7a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7af:	00 
 7b0:	8d 70 cf             	lea    -0x31(%eax),%esi
 7b3:	83 fe 08             	cmp    $0x8,%esi
 7b6:	0f 87 04 fe ff ff    	ja     5c0 <printf+0x70>
 7bc:	0f b6 1f             	movzbl (%edi),%ebx
        width = width * 10 + (c - '0');
 7bf:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
  for(i = 0; fmt[i]; i++){
 7c2:	83 c7 01             	add    $0x1,%edi
        width = width * 10 + (c - '0');
 7c5:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  for(i = 0; fmt[i]; i++){
 7c9:	84 db                	test   %bl,%bl
 7cb:	0f 84 24 fe ff ff    	je     5f5 <printf+0xa5>
    c = fmt[i] & 0xff;
 7d1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 7d4:	e9 c0 fd ff ff       	jmp    599 <printf+0x49>
 7d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 7e0:	0f b6 1f             	movzbl (%edi),%ebx
 7e3:	83 c7 01             	add    $0x1,%edi
 7e6:	84 db                	test   %bl,%bl
 7e8:	0f 84 07 fe ff ff    	je     5f5 <printf+0xa5>
    c = fmt[i] & 0xff;
 7ee:	0f b6 c3             	movzbl %bl,%eax
 7f1:	ba 30 00 00 00       	mov    $0x30,%edx
 7f6:	e9 9e fd ff ff       	jmp    599 <printf+0x49>
 7fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        for (char *t = s; *t; t++) len++;
 800:	0f b6 18             	movzbl (%eax),%ebx
 803:	88 5d d0             	mov    %bl,-0x30(%ebp)
 806:	84 db                	test   %bl,%bl
 808:	0f 85 5e fe ff ff    	jne    66c <printf+0x11c>
        int len = 0;
 80e:	31 db                	xor    %ebx,%ebx
        for (int j = len; j < width; j++)
 810:	85 c9                	test   %ecx,%ecx
 812:	0f 8f 69 fe ff ff    	jg     681 <printf+0x131>
 818:	e9 ca fd ff ff       	jmp    5e7 <printf+0x97>
 81d:	89 c2                	mov    %eax,%edx
 81f:	8d 75 e7             	lea    -0x19(%ebp),%esi
 822:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 826:	89 d3                	mov    %edx,%ebx
 828:	e9 b3 fe ff ff       	jmp    6e0 <printf+0x190>
 82d:	8d 76 00             	lea    0x0(%esi),%esi

00000830 <fprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
fprintf(int fd, char *fmt, ...)
{
 830:	55                   	push   %ebp
 831:	89 e5                	mov    %esp,%ebp
 833:	57                   	push   %edi
 834:	56                   	push   %esi
 835:	53                   	push   %ebx
 836:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 839:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 83c:	0f b6 13             	movzbl (%ebx),%edx
 83f:	83 c3 01             	add    $0x1,%ebx
 842:	84 d2                	test   %dl,%dl
 844:	0f 84 81 00 00 00    	je     8cb <fprintf+0x9b>
 84a:	8d 75 10             	lea    0x10(%ebp),%esi
 84d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 850:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if (c == '\f') { // Detect formfeed character
 853:	83 f8 0c             	cmp    $0xc,%eax
 856:	0f 84 04 01 00 00    	je     960 <fprintf+0x130>
        setcursor();
      } else
      if(c == '%'){
 85c:	83 f8 25             	cmp    $0x25,%eax
 85f:	0f 85 5b 01 00 00    	jne    9c0 <fprintf+0x190>
  for(i = 0; fmt[i]; i++){
 865:	0f b6 13             	movzbl (%ebx),%edx
 868:	84 d2                	test   %dl,%dl
 86a:	74 5f                	je     8cb <fprintf+0x9b>
    c = fmt[i] & 0xff;
 86c:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 86f:	80 fa 25             	cmp    $0x25,%dl
 872:	0f 84 78 01 00 00    	je     9f0 <fprintf+0x1c0>
 878:	83 e8 63             	sub    $0x63,%eax
 87b:	83 f8 15             	cmp    $0x15,%eax
 87e:	77 10                	ja     890 <fprintf+0x60>
 880:	ff 24 85 3c 0c 00 00 	jmp    *0xc3c(,%eax,4)
 887:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 88e:	00 
 88f:	90                   	nop
  write(fd, &c, 1);
 890:	83 ec 04             	sub    $0x4,%esp
 893:	8d 7d e7             	lea    -0x19(%ebp),%edi
 896:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 899:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 89d:	6a 01                	push   $0x1
 89f:	57                   	push   %edi
 8a0:	ff 75 08             	push   0x8(%ebp)
 8a3:	e8 4b fa ff ff       	call   2f3 <write>
        putc(fd, c);
 8a8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 8ac:	83 c4 0c             	add    $0xc,%esp
 8af:	88 55 e7             	mov    %dl,-0x19(%ebp)
 8b2:	6a 01                	push   $0x1
 8b4:	57                   	push   %edi
 8b5:	ff 75 08             	push   0x8(%ebp)
 8b8:	e8 36 fa ff ff       	call   2f3 <write>
  for(i = 0; fmt[i]; i++){
 8bd:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 8c1:	83 c3 02             	add    $0x2,%ebx
 8c4:	83 c4 10             	add    $0x10,%esp
 8c7:	84 d2                	test   %dl,%dl
 8c9:	75 85                	jne    850 <fprintf+0x20>
      }
      state = 0;
    }
  }
}
 8cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8ce:	5b                   	pop    %ebx
 8cf:	5e                   	pop    %esi
 8d0:	5f                   	pop    %edi
 8d1:	5d                   	pop    %ebp
 8d2:	c3                   	ret
 8d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(1, *ap, 16, 0, width, pad_char);
 8d8:	83 ec 08             	sub    $0x8,%esp
 8db:	8b 06                	mov    (%esi),%eax
 8dd:	31 c9                	xor    %ecx,%ecx
 8df:	ba 10 00 00 00       	mov    $0x10,%edx
 8e4:	6a 20                	push   $0x20
 8e6:	6a 00                	push   $0x0
 8e8:	e8 d3 fa ff ff       	call   3c0 <printint.constprop.0>
        ap++;
 8ed:	83 c6 04             	add    $0x4,%esi
  for(i = 0; fmt[i]; i++){
 8f0:	eb cb                	jmp    8bd <fprintf+0x8d>
 8f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s = (char*)*ap;
 8f8:	8b 3e                	mov    (%esi),%edi
        ap++;
 8fa:	83 c6 04             	add    $0x4,%esi
        if(s == 0)
 8fd:	85 ff                	test   %edi,%edi
 8ff:	0f 84 fb 00 00 00    	je     a00 <fprintf+0x1d0>
        while(*s != 0){
 905:	0f b6 07             	movzbl (%edi),%eax
 908:	84 c0                	test   %al,%al
 90a:	74 36                	je     942 <fprintf+0x112>
 90c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 90f:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 912:	8b 75 08             	mov    0x8(%ebp),%esi
 915:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 918:	89 fb                	mov    %edi,%ebx
 91a:	89 cf                	mov    %ecx,%edi
 91c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 920:	83 ec 04             	sub    $0x4,%esp
 923:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 926:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 929:	6a 01                	push   $0x1
 92b:	57                   	push   %edi
 92c:	56                   	push   %esi
 92d:	e8 c1 f9 ff ff       	call   2f3 <write>
        while(*s != 0){
 932:	0f b6 03             	movzbl (%ebx),%eax
 935:	83 c4 10             	add    $0x10,%esp
 938:	84 c0                	test   %al,%al
 93a:	75 e4                	jne    920 <fprintf+0xf0>
 93c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 93f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 942:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 946:	83 c3 02             	add    $0x2,%ebx
 949:	84 d2                	test   %dl,%dl
 94b:	0f 84 7a ff ff ff    	je     8cb <fprintf+0x9b>
    c = fmt[i] & 0xff;
 951:	0f b6 c2             	movzbl %dl,%eax
      if (c == '\f') { // Detect formfeed character
 954:	83 f8 0c             	cmp    $0xc,%eax
 957:	0f 85 ff fe ff ff    	jne    85c <fprintf+0x2c>
 95d:	8d 76 00             	lea    0x0(%esi),%esi
        setcursor();
 960:	e8 26 fa ff ff       	call   38b <setcursor>
  for(i = 0; fmt[i]; i++){
 965:	0f b6 13             	movzbl (%ebx),%edx
 968:	83 c3 01             	add    $0x1,%ebx
 96b:	84 d2                	test   %dl,%dl
 96d:	0f 85 dd fe ff ff    	jne    850 <fprintf+0x20>
 973:	e9 53 ff ff ff       	jmp    8cb <fprintf+0x9b>
 978:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 97f:	00 
        printint(1, *ap, 10, 1, width, pad_char);
 980:	83 ec 08             	sub    $0x8,%esp
 983:	8b 06                	mov    (%esi),%eax
 985:	b9 01 00 00 00       	mov    $0x1,%ecx
 98a:	ba 0a 00 00 00       	mov    $0xa,%edx
 98f:	6a 20                	push   $0x20
 991:	6a 00                	push   $0x0
 993:	e9 50 ff ff ff       	jmp    8e8 <fprintf+0xb8>
 998:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 99f:	00 
        putc(fd, *ap);
 9a0:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
 9a2:	83 ec 04             	sub    $0x4,%esp
 9a5:	8d 7d e7             	lea    -0x19(%ebp),%edi
        putc(fd, *ap);
 9a8:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 9ab:	6a 01                	push   $0x1
 9ad:	57                   	push   %edi
 9ae:	ff 75 08             	push   0x8(%ebp)
 9b1:	e8 3d f9 ff ff       	call   2f3 <write>
 9b6:	e9 32 ff ff ff       	jmp    8ed <fprintf+0xbd>
 9bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 9c0:	83 ec 04             	sub    $0x4,%esp
 9c3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 9c6:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 9c9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 9cc:	6a 01                	push   $0x1
 9ce:	50                   	push   %eax
 9cf:	ff 75 08             	push   0x8(%ebp)
 9d2:	e8 1c f9 ff ff       	call   2f3 <write>
  for(i = 0; fmt[i]; i++){
 9d7:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 9db:	83 c4 10             	add    $0x10,%esp
 9de:	84 d2                	test   %dl,%dl
 9e0:	0f 85 6a fe ff ff    	jne    850 <fprintf+0x20>
}
 9e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9e9:	5b                   	pop    %ebx
 9ea:	5e                   	pop    %esi
 9eb:	5f                   	pop    %edi
 9ec:	5d                   	pop    %ebp
 9ed:	c3                   	ret
 9ee:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 9f0:	83 ec 04             	sub    $0x4,%esp
 9f3:	88 55 e7             	mov    %dl,-0x19(%ebp)
 9f6:	8d 7d e7             	lea    -0x19(%ebp),%edi
 9f9:	6a 01                	push   $0x1
 9fb:	e9 b4 fe ff ff       	jmp    8b4 <fprintf+0x84>
          s = "(null)";
 a00:	bf db 0b 00 00       	mov    $0xbdb,%edi
 a05:	b8 28 00 00 00       	mov    $0x28,%eax
 a0a:	e9 fd fe ff ff       	jmp    90c <fprintf+0xdc>
 a0f:	66 90                	xchg   %ax,%ax
 a11:	66 90                	xchg   %ax,%ax
 a13:	66 90                	xchg   %ax,%ax
 a15:	66 90                	xchg   %ax,%ax
 a17:	66 90                	xchg   %ax,%ax
 a19:	66 90                	xchg   %ax,%ax
 a1b:	66 90                	xchg   %ax,%ax
 a1d:	66 90                	xchg   %ax,%ax
 a1f:	90                   	nop

00000a20 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a20:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a21:	a1 bc 0f 00 00       	mov    0xfbc,%eax
{
 a26:	89 e5                	mov    %esp,%ebp
 a28:	57                   	push   %edi
 a29:	56                   	push   %esi
 a2a:	53                   	push   %ebx
 a2b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 a2e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a31:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a38:	00 
 a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a40:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a42:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a44:	39 ca                	cmp    %ecx,%edx
 a46:	73 30                	jae    a78 <free+0x58>
 a48:	39 c1                	cmp    %eax,%ecx
 a4a:	72 04                	jb     a50 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a4c:	39 c2                	cmp    %eax,%edx
 a4e:	72 f0                	jb     a40 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a50:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a53:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a56:	39 f8                	cmp    %edi,%eax
 a58:	74 36                	je     a90 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 a5a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 a5d:	8b 42 04             	mov    0x4(%edx),%eax
 a60:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 a63:	39 f1                	cmp    %esi,%ecx
 a65:	74 40                	je     aa7 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 a67:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 a69:	5b                   	pop    %ebx
  freep = p;
 a6a:	89 15 bc 0f 00 00    	mov    %edx,0xfbc
}
 a70:	5e                   	pop    %esi
 a71:	5f                   	pop    %edi
 a72:	5d                   	pop    %ebp
 a73:	c3                   	ret
 a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a78:	39 c2                	cmp    %eax,%edx
 a7a:	72 c4                	jb     a40 <free+0x20>
 a7c:	39 c1                	cmp    %eax,%ecx
 a7e:	73 c0                	jae    a40 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 a80:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a83:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a86:	39 f8                	cmp    %edi,%eax
 a88:	75 d0                	jne    a5a <free+0x3a>
 a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 a90:	03 70 04             	add    0x4(%eax),%esi
 a93:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 a96:	8b 02                	mov    (%edx),%eax
 a98:	8b 00                	mov    (%eax),%eax
 a9a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 a9d:	8b 42 04             	mov    0x4(%edx),%eax
 aa0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 aa3:	39 f1                	cmp    %esi,%ecx
 aa5:	75 c0                	jne    a67 <free+0x47>
    p->s.size += bp->s.size;
 aa7:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 aaa:	89 15 bc 0f 00 00    	mov    %edx,0xfbc
    p->s.size += bp->s.size;
 ab0:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 ab3:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 ab6:	89 0a                	mov    %ecx,(%edx)
}
 ab8:	5b                   	pop    %ebx
 ab9:	5e                   	pop    %esi
 aba:	5f                   	pop    %edi
 abb:	5d                   	pop    %ebp
 abc:	c3                   	ret
 abd:	8d 76 00             	lea    0x0(%esi),%esi

00000ac0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ac0:	55                   	push   %ebp
 ac1:	89 e5                	mov    %esp,%ebp
 ac3:	57                   	push   %edi
 ac4:	56                   	push   %esi
 ac5:	53                   	push   %ebx
 ac6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ac9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 acc:	8b 15 bc 0f 00 00    	mov    0xfbc,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ad2:	8d 78 07             	lea    0x7(%eax),%edi
 ad5:	c1 ef 03             	shr    $0x3,%edi
 ad8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 adb:	85 d2                	test   %edx,%edx
 add:	0f 84 8d 00 00 00    	je     b70 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ae3:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 ae5:	8b 48 04             	mov    0x4(%eax),%ecx
 ae8:	39 f9                	cmp    %edi,%ecx
 aea:	73 64                	jae    b50 <malloc+0x90>
  if(nu < 4096)
 aec:	bb 00 10 00 00       	mov    $0x1000,%ebx
 af1:	39 df                	cmp    %ebx,%edi
 af3:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 af6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 afd:	eb 0a                	jmp    b09 <malloc+0x49>
 aff:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b00:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 b02:	8b 48 04             	mov    0x4(%eax),%ecx
 b05:	39 f9                	cmp    %edi,%ecx
 b07:	73 47                	jae    b50 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b09:	89 c2                	mov    %eax,%edx
 b0b:	39 05 bc 0f 00 00    	cmp    %eax,0xfbc
 b11:	75 ed                	jne    b00 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 b13:	83 ec 0c             	sub    $0xc,%esp
 b16:	56                   	push   %esi
 b17:	e8 3f f8 ff ff       	call   35b <sbrk>
  if(p == (char*)-1)
 b1c:	83 c4 10             	add    $0x10,%esp
 b1f:	83 f8 ff             	cmp    $0xffffffff,%eax
 b22:	74 1c                	je     b40 <malloc+0x80>
  hp->s.size = nu;
 b24:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 b27:	83 ec 0c             	sub    $0xc,%esp
 b2a:	83 c0 08             	add    $0x8,%eax
 b2d:	50                   	push   %eax
 b2e:	e8 ed fe ff ff       	call   a20 <free>
  return freep;
 b33:	8b 15 bc 0f 00 00    	mov    0xfbc,%edx
      if((p = morecore(nunits)) == 0)
 b39:	83 c4 10             	add    $0x10,%esp
 b3c:	85 d2                	test   %edx,%edx
 b3e:	75 c0                	jne    b00 <malloc+0x40>
        return 0;
  }
}
 b40:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 b43:	31 c0                	xor    %eax,%eax
}
 b45:	5b                   	pop    %ebx
 b46:	5e                   	pop    %esi
 b47:	5f                   	pop    %edi
 b48:	5d                   	pop    %ebp
 b49:	c3                   	ret
 b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 b50:	39 cf                	cmp    %ecx,%edi
 b52:	74 4c                	je     ba0 <malloc+0xe0>
        p->s.size -= nunits;
 b54:	29 f9                	sub    %edi,%ecx
 b56:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 b59:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 b5c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 b5f:	89 15 bc 0f 00 00    	mov    %edx,0xfbc
}
 b65:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 b68:	83 c0 08             	add    $0x8,%eax
}
 b6b:	5b                   	pop    %ebx
 b6c:	5e                   	pop    %esi
 b6d:	5f                   	pop    %edi
 b6e:	5d                   	pop    %ebp
 b6f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 b70:	c7 05 bc 0f 00 00 c0 	movl   $0xfc0,0xfbc
 b77:	0f 00 00 
    base.s.size = 0;
 b7a:	b8 c0 0f 00 00       	mov    $0xfc0,%eax
    base.s.ptr = freep = prevp = &base;
 b7f:	c7 05 c0 0f 00 00 c0 	movl   $0xfc0,0xfc0
 b86:	0f 00 00 
    base.s.size = 0;
 b89:	c7 05 c4 0f 00 00 00 	movl   $0x0,0xfc4
 b90:	00 00 00 
    if(p->s.size >= nunits){
 b93:	e9 54 ff ff ff       	jmp    aec <malloc+0x2c>
 b98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 b9f:	00 
        prevp->s.ptr = p->s.ptr;
 ba0:	8b 08                	mov    (%eax),%ecx
 ba2:	89 0a                	mov    %ecx,(%edx)
 ba4:	eb b9                	jmp    b5f <malloc+0x9f>
