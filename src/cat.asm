
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

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
   f:	be 01 00 00 00       	mov    $0x1,%esi
  14:	53                   	push   %ebx
  15:	51                   	push   %ecx
  16:	83 ec 18             	sub    $0x18,%esp
  19:	8b 01                	mov    (%ecx),%eax
  1b:	8b 59 04             	mov    0x4(%ecx),%ebx
  1e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  21:	83 c3 04             	add    $0x4,%ebx
  int fd, i;

  if(argc <= 1){
  24:	83 f8 01             	cmp    $0x1,%eax
  27:	7e 5f                	jle    88 <main+0x88>
  29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  30:	83 ec 08             	sub    $0x8,%esp
  33:	6a 00                	push   $0x0
  35:	ff 33                	push   (%ebx)
  37:	e8 77 03 00 00       	call   3b3 <open>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	89 c7                	mov    %eax,%edi
  41:	85 c0                	test   %eax,%eax
  43:	78 30                	js     75 <main+0x75>
      printf("cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  45:	83 ec 0c             	sub    $0xc,%esp
  for(i = 1; i < argc; i++){
  48:	83 c6 01             	add    $0x1,%esi
  4b:	83 c3 04             	add    $0x4,%ebx
    cat(fd);
  4e:	50                   	push   %eax
  4f:	e8 4c 00 00 00       	call   a0 <cat>
    printf("\n");
  54:	c7 04 24 69 0c 00 00 	movl   $0xc69,(%esp)
  5b:	e8 90 05 00 00       	call   5f0 <printf>
    close(fd);
  60:	89 3c 24             	mov    %edi,(%esp)
  63:	e8 33 03 00 00       	call   39b <close>
  for(i = 1; i < argc; i++){
  68:	83 c4 10             	add    $0x10,%esp
  6b:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  6e:	75 c0                	jne    30 <main+0x30>
  }
  exit();
  70:	e8 fe 02 00 00       	call   373 <exit>
      printf("cat: cannot open %s\n", argv[i]);
  75:	50                   	push   %eax
  76:	50                   	push   %eax
  77:	ff 33                	push   (%ebx)
  79:	68 6b 0c 00 00       	push   $0xc6b
  7e:	e8 6d 05 00 00       	call   5f0 <printf>
      exit();
  83:	e8 eb 02 00 00       	call   373 <exit>
    cat(0);
  88:	83 ec 0c             	sub    $0xc,%esp
  8b:	6a 00                	push   $0x0
  8d:	e8 0e 00 00 00       	call   a0 <cat>
    exit();
  92:	e8 dc 02 00 00       	call   373 <exit>
  97:	66 90                	xchg   %ax,%ax
  99:	66 90                	xchg   %ax,%ax
  9b:	66 90                	xchg   %ax,%ax
  9d:	66 90                	xchg   %ax,%ax
  9f:	90                   	nop

000000a0 <cat>:
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	56                   	push   %esi
  a4:	53                   	push   %ebx
  a5:	8b 75 08             	mov    0x8(%ebp),%esi
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  a8:	eb 1d                	jmp    c7 <cat+0x27>
  aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (write(1, buf, n) != n) {
  b0:	83 ec 04             	sub    $0x4,%esp
  b3:	53                   	push   %ebx
  b4:	68 a0 10 00 00       	push   $0x10a0
  b9:	6a 01                	push   $0x1
  bb:	e8 d3 02 00 00       	call   393 <write>
  c0:	83 c4 10             	add    $0x10,%esp
  c3:	39 d8                	cmp    %ebx,%eax
  c5:	75 25                	jne    ec <cat+0x4c>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  c7:	83 ec 04             	sub    $0x4,%esp
  ca:	68 00 02 00 00       	push   $0x200
  cf:	68 a0 10 00 00       	push   $0x10a0
  d4:	56                   	push   %esi
  d5:	e8 b1 02 00 00       	call   38b <read>
  da:	83 c4 10             	add    $0x10,%esp
  dd:	89 c3                	mov    %eax,%ebx
  df:	85 c0                	test   %eax,%eax
  e1:	7f cd                	jg     b0 <cat+0x10>
  if(n < 0){
  e3:	75 19                	jne    fe <cat+0x5e>
}
  e5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  e8:	5b                   	pop    %ebx
  e9:	5e                   	pop    %esi
  ea:	5d                   	pop    %ebp
  eb:	c3                   	ret
      printf("cat: write error\n");
  ec:	83 ec 0c             	sub    $0xc,%esp
  ef:	68 48 0c 00 00       	push   $0xc48
  f4:	e8 f7 04 00 00       	call   5f0 <printf>
      exit();
  f9:	e8 75 02 00 00       	call   373 <exit>
    printf("cat: read error\n");
  fe:	83 ec 0c             	sub    $0xc,%esp
 101:	68 5a 0c 00 00       	push   $0xc5a
 106:	e8 e5 04 00 00       	call   5f0 <printf>
    exit();
 10b:	e8 63 02 00 00       	call   373 <exit>
 110:	66 90                	xchg   %ax,%ax
 112:	66 90                	xchg   %ax,%ax
 114:	66 90                	xchg   %ax,%ax
 116:	66 90                	xchg   %ax,%ax
 118:	66 90                	xchg   %ax,%ax
 11a:	66 90                	xchg   %ax,%ax
 11c:	66 90                	xchg   %ax,%ax
 11e:	66 90                	xchg   %ax,%ax

00000120 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 120:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 121:	31 c0                	xor    %eax,%eax
{
 123:	89 e5                	mov    %esp,%ebp
 125:	53                   	push   %ebx
 126:	8b 4d 08             	mov    0x8(%ebp),%ecx
 129:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 12c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 130:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 134:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 137:	83 c0 01             	add    $0x1,%eax
 13a:	84 d2                	test   %dl,%dl
 13c:	75 f2                	jne    130 <strcpy+0x10>
    ;
  return os;
}
 13e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 141:	89 c8                	mov    %ecx,%eax
 143:	c9                   	leave
 144:	c3                   	ret
 145:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 14c:	00 
 14d:	8d 76 00             	lea    0x0(%esi),%esi

00000150 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	53                   	push   %ebx
 154:	8b 55 08             	mov    0x8(%ebp),%edx
 157:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 15a:	0f b6 02             	movzbl (%edx),%eax
 15d:	84 c0                	test   %al,%al
 15f:	75 2f                	jne    190 <strcmp+0x40>
 161:	eb 4a                	jmp    1ad <strcmp+0x5d>
 163:	eb 1b                	jmp    180 <strcmp+0x30>
 165:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 16c:	00 
 16d:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 174:	00 
 175:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 17c:	00 
 17d:	8d 76 00             	lea    0x0(%esi),%esi
 180:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 184:	83 c2 01             	add    $0x1,%edx
 187:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 18a:	84 c0                	test   %al,%al
 18c:	74 12                	je     1a0 <strcmp+0x50>
 18e:	89 d9                	mov    %ebx,%ecx
 190:	0f b6 19             	movzbl (%ecx),%ebx
 193:	38 c3                	cmp    %al,%bl
 195:	74 e9                	je     180 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 197:	29 d8                	sub    %ebx,%eax
}
 199:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 19c:	c9                   	leave
 19d:	c3                   	ret
 19e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 1a0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 1a4:	31 c0                	xor    %eax,%eax
 1a6:	29 d8                	sub    %ebx,%eax
}
 1a8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1ab:	c9                   	leave
 1ac:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 1ad:	0f b6 19             	movzbl (%ecx),%ebx
 1b0:	31 c0                	xor    %eax,%eax
 1b2:	eb e3                	jmp    197 <strcmp+0x47>
 1b4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1bb:	00 
 1bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001c0 <strlen>:

uint
strlen(char *s)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1c6:	80 3a 00             	cmpb   $0x0,(%edx)
 1c9:	74 15                	je     1e0 <strlen+0x20>
 1cb:	31 c0                	xor    %eax,%eax
 1cd:	8d 76 00             	lea    0x0(%esi),%esi
 1d0:	83 c0 01             	add    $0x1,%eax
 1d3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1d7:	89 c1                	mov    %eax,%ecx
 1d9:	75 f5                	jne    1d0 <strlen+0x10>
    ;
  return n;
}
 1db:	89 c8                	mov    %ecx,%eax
 1dd:	5d                   	pop    %ebp
 1de:	c3                   	ret
 1df:	90                   	nop
  for(n = 0; s[n]; n++)
 1e0:	31 c9                	xor    %ecx,%ecx
}
 1e2:	5d                   	pop    %ebp
 1e3:	89 c8                	mov    %ecx,%eax
 1e5:	c3                   	ret
 1e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ed:	00 
 1ee:	66 90                	xchg   %ax,%ax

