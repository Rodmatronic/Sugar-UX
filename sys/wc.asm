
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf("%d %d %d %s\n", l, w, c, name);
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
   e:	bf 01 00 00 00       	mov    $0x1,%edi
  13:	56                   	push   %esi
  14:	53                   	push   %ebx
  15:	51                   	push   %ecx
  16:	83 ec 18             	sub    $0x18,%esp
  19:	8b 01                	mov    (%ecx),%eax
  1b:	8b 71 04             	mov    0x4(%ecx),%esi
  1e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int fd, i;

  if(argc <= 1){
  21:	83 f8 01             	cmp    $0x1,%eax
  24:	7e 57                	jle    7d <main+0x7d>
  26:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  2d:	00 
  2e:	66 90                	xchg   %ax,%ax
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  30:	83 ec 08             	sub    $0x8,%esp
  33:	6a 00                	push   $0x0
  35:	ff 34 be             	push   (%esi,%edi,4)
  38:	e8 d6 03 00 00       	call   413 <open>
  3d:	83 c4 10             	add    $0x10,%esp
  40:	89 c3                	mov    %eax,%ebx
      printf("wc: cannot open %s\n", argv[i]);
  42:	8b 04 be             	mov    (%esi,%edi,4),%eax
    if((fd = open(argv[i], 0)) < 0){
  45:	85 db                	test   %ebx,%ebx
  47:	78 22                	js     6b <main+0x6b>
      exit();
    }
    wc(fd, argv[i]);
  49:	83 ec 08             	sub    $0x8,%esp
  for(i = 1; i < argc; i++){
  4c:	83 c7 01             	add    $0x1,%edi
    wc(fd, argv[i]);
  4f:	50                   	push   %eax
  50:	53                   	push   %ebx
  51:	e8 3a 00 00 00       	call   90 <wc>
    close(fd);
  56:	89 1c 24             	mov    %ebx,(%esp)
  59:	e8 9d 03 00 00       	call   3fb <close>
  for(i = 1; i < argc; i++){
  5e:	83 c4 10             	add    $0x10,%esp
  61:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
  64:	75 ca                	jne    30 <main+0x30>
  }
  exit();
  66:	e8 68 03 00 00       	call   3d3 <exit>
      printf("wc: cannot open %s\n", argv[i]);
  6b:	52                   	push   %edx
  6c:	52                   	push   %edx
  6d:	50                   	push   %eax
  6e:	68 cb 0c 00 00       	push   $0xccb
  73:	e8 d8 05 00 00       	call   650 <printf>
      exit();
  78:	e8 56 03 00 00       	call   3d3 <exit>
    wc(0, "");
  7d:	51                   	push   %ecx
  7e:	51                   	push   %ecx
  7f:	68 bd 0c 00 00       	push   $0xcbd
  84:	6a 00                	push   $0x0
  86:	e8 05 00 00 00       	call   90 <wc>
    exit();
  8b:	e8 43 03 00 00       	call   3d3 <exit>

00000090 <wc>:
{
  90:	55                   	push   %ebp
  l = w = c = 0;
  91:	31 d2                	xor    %edx,%edx
{
  93:	89 e5                	mov    %esp,%ebp
  95:	57                   	push   %edi
  96:	56                   	push   %esi
  inword = 0;
  97:	31 f6                	xor    %esi,%esi
{
  99:	53                   	push   %ebx
  l = w = c = 0;
  9a:	31 db                	xor    %ebx,%ebx
{
  9c:	83 ec 1c             	sub    $0x1c,%esp
  l = w = c = 0;
  9f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  a6:	89 55 dc             	mov    %edx,-0x24(%ebp)
  a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while((n = read(fd, buf, sizeof(buf))) > 0){
  b0:	83 ec 04             	sub    $0x4,%esp
  b3:	68 00 02 00 00       	push   $0x200
  b8:	68 00 11 00 00       	push   $0x1100
  bd:	ff 75 08             	push   0x8(%ebp)
  c0:	e8 26 03 00 00       	call   3eb <read>
  c5:	83 c4 10             	add    $0x10,%esp
  c8:	89 c1                	mov    %eax,%ecx
  ca:	85 c0                	test   %eax,%eax
  cc:	7e 62                	jle    130 <wc+0xa0>
    for(i=0; i<n; i++){
  ce:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  d1:	31 ff                	xor    %edi,%edi
  d3:	eb 0d                	jmp    e2 <wc+0x52>
  d5:	8d 76 00             	lea    0x0(%esi),%esi
        inword = 0;
  d8:	31 f6                	xor    %esi,%esi
    for(i=0; i<n; i++){
  da:	83 c7 01             	add    $0x1,%edi
  dd:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
  e0:	74 3e                	je     120 <wc+0x90>
      if(buf[i] == '\n')
  e2:	0f be 87 00 11 00 00 	movsbl 0x1100(%edi),%eax
        l++;
  e9:	31 c9                	xor    %ecx,%ecx
  eb:	3c 0a                	cmp    $0xa,%al
  ed:	0f 94 c1             	sete   %cl
      if(strchr(" \r\t\n\v", buf[i]))
  f0:	83 ec 08             	sub    $0x8,%esp
  f3:	50                   	push   %eax
        l++;
  f4:	01 cb                	add    %ecx,%ebx
      if(strchr(" \r\t\n\v", buf[i]))
  f6:	68 a8 0c 00 00       	push   $0xca8
  fb:	e8 70 01 00 00       	call   270 <strchr>
 100:	83 c4 10             	add    $0x10,%esp
 103:	85 c0                	test   %eax,%eax
 105:	75 d1                	jne    d8 <wc+0x48>
      else if(!inword){
 107:	85 f6                	test   %esi,%esi
 109:	75 cf                	jne    da <wc+0x4a>
        w++;
 10b:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
        inword = 1;
 10f:	be 01 00 00 00       	mov    $0x1,%esi
    for(i=0; i<n; i++){
 114:	83 c7 01             	add    $0x1,%edi
 117:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
 11a:	75 c6                	jne    e2 <wc+0x52>
 11c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 120:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 123:	01 4d dc             	add    %ecx,-0x24(%ebp)
 126:	eb 88                	jmp    b0 <wc+0x20>
 128:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 12f:	00 
  if(n < 0){
 130:	8b 55 dc             	mov    -0x24(%ebp),%edx
 133:	75 20                	jne    155 <wc+0xc5>
  printf("%d %d %d %s\n", l, w, c, name);
 135:	83 ec 0c             	sub    $0xc,%esp
 138:	ff 75 0c             	push   0xc(%ebp)
 13b:	52                   	push   %edx
 13c:	ff 75 e0             	push   -0x20(%ebp)
 13f:	53                   	push   %ebx
 140:	68 be 0c 00 00       	push   $0xcbe
 145:	e8 06 05 00 00       	call   650 <printf>
}
 14a:	83 c4 20             	add    $0x20,%esp
 14d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 150:	5b                   	pop    %ebx
 151:	5e                   	pop    %esi
 152:	5f                   	pop    %edi
 153:	5d                   	pop    %ebp
 154:	c3                   	ret
    printf("wc: read error\n");
 155:	83 ec 0c             	sub    $0xc,%esp
 158:	68 ae 0c 00 00       	push   $0xcae
 15d:	e8 ee 04 00 00       	call   650 <printf>
    exit();
 162:	e8 6c 02 00 00       	call   3d3 <exit>
 167:	66 90                	xchg   %ax,%ax
 169:	66 90                	xchg   %ax,%ax
 16b:	66 90                	xchg   %ax,%ax
 16d:	66 90                	xchg   %ax,%ax
 16f:	66 90                	xchg   %ax,%ax
 171:	66 90                	xchg   %ax,%ax
 173:	66 90                	xchg   %ax,%ax
 175:	66 90                	xchg   %ax,%ax
 177:	66 90                	xchg   %ax,%ax
 179:	66 90                	xchg   %ax,%ax
 17b:	66 90                	xchg   %ax,%ax
 17d:	66 90                	xchg   %ax,%ax
 17f:	90                   	nop

00000180 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 180:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 181:	31 c0                	xor    %eax,%eax
{
 183:	89 e5                	mov    %esp,%ebp
 185:	53                   	push   %ebx
 186:	8b 4d 08             	mov    0x8(%ebp),%ecx
 189:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 190:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 194:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 197:	83 c0 01             	add    $0x1,%eax
 19a:	84 d2                	test   %dl,%dl
 19c:	75 f2                	jne    190 <strcpy+0x10>
    ;
  return os;
}
 19e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1a1:	89 c8                	mov    %ecx,%eax
 1a3:	c9                   	leave
 1a4:	c3                   	ret
 1a5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ac:	00 
 1ad:	8d 76 00             	lea    0x0(%esi),%esi

000001b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	53                   	push   %ebx
 1b4:	8b 55 08             	mov    0x8(%ebp),%edx
 1b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1ba:	0f b6 02             	movzbl (%edx),%eax
 1bd:	84 c0                	test   %al,%al
 1bf:	75 2f                	jne    1f0 <strcmp+0x40>
 1c1:	eb 4a                	jmp    20d <strcmp+0x5d>
 1c3:	eb 1b                	jmp    1e0 <strcmp+0x30>
 1c5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1cc:	00 
 1cd:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1d4:	00 
 1d5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1dc:	00 
 1dd:	8d 76 00             	lea    0x0(%esi),%esi
 1e0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 1e4:	83 c2 01             	add    $0x1,%edx
 1e7:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 1ea:	84 c0                	test   %al,%al
 1ec:	74 12                	je     200 <strcmp+0x50>
 1ee:	89 d9                	mov    %ebx,%ecx
 1f0:	0f b6 19             	movzbl (%ecx),%ebx
 1f3:	38 c3                	cmp    %al,%bl
 1f5:	74 e9                	je     1e0 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 1f7:	29 d8                	sub    %ebx,%eax
}
 1f9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1fc:	c9                   	leave
 1fd:	c3                   	ret
 1fe:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 200:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 204:	31 c0                	xor    %eax,%eax
 206:	29 d8                	sub    %ebx,%eax
}
 208:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 20b:	c9                   	leave
 20c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 20d:	0f b6 19             	movzbl (%ecx),%ebx
 210:	31 c0                	xor    %eax,%eax
 212:	eb e3                	jmp    1f7 <strcmp+0x47>
 214:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 21b:	00 
 21c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000220 <strlen>:

uint
strlen(char *s)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 226:	80 3a 00             	cmpb   $0x0,(%edx)
 229:	74 15                	je     240 <strlen+0x20>
 22b:	31 c0                	xor    %eax,%eax
 22d:	8d 76 00             	lea    0x0(%esi),%esi
 230:	83 c0 01             	add    $0x1,%eax
 233:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 237:	89 c1                	mov    %eax,%ecx
 239:	75 f5                	jne    230 <strlen+0x10>
    ;
  return n;
}
 23b:	89 c8                	mov    %ecx,%eax
 23d:	5d                   	pop    %ebp
 23e:	c3                   	ret
 23f:	90                   	nop
  for(n = 0; s[n]; n++)
 240:	31 c9                	xor    %ecx,%ecx
}
 242:	5d                   	pop    %ebp
 243:	89 c8                	mov    %ecx,%eax
 245:	c3                   	ret
 246:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 24d:	00 
 24e:	66 90                	xchg   %ax,%ax

00000250 <memset>:

void*
memset(void *dst, int c, uint n)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	57                   	push   %edi
 254:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 257:	8b 4d 10             	mov    0x10(%ebp),%ecx
 25a:	8b 45 0c             	mov    0xc(%ebp),%eax
 25d:	89 d7                	mov    %edx,%edi
 25f:	fc                   	cld
 260:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 262:	8b 7d fc             	mov    -0x4(%ebp),%edi
 265:	89 d0                	mov    %edx,%eax
 267:	c9                   	leave
 268:	c3                   	ret
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000270 <strchr>:

char*
strchr(const char *s, char c)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 27a:	0f b6 10             	movzbl (%eax),%edx
 27d:	84 d2                	test   %dl,%dl
 27f:	75 1a                	jne    29b <strchr+0x2b>
 281:	eb 25                	jmp    2a8 <strchr+0x38>
 283:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 28a:	00 
 28b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 290:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 294:	83 c0 01             	add    $0x1,%eax
 297:	84 d2                	test   %dl,%dl
 299:	74 0d                	je     2a8 <strchr+0x38>
    if(*s == c)
 29b:	38 d1                	cmp    %dl,%cl
 29d:	75 f1                	jne    290 <strchr+0x20>
      return (char*)s;
  return 0;
}
 29f:	5d                   	pop    %ebp
 2a0:	c3                   	ret
 2a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 2a8:	31 c0                	xor    %eax,%eax
}
 2aa:	5d                   	pop    %ebp
 2ab:	c3                   	ret
 2ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002b0 <gets>:

char*
gets(char *buf, int max)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	57                   	push   %edi
 2b4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 2b5:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 2b8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 2b9:	31 db                	xor    %ebx,%ebx
{
 2bb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 2be:	eb 27                	jmp    2e7 <gets+0x37>
    cc = read(0, &c, 1);
 2c0:	83 ec 04             	sub    $0x4,%esp
 2c3:	6a 01                	push   $0x1
 2c5:	56                   	push   %esi
 2c6:	6a 00                	push   $0x0
 2c8:	e8 1e 01 00 00       	call   3eb <read>
    if(cc < 1)
 2cd:	83 c4 10             	add    $0x10,%esp
 2d0:	85 c0                	test   %eax,%eax
 2d2:	7e 1d                	jle    2f1 <gets+0x41>
      break;
    buf[i++] = c;
 2d4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2d8:	8b 55 08             	mov    0x8(%ebp),%edx
 2db:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 2df:	3c 0a                	cmp    $0xa,%al
 2e1:	74 10                	je     2f3 <gets+0x43>
 2e3:	3c 0d                	cmp    $0xd,%al
 2e5:	74 0c                	je     2f3 <gets+0x43>
  for(i=0; i+1 < max; ){
 2e7:	89 df                	mov    %ebx,%edi
 2e9:	83 c3 01             	add    $0x1,%ebx
 2ec:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2ef:	7c cf                	jl     2c0 <gets+0x10>
 2f1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 2f3:	8b 45 08             	mov    0x8(%ebp),%eax
 2f6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 2fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2fd:	5b                   	pop    %ebx
 2fe:	5e                   	pop    %esi
 2ff:	5f                   	pop    %edi
 300:	5d                   	pop    %ebp
 301:	c3                   	ret
 302:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 309:	00 
 30a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000310 <stat>:

int
stat(char *n, struct stat *st)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	56                   	push   %esi
 314:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 315:	83 ec 08             	sub    $0x8,%esp
 318:	6a 00                	push   $0x0
 31a:	ff 75 08             	push   0x8(%ebp)
 31d:	e8 f1 00 00 00       	call   413 <open>
  if(fd < 0)
 322:	83 c4 10             	add    $0x10,%esp
 325:	85 c0                	test   %eax,%eax
 327:	78 27                	js     350 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 329:	83 ec 08             	sub    $0x8,%esp
 32c:	ff 75 0c             	push   0xc(%ebp)
 32f:	89 c3                	mov    %eax,%ebx
 331:	50                   	push   %eax
 332:	e8 f4 00 00 00       	call   42b <fstat>
  close(fd);
 337:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 33a:	89 c6                	mov    %eax,%esi
  close(fd);
 33c:	e8 ba 00 00 00       	call   3fb <close>
  return r;
 341:	83 c4 10             	add    $0x10,%esp
}
 344:	8d 65 f8             	lea    -0x8(%ebp),%esp
 347:	89 f0                	mov    %esi,%eax
 349:	5b                   	pop    %ebx
 34a:	5e                   	pop    %esi
 34b:	5d                   	pop    %ebp
 34c:	c3                   	ret
 34d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 350:	be ff ff ff ff       	mov    $0xffffffff,%esi
 355:	eb ed                	jmp    344 <stat+0x34>
 357:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 35e:	00 
 35f:	90                   	nop

00000360 <atoi>:

int
atoi(const char *s)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	53                   	push   %ebx
 364:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 367:	0f be 02             	movsbl (%edx),%eax
 36a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 36d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 370:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 375:	77 1e                	ja     395 <atoi+0x35>
 377:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 37e:	00 
 37f:	90                   	nop
    n = n*10 + *s++ - '0';
 380:	83 c2 01             	add    $0x1,%edx
 383:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 386:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 38a:	0f be 02             	movsbl (%edx),%eax
 38d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 390:	80 fb 09             	cmp    $0x9,%bl
 393:	76 eb                	jbe    380 <atoi+0x20>
  return n;
}
 395:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 398:	89 c8                	mov    %ecx,%eax
 39a:	c9                   	leave
 39b:	c3                   	ret
 39c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003a0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	8b 45 10             	mov    0x10(%ebp),%eax
 3a7:	8b 55 08             	mov    0x8(%ebp),%edx
 3aa:	56                   	push   %esi
 3ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3ae:	85 c0                	test   %eax,%eax
 3b0:	7e 13                	jle    3c5 <memmove+0x25>
 3b2:	01 d0                	add    %edx,%eax
  dst = vdst;
 3b4:	89 d7                	mov    %edx,%edi
 3b6:	66 90                	xchg   %ax,%ax
 3b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3bf:	00 
    *dst++ = *src++;
 3c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3c1:	39 f8                	cmp    %edi,%eax
 3c3:	75 fb                	jne    3c0 <memmove+0x20>
  return vdst;
}
 3c5:	5e                   	pop    %esi
 3c6:	89 d0                	mov    %edx,%eax
 3c8:	5f                   	pop    %edi
 3c9:	5d                   	pop    %ebp
 3ca:	c3                   	ret

000003cb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3cb:	b8 01 00 00 00       	mov    $0x1,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <exit>:
SYSCALL(exit)
 3d3:	b8 02 00 00 00       	mov    $0x2,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <wait>:
SYSCALL(wait)
 3db:	b8 03 00 00 00       	mov    $0x3,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

000003e3 <pipe>:
SYSCALL(pipe)
 3e3:	b8 04 00 00 00       	mov    $0x4,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

000003eb <read>:
SYSCALL(read)
 3eb:	b8 05 00 00 00       	mov    $0x5,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <write>:
SYSCALL(write)
 3f3:	b8 10 00 00 00       	mov    $0x10,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <close>:
SYSCALL(close)
 3fb:	b8 15 00 00 00       	mov    $0x15,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <kill>:
SYSCALL(kill)
 403:	b8 06 00 00 00       	mov    $0x6,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

0000040b <exec>:
SYSCALL(exec)
 40b:	b8 07 00 00 00       	mov    $0x7,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret

00000413 <open>:
SYSCALL(open)
 413:	b8 0f 00 00 00       	mov    $0xf,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

0000041b <mknod>:
SYSCALL(mknod)
 41b:	b8 11 00 00 00       	mov    $0x11,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

00000423 <unlink>:
SYSCALL(unlink)
 423:	b8 12 00 00 00       	mov    $0x12,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

0000042b <fstat>:
SYSCALL(fstat)
 42b:	b8 08 00 00 00       	mov    $0x8,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

00000433 <link>:
SYSCALL(link)
 433:	b8 13 00 00 00       	mov    $0x13,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret

0000043b <mkdir>:
SYSCALL(mkdir)
 43b:	b8 14 00 00 00       	mov    $0x14,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret

00000443 <chdir>:
SYSCALL(chdir)
 443:	b8 09 00 00 00       	mov    $0x9,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret

0000044b <dup>:
SYSCALL(dup)
 44b:	b8 0a 00 00 00       	mov    $0xa,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret

00000453 <getpid>:
SYSCALL(getpid)
 453:	b8 0b 00 00 00       	mov    $0xb,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret

0000045b <sbrk>:
SYSCALL(sbrk)
 45b:	b8 0c 00 00 00       	mov    $0xc,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret

00000463 <sleep>:
SYSCALL(sleep)
 463:	b8 0d 00 00 00       	mov    $0xd,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret

0000046b <uptime>:
SYSCALL(uptime)
 46b:	b8 0e 00 00 00       	mov    $0xe,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret

00000473 <bstat>:
SYSCALL(bstat)
 473:	b8 16 00 00 00       	mov    $0x16,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret

0000047b <swap>:
SYSCALL(swap)
 47b:	b8 17 00 00 00       	mov    $0x17,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret

00000483 <gettime>:
SYSCALL(gettime)
 483:	b8 18 00 00 00       	mov    $0x18,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret

0000048b <setcursor>:
SYSCALL(setcursor)
 48b:	b8 19 00 00 00       	mov    $0x19,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret

00000493 <uname>:
SYSCALL(uname)
 493:	b8 1a 00 00 00       	mov    $0x1a,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret

0000049b <echo>:
SYSCALL(echo)
 49b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret
 4a3:	66 90                	xchg   %ax,%ax
 4a5:	66 90                	xchg   %ax,%ax
 4a7:	66 90                	xchg   %ax,%ax
 4a9:	66 90                	xchg   %ax,%ax
 4ab:	66 90                	xchg   %ax,%ax
 4ad:	66 90                	xchg   %ax,%ax
 4af:	66 90                	xchg   %ax,%ax
 4b1:	66 90                	xchg   %ax,%ax
 4b3:	66 90                	xchg   %ax,%ax
 4b5:	66 90                	xchg   %ax,%ax
 4b7:	66 90                	xchg   %ax,%ax
 4b9:	66 90                	xchg   %ax,%ax
 4bb:	66 90                	xchg   %ax,%ax
 4bd:	66 90                	xchg   %ax,%ax
 4bf:	90                   	nop

000004c0 <printint.constprop.0>:
{
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn, int width, char pad_char)
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	56                   	push   %esi
 4c5:	89 c6                	mov    %eax,%esi
 4c7:	53                   	push   %ebx
 4c8:	89 d3                	mov    %edx,%ebx
 4ca:	83 ec 3c             	sub    $0x3c,%esp
 4cd:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4d1:	85 f6                	test   %esi,%esi
 4d3:	0f 89 d7 00 00 00    	jns    5b0 <printint.constprop.0+0xf0>
 4d9:	83 e1 01             	and    $0x1,%ecx
 4dc:	0f 84 ce 00 00 00    	je     5b0 <printint.constprop.0+0xf0>
    neg = 1;
 4e2:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 4e9:	f7 de                	neg    %esi
 4eb:	89 f1                	mov    %esi,%ecx
  } else {
    x = xx;
  }

  i = 0;
 4ed:	88 45 bf             	mov    %al,-0x41(%ebp)
 4f0:	31 ff                	xor    %edi,%edi
 4f2:	8d 75 d7             	lea    -0x29(%ebp),%esi
 4f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4fc:	00 
 4fd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 500:	89 c8                	mov    %ecx,%eax
 502:	31 d2                	xor    %edx,%edx
 504:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 507:	83 c7 01             	add    $0x1,%edi
 50a:	f7 f3                	div    %ebx
 50c:	0f b6 92 98 0d 00 00 	movzbl 0xd98(%edx),%edx
 513:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 516:	89 ca                	mov    %ecx,%edx
 518:	89 c1                	mov    %eax,%ecx
 51a:	39 da                	cmp    %ebx,%edx
 51c:	73 e2                	jae    500 <printint.constprop.0+0x40>

  if(neg)
 51e:	8b 55 c0             	mov    -0x40(%ebp),%edx
 521:	0f b6 45 bf          	movzbl -0x41(%ebp),%eax
 525:	85 d2                	test   %edx,%edx
 527:	74 0b                	je     534 <printint.constprop.0+0x74>
    buf[i++] = '-';
 529:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
 52c:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 531:	8d 79 02             	lea    0x2(%ecx),%edi

  // Pad with pad_char until we hit the required width
  while(i < width)
 534:	39 7d 08             	cmp    %edi,0x8(%ebp)
 537:	0f 8e 83 00 00 00    	jle    5c0 <printint.constprop.0+0x100>
 53d:	8b 55 08             	mov    0x8(%ebp),%edx
 540:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 543:	01 df                	add    %ebx,%edi
 545:	01 da                	add    %ebx,%edx
 547:	89 d1                	mov    %edx,%ecx
 549:	29 f9                	sub    %edi,%ecx
 54b:	83 e1 01             	and    $0x1,%ecx
 54e:	74 10                	je     560 <printint.constprop.0+0xa0>
    buf[i++] = pad_char;
 550:	88 07                	mov    %al,(%edi)
  while(i < width)
 552:	83 c7 01             	add    $0x1,%edi
 555:	39 d7                	cmp    %edx,%edi
 557:	74 13                	je     56c <printint.constprop.0+0xac>
 559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = pad_char;
 560:	88 07                	mov    %al,(%edi)
  while(i < width)
 562:	83 c7 02             	add    $0x2,%edi
    buf[i++] = pad_char;
 565:	88 47 ff             	mov    %al,-0x1(%edi)
  while(i < width)
 568:	39 d7                	cmp    %edx,%edi
 56a:	75 f4                	jne    560 <printint.constprop.0+0xa0>
 56c:	8b 45 08             	mov    0x8(%ebp),%eax
 56f:	8d 78 ff             	lea    -0x1(%eax),%edi

  while(--i >= 0)
 572:	01 df                	add    %ebx,%edi
 574:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 57b:	00 
 57c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 580:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 583:	83 ec 04             	sub    $0x4,%esp
 586:	88 45 d7             	mov    %al,-0x29(%ebp)
 589:	6a 01                	push   $0x1
 58b:	56                   	push   %esi
 58c:	6a 01                	push   $0x1
 58e:	e8 60 fe ff ff       	call   3f3 <write>
  while(--i >= 0)
 593:	89 f8                	mov    %edi,%eax
 595:	83 c4 10             	add    $0x10,%esp
 598:	83 ef 01             	sub    $0x1,%edi
 59b:	39 d8                	cmp    %ebx,%eax
 59d:	75 e1                	jne    580 <printint.constprop.0+0xc0>
}
 59f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5a2:	5b                   	pop    %ebx
 5a3:	5e                   	pop    %esi
 5a4:	5f                   	pop    %edi
 5a5:	5d                   	pop    %ebp
 5a6:	c3                   	ret
 5a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5ae:	00 
 5af:	90                   	nop
  neg = 0;
 5b0:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = xx;
 5b7:	89 f1                	mov    %esi,%ecx
 5b9:	e9 2f ff ff ff       	jmp    4ed <printint.constprop.0+0x2d>
 5be:	66 90                	xchg   %ax,%ax
  while(--i >= 0)
 5c0:	83 ef 01             	sub    $0x1,%edi
 5c3:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 5c6:	eb aa                	jmp    572 <printint.constprop.0+0xb2>
 5c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5cf:	00 

000005d0 <strncpy>:
{
 5d0:	55                   	push   %ebp
 5d1:	31 c0                	xor    %eax,%eax
 5d3:	89 e5                	mov    %esp,%ebp
 5d5:	56                   	push   %esi
 5d6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 5d9:	8b 75 0c             	mov    0xc(%ebp),%esi
 5dc:	53                   	push   %ebx
 5dd:	8b 5d 10             	mov    0x10(%ebp),%ebx
  for (i = 0; i < n && src[i]; i++)
 5e0:	85 db                	test   %ebx,%ebx
 5e2:	7f 26                	jg     60a <strncpy+0x3a>
 5e4:	eb 58                	jmp    63e <strncpy+0x6e>
 5e6:	eb 18                	jmp    600 <strncpy+0x30>
 5e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5ef:	00 
 5f0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5f7:	00 
 5f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5ff:	00 
    dest[i] = src[i];
 600:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  for (i = 0; i < n && src[i]; i++)
 603:	83 c0 01             	add    $0x1,%eax
 606:	39 c3                	cmp    %eax,%ebx
 608:	74 34                	je     63e <strncpy+0x6e>
 60a:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
 60e:	84 d2                	test   %dl,%dl
 610:	75 ee                	jne    600 <strncpy+0x30>
  for (; i < n; i++)
 612:	39 c3                	cmp    %eax,%ebx
 614:	7e 28                	jle    63e <strncpy+0x6e>
 616:	01 c8                	add    %ecx,%eax
 618:	01 d9                	add    %ebx,%ecx
 61a:	89 ca                	mov    %ecx,%edx
 61c:	29 c2                	sub    %eax,%edx
 61e:	83 e2 01             	and    $0x1,%edx
 621:	74 0d                	je     630 <strncpy+0x60>
    dest[i] = '\0';
 623:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
 626:	83 c0 01             	add    $0x1,%eax
 629:	39 c8                	cmp    %ecx,%eax
 62b:	74 11                	je     63e <strncpy+0x6e>
 62d:	8d 76 00             	lea    0x0(%esi),%esi
    dest[i] = '\0';
 630:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
 633:	83 c0 02             	add    $0x2,%eax
    dest[i] = '\0';
 636:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  for (; i < n; i++)
 63a:	39 c8                	cmp    %ecx,%eax
 63c:	75 f2                	jne    630 <strncpy+0x60>
}
 63e:	5b                   	pop    %ebx
 63f:	5e                   	pop    %esi
 640:	5d                   	pop    %ebp
 641:	c3                   	ret
 642:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 649:	00 
 64a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000650 <printf>:

void
printf(char *fmt, ...)
{
 650:	55                   	push   %ebp
 651:	89 e5                	mov    %esp,%ebp
 653:	57                   	push   %edi
 654:	56                   	push   %esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 655:	8d 75 0c             	lea    0xc(%ebp),%esi
{
 658:	53                   	push   %ebx
 659:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  for(i = 0; fmt[i]; i++){
 65c:	8b 55 08             	mov    0x8(%ebp),%edx
  ap = (uint*)(void*)&fmt + 1;
 65f:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 662:	0f b6 02             	movzbl (%edx),%eax
 665:	84 c0                	test   %al,%al
 667:	0f 84 88 00 00 00    	je     6f5 <printf+0xa5>
 66d:	8d 7a 01             	lea    0x1(%edx),%edi
    c = fmt[i] & 0xff;
 670:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
      if (c == '\f') {
 673:	83 fa 0c             	cmp    $0xc,%edx
 676:	0f 84 d4 01 00 00    	je     850 <printf+0x200>
        setcursor();
      } else if(c == '%'){
 67c:	83 fa 25             	cmp    $0x25,%edx
 67f:	0f 85 0b 02 00 00    	jne    890 <printf+0x240>
  for(i = 0; fmt[i]; i++){
 685:	0f b6 1f             	movzbl (%edi),%ebx
 688:	83 c7 01             	add    $0x1,%edi
 68b:	84 db                	test   %bl,%bl
 68d:	74 66                	je     6f5 <printf+0xa5>
    c = fmt[i] & 0xff;
 68f:	0f b6 c3             	movzbl %bl,%eax
 692:	ba 20 00 00 00       	mov    $0x20,%edx
 697:	31 c9                	xor    %ecx,%ecx
        pad_char = ' ';
      } else {
        putc(1, c);
      }
    } else if(state == '%'){
      if(c == '0'){
 699:	83 f8 78             	cmp    $0x78,%eax
 69c:	7f 22                	jg     6c0 <printf+0x70>
 69e:	83 f8 62             	cmp    $0x62,%eax
 6a1:	0f 8e b9 01 00 00    	jle    860 <printf+0x210>
 6a7:	83 e8 63             	sub    $0x63,%eax
 6aa:	83 f8 15             	cmp    $0x15,%eax
 6ad:	77 11                	ja     6c0 <printf+0x70>
 6af:	ff 24 85 e8 0c 00 00 	jmp    *0xce8(,%eax,4)
 6b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6bd:	00 
 6be:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 6c0:	83 ec 04             	sub    $0x4,%esp
 6c3:	8d 75 e7             	lea    -0x19(%ebp),%esi
 6c6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 6ca:	6a 01                	push   $0x1
 6cc:	56                   	push   %esi
 6cd:	6a 01                	push   $0x1
 6cf:	e8 1f fd ff ff       	call   3f3 <write>
 6d4:	83 c4 0c             	add    $0xc,%esp
 6d7:	88 5d e7             	mov    %bl,-0x19(%ebp)
 6da:	6a 01                	push   $0x1
 6dc:	56                   	push   %esi
 6dd:	6a 01                	push   $0x1
 6df:	e8 0f fd ff ff       	call   3f3 <write>
      } else if(c == '%'){
        putc(1, '%');
        state = 0;
      } else {
        putc(1, '%');
        putc(1, c);
 6e4:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 6e7:	0f b6 07             	movzbl (%edi),%eax
 6ea:	83 c7 01             	add    $0x1,%edi
 6ed:	84 c0                	test   %al,%al
 6ef:	0f 85 7b ff ff ff    	jne    670 <printf+0x20>
        state = 0;
      }
    }
  }
}
 6f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6f8:	5b                   	pop    %ebx
 6f9:	5e                   	pop    %esi
 6fa:	5f                   	pop    %edi
 6fb:	5d                   	pop    %ebp
 6fc:	c3                   	ret
 6fd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 16, 0, width, pad_char);
 700:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 703:	83 ec 08             	sub    $0x8,%esp
 706:	8b 06                	mov    (%esi),%eax
 708:	52                   	push   %edx
 709:	ba 10 00 00 00       	mov    $0x10,%edx
 70e:	51                   	push   %ecx
 70f:	31 c9                	xor    %ecx,%ecx
        printint(1, *ap, 10, 1, width, pad_char);
 711:	e8 aa fd ff ff       	call   4c0 <printint.constprop.0>
        ap++;
 716:	83 c6 04             	add    $0x4,%esi
 719:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 71c:	0f b6 07             	movzbl (%edi),%eax
 71f:	83 c7 01             	add    $0x1,%edi
 722:	83 c4 10             	add    $0x10,%esp
 725:	84 c0                	test   %al,%al
 727:	0f 85 43 ff ff ff    	jne    670 <printf+0x20>
}
 72d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 730:	5b                   	pop    %ebx
 731:	5e                   	pop    %esi
 732:	5f                   	pop    %edi
 733:	5d                   	pop    %ebp
 734:	c3                   	ret
 735:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 10, 1, width, pad_char);
 738:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 73b:	83 ec 08             	sub    $0x8,%esp
 73e:	8b 06                	mov    (%esi),%eax
 740:	52                   	push   %edx
 741:	ba 0a 00 00 00       	mov    $0xa,%edx
 746:	51                   	push   %ecx
 747:	b9 01 00 00 00       	mov    $0x1,%ecx
 74c:	eb c3                	jmp    711 <printf+0xc1>
 74e:	66 90                	xchg   %ax,%ax
        s = (char*)*ap;
 750:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 753:	8b 06                	mov    (%esi),%eax
        ap++;
 755:	83 c6 04             	add    $0x4,%esi
 758:	89 75 d4             	mov    %esi,-0x2c(%ebp)
        if(s == 0)
 75b:	85 c0                	test   %eax,%eax
 75d:	0f 85 9d 01 00 00    	jne    900 <printf+0x2b0>
 763:	c6 45 d0 28          	movb   $0x28,-0x30(%ebp)
          s = "(null)";
 767:	b8 df 0c 00 00       	mov    $0xcdf,%eax
        int len = 0;
 76c:	31 db                	xor    %ebx,%ebx
 76e:	66 90                	xchg   %ax,%ax
        for (char *t = s; *t; t++) len++;
 770:	83 c3 01             	add    $0x1,%ebx
 773:	80 3c 18 00          	cmpb   $0x0,(%eax,%ebx,1)
 777:	75 f7                	jne    770 <printf+0x120>
        for (int j = len; j < width; j++)
 779:	39 cb                	cmp    %ecx,%ebx
 77b:	0f 8d 9c 01 00 00    	jge    91d <printf+0x2cd>
 781:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 784:	8d 75 e7             	lea    -0x19(%ebp),%esi
 787:	89 45 c8             	mov    %eax,-0x38(%ebp)
 78a:	89 7d cc             	mov    %edi,-0x34(%ebp)
 78d:	89 df                	mov    %ebx,%edi
 78f:	89 d3                	mov    %edx,%ebx
 791:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 798:	00 
 799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 7a0:	83 ec 04             	sub    $0x4,%esp
 7a3:	88 5d e7             	mov    %bl,-0x19(%ebp)
        for (int j = len; j < width; j++)
 7a6:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 7a9:	6a 01                	push   $0x1
 7ab:	56                   	push   %esi
 7ac:	6a 01                	push   $0x1
 7ae:	e8 40 fc ff ff       	call   3f3 <write>
        for (int j = len; j < width; j++)
 7b3:	8b 45 d0             	mov    -0x30(%ebp),%eax
 7b6:	83 c4 10             	add    $0x10,%esp
 7b9:	39 c7                	cmp    %eax,%edi
 7bb:	7c e3                	jl     7a0 <printf+0x150>
        while(*s != 0){
 7bd:	8b 45 c8             	mov    -0x38(%ebp),%eax
 7c0:	8b 7d cc             	mov    -0x34(%ebp),%edi
 7c3:	0f b6 08             	movzbl (%eax),%ecx
 7c6:	88 4d d0             	mov    %cl,-0x30(%ebp)
 7c9:	84 c9                	test   %cl,%cl
 7cb:	0f 84 16 ff ff ff    	je     6e7 <printf+0x97>
 7d1:	89 c3                	mov    %eax,%ebx
 7d3:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 7d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7de:	00 
 7df:	90                   	nop
  write(fd, &c, 1);
 7e0:	83 ec 04             	sub    $0x4,%esp
 7e3:	88 45 e7             	mov    %al,-0x19(%ebp)
          putc(1, *s++);
 7e6:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 7e9:	6a 01                	push   $0x1
 7eb:	56                   	push   %esi
 7ec:	6a 01                	push   $0x1
 7ee:	e8 00 fc ff ff       	call   3f3 <write>
        while(*s != 0){
 7f3:	0f b6 03             	movzbl (%ebx),%eax
 7f6:	83 c4 10             	add    $0x10,%esp
 7f9:	84 c0                	test   %al,%al
 7fb:	75 e3                	jne    7e0 <printf+0x190>
 7fd:	e9 e5 fe ff ff       	jmp    6e7 <printf+0x97>
 802:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        char ch = *ap++;
 808:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 80b:	83 ec 04             	sub    $0x4,%esp
 80e:	8d 75 e7             	lea    -0x19(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 811:	83 c7 01             	add    $0x1,%edi
        char ch = *ap++;
 814:	8d 58 04             	lea    0x4(%eax),%ebx
 817:	8b 00                	mov    (%eax),%eax
 819:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 81c:	6a 01                	push   $0x1
 81e:	56                   	push   %esi
 81f:	6a 01                	push   $0x1
 821:	e8 cd fb ff ff       	call   3f3 <write>
  for(i = 0; fmt[i]; i++){
 826:	0f b6 47 ff          	movzbl -0x1(%edi),%eax
 82a:	83 c4 10             	add    $0x10,%esp
 82d:	84 c0                	test   %al,%al
 82f:	0f 84 c0 fe ff ff    	je     6f5 <printf+0xa5>
    c = fmt[i] & 0xff;
 835:	0f b6 d0             	movzbl %al,%edx
        char ch = *ap++;
 838:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      if (c == '\f') {
 83b:	83 fa 0c             	cmp    $0xc,%edx
 83e:	0f 85 38 fe ff ff    	jne    67c <printf+0x2c>
 844:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 84b:	00 
 84c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        setcursor();
 850:	e8 36 fc ff ff       	call   48b <setcursor>
 855:	e9 8d fe ff ff       	jmp    6e7 <printf+0x97>
 85a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 860:	83 f8 30             	cmp    $0x30,%eax
 863:	74 7b                	je     8e0 <printf+0x290>
 865:	7f 49                	jg     8b0 <printf+0x260>
 867:	83 f8 25             	cmp    $0x25,%eax
 86a:	0f 85 50 fe ff ff    	jne    6c0 <printf+0x70>
  write(fd, &c, 1);
 870:	83 ec 04             	sub    $0x4,%esp
 873:	8d 75 e7             	lea    -0x19(%ebp),%esi
 876:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 87a:	6a 01                	push   $0x1
 87c:	56                   	push   %esi
 87d:	6a 01                	push   $0x1
 87f:	e8 6f fb ff ff       	call   3f3 <write>
        state = 0;
 884:	83 c4 10             	add    $0x10,%esp
 887:	e9 5b fe ff ff       	jmp    6e7 <printf+0x97>
 88c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 890:	83 ec 04             	sub    $0x4,%esp
 893:	8d 75 e7             	lea    -0x19(%ebp),%esi
 896:	88 45 e7             	mov    %al,-0x19(%ebp)
 899:	6a 01                	push   $0x1
 89b:	56                   	push   %esi
 89c:	6a 01                	push   $0x1
 89e:	e8 50 fb ff ff       	call   3f3 <write>
  for(i = 0; fmt[i]; i++){
 8a3:	e9 74 fe ff ff       	jmp    71c <printf+0xcc>
 8a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8af:	00 
 8b0:	8d 70 cf             	lea    -0x31(%eax),%esi
 8b3:	83 fe 08             	cmp    $0x8,%esi
 8b6:	0f 87 04 fe ff ff    	ja     6c0 <printf+0x70>
 8bc:	0f b6 1f             	movzbl (%edi),%ebx
        width = width * 10 + (c - '0');
 8bf:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
  for(i = 0; fmt[i]; i++){
 8c2:	83 c7 01             	add    $0x1,%edi
        width = width * 10 + (c - '0');
 8c5:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  for(i = 0; fmt[i]; i++){
 8c9:	84 db                	test   %bl,%bl
 8cb:	0f 84 24 fe ff ff    	je     6f5 <printf+0xa5>
    c = fmt[i] & 0xff;
 8d1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 8d4:	e9 c0 fd ff ff       	jmp    699 <printf+0x49>
 8d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 8e0:	0f b6 1f             	movzbl (%edi),%ebx
 8e3:	83 c7 01             	add    $0x1,%edi
 8e6:	84 db                	test   %bl,%bl
 8e8:	0f 84 07 fe ff ff    	je     6f5 <printf+0xa5>
    c = fmt[i] & 0xff;
 8ee:	0f b6 c3             	movzbl %bl,%eax
 8f1:	ba 30 00 00 00       	mov    $0x30,%edx
 8f6:	e9 9e fd ff ff       	jmp    699 <printf+0x49>
 8fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        for (char *t = s; *t; t++) len++;
 900:	0f b6 18             	movzbl (%eax),%ebx
 903:	88 5d d0             	mov    %bl,-0x30(%ebp)
 906:	84 db                	test   %bl,%bl
 908:	0f 85 5e fe ff ff    	jne    76c <printf+0x11c>
        int len = 0;
 90e:	31 db                	xor    %ebx,%ebx
        for (int j = len; j < width; j++)
 910:	85 c9                	test   %ecx,%ecx
 912:	0f 8f 69 fe ff ff    	jg     781 <printf+0x131>
 918:	e9 ca fd ff ff       	jmp    6e7 <printf+0x97>
 91d:	89 c2                	mov    %eax,%edx
 91f:	8d 75 e7             	lea    -0x19(%ebp),%esi
 922:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 926:	89 d3                	mov    %edx,%ebx
 928:	e9 b3 fe ff ff       	jmp    7e0 <printf+0x190>
 92d:	8d 76 00             	lea    0x0(%esi),%esi

00000930 <fprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
fprintf(int fd, char *fmt, ...)
{
 930:	55                   	push   %ebp
 931:	89 e5                	mov    %esp,%ebp
 933:	57                   	push   %edi
 934:	56                   	push   %esi
 935:	53                   	push   %ebx
 936:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 939:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 93c:	0f b6 13             	movzbl (%ebx),%edx
 93f:	83 c3 01             	add    $0x1,%ebx
 942:	84 d2                	test   %dl,%dl
 944:	0f 84 81 00 00 00    	je     9cb <fprintf+0x9b>
 94a:	8d 75 10             	lea    0x10(%ebp),%esi
 94d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 950:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if (c == '\f') { // Detect formfeed character
 953:	83 f8 0c             	cmp    $0xc,%eax
 956:	0f 84 04 01 00 00    	je     a60 <fprintf+0x130>
        setcursor();
      } else
      if(c == '%'){
 95c:	83 f8 25             	cmp    $0x25,%eax
 95f:	0f 85 5b 01 00 00    	jne    ac0 <fprintf+0x190>
  for(i = 0; fmt[i]; i++){
 965:	0f b6 13             	movzbl (%ebx),%edx
 968:	84 d2                	test   %dl,%dl
 96a:	74 5f                	je     9cb <fprintf+0x9b>
    c = fmt[i] & 0xff;
 96c:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 96f:	80 fa 25             	cmp    $0x25,%dl
 972:	0f 84 78 01 00 00    	je     af0 <fprintf+0x1c0>
 978:	83 e8 63             	sub    $0x63,%eax
 97b:	83 f8 15             	cmp    $0x15,%eax
 97e:	77 10                	ja     990 <fprintf+0x60>
 980:	ff 24 85 40 0d 00 00 	jmp    *0xd40(,%eax,4)
 987:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 98e:	00 
 98f:	90                   	nop
  write(fd, &c, 1);
 990:	83 ec 04             	sub    $0x4,%esp
 993:	8d 7d e7             	lea    -0x19(%ebp),%edi
 996:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 999:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 99d:	6a 01                	push   $0x1
 99f:	57                   	push   %edi
 9a0:	ff 75 08             	push   0x8(%ebp)
 9a3:	e8 4b fa ff ff       	call   3f3 <write>
        putc(fd, c);
 9a8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 9ac:	83 c4 0c             	add    $0xc,%esp
 9af:	88 55 e7             	mov    %dl,-0x19(%ebp)
 9b2:	6a 01                	push   $0x1
 9b4:	57                   	push   %edi
 9b5:	ff 75 08             	push   0x8(%ebp)
 9b8:	e8 36 fa ff ff       	call   3f3 <write>
  for(i = 0; fmt[i]; i++){
 9bd:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 9c1:	83 c3 02             	add    $0x2,%ebx
 9c4:	83 c4 10             	add    $0x10,%esp
 9c7:	84 d2                	test   %dl,%dl
 9c9:	75 85                	jne    950 <fprintf+0x20>
      }
      state = 0;
    }
  }
}
 9cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9ce:	5b                   	pop    %ebx
 9cf:	5e                   	pop    %esi
 9d0:	5f                   	pop    %edi
 9d1:	5d                   	pop    %ebp
 9d2:	c3                   	ret
 9d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(1, *ap, 16, 0, width, pad_char);
 9d8:	83 ec 08             	sub    $0x8,%esp
 9db:	8b 06                	mov    (%esi),%eax
 9dd:	31 c9                	xor    %ecx,%ecx
 9df:	ba 10 00 00 00       	mov    $0x10,%edx
 9e4:	6a 20                	push   $0x20
 9e6:	6a 00                	push   $0x0
 9e8:	e8 d3 fa ff ff       	call   4c0 <printint.constprop.0>
        ap++;
 9ed:	83 c6 04             	add    $0x4,%esi
  for(i = 0; fmt[i]; i++){
 9f0:	eb cb                	jmp    9bd <fprintf+0x8d>
 9f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s = (char*)*ap;
 9f8:	8b 3e                	mov    (%esi),%edi
        ap++;
 9fa:	83 c6 04             	add    $0x4,%esi
        if(s == 0)
 9fd:	85 ff                	test   %edi,%edi
 9ff:	0f 84 fb 00 00 00    	je     b00 <fprintf+0x1d0>
        while(*s != 0){
 a05:	0f b6 07             	movzbl (%edi),%eax
 a08:	84 c0                	test   %al,%al
 a0a:	74 36                	je     a42 <fprintf+0x112>
 a0c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 a0f:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 a12:	8b 75 08             	mov    0x8(%ebp),%esi
 a15:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 a18:	89 fb                	mov    %edi,%ebx
 a1a:	89 cf                	mov    %ecx,%edi
 a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 a20:	83 ec 04             	sub    $0x4,%esp
 a23:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 a26:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 a29:	6a 01                	push   $0x1
 a2b:	57                   	push   %edi
 a2c:	56                   	push   %esi
 a2d:	e8 c1 f9 ff ff       	call   3f3 <write>
        while(*s != 0){
 a32:	0f b6 03             	movzbl (%ebx),%eax
 a35:	83 c4 10             	add    $0x10,%esp
 a38:	84 c0                	test   %al,%al
 a3a:	75 e4                	jne    a20 <fprintf+0xf0>
 a3c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 a3f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 a42:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 a46:	83 c3 02             	add    $0x2,%ebx
 a49:	84 d2                	test   %dl,%dl
 a4b:	0f 84 7a ff ff ff    	je     9cb <fprintf+0x9b>
    c = fmt[i] & 0xff;
 a51:	0f b6 c2             	movzbl %dl,%eax
      if (c == '\f') { // Detect formfeed character
 a54:	83 f8 0c             	cmp    $0xc,%eax
 a57:	0f 85 ff fe ff ff    	jne    95c <fprintf+0x2c>
 a5d:	8d 76 00             	lea    0x0(%esi),%esi
        setcursor();
 a60:	e8 26 fa ff ff       	call   48b <setcursor>
  for(i = 0; fmt[i]; i++){
 a65:	0f b6 13             	movzbl (%ebx),%edx
 a68:	83 c3 01             	add    $0x1,%ebx
 a6b:	84 d2                	test   %dl,%dl
 a6d:	0f 85 dd fe ff ff    	jne    950 <fprintf+0x20>
 a73:	e9 53 ff ff ff       	jmp    9cb <fprintf+0x9b>
 a78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a7f:	00 
        printint(1, *ap, 10, 1, width, pad_char);
 a80:	83 ec 08             	sub    $0x8,%esp
 a83:	8b 06                	mov    (%esi),%eax
 a85:	b9 01 00 00 00       	mov    $0x1,%ecx
 a8a:	ba 0a 00 00 00       	mov    $0xa,%edx
 a8f:	6a 20                	push   $0x20
 a91:	6a 00                	push   $0x0
 a93:	e9 50 ff ff ff       	jmp    9e8 <fprintf+0xb8>
 a98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a9f:	00 
        putc(fd, *ap);
 aa0:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
 aa2:	83 ec 04             	sub    $0x4,%esp
 aa5:	8d 7d e7             	lea    -0x19(%ebp),%edi
        putc(fd, *ap);
 aa8:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 aab:	6a 01                	push   $0x1
 aad:	57                   	push   %edi
 aae:	ff 75 08             	push   0x8(%ebp)
 ab1:	e8 3d f9 ff ff       	call   3f3 <write>
 ab6:	e9 32 ff ff ff       	jmp    9ed <fprintf+0xbd>
 abb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 ac0:	83 ec 04             	sub    $0x4,%esp
 ac3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 ac6:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 ac9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 acc:	6a 01                	push   $0x1
 ace:	50                   	push   %eax
 acf:	ff 75 08             	push   0x8(%ebp)
 ad2:	e8 1c f9 ff ff       	call   3f3 <write>
  for(i = 0; fmt[i]; i++){
 ad7:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 adb:	83 c4 10             	add    $0x10,%esp
 ade:	84 d2                	test   %dl,%dl
 ae0:	0f 85 6a fe ff ff    	jne    950 <fprintf+0x20>
}
 ae6:	8d 65 f4             	lea    -0xc(%ebp),%esp
 ae9:	5b                   	pop    %ebx
 aea:	5e                   	pop    %esi
 aeb:	5f                   	pop    %edi
 aec:	5d                   	pop    %ebp
 aed:	c3                   	ret
 aee:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 af0:	83 ec 04             	sub    $0x4,%esp
 af3:	88 55 e7             	mov    %dl,-0x19(%ebp)
 af6:	8d 7d e7             	lea    -0x19(%ebp),%edi
 af9:	6a 01                	push   $0x1
 afb:	e9 b4 fe ff ff       	jmp    9b4 <fprintf+0x84>
          s = "(null)";
 b00:	bf df 0c 00 00       	mov    $0xcdf,%edi
 b05:	b8 28 00 00 00       	mov    $0x28,%eax
 b0a:	e9 fd fe ff ff       	jmp    a0c <fprintf+0xdc>
 b0f:	66 90                	xchg   %ax,%ax
 b11:	66 90                	xchg   %ax,%ax
 b13:	66 90                	xchg   %ax,%ax
 b15:	66 90                	xchg   %ax,%ax
 b17:	66 90                	xchg   %ax,%ax
 b19:	66 90                	xchg   %ax,%ax
 b1b:	66 90                	xchg   %ax,%ax
 b1d:	66 90                	xchg   %ax,%ax
 b1f:	90                   	nop

00000b20 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b20:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b21:	a1 00 13 00 00       	mov    0x1300,%eax
{
 b26:	89 e5                	mov    %esp,%ebp
 b28:	57                   	push   %edi
 b29:	56                   	push   %esi
 b2a:	53                   	push   %ebx
 b2b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 b2e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b31:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 b38:	00 
 b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 b40:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b42:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b44:	39 ca                	cmp    %ecx,%edx
 b46:	73 30                	jae    b78 <free+0x58>
 b48:	39 c1                	cmp    %eax,%ecx
 b4a:	72 04                	jb     b50 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b4c:	39 c2                	cmp    %eax,%edx
 b4e:	72 f0                	jb     b40 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b50:	8b 73 fc             	mov    -0x4(%ebx),%esi
 b53:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 b56:	39 f8                	cmp    %edi,%eax
 b58:	74 36                	je     b90 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 b5a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 b5d:	8b 42 04             	mov    0x4(%edx),%eax
 b60:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 b63:	39 f1                	cmp    %esi,%ecx
 b65:	74 40                	je     ba7 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 b67:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 b69:	5b                   	pop    %ebx
  freep = p;
 b6a:	89 15 00 13 00 00    	mov    %edx,0x1300
}
 b70:	5e                   	pop    %esi
 b71:	5f                   	pop    %edi
 b72:	5d                   	pop    %ebp
 b73:	c3                   	ret
 b74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b78:	39 c2                	cmp    %eax,%edx
 b7a:	72 c4                	jb     b40 <free+0x20>
 b7c:	39 c1                	cmp    %eax,%ecx
 b7e:	73 c0                	jae    b40 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 b80:	8b 73 fc             	mov    -0x4(%ebx),%esi
 b83:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 b86:	39 f8                	cmp    %edi,%eax
 b88:	75 d0                	jne    b5a <free+0x3a>
 b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 b90:	03 70 04             	add    0x4(%eax),%esi
 b93:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 b96:	8b 02                	mov    (%edx),%eax
 b98:	8b 00                	mov    (%eax),%eax
 b9a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 b9d:	8b 42 04             	mov    0x4(%edx),%eax
 ba0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 ba3:	39 f1                	cmp    %esi,%ecx
 ba5:	75 c0                	jne    b67 <free+0x47>
    p->s.size += bp->s.size;
 ba7:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 baa:	89 15 00 13 00 00    	mov    %edx,0x1300
    p->s.size += bp->s.size;
 bb0:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 bb3:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 bb6:	89 0a                	mov    %ecx,(%edx)
}
 bb8:	5b                   	pop    %ebx
 bb9:	5e                   	pop    %esi
 bba:	5f                   	pop    %edi
 bbb:	5d                   	pop    %ebp
 bbc:	c3                   	ret
 bbd:	8d 76 00             	lea    0x0(%esi),%esi

00000bc0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 bc0:	55                   	push   %ebp
 bc1:	89 e5                	mov    %esp,%ebp
 bc3:	57                   	push   %edi
 bc4:	56                   	push   %esi
 bc5:	53                   	push   %ebx
 bc6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bc9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 bcc:	8b 15 00 13 00 00    	mov    0x1300,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bd2:	8d 78 07             	lea    0x7(%eax),%edi
 bd5:	c1 ef 03             	shr    $0x3,%edi
 bd8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 bdb:	85 d2                	test   %edx,%edx
 bdd:	0f 84 8d 00 00 00    	je     c70 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 be3:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 be5:	8b 48 04             	mov    0x4(%eax),%ecx
 be8:	39 f9                	cmp    %edi,%ecx
 bea:	73 64                	jae    c50 <malloc+0x90>
  if(nu < 4096)
 bec:	bb 00 10 00 00       	mov    $0x1000,%ebx
 bf1:	39 df                	cmp    %ebx,%edi
 bf3:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 bf6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 bfd:	eb 0a                	jmp    c09 <malloc+0x49>
 bff:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c00:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 c02:	8b 48 04             	mov    0x4(%eax),%ecx
 c05:	39 f9                	cmp    %edi,%ecx
 c07:	73 47                	jae    c50 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c09:	89 c2                	mov    %eax,%edx
 c0b:	39 05 00 13 00 00    	cmp    %eax,0x1300
 c11:	75 ed                	jne    c00 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 c13:	83 ec 0c             	sub    $0xc,%esp
 c16:	56                   	push   %esi
 c17:	e8 3f f8 ff ff       	call   45b <sbrk>
  if(p == (char*)-1)
 c1c:	83 c4 10             	add    $0x10,%esp
 c1f:	83 f8 ff             	cmp    $0xffffffff,%eax
 c22:	74 1c                	je     c40 <malloc+0x80>
  hp->s.size = nu;
 c24:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 c27:	83 ec 0c             	sub    $0xc,%esp
 c2a:	83 c0 08             	add    $0x8,%eax
 c2d:	50                   	push   %eax
 c2e:	e8 ed fe ff ff       	call   b20 <free>
  return freep;
 c33:	8b 15 00 13 00 00    	mov    0x1300,%edx
      if((p = morecore(nunits)) == 0)
 c39:	83 c4 10             	add    $0x10,%esp
 c3c:	85 d2                	test   %edx,%edx
 c3e:	75 c0                	jne    c00 <malloc+0x40>
        return 0;
  }
}
 c40:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 c43:	31 c0                	xor    %eax,%eax
}
 c45:	5b                   	pop    %ebx
 c46:	5e                   	pop    %esi
 c47:	5f                   	pop    %edi
 c48:	5d                   	pop    %ebp
 c49:	c3                   	ret
 c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 c50:	39 cf                	cmp    %ecx,%edi
 c52:	74 4c                	je     ca0 <malloc+0xe0>
        p->s.size -= nunits;
 c54:	29 f9                	sub    %edi,%ecx
 c56:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 c59:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 c5c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 c5f:	89 15 00 13 00 00    	mov    %edx,0x1300
}
 c65:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 c68:	83 c0 08             	add    $0x8,%eax
}
 c6b:	5b                   	pop    %ebx
 c6c:	5e                   	pop    %esi
 c6d:	5f                   	pop    %edi
 c6e:	5d                   	pop    %ebp
 c6f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 c70:	c7 05 00 13 00 00 04 	movl   $0x1304,0x1300
 c77:	13 00 00 
    base.s.size = 0;
 c7a:	b8 04 13 00 00       	mov    $0x1304,%eax
    base.s.ptr = freep = prevp = &base;
 c7f:	c7 05 04 13 00 00 04 	movl   $0x1304,0x1304
 c86:	13 00 00 
    base.s.size = 0;
 c89:	c7 05 08 13 00 00 00 	movl   $0x0,0x1308
 c90:	00 00 00 
    if(p->s.size >= nunits){
 c93:	e9 54 ff ff ff       	jmp    bec <malloc+0x2c>
 c98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 c9f:	00 
        prevp->s.ptr = p->s.ptr;
 ca0:	8b 08                	mov    (%eax),%ecx
 ca2:	89 0a                	mov    %ecx,(%edx)
 ca4:	eb b9                	jmp    c5f <malloc+0x9f>
