
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
  1b:	0f 8e 7d 00 00 00    	jle    9e <main+0x9e>
                printf("\n");
                exit();
        }
        p1 = argv[1];
  21:	8b 46 04             	mov    0x4(%esi),%eax
        p2 = p1;
        while (*p1) {
  24:	0f b6 10             	movzbl (%eax),%edx
        p2 = p1;
  27:	89 c1                	mov    %eax,%ecx
        while (*p1) {
  29:	84 d2                	test   %dl,%dl
  2b:	74 13                	je     40 <main+0x40>
  2d:	8d 76 00             	lea    0x0(%esi),%esi
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
  4b:	74 4c                	je     99 <main+0x99>
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
  62:	73 35                	jae    99 <main+0x99>
  64:	39 d6                	cmp    %edx,%esi
  66:	73 31                	jae    99 <main+0x99>
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
  79:	68 ea 0b 00 00       	push   $0xbea
  7e:	e8 0d 05 00 00       	call   590 <printf>
        write(1, "\n", 1);
  83:	83 c4 0c             	add    $0xc,%esp
  86:	6a 01                	push   $0x1
  88:	68 e8 0b 00 00       	push   $0xbe8
  8d:	6a 01                	push   $0x1
  8f:	e8 9f 02 00 00       	call   333 <write>
        exit();
  94:	e8 7a 02 00 00       	call   313 <exit>
                *p1 = '\0';
  99:	c6 00 00             	movb   $0x0,(%eax)
  9c:	eb d7                	jmp    75 <main+0x75>
                printf("\n");
  9e:	83 ec 0c             	sub    $0xc,%esp
  a1:	68 e8 0b 00 00       	push   $0xbe8
  a6:	e8 e5 04 00 00       	call   590 <printf>
                exit();
  ab:	e8 63 02 00 00       	call   313 <exit>
  b0:	66 90                	xchg   %ax,%ax
  b2:	66 90                	xchg   %ax,%ax
  b4:	66 90                	xchg   %ax,%ax
  b6:	66 90                	xchg   %ax,%ax
  b8:	66 90                	xchg   %ax,%ax
  ba:	66 90                	xchg   %ax,%ax
  bc:	66 90                	xchg   %ax,%ax
  be:	66 90                	xchg   %ax,%ax

000000c0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  c0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  c1:	31 c0                	xor    %eax,%eax
{
  c3:	89 e5                	mov    %esp,%ebp
  c5:	53                   	push   %ebx
  c6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  c9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  d0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  d4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  d7:	83 c0 01             	add    $0x1,%eax
  da:	84 d2                	test   %dl,%dl
  dc:	75 f2                	jne    d0 <strcpy+0x10>
    ;
  return os;
}
  de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  e1:	89 c8                	mov    %ecx,%eax
  e3:	c9                   	leave
  e4:	c3                   	ret
  e5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  ec:	00 
  ed:	8d 76 00             	lea    0x0(%esi),%esi

000000f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	53                   	push   %ebx
  f4:	8b 55 08             	mov    0x8(%ebp),%edx
  f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  fa:	0f b6 02             	movzbl (%edx),%eax
  fd:	84 c0                	test   %al,%al
  ff:	75 2f                	jne    130 <strcmp+0x40>
 101:	eb 4a                	jmp    14d <strcmp+0x5d>
 103:	eb 1b                	jmp    120 <strcmp+0x30>
 105:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 10c:	00 
 10d:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 114:	00 
 115:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 11c:	00 
 11d:	8d 76 00             	lea    0x0(%esi),%esi
 120:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 124:	83 c2 01             	add    $0x1,%edx
 127:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 12a:	84 c0                	test   %al,%al
 12c:	74 12                	je     140 <strcmp+0x50>
 12e:	89 d9                	mov    %ebx,%ecx
 130:	0f b6 19             	movzbl (%ecx),%ebx
 133:	38 c3                	cmp    %al,%bl
 135:	74 e9                	je     120 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 137:	29 d8                	sub    %ebx,%eax
}
 139:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 13c:	c9                   	leave
 13d:	c3                   	ret
 13e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 140:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 144:	31 c0                	xor    %eax,%eax
 146:	29 d8                	sub    %ebx,%eax
}
 148:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 14b:	c9                   	leave
 14c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 14d:	0f b6 19             	movzbl (%ecx),%ebx
 150:	31 c0                	xor    %eax,%eax
 152:	eb e3                	jmp    137 <strcmp+0x47>
 154:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 15b:	00 
 15c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000160 <strlen>:

uint
strlen(char *s)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 166:	80 3a 00             	cmpb   $0x0,(%edx)
 169:	74 15                	je     180 <strlen+0x20>
 16b:	31 c0                	xor    %eax,%eax
 16d:	8d 76 00             	lea    0x0(%esi),%esi
 170:	83 c0 01             	add    $0x1,%eax
 173:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 177:	89 c1                	mov    %eax,%ecx
 179:	75 f5                	jne    170 <strlen+0x10>
    ;
  return n;
}
 17b:	89 c8                	mov    %ecx,%eax
 17d:	5d                   	pop    %ebp
 17e:	c3                   	ret
 17f:	90                   	nop
  for(n = 0; s[n]; n++)
 180:	31 c9                	xor    %ecx,%ecx
}
 182:	5d                   	pop    %ebp
 183:	89 c8                	mov    %ecx,%eax
 185:	c3                   	ret
 186:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 18d:	00 
 18e:	66 90                	xchg   %ax,%ax

00000190 <memset>:

void*
memset(void *dst, int c, uint n)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	57                   	push   %edi
 194:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 197:	8b 4d 10             	mov    0x10(%ebp),%ecx
 19a:	8b 45 0c             	mov    0xc(%ebp),%eax
 19d:	89 d7                	mov    %edx,%edi
 19f:	fc                   	cld
 1a0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1a2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 1a5:	89 d0                	mov    %edx,%eax
 1a7:	c9                   	leave
 1a8:	c3                   	ret
 1a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001b0 <strchr>:

char*
strchr(const char *s, char c)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 45 08             	mov    0x8(%ebp),%eax
 1b6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1ba:	0f b6 10             	movzbl (%eax),%edx
 1bd:	84 d2                	test   %dl,%dl
 1bf:	75 1a                	jne    1db <strchr+0x2b>
 1c1:	eb 25                	jmp    1e8 <strchr+0x38>
 1c3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ca:	00 
 1cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 1d0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 1d4:	83 c0 01             	add    $0x1,%eax
 1d7:	84 d2                	test   %dl,%dl
 1d9:	74 0d                	je     1e8 <strchr+0x38>
    if(*s == c)
 1db:	38 d1                	cmp    %dl,%cl
 1dd:	75 f1                	jne    1d0 <strchr+0x20>
      return (char*)s;
  return 0;
}
 1df:	5d                   	pop    %ebp
 1e0:	c3                   	ret
 1e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 1e8:	31 c0                	xor    %eax,%eax
}
 1ea:	5d                   	pop    %ebp
 1eb:	c3                   	ret
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001f0 <gets>:

char*
gets(char *buf, int max)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	57                   	push   %edi
 1f4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 1f5:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 1f8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 1f9:	31 db                	xor    %ebx,%ebx
{
 1fb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 1fe:	eb 27                	jmp    227 <gets+0x37>
    cc = read(0, &c, 1);
 200:	83 ec 04             	sub    $0x4,%esp
 203:	6a 01                	push   $0x1
 205:	56                   	push   %esi
 206:	6a 00                	push   $0x0
 208:	e8 1e 01 00 00       	call   32b <read>
    if(cc < 1)
 20d:	83 c4 10             	add    $0x10,%esp
 210:	85 c0                	test   %eax,%eax
 212:	7e 1d                	jle    231 <gets+0x41>
      break;
    buf[i++] = c;
 214:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 218:	8b 55 08             	mov    0x8(%ebp),%edx
 21b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 21f:	3c 0a                	cmp    $0xa,%al
 221:	74 10                	je     233 <gets+0x43>
 223:	3c 0d                	cmp    $0xd,%al
 225:	74 0c                	je     233 <gets+0x43>
  for(i=0; i+1 < max; ){
 227:	89 df                	mov    %ebx,%edi
 229:	83 c3 01             	add    $0x1,%ebx
 22c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 22f:	7c cf                	jl     200 <gets+0x10>
 231:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 233:	8b 45 08             	mov    0x8(%ebp),%eax
 236:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 23a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 23d:	5b                   	pop    %ebx
 23e:	5e                   	pop    %esi
 23f:	5f                   	pop    %edi
 240:	5d                   	pop    %ebp
 241:	c3                   	ret
 242:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 249:	00 
 24a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000250 <stat>:

int
stat(char *n, struct stat *st)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	56                   	push   %esi
 254:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 255:	83 ec 08             	sub    $0x8,%esp
 258:	6a 00                	push   $0x0
 25a:	ff 75 08             	push   0x8(%ebp)
 25d:	e8 f1 00 00 00       	call   353 <open>
  if(fd < 0)
 262:	83 c4 10             	add    $0x10,%esp
 265:	85 c0                	test   %eax,%eax
 267:	78 27                	js     290 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 269:	83 ec 08             	sub    $0x8,%esp
 26c:	ff 75 0c             	push   0xc(%ebp)
 26f:	89 c3                	mov    %eax,%ebx
 271:	50                   	push   %eax
 272:	e8 f4 00 00 00       	call   36b <fstat>
  close(fd);
 277:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 27a:	89 c6                	mov    %eax,%esi
  close(fd);
 27c:	e8 ba 00 00 00       	call   33b <close>
  return r;
 281:	83 c4 10             	add    $0x10,%esp
}
 284:	8d 65 f8             	lea    -0x8(%ebp),%esp
 287:	89 f0                	mov    %esi,%eax
 289:	5b                   	pop    %ebx
 28a:	5e                   	pop    %esi
 28b:	5d                   	pop    %ebp
 28c:	c3                   	ret
 28d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 290:	be ff ff ff ff       	mov    $0xffffffff,%esi
 295:	eb ed                	jmp    284 <stat+0x34>
 297:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 29e:	00 
 29f:	90                   	nop

000002a0 <atoi>:

int
atoi(const char *s)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	53                   	push   %ebx
 2a4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2a7:	0f be 02             	movsbl (%edx),%eax
 2aa:	8d 48 d0             	lea    -0x30(%eax),%ecx
 2ad:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 2b0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 2b5:	77 1e                	ja     2d5 <atoi+0x35>
 2b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2be:	00 
 2bf:	90                   	nop
    n = n*10 + *s++ - '0';
 2c0:	83 c2 01             	add    $0x1,%edx
 2c3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 2c6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 2ca:	0f be 02             	movsbl (%edx),%eax
 2cd:	8d 58 d0             	lea    -0x30(%eax),%ebx
 2d0:	80 fb 09             	cmp    $0x9,%bl
 2d3:	76 eb                	jbe    2c0 <atoi+0x20>
  return n;
}
 2d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2d8:	89 c8                	mov    %ecx,%eax
 2da:	c9                   	leave
 2db:	c3                   	ret
 2dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002e0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	57                   	push   %edi
 2e4:	8b 45 10             	mov    0x10(%ebp),%eax
 2e7:	8b 55 08             	mov    0x8(%ebp),%edx
 2ea:	56                   	push   %esi
 2eb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ee:	85 c0                	test   %eax,%eax
 2f0:	7e 13                	jle    305 <memmove+0x25>
 2f2:	01 d0                	add    %edx,%eax
  dst = vdst;
 2f4:	89 d7                	mov    %edx,%edi
 2f6:	66 90                	xchg   %ax,%ax
 2f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ff:	00 
    *dst++ = *src++;
 300:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 301:	39 f8                	cmp    %edi,%eax
 303:	75 fb                	jne    300 <memmove+0x20>
  return vdst;
}
 305:	5e                   	pop    %esi
 306:	89 d0                	mov    %edx,%eax
 308:	5f                   	pop    %edi
 309:	5d                   	pop    %ebp
 30a:	c3                   	ret

0000030b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 30b:	b8 01 00 00 00       	mov    $0x1,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret

00000313 <exit>:
SYSCALL(exit)
 313:	b8 02 00 00 00       	mov    $0x2,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret

0000031b <wait>:
SYSCALL(wait)
 31b:	b8 03 00 00 00       	mov    $0x3,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret

00000323 <pipe>:
SYSCALL(pipe)
 323:	b8 04 00 00 00       	mov    $0x4,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret

0000032b <read>:
SYSCALL(read)
 32b:	b8 05 00 00 00       	mov    $0x5,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret

00000333 <write>:
SYSCALL(write)
 333:	b8 10 00 00 00       	mov    $0x10,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret

0000033b <close>:
SYSCALL(close)
 33b:	b8 15 00 00 00       	mov    $0x15,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret

00000343 <kill>:
SYSCALL(kill)
 343:	b8 06 00 00 00       	mov    $0x6,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret

0000034b <exec>:
SYSCALL(exec)
 34b:	b8 07 00 00 00       	mov    $0x7,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <open>:
SYSCALL(open)
 353:	b8 0f 00 00 00       	mov    $0xf,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <mknod>:
SYSCALL(mknod)
 35b:	b8 11 00 00 00       	mov    $0x11,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <unlink>:
SYSCALL(unlink)
 363:	b8 12 00 00 00       	mov    $0x12,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <fstat>:
SYSCALL(fstat)
 36b:	b8 08 00 00 00       	mov    $0x8,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <link>:
SYSCALL(link)
 373:	b8 13 00 00 00       	mov    $0x13,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <mkdir>:
SYSCALL(mkdir)
 37b:	b8 14 00 00 00       	mov    $0x14,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

00000383 <chdir>:
SYSCALL(chdir)
 383:	b8 09 00 00 00       	mov    $0x9,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

0000038b <dup>:
SYSCALL(dup)
 38b:	b8 0a 00 00 00       	mov    $0xa,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <getpid>:
SYSCALL(getpid)
 393:	b8 0b 00 00 00       	mov    $0xb,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <sbrk>:
SYSCALL(sbrk)
 39b:	b8 0c 00 00 00       	mov    $0xc,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <sleep>:
SYSCALL(sleep)
 3a3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <uptime>:
SYSCALL(uptime)
 3ab:	b8 0e 00 00 00       	mov    $0xe,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <bstat>:
SYSCALL(bstat)
 3b3:	b8 16 00 00 00       	mov    $0x16,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

000003bb <swap>:
SYSCALL(swap)
 3bb:	b8 17 00 00 00       	mov    $0x17,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <gettime>:
SYSCALL(gettime)
 3c3:	b8 18 00 00 00       	mov    $0x18,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

000003cb <setcursor>:
SYSCALL(setcursor)
 3cb:	b8 19 00 00 00       	mov    $0x19,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <uname>:
SYSCALL(uname)
 3d3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <echo>:
SYSCALL(echo)
 3db:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret
 3e3:	66 90                	xchg   %ax,%ax
 3e5:	66 90                	xchg   %ax,%ax
 3e7:	66 90                	xchg   %ax,%ax
 3e9:	66 90                	xchg   %ax,%ax
 3eb:	66 90                	xchg   %ax,%ax
 3ed:	66 90                	xchg   %ax,%ax
 3ef:	66 90                	xchg   %ax,%ax
 3f1:	66 90                	xchg   %ax,%ax
 3f3:	66 90                	xchg   %ax,%ax
 3f5:	66 90                	xchg   %ax,%ax
 3f7:	66 90                	xchg   %ax,%ax
 3f9:	66 90                	xchg   %ax,%ax
 3fb:	66 90                	xchg   %ax,%ax
 3fd:	66 90                	xchg   %ax,%ax
 3ff:	90                   	nop

00000400 <printint.constprop.0>:
{
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn, int width, char pad_char)
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	56                   	push   %esi
 405:	89 c6                	mov    %eax,%esi
 407:	53                   	push   %ebx
 408:	89 d3                	mov    %edx,%ebx
 40a:	83 ec 3c             	sub    $0x3c,%esp
 40d:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 411:	85 f6                	test   %esi,%esi
 413:	0f 89 d7 00 00 00    	jns    4f0 <printint.constprop.0+0xf0>
 419:	83 e1 01             	and    $0x1,%ecx
 41c:	0f 84 ce 00 00 00    	je     4f0 <printint.constprop.0+0xf0>
    neg = 1;
 422:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 429:	f7 de                	neg    %esi
 42b:	89 f1                	mov    %esi,%ecx
  } else {
    x = xx;
  }

  i = 0;
 42d:	88 45 bf             	mov    %al,-0x41(%ebp)
 430:	31 ff                	xor    %edi,%edi
 432:	8d 75 d7             	lea    -0x29(%ebp),%esi
 435:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 43c:	00 
 43d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 440:	89 c8                	mov    %ecx,%eax
 442:	31 d2                	xor    %edx,%edx
 444:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 447:	83 c7 01             	add    $0x1,%edi
 44a:	f7 f3                	div    %ebx
 44c:	0f b6 92 a4 0c 00 00 	movzbl 0xca4(%edx),%edx
 453:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 456:	89 ca                	mov    %ecx,%edx
 458:	89 c1                	mov    %eax,%ecx
 45a:	39 da                	cmp    %ebx,%edx
 45c:	73 e2                	jae    440 <printint.constprop.0+0x40>

  if(neg)
 45e:	8b 55 c0             	mov    -0x40(%ebp),%edx
 461:	0f b6 45 bf          	movzbl -0x41(%ebp),%eax
 465:	85 d2                	test   %edx,%edx
 467:	74 0b                	je     474 <printint.constprop.0+0x74>
    buf[i++] = '-';
 469:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
 46c:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 471:	8d 79 02             	lea    0x2(%ecx),%edi

  // Pad with pad_char until we hit the required width
  while(i < width)
 474:	39 7d 08             	cmp    %edi,0x8(%ebp)
 477:	0f 8e 83 00 00 00    	jle    500 <printint.constprop.0+0x100>
 47d:	8b 55 08             	mov    0x8(%ebp),%edx
 480:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 483:	01 df                	add    %ebx,%edi
 485:	01 da                	add    %ebx,%edx
 487:	89 d1                	mov    %edx,%ecx
 489:	29 f9                	sub    %edi,%ecx
 48b:	83 e1 01             	and    $0x1,%ecx
 48e:	74 10                	je     4a0 <printint.constprop.0+0xa0>
    buf[i++] = pad_char;
 490:	88 07                	mov    %al,(%edi)
  while(i < width)
 492:	83 c7 01             	add    $0x1,%edi
 495:	39 d7                	cmp    %edx,%edi
 497:	74 13                	je     4ac <printint.constprop.0+0xac>
 499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = pad_char;
 4a0:	88 07                	mov    %al,(%edi)
  while(i < width)
 4a2:	83 c7 02             	add    $0x2,%edi
    buf[i++] = pad_char;
 4a5:	88 47 ff             	mov    %al,-0x1(%edi)
  while(i < width)
 4a8:	39 d7                	cmp    %edx,%edi
 4aa:	75 f4                	jne    4a0 <printint.constprop.0+0xa0>
 4ac:	8b 45 08             	mov    0x8(%ebp),%eax
 4af:	8d 78 ff             	lea    -0x1(%eax),%edi

  while(--i >= 0)
 4b2:	01 df                	add    %ebx,%edi
 4b4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4bb:	00 
 4bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 4c0:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 4c3:	83 ec 04             	sub    $0x4,%esp
 4c6:	88 45 d7             	mov    %al,-0x29(%ebp)
 4c9:	6a 01                	push   $0x1
 4cb:	56                   	push   %esi
 4cc:	6a 01                	push   $0x1
 4ce:	e8 60 fe ff ff       	call   333 <write>
  while(--i >= 0)
 4d3:	89 f8                	mov    %edi,%eax
 4d5:	83 c4 10             	add    $0x10,%esp
 4d8:	83 ef 01             	sub    $0x1,%edi
 4db:	39 d8                	cmp    %ebx,%eax
 4dd:	75 e1                	jne    4c0 <printint.constprop.0+0xc0>
}
 4df:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4e2:	5b                   	pop    %ebx
 4e3:	5e                   	pop    %esi
 4e4:	5f                   	pop    %edi
 4e5:	5d                   	pop    %ebp
 4e6:	c3                   	ret
 4e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4ee:	00 
 4ef:	90                   	nop
  neg = 0;
 4f0:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = xx;
 4f7:	89 f1                	mov    %esi,%ecx
 4f9:	e9 2f ff ff ff       	jmp    42d <printint.constprop.0+0x2d>
 4fe:	66 90                	xchg   %ax,%ax
  while(--i >= 0)
 500:	83 ef 01             	sub    $0x1,%edi
 503:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 506:	eb aa                	jmp    4b2 <printint.constprop.0+0xb2>
 508:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 50f:	00 