000001f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	57                   	push   %edi
 1f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1fd:	89 d7                	mov    %edx,%edi
 1ff:	fc                   	cld
 200:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 202:	8b 7d fc             	mov    -0x4(%ebp),%edi
 205:	89 d0                	mov    %edx,%eax
 207:	c9                   	leave
 208:	c3                   	ret
 209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000210 <strchr>:

char*
strchr(const char *s, char c)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	8b 45 08             	mov    0x8(%ebp),%eax
 216:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 21a:	0f b6 10             	movzbl (%eax),%edx
 21d:	84 d2                	test   %dl,%dl
 21f:	75 1a                	jne    23b <strchr+0x2b>
 221:	eb 25                	jmp    248 <strchr+0x38>
 223:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 22a:	00 
 22b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 230:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 234:	83 c0 01             	add    $0x1,%eax
 237:	84 d2                	test   %dl,%dl
 239:	74 0d                	je     248 <strchr+0x38>
    if(*s == c)
 23b:	38 d1                	cmp    %dl,%cl
 23d:	75 f1                	jne    230 <strchr+0x20>
      return (char*)s;
  return 0;
}
 23f:	5d                   	pop    %ebp
 240:	c3                   	ret
 241:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 248:	31 c0                	xor    %eax,%eax
}
 24a:	5d                   	pop    %ebp
 24b:	c3                   	ret
 24c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000250 <gets>:

char*
gets(char *buf, int max)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	57                   	push   %edi
 254:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 255:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 258:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 259:	31 db                	xor    %ebx,%ebx
{
 25b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 25e:	eb 27                	jmp    287 <gets+0x37>
    cc = read(0, &c, 1);
 260:	83 ec 04             	sub    $0x4,%esp
 263:	6a 01                	push   $0x1
 265:	56                   	push   %esi
 266:	6a 00                	push   $0x0
 268:	e8 1e 01 00 00       	call   38b <read>
    if(cc < 1)
 26d:	83 c4 10             	add    $0x10,%esp
 270:	85 c0                	test   %eax,%eax
 272:	7e 1d                	jle    291 <gets+0x41>
      break;
    buf[i++] = c;
 274:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 278:	8b 55 08             	mov    0x8(%ebp),%edx
 27b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 27f:	3c 0a                	cmp    $0xa,%al
 281:	74 10                	je     293 <gets+0x43>
 283:	3c 0d                	cmp    $0xd,%al
 285:	74 0c                	je     293 <gets+0x43>
  for(i=0; i+1 < max; ){
 287:	89 df                	mov    %ebx,%edi
 289:	83 c3 01             	add    $0x1,%ebx
 28c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 28f:	7c cf                	jl     260 <gets+0x10>
 291:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 293:	8b 45 08             	mov    0x8(%ebp),%eax
 296:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 29a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 29d:	5b                   	pop    %ebx
 29e:	5e                   	pop    %esi
 29f:	5f                   	pop    %edi
 2a0:	5d                   	pop    %ebp
 2a1:	c3                   	ret
 2a2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2a9:	00 
 2aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002b0 <stat>:

int
stat(char *n, struct stat *st)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	56                   	push   %esi
 2b4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b5:	83 ec 08             	sub    $0x8,%esp
 2b8:	6a 00                	push   $0x0
 2ba:	ff 75 08             	push   0x8(%ebp)
 2bd:	e8 f1 00 00 00       	call   3b3 <open>
  if(fd < 0)
 2c2:	83 c4 10             	add    $0x10,%esp
 2c5:	85 c0                	test   %eax,%eax
 2c7:	78 27                	js     2f0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2c9:	83 ec 08             	sub    $0x8,%esp
 2cc:	ff 75 0c             	push   0xc(%ebp)
 2cf:	89 c3                	mov    %eax,%ebx
 2d1:	50                   	push   %eax
 2d2:	e8 f4 00 00 00       	call   3cb <fstat>
  close(fd);
 2d7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2da:	89 c6                	mov    %eax,%esi
  close(fd);
 2dc:	e8 ba 00 00 00       	call   39b <close>
  return r;
 2e1:	83 c4 10             	add    $0x10,%esp
}
 2e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2e7:	89 f0                	mov    %esi,%eax
 2e9:	5b                   	pop    %ebx
 2ea:	5e                   	pop    %esi
 2eb:	5d                   	pop    %ebp
 2ec:	c3                   	ret
 2ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2f5:	eb ed                	jmp    2e4 <stat+0x34>
 2f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2fe:	00 
 2ff:	90                   	nop

00000300 <atoi>:

int
atoi(const char *s)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	53                   	push   %ebx
 304:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 307:	0f be 02             	movsbl (%edx),%eax
 30a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 30d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 310:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 315:	77 1e                	ja     335 <atoi+0x35>
 317:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 31e:	00 
 31f:	90                   	nop
    n = n*10 + *s++ - '0';
 320:	83 c2 01             	add    $0x1,%edx
 323:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 326:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 32a:	0f be 02             	movsbl (%edx),%eax
 32d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 330:	80 fb 09             	cmp    $0x9,%bl
 333:	76 eb                	jbe    320 <atoi+0x20>
  return n;
}
 335:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 338:	89 c8                	mov    %ecx,%eax
 33a:	c9                   	leave
 33b:	c3                   	ret
 33c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000340 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	8b 45 10             	mov    0x10(%ebp),%eax
 347:	8b 55 08             	mov    0x8(%ebp),%edx
 34a:	56                   	push   %esi
 34b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 34e:	85 c0                	test   %eax,%eax
 350:	7e 13                	jle    365 <memmove+0x25>
 352:	01 d0                	add    %edx,%eax
  dst = vdst;
 354:	89 d7                	mov    %edx,%edi
 356:	66 90                	xchg   %ax,%ax
 358:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 35f:	00 
    *dst++ = *src++;
 360:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 361:	39 f8                	cmp    %edi,%eax
 363:	75 fb                	jne    360 <memmove+0x20>
  return vdst;
}
 365:	5e                   	pop    %esi
 366:	89 d0                	mov    %edx,%eax
 368:	5f                   	pop    %edi
 369:	5d                   	pop    %ebp
 36a:	c3                   	ret

