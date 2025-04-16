
_basename:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
  10:	83 ec 0c             	sub    $0xc,%esp
  13:	8b 19                	mov    (%ecx),%ebx
  15:	8b 71 04             	mov    0x4(%ecx),%esi
        register char *p1, *p2, *p3;

        if (argc < 2) {
  18:	83 fb 01             	cmp    $0x1,%ebx
  1b:	7e 70                	jle    8d <main+0x8d>
                printf("\n");
                exit();
        }
        p1 = argv[1];
  1d:	8b 46 04             	mov    0x4(%esi),%eax
        p2 = p1;
        while (*p1) {
  20:	0f b6 10             	movzbl (%eax),%edx
        p2 = p1;
  23:	89 c1                	mov    %eax,%ecx
        while (*p1) {
  25:	84 d2                	test   %dl,%dl
  27:	74 17                	je     40 <main+0x40>
  29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                if (*p1++ == '/')
  30:	83 c0 01             	add    $0x1,%eax
                        p2 = p1;
  33:	80 fa 2f             	cmp    $0x2f,%dl
        while (*p1) {
  36:	0f b6 10             	movzbl (%eax),%edx
                        p2 = p1;
  39:	0f 44 c8             	cmove  %eax,%ecx
        while (*p1) {
  3c:	84 d2                	test   %dl,%dl
  3e:	75 f0                	jne    30 <main+0x30>
        }
        if (argc>2) {
  40:	83 fb 02             	cmp    $0x2,%ebx
  43:	74 30                	je     75 <main+0x75>
                for(p3=argv[2]; *p3; p3++)
  45:	8b 76 08             	mov    0x8(%esi),%esi
  48:	80 3e 00             	cmpb   $0x0,(%esi)
  4b:	74 3b                	je     88 <main+0x88>
  4d:	89 f2                	mov    %esi,%edx
  4f:	90                   	nop
  50:	83 c2 01             	add    $0x1,%edx
  53:	80 3a 00             	cmpb   $0x0,(%edx)
  56:	75 f8                	jne    50 <main+0x50>
  58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  5f:	00 
                        ;
                while(p1>p2 && p3>argv[2])
  60:	39 c1                	cmp    %eax,%ecx
  62:	73 24                	jae    88 <main+0x88>
  64:	39 d6                	cmp    %edx,%esi
  66:	73 20                	jae    88 <main+0x88>
                        if(*--p3 != *--p1)
  68:	83 ea 01             	sub    $0x1,%edx
  6b:	83 e8 01             	sub    $0x1,%eax
  6e:	0f b6 18             	movzbl (%eax),%ebx
  71:	38 1a                	cmp    %bl,(%edx)
  73:	74 eb                	je     60 <main+0x60>
                                goto output;
                *p1 = '\0';
        }
output:
        printf("%s", p2);
  75:	83 ec 08             	sub    $0x8,%esp
  78:	51                   	push   %ecx
  79:	68 ca 0b 00 00       	push   $0xbca
  7e:	e8 ed 04 00 00       	call   570 <printf>
        exit();
  83:	e8 6b 02 00 00       	call   2f3 <exit>
                *p1 = '\0';
  88:	c6 00 00             	movb   $0x0,(%eax)
  8b:	eb e8                	jmp    75 <main+0x75>
                printf("\n");
  8d:	83 ec 0c             	sub    $0xc,%esp
  90:	68 c8 0b 00 00       	push   $0xbc8
  95:	e8 d6 04 00 00       	call   570 <printf>
                exit();
  9a:	e8 54 02 00 00       	call   2f3 <exit>
  9f:	90                   	nop

000000a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  a0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  a1:	31 c0                	xor    %eax,%eax
{
  a3:	89 e5                	mov    %esp,%ebp
  a5:	53                   	push   %ebx
  a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  b0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  b4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  b7:	83 c0 01             	add    $0x1,%eax
  ba:	84 d2                	test   %dl,%dl
  bc:	75 f2                	jne    b0 <strcpy+0x10>
    ;
  return os;
}
  be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  c1:	89 c8                	mov    %ecx,%eax
  c3:	c9                   	leave
  c4:	c3                   	ret
  c5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  cc:	00 
  cd:	8d 76 00             	lea    0x0(%esi),%esi

000000d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	53                   	push   %ebx
  d4:	8b 55 08             	mov    0x8(%ebp),%edx
  d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  da:	0f b6 02             	movzbl (%edx),%eax
  dd:	84 c0                	test   %al,%al
  df:	75 2f                	jne    110 <strcmp+0x40>
  e1:	eb 4a                	jmp    12d <strcmp+0x5d>
  e3:	eb 1b                	jmp    100 <strcmp+0x30>
  e5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  ec:	00 
  ed:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  f4:	00 
  f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  fc:	00 
  fd:	8d 76 00             	lea    0x0(%esi),%esi
 100:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 104:	83 c2 01             	add    $0x1,%edx
 107:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 10a:	84 c0                	test   %al,%al
 10c:	74 12                	je     120 <strcmp+0x50>
 10e:	89 d9                	mov    %ebx,%ecx
 110:	0f b6 19             	movzbl (%ecx),%ebx
 113:	38 c3                	cmp    %al,%bl
 115:	74 e9                	je     100 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 117:	29 d8                	sub    %ebx,%eax
}
 119:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 11c:	c9                   	leave
 11d:	c3                   	ret
 11e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 120:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 124:	31 c0                	xor    %eax,%eax
 126:	29 d8                	sub    %ebx,%eax
}
 128:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 12b:	c9                   	leave
 12c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 12d:	0f b6 19             	movzbl (%ecx),%ebx
 130:	31 c0                	xor    %eax,%eax
 132:	eb e3                	jmp    117 <strcmp+0x47>
 134:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 13b:	00 
 13c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000140 <strlen>:

uint
strlen(char *s)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 146:	80 3a 00             	cmpb   $0x0,(%edx)
 149:	74 15                	je     160 <strlen+0x20>
 14b:	31 c0                	xor    %eax,%eax
 14d:	8d 76 00             	lea    0x0(%esi),%esi
 150:	83 c0 01             	add    $0x1,%eax
 153:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 157:	89 c1                	mov    %eax,%ecx
 159:	75 f5                	jne    150 <strlen+0x10>
    ;
  return n;
}
 15b:	89 c8                	mov    %ecx,%eax
 15d:	5d                   	pop    %ebp
 15e:	c3                   	ret
 15f:	90                   	nop
  for(n = 0; s[n]; n++)
 160:	31 c9                	xor    %ecx,%ecx
}
 162:	5d                   	pop    %ebp
 163:	89 c8                	mov    %ecx,%eax
 165:	c3                   	ret
 166:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 16d:	00 
 16e:	66 90                	xchg   %ax,%ax

00000170 <memset>:

void*
memset(void *dst, int c, uint n)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	57                   	push   %edi
 174:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 177:	8b 4d 10             	mov    0x10(%ebp),%ecx
 17a:	8b 45 0c             	mov    0xc(%ebp),%eax
 17d:	89 d7                	mov    %edx,%edi
 17f:	fc                   	cld
 180:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 182:	8b 7d fc             	mov    -0x4(%ebp),%edi
 185:	89 d0                	mov    %edx,%eax
 187:	c9                   	leave
 188:	c3                   	ret
 189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000190 <strchr>:

char*
strchr(const char *s, char c)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	8b 45 08             	mov    0x8(%ebp),%eax
 196:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 19a:	0f b6 10             	movzbl (%eax),%edx
 19d:	84 d2                	test   %dl,%dl
 19f:	75 1a                	jne    1bb <strchr+0x2b>
 1a1:	eb 25                	jmp    1c8 <strchr+0x38>
 1a3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1aa:	00 
 1ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 1b0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 1b4:	83 c0 01             	add    $0x1,%eax
 1b7:	84 d2                	test   %dl,%dl
 1b9:	74 0d                	je     1c8 <strchr+0x38>
    if(*s == c)
 1bb:	38 d1                	cmp    %dl,%cl
 1bd:	75 f1                	jne    1b0 <strchr+0x20>
      return (char*)s;
  return 0;
}
 1bf:	5d                   	pop    %ebp
 1c0:	c3                   	ret
 1c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 1c8:	31 c0                	xor    %eax,%eax
}
 1ca:	5d                   	pop    %ebp
 1cb:	c3                   	ret
 1cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001d0 <gets>:

char*
gets(char *buf, int max)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	57                   	push   %edi
 1d4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 1d5:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 1d8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 1d9:	31 db                	xor    %ebx,%ebx
{
 1db:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 1de:	eb 27                	jmp    207 <gets+0x37>
    cc = read(0, &c, 1);
 1e0:	83 ec 04             	sub    $0x4,%esp
 1e3:	6a 01                	push   $0x1
 1e5:	56                   	push   %esi
 1e6:	6a 00                	push   $0x0
 1e8:	e8 1e 01 00 00       	call   30b <read>
    if(cc < 1)
 1ed:	83 c4 10             	add    $0x10,%esp
 1f0:	85 c0                	test   %eax,%eax
 1f2:	7e 1d                	jle    211 <gets+0x41>
      break;
    buf[i++] = c;
 1f4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1f8:	8b 55 08             	mov    0x8(%ebp),%edx
 1fb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 1ff:	3c 0a                	cmp    $0xa,%al
 201:	74 10                	je     213 <gets+0x43>
 203:	3c 0d                	cmp    $0xd,%al
 205:	74 0c                	je     213 <gets+0x43>
  for(i=0; i+1 < max; ){
 207:	89 df                	mov    %ebx,%edi
 209:	83 c3 01             	add    $0x1,%ebx
 20c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 20f:	7c cf                	jl     1e0 <gets+0x10>
 211:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 213:	8b 45 08             	mov    0x8(%ebp),%eax
 216:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 21a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 21d:	5b                   	pop    %ebx
 21e:	5e                   	pop    %esi
 21f:	5f                   	pop    %edi
 220:	5d                   	pop    %ebp
 221:	c3                   	ret
 222:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 229:	00 
 22a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000230 <stat>:

int
stat(char *n, struct stat *st)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	56                   	push   %esi
 234:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 235:	83 ec 08             	sub    $0x8,%esp
 238:	6a 00                	push   $0x0
 23a:	ff 75 08             	push   0x8(%ebp)
 23d:	e8 f1 00 00 00       	call   333 <open>
  if(fd < 0)
 242:	83 c4 10             	add    $0x10,%esp
 245:	85 c0                	test   %eax,%eax
 247:	78 27                	js     270 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 249:	83 ec 08             	sub    $0x8,%esp
 24c:	ff 75 0c             	push   0xc(%ebp)
 24f:	89 c3                	mov    %eax,%ebx
 251:	50                   	push   %eax
 252:	e8 f4 00 00 00       	call   34b <fstat>
  close(fd);
 257:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 25a:	89 c6                	mov    %eax,%esi
  close(fd);
 25c:	e8 ba 00 00 00       	call   31b <close>
  return r;
 261:	83 c4 10             	add    $0x10,%esp
}
 264:	8d 65 f8             	lea    -0x8(%ebp),%esp
 267:	89 f0                	mov    %esi,%eax
 269:	5b                   	pop    %ebx
 26a:	5e                   	pop    %esi
 26b:	5d                   	pop    %ebp
 26c:	c3                   	ret
 26d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 270:	be ff ff ff ff       	mov    $0xffffffff,%esi
 275:	eb ed                	jmp    264 <stat+0x34>
 277:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 27e:	00 
 27f:	90                   	nop

00000280 <atoi>:

int
atoi(const char *s)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	53                   	push   %ebx
 284:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 287:	0f be 02             	movsbl (%edx),%eax
 28a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 28d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 290:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 295:	77 1e                	ja     2b5 <atoi+0x35>
 297:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 29e:	00 
 29f:	90                   	nop
    n = n*10 + *s++ - '0';
 2a0:	83 c2 01             	add    $0x1,%edx
 2a3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 2a6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 2aa:	0f be 02             	movsbl (%edx),%eax
 2ad:	8d 58 d0             	lea    -0x30(%eax),%ebx
 2b0:	80 fb 09             	cmp    $0x9,%bl
 2b3:	76 eb                	jbe    2a0 <atoi+0x20>
  return n;
}
 2b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2b8:	89 c8                	mov    %ecx,%eax
 2ba:	c9                   	leave
 2bb:	c3                   	ret
 2bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002c0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	57                   	push   %edi
 2c4:	8b 45 10             	mov    0x10(%ebp),%eax
 2c7:	8b 55 08             	mov    0x8(%ebp),%edx
 2ca:	56                   	push   %esi
 2cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ce:	85 c0                	test   %eax,%eax
 2d0:	7e 13                	jle    2e5 <memmove+0x25>
 2d2:	01 d0                	add    %edx,%eax
  dst = vdst;
 2d4:	89 d7                	mov    %edx,%edi
 2d6:	66 90                	xchg   %ax,%ax
 2d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2df:	00 
    *dst++ = *src++;
 2e0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2e1:	39 f8                	cmp    %edi,%eax
 2e3:	75 fb                	jne    2e0 <memmove+0x20>
  return vdst;
}
 2e5:	5e                   	pop    %esi
 2e6:	89 d0                	mov    %edx,%eax
 2e8:	5f                   	pop    %edi
 2e9:	5d                   	pop    %ebp
 2ea:	c3                   	ret

000002eb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2eb:	b8 01 00 00 00       	mov    $0x1,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret

000002f3 <exit>:
SYSCALL(exit)
 2f3:	b8 02 00 00 00       	mov    $0x2,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret

000002fb <wait>:
SYSCALL(wait)
 2fb:	b8 03 00 00 00       	mov    $0x3,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret

00000303 <pipe>:
SYSCALL(pipe)
 303:	b8 04 00 00 00       	mov    $0x4,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret

0000030b <read>:
SYSCALL(read)
 30b:	b8 05 00 00 00       	mov    $0x5,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret

00000313 <write>:
SYSCALL(write)
 313:	b8 10 00 00 00       	mov    $0x10,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret

0000031b <close>:
SYSCALL(close)
 31b:	b8 15 00 00 00       	mov    $0x15,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret

00000323 <kill>:
SYSCALL(kill)
 323:	b8 06 00 00 00       	mov    $0x6,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret

0000032b <exec>:
SYSCALL(exec)
 32b:	b8 07 00 00 00       	mov    $0x7,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret

00000333 <open>:
SYSCALL(open)
 333:	b8 0f 00 00 00       	mov    $0xf,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret

0000033b <mknod>:
SYSCALL(mknod)
 33b:	b8 11 00 00 00       	mov    $0x11,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret

00000343 <unlink>:
SYSCALL(unlink)
 343:	b8 12 00 00 00       	mov    $0x12,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret

0000034b <fstat>:
SYSCALL(fstat)
 34b:	b8 08 00 00 00       	mov    $0x8,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <link>:
SYSCALL(link)
 353:	b8 13 00 00 00       	mov    $0x13,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <mkdir>:
SYSCALL(mkdir)
 35b:	b8 14 00 00 00       	mov    $0x14,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <chdir>:
SYSCALL(chdir)
 363:	b8 09 00 00 00       	mov    $0x9,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <dup>:
SYSCALL(dup)
 36b:	b8 0a 00 00 00       	mov    $0xa,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <getpid>:
SYSCALL(getpid)
 373:	b8 0b 00 00 00       	mov    $0xb,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <sbrk>:
SYSCALL(sbrk)
 37b:	b8 0c 00 00 00       	mov    $0xc,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

00000383 <sleep>:
SYSCALL(sleep)
 383:	b8 0d 00 00 00       	mov    $0xd,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

0000038b <uptime>:
SYSCALL(uptime)
 38b:	b8 0e 00 00 00       	mov    $0xe,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <bstat>:
SYSCALL(bstat)
 393:	b8 16 00 00 00       	mov    $0x16,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <swap>:
SYSCALL(swap)
 39b:	b8 17 00 00 00       	mov    $0x17,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <gettime>:
SYSCALL(gettime)
 3a3:	b8 18 00 00 00       	mov    $0x18,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <setcursor>:
SYSCALL(setcursor)
 3ab:	b8 19 00 00 00       	mov    $0x19,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <uname>:
SYSCALL(uname)
 3b3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

000003bb <echo>:
SYSCALL(echo)
 3bb:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret
 3c3:	66 90                	xchg   %ax,%ax
 3c5:	66 90                	xchg   %ax,%ax
 3c7:	66 90                	xchg   %ax,%ax
 3c9:	66 90                	xchg   %ax,%ax
 3cb:	66 90                	xchg   %ax,%ax
 3cd:	66 90                	xchg   %ax,%ax
 3cf:	66 90                	xchg   %ax,%ax
 3d1:	66 90                	xchg   %ax,%ax
 3d3:	66 90                	xchg   %ax,%ax
 3d5:	66 90                	xchg   %ax,%ax
 3d7:	66 90                	xchg   %ax,%ax
 3d9:	66 90                	xchg   %ax,%ax
 3db:	66 90                	xchg   %ax,%ax
 3dd:	66 90                	xchg   %ax,%ax
 3df:	90                   	nop

000003e0 <printint.constprop.0>:
{
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn, int width, char pad_char)
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	56                   	push   %esi
 3e5:	89 c6                	mov    %eax,%esi
 3e7:	53                   	push   %ebx
 3e8:	89 d3                	mov    %edx,%ebx
 3ea:	83 ec 3c             	sub    $0x3c,%esp
 3ed:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3f1:	85 f6                	test   %esi,%esi
 3f3:	0f 89 d7 00 00 00    	jns    4d0 <printint.constprop.0+0xf0>
 3f9:	83 e1 01             	and    $0x1,%ecx
 3fc:	0f 84 ce 00 00 00    	je     4d0 <printint.constprop.0+0xf0>
    neg = 1;
 402:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 409:	f7 de                	neg    %esi
 40b:	89 f1                	mov    %esi,%ecx
  } else {
    x = xx;
  }

  i = 0;
 40d:	88 45 bf             	mov    %al,-0x41(%ebp)
 410:	31 ff                	xor    %edi,%edi
 412:	8d 75 d7             	lea    -0x29(%ebp),%esi
 415:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 41c:	00 
 41d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 420:	89 c8                	mov    %ecx,%eax
 422:	31 d2                	xor    %edx,%edx
 424:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 427:	83 c7 01             	add    $0x1,%edi
 42a:	f7 f3                	div    %ebx
 42c:	0f b6 92 84 0c 00 00 	movzbl 0xc84(%edx),%edx
 433:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 436:	89 ca                	mov    %ecx,%edx
 438:	89 c1                	mov    %eax,%ecx
 43a:	39 da                	cmp    %ebx,%edx
 43c:	73 e2                	jae    420 <printint.constprop.0+0x40>

  if(neg)
 43e:	8b 55 c0             	mov    -0x40(%ebp),%edx
 441:	0f b6 45 bf          	movzbl -0x41(%ebp),%eax
 445:	85 d2                	test   %edx,%edx
 447:	74 0b                	je     454 <printint.constprop.0+0x74>
    buf[i++] = '-';
 449:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
 44c:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 451:	8d 79 02             	lea    0x2(%ecx),%edi

  // Pad with pad_char until we hit the required width
  while(i < width)
 454:	39 7d 08             	cmp    %edi,0x8(%ebp)
 457:	0f 8e 83 00 00 00    	jle    4e0 <printint.constprop.0+0x100>
 45d:	8b 55 08             	mov    0x8(%ebp),%edx
 460:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 463:	01 df                	add    %ebx,%edi
 465:	01 da                	add    %ebx,%edx
 467:	89 d1                	mov    %edx,%ecx
 469:	29 f9                	sub    %edi,%ecx
 46b:	83 e1 01             	and    $0x1,%ecx
 46e:	74 10                	je     480 <printint.constprop.0+0xa0>
    buf[i++] = pad_char;
 470:	88 07                	mov    %al,(%edi)
  while(i < width)
 472:	83 c7 01             	add    $0x1,%edi
 475:	39 d7                	cmp    %edx,%edi
 477:	74 13                	je     48c <printint.constprop.0+0xac>
 479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = pad_char;
 480:	88 07                	mov    %al,(%edi)
  while(i < width)
 482:	83 c7 02             	add    $0x2,%edi
    buf[i++] = pad_char;
 485:	88 47 ff             	mov    %al,-0x1(%edi)
  while(i < width)
 488:	39 d7                	cmp    %edx,%edi
 48a:	75 f4                	jne    480 <printint.constprop.0+0xa0>
 48c:	8b 45 08             	mov    0x8(%ebp),%eax
 48f:	8d 78 ff             	lea    -0x1(%eax),%edi

  while(--i >= 0)
 492:	01 df                	add    %ebx,%edi
 494:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 49b:	00 
 49c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 4a0:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 4a3:	83 ec 04             	sub    $0x4,%esp
 4a6:	88 45 d7             	mov    %al,-0x29(%ebp)
 4a9:	6a 01                	push   $0x1
 4ab:	56                   	push   %esi
 4ac:	6a 01                	push   $0x1
 4ae:	e8 60 fe ff ff       	call   313 <write>
  while(--i >= 0)
 4b3:	89 f8                	mov    %edi,%eax
 4b5:	83 c4 10             	add    $0x10,%esp
 4b8:	83 ef 01             	sub    $0x1,%edi
 4bb:	39 d8                	cmp    %ebx,%eax
 4bd:	75 e1                	jne    4a0 <printint.constprop.0+0xc0>
}
 4bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4c2:	5b                   	pop    %ebx
 4c3:	5e                   	pop    %esi
 4c4:	5f                   	pop    %edi
 4c5:	5d                   	pop    %ebp
 4c6:	c3                   	ret
 4c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4ce:	00 
 4cf:	90                   	nop
  neg = 0;
 4d0:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = xx;
 4d7:	89 f1                	mov    %esi,%ecx
 4d9:	e9 2f ff ff ff       	jmp    40d <printint.constprop.0+0x2d>
 4de:	66 90                	xchg   %ax,%ax
  while(--i >= 0)
 4e0:	83 ef 01             	sub    $0x1,%edi
 4e3:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 4e6:	eb aa                	jmp    492 <printint.constprop.0+0xb2>
 4e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4ef:	00 

