
_pwd:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    for (int j = 0; j < i; j++)
        name[j] = y.name[j];
    name[i] = '/';
}

int main() {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
    int n;
loop0:
    stat(dot, &x);
  11:	83 ec 08             	sub    $0x8,%esp
  14:	68 e0 11 00 00       	push   $0x11e0
  19:	68 a1 11 00 00       	push   $0x11a1
  1e:	e8 ad 03 00 00       	call   3d0 <stat>
    if (x.ino == 1) { // Already at root
  23:	83 c4 10             	add    $0x10,%esp
  26:	83 3d e8 11 00 00 01 	cmpl   $0x1,0x11e8
  2d:	0f 84 85 00 00 00    	je     b8 <main+0xb8>
        write(1, root, 1);
        prname();
    }
    if ((file = open(dotdot, O_RDONLY)) < 0) prname();
  33:	83 ec 08             	sub    $0x8,%esp
  36:	6a 00                	push   $0x0
  38:	68 9e 11 00 00       	push   $0x119e
  3d:	e8 91 04 00 00       	call   4d3 <open>
  42:	83 c4 10             	add    $0x10,%esp
  45:	a3 44 12 00 00       	mov    %eax,0x1244
  4a:	85 c0                	test   %eax,%eax
  4c:	79 16                	jns    64 <main+0x64>
  4e:	eb 2c                	jmp    7c <main+0x7c>
loop1:
    if ((n = read(file, &y, sizeof(y))) < sizeof(y)) prname();
    if (y.jnum != x.ino) goto loop1;
    close(file);
  50:	a1 44 12 00 00       	mov    0x1244,%eax
    if (y.jnum != x.ino) goto loop1;
  55:	0f b7 15 c0 11 00 00 	movzwl 0x11c0,%edx
  5c:	3b 15 e8 11 00 00    	cmp    0x11e8,%edx
  62:	74 24                	je     88 <main+0x88>
    if ((n = read(file, &y, sizeof(y))) < sizeof(y)) prname();
  64:	83 ec 04             	sub    $0x4,%esp
  67:	6a 10                	push   $0x10
  69:	68 c0 11 00 00       	push   $0x11c0
  6e:	50                   	push   %eax
  6f:	e8 37 04 00 00       	call   4ab <read>
  74:	83 c4 10             	add    $0x10,%esp
  77:	83 f8 0f             	cmp    $0xf,%eax
  7a:	77 d4                	ja     50 <main+0x50>
    if ((file = open(dotdot, O_RDONLY)) < 0) prname();
  7c:	e8 5f 00 00 00       	call   e0 <prname>
  81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    close(file);
  88:	83 ec 0c             	sub    $0xc,%esp
  8b:	50                   	push   %eax
  8c:	e8 2a 04 00 00       	call   4bb <close>
    if (y.jnum == 1) ckroot(); // Handle root case
  91:	83 c4 10             	add    $0x10,%esp
  94:	66 83 3d c0 11 00 00 	cmpw   $0x1,0x11c0
  9b:	01 
  9c:	74 2e                	je     cc <main+0xcc>
    cat();
  9e:	e8 cd 00 00 00       	call   170 <cat>
    chdir(dotdot);
  a3:	83 ec 0c             	sub    $0xc,%esp
  a6:	68 9e 11 00 00       	push   $0x119e
  ab:	e8 53 04 00 00       	call   503 <chdir>
    goto loop0;
  b0:	83 c4 10             	add    $0x10,%esp
  b3:	e9 59 ff ff ff       	jmp    11 <main+0x11>
        write(1, root, 1);
  b8:	50                   	push   %eax
  b9:	6a 01                	push   $0x1
  bb:	68 9c 11 00 00       	push   $0x119c
  c0:	6a 01                	push   $0x1
  c2:	e8 ec 03 00 00       	call   4b3 <write>
        prname();
  c7:	e8 14 00 00 00       	call   e0 <prname>
    if (y.jnum == 1) ckroot(); // Handle root case
  cc:	e8 4f 00 00 00       	call   120 <ckroot>
  d1:	66 90                	xchg   %ax,%ax
  d3:	66 90                	xchg   %ax,%ax
  d5:	66 90                	xchg   %ax,%ax
  d7:	66 90                	xchg   %ax,%ax
  d9:	66 90                	xchg   %ax,%ax
  db:	66 90                	xchg   %ax,%ax
  dd:	66 90                	xchg   %ax,%ax
  df:	90                   	nop

000000e0 <prname>:
void prname() {
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	83 ec 08             	sub    $0x8,%esp
    if (off < 0) off = 0;
  e6:	a1 98 11 00 00       	mov    0x1198,%eax
  eb:	85 c0                	test   %eax,%eax
  ed:	79 09                	jns    f8 <prname+0x18>
  ef:	31 c0                	xor    %eax,%eax
  f1:	a3 98 11 00 00       	mov    %eax,0x1198
  f6:	31 c0                	xor    %eax,%eax
    name[off] = '\n';
  f8:	c6 80 60 12 00 00 0a 	movb   $0xa,0x1260(%eax)
    write(1, name, off + 1);
  ff:	83 ec 04             	sub    $0x4,%esp
 102:	83 c0 01             	add    $0x1,%eax
 105:	50                   	push   %eax
 106:	68 60 12 00 00       	push   $0x1260
 10b:	6a 01                	push   $0x1
 10d:	e8 a1 03 00 00       	call   4b3 <write>
    exit();
 112:	e8 7c 03 00 00       	call   493 <exit>
 117:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 11e:	00 
 11f:	90                   	nop

00000120 <ckroot>:
void ckroot() {
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	83 ec 10             	sub    $0x10,%esp
    if ((n = stat(y.name, &x)) < 0) prname();
 126:	68 e0 11 00 00       	push   $0x11e0
 12b:	68 c2 11 00 00       	push   $0x11c2
 130:	e8 9b 02 00 00       	call   3d0 <stat>
 135:	83 c4 10             	add    $0x10,%esp
 138:	85 c0                	test   %eax,%eax
 13a:	78 28                	js     164 <ckroot+0x44>
    if ((n = chdir(root)) < 0) prname();
 13c:	83 ec 0c             	sub    $0xc,%esp
 13f:	68 9c 11 00 00       	push   $0x119c
 144:	e8 ba 03 00 00       	call   503 <chdir>
 149:	83 c4 10             	add    $0x10,%esp
 14c:	85 c0                	test   %eax,%eax
 14e:	78 14                	js     164 <ckroot+0x44>
    write(1, root, 1);
 150:	50                   	push   %eax
 151:	6a 01                	push   $0x1
 153:	68 9c 11 00 00       	push   $0x119c
 158:	6a 01                	push   $0x1
 15a:	e8 54 03 00 00       	call   4b3 <write>
    prname();
 15f:	e8 7c ff ff ff       	call   e0 <prname>
    if ((n = stat(y.name, &x)) < 0) prname();
 164:	e8 77 ff ff ff       	call   e0 <prname>
 169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000170 <cat>:
void cat() {
 170:	55                   	push   %ebp
    int i = 0;
 171:	31 c0                	xor    %eax,%eax
void cat() {
 173:	89 e5                	mov    %esp,%ebp
 175:	53                   	push   %ebx
 176:	83 ec 04             	sub    $0x4,%esp
    while (y.name[i] != 0 && i < sizeof(y.name)) i++;
 179:	80 3d c2 11 00 00 00 	cmpb   $0x0,0x11c2
 180:	74 1a                	je     19c <cat+0x2c>
 182:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 189:	00 
 18a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 190:	83 c0 01             	add    $0x1,%eax
 193:	80 b8 c2 11 00 00 00 	cmpb   $0x0,0x11c2(%eax)
 19a:	75 f4                	jne    190 <cat+0x20>
    if (off + i + 1 >= sizeof(name)) prname();
 19c:	8b 1d 98 11 00 00    	mov    0x1198,%ebx
 1a2:	8d 54 03 01          	lea    0x1(%ebx,%eax,1),%edx
 1a6:	81 fa ff 01 00 00    	cmp    $0x1ff,%edx
 1ac:	77 72                	ja     220 <cat+0xb0>
    for (int j = off; j >= 0; j--)
 1ae:	89 da                	mov    %ebx,%edx
 1b0:	85 db                	test   %ebx,%ebx
 1b2:	78 1f                	js     1d3 <cat+0x63>
 1b4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1bb:	00 
 1bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        name[j + i + 1] = name[j];
 1c0:	0f b6 8a 60 12 00 00 	movzbl 0x1260(%edx),%ecx
 1c7:	88 8c 10 61 12 00 00 	mov    %cl,0x1261(%eax,%edx,1)
    for (int j = off; j >= 0; j--)
 1ce:	83 ea 01             	sub    $0x1,%edx
 1d1:	73 ed                	jae    1c0 <cat+0x50>
    off += i + 1;
 1d3:	8d 54 03 01          	lea    0x1(%ebx,%eax,1),%edx
 1d7:	89 15 98 11 00 00    	mov    %edx,0x1198
    for (int j = 0; j < i; j++)
 1dd:	85 c0                	test   %eax,%eax
 1df:	74 33                	je     214 <cat+0xa4>
 1e1:	31 d2                	xor    %edx,%edx
 1e3:	eb 1b                	jmp    200 <cat+0x90>
 1e5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ec:	00 
 1ed:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1f4:	00 
 1f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1fc:	00 
 1fd:	8d 76 00             	lea    0x0(%esi),%esi
        name[j] = y.name[j];
 200:	0f b6 8a c2 11 00 00 	movzbl 0x11c2(%edx),%ecx
    for (int j = 0; j < i; j++)
 207:	83 c2 01             	add    $0x1,%edx
        name[j] = y.name[j];
 20a:	88 8a 5f 12 00 00    	mov    %cl,0x125f(%edx)
    for (int j = 0; j < i; j++)
 210:	39 c2                	cmp    %eax,%edx
 212:	75 ec                	jne    200 <cat+0x90>
    name[i] = '/';
 214:	c6 80 60 12 00 00 2f 	movb   $0x2f,0x1260(%eax)
}
 21b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 21e:	c9                   	leave
 21f:	c3                   	ret
    if (off + i + 1 >= sizeof(name)) prname();
 220:	e8 bb fe ff ff       	call   e0 <prname>
 225:	66 90                	xchg   %ax,%ax
 227:	66 90                	xchg   %ax,%ax
 229:	66 90                	xchg   %ax,%ax
 22b:	66 90                	xchg   %ax,%ax
 22d:	66 90                	xchg   %ax,%ax
 22f:	66 90                	xchg   %ax,%ax
 231:	66 90                	xchg   %ax,%ax
 233:	66 90                	xchg   %ax,%ax
 235:	66 90                	xchg   %ax,%ax
 237:	66 90                	xchg   %ax,%ax
 239:	66 90                	xchg   %ax,%ax
 23b:	66 90                	xchg   %ax,%ax
 23d:	66 90                	xchg   %ax,%ax
 23f:	90                   	nop

00000240 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 240:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 241:	31 c0                	xor    %eax,%eax
{
 243:	89 e5                	mov    %esp,%ebp
 245:	53                   	push   %ebx
 246:	8b 4d 08             	mov    0x8(%ebp),%ecx
 249:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 24c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 250:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 254:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 257:	83 c0 01             	add    $0x1,%eax
 25a:	84 d2                	test   %dl,%dl
 25c:	75 f2                	jne    250 <strcpy+0x10>
    ;
  return os;
}
 25e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 261:	89 c8                	mov    %ecx,%eax
 263:	c9                   	leave
 264:	c3                   	ret
 265:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 26c:	00 
 26d:	8d 76 00             	lea    0x0(%esi),%esi

00000270 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	53                   	push   %ebx
 274:	8b 55 08             	mov    0x8(%ebp),%edx
 277:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 27a:	0f b6 02             	movzbl (%edx),%eax
 27d:	84 c0                	test   %al,%al
 27f:	75 2f                	jne    2b0 <strcmp+0x40>
 281:	eb 4a                	jmp    2cd <strcmp+0x5d>
 283:	eb 1b                	jmp    2a0 <strcmp+0x30>
 285:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 28c:	00 
 28d:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 294:	00 
 295:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 29c:	00 
 29d:	8d 76 00             	lea    0x0(%esi),%esi
 2a0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 2a4:	83 c2 01             	add    $0x1,%edx
 2a7:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 2aa:	84 c0                	test   %al,%al
 2ac:	74 12                	je     2c0 <strcmp+0x50>
 2ae:	89 d9                	mov    %ebx,%ecx
 2b0:	0f b6 19             	movzbl (%ecx),%ebx
 2b3:	38 c3                	cmp    %al,%bl
 2b5:	74 e9                	je     2a0 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 2b7:	29 d8                	sub    %ebx,%eax
}
 2b9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2bc:	c9                   	leave
 2bd:	c3                   	ret
 2be:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 2c0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 2c4:	31 c0                	xor    %eax,%eax
 2c6:	29 d8                	sub    %ebx,%eax
}
 2c8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2cb:	c9                   	leave
 2cc:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 2cd:	0f b6 19             	movzbl (%ecx),%ebx
 2d0:	31 c0                	xor    %eax,%eax
 2d2:	eb e3                	jmp    2b7 <strcmp+0x47>
 2d4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2db:	00 
 2dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002e0 <strlen>:

uint
strlen(char *s)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 2e6:	80 3a 00             	cmpb   $0x0,(%edx)
 2e9:	74 15                	je     300 <strlen+0x20>
 2eb:	31 c0                	xor    %eax,%eax
 2ed:	8d 76 00             	lea    0x0(%esi),%esi
 2f0:	83 c0 01             	add    $0x1,%eax
 2f3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 2f7:	89 c1                	mov    %eax,%ecx
 2f9:	75 f5                	jne    2f0 <strlen+0x10>
    ;
  return n;
}
 2fb:	89 c8                	mov    %ecx,%eax
 2fd:	5d                   	pop    %ebp
 2fe:	c3                   	ret
 2ff:	90                   	nop
  for(n = 0; s[n]; n++)
 300:	31 c9                	xor    %ecx,%ecx
}
 302:	5d                   	pop    %ebp
 303:	89 c8                	mov    %ecx,%eax
 305:	c3                   	ret
 306:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 30d:	00 
 30e:	66 90                	xchg   %ax,%ax