0000036b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 36b:	b8 01 00 00 00       	mov    $0x1,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <exit>:
SYSCALL(exit)
 373:	b8 02 00 00 00       	mov    $0x2,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <wait>:
SYSCALL(wait)
 37b:	b8 03 00 00 00       	mov    $0x3,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

00000383 <pipe>:
SYSCALL(pipe)
 383:	b8 04 00 00 00       	mov    $0x4,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

0000038b <read>:
SYSCALL(read)
 38b:	b8 05 00 00 00       	mov    $0x5,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <write>:
SYSCALL(write)
 393:	b8 10 00 00 00       	mov    $0x10,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <close>:
SYSCALL(close)
 39b:	b8 15 00 00 00       	mov    $0x15,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <kill>:
SYSCALL(kill)
 3a3:	b8 06 00 00 00       	mov    $0x6,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <exec>:
SYSCALL(exec)
 3ab:	b8 07 00 00 00       	mov    $0x7,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <open>:
SYSCALL(open)
 3b3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

000003bb <mknod>:
SYSCALL(mknod)
 3bb:	b8 11 00 00 00       	mov    $0x11,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <unlink>:
SYSCALL(unlink)
 3c3:	b8 12 00 00 00       	mov    $0x12,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

000003cb <fstat>:
SYSCALL(fstat)
 3cb:	b8 08 00 00 00       	mov    $0x8,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <link>:
SYSCALL(link)
 3d3:	b8 13 00 00 00       	mov    $0x13,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <mkdir>:
SYSCALL(mkdir)
 3db:	b8 14 00 00 00       	mov    $0x14,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

000003e3 <chdir>:
SYSCALL(chdir)
 3e3:	b8 09 00 00 00       	mov    $0x9,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

000003eb <dup>:
SYSCALL(dup)
 3eb:	b8 0a 00 00 00       	mov    $0xa,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <getpid>:
SYSCALL(getpid)
 3f3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <sbrk>:
SYSCALL(sbrk)
 3fb:	b8 0c 00 00 00       	mov    $0xc,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <sleep>:
SYSCALL(sleep)
 403:	b8 0d 00 00 00       	mov    $0xd,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

0000040b <uptime>:
SYSCALL(uptime)
 40b:	b8 0e 00 00 00       	mov    $0xe,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret

00000413 <bstat>:
SYSCALL(bstat)
 413:	b8 16 00 00 00       	mov    $0x16,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

0000041b <swap>:
SYSCALL(swap)
 41b:	b8 17 00 00 00       	mov    $0x17,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

00000423 <gettime>:
SYSCALL(gettime)
 423:	b8 18 00 00 00       	mov    $0x18,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

0000042b <setcursor>:
SYSCALL(setcursor)
 42b:	b8 19 00 00 00       	mov    $0x19,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

00000433 <uname>:
SYSCALL(uname)
 433:	b8 1a 00 00 00       	mov    $0x1a,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret

0000043b <echo>:
SYSCALL(echo)
 43b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret
 443:	66 90                	xchg   %ax,%ax
 445:	66 90                	xchg   %ax,%ax
 447:	66 90                	xchg   %ax,%ax
 449:	66 90                	xchg   %ax,%ax
 44b:	66 90                	xchg   %ax,%ax
 44d:	66 90                	xchg   %ax,%ax
 44f:	66 90                	xchg   %ax,%ax
 451:	66 90                	xchg   %ax,%ax
 453:	66 90                	xchg   %ax,%ax
 455:	66 90                	xchg   %ax,%ax
 457:	66 90                	xchg   %ax,%ax
 459:	66 90                	xchg   %ax,%ax
 45b:	66 90                	xchg   %ax,%ax
 45d:	66 90                	xchg   %ax,%ax
 45f:	90                   	nop

00000460 <printint.constprop.0>:
{
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn, int width, char pad_char)
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	56                   	push   %esi
 465:	89 c6                	mov    %eax,%esi
 467:	53                   	push   %ebx
 468:	89 d3                	mov    %edx,%ebx
 46a:	83 ec 3c             	sub    $0x3c,%esp
 46d:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 471:	85 f6                	test   %esi,%esi
 473:	0f 89 d7 00 00 00    	jns    550 <printint.constprop.0+0xf0>
 479:	83 e1 01             	and    $0x1,%ecx
 47c:	0f 84 ce 00 00 00    	je     550 <printint.constprop.0+0xf0>
    neg = 1;
 482:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 489:	f7 de                	neg    %esi
 48b:	89 f1                	mov    %esi,%ecx
  } else {
    x = xx;
  }

  i = 0;
 48d:	88 45 bf             	mov    %al,-0x41(%ebp)
 490:	31 ff                	xor    %edi,%edi
 492:	8d 75 d7             	lea    -0x29(%ebp),%esi
 495:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 49c:	00 
 49d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4a0:	89 c8                	mov    %ecx,%eax
 4a2:	31 d2                	xor    %edx,%edx
 4a4:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 4a7:	83 c7 01             	add    $0x1,%edi
 4aa:	f7 f3                	div    %ebx
 4ac:	0f b6 92 38 0d 00 00 	movzbl 0xd38(%edx),%edx
 4b3:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 4b6:	89 ca                	mov    %ecx,%edx
 4b8:	89 c1                	mov    %eax,%ecx
 4ba:	39 da                	cmp    %ebx,%edx
 4bc:	73 e2                	jae    4a0 <printint.constprop.0+0x40>

  if(neg)
 4be:	8b 55 c0             	mov    -0x40(%ebp),%edx
 4c1:	0f b6 45 bf          	movzbl -0x41(%ebp),%eax
 4c5:	85 d2                	test   %edx,%edx
 4c7:	74 0b                	je     4d4 <printint.constprop.0+0x74>
    buf[i++] = '-';
 4c9:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
 4cc:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 4d1:	8d 79 02             	lea    0x2(%ecx),%edi

  // Pad with pad_char until we hit the required width
  while(i < width)
 4d4:	39 7d 08             	cmp    %edi,0x8(%ebp)
 4d7:	0f 8e 83 00 00 00    	jle    560 <printint.constprop.0+0x100>
 4dd:	8b 55 08             	mov    0x8(%ebp),%edx
 4e0:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 4e3:	01 df                	add    %ebx,%edi
 4e5:	01 da                	add    %ebx,%edx
 4e7:	89 d1                	mov    %edx,%ecx
 4e9:	29 f9                	sub    %edi,%ecx
 4eb:	83 e1 01             	and    $0x1,%ecx
 4ee:	74 10                	je     500 <printint.constprop.0+0xa0>
    buf[i++] = pad_char;
 4f0:	88 07                	mov    %al,(%edi)
  while(i < width)
 4f2:	83 c7 01             	add    $0x1,%edi
 4f5:	39 d7                	cmp    %edx,%edi
 4f7:	74 13                	je     50c <printint.constprop.0+0xac>
 4f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = pad_char;
 500:	88 07                	mov    %al,(%edi)
  while(i < width)
 502:	83 c7 02             	add    $0x2,%edi
    buf[i++] = pad_char;
 505:	88 47 ff             	mov    %al,-0x1(%edi)
  while(i < width)
 508:	39 d7                	cmp    %edx,%edi
 50a:	75 f4                	jne    500 <printint.constprop.0+0xa0>
 50c:	8b 45 08             	mov    0x8(%ebp),%eax
 50f:	8d 78 ff             	lea    -0x1(%eax),%edi

  while(--i >= 0)
 512:	01 df                	add    %ebx,%edi
 514:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 51b:	00 
 51c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 520:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 523:	83 ec 04             	sub    $0x4,%esp
 526:	88 45 d7             	mov    %al,-0x29(%ebp)
 529:	6a 01                	push   $0x1
 52b:	56                   	push   %esi
 52c:	6a 01                	push   $0x1
 52e:	e8 60 fe ff ff       	call   393 <write>
  while(--i >= 0)
 533:	89 f8                	mov    %edi,%eax
 535:	83 c4 10             	add    $0x10,%esp
 538:	83 ef 01             	sub    $0x1,%edi
 53b:	39 d8                	cmp    %ebx,%eax
 53d:	75 e1                	jne    520 <printint.constprop.0+0xc0>
}
 53f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 542:	5b                   	pop    %ebx
 543:	5e                   	pop    %esi
 544:	5f                   	pop    %edi
 545:	5d                   	pop    %ebp
 546:	c3                   	ret
 547:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 54e:	00 
 54f:	90                   	nop
  neg = 0;
 550:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = xx;
 557:	89 f1                	mov    %esi,%ecx
 559:	e9 2f ff ff ff       	jmp    48d <printint.constprop.0+0x2d>
 55e:	66 90                	xchg   %ax,%ax
  while(--i >= 0)
 560:	83 ef 01             	sub    $0x1,%edi
 563:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 566:	eb aa                	jmp    512 <printint.constprop.0+0xb2>
 568:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 56f:	00 

