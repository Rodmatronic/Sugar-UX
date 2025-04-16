
_clear:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
 * TODO: Don't... don't do this.
 *
 */

int
main(int argc, char *argv[]){
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	bb 18 00 00 00       	mov    $0x18,%ebx
  13:	51                   	push   %ecx
  14:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1b:	00 
  1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	int i=0;
  for ( i = 0; i < 24; i++) {
    printf("\n");
  20:	83 ec 0c             	sub    $0xc,%esp
  23:	68 88 0b 00 00       	push   $0xb88
  28:	e8 03 05 00 00       	call   530 <printf>
  for ( i = 0; i < 24; i++) {
  2d:	83 c4 10             	add    $0x10,%esp
  30:	83 eb 01             	sub    $0x1,%ebx
  33:	75 eb                	jne    20 <main+0x20>
  }
  printf("\f");
  35:	83 ec 0c             	sub    $0xc,%esp
  38:	68 8a 0b 00 00       	push   $0xb8a
  3d:	e8 ee 04 00 00       	call   530 <printf>

  exit();
  42:	e8 6c 02 00 00       	call   2b3 <exit>
  47:	66 90                	xchg   %ax,%ax
  49:	66 90                	xchg   %ax,%ax
  4b:	66 90                	xchg   %ax,%ax
  4d:	66 90                	xchg   %ax,%ax
  4f:	66 90                	xchg   %ax,%ax
  51:	66 90                	xchg   %ax,%ax
  53:	66 90                	xchg   %ax,%ax
  55:	66 90                	xchg   %ax,%ax
  57:	66 90                	xchg   %ax,%ax
  59:	66 90                	xchg   %ax,%ax
  5b:	66 90                	xchg   %ax,%ax
  5d:	66 90                	xchg   %ax,%ax
  5f:	90                   	nop

00000060 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  60:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  61:	31 c0                	xor    %eax,%eax
{
  63:	89 e5                	mov    %esp,%ebp
  65:	53                   	push   %ebx
  66:	8b 4d 08             	mov    0x8(%ebp),%ecx
  69:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  70:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  74:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  77:	83 c0 01             	add    $0x1,%eax
  7a:	84 d2                	test   %dl,%dl
  7c:	75 f2                	jne    70 <strcpy+0x10>
    ;
  return os;
}
  7e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  81:	89 c8                	mov    %ecx,%eax
  83:	c9                   	leave
  84:	c3                   	ret
  85:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  8c:	00 
  8d:	8d 76 00             	lea    0x0(%esi),%esi

00000090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	53                   	push   %ebx
  94:	8b 55 08             	mov    0x8(%ebp),%edx
  97:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  9a:	0f b6 02             	movzbl (%edx),%eax
  9d:	84 c0                	test   %al,%al
  9f:	75 2f                	jne    d0 <strcmp+0x40>
  a1:	eb 4a                	jmp    ed <strcmp+0x5d>
  a3:	eb 1b                	jmp    c0 <strcmp+0x30>
  a5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  ac:	00 
  ad:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  b4:	00 
  b5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  bc:	00 
  bd:	8d 76 00             	lea    0x0(%esi),%esi
  c0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  c4:	83 c2 01             	add    $0x1,%edx
  c7:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
  ca:	84 c0                	test   %al,%al
  cc:	74 12                	je     e0 <strcmp+0x50>
  ce:	89 d9                	mov    %ebx,%ecx
  d0:	0f b6 19             	movzbl (%ecx),%ebx
  d3:	38 c3                	cmp    %al,%bl
  d5:	74 e9                	je     c0 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
  d7:	29 d8                	sub    %ebx,%eax
}
  d9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  dc:	c9                   	leave
  dd:	c3                   	ret
  de:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
  e0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  e4:	31 c0                	xor    %eax,%eax
  e6:	29 d8                	sub    %ebx,%eax
}
  e8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  eb:	c9                   	leave
  ec:	c3                   	ret
  return (uchar)*p - (uchar)*q;
  ed:	0f b6 19             	movzbl (%ecx),%ebx
  f0:	31 c0                	xor    %eax,%eax
  f2:	eb e3                	jmp    d7 <strcmp+0x47>
  f4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  fb:	00 
  fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000100 <strlen>:

uint
strlen(char *s)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 106:	80 3a 00             	cmpb   $0x0,(%edx)
 109:	74 15                	je     120 <strlen+0x20>
 10b:	31 c0                	xor    %eax,%eax
 10d:	8d 76 00             	lea    0x0(%esi),%esi
 110:	83 c0 01             	add    $0x1,%eax
 113:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 117:	89 c1                	mov    %eax,%ecx
 119:	75 f5                	jne    110 <strlen+0x10>
    ;
  return n;
}
 11b:	89 c8                	mov    %ecx,%eax
 11d:	5d                   	pop    %ebp
 11e:	c3                   	ret
 11f:	90                   	nop
  for(n = 0; s[n]; n++)
 120:	31 c9                	xor    %ecx,%ecx
}
 122:	5d                   	pop    %ebp
 123:	89 c8                	mov    %ecx,%eax
 125:	c3                   	ret
 126:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 12d:	00 
 12e:	66 90                	xchg   %ax,%ax

00000130 <memset>:

void*
memset(void *dst, int c, uint n)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	57                   	push   %edi
 134:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 137:	8b 4d 10             	mov    0x10(%ebp),%ecx
 13a:	8b 45 0c             	mov    0xc(%ebp),%eax
 13d:	89 d7                	mov    %edx,%edi
 13f:	fc                   	cld
 140:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 142:	8b 7d fc             	mov    -0x4(%ebp),%edi
 145:	89 d0                	mov    %edx,%eax
 147:	c9                   	leave
 148:	c3                   	ret
 149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000150 <strchr>:

char*
strchr(const char *s, char c)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	8b 45 08             	mov    0x8(%ebp),%eax
 156:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 15a:	0f b6 10             	movzbl (%eax),%edx
 15d:	84 d2                	test   %dl,%dl
 15f:	75 1a                	jne    17b <strchr+0x2b>
 161:	eb 25                	jmp    188 <strchr+0x38>
 163:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 16a:	00 
 16b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 170:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 174:	83 c0 01             	add    $0x1,%eax
 177:	84 d2                	test   %dl,%dl
 179:	74 0d                	je     188 <strchr+0x38>
    if(*s == c)
 17b:	38 d1                	cmp    %dl,%cl
 17d:	75 f1                	jne    170 <strchr+0x20>
      return (char*)s;
  return 0;
}
 17f:	5d                   	pop    %ebp
 180:	c3                   	ret
 181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 188:	31 c0                	xor    %eax,%eax
}
 18a:	5d                   	pop    %ebp
 18b:	c3                   	ret
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000190 <gets>:

char*
gets(char *buf, int max)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	57                   	push   %edi
 194:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 195:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 198:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 199:	31 db                	xor    %ebx,%ebx
{
 19b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 19e:	eb 27                	jmp    1c7 <gets+0x37>
    cc = read(0, &c, 1);
 1a0:	83 ec 04             	sub    $0x4,%esp
 1a3:	6a 01                	push   $0x1
 1a5:	56                   	push   %esi
 1a6:	6a 00                	push   $0x0
 1a8:	e8 1e 01 00 00       	call   2cb <read>
    if(cc < 1)
 1ad:	83 c4 10             	add    $0x10,%esp
 1b0:	85 c0                	test   %eax,%eax
 1b2:	7e 1d                	jle    1d1 <gets+0x41>
      break;
    buf[i++] = c;
 1b4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1b8:	8b 55 08             	mov    0x8(%ebp),%edx
 1bb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 1bf:	3c 0a                	cmp    $0xa,%al
 1c1:	74 10                	je     1d3 <gets+0x43>
 1c3:	3c 0d                	cmp    $0xd,%al
 1c5:	74 0c                	je     1d3 <gets+0x43>
  for(i=0; i+1 < max; ){
 1c7:	89 df                	mov    %ebx,%edi
 1c9:	83 c3 01             	add    $0x1,%ebx
 1cc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1cf:	7c cf                	jl     1a0 <gets+0x10>
 1d1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 1d3:	8b 45 08             	mov    0x8(%ebp),%eax
 1d6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 1da:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1dd:	5b                   	pop    %ebx
 1de:	5e                   	pop    %esi
 1df:	5f                   	pop    %edi
 1e0:	5d                   	pop    %ebp
 1e1:	c3                   	ret
 1e2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1e9:	00 
 1ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001f0 <stat>:

int
stat(char *n, struct stat *st)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	56                   	push   %esi
 1f4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f5:	83 ec 08             	sub    $0x8,%esp
 1f8:	6a 00                	push   $0x0
 1fa:	ff 75 08             	push   0x8(%ebp)
 1fd:	e8 f1 00 00 00       	call   2f3 <open>
  if(fd < 0)
 202:	83 c4 10             	add    $0x10,%esp
 205:	85 c0                	test   %eax,%eax
 207:	78 27                	js     230 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 209:	83 ec 08             	sub    $0x8,%esp
 20c:	ff 75 0c             	push   0xc(%ebp)
 20f:	89 c3                	mov    %eax,%ebx
 211:	50                   	push   %eax
 212:	e8 f4 00 00 00       	call   30b <fstat>
  close(fd);
 217:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 21a:	89 c6                	mov    %eax,%esi
  close(fd);
 21c:	e8 ba 00 00 00       	call   2db <close>
  return r;
 221:	83 c4 10             	add    $0x10,%esp
}
 224:	8d 65 f8             	lea    -0x8(%ebp),%esp
 227:	89 f0                	mov    %esi,%eax
 229:	5b                   	pop    %ebx
 22a:	5e                   	pop    %esi
 22b:	5d                   	pop    %ebp
 22c:	c3                   	ret
 22d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 230:	be ff ff ff ff       	mov    $0xffffffff,%esi
 235:	eb ed                	jmp    224 <stat+0x34>
 237:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 23e:	00 
 23f:	90                   	nop

00000240 <atoi>:

int
atoi(const char *s)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	53                   	push   %ebx
 244:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 247:	0f be 02             	movsbl (%edx),%eax
 24a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 24d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 250:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 255:	77 1e                	ja     275 <atoi+0x35>
 257:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 25e:	00 
 25f:	90                   	nop
    n = n*10 + *s++ - '0';
 260:	83 c2 01             	add    $0x1,%edx
 263:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 266:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 26a:	0f be 02             	movsbl (%edx),%eax
 26d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 270:	80 fb 09             	cmp    $0x9,%bl
 273:	76 eb                	jbe    260 <atoi+0x20>
  return n;
}
 275:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 278:	89 c8                	mov    %ecx,%eax
 27a:	c9                   	leave
 27b:	c3                   	ret
 27c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000280 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	57                   	push   %edi
 284:	8b 45 10             	mov    0x10(%ebp),%eax
 287:	8b 55 08             	mov    0x8(%ebp),%edx
 28a:	56                   	push   %esi
 28b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 28e:	85 c0                	test   %eax,%eax
 290:	7e 13                	jle    2a5 <memmove+0x25>
 292:	01 d0                	add    %edx,%eax
  dst = vdst;
 294:	89 d7                	mov    %edx,%edi
 296:	66 90                	xchg   %ax,%ax
 298:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 29f:	00 
    *dst++ = *src++;
 2a0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2a1:	39 f8                	cmp    %edi,%eax
 2a3:	75 fb                	jne    2a0 <memmove+0x20>
  return vdst;
}
 2a5:	5e                   	pop    %esi
 2a6:	89 d0                	mov    %edx,%eax
 2a8:	5f                   	pop    %edi
 2a9:	5d                   	pop    %ebp
 2aa:	c3                   	ret

000002ab <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2ab:	b8 01 00 00 00       	mov    $0x1,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret

000002b3 <exit>:
SYSCALL(exit)
 2b3:	b8 02 00 00 00       	mov    $0x2,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret

000002bb <wait>:
SYSCALL(wait)
 2bb:	b8 03 00 00 00       	mov    $0x3,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret

000002c3 <pipe>:
SYSCALL(pipe)
 2c3:	b8 04 00 00 00       	mov    $0x4,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret

000002cb <read>:
SYSCALL(read)
 2cb:	b8 05 00 00 00       	mov    $0x5,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret

000002d3 <write>:
SYSCALL(write)
 2d3:	b8 10 00 00 00       	mov    $0x10,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret

000002db <close>:
SYSCALL(close)
 2db:	b8 15 00 00 00       	mov    $0x15,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret

000002e3 <kill>:
SYSCALL(kill)
 2e3:	b8 06 00 00 00       	mov    $0x6,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret

000002eb <exec>:
SYSCALL(exec)
 2eb:	b8 07 00 00 00       	mov    $0x7,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret

000002f3 <open>:
SYSCALL(open)
 2f3:	b8 0f 00 00 00       	mov    $0xf,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret

000002fb <mknod>:
SYSCALL(mknod)
 2fb:	b8 11 00 00 00       	mov    $0x11,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret

00000303 <unlink>:
SYSCALL(unlink)
 303:	b8 12 00 00 00       	mov    $0x12,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret

0000030b <fstat>:
SYSCALL(fstat)
 30b:	b8 08 00 00 00       	mov    $0x8,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret

00000313 <link>:
SYSCALL(link)
 313:	b8 13 00 00 00       	mov    $0x13,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret

0000031b <mkdir>:
SYSCALL(mkdir)
 31b:	b8 14 00 00 00       	mov    $0x14,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret

00000323 <chdir>:
SYSCALL(chdir)
 323:	b8 09 00 00 00       	mov    $0x9,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret

0000032b <dup>:
SYSCALL(dup)
 32b:	b8 0a 00 00 00       	mov    $0xa,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret

00000333 <getpid>:
SYSCALL(getpid)
 333:	b8 0b 00 00 00       	mov    $0xb,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret

0000033b <sbrk>:
SYSCALL(sbrk)
 33b:	b8 0c 00 00 00       	mov    $0xc,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret

00000343 <sleep>:
SYSCALL(sleep)
 343:	b8 0d 00 00 00       	mov    $0xd,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret

0000034b <uptime>:
SYSCALL(uptime)
 34b:	b8 0e 00 00 00       	mov    $0xe,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <bstat>:
SYSCALL(bstat)
 353:	b8 16 00 00 00       	mov    $0x16,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <swap>:
SYSCALL(swap)
 35b:	b8 17 00 00 00       	mov    $0x17,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <gettime>:
SYSCALL(gettime)
 363:	b8 18 00 00 00       	mov    $0x18,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <setcursor>:
SYSCALL(setcursor)
 36b:	b8 19 00 00 00       	mov    $0x19,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <uname>:
SYSCALL(uname)
 373:	b8 1a 00 00 00       	mov    $0x1a,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <echo>:
SYSCALL(echo)
 37b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret
 383:	66 90                	xchg   %ax,%ax
 385:	66 90                	xchg   %ax,%ax
 387:	66 90                	xchg   %ax,%ax
 389:	66 90                	xchg   %ax,%ax
 38b:	66 90                	xchg   %ax,%ax
 38d:	66 90                	xchg   %ax,%ax
 38f:	66 90                	xchg   %ax,%ax
 391:	66 90                	xchg   %ax,%ax
 393:	66 90                	xchg   %ax,%ax
 395:	66 90                	xchg   %ax,%ax
 397:	66 90                	xchg   %ax,%ax
 399:	66 90                	xchg   %ax,%ax
 39b:	66 90                	xchg   %ax,%ax
 39d:	66 90                	xchg   %ax,%ax
 39f:	90                   	nop

000003a0 <printint.constprop.0>:
{
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn, int width, char pad_char)
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	56                   	push   %esi
 3a5:	89 c6                	mov    %eax,%esi
 3a7:	53                   	push   %ebx
 3a8:	89 d3                	mov    %edx,%ebx
 3aa:	83 ec 3c             	sub    $0x3c,%esp
 3ad:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3b1:	85 f6                	test   %esi,%esi
 3b3:	0f 89 d7 00 00 00    	jns    490 <printint.constprop.0+0xf0>
 3b9:	83 e1 01             	and    $0x1,%ecx
 3bc:	0f 84 ce 00 00 00    	je     490 <printint.constprop.0+0xf0>
    neg = 1;
 3c2:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 3c9:	f7 de                	neg    %esi
 3cb:	89 f1                	mov    %esi,%ecx
  } else {
    x = xx;
  }

  i = 0;
 3cd:	88 45 bf             	mov    %al,-0x41(%ebp)
 3d0:	31 ff                	xor    %edi,%edi
 3d2:	8d 75 d7             	lea    -0x29(%ebp),%esi
 3d5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3dc:	00 
 3dd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 3e0:	89 c8                	mov    %ecx,%eax
 3e2:	31 d2                	xor    %edx,%edx
 3e4:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 3e7:	83 c7 01             	add    $0x1,%edi
 3ea:	f7 f3                	div    %ebx
 3ec:	0f b6 92 44 0c 00 00 	movzbl 0xc44(%edx),%edx
 3f3:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 3f6:	89 ca                	mov    %ecx,%edx
 3f8:	89 c1                	mov    %eax,%ecx
 3fa:	39 da                	cmp    %ebx,%edx
 3fc:	73 e2                	jae    3e0 <printint.constprop.0+0x40>

  if(neg)
 3fe:	8b 55 c0             	mov    -0x40(%ebp),%edx
 401:	0f b6 45 bf          	movzbl -0x41(%ebp),%eax
 405:	85 d2                	test   %edx,%edx
 407:	74 0b                	je     414 <printint.constprop.0+0x74>
    buf[i++] = '-';
 409:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
 40c:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 411:	8d 79 02             	lea    0x2(%ecx),%edi

  // Pad with pad_char until we hit the required width
  while(i < width)
 414:	39 7d 08             	cmp    %edi,0x8(%ebp)
 417:	0f 8e 83 00 00 00    	jle    4a0 <printint.constprop.0+0x100>
 41d:	8b 55 08             	mov    0x8(%ebp),%edx
 420:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 423:	01 df                	add    %ebx,%edi
 425:	01 da                	add    %ebx,%edx
 427:	89 d1                	mov    %edx,%ecx
 429:	29 f9                	sub    %edi,%ecx
 42b:	83 e1 01             	and    $0x1,%ecx
 42e:	74 10                	je     440 <printint.constprop.0+0xa0>
    buf[i++] = pad_char;
 430:	88 07                	mov    %al,(%edi)
  while(i < width)
 432:	83 c7 01             	add    $0x1,%edi
 435:	39 d7                	cmp    %edx,%edi
 437:	74 13                	je     44c <printint.constprop.0+0xac>
 439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = pad_char;
 440:	88 07                	mov    %al,(%edi)
  while(i < width)
 442:	83 c7 02             	add    $0x2,%edi
    buf[i++] = pad_char;
 445:	88 47 ff             	mov    %al,-0x1(%edi)
  while(i < width)
 448:	39 d7                	cmp    %edx,%edi
 44a:	75 f4                	jne    440 <printint.constprop.0+0xa0>
 44c:	8b 45 08             	mov    0x8(%ebp),%eax
 44f:	8d 78 ff             	lea    -0x1(%eax),%edi

  while(--i >= 0)
 452:	01 df                	add    %ebx,%edi
 454:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 45b:	00 
 45c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 460:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 463:	83 ec 04             	sub    $0x4,%esp
 466:	88 45 d7             	mov    %al,-0x29(%ebp)
 469:	6a 01                	push   $0x1
 46b:	56                   	push   %esi
 46c:	6a 01                	push   $0x1
 46e:	e8 60 fe ff ff       	call   2d3 <write>
  while(--i >= 0)
 473:	89 f8                	mov    %edi,%eax
 475:	83 c4 10             	add    $0x10,%esp
 478:	83 ef 01             	sub    $0x1,%edi
 47b:	39 d8                	cmp    %ebx,%eax
 47d:	75 e1                	jne    460 <printint.constprop.0+0xc0>
}
 47f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 482:	5b                   	pop    %ebx
 483:	5e                   	pop    %esi
 484:	5f                   	pop    %edi
 485:	5d                   	pop    %ebp
 486:	c3                   	ret
 487:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 48e:	00 
 48f:	90                   	nop
  neg = 0;
 490:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = xx;
 497:	89 f1                	mov    %esi,%ecx
 499:	e9 2f ff ff ff       	jmp    3cd <printint.constprop.0+0x2d>
 49e:	66 90                	xchg   %ax,%ax
  while(--i >= 0)
 4a0:	83 ef 01             	sub    $0x1,%edi
 4a3:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 4a6:	eb aa                	jmp    452 <printint.constprop.0+0xb2>
 4a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4af:	00 

