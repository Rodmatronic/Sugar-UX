
_date:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

  return months[m - 1];
}

int
main(void ) {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
  struct rtcdate r;
  if (gettime(&r) == 0) {
   f:	8d 45 d0             	lea    -0x30(%ebp),%eax
main(void ) {
  12:	53                   	push   %ebx
  13:	51                   	push   %ecx
  14:	83 ec 44             	sub    $0x44,%esp
  if (gettime(&r) == 0) {
  17:	50                   	push   %eax
  18:	e8 26 04 00 00       	call   443 <gettime>
  1d:	83 c4 10             	add    $0x10,%esp
  20:	85 c0                	test   %eax,%eax
  22:	75 52                	jne    76 <main+0x76>
    printf("%s %s %02d %02d:%02d:%02d UTC %02d\n",
  24:	8b 45 d8             	mov    -0x28(%ebp),%eax
  27:	8b 75 e4             	mov    -0x1c(%ebp),%esi
  2a:	8b 4d d0             	mov    -0x30(%ebp),%ecx
  2d:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  30:	89 45 c4             	mov    %eax,-0x3c(%ebp)
           get_weekday(r.year, r.month, r.day),
           monthname(r.month),
  33:	8b 45 e0             	mov    -0x20(%ebp),%eax
    printf("%s %s %02d %02d:%02d:%02d UTC %02d\n",
  36:	8b 5d dc             	mov    -0x24(%ebp),%ebx
  if (m < 1 || m > 12)
  39:	8d 78 ff             	lea    -0x1(%eax),%edi
  3c:	83 ff 0b             	cmp    $0xb,%edi
  3f:	77 3a                	ja     7b <main+0x7b>
  return months[m - 1];
  41:	8b 3c bd 20 0d 00 00 	mov    0xd20(,%edi,4),%edi
  48:	89 55 bc             	mov    %edx,-0x44(%ebp)
    printf("%s %s %02d %02d:%02d:%02d UTC %02d\n",
  4b:	52                   	push   %edx
  4c:	53                   	push   %ebx
  4d:	50                   	push   %eax
  4e:	56                   	push   %esi
  4f:	89 4d c0             	mov    %ecx,-0x40(%ebp)
  52:	e8 39 00 00 00       	call   90 <get_weekday>
  57:	8b 4d c0             	mov    -0x40(%ebp),%ecx
  5a:	8b 55 bc             	mov    -0x44(%ebp),%edx
  5d:	83 c4 10             	add    $0x10,%esp
  60:	56                   	push   %esi
  61:	51                   	push   %ecx
  62:	52                   	push   %edx
  63:	ff 75 c4             	push   -0x3c(%ebp)
  66:	53                   	push   %ebx
  67:	57                   	push   %edi
  68:	50                   	push   %eax
  69:	68 e0 0c 00 00       	push   $0xce0
  6e:	e8 9d 05 00 00       	call   610 <printf>
  73:	83 c4 20             	add    $0x20,%esp
           r.hour,
           r.minute,
           r.second,
           r.year);
  }
  exit();
  76:	e8 18 03 00 00       	call   393 <exit>
    return "???";
  7b:	bf 80 0c 00 00       	mov    $0xc80,%edi
  80:	eb c6                	jmp    48 <main+0x48>
  82:	66 90                	xchg   %ax,%ax
  84:	66 90                	xchg   %ax,%ax
  86:	66 90                	xchg   %ax,%ax
  88:	66 90                	xchg   %ax,%ax
  8a:	66 90                	xchg   %ax,%ax
  8c:	66 90                	xchg   %ax,%ax
  8e:	66 90                	xchg   %ax,%ax

00000090 <get_weekday>:
char* get_weekday(int y, int m, int d) {
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	57                   	push   %edi
  94:	56                   	push   %esi
  95:	8b 75 0c             	mov    0xc(%ebp),%esi
  98:	53                   	push   %ebx
  99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (m < 3) {
  9c:	83 fe 02             	cmp    $0x2,%esi
  9f:	7f 06                	jg     a7 <get_weekday+0x17>
    m += 12;
  a1:	83 c6 0c             	add    $0xc,%esi
    y -= 1;
  a4:	83 eb 01             	sub    $0x1,%ebx
  int h = (d + 2*m + 3*(m+1)/5 + y + y/4 - y/100 + y/400) % 7;
  a7:	8d 7c 76 03          	lea    0x3(%esi,%esi,2),%edi
  ab:	b8 67 66 66 66       	mov    $0x66666667,%eax
  b0:	f7 ef                	imul   %edi
  b2:	8b 45 10             	mov    0x10(%ebp),%eax
  b5:	c1 ff 1f             	sar    $0x1f,%edi
  b8:	8d 04 70             	lea    (%eax,%esi,2),%eax
  bb:	d1 fa                	sar    $1,%edx
  bd:	29 fa                	sub    %edi,%edx
  bf:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  c2:	8d 43 03             	lea    0x3(%ebx),%eax
  c5:	01 d9                	add    %ebx,%ecx
  c7:	85 db                	test   %ebx,%ebx
  c9:	0f 49 c3             	cmovns %ebx,%eax
  cc:	c1 f8 02             	sar    $0x2,%eax
  cf:	01 c1                	add    %eax,%ecx
  d1:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
  d6:	f7 eb                	imul   %ebx
  d8:	c1 fb 1f             	sar    $0x1f,%ebx
  db:	89 d8                	mov    %ebx,%eax
  dd:	89 d6                	mov    %edx,%esi
  df:	c1 fa 07             	sar    $0x7,%edx
  e2:	c1 fe 05             	sar    $0x5,%esi
  e5:	29 da                	sub    %ebx,%edx
}
  e7:	5b                   	pop    %ebx
  int h = (d + 2*m + 3*(m+1)/5 + y + y/4 - y/100 + y/400) % 7;
  e8:	29 f0                	sub    %esi,%eax
}
  ea:	5e                   	pop    %esi
  eb:	5f                   	pop    %edi
  int h = (d + 2*m + 3*(m+1)/5 + y + y/4 - y/100 + y/400) % 7;
  ec:	01 c1                	add    %eax,%ecx
  ee:	b8 93 24 49 92       	mov    $0x92492493,%eax
}
  f3:	5d                   	pop    %ebp
  int h = (d + 2*m + 3*(m+1)/5 + y + y/4 - y/100 + y/400) % 7;
  f4:	01 d1                	add    %edx,%ecx
  f6:	f7 e9                	imul   %ecx
  f8:	89 c8                	mov    %ecx,%eax
  fa:	c1 f8 1f             	sar    $0x1f,%eax
  fd:	01 ca                	add    %ecx,%edx
  ff:	c1 fa 02             	sar    $0x2,%edx
 102:	29 c2                	sub    %eax,%edx
 104:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
 10b:	29 d0                	sub    %edx,%eax
 10d:	29 c1                	sub    %eax,%ecx
  return days[h];
 10f:	8b 04 8d 50 0d 00 00 	mov    0xd50(,%ecx,4),%eax
}
 116:	c3                   	ret
 117:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 11e:	00 
 11f:	90                   	nop

00000120 <monthname>:
char* monthname(int m) {
 120:	55                   	push   %ebp
 121:	ba 80 0c 00 00       	mov    $0xc80,%edx
 126:	89 e5                	mov    %esp,%ebp
  if (m < 1 || m > 12)
 128:	8b 45 08             	mov    0x8(%ebp),%eax
 12b:	83 e8 01             	sub    $0x1,%eax
 12e:	83 f8 0b             	cmp    $0xb,%eax
 131:	77 07                	ja     13a <monthname+0x1a>
  return months[m - 1];
 133:	8b 14 85 20 0d 00 00 	mov    0xd20(,%eax,4),%edx
}
 13a:	89 d0                	mov    %edx,%eax
 13c:	5d                   	pop    %ebp
 13d:	c3                   	ret
 13e:	66 90                	xchg   %ax,%ax

00000140 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 140:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 141:	31 c0                	xor    %eax,%eax
{
 143:	89 e5                	mov    %esp,%ebp
 145:	53                   	push   %ebx
 146:	8b 4d 08             	mov    0x8(%ebp),%ecx
 149:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 150:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 154:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 157:	83 c0 01             	add    $0x1,%eax
 15a:	84 d2                	test   %dl,%dl
 15c:	75 f2                	jne    150 <strcpy+0x10>
    ;
  return os;
}
 15e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 161:	89 c8                	mov    %ecx,%eax
 163:	c9                   	leave
 164:	c3                   	ret
 165:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 16c:	00 
 16d:	8d 76 00             	lea    0x0(%esi),%esi

00000170 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	53                   	push   %ebx
 174:	8b 55 08             	mov    0x8(%ebp),%edx
 177:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 17a:	0f b6 02             	movzbl (%edx),%eax
 17d:	84 c0                	test   %al,%al
 17f:	75 2f                	jne    1b0 <strcmp+0x40>
 181:	eb 4a                	jmp    1cd <strcmp+0x5d>
 183:	eb 1b                	jmp    1a0 <strcmp+0x30>
 185:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 18c:	00 
 18d:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 194:	00 
 195:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 19c:	00 
 19d:	8d 76 00             	lea    0x0(%esi),%esi
 1a0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 1a4:	83 c2 01             	add    $0x1,%edx
 1a7:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 1aa:	84 c0                	test   %al,%al
 1ac:	74 12                	je     1c0 <strcmp+0x50>
 1ae:	89 d9                	mov    %ebx,%ecx
 1b0:	0f b6 19             	movzbl (%ecx),%ebx
 1b3:	38 c3                	cmp    %al,%bl
 1b5:	74 e9                	je     1a0 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 1b7:	29 d8                	sub    %ebx,%eax
}
 1b9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1bc:	c9                   	leave
 1bd:	c3                   	ret
 1be:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 1c0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 1c4:	31 c0                	xor    %eax,%eax
 1c6:	29 d8                	sub    %ebx,%eax
}
 1c8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1cb:	c9                   	leave
 1cc:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 1cd:	0f b6 19             	movzbl (%ecx),%ebx
 1d0:	31 c0                	xor    %eax,%eax
 1d2:	eb e3                	jmp    1b7 <strcmp+0x47>
 1d4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1db:	00 
 1dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001e0 <strlen>:

uint
strlen(char *s)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1e6:	80 3a 00             	cmpb   $0x0,(%edx)
 1e9:	74 15                	je     200 <strlen+0x20>
 1eb:	31 c0                	xor    %eax,%eax
 1ed:	8d 76 00             	lea    0x0(%esi),%esi
 1f0:	83 c0 01             	add    $0x1,%eax
 1f3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1f7:	89 c1                	mov    %eax,%ecx
 1f9:	75 f5                	jne    1f0 <strlen+0x10>
    ;
  return n;
}
 1fb:	89 c8                	mov    %ecx,%eax
 1fd:	5d                   	pop    %ebp
 1fe:	c3                   	ret
 1ff:	90                   	nop
  for(n = 0; s[n]; n++)
 200:	31 c9                	xor    %ecx,%ecx
}
 202:	5d                   	pop    %ebp
 203:	89 c8                	mov    %ecx,%eax
 205:	c3                   	ret
 206:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 20d:	00 
 20e:	66 90                	xchg   %ax,%ax