000004f0 <strncpy>:
{
 4f0:	55                   	push   %ebp
 4f1:	31 c0                	xor    %eax,%eax
 4f3:	89 e5                	mov    %esp,%ebp
 4f5:	56                   	push   %esi
 4f6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 4f9:	8b 75 0c             	mov    0xc(%ebp),%esi
 4fc:	53                   	push   %ebx
 4fd:	8b 5d 10             	mov    0x10(%ebp),%ebx
  for (i = 0; i < n && src[i]; i++)
 500:	85 db                	test   %ebx,%ebx
 502:	7f 26                	jg     52a <strncpy+0x3a>
 504:	eb 58                	jmp    55e <strncpy+0x6e>
 506:	eb 18                	jmp    520 <strncpy+0x30>
 508:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 50f:	00 
 510:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 517:	00 
 518:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 51f:	00 
    dest[i] = src[i];
 520:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  for (i = 0; i < n && src[i]; i++)
 523:	83 c0 01             	add    $0x1,%eax
 526:	39 c3                	cmp    %eax,%ebx
 528:	74 34                	je     55e <strncpy+0x6e>
 52a:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
 52e:	84 d2                	test   %dl,%dl
 530:	75 ee                	jne    520 <strncpy+0x30>
  for (; i < n; i++)
 532:	39 c3                	cmp    %eax,%ebx
 534:	7e 28                	jle    55e <strncpy+0x6e>
 536:	01 c8                	add    %ecx,%eax
 538:	01 d9                	add    %ebx,%ecx
 53a:	89 ca                	mov    %ecx,%edx
 53c:	29 c2                	sub    %eax,%edx
 53e:	83 e2 01             	and    $0x1,%edx
 541:	74 0d                	je     550 <strncpy+0x60>
    dest[i] = '\0';
 543:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
 546:	83 c0 01             	add    $0x1,%eax
 549:	39 c8                	cmp    %ecx,%eax
 54b:	74 11                	je     55e <strncpy+0x6e>
 54d:	8d 76 00             	lea    0x0(%esi),%esi
    dest[i] = '\0';
 550:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
 553:	83 c0 02             	add    $0x2,%eax
    dest[i] = '\0';
 556:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  for (; i < n; i++)
 55a:	39 c8                	cmp    %ecx,%eax
 55c:	75 f2                	jne    550 <strncpy+0x60>
}
 55e:	5b                   	pop    %ebx
 55f:	5e                   	pop    %esi
 560:	5d                   	pop    %ebp
 561:	c3                   	ret
 562:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 569:	00 
 56a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000570 <printf>:

void
printf(char *fmt, ...)
{
 570:	55                   	push   %ebp
 571:	89 e5                	mov    %esp,%ebp
 573:	57                   	push   %edi
 574:	56                   	push   %esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 575:	8d 75 0c             	lea    0xc(%ebp),%esi
{
 578:	53                   	push   %ebx
 579:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  for(i = 0; fmt[i]; i++){
 57c:	8b 55 08             	mov    0x8(%ebp),%edx
  ap = (uint*)(void*)&fmt + 1;
 57f:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 582:	0f b6 02             	movzbl (%edx),%eax
 585:	84 c0                	test   %al,%al
 587:	0f 84 88 00 00 00    	je     615 <printf+0xa5>
 58d:	8d 7a 01             	lea    0x1(%edx),%edi
    c = fmt[i] & 0xff;
 590:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
      if (c == '\f') {
 593:	83 fa 0c             	cmp    $0xc,%edx
 596:	0f 84 d4 01 00 00    	je     770 <printf+0x200>
        setcursor();
      } else if(c == '%'){
 59c:	83 fa 25             	cmp    $0x25,%edx
 59f:	0f 85 0b 02 00 00    	jne    7b0 <printf+0x240>
  for(i = 0; fmt[i]; i++){
 5a5:	0f b6 1f             	movzbl (%edi),%ebx
 5a8:	83 c7 01             	add    $0x1,%edi
 5ab:	84 db                	test   %bl,%bl
 5ad:	74 66                	je     615 <printf+0xa5>
    c = fmt[i] & 0xff;
 5af:	0f b6 c3             	movzbl %bl,%eax
 5b2:	ba 20 00 00 00       	mov    $0x20,%edx
 5b7:	31 c9                	xor    %ecx,%ecx
        pad_char = ' ';
      } else {
        putc(1, c);
      }
    } else if(state == '%'){
      if(c == '0'){
 5b9:	83 f8 78             	cmp    $0x78,%eax
 5bc:	7f 22                	jg     5e0 <printf+0x70>
 5be:	83 f8 62             	cmp    $0x62,%eax
 5c1:	0f 8e b9 01 00 00    	jle    780 <printf+0x210>
 5c7:	83 e8 63             	sub    $0x63,%eax
 5ca:	83 f8 15             	cmp    $0x15,%eax
 5cd:	77 11                	ja     5e0 <printf+0x70>
 5cf:	ff 24 85 d4 0b 00 00 	jmp    *0xbd4(,%eax,4)
 5d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5dd:	00 
 5de:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 5e0:	83 ec 04             	sub    $0x4,%esp
 5e3:	8d 75 e7             	lea    -0x19(%ebp),%esi
 5e6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5ea:	6a 01                	push   $0x1
 5ec:	56                   	push   %esi
 5ed:	6a 01                	push   $0x1
 5ef:	e8 1f fd ff ff       	call   313 <write>
 5f4:	83 c4 0c             	add    $0xc,%esp
 5f7:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5fa:	6a 01                	push   $0x1
 5fc:	56                   	push   %esi
 5fd:	6a 01                	push   $0x1
 5ff:	e8 0f fd ff ff       	call   313 <write>
      } else if(c == '%'){
        putc(1, '%');
        state = 0;
      } else {
        putc(1, '%');
        putc(1, c);
 604:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 607:	0f b6 07             	movzbl (%edi),%eax
 60a:	83 c7 01             	add    $0x1,%edi
 60d:	84 c0                	test   %al,%al
 60f:	0f 85 7b ff ff ff    	jne    590 <printf+0x20>
        state = 0;
      }
    }
  }
}
 615:	8d 65 f4             	lea    -0xc(%ebp),%esp
 618:	5b                   	pop    %ebx
 619:	5e                   	pop    %esi
 61a:	5f                   	pop    %edi
 61b:	5d                   	pop    %ebp
 61c:	c3                   	ret
 61d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 16, 0, width, pad_char);
 620:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 623:	83 ec 08             	sub    $0x8,%esp
 626:	8b 06                	mov    (%esi),%eax
 628:	52                   	push   %edx
 629:	ba 10 00 00 00       	mov    $0x10,%edx
 62e:	51                   	push   %ecx
 62f:	31 c9                	xor    %ecx,%ecx
        printint(1, *ap, 10, 1, width, pad_char);
 631:	e8 aa fd ff ff       	call   3e0 <printint.constprop.0>
        ap++;
 636:	83 c6 04             	add    $0x4,%esi
 639:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 63c:	0f b6 07             	movzbl (%edi),%eax
 63f:	83 c7 01             	add    $0x1,%edi
 642:	83 c4 10             	add    $0x10,%esp
 645:	84 c0                	test   %al,%al
 647:	0f 85 43 ff ff ff    	jne    590 <printf+0x20>
}
 64d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 650:	5b                   	pop    %ebx
 651:	5e                   	pop    %esi
 652:	5f                   	pop    %edi
 653:	5d                   	pop    %ebp
 654:	c3                   	ret
 655:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 10, 1, width, pad_char);
 658:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 65b:	83 ec 08             	sub    $0x8,%esp
 65e:	8b 06                	mov    (%esi),%eax
 660:	52                   	push   %edx
 661:	ba 0a 00 00 00       	mov    $0xa,%edx
 666:	51                   	push   %ecx
 667:	b9 01 00 00 00       	mov    $0x1,%ecx
 66c:	eb c3                	jmp    631 <printf+0xc1>
 66e:	66 90                	xchg   %ax,%ax
        s = (char*)*ap;
 670:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 673:	8b 06                	mov    (%esi),%eax
        ap++;
 675:	83 c6 04             	add    $0x4,%esi
 678:	89 75 d4             	mov    %esi,-0x2c(%ebp)
        if(s == 0)
 67b:	85 c0                	test   %eax,%eax
 67d:	0f 85 9d 01 00 00    	jne    820 <printf+0x2b0>
 683:	c6 45 d0 28          	movb   $0x28,-0x30(%ebp)
          s = "(null)";
 687:	b8 cd 0b 00 00       	mov    $0xbcd,%eax
        int len = 0;
 68c:	31 db                	xor    %ebx,%ebx
 68e:	66 90                	xchg   %ax,%ax
        for (char *t = s; *t; t++) len++;
 690:	83 c3 01             	add    $0x1,%ebx
 693:	80 3c 18 00          	cmpb   $0x0,(%eax,%ebx,1)
 697:	75 f7                	jne    690 <printf+0x120>
        for (int j = len; j < width; j++)
 699:	39 cb                	cmp    %ecx,%ebx
 69b:	0f 8d 9c 01 00 00    	jge    83d <printf+0x2cd>
 6a1:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 6a4:	8d 75 e7             	lea    -0x19(%ebp),%esi
 6a7:	89 45 c8             	mov    %eax,-0x38(%ebp)
 6aa:	89 7d cc             	mov    %edi,-0x34(%ebp)
 6ad:	89 df                	mov    %ebx,%edi
 6af:	89 d3                	mov    %edx,%ebx
 6b1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6b8:	00 
 6b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 6c0:	83 ec 04             	sub    $0x4,%esp
 6c3:	88 5d e7             	mov    %bl,-0x19(%ebp)
        for (int j = len; j < width; j++)
 6c6:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 6c9:	6a 01                	push   $0x1
 6cb:	56                   	push   %esi
 6cc:	6a 01                	push   $0x1
 6ce:	e8 40 fc ff ff       	call   313 <write>
        for (int j = len; j < width; j++)
 6d3:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6d6:	83 c4 10             	add    $0x10,%esp
 6d9:	39 c7                	cmp    %eax,%edi
 6db:	7c e3                	jl     6c0 <printf+0x150>
        while(*s != 0){
 6dd:	8b 45 c8             	mov    -0x38(%ebp),%eax
 6e0:	8b 7d cc             	mov    -0x34(%ebp),%edi
 6e3:	0f b6 08             	movzbl (%eax),%ecx
 6e6:	88 4d d0             	mov    %cl,-0x30(%ebp)
 6e9:	84 c9                	test   %cl,%cl
 6eb:	0f 84 16 ff ff ff    	je     607 <printf+0x97>
 6f1:	89 c3                	mov    %eax,%ebx
 6f3:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 6f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6fe:	00 
 6ff:	90                   	nop
  write(fd, &c, 1);
 700:	83 ec 04             	sub    $0x4,%esp
 703:	88 45 e7             	mov    %al,-0x19(%ebp)
          putc(1, *s++);
 706:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 709:	6a 01                	push   $0x1
 70b:	56                   	push   %esi
 70c:	6a 01                	push   $0x1
 70e:	e8 00 fc ff ff       	call   313 <write>
        while(*s != 0){
 713:	0f b6 03             	movzbl (%ebx),%eax
 716:	83 c4 10             	add    $0x10,%esp
 719:	84 c0                	test   %al,%al
 71b:	75 e3                	jne    700 <printf+0x190>
 71d:	e9 e5 fe ff ff       	jmp    607 <printf+0x97>
 722:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        char ch = *ap++;
 728:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 72b:	83 ec 04             	sub    $0x4,%esp
 72e:	8d 75 e7             	lea    -0x19(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 731:	83 c7 01             	add    $0x1,%edi
        char ch = *ap++;
 734:	8d 58 04             	lea    0x4(%eax),%ebx
 737:	8b 00                	mov    (%eax),%eax
 739:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 73c:	6a 01                	push   $0x1
 73e:	56                   	push   %esi
 73f:	6a 01                	push   $0x1
 741:	e8 cd fb ff ff       	call   313 <write>
  for(i = 0; fmt[i]; i++){
 746:	0f b6 47 ff          	movzbl -0x1(%edi),%eax
 74a:	83 c4 10             	add    $0x10,%esp
 74d:	84 c0                	test   %al,%al
 74f:	0f 84 c0 fe ff ff    	je     615 <printf+0xa5>
    c = fmt[i] & 0xff;
 755:	0f b6 d0             	movzbl %al,%edx
        char ch = *ap++;
 758:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      if (c == '\f') {
 75b:	83 fa 0c             	cmp    $0xc,%edx
 75e:	0f 85 38 fe ff ff    	jne    59c <printf+0x2c>
 764:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 76b:	00 
 76c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        setcursor();
 770:	e8 36 fc ff ff       	call   3ab <setcursor>
 775:	e9 8d fe ff ff       	jmp    607 <printf+0x97>
 77a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 780:	83 f8 30             	cmp    $0x30,%eax
 783:	74 7b                	je     800 <printf+0x290>
 785:	7f 49                	jg     7d0 <printf+0x260>
 787:	83 f8 25             	cmp    $0x25,%eax
 78a:	0f 85 50 fe ff ff    	jne    5e0 <printf+0x70>
  write(fd, &c, 1);
 790:	83 ec 04             	sub    $0x4,%esp
 793:	8d 75 e7             	lea    -0x19(%ebp),%esi
 796:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 79a:	6a 01                	push   $0x1
 79c:	56                   	push   %esi
 79d:	6a 01                	push   $0x1
 79f:	e8 6f fb ff ff       	call   313 <write>
        state = 0;
 7a4:	83 c4 10             	add    $0x10,%esp
 7a7:	e9 5b fe ff ff       	jmp    607 <printf+0x97>
 7ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 7b0:	83 ec 04             	sub    $0x4,%esp
 7b3:	8d 75 e7             	lea    -0x19(%ebp),%esi
 7b6:	88 45 e7             	mov    %al,-0x19(%ebp)
 7b9:	6a 01                	push   $0x1
 7bb:	56                   	push   %esi
 7bc:	6a 01                	push   $0x1
 7be:	e8 50 fb ff ff       	call   313 <write>
  for(i = 0; fmt[i]; i++){
 7c3:	e9 74 fe ff ff       	jmp    63c <printf+0xcc>
 7c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7cf:	00 
 7d0:	8d 70 cf             	lea    -0x31(%eax),%esi
 7d3:	83 fe 08             	cmp    $0x8,%esi
 7d6:	0f 87 04 fe ff ff    	ja     5e0 <printf+0x70>
 7dc:	0f b6 1f             	movzbl (%edi),%ebx
        width = width * 10 + (c - '0');
 7df:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
  for(i = 0; fmt[i]; i++){
 7e2:	83 c7 01             	add    $0x1,%edi
        width = width * 10 + (c - '0');
 7e5:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  for(i = 0; fmt[i]; i++){
 7e9:	84 db                	test   %bl,%bl
 7eb:	0f 84 24 fe ff ff    	je     615 <printf+0xa5>
    c = fmt[i] & 0xff;
 7f1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 7f4:	e9 c0 fd ff ff       	jmp    5b9 <printf+0x49>
 7f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 800:	0f b6 1f             	movzbl (%edi),%ebx
 803:	83 c7 01             	add    $0x1,%edi
 806:	84 db                	test   %bl,%bl
 808:	0f 84 07 fe ff ff    	je     615 <printf+0xa5>
    c = fmt[i] & 0xff;
 80e:	0f b6 c3             	movzbl %bl,%eax
 811:	ba 30 00 00 00       	mov    $0x30,%edx
 816:	e9 9e fd ff ff       	jmp    5b9 <printf+0x49>
 81b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        for (char *t = s; *t; t++) len++;
 820:	0f b6 18             	movzbl (%eax),%ebx
 823:	88 5d d0             	mov    %bl,-0x30(%ebp)
 826:	84 db                	test   %bl,%bl
 828:	0f 85 5e fe ff ff    	jne    68c <printf+0x11c>
        int len = 0;
 82e:	31 db                	xor    %ebx,%ebx
        for (int j = len; j < width; j++)
 830:	85 c9                	test   %ecx,%ecx
 832:	0f 8f 69 fe ff ff    	jg     6a1 <printf+0x131>
 838:	e9 ca fd ff ff       	jmp    607 <printf+0x97>
 83d:	89 c2                	mov    %eax,%edx
 83f:	8d 75 e7             	lea    -0x19(%ebp),%esi
 842:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 846:	89 d3                	mov    %edx,%ebx
 848:	e9 b3 fe ff ff       	jmp    700 <printf+0x190>
 84d:	8d 76 00             	lea    0x0(%esi),%esi

00000850 <fprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
fprintf(int fd, char *fmt, ...)
{
 850:	55                   	push   %ebp
 851:	89 e5                	mov    %esp,%ebp
 853:	57                   	push   %edi
 854:	56                   	push   %esi
 855:	53                   	push   %ebx
 856:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 859:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 85c:	0f b6 13             	movzbl (%ebx),%edx
 85f:	83 c3 01             	add    $0x1,%ebx
 862:	84 d2                	test   %dl,%dl
 864:	0f 84 81 00 00 00    	je     8eb <fprintf+0x9b>
 86a:	8d 75 10             	lea    0x10(%ebp),%esi
 86d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 870:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if (c == '\f') { // Detect formfeed character
 873:	83 f8 0c             	cmp    $0xc,%eax
 876:	0f 84 04 01 00 00    	je     980 <fprintf+0x130>
        setcursor();
      } else
      if(c == '%'){
 87c:	83 f8 25             	cmp    $0x25,%eax
 87f:	0f 85 5b 01 00 00    	jne    9e0 <fprintf+0x190>
  for(i = 0; fmt[i]; i++){
 885:	0f b6 13             	movzbl (%ebx),%edx
 888:	84 d2                	test   %dl,%dl
 88a:	74 5f                	je     8eb <fprintf+0x9b>
    c = fmt[i] & 0xff;
 88c:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 88f:	80 fa 25             	cmp    $0x25,%dl
 892:	0f 84 78 01 00 00    	je     a10 <fprintf+0x1c0>
 898:	83 e8 63             	sub    $0x63,%eax
 89b:	83 f8 15             	cmp    $0x15,%eax
 89e:	77 10                	ja     8b0 <fprintf+0x60>
 8a0:	ff 24 85 2c 0c 00 00 	jmp    *0xc2c(,%eax,4)
 8a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8ae:	00 
 8af:	90                   	nop
  write(fd, &c, 1);
 8b0:	83 ec 04             	sub    $0x4,%esp
 8b3:	8d 7d e7             	lea    -0x19(%ebp),%edi
 8b6:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8b9:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 8bd:	6a 01                	push   $0x1
 8bf:	57                   	push   %edi
 8c0:	ff 75 08             	push   0x8(%ebp)
 8c3:	e8 4b fa ff ff       	call   313 <write>
        putc(fd, c);
 8c8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 8cc:	83 c4 0c             	add    $0xc,%esp
 8cf:	88 55 e7             	mov    %dl,-0x19(%ebp)
 8d2:	6a 01                	push   $0x1
 8d4:	57                   	push   %edi
 8d5:	ff 75 08             	push   0x8(%ebp)
 8d8:	e8 36 fa ff ff       	call   313 <write>
  for(i = 0; fmt[i]; i++){
 8dd:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 8e1:	83 c3 02             	add    $0x2,%ebx
 8e4:	83 c4 10             	add    $0x10,%esp
 8e7:	84 d2                	test   %dl,%dl
 8e9:	75 85                	jne    870 <fprintf+0x20>
      }
      state = 0;
    }
  }
}
 8eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8ee:	5b                   	pop    %ebx
 8ef:	5e                   	pop    %esi
 8f0:	5f                   	pop    %edi
 8f1:	5d                   	pop    %ebp
 8f2:	c3                   	ret
 8f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(1, *ap, 16, 0, width, pad_char);
 8f8:	83 ec 08             	sub    $0x8,%esp
 8fb:	8b 06                	mov    (%esi),%eax
 8fd:	31 c9                	xor    %ecx,%ecx
 8ff:	ba 10 00 00 00       	mov    $0x10,%edx
 904:	6a 20                	push   $0x20
 906:	6a 00                	push   $0x0
 908:	e8 d3 fa ff ff       	call   3e0 <printint.constprop.0>
        ap++;
 90d:	83 c6 04             	add    $0x4,%esi
  for(i = 0; fmt[i]; i++){
 910:	eb cb                	jmp    8dd <fprintf+0x8d>
 912:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s = (char*)*ap;
 918:	8b 3e                	mov    (%esi),%edi
        ap++;
 91a:	83 c6 04             	add    $0x4,%esi
        if(s == 0)
 91d:	85 ff                	test   %edi,%edi
 91f:	0f 84 fb 00 00 00    	je     a20 <fprintf+0x1d0>
        while(*s != 0){
 925:	0f b6 07             	movzbl (%edi),%eax
 928:	84 c0                	test   %al,%al
 92a:	74 36                	je     962 <fprintf+0x112>
 92c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 92f:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 932:	8b 75 08             	mov    0x8(%ebp),%esi
 935:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 938:	89 fb                	mov    %edi,%ebx
 93a:	89 cf                	mov    %ecx,%edi
 93c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 940:	83 ec 04             	sub    $0x4,%esp
 943:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 946:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 949:	6a 01                	push   $0x1
 94b:	57                   	push   %edi
 94c:	56                   	push   %esi
 94d:	e8 c1 f9 ff ff       	call   313 <write>
        while(*s != 0){
 952:	0f b6 03             	movzbl (%ebx),%eax
 955:	83 c4 10             	add    $0x10,%esp
 958:	84 c0                	test   %al,%al
 95a:	75 e4                	jne    940 <fprintf+0xf0>
 95c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 95f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 962:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 966:	83 c3 02             	add    $0x2,%ebx
 969:	84 d2                	test   %dl,%dl
 96b:	0f 84 7a ff ff ff    	je     8eb <fprintf+0x9b>
    c = fmt[i] & 0xff;
 971:	0f b6 c2             	movzbl %dl,%eax
      if (c == '\f') { // Detect formfeed character
 974:	83 f8 0c             	cmp    $0xc,%eax
 977:	0f 85 ff fe ff ff    	jne    87c <fprintf+0x2c>
 97d:	8d 76 00             	lea    0x0(%esi),%esi
        setcursor();
 980:	e8 26 fa ff ff       	call   3ab <setcursor>
  for(i = 0; fmt[i]; i++){
 985:	0f b6 13             	movzbl (%ebx),%edx
 988:	83 c3 01             	add    $0x1,%ebx
 98b:	84 d2                	test   %dl,%dl
 98d:	0f 85 dd fe ff ff    	jne    870 <fprintf+0x20>
 993:	e9 53 ff ff ff       	jmp    8eb <fprintf+0x9b>
 998:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 99f:	00 
        printint(1, *ap, 10, 1, width, pad_char);
 9a0:	83 ec 08             	sub    $0x8,%esp
 9a3:	8b 06                	mov    (%esi),%eax
 9a5:	b9 01 00 00 00       	mov    $0x1,%ecx
 9aa:	ba 0a 00 00 00       	mov    $0xa,%edx
 9af:	6a 20                	push   $0x20
 9b1:	6a 00                	push   $0x0
 9b3:	e9 50 ff ff ff       	jmp    908 <fprintf+0xb8>
 9b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 9bf:	00 
        putc(fd, *ap);
 9c0:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
 9c2:	83 ec 04             	sub    $0x4,%esp
 9c5:	8d 7d e7             	lea    -0x19(%ebp),%edi
        putc(fd, *ap);
 9c8:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 9cb:	6a 01                	push   $0x1
 9cd:	57                   	push   %edi
 9ce:	ff 75 08             	push   0x8(%ebp)
 9d1:	e8 3d f9 ff ff       	call   313 <write>
 9d6:	e9 32 ff ff ff       	jmp    90d <fprintf+0xbd>
 9db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 9e0:	83 ec 04             	sub    $0x4,%esp
 9e3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 9e6:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 9e9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 9ec:	6a 01                	push   $0x1
 9ee:	50                   	push   %eax
 9ef:	ff 75 08             	push   0x8(%ebp)
 9f2:	e8 1c f9 ff ff       	call   313 <write>
  for(i = 0; fmt[i]; i++){
 9f7:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 9fb:	83 c4 10             	add    $0x10,%esp
 9fe:	84 d2                	test   %dl,%dl
 a00:	0f 85 6a fe ff ff    	jne    870 <fprintf+0x20>
}
 a06:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a09:	5b                   	pop    %ebx
 a0a:	5e                   	pop    %esi
 a0b:	5f                   	pop    %edi
 a0c:	5d                   	pop    %ebp
 a0d:	c3                   	ret
 a0e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 a10:	83 ec 04             	sub    $0x4,%esp
 a13:	88 55 e7             	mov    %dl,-0x19(%ebp)
 a16:	8d 7d e7             	lea    -0x19(%ebp),%edi
 a19:	6a 01                	push   $0x1
 a1b:	e9 b4 fe ff ff       	jmp    8d4 <fprintf+0x84>
          s = "(null)";
 a20:	bf cd 0b 00 00       	mov    $0xbcd,%edi
 a25:	b8 28 00 00 00       	mov    $0x28,%eax
 a2a:	e9 fd fe ff ff       	jmp    92c <fprintf+0xdc>
 a2f:	66 90                	xchg   %ax,%ax
 a31:	66 90                	xchg   %ax,%ax
 a33:	66 90                	xchg   %ax,%ax
 a35:	66 90                	xchg   %ax,%ax
 a37:	66 90                	xchg   %ax,%ax
 a39:	66 90                	xchg   %ax,%ax
 a3b:	66 90                	xchg   %ax,%ax
 a3d:	66 90                	xchg   %ax,%ax
 a3f:	90                   	nop

00000a40 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a40:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a41:	a1 a4 0f 00 00       	mov    0xfa4,%eax
{
 a46:	89 e5                	mov    %esp,%ebp
 a48:	57                   	push   %edi
 a49:	56                   	push   %esi
 a4a:	53                   	push   %ebx
 a4b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 a4e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a51:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a58:	00 
 a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a60:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a62:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a64:	39 ca                	cmp    %ecx,%edx
 a66:	73 30                	jae    a98 <free+0x58>
 a68:	39 c1                	cmp    %eax,%ecx
 a6a:	72 04                	jb     a70 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a6c:	39 c2                	cmp    %eax,%edx
 a6e:	72 f0                	jb     a60 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a70:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a73:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a76:	39 f8                	cmp    %edi,%eax
 a78:	74 36                	je     ab0 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 a7a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 a7d:	8b 42 04             	mov    0x4(%edx),%eax
 a80:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 a83:	39 f1                	cmp    %esi,%ecx
 a85:	74 40                	je     ac7 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 a87:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 a89:	5b                   	pop    %ebx
  freep = p;
 a8a:	89 15 a4 0f 00 00    	mov    %edx,0xfa4
}
 a90:	5e                   	pop    %esi
 a91:	5f                   	pop    %edi
 a92:	5d                   	pop    %ebp
 a93:	c3                   	ret
 a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a98:	39 c2                	cmp    %eax,%edx
 a9a:	72 c4                	jb     a60 <free+0x20>
 a9c:	39 c1                	cmp    %eax,%ecx
 a9e:	73 c0                	jae    a60 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 aa0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 aa3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 aa6:	39 f8                	cmp    %edi,%eax
 aa8:	75 d0                	jne    a7a <free+0x3a>
 aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 ab0:	03 70 04             	add    0x4(%eax),%esi
 ab3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 ab6:	8b 02                	mov    (%edx),%eax
 ab8:	8b 00                	mov    (%eax),%eax
 aba:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 abd:	8b 42 04             	mov    0x4(%edx),%eax
 ac0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 ac3:	39 f1                	cmp    %esi,%ecx
 ac5:	75 c0                	jne    a87 <free+0x47>
    p->s.size += bp->s.size;
 ac7:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 aca:	89 15 a4 0f 00 00    	mov    %edx,0xfa4
    p->s.size += bp->s.size;
 ad0:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 ad3:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 ad6:	89 0a                	mov    %ecx,(%edx)
}
 ad8:	5b                   	pop    %ebx
 ad9:	5e                   	pop    %esi
 ada:	5f                   	pop    %edi
 adb:	5d                   	pop    %ebp
 adc:	c3                   	ret
 add:	8d 76 00             	lea    0x0(%esi),%esi

00000ae0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ae0:	55                   	push   %ebp
 ae1:	89 e5                	mov    %esp,%ebp
 ae3:	57                   	push   %edi
 ae4:	56                   	push   %esi
 ae5:	53                   	push   %ebx
 ae6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ae9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 aec:	8b 15 a4 0f 00 00    	mov    0xfa4,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 af2:	8d 78 07             	lea    0x7(%eax),%edi
 af5:	c1 ef 03             	shr    $0x3,%edi
 af8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 afb:	85 d2                	test   %edx,%edx
 afd:	0f 84 8d 00 00 00    	je     b90 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b03:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 b05:	8b 48 04             	mov    0x4(%eax),%ecx
 b08:	39 f9                	cmp    %edi,%ecx
 b0a:	73 64                	jae    b70 <malloc+0x90>
  if(nu < 4096)
 b0c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 b11:	39 df                	cmp    %ebx,%edi
 b13:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 b16:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 b1d:	eb 0a                	jmp    b29 <malloc+0x49>
 b1f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b20:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 b22:	8b 48 04             	mov    0x4(%eax),%ecx
 b25:	39 f9                	cmp    %edi,%ecx
 b27:	73 47                	jae    b70 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b29:	89 c2                	mov    %eax,%edx
 b2b:	39 05 a4 0f 00 00    	cmp    %eax,0xfa4
 b31:	75 ed                	jne    b20 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 b33:	83 ec 0c             	sub    $0xc,%esp
 b36:	56                   	push   %esi
 b37:	e8 3f f8 ff ff       	call   37b <sbrk>
  if(p == (char*)-1)
 b3c:	83 c4 10             	add    $0x10,%esp
 b3f:	83 f8 ff             	cmp    $0xffffffff,%eax
 b42:	74 1c                	je     b60 <malloc+0x80>
  hp->s.size = nu;
 b44:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 b47:	83 ec 0c             	sub    $0xc,%esp
 b4a:	83 c0 08             	add    $0x8,%eax
 b4d:	50                   	push   %eax
 b4e:	e8 ed fe ff ff       	call   a40 <free>
  return freep;
 b53:	8b 15 a4 0f 00 00    	mov    0xfa4,%edx
      if((p = morecore(nunits)) == 0)
 b59:	83 c4 10             	add    $0x10,%esp
 b5c:	85 d2                	test   %edx,%edx
 b5e:	75 c0                	jne    b20 <malloc+0x40>
        return 0;
  }
}
 b60:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 b63:	31 c0                	xor    %eax,%eax
}
 b65:	5b                   	pop    %ebx
 b66:	5e                   	pop    %esi
 b67:	5f                   	pop    %edi
 b68:	5d                   	pop    %ebp
 b69:	c3                   	ret
 b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 b70:	39 cf                	cmp    %ecx,%edi
 b72:	74 4c                	je     bc0 <malloc+0xe0>
        p->s.size -= nunits;
 b74:	29 f9                	sub    %edi,%ecx
 b76:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 b79:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 b7c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 b7f:	89 15 a4 0f 00 00    	mov    %edx,0xfa4
}
 b85:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 b88:	83 c0 08             	add    $0x8,%eax
}
 b8b:	5b                   	pop    %ebx
 b8c:	5e                   	pop    %esi
 b8d:	5f                   	pop    %edi
 b8e:	5d                   	pop    %ebp
 b8f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 b90:	c7 05 a4 0f 00 00 a8 	movl   $0xfa8,0xfa4
 b97:	0f 00 00 
    base.s.size = 0;
 b9a:	b8 a8 0f 00 00       	mov    $0xfa8,%eax
    base.s.ptr = freep = prevp = &base;
 b9f:	c7 05 a8 0f 00 00 a8 	movl   $0xfa8,0xfa8
 ba6:	0f 00 00 
    base.s.size = 0;
 ba9:	c7 05 ac 0f 00 00 00 	movl   $0x0,0xfac
 bb0:	00 00 00 
    if(p->s.size >= nunits){
 bb3:	e9 54 ff ff ff       	jmp    b0c <malloc+0x2c>
 bb8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 bbf:	00 
        prevp->s.ptr = p->s.ptr;
 bc0:	8b 08                	mov    (%eax),%ecx
 bc2:	89 0a                	mov    %ecx,(%edx)
 bc4:	eb b9                	jmp    b7f <malloc+0x9f>