00000510 <strncpy>:
{
 510:	55                   	push   %ebp
 511:	31 c0                	xor    %eax,%eax
 513:	89 e5                	mov    %esp,%ebp
 515:	56                   	push   %esi
 516:	8b 4d 08             	mov    0x8(%ebp),%ecx
 519:	8b 75 0c             	mov    0xc(%ebp),%esi
 51c:	53                   	push   %ebx
 51d:	8b 5d 10             	mov    0x10(%ebp),%ebx
  for (i = 0; i < n && src[i]; i++)
 520:	85 db                	test   %ebx,%ebx
 522:	7f 26                	jg     54a <strncpy+0x3a>
 524:	eb 58                	jmp    57e <strncpy+0x6e>
 526:	eb 18                	jmp    540 <strncpy+0x30>
 528:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 52f:	00 
 530:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 537:	00 
 538:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 53f:	00 
    dest[i] = src[i];
 540:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  for (i = 0; i < n && src[i]; i++)
 543:	83 c0 01             	add    $0x1,%eax
 546:	39 c3                	cmp    %eax,%ebx
 548:	74 34                	je     57e <strncpy+0x6e>
 54a:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
 54e:	84 d2                	test   %dl,%dl
 550:	75 ee                	jne    540 <strncpy+0x30>
  for (; i < n; i++)
 552:	39 c3                	cmp    %eax,%ebx
 554:	7e 28                	jle    57e <strncpy+0x6e>
 556:	01 c8                	add    %ecx,%eax
 558:	01 d9                	add    %ebx,%ecx
 55a:	89 ca                	mov    %ecx,%edx
 55c:	29 c2                	sub    %eax,%edx
 55e:	83 e2 01             	and    $0x1,%edx
 561:	74 0d                	je     570 <strncpy+0x60>
    dest[i] = '\0';
 563:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
 566:	83 c0 01             	add    $0x1,%eax
 569:	39 c8                	cmp    %ecx,%eax
 56b:	74 11                	je     57e <strncpy+0x6e>
 56d:	8d 76 00             	lea    0x0(%esi),%esi
    dest[i] = '\0';
 570:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
 573:	83 c0 02             	add    $0x2,%eax
    dest[i] = '\0';
 576:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  for (; i < n; i++)
 57a:	39 c8                	cmp    %ecx,%eax
 57c:	75 f2                	jne    570 <strncpy+0x60>
}
 57e:	5b                   	pop    %ebx
 57f:	5e                   	pop    %esi
 580:	5d                   	pop    %ebp
 581:	c3                   	ret
 582:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 589:	00 
 58a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000590 <printf>:

void
printf(char *fmt, ...)
{
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	57                   	push   %edi
 594:	56                   	push   %esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 595:	8d 75 0c             	lea    0xc(%ebp),%esi
{
 598:	53                   	push   %ebx
 599:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  for(i = 0; fmt[i]; i++){
 59c:	8b 55 08             	mov    0x8(%ebp),%edx
  ap = (uint*)(void*)&fmt + 1;
 59f:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 5a2:	0f b6 02             	movzbl (%edx),%eax
 5a5:	84 c0                	test   %al,%al
 5a7:	0f 84 88 00 00 00    	je     635 <printf+0xa5>
 5ad:	8d 7a 01             	lea    0x1(%edx),%edi
    c = fmt[i] & 0xff;
 5b0:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
      if (c == '\f') {
 5b3:	83 fa 0c             	cmp    $0xc,%edx
 5b6:	0f 84 d4 01 00 00    	je     790 <printf+0x200>
        setcursor();
      } else if(c == '%'){
 5bc:	83 fa 25             	cmp    $0x25,%edx
 5bf:	0f 85 0b 02 00 00    	jne    7d0 <printf+0x240>
  for(i = 0; fmt[i]; i++){
 5c5:	0f b6 1f             	movzbl (%edi),%ebx
 5c8:	83 c7 01             	add    $0x1,%edi
 5cb:	84 db                	test   %bl,%bl
 5cd:	74 66                	je     635 <printf+0xa5>
    c = fmt[i] & 0xff;
 5cf:	0f b6 c3             	movzbl %bl,%eax
 5d2:	ba 20 00 00 00       	mov    $0x20,%edx
 5d7:	31 c9                	xor    %ecx,%ecx
        pad_char = ' ';
      } else {
        putc(1, c);
      }
    } else if(state == '%'){
      if(c == '0'){
 5d9:	83 f8 78             	cmp    $0x78,%eax
 5dc:	7f 22                	jg     600 <printf+0x70>
 5de:	83 f8 62             	cmp    $0x62,%eax
 5e1:	0f 8e b9 01 00 00    	jle    7a0 <printf+0x210>
 5e7:	83 e8 63             	sub    $0x63,%eax
 5ea:	83 f8 15             	cmp    $0x15,%eax
 5ed:	77 11                	ja     600 <printf+0x70>
 5ef:	ff 24 85 f4 0b 00 00 	jmp    *0xbf4(,%eax,4)
 5f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5fd:	00 
 5fe:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 600:	83 ec 04             	sub    $0x4,%esp
 603:	8d 75 e7             	lea    -0x19(%ebp),%esi
 606:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 60a:	6a 01                	push   $0x1
 60c:	56                   	push   %esi
 60d:	6a 01                	push   $0x1
 60f:	e8 1f fd ff ff       	call   333 <write>
 614:	83 c4 0c             	add    $0xc,%esp
 617:	88 5d e7             	mov    %bl,-0x19(%ebp)
 61a:	6a 01                	push   $0x1
 61c:	56                   	push   %esi
 61d:	6a 01                	push   $0x1
 61f:	e8 0f fd ff ff       	call   333 <write>
      } else if(c == '%'){
        putc(1, '%');
        state = 0;
      } else {
        putc(1, '%');
        putc(1, c);
 624:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 627:	0f b6 07             	movzbl (%edi),%eax
 62a:	83 c7 01             	add    $0x1,%edi
 62d:	84 c0                	test   %al,%al
 62f:	0f 85 7b ff ff ff    	jne    5b0 <printf+0x20>
        state = 0;
      }
    }
  }
}
 635:	8d 65 f4             	lea    -0xc(%ebp),%esp
 638:	5b                   	pop    %ebx
 639:	5e                   	pop    %esi
 63a:	5f                   	pop    %edi
 63b:	5d                   	pop    %ebp
 63c:	c3                   	ret
 63d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 16, 0, width, pad_char);
 640:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 643:	83 ec 08             	sub    $0x8,%esp
 646:	8b 06                	mov    (%esi),%eax
 648:	52                   	push   %edx
 649:	ba 10 00 00 00       	mov    $0x10,%edx
 64e:	51                   	push   %ecx
 64f:	31 c9                	xor    %ecx,%ecx
        printint(1, *ap, 10, 1, width, pad_char);
 651:	e8 aa fd ff ff       	call   400 <printint.constprop.0>
        ap++;
 656:	83 c6 04             	add    $0x4,%esi
 659:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 65c:	0f b6 07             	movzbl (%edi),%eax
 65f:	83 c7 01             	add    $0x1,%edi
 662:	83 c4 10             	add    $0x10,%esp
 665:	84 c0                	test   %al,%al
 667:	0f 85 43 ff ff ff    	jne    5b0 <printf+0x20>
}
 66d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 670:	5b                   	pop    %ebx
 671:	5e                   	pop    %esi
 672:	5f                   	pop    %edi
 673:	5d                   	pop    %ebp
 674:	c3                   	ret
 675:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 10, 1, width, pad_char);
 678:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 67b:	83 ec 08             	sub    $0x8,%esp
 67e:	8b 06                	mov    (%esi),%eax
 680:	52                   	push   %edx
 681:	ba 0a 00 00 00       	mov    $0xa,%edx
 686:	51                   	push   %ecx
 687:	b9 01 00 00 00       	mov    $0x1,%ecx
 68c:	eb c3                	jmp    651 <printf+0xc1>
 68e:	66 90                	xchg   %ax,%ax
        s = (char*)*ap;
 690:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 693:	8b 06                	mov    (%esi),%eax
        ap++;
 695:	83 c6 04             	add    $0x4,%esi
 698:	89 75 d4             	mov    %esi,-0x2c(%ebp)
        if(s == 0)
 69b:	85 c0                	test   %eax,%eax
 69d:	0f 85 9d 01 00 00    	jne    840 <printf+0x2b0>
 6a3:	c6 45 d0 28          	movb   $0x28,-0x30(%ebp)
          s = "(null)";
 6a7:	b8 ed 0b 00 00       	mov    $0xbed,%eax
        int len = 0;
 6ac:	31 db                	xor    %ebx,%ebx
 6ae:	66 90                	xchg   %ax,%ax
        for (char *t = s; *t; t++) len++;
 6b0:	83 c3 01             	add    $0x1,%ebx
 6b3:	80 3c 18 00          	cmpb   $0x0,(%eax,%ebx,1)
 6b7:	75 f7                	jne    6b0 <printf+0x120>
        for (int j = len; j < width; j++)
 6b9:	39 cb                	cmp    %ecx,%ebx
 6bb:	0f 8d 9c 01 00 00    	jge    85d <printf+0x2cd>
 6c1:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 6c4:	8d 75 e7             	lea    -0x19(%ebp),%esi
 6c7:	89 45 c8             	mov    %eax,-0x38(%ebp)
 6ca:	89 7d cc             	mov    %edi,-0x34(%ebp)
 6cd:	89 df                	mov    %ebx,%edi
 6cf:	89 d3                	mov    %edx,%ebx
 6d1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6d8:	00 
 6d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 6e0:	83 ec 04             	sub    $0x4,%esp
 6e3:	88 5d e7             	mov    %bl,-0x19(%ebp)
        for (int j = len; j < width; j++)
 6e6:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 6e9:	6a 01                	push   $0x1
 6eb:	56                   	push   %esi
 6ec:	6a 01                	push   $0x1
 6ee:	e8 40 fc ff ff       	call   333 <write>
        for (int j = len; j < width; j++)
 6f3:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6f6:	83 c4 10             	add    $0x10,%esp
 6f9:	39 c7                	cmp    %eax,%edi
 6fb:	7c e3                	jl     6e0 <printf+0x150>
        while(*s != 0){
 6fd:	8b 45 c8             	mov    -0x38(%ebp),%eax
 700:	8b 7d cc             	mov    -0x34(%ebp),%edi
 703:	0f b6 08             	movzbl (%eax),%ecx
 706:	88 4d d0             	mov    %cl,-0x30(%ebp)
 709:	84 c9                	test   %cl,%cl
 70b:	0f 84 16 ff ff ff    	je     627 <printf+0x97>
 711:	89 c3                	mov    %eax,%ebx
 713:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 717:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 71e:	00 
 71f:	90                   	nop
  write(fd, &c, 1);
 720:	83 ec 04             	sub    $0x4,%esp
 723:	88 45 e7             	mov    %al,-0x19(%ebp)
          putc(1, *s++);
 726:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 729:	6a 01                	push   $0x1
 72b:	56                   	push   %esi
 72c:	6a 01                	push   $0x1
 72e:	e8 00 fc ff ff       	call   333 <write>
        while(*s != 0){
 733:	0f b6 03             	movzbl (%ebx),%eax
 736:	83 c4 10             	add    $0x10,%esp
 739:	84 c0                	test   %al,%al
 73b:	75 e3                	jne    720 <printf+0x190>
 73d:	e9 e5 fe ff ff       	jmp    627 <printf+0x97>
 742:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        char ch = *ap++;
 748:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 74b:	83 ec 04             	sub    $0x4,%esp
 74e:	8d 75 e7             	lea    -0x19(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 751:	83 c7 01             	add    $0x1,%edi
        char ch = *ap++;
 754:	8d 58 04             	lea    0x4(%eax),%ebx
 757:	8b 00                	mov    (%eax),%eax
 759:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 75c:	6a 01                	push   $0x1
 75e:	56                   	push   %esi
 75f:	6a 01                	push   $0x1
 761:	e8 cd fb ff ff       	call   333 <write>
  for(i = 0; fmt[i]; i++){
 766:	0f b6 47 ff          	movzbl -0x1(%edi),%eax
 76a:	83 c4 10             	add    $0x10,%esp
 76d:	84 c0                	test   %al,%al
 76f:	0f 84 c0 fe ff ff    	je     635 <printf+0xa5>
    c = fmt[i] & 0xff;
 775:	0f b6 d0             	movzbl %al,%edx
        char ch = *ap++;
 778:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      if (c == '\f') {
 77b:	83 fa 0c             	cmp    $0xc,%edx
 77e:	0f 85 38 fe ff ff    	jne    5bc <printf+0x2c>
 784:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 78b:	00 
 78c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        setcursor();
 790:	e8 36 fc ff ff       	call   3cb <setcursor>
 795:	e9 8d fe ff ff       	jmp    627 <printf+0x97>
 79a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 7a0:	83 f8 30             	cmp    $0x30,%eax
 7a3:	74 7b                	je     820 <printf+0x290>
 7a5:	7f 49                	jg     7f0 <printf+0x260>
 7a7:	83 f8 25             	cmp    $0x25,%eax
 7aa:	0f 85 50 fe ff ff    	jne    600 <printf+0x70>
  write(fd, &c, 1);
 7b0:	83 ec 04             	sub    $0x4,%esp
 7b3:	8d 75 e7             	lea    -0x19(%ebp),%esi
 7b6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 7ba:	6a 01                	push   $0x1
 7bc:	56                   	push   %esi
 7bd:	6a 01                	push   $0x1
 7bf:	e8 6f fb ff ff       	call   333 <write>
        state = 0;
 7c4:	83 c4 10             	add    $0x10,%esp
 7c7:	e9 5b fe ff ff       	jmp    627 <printf+0x97>
 7cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 7d0:	83 ec 04             	sub    $0x4,%esp
 7d3:	8d 75 e7             	lea    -0x19(%ebp),%esi
 7d6:	88 45 e7             	mov    %al,-0x19(%ebp)
 7d9:	6a 01                	push   $0x1
 7db:	56                   	push   %esi
 7dc:	6a 01                	push   $0x1
 7de:	e8 50 fb ff ff       	call   333 <write>
  for(i = 0; fmt[i]; i++){
 7e3:	e9 74 fe ff ff       	jmp    65c <printf+0xcc>
 7e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7ef:	00 
 7f0:	8d 70 cf             	lea    -0x31(%eax),%esi
 7f3:	83 fe 08             	cmp    $0x8,%esi
 7f6:	0f 87 04 fe ff ff    	ja     600 <printf+0x70>
 7fc:	0f b6 1f             	movzbl (%edi),%ebx
        width = width * 10 + (c - '0');
 7ff:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
  for(i = 0; fmt[i]; i++){
 802:	83 c7 01             	add    $0x1,%edi
        width = width * 10 + (c - '0');
 805:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  for(i = 0; fmt[i]; i++){
 809:	84 db                	test   %bl,%bl
 80b:	0f 84 24 fe ff ff    	je     635 <printf+0xa5>
    c = fmt[i] & 0xff;
 811:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 814:	e9 c0 fd ff ff       	jmp    5d9 <printf+0x49>
 819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 820:	0f b6 1f             	movzbl (%edi),%ebx
 823:	83 c7 01             	add    $0x1,%edi
 826:	84 db                	test   %bl,%bl
 828:	0f 84 07 fe ff ff    	je     635 <printf+0xa5>
    c = fmt[i] & 0xff;
 82e:	0f b6 c3             	movzbl %bl,%eax
 831:	ba 30 00 00 00       	mov    $0x30,%edx
 836:	e9 9e fd ff ff       	jmp    5d9 <printf+0x49>
 83b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        for (char *t = s; *t; t++) len++;
 840:	0f b6 18             	movzbl (%eax),%ebx
 843:	88 5d d0             	mov    %bl,-0x30(%ebp)
 846:	84 db                	test   %bl,%bl
 848:	0f 85 5e fe ff ff    	jne    6ac <printf+0x11c>
        int len = 0;
 84e:	31 db                	xor    %ebx,%ebx
        for (int j = len; j < width; j++)
 850:	85 c9                	test   %ecx,%ecx
 852:	0f 8f 69 fe ff ff    	jg     6c1 <printf+0x131>
 858:	e9 ca fd ff ff       	jmp    627 <printf+0x97>
 85d:	89 c2                	mov    %eax,%edx
 85f:	8d 75 e7             	lea    -0x19(%ebp),%esi
 862:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 866:	89 d3                	mov    %edx,%ebx
 868:	e9 b3 fe ff ff       	jmp    720 <printf+0x190>
 86d:	8d 76 00             	lea    0x0(%esi),%esi

00000870 <fprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
fprintf(int fd, char *fmt, ...)
{
 870:	55                   	push   %ebp
 871:	89 e5                	mov    %esp,%ebp
 873:	57                   	push   %edi
 874:	56                   	push   %esi
 875:	53                   	push   %ebx
 876:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 879:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 87c:	0f b6 13             	movzbl (%ebx),%edx
 87f:	83 c3 01             	add    $0x1,%ebx
 882:	84 d2                	test   %dl,%dl
 884:	0f 84 81 00 00 00    	je     90b <fprintf+0x9b>
 88a:	8d 75 10             	lea    0x10(%ebp),%esi
 88d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 890:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if (c == '\f') { // Detect formfeed character
 893:	83 f8 0c             	cmp    $0xc,%eax
 896:	0f 84 04 01 00 00    	je     9a0 <fprintf+0x130>
        setcursor();
      } else
      if(c == '%'){
 89c:	83 f8 25             	cmp    $0x25,%eax
 89f:	0f 85 5b 01 00 00    	jne    a00 <fprintf+0x190>
  for(i = 0; fmt[i]; i++){
 8a5:	0f b6 13             	movzbl (%ebx),%edx
 8a8:	84 d2                	test   %dl,%dl
 8aa:	74 5f                	je     90b <fprintf+0x9b>
    c = fmt[i] & 0xff;
 8ac:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 8af:	80 fa 25             	cmp    $0x25,%dl
 8b2:	0f 84 78 01 00 00    	je     a30 <fprintf+0x1c0>
 8b8:	83 e8 63             	sub    $0x63,%eax
 8bb:	83 f8 15             	cmp    $0x15,%eax
 8be:	77 10                	ja     8d0 <fprintf+0x60>
 8c0:	ff 24 85 4c 0c 00 00 	jmp    *0xc4c(,%eax,4)
 8c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8ce:	00 
 8cf:	90                   	nop
  write(fd, &c, 1);
 8d0:	83 ec 04             	sub    $0x4,%esp
 8d3:	8d 7d e7             	lea    -0x19(%ebp),%edi
 8d6:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8d9:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 8dd:	6a 01                	push   $0x1
 8df:	57                   	push   %edi
 8e0:	ff 75 08             	push   0x8(%ebp)
 8e3:	e8 4b fa ff ff       	call   333 <write>
        putc(fd, c);
 8e8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 8ec:	83 c4 0c             	add    $0xc,%esp
 8ef:	88 55 e7             	mov    %dl,-0x19(%ebp)
 8f2:	6a 01                	push   $0x1
 8f4:	57                   	push   %edi
 8f5:	ff 75 08             	push   0x8(%ebp)
 8f8:	e8 36 fa ff ff       	call   333 <write>
  for(i = 0; fmt[i]; i++){
 8fd:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 901:	83 c3 02             	add    $0x2,%ebx
 904:	83 c4 10             	add    $0x10,%esp
 907:	84 d2                	test   %dl,%dl
 909:	75 85                	jne    890 <fprintf+0x20>
      }
      state = 0;
    }
  }
}
 90b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 90e:	5b                   	pop    %ebx
 90f:	5e                   	pop    %esi
 910:	5f                   	pop    %edi
 911:	5d                   	pop    %ebp
 912:	c3                   	ret
 913:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(1, *ap, 16, 0, width, pad_char);
 918:	83 ec 08             	sub    $0x8,%esp
 91b:	8b 06                	mov    (%esi),%eax
 91d:	31 c9                	xor    %ecx,%ecx
 91f:	ba 10 00 00 00       	mov    $0x10,%edx
 924:	6a 20                	push   $0x20
 926:	6a 00                	push   $0x0
 928:	e8 d3 fa ff ff       	call   400 <printint.constprop.0>
        ap++;
 92d:	83 c6 04             	add    $0x4,%esi
  for(i = 0; fmt[i]; i++){
 930:	eb cb                	jmp    8fd <fprintf+0x8d>
 932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s = (char*)*ap;
 938:	8b 3e                	mov    (%esi),%edi
        ap++;
 93a:	83 c6 04             	add    $0x4,%esi
        if(s == 0)
 93d:	85 ff                	test   %edi,%edi
 93f:	0f 84 fb 00 00 00    	je     a40 <fprintf+0x1d0>
        while(*s != 0){
 945:	0f b6 07             	movzbl (%edi),%eax
 948:	84 c0                	test   %al,%al
 94a:	74 36                	je     982 <fprintf+0x112>
 94c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 94f:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 952:	8b 75 08             	mov    0x8(%ebp),%esi
 955:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 958:	89 fb                	mov    %edi,%ebx
 95a:	89 cf                	mov    %ecx,%edi
 95c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 960:	83 ec 04             	sub    $0x4,%esp
 963:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 966:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 969:	6a 01                	push   $0x1
 96b:	57                   	push   %edi
 96c:	56                   	push   %esi
 96d:	e8 c1 f9 ff ff       	call   333 <write>
        while(*s != 0){
 972:	0f b6 03             	movzbl (%ebx),%eax
 975:	83 c4 10             	add    $0x10,%esp
 978:	84 c0                	test   %al,%al
 97a:	75 e4                	jne    960 <fprintf+0xf0>
 97c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 97f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 982:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 986:	83 c3 02             	add    $0x2,%ebx
 989:	84 d2                	test   %dl,%dl
 98b:	0f 84 7a ff ff ff    	je     90b <fprintf+0x9b>
    c = fmt[i] & 0xff;
 991:	0f b6 c2             	movzbl %dl,%eax
      if (c == '\f') { // Detect formfeed character
 994:	83 f8 0c             	cmp    $0xc,%eax
 997:	0f 85 ff fe ff ff    	jne    89c <fprintf+0x2c>
 99d:	8d 76 00             	lea    0x0(%esi),%esi
        setcursor();
 9a0:	e8 26 fa ff ff       	call   3cb <setcursor>
  for(i = 0; fmt[i]; i++){
 9a5:	0f b6 13             	movzbl (%ebx),%edx
 9a8:	83 c3 01             	add    $0x1,%ebx
 9ab:	84 d2                	test   %dl,%dl
 9ad:	0f 85 dd fe ff ff    	jne    890 <fprintf+0x20>
 9b3:	e9 53 ff ff ff       	jmp    90b <fprintf+0x9b>
 9b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 9bf:	00 
        printint(1, *ap, 10, 1, width, pad_char);
 9c0:	83 ec 08             	sub    $0x8,%esp
 9c3:	8b 06                	mov    (%esi),%eax
 9c5:	b9 01 00 00 00       	mov    $0x1,%ecx
 9ca:	ba 0a 00 00 00       	mov    $0xa,%edx
 9cf:	6a 20                	push   $0x20
 9d1:	6a 00                	push   $0x0
 9d3:	e9 50 ff ff ff       	jmp    928 <fprintf+0xb8>
 9d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 9df:	00 
        putc(fd, *ap);
 9e0:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
 9e2:	83 ec 04             	sub    $0x4,%esp
 9e5:	8d 7d e7             	lea    -0x19(%ebp),%edi
        putc(fd, *ap);
 9e8:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 9eb:	6a 01                	push   $0x1
 9ed:	57                   	push   %edi
 9ee:	ff 75 08             	push   0x8(%ebp)
 9f1:	e8 3d f9 ff ff       	call   333 <write>
 9f6:	e9 32 ff ff ff       	jmp    92d <fprintf+0xbd>
 9fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 a00:	83 ec 04             	sub    $0x4,%esp
 a03:	8d 45 e7             	lea    -0x19(%ebp),%eax
 a06:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 a09:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 a0c:	6a 01                	push   $0x1
 a0e:	50                   	push   %eax
 a0f:	ff 75 08             	push   0x8(%ebp)
 a12:	e8 1c f9 ff ff       	call   333 <write>
  for(i = 0; fmt[i]; i++){
 a17:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 a1b:	83 c4 10             	add    $0x10,%esp
 a1e:	84 d2                	test   %dl,%dl
 a20:	0f 85 6a fe ff ff    	jne    890 <fprintf+0x20>
}
 a26:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a29:	5b                   	pop    %ebx
 a2a:	5e                   	pop    %esi
 a2b:	5f                   	pop    %edi
 a2c:	5d                   	pop    %ebp
 a2d:	c3                   	ret
 a2e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 a30:	83 ec 04             	sub    $0x4,%esp
 a33:	88 55 e7             	mov    %dl,-0x19(%ebp)
 a36:	8d 7d e7             	lea    -0x19(%ebp),%edi
 a39:	6a 01                	push   $0x1
 a3b:	e9 b4 fe ff ff       	jmp    8f4 <fprintf+0x84>
          s = "(null)";
 a40:	bf ed 0b 00 00       	mov    $0xbed,%edi
 a45:	b8 28 00 00 00       	mov    $0x28,%eax
 a4a:	e9 fd fe ff ff       	jmp    94c <fprintf+0xdc>
 a4f:	66 90                	xchg   %ax,%ax
 a51:	66 90                	xchg   %ax,%ax
 a53:	66 90                	xchg   %ax,%ax
 a55:	66 90                	xchg   %ax,%ax
 a57:	66 90                	xchg   %ax,%ax
 a59:	66 90                	xchg   %ax,%ax
 a5b:	66 90                	xchg   %ax,%ax
 a5d:	66 90                	xchg   %ax,%ax
 a5f:	90                   	nop

00000a60 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a60:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a61:	a1 c4 0f 00 00       	mov    0xfc4,%eax
{
 a66:	89 e5                	mov    %esp,%ebp
 a68:	57                   	push   %edi
 a69:	56                   	push   %esi
 a6a:	53                   	push   %ebx
 a6b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 a6e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a71:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a78:	00 
 a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a80:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a82:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a84:	39 ca                	cmp    %ecx,%edx
 a86:	73 30                	jae    ab8 <free+0x58>
 a88:	39 c1                	cmp    %eax,%ecx
 a8a:	72 04                	jb     a90 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a8c:	39 c2                	cmp    %eax,%edx
 a8e:	72 f0                	jb     a80 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a90:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a93:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a96:	39 f8                	cmp    %edi,%eax
 a98:	74 36                	je     ad0 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 a9a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 a9d:	8b 42 04             	mov    0x4(%edx),%eax
 aa0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 aa3:	39 f1                	cmp    %esi,%ecx
 aa5:	74 40                	je     ae7 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 aa7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 aa9:	5b                   	pop    %ebx
  freep = p;
 aaa:	89 15 c4 0f 00 00    	mov    %edx,0xfc4
}
 ab0:	5e                   	pop    %esi
 ab1:	5f                   	pop    %edi
 ab2:	5d                   	pop    %ebp
 ab3:	c3                   	ret
 ab4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ab8:	39 c2                	cmp    %eax,%edx
 aba:	72 c4                	jb     a80 <free+0x20>
 abc:	39 c1                	cmp    %eax,%ecx
 abe:	73 c0                	jae    a80 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 ac0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 ac3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 ac6:	39 f8                	cmp    %edi,%eax
 ac8:	75 d0                	jne    a9a <free+0x3a>
 aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 ad0:	03 70 04             	add    0x4(%eax),%esi
 ad3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 ad6:	8b 02                	mov    (%edx),%eax
 ad8:	8b 00                	mov    (%eax),%eax
 ada:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 add:	8b 42 04             	mov    0x4(%edx),%eax
 ae0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 ae3:	39 f1                	cmp    %esi,%ecx
 ae5:	75 c0                	jne    aa7 <free+0x47>
    p->s.size += bp->s.size;
 ae7:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 aea:	89 15 c4 0f 00 00    	mov    %edx,0xfc4
    p->s.size += bp->s.size;
 af0:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 af3:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 af6:	89 0a                	mov    %ecx,(%edx)
}
 af8:	5b                   	pop    %ebx
 af9:	5e                   	pop    %esi
 afa:	5f                   	pop    %edi
 afb:	5d                   	pop    %ebp
 afc:	c3                   	ret
 afd:	8d 76 00             	lea    0x0(%esi),%esi

00000b00 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b00:	55                   	push   %ebp
 b01:	89 e5                	mov    %esp,%ebp
 b03:	57                   	push   %edi
 b04:	56                   	push   %esi
 b05:	53                   	push   %ebx
 b06:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b09:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 b0c:	8b 15 c4 0f 00 00    	mov    0xfc4,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b12:	8d 78 07             	lea    0x7(%eax),%edi
 b15:	c1 ef 03             	shr    $0x3,%edi
 b18:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 b1b:	85 d2                	test   %edx,%edx
 b1d:	0f 84 8d 00 00 00    	je     bb0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b23:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 b25:	8b 48 04             	mov    0x4(%eax),%ecx
 b28:	39 f9                	cmp    %edi,%ecx
 b2a:	73 64                	jae    b90 <malloc+0x90>
  if(nu < 4096)
 b2c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 b31:	39 df                	cmp    %ebx,%edi
 b33:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 b36:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 b3d:	eb 0a                	jmp    b49 <malloc+0x49>
 b3f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b40:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 b42:	8b 48 04             	mov    0x4(%eax),%ecx
 b45:	39 f9                	cmp    %edi,%ecx
 b47:	73 47                	jae    b90 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b49:	89 c2                	mov    %eax,%edx
 b4b:	39 05 c4 0f 00 00    	cmp    %eax,0xfc4
 b51:	75 ed                	jne    b40 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 b53:	83 ec 0c             	sub    $0xc,%esp
 b56:	56                   	push   %esi
 b57:	e8 3f f8 ff ff       	call   39b <sbrk>
  if(p == (char*)-1)
 b5c:	83 c4 10             	add    $0x10,%esp
 b5f:	83 f8 ff             	cmp    $0xffffffff,%eax
 b62:	74 1c                	je     b80 <malloc+0x80>
  hp->s.size = nu;
 b64:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 b67:	83 ec 0c             	sub    $0xc,%esp
 b6a:	83 c0 08             	add    $0x8,%eax
 b6d:	50                   	push   %eax
 b6e:	e8 ed fe ff ff       	call   a60 <free>
  return freep;
 b73:	8b 15 c4 0f 00 00    	mov    0xfc4,%edx
      if((p = morecore(nunits)) == 0)
 b79:	83 c4 10             	add    $0x10,%esp
 b7c:	85 d2                	test   %edx,%edx
 b7e:	75 c0                	jne    b40 <malloc+0x40>
        return 0;
  }
}
 b80:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 b83:	31 c0                	xor    %eax,%eax
}
 b85:	5b                   	pop    %ebx
 b86:	5e                   	pop    %esi
 b87:	5f                   	pop    %edi
 b88:	5d                   	pop    %ebp
 b89:	c3                   	ret
 b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 b90:	39 cf                	cmp    %ecx,%edi
 b92:	74 4c                	je     be0 <malloc+0xe0>
        p->s.size -= nunits;
 b94:	29 f9                	sub    %edi,%ecx
 b96:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 b99:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 b9c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 b9f:	89 15 c4 0f 00 00    	mov    %edx,0xfc4
}
 ba5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 ba8:	83 c0 08             	add    $0x8,%eax
}
 bab:	5b                   	pop    %ebx
 bac:	5e                   	pop    %esi
 bad:	5f                   	pop    %edi
 bae:	5d                   	pop    %ebp
 baf:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 bb0:	c7 05 c4 0f 00 00 c8 	movl   $0xfc8,0xfc4
 bb7:	0f 00 00 
    base.s.size = 0;
 bba:	b8 c8 0f 00 00       	mov    $0xfc8,%eax
    base.s.ptr = freep = prevp = &base;
 bbf:	c7 05 c8 0f 00 00 c8 	movl   $0xfc8,0xfc8
 bc6:	0f 00 00 
    base.s.size = 0;
 bc9:	c7 05 cc 0f 00 00 00 	movl   $0x0,0xfcc
 bd0:	00 00 00 
    if(p->s.size >= nunits){
 bd3:	e9 54 ff ff ff       	jmp    b2c <malloc+0x2c>
 bd8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 bdf:	00 
        prevp->s.ptr = p->s.ptr;
 be0:	8b 08                	mov    (%eax),%ecx
 be2:	89 0a                	mov    %ecx,(%edx)
 be4:	eb b9                	jmp    b9f <malloc+0x9f>