00000210 <memset>:

void*
memset(void *dst, int c, uint n)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	57                   	push   %edi
 214:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 217:	8b 4d 10             	mov    0x10(%ebp),%ecx
 21a:	8b 45 0c             	mov    0xc(%ebp),%eax
 21d:	89 d7                	mov    %edx,%edi
 21f:	fc                   	cld
 220:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 222:	8b 7d fc             	mov    -0x4(%ebp),%edi
 225:	89 d0                	mov    %edx,%eax
 227:	c9                   	leave
 228:	c3                   	ret
 229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000230 <strchr>:

char*
strchr(const char *s, char c)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	8b 45 08             	mov    0x8(%ebp),%eax
 236:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 23a:	0f b6 10             	movzbl (%eax),%edx
 23d:	84 d2                	test   %dl,%dl
 23f:	75 1a                	jne    25b <strchr+0x2b>
 241:	eb 25                	jmp    268 <strchr+0x38>
 243:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 24a:	00 
 24b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 250:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 254:	83 c0 01             	add    $0x1,%eax
 257:	84 d2                	test   %dl,%dl
 259:	74 0d                	je     268 <strchr+0x38>
    if(*s == c)
 25b:	38 d1                	cmp    %dl,%cl
 25d:	75 f1                	jne    250 <strchr+0x20>
      return (char*)s;
  return 0;
}
 25f:	5d                   	pop    %ebp
 260:	c3                   	ret
 261:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 268:	31 c0                	xor    %eax,%eax
}
 26a:	5d                   	pop    %ebp
 26b:	c3                   	ret
 26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000270 <gets>:

char*
gets(char *buf, int max)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	57                   	push   %edi
 274:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 275:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 278:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 279:	31 db                	xor    %ebx,%ebx
{
 27b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 27e:	eb 27                	jmp    2a7 <gets+0x37>
    cc = read(0, &c, 1);
 280:	83 ec 04             	sub    $0x4,%esp
 283:	6a 01                	push   $0x1
 285:	56                   	push   %esi
 286:	6a 00                	push   $0x0
 288:	e8 1e 01 00 00       	call   3ab <read>
    if(cc < 1)
 28d:	83 c4 10             	add    $0x10,%esp
 290:	85 c0                	test   %eax,%eax
 292:	7e 1d                	jle    2b1 <gets+0x41>
      break;
    buf[i++] = c;
 294:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 298:	8b 55 08             	mov    0x8(%ebp),%edx
 29b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 29f:	3c 0a                	cmp    $0xa,%al
 2a1:	74 10                	je     2b3 <gets+0x43>
 2a3:	3c 0d                	cmp    $0xd,%al
 2a5:	74 0c                	je     2b3 <gets+0x43>
  for(i=0; i+1 < max; ){
 2a7:	89 df                	mov    %ebx,%edi
 2a9:	83 c3 01             	add    $0x1,%ebx
 2ac:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2af:	7c cf                	jl     280 <gets+0x10>
 2b1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 2b3:	8b 45 08             	mov    0x8(%ebp),%eax
 2b6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 2ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2bd:	5b                   	pop    %ebx
 2be:	5e                   	pop    %esi
 2bf:	5f                   	pop    %edi
 2c0:	5d                   	pop    %ebp
 2c1:	c3                   	ret
 2c2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2c9:	00 
 2ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002d0 <stat>:

int
stat(char *n, struct stat *st)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	56                   	push   %esi
 2d4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d5:	83 ec 08             	sub    $0x8,%esp
 2d8:	6a 00                	push   $0x0
 2da:	ff 75 08             	push   0x8(%ebp)
 2dd:	e8 f1 00 00 00       	call   3d3 <open>
  if(fd < 0)
 2e2:	83 c4 10             	add    $0x10,%esp
 2e5:	85 c0                	test   %eax,%eax
 2e7:	78 27                	js     310 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2e9:	83 ec 08             	sub    $0x8,%esp
 2ec:	ff 75 0c             	push   0xc(%ebp)
 2ef:	89 c3                	mov    %eax,%ebx
 2f1:	50                   	push   %eax
 2f2:	e8 f4 00 00 00       	call   3eb <fstat>
  close(fd);
 2f7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2fa:	89 c6                	mov    %eax,%esi
  close(fd);
 2fc:	e8 ba 00 00 00       	call   3bb <close>
  return r;
 301:	83 c4 10             	add    $0x10,%esp
}
 304:	8d 65 f8             	lea    -0x8(%ebp),%esp
 307:	89 f0                	mov    %esi,%eax
 309:	5b                   	pop    %ebx
 30a:	5e                   	pop    %esi
 30b:	5d                   	pop    %ebp
 30c:	c3                   	ret
 30d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 310:	be ff ff ff ff       	mov    $0xffffffff,%esi
 315:	eb ed                	jmp    304 <stat+0x34>
 317:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 31e:	00 
 31f:	90                   	nop

00000320 <atoi>:

int
atoi(const char *s)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	53                   	push   %ebx
 324:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 327:	0f be 02             	movsbl (%edx),%eax
 32a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 32d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 330:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 335:	77 1e                	ja     355 <atoi+0x35>
 337:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 33e:	00 
 33f:	90                   	nop
    n = n*10 + *s++ - '0';
 340:	83 c2 01             	add    $0x1,%edx
 343:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 346:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 34a:	0f be 02             	movsbl (%edx),%eax
 34d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 350:	80 fb 09             	cmp    $0x9,%bl
 353:	76 eb                	jbe    340 <atoi+0x20>
  return n;
}
 355:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 358:	89 c8                	mov    %ecx,%eax
 35a:	c9                   	leave
 35b:	c3                   	ret
 35c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000360 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	8b 45 10             	mov    0x10(%ebp),%eax
 367:	8b 55 08             	mov    0x8(%ebp),%edx
 36a:	56                   	push   %esi
 36b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 36e:	85 c0                	test   %eax,%eax
 370:	7e 13                	jle    385 <memmove+0x25>
 372:	01 d0                	add    %edx,%eax
  dst = vdst;
 374:	89 d7                	mov    %edx,%edi
 376:	66 90                	xchg   %ax,%ax
 378:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 37f:	00 
    *dst++ = *src++;
 380:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 381:	39 f8                	cmp    %edi,%eax
 383:	75 fb                	jne    380 <memmove+0x20>
  return vdst;
}
 385:	5e                   	pop    %esi
 386:	89 d0                	mov    %edx,%eax
 388:	5f                   	pop    %edi
 389:	5d                   	pop    %ebp
 38a:	c3                   	ret

0000038b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 38b:	b8 01 00 00 00       	mov    $0x1,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <exit>:
SYSCALL(exit)
 393:	b8 02 00 00 00       	mov    $0x2,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <wait>:
SYSCALL(wait)
 39b:	b8 03 00 00 00       	mov    $0x3,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <pipe>:
SYSCALL(pipe)
 3a3:	b8 04 00 00 00       	mov    $0x4,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <read>:
SYSCALL(read)
 3ab:	b8 05 00 00 00       	mov    $0x5,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <write>:
SYSCALL(write)
 3b3:	b8 10 00 00 00       	mov    $0x10,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

000003bb <close>:
SYSCALL(close)
 3bb:	b8 15 00 00 00       	mov    $0x15,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <kill>:
SYSCALL(kill)
 3c3:	b8 06 00 00 00       	mov    $0x6,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

000003cb <exec>:
SYSCALL(exec)
 3cb:	b8 07 00 00 00       	mov    $0x7,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <open>:
SYSCALL(open)
 3d3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <mknod>:
SYSCALL(mknod)
 3db:	b8 11 00 00 00       	mov    $0x11,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

000003e3 <unlink>:
SYSCALL(unlink)
 3e3:	b8 12 00 00 00       	mov    $0x12,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

000003eb <fstat>:
SYSCALL(fstat)
 3eb:	b8 08 00 00 00       	mov    $0x8,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <link>:
SYSCALL(link)
 3f3:	b8 13 00 00 00       	mov    $0x13,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <mkdir>:
SYSCALL(mkdir)
 3fb:	b8 14 00 00 00       	mov    $0x14,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <chdir>:
SYSCALL(chdir)
 403:	b8 09 00 00 00       	mov    $0x9,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

0000040b <dup>:
SYSCALL(dup)
 40b:	b8 0a 00 00 00       	mov    $0xa,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret

00000413 <getpid>:
SYSCALL(getpid)
 413:	b8 0b 00 00 00       	mov    $0xb,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

0000041b <sbrk>:
SYSCALL(sbrk)
 41b:	b8 0c 00 00 00       	mov    $0xc,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

00000423 <sleep>:
SYSCALL(sleep)
 423:	b8 0d 00 00 00       	mov    $0xd,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

0000042b <uptime>:
SYSCALL(uptime)
 42b:	b8 0e 00 00 00       	mov    $0xe,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

00000433 <bstat>:
SYSCALL(bstat)
 433:	b8 16 00 00 00       	mov    $0x16,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret

0000043b <swap>:
SYSCALL(swap)
 43b:	b8 17 00 00 00       	mov    $0x17,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret

00000443 <gettime>:
SYSCALL(gettime)
 443:	b8 18 00 00 00       	mov    $0x18,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret

0000044b <setcursor>:
SYSCALL(setcursor)
 44b:	b8 19 00 00 00       	mov    $0x19,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret

00000453 <uname>:
SYSCALL(uname)
 453:	b8 1a 00 00 00       	mov    $0x1a,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret

0000045b <echo>:
SYSCALL(echo)
 45b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret
 463:	66 90                	xchg   %ax,%ax
 465:	66 90                	xchg   %ax,%ax
 467:	66 90                	xchg   %ax,%ax
 469:	66 90                	xchg   %ax,%ax
 46b:	66 90                	xchg   %ax,%ax
 46d:	66 90                	xchg   %ax,%ax
 46f:	66 90                	xchg   %ax,%ax
 471:	66 90                	xchg   %ax,%ax
 473:	66 90                	xchg   %ax,%ax
 475:	66 90                	xchg   %ax,%ax
 477:	66 90                	xchg   %ax,%ax
 479:	66 90                	xchg   %ax,%ax
 47b:	66 90                	xchg   %ax,%ax
 47d:	66 90                	xchg   %ax,%ax
 47f:	90                   	nop