00000570 <strncpy>:
{
 570:	55                   	push   %ebp
 571:	31 c0                	xor    %eax,%eax
 573:	89 e5                	mov    %esp,%ebp
 575:	56                   	push   %esi
 576:	8b 4d 08             	mov    0x8(%ebp),%ecx
 579:	8b 75 0c             	mov    0xc(%ebp),%esi
 57c:	53                   	push   %ebx
 57d:	8b 5d 10             	mov    0x10(%ebp),%ebx
  for (i = 0; i < n && src[i]; i++)
 580:	85 db                	test   %ebx,%ebx
 582:	7f 26                	jg     5aa <strncpy+0x3a>
 584:	eb 58                	jmp    5de <strncpy+0x6e>
 586:	eb 18                	jmp    5a0 <strncpy+0x30>
 588:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 58f:	00 
 590:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 597:	00 
 598:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 59f:	00 
    dest[i] = src[i];
 5a0:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  for (i = 0; i < n && src[i]; i++)
 5a3:	83 c0 01             	add    $0x1,%eax
 5a6:	39 c3                	cmp    %eax,%ebx
 5a8:	74 34                	je     5de <strncpy+0x6e>
 5aa:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
 5ae:	84 d2                	test   %dl,%dl
 5b0:	75 ee                	jne    5a0 <strncpy+0x30>
  for (; i < n; i++)
 5b2:	39 c3                	cmp    %eax,%ebx
 5b4:	7e 28                	jle    5de <strncpy+0x6e>
 5b6:	01 c8                	add    %ecx,%eax
 5b8:	01 d9                	add    %ebx,%ecx
 5ba:	89 ca                	mov    %ecx,%edx
 5bc:	29 c2                	sub    %eax,%edx
 5be:	83 e2 01             	and    $0x1,%edx
 5c1:	74 0d                	je     5d0 <strncpy+0x60>
    dest[i] = '\0';
 5c3:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
 5c6:	83 c0 01             	add    $0x1,%eax
 5c9:	39 c8                	cmp    %ecx,%eax
 5cb:	74 11                	je     5de <strncpy+0x6e>
 5cd:	8d 76 00             	lea    0x0(%esi),%esi
    dest[i] = '\0';
 5d0:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
 5d3:	83 c0 02             	add    $0x2,%eax
    dest[i] = '\0';
 5d6:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  for (; i < n; i++)
 5da:	39 c8                	cmp    %ecx,%eax
 5dc:	75 f2                	jne    5d0 <strncpy+0x60>
}
 5de:	5b                   	pop    %ebx
 5df:	5e                   	pop    %esi
 5e0:	5d                   	pop    %ebp
 5e1:	c3                   	ret
 5e2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5e9:	00 
 5ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000005f0 <printf>:

void
printf(char *fmt, ...)
{
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	57                   	push   %edi
 5f4:	56                   	push   %esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 5f5:	8d 75 0c             	lea    0xc(%ebp),%esi
{
 5f8:	53                   	push   %ebx
 5f9:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  for(i = 0; fmt[i]; i++){
 5fc:	8b 55 08             	mov    0x8(%ebp),%edx
  ap = (uint*)(void*)&fmt + 1;
 5ff:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 602:	0f b6 02             	movzbl (%edx),%eax
 605:	84 c0                	test   %al,%al
 607:	0f 84 88 00 00 00    	je     695 <printf+0xa5>
 60d:	8d 7a 01             	lea    0x1(%edx),%edi
    c = fmt[i] & 0xff;
 610:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
      if (c == '\f') {
 613:	83 fa 0c             	cmp    $0xc,%edx
 616:	0f 84 d4 01 00 00    	je     7f0 <printf+0x200>
        setcursor();
      } else if(c == '%'){
 61c:	83 fa 25             	cmp    $0x25,%edx
 61f:	0f 85 0b 02 00 00    	jne    830 <printf+0x240>
  for(i = 0; fmt[i]; i++){
 625:	0f b6 1f             	movzbl (%edi),%ebx
 628:	83 c7 01             	add    $0x1,%edi
 62b:	84 db                	test   %bl,%bl
 62d:	74 66                	je     695 <printf+0xa5>
    c = fmt[i] & 0xff;
 62f:	0f b6 c3             	movzbl %bl,%eax
 632:	ba 20 00 00 00       	mov    $0x20,%edx
 637:	31 c9                	xor    %ecx,%ecx
        pad_char = ' ';
      } else {
        putc(1, c);
      }
    } else if(state == '%'){
      if(c == '0'){
 639:	83 f8 78             	cmp    $0x78,%eax
 63c:	7f 22                	jg     660 <printf+0x70>
 63e:	83 f8 62             	cmp    $0x62,%eax
 641:	0f 8e b9 01 00 00    	jle    800 <printf+0x210>
 647:	83 e8 63             	sub    $0x63,%eax
 64a:	83 f8 15             	cmp    $0x15,%eax
 64d:	77 11                	ja     660 <printf+0x70>
 64f:	ff 24 85 88 0c 00 00 	jmp    *0xc88(,%eax,4)
 656:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 65d:	00 
 65e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 660:	83 ec 04             	sub    $0x4,%esp
 663:	8d 75 e7             	lea    -0x19(%ebp),%esi
 666:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 66a:	6a 01                	push   $0x1
 66c:	56                   	push   %esi
 66d:	6a 01                	push   $0x1
 66f:	e8 1f fd ff ff       	call   393 <write>
 674:	83 c4 0c             	add    $0xc,%esp
 677:	88 5d e7             	mov    %bl,-0x19(%ebp)
 67a:	6a 01                	push   $0x1
 67c:	56                   	push   %esi
 67d:	6a 01                	push   $0x1
 67f:	e8 0f fd ff ff       	call   393 <write>
      } else if(c == '%'){
        putc(1, '%');
        state = 0;
      } else {
        putc(1, '%');
        putc(1, c);
 684:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 687:	0f b6 07             	movzbl (%edi),%eax
 68a:	83 c7 01             	add    $0x1,%edi
 68d:	84 c0                	test   %al,%al
 68f:	0f 85 7b ff ff ff    	jne    610 <printf+0x20>
        state = 0;
      }
    }
  }
}
 695:	8d 65 f4             	lea    -0xc(%ebp),%esp
 698:	5b                   	pop    %ebx
 699:	5e                   	pop    %esi
 69a:	5f                   	pop    %edi
 69b:	5d                   	pop    %ebp
 69c:	c3                   	ret
 69d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 16, 0, width, pad_char);
 6a0:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 6a3:	83 ec 08             	sub    $0x8,%esp
 6a6:	8b 06                	mov    (%esi),%eax
 6a8:	52                   	push   %edx
 6a9:	ba 10 00 00 00       	mov    $0x10,%edx
 6ae:	51                   	push   %ecx
 6af:	31 c9                	xor    %ecx,%ecx
        printint(1, *ap, 10, 1, width, pad_char);
 6b1:	e8 aa fd ff ff       	call   460 <printint.constprop.0>
        ap++;
 6b6:	83 c6 04             	add    $0x4,%esi
 6b9:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 6bc:	0f b6 07             	movzbl (%edi),%eax
 6bf:	83 c7 01             	add    $0x1,%edi
 6c2:	83 c4 10             	add    $0x10,%esp
 6c5:	84 c0                	test   %al,%al
 6c7:	0f 85 43 ff ff ff    	jne    610 <printf+0x20>
}
 6cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6d0:	5b                   	pop    %ebx
 6d1:	5e                   	pop    %esi
 6d2:	5f                   	pop    %edi
 6d3:	5d                   	pop    %ebp
 6d4:	c3                   	ret
 6d5:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 10, 1, width, pad_char);
 6d8:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 6db:	83 ec 08             	sub    $0x8,%esp
 6de:	8b 06                	mov    (%esi),%eax
 6e0:	52                   	push   %edx
 6e1:	ba 0a 00 00 00       	mov    $0xa,%edx
 6e6:	51                   	push   %ecx
 6e7:	b9 01 00 00 00       	mov    $0x1,%ecx
 6ec:	eb c3                	jmp    6b1 <printf+0xc1>
 6ee:	66 90                	xchg   %ax,%ax
        s = (char*)*ap;
 6f0:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 6f3:	8b 06                	mov    (%esi),%eax
        ap++;
 6f5:	83 c6 04             	add    $0x4,%esi
 6f8:	89 75 d4             	mov    %esi,-0x2c(%ebp)
        if(s == 0)
 6fb:	85 c0                	test   %eax,%eax
 6fd:	0f 85 9d 01 00 00    	jne    8a0 <printf+0x2b0>
 703:	c6 45 d0 28          	movb   $0x28,-0x30(%ebp)
          s = "(null)";
 707:	b8 80 0c 00 00       	mov    $0xc80,%eax
        int len = 0;
 70c:	31 db                	xor    %ebx,%ebx
 70e:	66 90                	xchg   %ax,%ax
        for (char *t = s; *t; t++) len++;
 710:	83 c3 01             	add    $0x1,%ebx
 713:	80 3c 18 00          	cmpb   $0x0,(%eax,%ebx,1)
 717:	75 f7                	jne    710 <printf+0x120>
        for (int j = len; j < width; j++)
 719:	39 cb                	cmp    %ecx,%ebx
 71b:	0f 8d 9c 01 00 00    	jge    8bd <printf+0x2cd>
 721:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 724:	8d 75 e7             	lea    -0x19(%ebp),%esi
 727:	89 45 c8             	mov    %eax,-0x38(%ebp)
 72a:	89 7d cc             	mov    %edi,-0x34(%ebp)
 72d:	89 df                	mov    %ebx,%edi
 72f:	89 d3                	mov    %edx,%ebx
 731:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 738:	00 
 739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 740:	83 ec 04             	sub    $0x4,%esp
 743:	88 5d e7             	mov    %bl,-0x19(%ebp)
        for (int j = len; j < width; j++)
 746:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 749:	6a 01                	push   $0x1
 74b:	56                   	push   %esi
 74c:	6a 01                	push   $0x1
 74e:	e8 40 fc ff ff       	call   393 <write>
        for (int j = len; j < width; j++)
 753:	8b 45 d0             	mov    -0x30(%ebp),%eax
 756:	83 c4 10             	add    $0x10,%esp
 759:	39 c7                	cmp    %eax,%edi
 75b:	7c e3                	jl     740 <printf+0x150>
        while(*s != 0){
 75d:	8b 45 c8             	mov    -0x38(%ebp),%eax
 760:	8b 7d cc             	mov    -0x34(%ebp),%edi
 763:	0f b6 08             	movzbl (%eax),%ecx
 766:	88 4d d0             	mov    %cl,-0x30(%ebp)
 769:	84 c9                	test   %cl,%cl
 76b:	0f 84 16 ff ff ff    	je     687 <printf+0x97>
 771:	89 c3                	mov    %eax,%ebx
 773:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 777:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 77e:	00 
 77f:	90                   	nop
  write(fd, &c, 1);
 780:	83 ec 04             	sub    $0x4,%esp
 783:	88 45 e7             	mov    %al,-0x19(%ebp)
          putc(1, *s++);
 786:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 789:	6a 01                	push   $0x1
 78b:	56                   	push   %esi
 78c:	6a 01                	push   $0x1
 78e:	e8 00 fc ff ff       	call   393 <write>
        while(*s != 0){
 793:	0f b6 03             	movzbl (%ebx),%eax
 796:	83 c4 10             	add    $0x10,%esp
 799:	84 c0                	test   %al,%al
 79b:	75 e3                	jne    780 <printf+0x190>
 79d:	e9 e5 fe ff ff       	jmp    687 <printf+0x97>
 7a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        char ch = *ap++;
 7a8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 7ab:	83 ec 04             	sub    $0x4,%esp
 7ae:	8d 75 e7             	lea    -0x19(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 7b1:	83 c7 01             	add    $0x1,%edi
        char ch = *ap++;
 7b4:	8d 58 04             	lea    0x4(%eax),%ebx
 7b7:	8b 00                	mov    (%eax),%eax
 7b9:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 7bc:	6a 01                	push   $0x1
 7be:	56                   	push   %esi
 7bf:	6a 01                	push   $0x1
 7c1:	e8 cd fb ff ff       	call   393 <write>
  for(i = 0; fmt[i]; i++){
 7c6:	0f b6 47 ff          	movzbl -0x1(%edi),%eax
 7ca:	83 c4 10             	add    $0x10,%esp
 7cd:	84 c0                	test   %al,%al
 7cf:	0f 84 c0 fe ff ff    	je     695 <printf+0xa5>
    c = fmt[i] & 0xff;
 7d5:	0f b6 d0             	movzbl %al,%edx
        char ch = *ap++;
 7d8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      if (c == '\f') {
 7db:	83 fa 0c             	cmp    $0xc,%edx
 7de:	0f 85 38 fe ff ff    	jne    61c <printf+0x2c>
 7e4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7eb:	00 
 7ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        setcursor();
 7f0:	e8 36 fc ff ff       	call   42b <setcursor>
 7f5:	e9 8d fe ff ff       	jmp    687 <printf+0x97>
 7fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 800:	83 f8 30             	cmp    $0x30,%eax
 803:	74 7b                	je     880 <printf+0x290>
 805:	7f 49                	jg     850 <printf+0x260>
 807:	83 f8 25             	cmp    $0x25,%eax
 80a:	0f 85 50 fe ff ff    	jne    660 <printf+0x70>
  write(fd, &c, 1);
 810:	83 ec 04             	sub    $0x4,%esp
 813:	8d 75 e7             	lea    -0x19(%ebp),%esi
 816:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 81a:	6a 01                	push   $0x1
 81c:	56                   	push   %esi
 81d:	6a 01                	push   $0x1
 81f:	e8 6f fb ff ff       	call   393 <write>
        state = 0;
 824:	83 c4 10             	add    $0x10,%esp
 827:	e9 5b fe ff ff       	jmp    687 <printf+0x97>
 82c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 830:	83 ec 04             	sub    $0x4,%esp
 833:	8d 75 e7             	lea    -0x19(%ebp),%esi
 836:	88 45 e7             	mov    %al,-0x19(%ebp)
 839:	6a 01                	push   $0x1
 83b:	56                   	push   %esi
 83c:	6a 01                	push   $0x1
 83e:	e8 50 fb ff ff       	call   393 <write>
  for(i = 0; fmt[i]; i++){
 843:	e9 74 fe ff ff       	jmp    6bc <printf+0xcc>
 848:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 84f:	00 
 850:	8d 70 cf             	lea    -0x31(%eax),%esi
 853:	83 fe 08             	cmp    $0x8,%esi
 856:	0f 87 04 fe ff ff    	ja     660 <printf+0x70>
 85c:	0f b6 1f             	movzbl (%edi),%ebx
        width = width * 10 + (c - '0');
 85f:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
  for(i = 0; fmt[i]; i++){
 862:	83 c7 01             	add    $0x1,%edi
        width = width * 10 + (c - '0');
 865:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  for(i = 0; fmt[i]; i++){
 869:	84 db                	test   %bl,%bl
 86b:	0f 84 24 fe ff ff    	je     695 <printf+0xa5>
    c = fmt[i] & 0xff;
 871:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 874:	e9 c0 fd ff ff       	jmp    639 <printf+0x49>
 879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 880:	0f b6 1f             	movzbl (%edi),%ebx
 883:	83 c7 01             	add    $0x1,%edi
 886:	84 db                	test   %bl,%bl
 888:	0f 84 07 fe ff ff    	je     695 <printf+0xa5>
    c = fmt[i] & 0xff;
 88e:	0f b6 c3             	movzbl %bl,%eax
 891:	ba 30 00 00 00       	mov    $0x30,%edx
 896:	e9 9e fd ff ff       	jmp    639 <printf+0x49>
 89b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        for (char *t = s; *t; t++) len++;
 8a0:	0f b6 18             	movzbl (%eax),%ebx
 8a3:	88 5d d0             	mov    %bl,-0x30(%ebp)
 8a6:	84 db                	test   %bl,%bl
 8a8:	0f 85 5e fe ff ff    	jne    70c <printf+0x11c>
        int len = 0;
 8ae:	31 db                	xor    %ebx,%ebx
        for (int j = len; j < width; j++)
 8b0:	85 c9                	test   %ecx,%ecx
 8b2:	0f 8f 69 fe ff ff    	jg     721 <printf+0x131>
 8b8:	e9 ca fd ff ff       	jmp    687 <printf+0x97>
 8bd:	89 c2                	mov    %eax,%edx
 8bf:	8d 75 e7             	lea    -0x19(%ebp),%esi
 8c2:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 8c6:	89 d3                	mov    %edx,%ebx
 8c8:	e9 b3 fe ff ff       	jmp    780 <printf+0x190>
 8cd:	8d 76 00             	lea    0x0(%esi),%esi

000008d0 <fprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
fprintf(int fd, char *fmt, ...)
{
 8d0:	55                   	push   %ebp
 8d1:	89 e5                	mov    %esp,%ebp
 8d3:	57                   	push   %edi
 8d4:	56                   	push   %esi
 8d5:	53                   	push   %ebx
 8d6:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8d9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 8dc:	0f b6 13             	movzbl (%ebx),%edx
 8df:	83 c3 01             	add    $0x1,%ebx
 8e2:	84 d2                	test   %dl,%dl
 8e4:	0f 84 81 00 00 00    	je     96b <fprintf+0x9b>
 8ea:	8d 75 10             	lea    0x10(%ebp),%esi
 8ed:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 8f0:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if (c == '\f') { // Detect formfeed character
 8f3:	83 f8 0c             	cmp    $0xc,%eax
 8f6:	0f 84 04 01 00 00    	je     a00 <fprintf+0x130>
        setcursor();
      } else
      if(c == '%'){
 8fc:	83 f8 25             	cmp    $0x25,%eax
 8ff:	0f 85 5b 01 00 00    	jne    a60 <fprintf+0x190>
  for(i = 0; fmt[i]; i++){
 905:	0f b6 13             	movzbl (%ebx),%edx
 908:	84 d2                	test   %dl,%dl
 90a:	74 5f                	je     96b <fprintf+0x9b>
    c = fmt[i] & 0xff;
 90c:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 90f:	80 fa 25             	cmp    $0x25,%dl
 912:	0f 84 78 01 00 00    	je     a90 <fprintf+0x1c0>
 918:	83 e8 63             	sub    $0x63,%eax
 91b:	83 f8 15             	cmp    $0x15,%eax
 91e:	77 10                	ja     930 <fprintf+0x60>
 920:	ff 24 85 e0 0c 00 00 	jmp    *0xce0(,%eax,4)
 927:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 92e:	00 
 92f:	90                   	nop
  write(fd, &c, 1);
 930:	83 ec 04             	sub    $0x4,%esp
 933:	8d 7d e7             	lea    -0x19(%ebp),%edi
 936:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 939:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 93d:	6a 01                	push   $0x1
 93f:	57                   	push   %edi
 940:	ff 75 08             	push   0x8(%ebp)
 943:	e8 4b fa ff ff       	call   393 <write>
        putc(fd, c);
 948:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 94c:	83 c4 0c             	add    $0xc,%esp
 94f:	88 55 e7             	mov    %dl,-0x19(%ebp)
 952:	6a 01                	push   $0x1
 954:	57                   	push   %edi
 955:	ff 75 08             	push   0x8(%ebp)
 958:	e8 36 fa ff ff       	call   393 <write>
  for(i = 0; fmt[i]; i++){
 95d:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 961:	83 c3 02             	add    $0x2,%ebx
 964:	83 c4 10             	add    $0x10,%esp
 967:	84 d2                	test   %dl,%dl
 969:	75 85                	jne    8f0 <fprintf+0x20>
      }
      state = 0;
    }
  }
}
 96b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 96e:	5b                   	pop    %ebx
 96f:	5e                   	pop    %esi
 970:	5f                   	pop    %edi
 971:	5d                   	pop    %ebp
 972:	c3                   	ret
 973:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(1, *ap, 16, 0, width, pad_char);
 978:	83 ec 08             	sub    $0x8,%esp
 97b:	8b 06                	mov    (%esi),%eax
 97d:	31 c9                	xor    %ecx,%ecx
 97f:	ba 10 00 00 00       	mov    $0x10,%edx
 984:	6a 20                	push   $0x20
 986:	6a 00                	push   $0x0
 988:	e8 d3 fa ff ff       	call   460 <printint.constprop.0>
        ap++;
 98d:	83 c6 04             	add    $0x4,%esi
  for(i = 0; fmt[i]; i++){
 990:	eb cb                	jmp    95d <fprintf+0x8d>
 992:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s = (char*)*ap;
 998:	8b 3e                	mov    (%esi),%edi
        ap++;
 99a:	83 c6 04             	add    $0x4,%esi
        if(s == 0)
 99d:	85 ff                	test   %edi,%edi
 99f:	0f 84 fb 00 00 00    	je     aa0 <fprintf+0x1d0>
        while(*s != 0){
 9a5:	0f b6 07             	movzbl (%edi),%eax
 9a8:	84 c0                	test   %al,%al
 9aa:	74 36                	je     9e2 <fprintf+0x112>
 9ac:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 9af:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 9b2:	8b 75 08             	mov    0x8(%ebp),%esi
 9b5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 9b8:	89 fb                	mov    %edi,%ebx
 9ba:	89 cf                	mov    %ecx,%edi
 9bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 9c0:	83 ec 04             	sub    $0x4,%esp
 9c3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 9c6:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 9c9:	6a 01                	push   $0x1
 9cb:	57                   	push   %edi
 9cc:	56                   	push   %esi
 9cd:	e8 c1 f9 ff ff       	call   393 <write>
        while(*s != 0){
 9d2:	0f b6 03             	movzbl (%ebx),%eax
 9d5:	83 c4 10             	add    $0x10,%esp
 9d8:	84 c0                	test   %al,%al
 9da:	75 e4                	jne    9c0 <fprintf+0xf0>
 9dc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 9df:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 9e2:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 9e6:	83 c3 02             	add    $0x2,%ebx
 9e9:	84 d2                	test   %dl,%dl
 9eb:	0f 84 7a ff ff ff    	je     96b <fprintf+0x9b>
    c = fmt[i] & 0xff;
 9f1:	0f b6 c2             	movzbl %dl,%eax
      if (c == '\f') { // Detect formfeed character
 9f4:	83 f8 0c             	cmp    $0xc,%eax
 9f7:	0f 85 ff fe ff ff    	jne    8fc <fprintf+0x2c>
 9fd:	8d 76 00             	lea    0x0(%esi),%esi
        setcursor();
 a00:	e8 26 fa ff ff       	call   42b <setcursor>
  for(i = 0; fmt[i]; i++){
 a05:	0f b6 13             	movzbl (%ebx),%edx
 a08:	83 c3 01             	add    $0x1,%ebx
 a0b:	84 d2                	test   %dl,%dl
 a0d:	0f 85 dd fe ff ff    	jne    8f0 <fprintf+0x20>
 a13:	e9 53 ff ff ff       	jmp    96b <fprintf+0x9b>
 a18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a1f:	00 
        printint(1, *ap, 10, 1, width, pad_char);
 a20:	83 ec 08             	sub    $0x8,%esp
 a23:	8b 06                	mov    (%esi),%eax
 a25:	b9 01 00 00 00       	mov    $0x1,%ecx
 a2a:	ba 0a 00 00 00       	mov    $0xa,%edx
 a2f:	6a 20                	push   $0x20
 a31:	6a 00                	push   $0x0
 a33:	e9 50 ff ff ff       	jmp    988 <fprintf+0xb8>
 a38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a3f:	00 
        putc(fd, *ap);
 a40:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
 a42:	83 ec 04             	sub    $0x4,%esp
 a45:	8d 7d e7             	lea    -0x19(%ebp),%edi
        putc(fd, *ap);
 a48:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 a4b:	6a 01                	push   $0x1
 a4d:	57                   	push   %edi
 a4e:	ff 75 08             	push   0x8(%ebp)
 a51:	e8 3d f9 ff ff       	call   393 <write>
 a56:	e9 32 ff ff ff       	jmp    98d <fprintf+0xbd>
 a5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 a60:	83 ec 04             	sub    $0x4,%esp
 a63:	8d 45 e7             	lea    -0x19(%ebp),%eax
 a66:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 a69:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 a6c:	6a 01                	push   $0x1
 a6e:	50                   	push   %eax
 a6f:	ff 75 08             	push   0x8(%ebp)
 a72:	e8 1c f9 ff ff       	call   393 <write>
  for(i = 0; fmt[i]; i++){
 a77:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 a7b:	83 c4 10             	add    $0x10,%esp
 a7e:	84 d2                	test   %dl,%dl
 a80:	0f 85 6a fe ff ff    	jne    8f0 <fprintf+0x20>
}
 a86:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a89:	5b                   	pop    %ebx
 a8a:	5e                   	pop    %esi
 a8b:	5f                   	pop    %edi
 a8c:	5d                   	pop    %ebp
 a8d:	c3                   	ret
 a8e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 a90:	83 ec 04             	sub    $0x4,%esp
 a93:	88 55 e7             	mov    %dl,-0x19(%ebp)
 a96:	8d 7d e7             	lea    -0x19(%ebp),%edi
 a99:	6a 01                	push   $0x1
 a9b:	e9 b4 fe ff ff       	jmp    954 <fprintf+0x84>
          s = "(null)";
 aa0:	bf 80 0c 00 00       	mov    $0xc80,%edi
 aa5:	b8 28 00 00 00       	mov    $0x28,%eax
 aaa:	e9 fd fe ff ff       	jmp    9ac <fprintf+0xdc>
 aaf:	66 90                	xchg   %ax,%ax
 ab1:	66 90                	xchg   %ax,%ax
 ab3:	66 90                	xchg   %ax,%ax
 ab5:	66 90                	xchg   %ax,%ax
 ab7:	66 90                	xchg   %ax,%ax
 ab9:	66 90                	xchg   %ax,%ax
 abb:	66 90                	xchg   %ax,%ax
 abd:	66 90                	xchg   %ax,%ax
 abf:	90                   	nop

00000ac0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ac0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ac1:	a1 a0 12 00 00       	mov    0x12a0,%eax
{
 ac6:	89 e5                	mov    %esp,%ebp
 ac8:	57                   	push   %edi
 ac9:	56                   	push   %esi
 aca:	53                   	push   %ebx
 acb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 ace:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ad1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 ad8:	00 
 ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 ae0:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ae2:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ae4:	39 ca                	cmp    %ecx,%edx
 ae6:	73 30                	jae    b18 <free+0x58>
 ae8:	39 c1                	cmp    %eax,%ecx
 aea:	72 04                	jb     af0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aec:	39 c2                	cmp    %eax,%edx
 aee:	72 f0                	jb     ae0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 af0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 af3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 af6:	39 f8                	cmp    %edi,%eax
 af8:	74 36                	je     b30 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 afa:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 afd:	8b 42 04             	mov    0x4(%edx),%eax
 b00:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 b03:	39 f1                	cmp    %esi,%ecx
 b05:	74 40                	je     b47 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 b07:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 b09:	5b                   	pop    %ebx
  freep = p;
 b0a:	89 15 a0 12 00 00    	mov    %edx,0x12a0
}
 b10:	5e                   	pop    %esi
 b11:	5f                   	pop    %edi
 b12:	5d                   	pop    %ebp
 b13:	c3                   	ret
 b14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b18:	39 c2                	cmp    %eax,%edx
 b1a:	72 c4                	jb     ae0 <free+0x20>
 b1c:	39 c1                	cmp    %eax,%ecx
 b1e:	73 c0                	jae    ae0 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 b20:	8b 73 fc             	mov    -0x4(%ebx),%esi
 b23:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 b26:	39 f8                	cmp    %edi,%eax
 b28:	75 d0                	jne    afa <free+0x3a>
 b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 b30:	03 70 04             	add    0x4(%eax),%esi
 b33:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 b36:	8b 02                	mov    (%edx),%eax
 b38:	8b 00                	mov    (%eax),%eax
 b3a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 b3d:	8b 42 04             	mov    0x4(%edx),%eax
 b40:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 b43:	39 f1                	cmp    %esi,%ecx
 b45:	75 c0                	jne    b07 <free+0x47>
    p->s.size += bp->s.size;
 b47:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 b4a:	89 15 a0 12 00 00    	mov    %edx,0x12a0
    p->s.size += bp->s.size;
 b50:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 b53:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 b56:	89 0a                	mov    %ecx,(%edx)
}
 b58:	5b                   	pop    %ebx
 b59:	5e                   	pop    %esi
 b5a:	5f                   	pop    %edi
 b5b:	5d                   	pop    %ebp
 b5c:	c3                   	ret
 b5d:	8d 76 00             	lea    0x0(%esi),%esi

00000b60 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b60:	55                   	push   %ebp
 b61:	89 e5                	mov    %esp,%ebp
 b63:	57                   	push   %edi
 b64:	56                   	push   %esi
 b65:	53                   	push   %ebx
 b66:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b69:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 b6c:	8b 15 a0 12 00 00    	mov    0x12a0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b72:	8d 78 07             	lea    0x7(%eax),%edi
 b75:	c1 ef 03             	shr    $0x3,%edi
 b78:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 b7b:	85 d2                	test   %edx,%edx
 b7d:	0f 84 8d 00 00 00    	je     c10 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b83:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 b85:	8b 48 04             	mov    0x4(%eax),%ecx
 b88:	39 f9                	cmp    %edi,%ecx
 b8a:	73 64                	jae    bf0 <malloc+0x90>
  if(nu < 4096)
 b8c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 b91:	39 df                	cmp    %ebx,%edi
 b93:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 b96:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 b9d:	eb 0a                	jmp    ba9 <malloc+0x49>
 b9f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ba0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 ba2:	8b 48 04             	mov    0x4(%eax),%ecx
 ba5:	39 f9                	cmp    %edi,%ecx
 ba7:	73 47                	jae    bf0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ba9:	89 c2                	mov    %eax,%edx
 bab:	39 05 a0 12 00 00    	cmp    %eax,0x12a0
 bb1:	75 ed                	jne    ba0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 bb3:	83 ec 0c             	sub    $0xc,%esp
 bb6:	56                   	push   %esi
 bb7:	e8 3f f8 ff ff       	call   3fb <sbrk>
  if(p == (char*)-1)
 bbc:	83 c4 10             	add    $0x10,%esp
 bbf:	83 f8 ff             	cmp    $0xffffffff,%eax
 bc2:	74 1c                	je     be0 <malloc+0x80>
  hp->s.size = nu;
 bc4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 bc7:	83 ec 0c             	sub    $0xc,%esp
 bca:	83 c0 08             	add    $0x8,%eax
 bcd:	50                   	push   %eax
 bce:	e8 ed fe ff ff       	call   ac0 <free>
  return freep;
 bd3:	8b 15 a0 12 00 00    	mov    0x12a0,%edx
      if((p = morecore(nunits)) == 0)
 bd9:	83 c4 10             	add    $0x10,%esp
 bdc:	85 d2                	test   %edx,%edx
 bde:	75 c0                	jne    ba0 <malloc+0x40>
        return 0;
  }
}
 be0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 be3:	31 c0                	xor    %eax,%eax
}
 be5:	5b                   	pop    %ebx
 be6:	5e                   	pop    %esi
 be7:	5f                   	pop    %edi
 be8:	5d                   	pop    %ebp
 be9:	c3                   	ret
 bea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 bf0:	39 cf                	cmp    %ecx,%edi
 bf2:	74 4c                	je     c40 <malloc+0xe0>
        p->s.size -= nunits;
 bf4:	29 f9                	sub    %edi,%ecx
 bf6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 bf9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 bfc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 bff:	89 15 a0 12 00 00    	mov    %edx,0x12a0
}
 c05:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 c08:	83 c0 08             	add    $0x8,%eax
}
 c0b:	5b                   	pop    %ebx
 c0c:	5e                   	pop    %esi
 c0d:	5f                   	pop    %edi
 c0e:	5d                   	pop    %ebp
 c0f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 c10:	c7 05 a0 12 00 00 a4 	movl   $0x12a4,0x12a0
 c17:	12 00 00 
    base.s.size = 0;
 c1a:	b8 a4 12 00 00       	mov    $0x12a4,%eax
    base.s.ptr = freep = prevp = &base;
 c1f:	c7 05 a4 12 00 00 a4 	movl   $0x12a4,0x12a4
 c26:	12 00 00 
    base.s.size = 0;
 c29:	c7 05 a8 12 00 00 00 	movl   $0x0,0x12a8
 c30:	00 00 00 
    if(p->s.size >= nunits){
 c33:	e9 54 ff ff ff       	jmp    b8c <malloc+0x2c>
 c38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 c3f:	00 
        prevp->s.ptr = p->s.ptr;
 c40:	8b 08                	mov    (%eax),%ecx
 c42:	89 0a                	mov    %ecx,(%edx)
 c44:	eb b9                	jmp    bff <malloc+0x9f>