00000310 <memset>:

void*
memset(void *dst, int c, uint n)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	57                   	push   %edi
 314:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 317:	8b 4d 10             	mov    0x10(%ebp),%ecx
 31a:	8b 45 0c             	mov    0xc(%ebp),%eax
 31d:	89 d7                	mov    %edx,%edi
 31f:	fc                   	cld
 320:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 322:	8b 7d fc             	mov    -0x4(%ebp),%edi
 325:	89 d0                	mov    %edx,%eax
 327:	c9                   	leave
 328:	c3                   	ret
 329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000330 <strchr>:

char*
strchr(const char *s, char c)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	8b 45 08             	mov    0x8(%ebp),%eax
 336:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 33a:	0f b6 10             	movzbl (%eax),%edx
 33d:	84 d2                	test   %dl,%dl
 33f:	75 1a                	jne    35b <strchr+0x2b>
 341:	eb 25                	jmp    368 <strchr+0x38>
 343:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 34a:	00 
 34b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 350:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 354:	83 c0 01             	add    $0x1,%eax
 357:	84 d2                	test   %dl,%dl
 359:	74 0d                	je     368 <strchr+0x38>
    if(*s == c)
 35b:	38 d1                	cmp    %dl,%cl
 35d:	75 f1                	jne    350 <strchr+0x20>
      return (char*)s;
  return 0;
}
 35f:	5d                   	pop    %ebp
 360:	c3                   	ret
 361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 368:	31 c0                	xor    %eax,%eax
}
 36a:	5d                   	pop    %ebp
 36b:	c3                   	ret
 36c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000370 <gets>:

char*
gets(char *buf, int max)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	57                   	push   %edi
 374:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 375:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 378:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 379:	31 db                	xor    %ebx,%ebx
{
 37b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 37e:	eb 27                	jmp    3a7 <gets+0x37>
    cc = read(0, &c, 1);
 380:	83 ec 04             	sub    $0x4,%esp
 383:	6a 01                	push   $0x1
 385:	56                   	push   %esi
 386:	6a 00                	push   $0x0
 388:	e8 1e 01 00 00       	call   4ab <read>
    if(cc < 1)
 38d:	83 c4 10             	add    $0x10,%esp
 390:	85 c0                	test   %eax,%eax
 392:	7e 1d                	jle    3b1 <gets+0x41>
      break;
    buf[i++] = c;
 394:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 398:	8b 55 08             	mov    0x8(%ebp),%edx
 39b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 39f:	3c 0a                	cmp    $0xa,%al
 3a1:	74 10                	je     3b3 <gets+0x43>
 3a3:	3c 0d                	cmp    $0xd,%al
 3a5:	74 0c                	je     3b3 <gets+0x43>
  for(i=0; i+1 < max; ){
 3a7:	89 df                	mov    %ebx,%edi
 3a9:	83 c3 01             	add    $0x1,%ebx
 3ac:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3af:	7c cf                	jl     380 <gets+0x10>
 3b1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 3b3:	8b 45 08             	mov    0x8(%ebp),%eax
 3b6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 3ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3bd:	5b                   	pop    %ebx
 3be:	5e                   	pop    %esi
 3bf:	5f                   	pop    %edi
 3c0:	5d                   	pop    %ebp
 3c1:	c3                   	ret
 3c2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3c9:	00 
 3ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003d0 <stat>:

int
stat(char *n, struct stat *st)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	56                   	push   %esi
 3d4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3d5:	83 ec 08             	sub    $0x8,%esp
 3d8:	6a 00                	push   $0x0
 3da:	ff 75 08             	push   0x8(%ebp)
 3dd:	e8 f1 00 00 00       	call   4d3 <open>
  if(fd < 0)
 3e2:	83 c4 10             	add    $0x10,%esp
 3e5:	85 c0                	test   %eax,%eax
 3e7:	78 27                	js     410 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 3e9:	83 ec 08             	sub    $0x8,%esp
 3ec:	ff 75 0c             	push   0xc(%ebp)
 3ef:	89 c3                	mov    %eax,%ebx
 3f1:	50                   	push   %eax
 3f2:	e8 f4 00 00 00       	call   4eb <fstat>
  close(fd);
 3f7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 3fa:	89 c6                	mov    %eax,%esi
  close(fd);
 3fc:	e8 ba 00 00 00       	call   4bb <close>
  return r;
 401:	83 c4 10             	add    $0x10,%esp
}
 404:	8d 65 f8             	lea    -0x8(%ebp),%esp
 407:	89 f0                	mov    %esi,%eax
 409:	5b                   	pop    %ebx
 40a:	5e                   	pop    %esi
 40b:	5d                   	pop    %ebp
 40c:	c3                   	ret
 40d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 410:	be ff ff ff ff       	mov    $0xffffffff,%esi
 415:	eb ed                	jmp    404 <stat+0x34>
 417:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 41e:	00 
 41f:	90                   	nop

00000420 <atoi>:

int
atoi(const char *s)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	53                   	push   %ebx
 424:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 427:	0f be 02             	movsbl (%edx),%eax
 42a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 42d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 430:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 435:	77 1e                	ja     455 <atoi+0x35>
 437:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 43e:	00 
 43f:	90                   	nop
    n = n*10 + *s++ - '0';
 440:	83 c2 01             	add    $0x1,%edx
 443:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 446:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 44a:	0f be 02             	movsbl (%edx),%eax
 44d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 450:	80 fb 09             	cmp    $0x9,%bl
 453:	76 eb                	jbe    440 <atoi+0x20>
  return n;
}
 455:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 458:	89 c8                	mov    %ecx,%eax
 45a:	c9                   	leave
 45b:	c3                   	ret
 45c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000460 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	8b 45 10             	mov    0x10(%ebp),%eax
 467:	8b 55 08             	mov    0x8(%ebp),%edx
 46a:	56                   	push   %esi
 46b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 46e:	85 c0                	test   %eax,%eax
 470:	7e 13                	jle    485 <memmove+0x25>
 472:	01 d0                	add    %edx,%eax
  dst = vdst;
 474:	89 d7                	mov    %edx,%edi
 476:	66 90                	xchg   %ax,%ax
 478:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 47f:	00 
    *dst++ = *src++;
 480:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 481:	39 f8                	cmp    %edi,%eax
 483:	75 fb                	jne    480 <memmove+0x20>
  return vdst;
}
 485:	5e                   	pop    %esi
 486:	89 d0                	mov    %edx,%eax
 488:	5f                   	pop    %edi
 489:	5d                   	pop    %ebp
 48a:	c3                   	ret

0000048b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 48b:	b8 01 00 00 00       	mov    $0x1,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret

00000493 <exit>:
SYSCALL(exit)
 493:	b8 02 00 00 00       	mov    $0x2,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret

0000049b <wait>:
SYSCALL(wait)
 49b:	b8 03 00 00 00       	mov    $0x3,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret

000004a3 <pipe>:
SYSCALL(pipe)
 4a3:	b8 04 00 00 00       	mov    $0x4,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret

000004ab <read>:
SYSCALL(read)
 4ab:	b8 05 00 00 00       	mov    $0x5,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret

000004b3 <write>:
SYSCALL(write)
 4b3:	b8 10 00 00 00       	mov    $0x10,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret

000004bb <close>:
SYSCALL(close)
 4bb:	b8 15 00 00 00       	mov    $0x15,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret

000004c3 <kill>:
SYSCALL(kill)
 4c3:	b8 06 00 00 00       	mov    $0x6,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret

000004cb <exec>:
SYSCALL(exec)
 4cb:	b8 07 00 00 00       	mov    $0x7,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret

000004d3 <open>:
SYSCALL(open)
 4d3:	b8 0f 00 00 00       	mov    $0xf,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret

000004db <mknod>:
SYSCALL(mknod)
 4db:	b8 11 00 00 00       	mov    $0x11,%eax
 4e0:	cd 40                	int    $0x40
 4e2:	c3                   	ret

000004e3 <unlink>:
SYSCALL(unlink)
 4e3:	b8 12 00 00 00       	mov    $0x12,%eax
 4e8:	cd 40                	int    $0x40
 4ea:	c3                   	ret

000004eb <fstat>:
SYSCALL(fstat)
 4eb:	b8 08 00 00 00       	mov    $0x8,%eax
 4f0:	cd 40                	int    $0x40
 4f2:	c3                   	ret

000004f3 <link>:
SYSCALL(link)
 4f3:	b8 13 00 00 00       	mov    $0x13,%eax
 4f8:	cd 40                	int    $0x40
 4fa:	c3                   	ret

000004fb <mkdir>:
SYSCALL(mkdir)
 4fb:	b8 14 00 00 00       	mov    $0x14,%eax
 500:	cd 40                	int    $0x40
 502:	c3                   	ret

00000503 <chdir>:
SYSCALL(chdir)
 503:	b8 09 00 00 00       	mov    $0x9,%eax
 508:	cd 40                	int    $0x40
 50a:	c3                   	ret

0000050b <dup>:
SYSCALL(dup)
 50b:	b8 0a 00 00 00       	mov    $0xa,%eax
 510:	cd 40                	int    $0x40
 512:	c3                   	ret

00000513 <getpid>:
SYSCALL(getpid)
 513:	b8 0b 00 00 00       	mov    $0xb,%eax
 518:	cd 40                	int    $0x40
 51a:	c3                   	ret

0000051b <sbrk>:
SYSCALL(sbrk)
 51b:	b8 0c 00 00 00       	mov    $0xc,%eax
 520:	cd 40                	int    $0x40
 522:	c3                   	ret

00000523 <sleep>:
SYSCALL(sleep)
 523:	b8 0d 00 00 00       	mov    $0xd,%eax
 528:	cd 40                	int    $0x40
 52a:	c3                   	ret

0000052b <uptime>:
SYSCALL(uptime)
 52b:	b8 0e 00 00 00       	mov    $0xe,%eax
 530:	cd 40                	int    $0x40
 532:	c3                   	ret

00000533 <bstat>:
SYSCALL(bstat)
 533:	b8 16 00 00 00       	mov    $0x16,%eax
 538:	cd 40                	int    $0x40
 53a:	c3                   	ret