00000480 <printint.constprop.0>:
{
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn, int width, char pad_char)
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
 485:	89 c6                	mov    %eax,%esi
 487:	53                   	push   %ebx
 488:	89 d3                	mov    %edx,%ebx
 48a:	83 ec 3c             	sub    $0x3c,%esp
 48d:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 491:	85 f6                	test   %esi,%esi
 493:	0f 89 d7 00 00 00    	jns    570 <printint.constprop.0+0xf0>
 499:	83 e1 01             	and    $0x1,%ecx
 49c:	0f 84 ce 00 00 00    	je     570 <printint.constprop.0+0xf0>
    neg = 1;
 4a2:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 4a9:	f7 de                	neg    %esi
 4ab:	89 f1                	mov    %esi,%ecx
  } else {
    x = xx;
  }

  i = 0;
 4ad:	88 45 bf             	mov    %al,-0x41(%ebp)
 4b0:	31 ff                	xor    %edi,%edi
 4b2:	8d 75 d7             	lea    -0x29(%ebp),%esi
 4b5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4bc:	00 
 4bd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4c0:	89 c8                	mov    %ecx,%eax
 4c2:	31 d2                	xor    %edx,%edx
 4c4:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 4c7:	83 c7 01             	add    $0x1,%edi
 4ca:	f7 f3                	div    %ebx
 4cc:	0f b6 92 1c 0e 00 00 	movzbl 0xe1c(%edx),%edx
 4d3:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 4d6:	89 ca                	mov    %ecx,%edx
 4d8:	89 c1                	mov    %eax,%ecx
 4da:	39 da                	cmp    %ebx,%edx
 4dc:	73 e2                	jae    4c0 <printint.constprop.0+0x40>

  if(neg)
 4de:	8b 55 c0             	mov    -0x40(%ebp),%edx
 4e1:	0f b6 45 bf          	movzbl -0x41(%ebp),%eax
 4e5:	85 d2                	test   %edx,%edx
 4e7:	74 0b                	je     4f4 <printint.constprop.0+0x74>
    buf[i++] = '-';
 4e9:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
 4ec:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 4f1:	8d 79 02             	lea    0x2(%ecx),%edi

  // Pad with pad_char until we hit the required width
  while(i < width)
 4f4:	39 7d 08             	cmp    %edi,0x8(%ebp)
 4f7:	0f 8e 83 00 00 00    	jle    580 <printint.constprop.0+0x100>
 4fd:	8b 55 08             	mov    0x8(%ebp),%edx
 500:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 503:	01 df                	add    %ebx,%edi
 505:	01 da                	add    %ebx,%edx
 507:	89 d1                	mov    %edx,%ecx
 509:	29 f9                	sub    %edi,%ecx
 50b:	83 e1 01             	and    $0x1,%ecx
 50e:	74 10                	je     520 <printint.constprop.0+0xa0>
    buf[i++] = pad_char;
 510:	88 07                	mov    %al,(%edi)
  while(i < width)
 512:	83 c7 01             	add    $0x1,%edi
 515:	39 d7                	cmp    %edx,%edi
 517:	74 13                	je     52c <printint.constprop.0+0xac>
 519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = pad_char;
 520:	88 07                	mov    %al,(%edi)
  while(i < width)
 522:	83 c7 02             	add    $0x2,%edi
    buf[i++] = pad_char;
 525:	88 47 ff             	mov    %al,-0x1(%edi)
  while(i < width)
 528:	39 d7                	cmp    %edx,%edi
 52a:	75 f4                	jne    520 <printint.constprop.0+0xa0>
 52c:	8b 45 08             	mov    0x8(%ebp),%eax
 52f:	8d 78 ff             	lea    -0x1(%eax),%edi

  while(--i >= 0)
 532:	01 df                	add    %ebx,%edi
 534:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 53b:	00 
 53c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 540:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 543:	83 ec 04             	sub    $0x4,%esp
 546:	88 45 d7             	mov    %al,-0x29(%ebp)
 549:	6a 01                	push   $0x1
 54b:	56                   	push   %esi
 54c:	6a 01                	push   $0x1
 54e:	e8 60 fe ff ff       	call   3b3 <write>
  while(--i >= 0)
 553:	89 f8                	mov    %edi,%eax
 555:	83 c4 10             	add    $0x10,%esp
 558:	83 ef 01             	sub    $0x1,%edi
 55b:	39 d8                	cmp    %ebx,%eax
 55d:	75 e1                	jne    540 <printint.constprop.0+0xc0>
}
 55f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 562:	5b                   	pop    %ebx
 563:	5e                   	pop    %esi
 564:	5f                   	pop    %edi
 565:	5d                   	pop    %ebp
 566:	c3                   	ret
 567:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 56e:	00 
 56f:	90                   	nop
  neg = 0;
 570:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = xx;
 577:	89 f1                	mov    %esi,%ecx
 579:	e9 2f ff ff ff       	jmp    4ad <printint.constprop.0+0x2d>
 57e:	66 90                	xchg   %ax,%ax
  while(--i >= 0)
 580:	83 ef 01             	sub    $0x1,%edi
 583:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 586:	eb aa                	jmp    532 <printint.constprop.0+0xb2>
 588:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 58f:	00 

00000590 <strncpy>:
{
 590:	55                   	push   %ebp
 591:	31 c0                	xor    %eax,%eax
 593:	89 e5                	mov    %esp,%ebp
 595:	56                   	push   %esi
 596:	8b 4d 08             	mov    0x8(%ebp),%ecx
 599:	8b 75 0c             	mov    0xc(%ebp),%esi
 59c:	53                   	push   %ebx
 59d:	8b 5d 10             	mov    0x10(%ebp),%ebx
  for (i = 0; i < n && src[i]; i++)
 5a0:	85 db                	test   %ebx,%ebx
 5a2:	7f 26                	jg     5ca <strncpy+0x3a>
 5a4:	eb 58                	jmp    5fe <strncpy+0x6e>
 5a6:	eb 18                	jmp    5c0 <strncpy+0x30>
 5a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5af:	00 
 5b0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5b7:	00 
 5b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5bf:	00 
    dest[i] = src[i];
 5c0:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  for (i = 0; i < n && src[i]; i++)
 5c3:	83 c0 01             	add    $0x1,%eax
 5c6:	39 c3                	cmp    %eax,%ebx
 5c8:	74 34                	je     5fe <strncpy+0x6e>
 5ca:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
 5ce:	84 d2                	test   %dl,%dl
 5d0:	75 ee                	jne    5c0 <strncpy+0x30>
  for (; i < n; i++)
 5d2:	39 c3                	cmp    %eax,%ebx
 5d4:	7e 28                	jle    5fe <strncpy+0x6e>
 5d6:	01 c8                	add    %ecx,%eax
 5d8:	01 d9                	add    %ebx,%ecx
 5da:	89 ca                	mov    %ecx,%edx
 5dc:	29 c2                	sub    %eax,%edx
 5de:	83 e2 01             	and    $0x1,%edx
 5e1:	74 0d                	je     5f0 <strncpy+0x60>
    dest[i] = '\0';
 5e3:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
 5e6:	83 c0 01             	add    $0x1,%eax
 5e9:	39 c8                	cmp    %ecx,%eax
 5eb:	74 11                	je     5fe <strncpy+0x6e>
 5ed:	8d 76 00             	lea    0x0(%esi),%esi
    dest[i] = '\0';
 5f0:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
 5f3:	83 c0 02             	add    $0x2,%eax
    dest[i] = '\0';
 5f6:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  for (; i < n; i++)
 5fa:	39 c8                	cmp    %ecx,%eax
 5fc:	75 f2                	jne    5f0 <strncpy+0x60>
}
 5fe:	5b                   	pop    %ebx
 5ff:	5e                   	pop    %esi
 600:	5d                   	pop    %ebp
 601:	c3                   	ret
 602:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 609:	00 
 60a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000610 <printf>:

void
printf(char *fmt, ...)
{
 610:	55                   	push   %ebp
 611:	89 e5                	mov    %esp,%ebp
 613:	57                   	push   %edi
 614:	56                   	push   %esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 615:	8d 75 0c             	lea    0xc(%ebp),%esi
{
 618:	53                   	push   %ebx
 619:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  for(i = 0; fmt[i]; i++){
 61c:	8b 55 08             	mov    0x8(%ebp),%edx
  ap = (uint*)(void*)&fmt + 1;
 61f:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 622:	0f b6 02             	movzbl (%edx),%eax
 625:	84 c0                	test   %al,%al
 627:	0f 84 88 00 00 00    	je     6b5 <printf+0xa5>
 62d:	8d 7a 01             	lea    0x1(%edx),%edi
    c = fmt[i] & 0xff;
 630:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
      if (c == '\f') {
 633:	83 fa 0c             	cmp    $0xc,%edx
 636:	0f 84 d4 01 00 00    	je     810 <printf+0x200>
        setcursor();
      } else if(c == '%'){
 63c:	83 fa 25             	cmp    $0x25,%edx
 63f:	0f 85 0b 02 00 00    	jne    850 <printf+0x240>
  for(i = 0; fmt[i]; i++){
 645:	0f b6 1f             	movzbl (%edi),%ebx
 648:	83 c7 01             	add    $0x1,%edi
 64b:	84 db                	test   %bl,%bl
 64d:	74 66                	je     6b5 <printf+0xa5>
    c = fmt[i] & 0xff;
 64f:	0f b6 c3             	movzbl %bl,%eax
 652:	ba 20 00 00 00       	mov    $0x20,%edx
 657:	31 c9                	xor    %ecx,%ecx
        pad_char = ' ';
      } else {
        putc(1, c);
      }
    } else if(state == '%'){
      if(c == '0'){
 659:	83 f8 78             	cmp    $0x78,%eax
 65c:	7f 22                	jg     680 <printf+0x70>
 65e:	83 f8 62             	cmp    $0x62,%eax
 661:	0f 8e b9 01 00 00    	jle    820 <printf+0x210>
 667:	83 e8 63             	sub    $0x63,%eax
 66a:	83 f8 15             	cmp    $0x15,%eax
 66d:	77 11                	ja     680 <printf+0x70>
 66f:	ff 24 85 6c 0d 00 00 	jmp    *0xd6c(,%eax,4)
 676:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 67d:	00 
 67e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 680:	83 ec 04             	sub    $0x4,%esp
 683:	8d 75 e7             	lea    -0x19(%ebp),%esi
 686:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 68a:	6a 01                	push   $0x1
 68c:	56                   	push   %esi
 68d:	6a 01                	push   $0x1
 68f:	e8 1f fd ff ff       	call   3b3 <write>
 694:	83 c4 0c             	add    $0xc,%esp
 697:	88 5d e7             	mov    %bl,-0x19(%ebp)
 69a:	6a 01                	push   $0x1
 69c:	56                   	push   %esi
 69d:	6a 01                	push   $0x1
 69f:	e8 0f fd ff ff       	call   3b3 <write>
      } else if(c == '%'){
        putc(1, '%');
        state = 0;
      } else {
        putc(1, '%');
        putc(1, c);
 6a4:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 6a7:	0f b6 07             	movzbl (%edi),%eax
 6aa:	83 c7 01             	add    $0x1,%edi
 6ad:	84 c0                	test   %al,%al
 6af:	0f 85 7b ff ff ff    	jne    630 <printf+0x20>
        state = 0;
      }
    }
  }
}
 6b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6b8:	5b                   	pop    %ebx
 6b9:	5e                   	pop    %esi
 6ba:	5f                   	pop    %edi
 6bb:	5d                   	pop    %ebp
 6bc:	c3                   	ret
 6bd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 16, 0, width, pad_char);
 6c0:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 6c3:	83 ec 08             	sub    $0x8,%esp
 6c6:	8b 06                	mov    (%esi),%eax
 6c8:	52                   	push   %edx
 6c9:	ba 10 00 00 00       	mov    $0x10,%edx
 6ce:	51                   	push   %ecx
 6cf:	31 c9                	xor    %ecx,%ecx
        printint(1, *ap, 10, 1, width, pad_char);
 6d1:	e8 aa fd ff ff       	call   480 <printint.constprop.0>
        ap++;
 6d6:	83 c6 04             	add    $0x4,%esi
 6d9:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 6dc:	0f b6 07             	movzbl (%edi),%eax
 6df:	83 c7 01             	add    $0x1,%edi
 6e2:	83 c4 10             	add    $0x10,%esp
 6e5:	84 c0                	test   %al,%al
 6e7:	0f 85 43 ff ff ff    	jne    630 <printf+0x20>
}
 6ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6f0:	5b                   	pop    %ebx
 6f1:	5e                   	pop    %esi
 6f2:	5f                   	pop    %edi
 6f3:	5d                   	pop    %ebp
 6f4:	c3                   	ret
 6f5:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 10, 1, width, pad_char);
 6f8:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 6fb:	83 ec 08             	sub    $0x8,%esp
 6fe:	8b 06                	mov    (%esi),%eax
 700:	52                   	push   %edx
 701:	ba 0a 00 00 00       	mov    $0xa,%edx
 706:	51                   	push   %ecx
 707:	b9 01 00 00 00       	mov    $0x1,%ecx
 70c:	eb c3                	jmp    6d1 <printf+0xc1>
 70e:	66 90                	xchg   %ax,%ax
        s = (char*)*ap;
 710:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 713:	8b 06                	mov    (%esi),%eax
        ap++;
 715:	83 c6 04             	add    $0x4,%esi
 718:	89 75 d4             	mov    %esi,-0x2c(%ebp)
        if(s == 0)
 71b:	85 c0                	test   %eax,%eax
 71d:	0f 85 9d 01 00 00    	jne    8c0 <printf+0x2b0>
 723:	c6 45 d0 28          	movb   $0x28,-0x30(%ebp)
          s = "(null)";
 727:	b8 d6 0c 00 00       	mov    $0xcd6,%eax
        int len = 0;
 72c:	31 db                	xor    %ebx,%ebx
 72e:	66 90                	xchg   %ax,%ax
        for (char *t = s; *t; t++) len++;
 730:	83 c3 01             	add    $0x1,%ebx
 733:	80 3c 18 00          	cmpb   $0x0,(%eax,%ebx,1)
 737:	75 f7                	jne    730 <printf+0x120>
        for (int j = len; j < width; j++)
 739:	39 cb                	cmp    %ecx,%ebx
 73b:	0f 8d 9c 01 00 00    	jge    8dd <printf+0x2cd>
 741:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 744:	8d 75 e7             	lea    -0x19(%ebp),%esi
 747:	89 45 c8             	mov    %eax,-0x38(%ebp)
 74a:	89 7d cc             	mov    %edi,-0x34(%ebp)
 74d:	89 df                	mov    %ebx,%edi
 74f:	89 d3                	mov    %edx,%ebx
 751:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 758:	00 
 759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 760:	83 ec 04             	sub    $0x4,%esp
 763:	88 5d e7             	mov    %bl,-0x19(%ebp)
        for (int j = len; j < width; j++)
 766:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 769:	6a 01                	push   $0x1
 76b:	56                   	push   %esi
 76c:	6a 01                	push   $0x1
 76e:	e8 40 fc ff ff       	call   3b3 <write>
        for (int j = len; j < width; j++)
 773:	8b 45 d0             	mov    -0x30(%ebp),%eax
 776:	83 c4 10             	add    $0x10,%esp
 779:	39 c7                	cmp    %eax,%edi
 77b:	7c e3                	jl     760 <printf+0x150>
        while(*s != 0){
 77d:	8b 45 c8             	mov    -0x38(%ebp),%eax
 780:	8b 7d cc             	mov    -0x34(%ebp),%edi
 783:	0f b6 08             	movzbl (%eax),%ecx
 786:	88 4d d0             	mov    %cl,-0x30(%ebp)
 789:	84 c9                	test   %cl,%cl
 78b:	0f 84 16 ff ff ff    	je     6a7 <printf+0x97>
 791:	89 c3                	mov    %eax,%ebx
 793:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 797:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 79e:	00 
 79f:	90                   	nop
  write(fd, &c, 1);
 7a0:	83 ec 04             	sub    $0x4,%esp
 7a3:	88 45 e7             	mov    %al,-0x19(%ebp)
          putc(1, *s++);
 7a6:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 7a9:	6a 01                	push   $0x1
 7ab:	56                   	push   %esi
 7ac:	6a 01                	push   $0x1
 7ae:	e8 00 fc ff ff       	call   3b3 <write>
        while(*s != 0){
 7b3:	0f b6 03             	movzbl (%ebx),%eax
 7b6:	83 c4 10             	add    $0x10,%esp
 7b9:	84 c0                	test   %al,%al
 7bb:	75 e3                	jne    7a0 <printf+0x190>
 7bd:	e9 e5 fe ff ff       	jmp    6a7 <printf+0x97>
 7c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        char ch = *ap++;
 7c8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 7cb:	83 ec 04             	sub    $0x4,%esp
 7ce:	8d 75 e7             	lea    -0x19(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 7d1:	83 c7 01             	add    $0x1,%edi
        char ch = *ap++;
 7d4:	8d 58 04             	lea    0x4(%eax),%ebx
 7d7:	8b 00                	mov    (%eax),%eax
 7d9:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 7dc:	6a 01                	push   $0x1
 7de:	56                   	push   %esi
 7df:	6a 01                	push   $0x1
 7e1:	e8 cd fb ff ff       	call   3b3 <write>
  for(i = 0; fmt[i]; i++){
 7e6:	0f b6 47 ff          	movzbl -0x1(%edi),%eax
 7ea:	83 c4 10             	add    $0x10,%esp
 7ed:	84 c0                	test   %al,%al
 7ef:	0f 84 c0 fe ff ff    	je     6b5 <printf+0xa5>
    c = fmt[i] & 0xff;
 7f5:	0f b6 d0             	movzbl %al,%edx
        char ch = *ap++;
 7f8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      if (c == '\f') {
 7fb:	83 fa 0c             	cmp    $0xc,%edx
 7fe:	0f 85 38 fe ff ff    	jne    63c <printf+0x2c>
 804:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 80b:	00 
 80c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        setcursor();
 810:	e8 36 fc ff ff       	call   44b <setcursor>
 815:	e9 8d fe ff ff       	jmp    6a7 <printf+0x97>
 81a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 820:	83 f8 30             	cmp    $0x30,%eax
 823:	74 7b                	je     8a0 <printf+0x290>
 825:	7f 49                	jg     870 <printf+0x260>
 827:	83 f8 25             	cmp    $0x25,%eax
 82a:	0f 85 50 fe ff ff    	jne    680 <printf+0x70>
  write(fd, &c, 1);
 830:	83 ec 04             	sub    $0x4,%esp
 833:	8d 75 e7             	lea    -0x19(%ebp),%esi
 836:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 83a:	6a 01                	push   $0x1
 83c:	56                   	push   %esi
 83d:	6a 01                	push   $0x1
 83f:	e8 6f fb ff ff       	call   3b3 <write>
        state = 0;
 844:	83 c4 10             	add    $0x10,%esp
 847:	e9 5b fe ff ff       	jmp    6a7 <printf+0x97>
 84c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 850:	83 ec 04             	sub    $0x4,%esp
 853:	8d 75 e7             	lea    -0x19(%ebp),%esi
 856:	88 45 e7             	mov    %al,-0x19(%ebp)
 859:	6a 01                	push   $0x1
 85b:	56                   	push   %esi
 85c:	6a 01                	push   $0x1
 85e:	e8 50 fb ff ff       	call   3b3 <write>
  for(i = 0; fmt[i]; i++){
 863:	e9 74 fe ff ff       	jmp    6dc <printf+0xcc>
 868:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 86f:	00 
 870:	8d 70 cf             	lea    -0x31(%eax),%esi
 873:	83 fe 08             	cmp    $0x8,%esi
 876:	0f 87 04 fe ff ff    	ja     680 <printf+0x70>
 87c:	0f b6 1f             	movzbl (%edi),%ebx
        width = width * 10 + (c - '0');
 87f:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
  for(i = 0; fmt[i]; i++){
 882:	83 c7 01             	add    $0x1,%edi
        width = width * 10 + (c - '0');
 885:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  for(i = 0; fmt[i]; i++){
 889:	84 db                	test   %bl,%bl
 88b:	0f 84 24 fe ff ff    	je     6b5 <printf+0xa5>
    c = fmt[i] & 0xff;
 891:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 894:	e9 c0 fd ff ff       	jmp    659 <printf+0x49>
 899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 8a0:	0f b6 1f             	movzbl (%edi),%ebx
 8a3:	83 c7 01             	add    $0x1,%edi
 8a6:	84 db                	test   %bl,%bl
 8a8:	0f 84 07 fe ff ff    	je     6b5 <printf+0xa5>
    c = fmt[i] & 0xff;
 8ae:	0f b6 c3             	movzbl %bl,%eax
 8b1:	ba 30 00 00 00       	mov    $0x30,%edx
 8b6:	e9 9e fd ff ff       	jmp    659 <printf+0x49>
 8bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        for (char *t = s; *t; t++) len++;
 8c0:	0f b6 18             	movzbl (%eax),%ebx
 8c3:	88 5d d0             	mov    %bl,-0x30(%ebp)
 8c6:	84 db                	test   %bl,%bl
 8c8:	0f 85 5e fe ff ff    	jne    72c <printf+0x11c>
        int len = 0;
 8ce:	31 db                	xor    %ebx,%ebx
        for (int j = len; j < width; j++)
 8d0:	85 c9                	test   %ecx,%ecx
 8d2:	0f 8f 69 fe ff ff    	jg     741 <printf+0x131>
 8d8:	e9 ca fd ff ff       	jmp    6a7 <printf+0x97>
 8dd:	89 c2                	mov    %eax,%edx
 8df:	8d 75 e7             	lea    -0x19(%ebp),%esi
 8e2:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 8e6:	89 d3                	mov    %edx,%ebx
 8e8:	e9 b3 fe ff ff       	jmp    7a0 <printf+0x190>
 8ed:	8d 76 00             	lea    0x0(%esi),%esi

000008f0 <fprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
fprintf(int fd, char *fmt, ...)
{
 8f0:	55                   	push   %ebp
 8f1:	89 e5                	mov    %esp,%ebp
 8f3:	57                   	push   %edi
 8f4:	56                   	push   %esi
 8f5:	53                   	push   %ebx
 8f6:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8f9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 8fc:	0f b6 13             	movzbl (%ebx),%edx
 8ff:	83 c3 01             	add    $0x1,%ebx
 902:	84 d2                	test   %dl,%dl
 904:	0f 84 81 00 00 00    	je     98b <fprintf+0x9b>
 90a:	8d 75 10             	lea    0x10(%ebp),%esi
 90d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 910:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if (c == '\f') { // Detect formfeed character
 913:	83 f8 0c             	cmp    $0xc,%eax
 916:	0f 84 04 01 00 00    	je     a20 <fprintf+0x130>
        setcursor();
      } else
      if(c == '%'){
 91c:	83 f8 25             	cmp    $0x25,%eax
 91f:	0f 85 5b 01 00 00    	jne    a80 <fprintf+0x190>
  for(i = 0; fmt[i]; i++){
 925:	0f b6 13             	movzbl (%ebx),%edx
 928:	84 d2                	test   %dl,%dl
 92a:	74 5f                	je     98b <fprintf+0x9b>
    c = fmt[i] & 0xff;
 92c:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 92f:	80 fa 25             	cmp    $0x25,%dl
 932:	0f 84 78 01 00 00    	je     ab0 <fprintf+0x1c0>
 938:	83 e8 63             	sub    $0x63,%eax
 93b:	83 f8 15             	cmp    $0x15,%eax
 93e:	77 10                	ja     950 <fprintf+0x60>
 940:	ff 24 85 c4 0d 00 00 	jmp    *0xdc4(,%eax,4)
 947:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 94e:	00 
 94f:	90                   	nop
  write(fd, &c, 1);
 950:	83 ec 04             	sub    $0x4,%esp
 953:	8d 7d e7             	lea    -0x19(%ebp),%edi
 956:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 959:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 95d:	6a 01                	push   $0x1
 95f:	57                   	push   %edi
 960:	ff 75 08             	push   0x8(%ebp)
 963:	e8 4b fa ff ff       	call   3b3 <write>
        putc(fd, c);
 968:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 96c:	83 c4 0c             	add    $0xc,%esp
 96f:	88 55 e7             	mov    %dl,-0x19(%ebp)
 972:	6a 01                	push   $0x1
 974:	57                   	push   %edi
 975:	ff 75 08             	push   0x8(%ebp)
 978:	e8 36 fa ff ff       	call   3b3 <write>
  for(i = 0; fmt[i]; i++){
 97d:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 981:	83 c3 02             	add    $0x2,%ebx
 984:	83 c4 10             	add    $0x10,%esp
 987:	84 d2                	test   %dl,%dl
 989:	75 85                	jne    910 <fprintf+0x20>
      }
      state = 0;
    }
  }
}
 98b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 98e:	5b                   	pop    %ebx
 98f:	5e                   	pop    %esi
 990:	5f                   	pop    %edi
 991:	5d                   	pop    %ebp
 992:	c3                   	ret
 993:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(1, *ap, 16, 0, width, pad_char);
 998:	83 ec 08             	sub    $0x8,%esp
 99b:	8b 06                	mov    (%esi),%eax
 99d:	31 c9                	xor    %ecx,%ecx
 99f:	ba 10 00 00 00       	mov    $0x10,%edx
 9a4:	6a 20                	push   $0x20
 9a6:	6a 00                	push   $0x0
 9a8:	e8 d3 fa ff ff       	call   480 <printint.constprop.0>
        ap++;
 9ad:	83 c6 04             	add    $0x4,%esi
  for(i = 0; fmt[i]; i++){
 9b0:	eb cb                	jmp    97d <fprintf+0x8d>
 9b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s = (char*)*ap;
 9b8:	8b 3e                	mov    (%esi),%edi
        ap++;
 9ba:	83 c6 04             	add    $0x4,%esi
        if(s == 0)
 9bd:	85 ff                	test   %edi,%edi
 9bf:	0f 84 fb 00 00 00    	je     ac0 <fprintf+0x1d0>
        while(*s != 0){
 9c5:	0f b6 07             	movzbl (%edi),%eax
 9c8:	84 c0                	test   %al,%al
 9ca:	74 36                	je     a02 <fprintf+0x112>
 9cc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 9cf:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 9d2:	8b 75 08             	mov    0x8(%ebp),%esi
 9d5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 9d8:	89 fb                	mov    %edi,%ebx
 9da:	89 cf                	mov    %ecx,%edi
 9dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 9e0:	83 ec 04             	sub    $0x4,%esp
 9e3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 9e6:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 9e9:	6a 01                	push   $0x1
 9eb:	57                   	push   %edi
 9ec:	56                   	push   %esi
 9ed:	e8 c1 f9 ff ff       	call   3b3 <write>
        while(*s != 0){
 9f2:	0f b6 03             	movzbl (%ebx),%eax
 9f5:	83 c4 10             	add    $0x10,%esp
 9f8:	84 c0                	test   %al,%al
 9fa:	75 e4                	jne    9e0 <fprintf+0xf0>
 9fc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 9ff:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 a02:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 a06:	83 c3 02             	add    $0x2,%ebx
 a09:	84 d2                	test   %dl,%dl
 a0b:	0f 84 7a ff ff ff    	je     98b <fprintf+0x9b>
    c = fmt[i] & 0xff;
 a11:	0f b6 c2             	movzbl %dl,%eax
      if (c == '\f') { // Detect formfeed character
 a14:	83 f8 0c             	cmp    $0xc,%eax
 a17:	0f 85 ff fe ff ff    	jne    91c <fprintf+0x2c>
 a1d:	8d 76 00             	lea    0x0(%esi),%esi
        setcursor();
 a20:	e8 26 fa ff ff       	call   44b <setcursor>
  for(i = 0; fmt[i]; i++){
 a25:	0f b6 13             	movzbl (%ebx),%edx
 a28:	83 c3 01             	add    $0x1,%ebx
 a2b:	84 d2                	test   %dl,%dl
 a2d:	0f 85 dd fe ff ff    	jne    910 <fprintf+0x20>
 a33:	e9 53 ff ff ff       	jmp    98b <fprintf+0x9b>
 a38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a3f:	00 
        printint(1, *ap, 10, 1, width, pad_char);
 a40:	83 ec 08             	sub    $0x8,%esp
 a43:	8b 06                	mov    (%esi),%eax
 a45:	b9 01 00 00 00       	mov    $0x1,%ecx
 a4a:	ba 0a 00 00 00       	mov    $0xa,%edx
 a4f:	6a 20                	push   $0x20
 a51:	6a 00                	push   $0x0
 a53:	e9 50 ff ff ff       	jmp    9a8 <fprintf+0xb8>
 a58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a5f:	00 
        putc(fd, *ap);
 a60:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
 a62:	83 ec 04             	sub    $0x4,%esp
 a65:	8d 7d e7             	lea    -0x19(%ebp),%edi
        putc(fd, *ap);
 a68:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 a6b:	6a 01                	push   $0x1
 a6d:	57                   	push   %edi
 a6e:	ff 75 08             	push   0x8(%ebp)
 a71:	e8 3d f9 ff ff       	call   3b3 <write>
 a76:	e9 32 ff ff ff       	jmp    9ad <fprintf+0xbd>
 a7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 a80:	83 ec 04             	sub    $0x4,%esp
 a83:	8d 45 e7             	lea    -0x19(%ebp),%eax
 a86:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 a89:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 a8c:	6a 01                	push   $0x1
 a8e:	50                   	push   %eax
 a8f:	ff 75 08             	push   0x8(%ebp)
 a92:	e8 1c f9 ff ff       	call   3b3 <write>
  for(i = 0; fmt[i]; i++){
 a97:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 a9b:	83 c4 10             	add    $0x10,%esp
 a9e:	84 d2                	test   %dl,%dl
 aa0:	0f 85 6a fe ff ff    	jne    910 <fprintf+0x20>
}
 aa6:	8d 65 f4             	lea    -0xc(%ebp),%esp
 aa9:	5b                   	pop    %ebx
 aaa:	5e                   	pop    %esi
 aab:	5f                   	pop    %edi
 aac:	5d                   	pop    %ebp
 aad:	c3                   	ret
 aae:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 ab0:	83 ec 04             	sub    $0x4,%esp
 ab3:	88 55 e7             	mov    %dl,-0x19(%ebp)
 ab6:	8d 7d e7             	lea    -0x19(%ebp),%edi
 ab9:	6a 01                	push   $0x1
 abb:	e9 b4 fe ff ff       	jmp    974 <fprintf+0x84>
          s = "(null)";
 ac0:	bf d6 0c 00 00       	mov    $0xcd6,%edi
 ac5:	b8 28 00 00 00       	mov    $0x28,%eax
 aca:	e9 fd fe ff ff       	jmp    9cc <fprintf+0xdc>
 acf:	66 90                	xchg   %ax,%ax
 ad1:	66 90                	xchg   %ax,%ax
 ad3:	66 90                	xchg   %ax,%ax
 ad5:	66 90                	xchg   %ax,%ax
 ad7:	66 90                	xchg   %ax,%ax
 ad9:	66 90                	xchg   %ax,%ax
 adb:	66 90                	xchg   %ax,%ax
 add:	66 90                	xchg   %ax,%ax
 adf:	90                   	nop

00000ae0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ae0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ae1:	a1 98 11 00 00       	mov    0x1198,%eax
{
 ae6:	89 e5                	mov    %esp,%ebp
 ae8:	57                   	push   %edi
 ae9:	56                   	push   %esi
 aea:	53                   	push   %ebx
 aeb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 aee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 af1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 af8:	00 
 af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 b00:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b02:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b04:	39 ca                	cmp    %ecx,%edx
 b06:	73 30                	jae    b38 <free+0x58>
 b08:	39 c1                	cmp    %eax,%ecx
 b0a:	72 04                	jb     b10 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b0c:	39 c2                	cmp    %eax,%edx
 b0e:	72 f0                	jb     b00 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b10:	8b 73 fc             	mov    -0x4(%ebx),%esi
 b13:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 b16:	39 f8                	cmp    %edi,%eax
 b18:	74 36                	je     b50 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 b1a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 b1d:	8b 42 04             	mov    0x4(%edx),%eax
 b20:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 b23:	39 f1                	cmp    %esi,%ecx
 b25:	74 40                	je     b67 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 b27:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 b29:	5b                   	pop    %ebx
  freep = p;
 b2a:	89 15 98 11 00 00    	mov    %edx,0x1198
}
 b30:	5e                   	pop    %esi
 b31:	5f                   	pop    %edi
 b32:	5d                   	pop    %ebp
 b33:	c3                   	ret
 b34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b38:	39 c2                	cmp    %eax,%edx
 b3a:	72 c4                	jb     b00 <free+0x20>
 b3c:	39 c1                	cmp    %eax,%ecx
 b3e:	73 c0                	jae    b00 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 b40:	8b 73 fc             	mov    -0x4(%ebx),%esi
 b43:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 b46:	39 f8                	cmp    %edi,%eax
 b48:	75 d0                	jne    b1a <free+0x3a>
 b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 b50:	03 70 04             	add    0x4(%eax),%esi
 b53:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 b56:	8b 02                	mov    (%edx),%eax
 b58:	8b 00                	mov    (%eax),%eax
 b5a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 b5d:	8b 42 04             	mov    0x4(%edx),%eax
 b60:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 b63:	39 f1                	cmp    %esi,%ecx
 b65:	75 c0                	jne    b27 <free+0x47>
    p->s.size += bp->s.size;
 b67:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 b6a:	89 15 98 11 00 00    	mov    %edx,0x1198
    p->s.size += bp->s.size;
 b70:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 b73:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 b76:	89 0a                	mov    %ecx,(%edx)
}
 b78:	5b                   	pop    %ebx
 b79:	5e                   	pop    %esi
 b7a:	5f                   	pop    %edi
 b7b:	5d                   	pop    %ebp
 b7c:	c3                   	ret
 b7d:	8d 76 00             	lea    0x0(%esi),%esi

00000b80 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b80:	55                   	push   %ebp
 b81:	89 e5                	mov    %esp,%ebp
 b83:	57                   	push   %edi
 b84:	56                   	push   %esi
 b85:	53                   	push   %ebx
 b86:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b89:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 b8c:	8b 15 98 11 00 00    	mov    0x1198,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b92:	8d 78 07             	lea    0x7(%eax),%edi
 b95:	c1 ef 03             	shr    $0x3,%edi
 b98:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 b9b:	85 d2                	test   %edx,%edx
 b9d:	0f 84 8d 00 00 00    	je     c30 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ba3:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 ba5:	8b 48 04             	mov    0x4(%eax),%ecx
 ba8:	39 f9                	cmp    %edi,%ecx
 baa:	73 64                	jae    c10 <malloc+0x90>
  if(nu < 4096)
 bac:	bb 00 10 00 00       	mov    $0x1000,%ebx
 bb1:	39 df                	cmp    %ebx,%edi
 bb3:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 bb6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 bbd:	eb 0a                	jmp    bc9 <malloc+0x49>
 bbf:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bc0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 bc2:	8b 48 04             	mov    0x4(%eax),%ecx
 bc5:	39 f9                	cmp    %edi,%ecx
 bc7:	73 47                	jae    c10 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 bc9:	89 c2                	mov    %eax,%edx
 bcb:	39 05 98 11 00 00    	cmp    %eax,0x1198
 bd1:	75 ed                	jne    bc0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 bd3:	83 ec 0c             	sub    $0xc,%esp
 bd6:	56                   	push   %esi
 bd7:	e8 3f f8 ff ff       	call   41b <sbrk>
  if(p == (char*)-1)
 bdc:	83 c4 10             	add    $0x10,%esp
 bdf:	83 f8 ff             	cmp    $0xffffffff,%eax
 be2:	74 1c                	je     c00 <malloc+0x80>
  hp->s.size = nu;
 be4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 be7:	83 ec 0c             	sub    $0xc,%esp
 bea:	83 c0 08             	add    $0x8,%eax
 bed:	50                   	push   %eax
 bee:	e8 ed fe ff ff       	call   ae0 <free>
  return freep;
 bf3:	8b 15 98 11 00 00    	mov    0x1198,%edx
      if((p = morecore(nunits)) == 0)
 bf9:	83 c4 10             	add    $0x10,%esp
 bfc:	85 d2                	test   %edx,%edx
 bfe:	75 c0                	jne    bc0 <malloc+0x40>
        return 0;
  }
}
 c00:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 c03:	31 c0                	xor    %eax,%eax
}
 c05:	5b                   	pop    %ebx
 c06:	5e                   	pop    %esi
 c07:	5f                   	pop    %edi
 c08:	5d                   	pop    %ebp
 c09:	c3                   	ret
 c0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 c10:	39 cf                	cmp    %ecx,%edi
 c12:	74 4c                	je     c60 <malloc+0xe0>
        p->s.size -= nunits;
 c14:	29 f9                	sub    %edi,%ecx
 c16:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 c19:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 c1c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 c1f:	89 15 98 11 00 00    	mov    %edx,0x1198
}
 c25:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 c28:	83 c0 08             	add    $0x8,%eax
}
 c2b:	5b                   	pop    %ebx
 c2c:	5e                   	pop    %esi
 c2d:	5f                   	pop    %edi
 c2e:	5d                   	pop    %ebp
 c2f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 c30:	c7 05 98 11 00 00 9c 	movl   $0x119c,0x1198
 c37:	11 00 00 
    base.s.size = 0;
 c3a:	b8 9c 11 00 00       	mov    $0x119c,%eax
    base.s.ptr = freep = prevp = &base;
 c3f:	c7 05 9c 11 00 00 9c 	movl   $0x119c,0x119c
 c46:	11 00 00 
    base.s.size = 0;
 c49:	c7 05 a0 11 00 00 00 	movl   $0x0,0x11a0
 c50:	00 00 00 
    if(p->s.size >= nunits){
 c53:	e9 54 ff ff ff       	jmp    bac <malloc+0x2c>
 c58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 c5f:	00 
        prevp->s.ptr = p->s.ptr;
 c60:	8b 08                	mov    (%eax),%ecx
 c62:	89 0a                	mov    %ecx,(%edx)
 c64:	eb b9                	jmp    c1f <malloc+0x9f>