000004b0 <strncpy>:
{
 4b0:	55                   	push   %ebp
 4b1:	31 c0                	xor    %eax,%eax
 4b3:	89 e5                	mov    %esp,%ebp
 4b5:	56                   	push   %esi
 4b6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 4b9:	8b 75 0c             	mov    0xc(%ebp),%esi
 4bc:	53                   	push   %ebx
 4bd:	8b 5d 10             	mov    0x10(%ebp),%ebx
  for (i = 0; i < n && src[i]; i++)
 4c0:	85 db                	test   %ebx,%ebx
 4c2:	7f 26                	jg     4ea <strncpy+0x3a>
 4c4:	eb 58                	jmp    51e <strncpy+0x6e>
 4c6:	eb 18                	jmp    4e0 <strncpy+0x30>
 4c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4cf:	00 
 4d0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4d7:	00 
 4d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4df:	00 
    dest[i] = src[i];
 4e0:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  for (i = 0; i < n && src[i]; i++)
 4e3:	83 c0 01             	add    $0x1,%eax
 4e6:	39 c3                	cmp    %eax,%ebx
 4e8:	74 34                	je     51e <strncpy+0x6e>
 4ea:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
 4ee:	84 d2                	test   %dl,%dl
 4f0:	75 ee                	jne    4e0 <strncpy+0x30>
  for (; i < n; i++)
 4f2:	39 c3                	cmp    %eax,%ebx
 4f4:	7e 28                	jle    51e <strncpy+0x6e>
 4f6:	01 c8                	add    %ecx,%eax
 4f8:	01 d9                	add    %ebx,%ecx
 4fa:	89 ca                	mov    %ecx,%edx
 4fc:	29 c2                	sub    %eax,%edx
 4fe:	83 e2 01             	and    $0x1,%edx
 501:	74 0d                	je     510 <strncpy+0x60>
    dest[i] = '\0';
 503:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
 506:	83 c0 01             	add    $0x1,%eax
 509:	39 c8                	cmp    %ecx,%eax
 50b:	74 11                	je     51e <strncpy+0x6e>
 50d:	8d 76 00             	lea    0x0(%esi),%esi
    dest[i] = '\0';
 510:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
 513:	83 c0 02             	add    $0x2,%eax
    dest[i] = '\0';
 516:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  for (; i < n; i++)
 51a:	39 c8                	cmp    %ecx,%eax
 51c:	75 f2                	jne    510 <strncpy+0x60>
}
 51e:	5b                   	pop    %ebx
 51f:	5e                   	pop    %esi
 520:	5d                   	pop    %ebp
 521:	c3                   	ret
 522:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 529:	00 
 52a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000530 <printf>:

void
printf(char *fmt, ...)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	57                   	push   %edi
 534:	56                   	push   %esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 535:	8d 75 0c             	lea    0xc(%ebp),%esi
{
 538:	53                   	push   %ebx
 539:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  for(i = 0; fmt[i]; i++){
 53c:	8b 55 08             	mov    0x8(%ebp),%edx
  ap = (uint*)(void*)&fmt + 1;
 53f:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 542:	0f b6 02             	movzbl (%edx),%eax
 545:	84 c0                	test   %al,%al
 547:	0f 84 88 00 00 00    	je     5d5 <printf+0xa5>
 54d:	8d 7a 01             	lea    0x1(%edx),%edi
    c = fmt[i] & 0xff;
 550:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
      if (c == '\f') {
 553:	83 fa 0c             	cmp    $0xc,%edx
 556:	0f 84 d4 01 00 00    	je     730 <printf+0x200>
        setcursor();
      } else if(c == '%'){
 55c:	83 fa 25             	cmp    $0x25,%edx
 55f:	0f 85 0b 02 00 00    	jne    770 <printf+0x240>
  for(i = 0; fmt[i]; i++){
 565:	0f b6 1f             	movzbl (%edi),%ebx
 568:	83 c7 01             	add    $0x1,%edi
 56b:	84 db                	test   %bl,%bl
 56d:	74 66                	je     5d5 <printf+0xa5>
    c = fmt[i] & 0xff;
 56f:	0f b6 c3             	movzbl %bl,%eax
 572:	ba 20 00 00 00       	mov    $0x20,%edx
 577:	31 c9                	xor    %ecx,%ecx
        pad_char = ' ';
      } else {
        putc(1, c);
      }
    } else if(state == '%'){
      if(c == '0'){
 579:	83 f8 78             	cmp    $0x78,%eax
 57c:	7f 22                	jg     5a0 <printf+0x70>
 57e:	83 f8 62             	cmp    $0x62,%eax
 581:	0f 8e b9 01 00 00    	jle    740 <printf+0x210>
 587:	83 e8 63             	sub    $0x63,%eax
 58a:	83 f8 15             	cmp    $0x15,%eax
 58d:	77 11                	ja     5a0 <printf+0x70>
 58f:	ff 24 85 94 0b 00 00 	jmp    *0xb94(,%eax,4)
 596:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 59d:	00 
 59e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 5a0:	83 ec 04             	sub    $0x4,%esp
 5a3:	8d 75 e7             	lea    -0x19(%ebp),%esi
 5a6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5aa:	6a 01                	push   $0x1
 5ac:	56                   	push   %esi
 5ad:	6a 01                	push   $0x1
 5af:	e8 1f fd ff ff       	call   2d3 <write>
 5b4:	83 c4 0c             	add    $0xc,%esp
 5b7:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5ba:	6a 01                	push   $0x1
 5bc:	56                   	push   %esi
 5bd:	6a 01                	push   $0x1
 5bf:	e8 0f fd ff ff       	call   2d3 <write>
      } else if(c == '%'){
        putc(1, '%');
        state = 0;
      } else {
        putc(1, '%');
        putc(1, c);
 5c4:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 5c7:	0f b6 07             	movzbl (%edi),%eax
 5ca:	83 c7 01             	add    $0x1,%edi
 5cd:	84 c0                	test   %al,%al
 5cf:	0f 85 7b ff ff ff    	jne    550 <printf+0x20>
        state = 0;
      }
    }
  }
}
 5d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5d8:	5b                   	pop    %ebx
 5d9:	5e                   	pop    %esi
 5da:	5f                   	pop    %edi
 5db:	5d                   	pop    %ebp
 5dc:	c3                   	ret
 5dd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 16, 0, width, pad_char);
 5e0:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 5e3:	83 ec 08             	sub    $0x8,%esp
 5e6:	8b 06                	mov    (%esi),%eax
 5e8:	52                   	push   %edx
 5e9:	ba 10 00 00 00       	mov    $0x10,%edx
 5ee:	51                   	push   %ecx
 5ef:	31 c9                	xor    %ecx,%ecx
        printint(1, *ap, 10, 1, width, pad_char);
 5f1:	e8 aa fd ff ff       	call   3a0 <printint.constprop.0>
        ap++;
 5f6:	83 c6 04             	add    $0x4,%esi
 5f9:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 5fc:	0f b6 07             	movzbl (%edi),%eax
 5ff:	83 c7 01             	add    $0x1,%edi
 602:	83 c4 10             	add    $0x10,%esp
 605:	84 c0                	test   %al,%al
 607:	0f 85 43 ff ff ff    	jne    550 <printf+0x20>
}
 60d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 610:	5b                   	pop    %ebx
 611:	5e                   	pop    %esi
 612:	5f                   	pop    %edi
 613:	5d                   	pop    %ebp
 614:	c3                   	ret
 615:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 10, 1, width, pad_char);
 618:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 61b:	83 ec 08             	sub    $0x8,%esp
 61e:	8b 06                	mov    (%esi),%eax
 620:	52                   	push   %edx
 621:	ba 0a 00 00 00       	mov    $0xa,%edx
 626:	51                   	push   %ecx
 627:	b9 01 00 00 00       	mov    $0x1,%ecx
 62c:	eb c3                	jmp    5f1 <printf+0xc1>
 62e:	66 90                	xchg   %ax,%ax
        s = (char*)*ap;
 630:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 633:	8b 06                	mov    (%esi),%eax
        ap++;
 635:	83 c6 04             	add    $0x4,%esi
 638:	89 75 d4             	mov    %esi,-0x2c(%ebp)
        if(s == 0)
 63b:	85 c0                	test   %eax,%eax
 63d:	0f 85 9d 01 00 00    	jne    7e0 <printf+0x2b0>
 643:	c6 45 d0 28          	movb   $0x28,-0x30(%ebp)
          s = "(null)";
 647:	b8 8c 0b 00 00       	mov    $0xb8c,%eax
        int len = 0;
 64c:	31 db                	xor    %ebx,%ebx
 64e:	66 90                	xchg   %ax,%ax
        for (char *t = s; *t; t++) len++;
 650:	83 c3 01             	add    $0x1,%ebx
 653:	80 3c 18 00          	cmpb   $0x0,(%eax,%ebx,1)
 657:	75 f7                	jne    650 <printf+0x120>
        for (int j = len; j < width; j++)
 659:	39 cb                	cmp    %ecx,%ebx
 65b:	0f 8d 9c 01 00 00    	jge    7fd <printf+0x2cd>
 661:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 664:	8d 75 e7             	lea    -0x19(%ebp),%esi
 667:	89 45 c8             	mov    %eax,-0x38(%ebp)
 66a:	89 7d cc             	mov    %edi,-0x34(%ebp)
 66d:	89 df                	mov    %ebx,%edi
 66f:	89 d3                	mov    %edx,%ebx
 671:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 678:	00 
 679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 680:	83 ec 04             	sub    $0x4,%esp
 683:	88 5d e7             	mov    %bl,-0x19(%ebp)
        for (int j = len; j < width; j++)
 686:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 689:	6a 01                	push   $0x1
 68b:	56                   	push   %esi
 68c:	6a 01                	push   $0x1
 68e:	e8 40 fc ff ff       	call   2d3 <write>
        for (int j = len; j < width; j++)
 693:	8b 45 d0             	mov    -0x30(%ebp),%eax
 696:	83 c4 10             	add    $0x10,%esp
 699:	39 c7                	cmp    %eax,%edi
 69b:	7c e3                	jl     680 <printf+0x150>
        while(*s != 0){
 69d:	8b 45 c8             	mov    -0x38(%ebp),%eax
 6a0:	8b 7d cc             	mov    -0x34(%ebp),%edi
 6a3:	0f b6 08             	movzbl (%eax),%ecx
 6a6:	88 4d d0             	mov    %cl,-0x30(%ebp)
 6a9:	84 c9                	test   %cl,%cl
 6ab:	0f 84 16 ff ff ff    	je     5c7 <printf+0x97>
 6b1:	89 c3                	mov    %eax,%ebx
 6b3:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 6b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6be:	00 
 6bf:	90                   	nop
  write(fd, &c, 1);
 6c0:	83 ec 04             	sub    $0x4,%esp
 6c3:	88 45 e7             	mov    %al,-0x19(%ebp)
          putc(1, *s++);
 6c6:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 6c9:	6a 01                	push   $0x1
 6cb:	56                   	push   %esi
 6cc:	6a 01                	push   $0x1
 6ce:	e8 00 fc ff ff       	call   2d3 <write>
        while(*s != 0){
 6d3:	0f b6 03             	movzbl (%ebx),%eax
 6d6:	83 c4 10             	add    $0x10,%esp
 6d9:	84 c0                	test   %al,%al
 6db:	75 e3                	jne    6c0 <printf+0x190>
 6dd:	e9 e5 fe ff ff       	jmp    5c7 <printf+0x97>
 6e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        char ch = *ap++;
 6e8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 6eb:	83 ec 04             	sub    $0x4,%esp
 6ee:	8d 75 e7             	lea    -0x19(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 6f1:	83 c7 01             	add    $0x1,%edi
        char ch = *ap++;
 6f4:	8d 58 04             	lea    0x4(%eax),%ebx
 6f7:	8b 00                	mov    (%eax),%eax
 6f9:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6fc:	6a 01                	push   $0x1
 6fe:	56                   	push   %esi
 6ff:	6a 01                	push   $0x1
 701:	e8 cd fb ff ff       	call   2d3 <write>
  for(i = 0; fmt[i]; i++){
 706:	0f b6 47 ff          	movzbl -0x1(%edi),%eax
 70a:	83 c4 10             	add    $0x10,%esp
 70d:	84 c0                	test   %al,%al
 70f:	0f 84 c0 fe ff ff    	je     5d5 <printf+0xa5>
    c = fmt[i] & 0xff;
 715:	0f b6 d0             	movzbl %al,%edx
        char ch = *ap++;
 718:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      if (c == '\f') {
 71b:	83 fa 0c             	cmp    $0xc,%edx
 71e:	0f 85 38 fe ff ff    	jne    55c <printf+0x2c>
 724:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 72b:	00 
 72c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        setcursor();
 730:	e8 36 fc ff ff       	call   36b <setcursor>
 735:	e9 8d fe ff ff       	jmp    5c7 <printf+0x97>
 73a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 740:	83 f8 30             	cmp    $0x30,%eax
 743:	74 7b                	je     7c0 <printf+0x290>
 745:	7f 49                	jg     790 <printf+0x260>
 747:	83 f8 25             	cmp    $0x25,%eax
 74a:	0f 85 50 fe ff ff    	jne    5a0 <printf+0x70>
  write(fd, &c, 1);
 750:	83 ec 04             	sub    $0x4,%esp
 753:	8d 75 e7             	lea    -0x19(%ebp),%esi
 756:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 75a:	6a 01                	push   $0x1
 75c:	56                   	push   %esi
 75d:	6a 01                	push   $0x1
 75f:	e8 6f fb ff ff       	call   2d3 <write>
        state = 0;
 764:	83 c4 10             	add    $0x10,%esp
 767:	e9 5b fe ff ff       	jmp    5c7 <printf+0x97>
 76c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 770:	83 ec 04             	sub    $0x4,%esp
 773:	8d 75 e7             	lea    -0x19(%ebp),%esi
 776:	88 45 e7             	mov    %al,-0x19(%ebp)
 779:	6a 01                	push   $0x1
 77b:	56                   	push   %esi
 77c:	6a 01                	push   $0x1
 77e:	e8 50 fb ff ff       	call   2d3 <write>
  for(i = 0; fmt[i]; i++){
 783:	e9 74 fe ff ff       	jmp    5fc <printf+0xcc>
 788:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 78f:	00 
 790:	8d 70 cf             	lea    -0x31(%eax),%esi
 793:	83 fe 08             	cmp    $0x8,%esi
 796:	0f 87 04 fe ff ff    	ja     5a0 <printf+0x70>
 79c:	0f b6 1f             	movzbl (%edi),%ebx
        width = width * 10 + (c - '0');
 79f:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
  for(i = 0; fmt[i]; i++){
 7a2:	83 c7 01             	add    $0x1,%edi
        width = width * 10 + (c - '0');
 7a5:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  for(i = 0; fmt[i]; i++){
 7a9:	84 db                	test   %bl,%bl
 7ab:	0f 84 24 fe ff ff    	je     5d5 <printf+0xa5>
    c = fmt[i] & 0xff;
 7b1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 7b4:	e9 c0 fd ff ff       	jmp    579 <printf+0x49>
 7b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 7c0:	0f b6 1f             	movzbl (%edi),%ebx
 7c3:	83 c7 01             	add    $0x1,%edi
 7c6:	84 db                	test   %bl,%bl
 7c8:	0f 84 07 fe ff ff    	je     5d5 <printf+0xa5>
    c = fmt[i] & 0xff;
 7ce:	0f b6 c3             	movzbl %bl,%eax
 7d1:	ba 30 00 00 00       	mov    $0x30,%edx
 7d6:	e9 9e fd ff ff       	jmp    579 <printf+0x49>
 7db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        for (char *t = s; *t; t++) len++;
 7e0:	0f b6 18             	movzbl (%eax),%ebx
 7e3:	88 5d d0             	mov    %bl,-0x30(%ebp)
 7e6:	84 db                	test   %bl,%bl
 7e8:	0f 85 5e fe ff ff    	jne    64c <printf+0x11c>
        int len = 0;
 7ee:	31 db                	xor    %ebx,%ebx
        for (int j = len; j < width; j++)
 7f0:	85 c9                	test   %ecx,%ecx
 7f2:	0f 8f 69 fe ff ff    	jg     661 <printf+0x131>
 7f8:	e9 ca fd ff ff       	jmp    5c7 <printf+0x97>
 7fd:	89 c2                	mov    %eax,%edx
 7ff:	8d 75 e7             	lea    -0x19(%ebp),%esi
 802:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 806:	89 d3                	mov    %edx,%ebx
 808:	e9 b3 fe ff ff       	jmp    6c0 <printf+0x190>
 80d:	8d 76 00             	lea    0x0(%esi),%esi

00000810 <fprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
fprintf(int fd, char *fmt, ...)
{
 810:	55                   	push   %ebp
 811:	89 e5                	mov    %esp,%ebp
 813:	57                   	push   %edi
 814:	56                   	push   %esi
 815:	53                   	push   %ebx
 816:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 819:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 81c:	0f b6 13             	movzbl (%ebx),%edx
 81f:	83 c3 01             	add    $0x1,%ebx
 822:	84 d2                	test   %dl,%dl
 824:	0f 84 81 00 00 00    	je     8ab <fprintf+0x9b>
 82a:	8d 75 10             	lea    0x10(%ebp),%esi
 82d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 830:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if (c == '\f') { // Detect formfeed character
 833:	83 f8 0c             	cmp    $0xc,%eax
 836:	0f 84 04 01 00 00    	je     940 <fprintf+0x130>
        setcursor();
      } else
      if(c == '%'){
 83c:	83 f8 25             	cmp    $0x25,%eax
 83f:	0f 85 5b 01 00 00    	jne    9a0 <fprintf+0x190>
  for(i = 0; fmt[i]; i++){
 845:	0f b6 13             	movzbl (%ebx),%edx
 848:	84 d2                	test   %dl,%dl
 84a:	74 5f                	je     8ab <fprintf+0x9b>
    c = fmt[i] & 0xff;
 84c:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 84f:	80 fa 25             	cmp    $0x25,%dl
 852:	0f 84 78 01 00 00    	je     9d0 <fprintf+0x1c0>
 858:	83 e8 63             	sub    $0x63,%eax
 85b:	83 f8 15             	cmp    $0x15,%eax
 85e:	77 10                	ja     870 <fprintf+0x60>
 860:	ff 24 85 ec 0b 00 00 	jmp    *0xbec(,%eax,4)
 867:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 86e:	00 
 86f:	90                   	nop
  write(fd, &c, 1);
 870:	83 ec 04             	sub    $0x4,%esp
 873:	8d 7d e7             	lea    -0x19(%ebp),%edi
 876:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 879:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 87d:	6a 01                	push   $0x1
 87f:	57                   	push   %edi
 880:	ff 75 08             	push   0x8(%ebp)
 883:	e8 4b fa ff ff       	call   2d3 <write>
        putc(fd, c);
 888:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 88c:	83 c4 0c             	add    $0xc,%esp
 88f:	88 55 e7             	mov    %dl,-0x19(%ebp)
 892:	6a 01                	push   $0x1
 894:	57                   	push   %edi
 895:	ff 75 08             	push   0x8(%ebp)
 898:	e8 36 fa ff ff       	call   2d3 <write>
  for(i = 0; fmt[i]; i++){
 89d:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 8a1:	83 c3 02             	add    $0x2,%ebx
 8a4:	83 c4 10             	add    $0x10,%esp
 8a7:	84 d2                	test   %dl,%dl
 8a9:	75 85                	jne    830 <fprintf+0x20>
      }
      state = 0;
    }
  }
}
 8ab:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8ae:	5b                   	pop    %ebx
 8af:	5e                   	pop    %esi
 8b0:	5f                   	pop    %edi
 8b1:	5d                   	pop    %ebp
 8b2:	c3                   	ret
 8b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(1, *ap, 16, 0, width, pad_char);
 8b8:	83 ec 08             	sub    $0x8,%esp
 8bb:	8b 06                	mov    (%esi),%eax
 8bd:	31 c9                	xor    %ecx,%ecx
 8bf:	ba 10 00 00 00       	mov    $0x10,%edx
 8c4:	6a 20                	push   $0x20
 8c6:	6a 00                	push   $0x0
 8c8:	e8 d3 fa ff ff       	call   3a0 <printint.constprop.0>
        ap++;
 8cd:	83 c6 04             	add    $0x4,%esi
  for(i = 0; fmt[i]; i++){
 8d0:	eb cb                	jmp    89d <fprintf+0x8d>
 8d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s = (char*)*ap;
 8d8:	8b 3e                	mov    (%esi),%edi
        ap++;
 8da:	83 c6 04             	add    $0x4,%esi
        if(s == 0)
 8dd:	85 ff                	test   %edi,%edi
 8df:	0f 84 fb 00 00 00    	je     9e0 <fprintf+0x1d0>
        while(*s != 0){
 8e5:	0f b6 07             	movzbl (%edi),%eax
 8e8:	84 c0                	test   %al,%al
 8ea:	74 36                	je     922 <fprintf+0x112>
 8ec:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 8ef:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 8f2:	8b 75 08             	mov    0x8(%ebp),%esi
 8f5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 8f8:	89 fb                	mov    %edi,%ebx
 8fa:	89 cf                	mov    %ecx,%edi
 8fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 900:	83 ec 04             	sub    $0x4,%esp
 903:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 906:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 909:	6a 01                	push   $0x1
 90b:	57                   	push   %edi
 90c:	56                   	push   %esi
 90d:	e8 c1 f9 ff ff       	call   2d3 <write>
        while(*s != 0){
 912:	0f b6 03             	movzbl (%ebx),%eax
 915:	83 c4 10             	add    $0x10,%esp
 918:	84 c0                	test   %al,%al
 91a:	75 e4                	jne    900 <fprintf+0xf0>
 91c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 91f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 922:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 926:	83 c3 02             	add    $0x2,%ebx
 929:	84 d2                	test   %dl,%dl
 92b:	0f 84 7a ff ff ff    	je     8ab <fprintf+0x9b>
    c = fmt[i] & 0xff;
 931:	0f b6 c2             	movzbl %dl,%eax
      if (c == '\f') { // Detect formfeed character
 934:	83 f8 0c             	cmp    $0xc,%eax
 937:	0f 85 ff fe ff ff    	jne    83c <fprintf+0x2c>
 93d:	8d 76 00             	lea    0x0(%esi),%esi
        setcursor();
 940:	e8 26 fa ff ff       	call   36b <setcursor>
  for(i = 0; fmt[i]; i++){
 945:	0f b6 13             	movzbl (%ebx),%edx
 948:	83 c3 01             	add    $0x1,%ebx
 94b:	84 d2                	test   %dl,%dl
 94d:	0f 85 dd fe ff ff    	jne    830 <fprintf+0x20>
 953:	e9 53 ff ff ff       	jmp    8ab <fprintf+0x9b>
 958:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 95f:	00 
        printint(1, *ap, 10, 1, width, pad_char);
 960:	83 ec 08             	sub    $0x8,%esp
 963:	8b 06                	mov    (%esi),%eax
 965:	b9 01 00 00 00       	mov    $0x1,%ecx
 96a:	ba 0a 00 00 00       	mov    $0xa,%edx
 96f:	6a 20                	push   $0x20
 971:	6a 00                	push   $0x0
 973:	e9 50 ff ff ff       	jmp    8c8 <fprintf+0xb8>
 978:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 97f:	00 
        putc(fd, *ap);
 980:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
 982:	83 ec 04             	sub    $0x4,%esp
 985:	8d 7d e7             	lea    -0x19(%ebp),%edi
        putc(fd, *ap);
 988:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 98b:	6a 01                	push   $0x1
 98d:	57                   	push   %edi
 98e:	ff 75 08             	push   0x8(%ebp)
 991:	e8 3d f9 ff ff       	call   2d3 <write>
 996:	e9 32 ff ff ff       	jmp    8cd <fprintf+0xbd>
 99b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 9a0:	83 ec 04             	sub    $0x4,%esp
 9a3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 9a6:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 9a9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 9ac:	6a 01                	push   $0x1
 9ae:	50                   	push   %eax
 9af:	ff 75 08             	push   0x8(%ebp)
 9b2:	e8 1c f9 ff ff       	call   2d3 <write>
  for(i = 0; fmt[i]; i++){
 9b7:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 9bb:	83 c4 10             	add    $0x10,%esp
 9be:	84 d2                	test   %dl,%dl
 9c0:	0f 85 6a fe ff ff    	jne    830 <fprintf+0x20>
}
 9c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9c9:	5b                   	pop    %ebx
 9ca:	5e                   	pop    %esi
 9cb:	5f                   	pop    %edi
 9cc:	5d                   	pop    %ebp
 9cd:	c3                   	ret
 9ce:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 9d0:	83 ec 04             	sub    $0x4,%esp
 9d3:	88 55 e7             	mov    %dl,-0x19(%ebp)
 9d6:	8d 7d e7             	lea    -0x19(%ebp),%edi
 9d9:	6a 01                	push   $0x1
 9db:	e9 b4 fe ff ff       	jmp    894 <fprintf+0x84>
          s = "(null)";
 9e0:	bf 8c 0b 00 00       	mov    $0xb8c,%edi
 9e5:	b8 28 00 00 00       	mov    $0x28,%eax
 9ea:	e9 fd fe ff ff       	jmp    8ec <fprintf+0xdc>
 9ef:	66 90                	xchg   %ax,%ax
 9f1:	66 90                	xchg   %ax,%ax
 9f3:	66 90                	xchg   %ax,%ax
 9f5:	66 90                	xchg   %ax,%ax
 9f7:	66 90                	xchg   %ax,%ax
 9f9:	66 90                	xchg   %ax,%ax
 9fb:	66 90                	xchg   %ax,%ax
 9fd:	66 90                	xchg   %ax,%ax
 9ff:	90                   	nop

00000a00 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a00:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a01:	a1 60 0f 00 00       	mov    0xf60,%eax
{
 a06:	89 e5                	mov    %esp,%ebp
 a08:	57                   	push   %edi
 a09:	56                   	push   %esi
 a0a:	53                   	push   %ebx
 a0b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 a0e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a11:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a18:	00 
 a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a20:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a22:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a24:	39 ca                	cmp    %ecx,%edx
 a26:	73 30                	jae    a58 <free+0x58>
 a28:	39 c1                	cmp    %eax,%ecx
 a2a:	72 04                	jb     a30 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a2c:	39 c2                	cmp    %eax,%edx
 a2e:	72 f0                	jb     a20 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a30:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a33:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a36:	39 f8                	cmp    %edi,%eax
 a38:	74 36                	je     a70 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 a3a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 a3d:	8b 42 04             	mov    0x4(%edx),%eax
 a40:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 a43:	39 f1                	cmp    %esi,%ecx
 a45:	74 40                	je     a87 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 a47:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 a49:	5b                   	pop    %ebx
  freep = p;
 a4a:	89 15 60 0f 00 00    	mov    %edx,0xf60
}
 a50:	5e                   	pop    %esi
 a51:	5f                   	pop    %edi
 a52:	5d                   	pop    %ebp
 a53:	c3                   	ret
 a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a58:	39 c2                	cmp    %eax,%edx
 a5a:	72 c4                	jb     a20 <free+0x20>
 a5c:	39 c1                	cmp    %eax,%ecx
 a5e:	73 c0                	jae    a20 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 a60:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a63:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a66:	39 f8                	cmp    %edi,%eax
 a68:	75 d0                	jne    a3a <free+0x3a>
 a6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 a70:	03 70 04             	add    0x4(%eax),%esi
 a73:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 a76:	8b 02                	mov    (%edx),%eax
 a78:	8b 00                	mov    (%eax),%eax
 a7a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 a7d:	8b 42 04             	mov    0x4(%edx),%eax
 a80:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 a83:	39 f1                	cmp    %esi,%ecx
 a85:	75 c0                	jne    a47 <free+0x47>
    p->s.size += bp->s.size;
 a87:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 a8a:	89 15 60 0f 00 00    	mov    %edx,0xf60
    p->s.size += bp->s.size;
 a90:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 a93:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 a96:	89 0a                	mov    %ecx,(%edx)
}
 a98:	5b                   	pop    %ebx
 a99:	5e                   	pop    %esi
 a9a:	5f                   	pop    %edi
 a9b:	5d                   	pop    %ebp
 a9c:	c3                   	ret
 a9d:	8d 76 00             	lea    0x0(%esi),%esi

00000aa0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 aa0:	55                   	push   %ebp
 aa1:	89 e5                	mov    %esp,%ebp
 aa3:	57                   	push   %edi
 aa4:	56                   	push   %esi
 aa5:	53                   	push   %ebx
 aa6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 aa9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 aac:	8b 15 60 0f 00 00    	mov    0xf60,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ab2:	8d 78 07             	lea    0x7(%eax),%edi
 ab5:	c1 ef 03             	shr    $0x3,%edi
 ab8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 abb:	85 d2                	test   %edx,%edx
 abd:	0f 84 8d 00 00 00    	je     b50 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ac3:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 ac5:	8b 48 04             	mov    0x4(%eax),%ecx
 ac8:	39 f9                	cmp    %edi,%ecx
 aca:	73 64                	jae    b30 <malloc+0x90>
  if(nu < 4096)
 acc:	bb 00 10 00 00       	mov    $0x1000,%ebx
 ad1:	39 df                	cmp    %ebx,%edi
 ad3:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 ad6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 add:	eb 0a                	jmp    ae9 <malloc+0x49>
 adf:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ae0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 ae2:	8b 48 04             	mov    0x4(%eax),%ecx
 ae5:	39 f9                	cmp    %edi,%ecx
 ae7:	73 47                	jae    b30 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ae9:	89 c2                	mov    %eax,%edx
 aeb:	39 05 60 0f 00 00    	cmp    %eax,0xf60
 af1:	75 ed                	jne    ae0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 af3:	83 ec 0c             	sub    $0xc,%esp
 af6:	56                   	push   %esi
 af7:	e8 3f f8 ff ff       	call   33b <sbrk>
  if(p == (char*)-1)
 afc:	83 c4 10             	add    $0x10,%esp
 aff:	83 f8 ff             	cmp    $0xffffffff,%eax
 b02:	74 1c                	je     b20 <malloc+0x80>
  hp->s.size = nu;
 b04:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 b07:	83 ec 0c             	sub    $0xc,%esp
 b0a:	83 c0 08             	add    $0x8,%eax
 b0d:	50                   	push   %eax
 b0e:	e8 ed fe ff ff       	call   a00 <free>
  return freep;
 b13:	8b 15 60 0f 00 00    	mov    0xf60,%edx
      if((p = morecore(nunits)) == 0)
 b19:	83 c4 10             	add    $0x10,%esp
 b1c:	85 d2                	test   %edx,%edx
 b1e:	75 c0                	jne    ae0 <malloc+0x40>
        return 0;
  }
}
 b20:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 b23:	31 c0                	xor    %eax,%eax
}
 b25:	5b                   	pop    %ebx
 b26:	5e                   	pop    %esi
 b27:	5f                   	pop    %edi
 b28:	5d                   	pop    %ebp
 b29:	c3                   	ret
 b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 b30:	39 cf                	cmp    %ecx,%edi
 b32:	74 4c                	je     b80 <malloc+0xe0>
        p->s.size -= nunits;
 b34:	29 f9                	sub    %edi,%ecx
 b36:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 b39:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 b3c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 b3f:	89 15 60 0f 00 00    	mov    %edx,0xf60
}
 b45:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 b48:	83 c0 08             	add    $0x8,%eax
}
 b4b:	5b                   	pop    %ebx
 b4c:	5e                   	pop    %esi
 b4d:	5f                   	pop    %edi
 b4e:	5d                   	pop    %ebp
 b4f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 b50:	c7 05 60 0f 00 00 64 	movl   $0xf64,0xf60
 b57:	0f 00 00 
    base.s.size = 0;
 b5a:	b8 64 0f 00 00       	mov    $0xf64,%eax
    base.s.ptr = freep = prevp = &base;
 b5f:	c7 05 64 0f 00 00 64 	movl   $0xf64,0xf64
 b66:	0f 00 00 
    base.s.size = 0;
 b69:	c7 05 68 0f 00 00 00 	movl   $0x0,0xf68
 b70:	00 00 00 
    if(p->s.size >= nunits){
 b73:	e9 54 ff ff ff       	jmp    acc <malloc+0x2c>
 b78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 b7f:	00 
        prevp->s.ptr = p->s.ptr;
 b80:	8b 08                	mov    (%eax),%ecx
 b82:	89 0a                	mov    %ecx,(%edx)
 b84:	eb b9                	jmp    b3f <malloc+0x9f>