0000053b <swap>:
SYSCALL(swap)
 53b:	b8 17 00 00 00       	mov    $0x17,%eax
 540:	cd 40                	int    $0x40
 542:	c3                   	ret

00000543 <gettime>:
SYSCALL(gettime)
 543:	b8 18 00 00 00       	mov    $0x18,%eax
 548:	cd 40                	int    $0x40
 54a:	c3                   	ret

0000054b <setcursor>:
SYSCALL(setcursor)
 54b:	b8 19 00 00 00       	mov    $0x19,%eax
 550:	cd 40                	int    $0x40
 552:	c3                   	ret

00000553 <uname>:
SYSCALL(uname)
 553:	b8 1a 00 00 00       	mov    $0x1a,%eax
 558:	cd 40                	int    $0x40
 55a:	c3                   	ret

0000055b <echo>:
SYSCALL(echo)
 55b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 560:	cd 40                	int    $0x40
 562:	c3                   	ret
 563:	66 90                	xchg   %ax,%ax
 565:	66 90                	xchg   %ax,%ax
 567:	66 90                	xchg   %ax,%ax
 569:	66 90                	xchg   %ax,%ax
 56b:	66 90                	xchg   %ax,%ax
 56d:	66 90                	xchg   %ax,%ax
 56f:	66 90                	xchg   %ax,%ax
 571:	66 90                	xchg   %ax,%ax
 573:	66 90                	xchg   %ax,%ax
 575:	66 90                	xchg   %ax,%ax
 577:	66 90                	xchg   %ax,%ax
 579:	66 90                	xchg   %ax,%ax
 57b:	66 90                	xchg   %ax,%ax
 57d:	66 90                	xchg   %ax,%ax
 57f:	90                   	nop

00000580 <printint.constprop.0>:
{
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn, int width, char pad_char)
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	57                   	push   %edi
 584:	56                   	push   %esi
 585:	89 c6                	mov    %eax,%esi
 587:	53                   	push   %ebx
 588:	89 d3                	mov    %edx,%ebx
 58a:	83 ec 3c             	sub    $0x3c,%esp
 58d:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 591:	85 f6                	test   %esi,%esi
 593:	0f 89 d7 00 00 00    	jns    670 <printint.constprop.0+0xf0>
 599:	83 e1 01             	and    $0x1,%ecx
 59c:	0f 84 ce 00 00 00    	je     670 <printint.constprop.0+0xf0>
    neg = 1;
 5a2:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 5a9:	f7 de                	neg    %esi
 5ab:	89 f1                	mov    %esi,%ecx
  } else {
    x = xx;
  }

  i = 0;
 5ad:	88 45 bf             	mov    %al,-0x41(%ebp)
 5b0:	31 ff                	xor    %edi,%edi
 5b2:	8d 75 d7             	lea    -0x29(%ebp),%esi
 5b5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5bc:	00 
 5bd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 5c0:	89 c8                	mov    %ecx,%eax
 5c2:	31 d2                	xor    %edx,%edx
 5c4:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 5c7:	83 c7 01             	add    $0x1,%edi
 5ca:	f7 f3                	div    %ebx
 5cc:	0f b6 92 20 0e 00 00 	movzbl 0xe20(%edx),%edx
 5d3:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 5d6:	89 ca                	mov    %ecx,%edx
 5d8:	89 c1                	mov    %eax,%ecx
 5da:	39 da                	cmp    %ebx,%edx
 5dc:	73 e2                	jae    5c0 <printint.constprop.0+0x40>

  if(neg)
 5de:	8b 55 c0             	mov    -0x40(%ebp),%edx
 5e1:	0f b6 45 bf          	movzbl -0x41(%ebp),%eax
 5e5:	85 d2                	test   %edx,%edx
 5e7:	74 0b                	je     5f4 <printint.constprop.0+0x74>
    buf[i++] = '-';
 5e9:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
 5ec:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 5f1:	8d 79 02             	lea    0x2(%ecx),%edi

  // Pad with pad_char until we hit the required width
  while(i < width)
 5f4:	39 7d 08             	cmp    %edi,0x8(%ebp)
 5f7:	0f 8e 83 00 00 00    	jle    680 <printint.constprop.0+0x100>
 5fd:	8b 55 08             	mov    0x8(%ebp),%edx
 600:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 603:	01 df                	add    %ebx,%edi
 605:	01 da                	add    %ebx,%edx
 607:	89 d1                	mov    %edx,%ecx
 609:	29 f9                	sub    %edi,%ecx
 60b:	83 e1 01             	and    $0x1,%ecx
 60e:	74 10                	je     620 <printint.constprop.0+0xa0>
    buf[i++] = pad_char;
 610:	88 07                	mov    %al,(%edi)
  while(i < width)
 612:	83 c7 01             	add    $0x1,%edi
 615:	39 d7                	cmp    %edx,%edi
 617:	74 13                	je     62c <printint.constprop.0+0xac>
 619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = pad_char;
 620:	88 07                	mov    %al,(%edi)
  while(i < width)
 622:	83 c7 02             	add    $0x2,%edi
    buf[i++] = pad_char;
 625:	88 47 ff             	mov    %al,-0x1(%edi)
  while(i < width)
 628:	39 d7                	cmp    %edx,%edi
 62a:	75 f4                	jne    620 <printint.constprop.0+0xa0>
 62c:	8b 45 08             	mov    0x8(%ebp),%eax
 62f:	8d 78 ff             	lea    -0x1(%eax),%edi

  while(--i >= 0)
 632:	01 df                	add    %ebx,%edi
 634:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 63b:	00 
 63c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 640:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 643:	83 ec 04             	sub    $0x4,%esp
 646:	88 45 d7             	mov    %al,-0x29(%ebp)
 649:	6a 01                	push   $0x1
 64b:	56                   	push   %esi
 64c:	6a 01                	push   $0x1
 64e:	e8 60 fe ff ff       	call   4b3 <write>
  while(--i >= 0)
 653:	89 f8                	mov    %edi,%eax
 655:	83 c4 10             	add    $0x10,%esp
 658:	83 ef 01             	sub    $0x1,%edi
 65b:	39 d8                	cmp    %ebx,%eax
 65d:	75 e1                	jne    640 <printint.constprop.0+0xc0>
}
 65f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 662:	5b                   	pop    %ebx
 663:	5e                   	pop    %esi
 664:	5f                   	pop    %edi
 665:	5d                   	pop    %ebp
 666:	c3                   	ret
 667:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 66e:	00 
 66f:	90                   	nop
  neg = 0;
 670:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = xx;
 677:	89 f1                	mov    %esi,%ecx
 679:	e9 2f ff ff ff       	jmp    5ad <printint.constprop.0+0x2d>
 67e:	66 90                	xchg   %ax,%ax
  while(--i >= 0)
 680:	83 ef 01             	sub    $0x1,%edi
 683:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 686:	eb aa                	jmp    632 <printint.constprop.0+0xb2>
 688:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 68f:	00 

00000690 <strncpy>:
{
 690:	55                   	push   %ebp
 691:	31 c0                	xor    %eax,%eax
 693:	89 e5                	mov    %esp,%ebp
 695:	56                   	push   %esi
 696:	8b 4d 08             	mov    0x8(%ebp),%ecx
 699:	8b 75 0c             	mov    0xc(%ebp),%esi
 69c:	53                   	push   %ebx
 69d:	8b 5d 10             	mov    0x10(%ebp),%ebx
  for (i = 0; i < n && src[i]; i++)
 6a0:	85 db                	test   %ebx,%ebx
 6a2:	7f 26                	jg     6ca <strncpy+0x3a>
 6a4:	eb 58                	jmp    6fe <strncpy+0x6e>
 6a6:	eb 18                	jmp    6c0 <strncpy+0x30>
 6a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6af:	00 
 6b0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6b7:	00 
 6b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6bf:	00 
    dest[i] = src[i];
 6c0:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  for (i = 0; i < n && src[i]; i++)
 6c3:	83 c0 01             	add    $0x1,%eax
 6c6:	39 c3                	cmp    %eax,%ebx
 6c8:	74 34                	je     6fe <strncpy+0x6e>
 6ca:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
 6ce:	84 d2                	test   %dl,%dl
 6d0:	75 ee                	jne    6c0 <strncpy+0x30>
  for (; i < n; i++)
 6d2:	39 c3                	cmp    %eax,%ebx
 6d4:	7e 28                	jle    6fe <strncpy+0x6e>
 6d6:	01 c8                	add    %ecx,%eax
 6d8:	01 d9                	add    %ebx,%ecx
 6da:	89 ca                	mov    %ecx,%edx
 6dc:	29 c2                	sub    %eax,%edx
 6de:	83 e2 01             	and    $0x1,%edx
 6e1:	74 0d                	je     6f0 <strncpy+0x60>
    dest[i] = '\0';
 6e3:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
 6e6:	83 c0 01             	add    $0x1,%eax
 6e9:	39 c8                	cmp    %ecx,%eax
 6eb:	74 11                	je     6fe <strncpy+0x6e>
 6ed:	8d 76 00             	lea    0x0(%esi),%esi
    dest[i] = '\0';
 6f0:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
 6f3:	83 c0 02             	add    $0x2,%eax
    dest[i] = '\0';
 6f6:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  for (; i < n; i++)
 6fa:	39 c8                	cmp    %ecx,%eax
 6fc:	75 f2                	jne    6f0 <strncpy+0x60>
}
 6fe:	5b                   	pop    %ebx
 6ff:	5e                   	pop    %esi
 700:	5d                   	pop    %ebp
 701:	c3                   	ret
 702:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 709:	00 
 70a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000710 <printf>:

void
printf(char *fmt, ...)
{
 710:	55                   	push   %ebp
 711:	89 e5                	mov    %esp,%ebp
 713:	57                   	push   %edi
 714:	56                   	push   %esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 715:	8d 75 0c             	lea    0xc(%ebp),%esi
{
 718:	53                   	push   %ebx
 719:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  for(i = 0; fmt[i]; i++){
 71c:	8b 55 08             	mov    0x8(%ebp),%edx
  ap = (uint*)(void*)&fmt + 1;
 71f:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 722:	0f b6 02             	movzbl (%edx),%eax
 725:	84 c0                	test   %al,%al
 727:	0f 84 88 00 00 00    	je     7b5 <printf+0xa5>
 72d:	8d 7a 01             	lea    0x1(%edx),%edi
    c = fmt[i] & 0xff;
 730:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
      if (c == '\f') {
 733:	83 fa 0c             	cmp    $0xc,%edx
 736:	0f 84 d4 01 00 00    	je     910 <printf+0x200>
        setcursor();
      } else if(c == '%'){
 73c:	83 fa 25             	cmp    $0x25,%edx
 73f:	0f 85 0b 02 00 00    	jne    950 <printf+0x240>
  for(i = 0; fmt[i]; i++){
 745:	0f b6 1f             	movzbl (%edi),%ebx
 748:	83 c7 01             	add    $0x1,%edi
 74b:	84 db                	test   %bl,%bl
 74d:	74 66                	je     7b5 <printf+0xa5>
    c = fmt[i] & 0xff;
 74f:	0f b6 c3             	movzbl %bl,%eax
 752:	ba 20 00 00 00       	mov    $0x20,%edx
 757:	31 c9                	xor    %ecx,%ecx
        pad_char = ' ';
      } else {
        putc(1, c);
      }
    } else if(state == '%'){
      if(c == '0'){
 759:	83 f8 78             	cmp    $0x78,%eax
 75c:	7f 22                	jg     780 <printf+0x70>
 75e:	83 f8 62             	cmp    $0x62,%eax
 761:	0f 8e b9 01 00 00    	jle    920 <printf+0x210>
 767:	83 e8 63             	sub    $0x63,%eax
 76a:	83 f8 15             	cmp    $0x15,%eax
 76d:	77 11                	ja     780 <printf+0x70>
 76f:	ff 24 85 70 0d 00 00 	jmp    *0xd70(,%eax,4)
 776:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 77d:	00 
 77e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 780:	83 ec 04             	sub    $0x4,%esp
 783:	8d 75 e7             	lea    -0x19(%ebp),%esi
 786:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 78a:	6a 01                	push   $0x1
 78c:	56                   	push   %esi
 78d:	6a 01                	push   $0x1
 78f:	e8 1f fd ff ff       	call   4b3 <write>
 794:	83 c4 0c             	add    $0xc,%esp
 797:	88 5d e7             	mov    %bl,-0x19(%ebp)
 79a:	6a 01                	push   $0x1
 79c:	56                   	push   %esi
 79d:	6a 01                	push   $0x1
 79f:	e8 0f fd ff ff       	call   4b3 <write>
      } else if(c == '%'){
        putc(1, '%');
        state = 0;
      } else {
        putc(1, '%');
        putc(1, c);
 7a4:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 7a7:	0f b6 07             	movzbl (%edi),%eax
 7aa:	83 c7 01             	add    $0x1,%edi
 7ad:	84 c0                	test   %al,%al
 7af:	0f 85 7b ff ff ff    	jne    730 <printf+0x20>
        state = 0;
      }
    }
  }
}
 7b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7b8:	5b                   	pop    %ebx
 7b9:	5e                   	pop    %esi
 7ba:	5f                   	pop    %edi
 7bb:	5d                   	pop    %ebp
 7bc:	c3                   	ret
 7bd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 16, 0, width, pad_char);
 7c0:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 7c3:	83 ec 08             	sub    $0x8,%esp
 7c6:	8b 06                	mov    (%esi),%eax
 7c8:	52                   	push   %edx
 7c9:	ba 10 00 00 00       	mov    $0x10,%edx
 7ce:	51                   	push   %ecx
 7cf:	31 c9                	xor    %ecx,%ecx
        printint(1, *ap, 10, 1, width, pad_char);
 7d1:	e8 aa fd ff ff       	call   580 <printint.constprop.0>
        ap++;
 7d6:	83 c6 04             	add    $0x4,%esi
 7d9:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 7dc:	0f b6 07             	movzbl (%edi),%eax
 7df:	83 c7 01             	add    $0x1,%edi
 7e2:	83 c4 10             	add    $0x10,%esp
 7e5:	84 c0                	test   %al,%al
 7e7:	0f 85 43 ff ff ff    	jne    730 <printf+0x20>
}
 7ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7f0:	5b                   	pop    %ebx
 7f1:	5e                   	pop    %esi
 7f2:	5f                   	pop    %edi
 7f3:	5d                   	pop    %ebp
 7f4:	c3                   	ret
 7f5:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 10, 1, width, pad_char);
 7f8:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 7fb:	83 ec 08             	sub    $0x8,%esp
 7fe:	8b 06                	mov    (%esi),%eax
 800:	52                   	push   %edx
 801:	ba 0a 00 00 00       	mov    $0xa,%edx
 806:	51                   	push   %ecx
 807:	b9 01 00 00 00       	mov    $0x1,%ecx
 80c:	eb c3                	jmp    7d1 <printf+0xc1>
 80e:	66 90                	xchg   %ax,%ax
        s = (char*)*ap;
 810:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 813:	8b 06                	mov    (%esi),%eax
        ap++;
 815:	83 c6 04             	add    $0x4,%esi
 818:	89 75 d4             	mov    %esi,-0x2c(%ebp)
        if(s == 0)
 81b:	85 c0                	test   %eax,%eax
 81d:	0f 85 9d 01 00 00    	jne    9c0 <printf+0x2b0>
 823:	c6 45 d0 28          	movb   $0x28,-0x30(%ebp)
          s = "(null)";
 827:	b8 68 0d 00 00       	mov    $0xd68,%eax
        int len = 0;
 82c:	31 db                	xor    %ebx,%ebx
 82e:	66 90                	xchg   %ax,%ax
        for (char *t = s; *t; t++) len++;
 830:	83 c3 01             	add    $0x1,%ebx
 833:	80 3c 18 00          	cmpb   $0x0,(%eax,%ebx,1)
 837:	75 f7                	jne    830 <printf+0x120>
        for (int j = len; j < width; j++)
 839:	39 cb                	cmp    %ecx,%ebx
 83b:	0f 8d 9c 01 00 00    	jge    9dd <printf+0x2cd>
 841:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 844:	8d 75 e7             	lea    -0x19(%ebp),%esi
 847:	89 45 c8             	mov    %eax,-0x38(%ebp)
 84a:	89 7d cc             	mov    %edi,-0x34(%ebp)
 84d:	89 df                	mov    %ebx,%edi
 84f:	89 d3                	mov    %edx,%ebx
 851:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 858:	00 
 859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 860:	83 ec 04             	sub    $0x4,%esp
 863:	88 5d e7             	mov    %bl,-0x19(%ebp)
        for (int j = len; j < width; j++)
 866:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 869:	6a 01                	push   $0x1
 86b:	56                   	push   %esi
 86c:	6a 01                	push   $0x1
 86e:	e8 40 fc ff ff       	call   4b3 <write>
        for (int j = len; j < width; j++)
 873:	8b 45 d0             	mov    -0x30(%ebp),%eax
 876:	83 c4 10             	add    $0x10,%esp
 879:	39 c7                	cmp    %eax,%edi
 87b:	7c e3                	jl     860 <printf+0x150>
        while(*s != 0){
 87d:	8b 45 c8             	mov    -0x38(%ebp),%eax
 880:	8b 7d cc             	mov    -0x34(%ebp),%edi
 883:	0f b6 08             	movzbl (%eax),%ecx
 886:	88 4d d0             	mov    %cl,-0x30(%ebp)
 889:	84 c9                	test   %cl,%cl
 88b:	0f 84 16 ff ff ff    	je     7a7 <printf+0x97>
 891:	89 c3                	mov    %eax,%ebx
 893:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 897:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 89e:	00 
 89f:	90                   	nop
  write(fd, &c, 1);
 8a0:	83 ec 04             	sub    $0x4,%esp
 8a3:	88 45 e7             	mov    %al,-0x19(%ebp)
          putc(1, *s++);
 8a6:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 8a9:	6a 01                	push   $0x1
 8ab:	56                   	push   %esi
 8ac:	6a 01                	push   $0x1
 8ae:	e8 00 fc ff ff       	call   4b3 <write>
        while(*s != 0){
 8b3:	0f b6 03             	movzbl (%ebx),%eax
 8b6:	83 c4 10             	add    $0x10,%esp
 8b9:	84 c0                	test   %al,%al
 8bb:	75 e3                	jne    8a0 <printf+0x190>
 8bd:	e9 e5 fe ff ff       	jmp    7a7 <printf+0x97>
 8c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        char ch = *ap++;
 8c8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 8cb:	83 ec 04             	sub    $0x4,%esp
 8ce:	8d 75 e7             	lea    -0x19(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 8d1:	83 c7 01             	add    $0x1,%edi
        char ch = *ap++;
 8d4:	8d 58 04             	lea    0x4(%eax),%ebx
 8d7:	8b 00                	mov    (%eax),%eax
 8d9:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 8dc:	6a 01                	push   $0x1
 8de:	56                   	push   %esi
 8df:	6a 01                	push   $0x1
 8e1:	e8 cd fb ff ff       	call   4b3 <write>
  for(i = 0; fmt[i]; i++){
 8e6:	0f b6 47 ff          	movzbl -0x1(%edi),%eax
 8ea:	83 c4 10             	add    $0x10,%esp
 8ed:	84 c0                	test   %al,%al
 8ef:	0f 84 c0 fe ff ff    	je     7b5 <printf+0xa5>
    c = fmt[i] & 0xff;
 8f5:	0f b6 d0             	movzbl %al,%edx
        char ch = *ap++;
 8f8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      if (c == '\f') {
 8fb:	83 fa 0c             	cmp    $0xc,%edx
 8fe:	0f 85 38 fe ff ff    	jne    73c <printf+0x2c>
 904:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 90b:	00 
 90c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        setcursor();
 910:	e8 36 fc ff ff       	call   54b <setcursor>
 915:	e9 8d fe ff ff       	jmp    7a7 <printf+0x97>
 91a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 920:	83 f8 30             	cmp    $0x30,%eax
 923:	74 7b                	je     9a0 <printf+0x290>
 925:	7f 49                	jg     970 <printf+0x260>
 927:	83 f8 25             	cmp    $0x25,%eax
 92a:	0f 85 50 fe ff ff    	jne    780 <printf+0x70>
  write(fd, &c, 1);
 930:	83 ec 04             	sub    $0x4,%esp
 933:	8d 75 e7             	lea    -0x19(%ebp),%esi
 936:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 93a:	6a 01                	push   $0x1
 93c:	56                   	push   %esi
 93d:	6a 01                	push   $0x1
 93f:	e8 6f fb ff ff       	call   4b3 <write>
        state = 0;
 944:	83 c4 10             	add    $0x10,%esp
 947:	e9 5b fe ff ff       	jmp    7a7 <printf+0x97>
 94c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 950:	83 ec 04             	sub    $0x4,%esp
 953:	8d 75 e7             	lea    -0x19(%ebp),%esi
 956:	88 45 e7             	mov    %al,-0x19(%ebp)
 959:	6a 01                	push   $0x1
 95b:	56                   	push   %esi
 95c:	6a 01                	push   $0x1
 95e:	e8 50 fb ff ff       	call   4b3 <write>
  for(i = 0; fmt[i]; i++){
 963:	e9 74 fe ff ff       	jmp    7dc <printf+0xcc>
 968:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 96f:	00 
 970:	8d 70 cf             	lea    -0x31(%eax),%esi
 973:	83 fe 08             	cmp    $0x8,%esi
 976:	0f 87 04 fe ff ff    	ja     780 <printf+0x70>
 97c:	0f b6 1f             	movzbl (%edi),%ebx
        width = width * 10 + (c - '0');
 97f:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
  for(i = 0; fmt[i]; i++){
 982:	83 c7 01             	add    $0x1,%edi
        width = width * 10 + (c - '0');
 985:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  for(i = 0; fmt[i]; i++){
 989:	84 db                	test   %bl,%bl
 98b:	0f 84 24 fe ff ff    	je     7b5 <printf+0xa5>
    c = fmt[i] & 0xff;
 991:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 994:	e9 c0 fd ff ff       	jmp    759 <printf+0x49>
 999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 9a0:	0f b6 1f             	movzbl (%edi),%ebx
 9a3:	83 c7 01             	add    $0x1,%edi
 9a6:	84 db                	test   %bl,%bl
 9a8:	0f 84 07 fe ff ff    	je     7b5 <printf+0xa5>
    c = fmt[i] & 0xff;
 9ae:	0f b6 c3             	movzbl %bl,%eax
 9b1:	ba 30 00 00 00       	mov    $0x30,%edx
 9b6:	e9 9e fd ff ff       	jmp    759 <printf+0x49>
 9bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        for (char *t = s; *t; t++) len++;
 9c0:	0f b6 18             	movzbl (%eax),%ebx
 9c3:	88 5d d0             	mov    %bl,-0x30(%ebp)
 9c6:	84 db                	test   %bl,%bl
 9c8:	0f 85 5e fe ff ff    	jne    82c <printf+0x11c>
        int len = 0;
 9ce:	31 db                	xor    %ebx,%ebx
        for (int j = len; j < width; j++)
 9d0:	85 c9                	test   %ecx,%ecx
 9d2:	0f 8f 69 fe ff ff    	jg     841 <printf+0x131>
 9d8:	e9 ca fd ff ff       	jmp    7a7 <printf+0x97>
 9dd:	89 c2                	mov    %eax,%edx
 9df:	8d 75 e7             	lea    -0x19(%ebp),%esi
 9e2:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 9e6:	89 d3                	mov    %edx,%ebx
 9e8:	e9 b3 fe ff ff       	jmp    8a0 <printf+0x190>
 9ed:	8d 76 00             	lea    0x0(%esi),%esi

000009f0 <fprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
fprintf(int fd, char *fmt, ...)
{
 9f0:	55                   	push   %ebp
 9f1:	89 e5                	mov    %esp,%ebp
 9f3:	57                   	push   %edi
 9f4:	56                   	push   %esi
 9f5:	53                   	push   %ebx
 9f6:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 9f9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 9fc:	0f b6 13             	movzbl (%ebx),%edx
 9ff:	83 c3 01             	add    $0x1,%ebx
 a02:	84 d2                	test   %dl,%dl
 a04:	0f 84 81 00 00 00    	je     a8b <fprintf+0x9b>
 a0a:	8d 75 10             	lea    0x10(%ebp),%esi
 a0d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 a10:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if (c == '\f') { // Detect formfeed character
 a13:	83 f8 0c             	cmp    $0xc,%eax
 a16:	0f 84 04 01 00 00    	je     b20 <fprintf+0x130>
        setcursor();
      } else
      if(c == '%'){
 a1c:	83 f8 25             	cmp    $0x25,%eax
 a1f:	0f 85 5b 01 00 00    	jne    b80 <fprintf+0x190>
  for(i = 0; fmt[i]; i++){
 a25:	0f b6 13             	movzbl (%ebx),%edx
 a28:	84 d2                	test   %dl,%dl
 a2a:	74 5f                	je     a8b <fprintf+0x9b>
    c = fmt[i] & 0xff;
 a2c:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 a2f:	80 fa 25             	cmp    $0x25,%dl
 a32:	0f 84 78 01 00 00    	je     bb0 <fprintf+0x1c0>
 a38:	83 e8 63             	sub    $0x63,%eax
 a3b:	83 f8 15             	cmp    $0x15,%eax
 a3e:	77 10                	ja     a50 <fprintf+0x60>
 a40:	ff 24 85 c8 0d 00 00 	jmp    *0xdc8(,%eax,4)
 a47:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a4e:	00 
 a4f:	90                   	nop
  write(fd, &c, 1);
 a50:	83 ec 04             	sub    $0x4,%esp
 a53:	8d 7d e7             	lea    -0x19(%ebp),%edi
 a56:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 a59:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 a5d:	6a 01                	push   $0x1
 a5f:	57                   	push   %edi
 a60:	ff 75 08             	push   0x8(%ebp)
 a63:	e8 4b fa ff ff       	call   4b3 <write>
        putc(fd, c);
 a68:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 a6c:	83 c4 0c             	add    $0xc,%esp
 a6f:	88 55 e7             	mov    %dl,-0x19(%ebp)
 a72:	6a 01                	push   $0x1
 a74:	57                   	push   %edi
 a75:	ff 75 08             	push   0x8(%ebp)
 a78:	e8 36 fa ff ff       	call   4b3 <write>
  for(i = 0; fmt[i]; i++){
 a7d:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 a81:	83 c3 02             	add    $0x2,%ebx
 a84:	83 c4 10             	add    $0x10,%esp
 a87:	84 d2                	test   %dl,%dl
 a89:	75 85                	jne    a10 <fprintf+0x20>
      }
      state = 0;
    }
  }
}
 a8b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a8e:	5b                   	pop    %ebx
 a8f:	5e                   	pop    %esi
 a90:	5f                   	pop    %edi
 a91:	5d                   	pop    %ebp
 a92:	c3                   	ret
 a93:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(1, *ap, 16, 0, width, pad_char);
 a98:	83 ec 08             	sub    $0x8,%esp
 a9b:	8b 06                	mov    (%esi),%eax
 a9d:	31 c9                	xor    %ecx,%ecx
 a9f:	ba 10 00 00 00       	mov    $0x10,%edx
 aa4:	6a 20                	push   $0x20
 aa6:	6a 00                	push   $0x0
 aa8:	e8 d3 fa ff ff       	call   580 <printint.constprop.0>
        ap++;
 aad:	83 c6 04             	add    $0x4,%esi
  for(i = 0; fmt[i]; i++){
 ab0:	eb cb                	jmp    a7d <fprintf+0x8d>
 ab2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s = (char*)*ap;
 ab8:	8b 3e                	mov    (%esi),%edi
        ap++;
 aba:	83 c6 04             	add    $0x4,%esi
        if(s == 0)
 abd:	85 ff                	test   %edi,%edi
 abf:	0f 84 fb 00 00 00    	je     bc0 <fprintf+0x1d0>
        while(*s != 0){
 ac5:	0f b6 07             	movzbl (%edi),%eax
 ac8:	84 c0                	test   %al,%al
 aca:	74 36                	je     b02 <fprintf+0x112>
 acc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 acf:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 ad2:	8b 75 08             	mov    0x8(%ebp),%esi
 ad5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 ad8:	89 fb                	mov    %edi,%ebx
 ada:	89 cf                	mov    %ecx,%edi
 adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 ae0:	83 ec 04             	sub    $0x4,%esp
 ae3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 ae6:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 ae9:	6a 01                	push   $0x1
 aeb:	57                   	push   %edi
 aec:	56                   	push   %esi
 aed:	e8 c1 f9 ff ff       	call   4b3 <write>
        while(*s != 0){
 af2:	0f b6 03             	movzbl (%ebx),%eax
 af5:	83 c4 10             	add    $0x10,%esp
 af8:	84 c0                	test   %al,%al
 afa:	75 e4                	jne    ae0 <fprintf+0xf0>
 afc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 aff:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 b02:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 b06:	83 c3 02             	add    $0x2,%ebx
 b09:	84 d2                	test   %dl,%dl
 b0b:	0f 84 7a ff ff ff    	je     a8b <fprintf+0x9b>
    c = fmt[i] & 0xff;
 b11:	0f b6 c2             	movzbl %dl,%eax
      if (c == '\f') { // Detect formfeed character
 b14:	83 f8 0c             	cmp    $0xc,%eax
 b17:	0f 85 ff fe ff ff    	jne    a1c <fprintf+0x2c>
 b1d:	8d 76 00             	lea    0x0(%esi),%esi
        setcursor();
 b20:	e8 26 fa ff ff       	call   54b <setcursor>
  for(i = 0; fmt[i]; i++){
 b25:	0f b6 13             	movzbl (%ebx),%edx
 b28:	83 c3 01             	add    $0x1,%ebx
 b2b:	84 d2                	test   %dl,%dl
 b2d:	0f 85 dd fe ff ff    	jne    a10 <fprintf+0x20>
 b33:	e9 53 ff ff ff       	jmp    a8b <fprintf+0x9b>
 b38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 b3f:	00 
        printint(1, *ap, 10, 1, width, pad_char);
 b40:	83 ec 08             	sub    $0x8,%esp
 b43:	8b 06                	mov    (%esi),%eax
 b45:	b9 01 00 00 00       	mov    $0x1,%ecx
 b4a:	ba 0a 00 00 00       	mov    $0xa,%edx
 b4f:	6a 20                	push   $0x20
 b51:	6a 00                	push   $0x0
 b53:	e9 50 ff ff ff       	jmp    aa8 <fprintf+0xb8>
 b58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 b5f:	00 
        putc(fd, *ap);
 b60:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
 b62:	83 ec 04             	sub    $0x4,%esp
 b65:	8d 7d e7             	lea    -0x19(%ebp),%edi
        putc(fd, *ap);
 b68:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 b6b:	6a 01                	push   $0x1
 b6d:	57                   	push   %edi
 b6e:	ff 75 08             	push   0x8(%ebp)
 b71:	e8 3d f9 ff ff       	call   4b3 <write>
 b76:	e9 32 ff ff ff       	jmp    aad <fprintf+0xbd>
 b7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 b80:	83 ec 04             	sub    $0x4,%esp
 b83:	8d 45 e7             	lea    -0x19(%ebp),%eax
 b86:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 b89:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 b8c:	6a 01                	push   $0x1
 b8e:	50                   	push   %eax
 b8f:	ff 75 08             	push   0x8(%ebp)
 b92:	e8 1c f9 ff ff       	call   4b3 <write>
  for(i = 0; fmt[i]; i++){
 b97:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 b9b:	83 c4 10             	add    $0x10,%esp
 b9e:	84 d2                	test   %dl,%dl
 ba0:	0f 85 6a fe ff ff    	jne    a10 <fprintf+0x20>
}
 ba6:	8d 65 f4             	lea    -0xc(%ebp),%esp
 ba9:	5b                   	pop    %ebx
 baa:	5e                   	pop    %esi
 bab:	5f                   	pop    %edi
 bac:	5d                   	pop    %ebp
 bad:	c3                   	ret
 bae:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 bb0:	83 ec 04             	sub    $0x4,%esp
 bb3:	88 55 e7             	mov    %dl,-0x19(%ebp)
 bb6:	8d 7d e7             	lea    -0x19(%ebp),%edi
 bb9:	6a 01                	push   $0x1
 bbb:	e9 b4 fe ff ff       	jmp    a74 <fprintf+0x84>
          s = "(null)";
 bc0:	bf 68 0d 00 00       	mov    $0xd68,%edi
 bc5:	b8 28 00 00 00       	mov    $0x28,%eax
 bca:	e9 fd fe ff ff       	jmp    acc <fprintf+0xdc>
 bcf:	66 90                	xchg   %ax,%ax
 bd1:	66 90                	xchg   %ax,%ax
 bd3:	66 90                	xchg   %ax,%ax
 bd5:	66 90                	xchg   %ax,%ax
 bd7:	66 90                	xchg   %ax,%ax
 bd9:	66 90                	xchg   %ax,%ax
 bdb:	66 90                	xchg   %ax,%ax
 bdd:	66 90                	xchg   %ax,%ax
 bdf:	90                   	nop

00000be0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 be0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 be1:	a1 60 14 00 00       	mov    0x1460,%eax
{
 be6:	89 e5                	mov    %esp,%ebp
 be8:	57                   	push   %edi
 be9:	56                   	push   %esi
 bea:	53                   	push   %ebx
 beb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 bee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bf1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 bf8:	00 
 bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 c00:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c02:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c04:	39 ca                	cmp    %ecx,%edx
 c06:	73 30                	jae    c38 <free+0x58>
 c08:	39 c1                	cmp    %eax,%ecx
 c0a:	72 04                	jb     c10 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c0c:	39 c2                	cmp    %eax,%edx
 c0e:	72 f0                	jb     c00 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 c10:	8b 73 fc             	mov    -0x4(%ebx),%esi
 c13:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 c16:	39 f8                	cmp    %edi,%eax
 c18:	74 36                	je     c50 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 c1a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 c1d:	8b 42 04             	mov    0x4(%edx),%eax
 c20:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 c23:	39 f1                	cmp    %esi,%ecx
 c25:	74 40                	je     c67 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 c27:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 c29:	5b                   	pop    %ebx
  freep = p;
 c2a:	89 15 60 14 00 00    	mov    %edx,0x1460
}
 c30:	5e                   	pop    %esi
 c31:	5f                   	pop    %edi
 c32:	5d                   	pop    %ebp
 c33:	c3                   	ret
 c34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c38:	39 c2                	cmp    %eax,%edx
 c3a:	72 c4                	jb     c00 <free+0x20>
 c3c:	39 c1                	cmp    %eax,%ecx
 c3e:	73 c0                	jae    c00 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 c40:	8b 73 fc             	mov    -0x4(%ebx),%esi
 c43:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 c46:	39 f8                	cmp    %edi,%eax
 c48:	75 d0                	jne    c1a <free+0x3a>
 c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 c50:	03 70 04             	add    0x4(%eax),%esi
 c53:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 c56:	8b 02                	mov    (%edx),%eax
 c58:	8b 00                	mov    (%eax),%eax
 c5a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 c5d:	8b 42 04             	mov    0x4(%edx),%eax
 c60:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 c63:	39 f1                	cmp    %esi,%ecx
 c65:	75 c0                	jne    c27 <free+0x47>
    p->s.size += bp->s.size;
 c67:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 c6a:	89 15 60 14 00 00    	mov    %edx,0x1460
    p->s.size += bp->s.size;
 c70:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 c73:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 c76:	89 0a                	mov    %ecx,(%edx)
}
 c78:	5b                   	pop    %ebx
 c79:	5e                   	pop    %esi
 c7a:	5f                   	pop    %edi
 c7b:	5d                   	pop    %ebp
 c7c:	c3                   	ret
 c7d:	8d 76 00             	lea    0x0(%esi),%esi

00000c80 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c80:	55                   	push   %ebp
 c81:	89 e5                	mov    %esp,%ebp
 c83:	57                   	push   %edi
 c84:	56                   	push   %esi
 c85:	53                   	push   %ebx
 c86:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c89:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 c8c:	8b 15 60 14 00 00    	mov    0x1460,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c92:	8d 78 07             	lea    0x7(%eax),%edi
 c95:	c1 ef 03             	shr    $0x3,%edi
 c98:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 c9b:	85 d2                	test   %edx,%edx
 c9d:	0f 84 8d 00 00 00    	je     d30 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ca3:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 ca5:	8b 48 04             	mov    0x4(%eax),%ecx
 ca8:	39 f9                	cmp    %edi,%ecx
 caa:	73 64                	jae    d10 <malloc+0x90>
  if(nu < 4096)
 cac:	bb 00 10 00 00       	mov    $0x1000,%ebx
 cb1:	39 df                	cmp    %ebx,%edi
 cb3:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 cb6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 cbd:	eb 0a                	jmp    cc9 <malloc+0x49>
 cbf:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cc0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 cc2:	8b 48 04             	mov    0x4(%eax),%ecx
 cc5:	39 f9                	cmp    %edi,%ecx
 cc7:	73 47                	jae    d10 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 cc9:	89 c2                	mov    %eax,%edx
 ccb:	39 05 60 14 00 00    	cmp    %eax,0x1460
 cd1:	75 ed                	jne    cc0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 cd3:	83 ec 0c             	sub    $0xc,%esp
 cd6:	56                   	push   %esi
 cd7:	e8 3f f8 ff ff       	call   51b <sbrk>
  if(p == (char*)-1)
 cdc:	83 c4 10             	add    $0x10,%esp
 cdf:	83 f8 ff             	cmp    $0xffffffff,%eax
 ce2:	74 1c                	je     d00 <malloc+0x80>
  hp->s.size = nu;
 ce4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 ce7:	83 ec 0c             	sub    $0xc,%esp
 cea:	83 c0 08             	add    $0x8,%eax
 ced:	50                   	push   %eax
 cee:	e8 ed fe ff ff       	call   be0 <free>
  return freep;
 cf3:	8b 15 60 14 00 00    	mov    0x1460,%edx
      if((p = morecore(nunits)) == 0)
 cf9:	83 c4 10             	add    $0x10,%esp
 cfc:	85 d2                	test   %edx,%edx
 cfe:	75 c0                	jne    cc0 <malloc+0x40>
        return 0;
  }
}
 d00:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 d03:	31 c0                	xor    %eax,%eax
}
 d05:	5b                   	pop    %ebx
 d06:	5e                   	pop    %esi
 d07:	5f                   	pop    %edi
 d08:	5d                   	pop    %ebp
 d09:	c3                   	ret
 d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 d10:	39 cf                	cmp    %ecx,%edi
 d12:	74 4c                	je     d60 <malloc+0xe0>
        p->s.size -= nunits;
 d14:	29 f9                	sub    %edi,%ecx
 d16:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 d19:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 d1c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 d1f:	89 15 60 14 00 00    	mov    %edx,0x1460
}
 d25:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 d28:	83 c0 08             	add    $0x8,%eax
}
 d2b:	5b                   	pop    %ebx
 d2c:	5e                   	pop    %esi
 d2d:	5f                   	pop    %edi
 d2e:	5d                   	pop    %ebp
 d2f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 d30:	c7 05 60 14 00 00 64 	movl   $0x1464,0x1460
 d37:	14 00 00 
    base.s.size = 0;
 d3a:	b8 64 14 00 00       	mov    $0x1464,%eax
    base.s.ptr = freep = prevp = &base;
 d3f:	c7 05 64 14 00 00 64 	movl   $0x1464,0x1464
 d46:	14 00 00 
    base.s.size = 0;
 d49:	c7 05 68 14 00 00 00 	movl   $0x0,0x1468
 d50:	00 00 00 
    if(p->s.size >= nunits){
 d53:	e9 54 ff ff ff       	jmp    cac <malloc+0x2c>
 d58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 d5f:	00 
        prevp->s.ptr = p->s.ptr;
 d60:	8b 08                	mov    (%eax),%ecx
 d62:	89 0a                	mov    %ecx,(%edx)
 d64:	eb b9                	jmp    d1f <malloc+0x9f>
