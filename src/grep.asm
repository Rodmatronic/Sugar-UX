
_grep:     file format elf32-i386


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
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 18             	sub    $0x18,%esp
  14:	8b 01                	mov    (%ecx),%eax
  16:	8b 59 04             	mov    0x4(%ecx),%ebx
  19:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int fd, i;
  char *pattern;

  if(argc <= 1){
  1c:	83 f8 01             	cmp    $0x1,%eax
  1f:	7e 6e                	jle    8f <main+0x8f>
    printf("usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
  21:	8b 43 04             	mov    0x4(%ebx),%eax
  24:	83 c3 08             	add    $0x8,%ebx

  if(argc <= 2){
  27:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
  2b:	be 02 00 00 00       	mov    $0x2,%esi
  pattern = argv[1];
  30:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(argc <= 2){
  33:	74 6c                	je     a1 <main+0xa1>
  35:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  3c:	00 
  3d:	8d 76 00             	lea    0x0(%esi),%esi
    if((fd = open(argv[i], 0)) < 0){
  40:	83 ec 08             	sub    $0x8,%esp
  43:	6a 00                	push   $0x0
  45:	ff 33                	push   (%ebx)
  47:	e8 07 06 00 00       	call   653 <open>
  4c:	83 c4 10             	add    $0x10,%esp
  4f:	89 c7                	mov    %eax,%edi
  51:	85 c0                	test   %eax,%eax
  53:	78 27                	js     7c <main+0x7c>
      printf("grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
  55:	83 ec 08             	sub    $0x8,%esp
  for(i = 2; i < argc; i++){
  58:	83 c6 01             	add    $0x1,%esi
  5b:	83 c3 04             	add    $0x4,%ebx
    grep(pattern, fd);
  5e:	50                   	push   %eax
  5f:	ff 75 e0             	push   -0x20(%ebp)
  62:	e8 99 01 00 00       	call   200 <grep>
    close(fd);
  67:	89 3c 24             	mov    %edi,(%esp)
  6a:	e8 cc 05 00 00       	call   63b <close>
  for(i = 2; i < argc; i++){
  6f:	83 c4 10             	add    $0x10,%esp
  72:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  75:	7f c9                	jg     40 <main+0x40>
  }
  exit();
  77:	e8 97 05 00 00       	call   613 <exit>
      printf("grep: cannot open %s\n", argv[i]);
  7c:	50                   	push   %eax
  7d:	50                   	push   %eax
  7e:	ff 33                	push   (%ebx)
  80:	68 08 0f 00 00       	push   $0xf08
  85:	e8 06 08 00 00       	call   890 <printf>
      exit();
  8a:	e8 84 05 00 00       	call   613 <exit>
    printf("usage: grep pattern [file ...]\n");
  8f:	83 ec 0c             	sub    $0xc,%esp
  92:	68 e8 0e 00 00       	push   $0xee8
  97:	e8 f4 07 00 00       	call   890 <printf>
    exit();
  9c:	e8 72 05 00 00       	call   613 <exit>
    grep(pattern, 0);
  a1:	52                   	push   %edx
  a2:	52                   	push   %edx
  a3:	6a 00                	push   $0x0
  a5:	50                   	push   %eax
  a6:	e8 55 01 00 00       	call   200 <grep>
    exit();
  ab:	e8 63 05 00 00       	call   613 <exit>

000000b0 <matchhere>:
  return 0;
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	57                   	push   %edi
  b4:	56                   	push   %esi
  b5:	53                   	push   %ebx
  b6:	83 ec 1c             	sub    $0x1c,%esp
  b9:	8b 75 08             	mov    0x8(%ebp),%esi
  bc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '\0')
  bf:	0f b6 16             	movzbl (%esi),%edx
  c2:	84 d2                	test   %dl,%dl
  c4:	0f 84 a6 00 00 00    	je     170 <matchhere+0xc0>
    return 1;
  if(re[1] == '*')
  ca:	0f b6 46 01          	movzbl 0x1(%esi),%eax
  ce:	3c 2a                	cmp    $0x2a,%al
  d0:	74 3f                	je     111 <matchhere+0x61>
  d2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  d9:	00 
  da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  e0:	0f b6 0b             	movzbl (%ebx),%ecx
  if(re[0] == '$' && re[1] == '\0')
  e3:	80 fa 24             	cmp    $0x24,%dl
  e6:	74 68                	je     150 <matchhere+0xa0>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  e8:	84 c9                	test   %cl,%cl
  ea:	0f 84 90 00 00 00    	je     180 <matchhere+0xd0>
  f0:	80 fa 2e             	cmp    $0x2e,%dl
  f3:	74 08                	je     fd <matchhere+0x4d>
  f5:	38 d1                	cmp    %dl,%cl
  f7:	0f 85 83 00 00 00    	jne    180 <matchhere+0xd0>
    return matchhere(re+1, text+1);
  fd:	83 c3 01             	add    $0x1,%ebx
 100:	83 c6 01             	add    $0x1,%esi
  if(re[0] == '\0')
 103:	84 c0                	test   %al,%al
 105:	74 69                	je     170 <matchhere+0xc0>
{
 107:	89 c2                	mov    %eax,%edx
  if(re[1] == '*')
 109:	0f b6 46 01          	movzbl 0x1(%esi),%eax
 10d:	3c 2a                	cmp    $0x2a,%al
 10f:	75 cf                	jne    e0 <matchhere+0x30>
    return matchstar(re[0], re+2, text);
 111:	83 c6 02             	add    $0x2,%esi
int matchstar(int c, char *re, char *text)
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
 114:	80 fa 2e             	cmp    $0x2e,%dl
 117:	0f 94 c0             	sete   %al
 11a:	89 c7                	mov    %eax,%edi
 11c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(matchhere(re, text))
 120:	83 ec 08             	sub    $0x8,%esp
 123:	88 55 e7             	mov    %dl,-0x19(%ebp)
 126:	53                   	push   %ebx
 127:	56                   	push   %esi
 128:	e8 83 ff ff ff       	call   b0 <matchhere>
 12d:	83 c4 10             	add    $0x10,%esp
 130:	85 c0                	test   %eax,%eax
 132:	75 41                	jne    175 <matchhere+0xc5>
  }while(*text!='\0' && (*text++==c || c=='.'));
 134:	0f b6 0b             	movzbl (%ebx),%ecx
 137:	84 c9                	test   %cl,%cl
 139:	74 3a                	je     175 <matchhere+0xc5>
 13b:	0f b6 55 e7          	movzbl -0x19(%ebp),%edx
 13f:	83 c3 01             	add    $0x1,%ebx
 142:	38 d1                	cmp    %dl,%cl
 144:	74 da                	je     120 <matchhere+0x70>
 146:	89 f9                	mov    %edi,%ecx
 148:	84 c9                	test   %cl,%cl
 14a:	75 d4                	jne    120 <matchhere+0x70>
 14c:	eb 27                	jmp    175 <matchhere+0xc5>
 14e:	66 90                	xchg   %ax,%ax
  if(re[0] == '$' && re[1] == '\0')
 150:	84 c0                	test   %al,%al
 152:	74 36                	je     18a <matchhere+0xda>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 154:	84 c9                	test   %cl,%cl
 156:	74 28                	je     180 <matchhere+0xd0>
 158:	80 f9 24             	cmp    $0x24,%cl
 15b:	75 23                	jne    180 <matchhere+0xd0>
    return matchhere(re+1, text+1);
 15d:	83 c3 01             	add    $0x1,%ebx
 160:	83 c6 01             	add    $0x1,%esi
{
 163:	89 c2                	mov    %eax,%edx
 165:	eb a2                	jmp    109 <matchhere+0x59>
 167:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 16e:	00 
 16f:	90                   	nop
    return 1;
 170:	b8 01 00 00 00       	mov    $0x1,%eax
}
 175:	8d 65 f4             	lea    -0xc(%ebp),%esp
 178:	5b                   	pop    %ebx
 179:	5e                   	pop    %esi
 17a:	5f                   	pop    %edi
 17b:	5d                   	pop    %ebp
 17c:	c3                   	ret
 17d:	8d 76 00             	lea    0x0(%esi),%esi
 180:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
 183:	31 c0                	xor    %eax,%eax
}
 185:	5b                   	pop    %ebx
 186:	5e                   	pop    %esi
 187:	5f                   	pop    %edi
 188:	5d                   	pop    %ebp
 189:	c3                   	ret
    return *text == '\0';
 18a:	31 c0                	xor    %eax,%eax
 18c:	84 c9                	test   %cl,%cl
 18e:	0f 94 c0             	sete   %al
 191:	eb e2                	jmp    175 <matchhere+0xc5>
 193:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 19a:	00 
 19b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

000001a0 <match>:
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	56                   	push   %esi
 1a4:	53                   	push   %ebx
 1a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 1a8:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(re[0] == '^')
 1ab:	80 3b 5e             	cmpb   $0x5e,(%ebx)
 1ae:	75 11                	jne    1c1 <match+0x21>
 1b0:	eb 2e                	jmp    1e0 <match+0x40>
 1b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }while(*text++ != '\0');
 1b8:	83 c6 01             	add    $0x1,%esi
 1bb:	80 7e ff 00          	cmpb   $0x0,-0x1(%esi)
 1bf:	74 11                	je     1d2 <match+0x32>
    if(matchhere(re, text))
 1c1:	83 ec 08             	sub    $0x8,%esp
 1c4:	56                   	push   %esi
 1c5:	53                   	push   %ebx
 1c6:	e8 e5 fe ff ff       	call   b0 <matchhere>
 1cb:	83 c4 10             	add    $0x10,%esp
 1ce:	85 c0                	test   %eax,%eax
 1d0:	74 e6                	je     1b8 <match+0x18>
}
 1d2:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1d5:	5b                   	pop    %ebx
 1d6:	5e                   	pop    %esi
 1d7:	5d                   	pop    %ebp
 1d8:	c3                   	ret
 1d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return matchhere(re+1, text);
 1e0:	83 c3 01             	add    $0x1,%ebx
 1e3:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
 1e6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1e9:	5b                   	pop    %ebx
 1ea:	5e                   	pop    %esi
 1eb:	5d                   	pop    %ebp
    return matchhere(re+1, text);
 1ec:	e9 bf fe ff ff       	jmp    b0 <matchhere>
 1f1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1f8:	00 
 1f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000200 <grep>:
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	57                   	push   %edi
  m = 0;
 204:	31 ff                	xor    %edi,%edi
{
 206:	56                   	push   %esi
 207:	53                   	push   %ebx
 208:	83 ec 1c             	sub    $0x1c,%esp
 20b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 20e:	89 7d e0             	mov    %edi,-0x20(%ebp)
    return matchhere(re+1, text);
 211:	8d 43 01             	lea    0x1(%ebx),%eax
 214:	89 45 dc             	mov    %eax,-0x24(%ebp)
 217:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 21e:	00 
 21f:	90                   	nop
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 220:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 223:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 228:	83 ec 04             	sub    $0x4,%esp
 22b:	29 c8                	sub    %ecx,%eax
 22d:	50                   	push   %eax
 22e:	8d 81 e0 13 00 00    	lea    0x13e0(%ecx),%eax
 234:	50                   	push   %eax
 235:	ff 75 0c             	push   0xc(%ebp)
 238:	e8 ee 03 00 00       	call   62b <read>
 23d:	83 c4 10             	add    $0x10,%esp
 240:	85 c0                	test   %eax,%eax
 242:	0f 8e fd 00 00 00    	jle    345 <grep+0x145>
    m += n;
 248:	01 45 e0             	add    %eax,-0x20(%ebp)
 24b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    buf[m] = '\0';
 24e:	bf e0 13 00 00       	mov    $0x13e0,%edi
 253:	89 de                	mov    %ebx,%esi
 255:	c6 81 e0 13 00 00 00 	movb   $0x0,0x13e0(%ecx)
    while((q = strchr(p, '\n')) != 0){
 25c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 260:	83 ec 08             	sub    $0x8,%esp
 263:	6a 0a                	push   $0xa
 265:	57                   	push   %edi
 266:	e8 45 02 00 00       	call   4b0 <strchr>
 26b:	83 c4 10             	add    $0x10,%esp
 26e:	89 c2                	mov    %eax,%edx
 270:	85 c0                	test   %eax,%eax
 272:	0f 84 88 00 00 00    	je     300 <grep+0x100>
      *q = 0;
 278:	c6 02 00             	movb   $0x0,(%edx)
  if(re[0] == '^')
 27b:	80 3e 5e             	cmpb   $0x5e,(%esi)
 27e:	74 58                	je     2d8 <grep+0xd8>
 280:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 283:	89 d3                	mov    %edx,%ebx
 285:	eb 12                	jmp    299 <grep+0x99>
 287:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 28e:	00 
 28f:	90                   	nop
  }while(*text++ != '\0');
 290:	83 c7 01             	add    $0x1,%edi
 293:	80 7f ff 00          	cmpb   $0x0,-0x1(%edi)
 297:	74 37                	je     2d0 <grep+0xd0>
    if(matchhere(re, text))
 299:	83 ec 08             	sub    $0x8,%esp
 29c:	57                   	push   %edi
 29d:	56                   	push   %esi
 29e:	e8 0d fe ff ff       	call   b0 <matchhere>
 2a3:	83 c4 10             	add    $0x10,%esp
 2a6:	85 c0                	test   %eax,%eax
 2a8:	74 e6                	je     290 <grep+0x90>
        write(1, p, q+1 - p);
 2aa:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 2ad:	89 da                	mov    %ebx,%edx
 2af:	8d 5b 01             	lea    0x1(%ebx),%ebx
 2b2:	89 d8                	mov    %ebx,%eax
 2b4:	83 ec 04             	sub    $0x4,%esp
        *q = '\n';
 2b7:	c6 02 0a             	movb   $0xa,(%edx)
        write(1, p, q+1 - p);
 2ba:	29 f8                	sub    %edi,%eax
 2bc:	50                   	push   %eax
 2bd:	57                   	push   %edi
 2be:	89 df                	mov    %ebx,%edi
 2c0:	6a 01                	push   $0x1
 2c2:	e8 6c 03 00 00       	call   633 <write>
 2c7:	83 c4 10             	add    $0x10,%esp
 2ca:	eb 94                	jmp    260 <grep+0x60>
 2cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2d0:	8d 7b 01             	lea    0x1(%ebx),%edi
      p = q+1;
 2d3:	eb 8b                	jmp    260 <grep+0x60>
 2d5:	8d 76 00             	lea    0x0(%esi),%esi
    return matchhere(re+1, text);
 2d8:	83 ec 08             	sub    $0x8,%esp
 2db:	89 55 e4             	mov    %edx,-0x1c(%ebp)
 2de:	57                   	push   %edi
 2df:	ff 75 dc             	push   -0x24(%ebp)
 2e2:	e8 c9 fd ff ff       	call   b0 <matchhere>
        write(1, p, q+1 - p);
 2e7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    return matchhere(re+1, text);
 2ea:	83 c4 10             	add    $0x10,%esp
        write(1, p, q+1 - p);
 2ed:	8d 5a 01             	lea    0x1(%edx),%ebx
      if(match(pattern, p)){
 2f0:	85 c0                	test   %eax,%eax
 2f2:	75 be                	jne    2b2 <grep+0xb2>
        write(1, p, q+1 - p);
 2f4:	89 df                	mov    %ebx,%edi
 2f6:	e9 65 ff ff ff       	jmp    260 <grep+0x60>
 2fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(p == buf)
 300:	89 f3                	mov    %esi,%ebx
 302:	81 ff e0 13 00 00    	cmp    $0x13e0,%edi
 308:	74 2f                	je     339 <grep+0x139>
    if(m > 0){
 30a:	8b 45 e0             	mov    -0x20(%ebp),%eax
 30d:	85 c0                	test   %eax,%eax
 30f:	0f 8e 0b ff ff ff    	jle    220 <grep+0x20>
      m -= p - buf;
 315:	89 f8                	mov    %edi,%eax
      memmove(buf, p, m);
 317:	83 ec 04             	sub    $0x4,%esp
      m -= p - buf;
 31a:	2d e0 13 00 00       	sub    $0x13e0,%eax
 31f:	29 45 e0             	sub    %eax,-0x20(%ebp)
 322:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      memmove(buf, p, m);
 325:	51                   	push   %ecx
 326:	57                   	push   %edi
 327:	68 e0 13 00 00       	push   $0x13e0
 32c:	e8 af 02 00 00       	call   5e0 <memmove>
 331:	83 c4 10             	add    $0x10,%esp
 334:	e9 e7 fe ff ff       	jmp    220 <grep+0x20>
      m = 0;
 339:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 340:	e9 db fe ff ff       	jmp    220 <grep+0x20>
}
 345:	8d 65 f4             	lea    -0xc(%ebp),%esp
 348:	5b                   	pop    %ebx
 349:	5e                   	pop    %esi
 34a:	5f                   	pop    %edi
 34b:	5d                   	pop    %ebp
 34c:	c3                   	ret
 34d:	8d 76 00             	lea    0x0(%esi),%esi

00000350 <matchstar>:
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	57                   	push   %edi
 354:	56                   	push   %esi
 355:	53                   	push   %ebx
 356:	83 ec 1c             	sub    $0x1c,%esp
 359:	8b 5d 08             	mov    0x8(%ebp),%ebx
 35c:	8b 75 0c             	mov    0xc(%ebp),%esi
 35f:	8b 7d 10             	mov    0x10(%ebp),%edi
  }while(*text!='\0' && (*text++==c || c=='.'));
 362:	83 fb 2e             	cmp    $0x2e,%ebx
 365:	0f 94 45 e7          	sete   -0x19(%ebp)
 369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(matchhere(re, text))
 370:	83 ec 08             	sub    $0x8,%esp
 373:	57                   	push   %edi
 374:	56                   	push   %esi
 375:	e8 36 fd ff ff       	call   b0 <matchhere>
 37a:	83 c4 10             	add    $0x10,%esp
 37d:	89 c1                	mov    %eax,%ecx
 37f:	85 c0                	test   %eax,%eax
 381:	75 14                	jne    397 <matchstar+0x47>
  }while(*text!='\0' && (*text++==c || c=='.'));
 383:	0f be 07             	movsbl (%edi),%eax
 386:	84 c0                	test   %al,%al
 388:	74 0d                	je     397 <matchstar+0x47>
 38a:	83 c7 01             	add    $0x1,%edi
 38d:	39 d8                	cmp    %ebx,%eax
 38f:	74 df                	je     370 <matchstar+0x20>
 391:	80 7d e7 00          	cmpb   $0x0,-0x19(%ebp)
 395:	75 d9                	jne    370 <matchstar+0x20>
}
 397:	8d 65 f4             	lea    -0xc(%ebp),%esp
 39a:	89 c8                	mov    %ecx,%eax
 39c:	5b                   	pop    %ebx
 39d:	5e                   	pop    %esi
 39e:	5f                   	pop    %edi
 39f:	5d                   	pop    %ebp
 3a0:	c3                   	ret
 3a1:	66 90                	xchg   %ax,%ax
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

000003c0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 3c0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 3c1:	31 c0                	xor    %eax,%eax
{
 3c3:	89 e5                	mov    %esp,%ebp
 3c5:	53                   	push   %ebx
 3c6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3c9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 3cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 3d0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 3d4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 3d7:	83 c0 01             	add    $0x1,%eax
 3da:	84 d2                	test   %dl,%dl
 3dc:	75 f2                	jne    3d0 <strcpy+0x10>
    ;
  return os;
}
 3de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3e1:	89 c8                	mov    %ecx,%eax
 3e3:	c9                   	leave
 3e4:	c3                   	ret
 3e5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3ec:	00 
 3ed:	8d 76 00             	lea    0x0(%esi),%esi

000003f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	53                   	push   %ebx
 3f4:	8b 55 08             	mov    0x8(%ebp),%edx
 3f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 3fa:	0f b6 02             	movzbl (%edx),%eax
 3fd:	84 c0                	test   %al,%al
 3ff:	75 2f                	jne    430 <strcmp+0x40>
 401:	eb 4a                	jmp    44d <strcmp+0x5d>
 403:	eb 1b                	jmp    420 <strcmp+0x30>
 405:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 40c:	00 
 40d:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 414:	00 
 415:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 41c:	00 
 41d:	8d 76 00             	lea    0x0(%esi),%esi
 420:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 424:	83 c2 01             	add    $0x1,%edx
 427:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 42a:	84 c0                	test   %al,%al
 42c:	74 12                	je     440 <strcmp+0x50>
 42e:	89 d9                	mov    %ebx,%ecx
 430:	0f b6 19             	movzbl (%ecx),%ebx
 433:	38 c3                	cmp    %al,%bl
 435:	74 e9                	je     420 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 437:	29 d8                	sub    %ebx,%eax
}
 439:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 43c:	c9                   	leave
 43d:	c3                   	ret
 43e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 440:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 444:	31 c0                	xor    %eax,%eax
 446:	29 d8                	sub    %ebx,%eax
}
 448:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 44b:	c9                   	leave
 44c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 44d:	0f b6 19             	movzbl (%ecx),%ebx
 450:	31 c0                	xor    %eax,%eax
 452:	eb e3                	jmp    437 <strcmp+0x47>
 454:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 45b:	00 
 45c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000460 <strlen>:

uint
strlen(char *s)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 466:	80 3a 00             	cmpb   $0x0,(%edx)
 469:	74 15                	je     480 <strlen+0x20>
 46b:	31 c0                	xor    %eax,%eax
 46d:	8d 76 00             	lea    0x0(%esi),%esi
 470:	83 c0 01             	add    $0x1,%eax
 473:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 477:	89 c1                	mov    %eax,%ecx
 479:	75 f5                	jne    470 <strlen+0x10>
    ;
  return n;
}
 47b:	89 c8                	mov    %ecx,%eax
 47d:	5d                   	pop    %ebp
 47e:	c3                   	ret
 47f:	90                   	nop
  for(n = 0; s[n]; n++)
 480:	31 c9                	xor    %ecx,%ecx
}
 482:	5d                   	pop    %ebp
 483:	89 c8                	mov    %ecx,%eax
 485:	c3                   	ret
 486:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 48d:	00 
 48e:	66 90                	xchg   %ax,%ax

00000490 <memset>:

void*
memset(void *dst, int c, uint n)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 497:	8b 4d 10             	mov    0x10(%ebp),%ecx
 49a:	8b 45 0c             	mov    0xc(%ebp),%eax
 49d:	89 d7                	mov    %edx,%edi
 49f:	fc                   	cld
 4a0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 4a2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 4a5:	89 d0                	mov    %edx,%eax
 4a7:	c9                   	leave
 4a8:	c3                   	ret
 4a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004b0 <strchr>:

char*
strchr(const char *s, char c)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	8b 45 08             	mov    0x8(%ebp),%eax
 4b6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 4ba:	0f b6 10             	movzbl (%eax),%edx
 4bd:	84 d2                	test   %dl,%dl
 4bf:	75 1a                	jne    4db <strchr+0x2b>
 4c1:	eb 25                	jmp    4e8 <strchr+0x38>
 4c3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4ca:	00 
 4cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 4d0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 4d4:	83 c0 01             	add    $0x1,%eax
 4d7:	84 d2                	test   %dl,%dl
 4d9:	74 0d                	je     4e8 <strchr+0x38>
    if(*s == c)
 4db:	38 d1                	cmp    %dl,%cl
 4dd:	75 f1                	jne    4d0 <strchr+0x20>
      return (char*)s;
  return 0;
}
 4df:	5d                   	pop    %ebp
 4e0:	c3                   	ret
 4e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 4e8:	31 c0                	xor    %eax,%eax
}
 4ea:	5d                   	pop    %ebp
 4eb:	c3                   	ret
 4ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004f0 <gets>:

char*
gets(char *buf, int max)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	57                   	push   %edi
 4f4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 4f5:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 4f8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 4f9:	31 db                	xor    %ebx,%ebx
{
 4fb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 4fe:	eb 27                	jmp    527 <gets+0x37>
    cc = read(0, &c, 1);
 500:	83 ec 04             	sub    $0x4,%esp
 503:	6a 01                	push   $0x1
 505:	56                   	push   %esi
 506:	6a 00                	push   $0x0
 508:	e8 1e 01 00 00       	call   62b <read>
    if(cc < 1)
 50d:	83 c4 10             	add    $0x10,%esp
 510:	85 c0                	test   %eax,%eax
 512:	7e 1d                	jle    531 <gets+0x41>
      break;
    buf[i++] = c;
 514:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 518:	8b 55 08             	mov    0x8(%ebp),%edx
 51b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 51f:	3c 0a                	cmp    $0xa,%al
 521:	74 10                	je     533 <gets+0x43>
 523:	3c 0d                	cmp    $0xd,%al
 525:	74 0c                	je     533 <gets+0x43>
  for(i=0; i+1 < max; ){
 527:	89 df                	mov    %ebx,%edi
 529:	83 c3 01             	add    $0x1,%ebx
 52c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 52f:	7c cf                	jl     500 <gets+0x10>
 531:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 533:	8b 45 08             	mov    0x8(%ebp),%eax
 536:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 53a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 53d:	5b                   	pop    %ebx
 53e:	5e                   	pop    %esi
 53f:	5f                   	pop    %edi
 540:	5d                   	pop    %ebp
 541:	c3                   	ret
 542:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 549:	00 
 54a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000550 <stat>:

int
stat(char *n, struct stat *st)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	56                   	push   %esi
 554:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 555:	83 ec 08             	sub    $0x8,%esp
 558:	6a 00                	push   $0x0
 55a:	ff 75 08             	push   0x8(%ebp)
 55d:	e8 f1 00 00 00       	call   653 <open>
  if(fd < 0)
 562:	83 c4 10             	add    $0x10,%esp
 565:	85 c0                	test   %eax,%eax
 567:	78 27                	js     590 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 569:	83 ec 08             	sub    $0x8,%esp
 56c:	ff 75 0c             	push   0xc(%ebp)
 56f:	89 c3                	mov    %eax,%ebx
 571:	50                   	push   %eax
 572:	e8 f4 00 00 00       	call   66b <fstat>
  close(fd);
 577:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 57a:	89 c6                	mov    %eax,%esi
  close(fd);
 57c:	e8 ba 00 00 00       	call   63b <close>
  return r;
 581:	83 c4 10             	add    $0x10,%esp
}
 584:	8d 65 f8             	lea    -0x8(%ebp),%esp
 587:	89 f0                	mov    %esi,%eax
 589:	5b                   	pop    %ebx
 58a:	5e                   	pop    %esi
 58b:	5d                   	pop    %ebp
 58c:	c3                   	ret
 58d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 590:	be ff ff ff ff       	mov    $0xffffffff,%esi
 595:	eb ed                	jmp    584 <stat+0x34>
 597:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 59e:	00 
 59f:	90                   	nop

000005a0 <atoi>:

int
atoi(const char *s)
{
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	53                   	push   %ebx
 5a4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 5a7:	0f be 02             	movsbl (%edx),%eax
 5aa:	8d 48 d0             	lea    -0x30(%eax),%ecx
 5ad:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 5b0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 5b5:	77 1e                	ja     5d5 <atoi+0x35>
 5b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5be:	00 
 5bf:	90                   	nop
    n = n*10 + *s++ - '0';
 5c0:	83 c2 01             	add    $0x1,%edx
 5c3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 5c6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 5ca:	0f be 02             	movsbl (%edx),%eax
 5cd:	8d 58 d0             	lea    -0x30(%eax),%ebx
 5d0:	80 fb 09             	cmp    $0x9,%bl
 5d3:	76 eb                	jbe    5c0 <atoi+0x20>
  return n;
}
 5d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5d8:	89 c8                	mov    %ecx,%eax
 5da:	c9                   	leave
 5db:	c3                   	ret
 5dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000005e0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	57                   	push   %edi
 5e4:	8b 45 10             	mov    0x10(%ebp),%eax
 5e7:	8b 55 08             	mov    0x8(%ebp),%edx
 5ea:	56                   	push   %esi
 5eb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5ee:	85 c0                	test   %eax,%eax
 5f0:	7e 13                	jle    605 <memmove+0x25>
 5f2:	01 d0                	add    %edx,%eax
  dst = vdst;
 5f4:	89 d7                	mov    %edx,%edi
 5f6:	66 90                	xchg   %ax,%ax
 5f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5ff:	00 
    *dst++ = *src++;
 600:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 601:	39 f8                	cmp    %edi,%eax
 603:	75 fb                	jne    600 <memmove+0x20>
  return vdst;
}
 605:	5e                   	pop    %esi
 606:	89 d0                	mov    %edx,%eax
 608:	5f                   	pop    %edi
 609:	5d                   	pop    %ebp
 60a:	c3                   	ret

0000060b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 60b:	b8 01 00 00 00       	mov    $0x1,%eax
 610:	cd 40                	int    $0x40
 612:	c3                   	ret

00000613 <exit>:
SYSCALL(exit)
 613:	b8 02 00 00 00       	mov    $0x2,%eax
 618:	cd 40                	int    $0x40
 61a:	c3                   	ret

0000061b <wait>:
SYSCALL(wait)
 61b:	b8 03 00 00 00       	mov    $0x3,%eax
 620:	cd 40                	int    $0x40
 622:	c3                   	ret

00000623 <pipe>:
SYSCALL(pipe)
 623:	b8 04 00 00 00       	mov    $0x4,%eax
 628:	cd 40                	int    $0x40
 62a:	c3                   	ret

0000062b <read>:
SYSCALL(read)
 62b:	b8 05 00 00 00       	mov    $0x5,%eax
 630:	cd 40                	int    $0x40
 632:	c3                   	ret

00000633 <write>:
SYSCALL(write)
 633:	b8 10 00 00 00       	mov    $0x10,%eax
 638:	cd 40                	int    $0x40
 63a:	c3                   	ret

0000063b <close>:
SYSCALL(close)
 63b:	b8 15 00 00 00       	mov    $0x15,%eax
 640:	cd 40                	int    $0x40
 642:	c3                   	ret

00000643 <kill>:
SYSCALL(kill)
 643:	b8 06 00 00 00       	mov    $0x6,%eax
 648:	cd 40                	int    $0x40
 64a:	c3                   	ret

0000064b <exec>:
SYSCALL(exec)
 64b:	b8 07 00 00 00       	mov    $0x7,%eax
 650:	cd 40                	int    $0x40
 652:	c3                   	ret

00000653 <open>:
SYSCALL(open)
 653:	b8 0f 00 00 00       	mov    $0xf,%eax
 658:	cd 40                	int    $0x40
 65a:	c3                   	ret

0000065b <mknod>:
SYSCALL(mknod)
 65b:	b8 11 00 00 00       	mov    $0x11,%eax
 660:	cd 40                	int    $0x40
 662:	c3                   	ret

00000663 <unlink>:
SYSCALL(unlink)
 663:	b8 12 00 00 00       	mov    $0x12,%eax
 668:	cd 40                	int    $0x40
 66a:	c3                   	ret

0000066b <fstat>:
SYSCALL(fstat)
 66b:	b8 08 00 00 00       	mov    $0x8,%eax
 670:	cd 40                	int    $0x40
 672:	c3                   	ret

00000673 <link>:
SYSCALL(link)
 673:	b8 13 00 00 00       	mov    $0x13,%eax
 678:	cd 40                	int    $0x40
 67a:	c3                   	ret

0000067b <mkdir>:
SYSCALL(mkdir)
 67b:	b8 14 00 00 00       	mov    $0x14,%eax
 680:	cd 40                	int    $0x40
 682:	c3                   	ret

00000683 <chdir>:
SYSCALL(chdir)
 683:	b8 09 00 00 00       	mov    $0x9,%eax
 688:	cd 40                	int    $0x40
 68a:	c3                   	ret

0000068b <dup>:
SYSCALL(dup)
 68b:	b8 0a 00 00 00       	mov    $0xa,%eax
 690:	cd 40                	int    $0x40
 692:	c3                   	ret

00000693 <getpid>:
SYSCALL(getpid)
 693:	b8 0b 00 00 00       	mov    $0xb,%eax
 698:	cd 40                	int    $0x40
 69a:	c3                   	ret

0000069b <sbrk>:
SYSCALL(sbrk)
 69b:	b8 0c 00 00 00       	mov    $0xc,%eax
 6a0:	cd 40                	int    $0x40
 6a2:	c3                   	ret

000006a3 <sleep>:
SYSCALL(sleep)
 6a3:	b8 0d 00 00 00       	mov    $0xd,%eax
 6a8:	cd 40                	int    $0x40
 6aa:	c3                   	ret

000006ab <uptime>:
SYSCALL(uptime)
 6ab:	b8 0e 00 00 00       	mov    $0xe,%eax
 6b0:	cd 40                	int    $0x40
 6b2:	c3                   	ret

000006b3 <bstat>:
SYSCALL(bstat)
 6b3:	b8 16 00 00 00       	mov    $0x16,%eax
 6b8:	cd 40                	int    $0x40
 6ba:	c3                   	ret

000006bb <swap>:
SYSCALL(swap)
 6bb:	b8 17 00 00 00       	mov    $0x17,%eax
 6c0:	cd 40                	int    $0x40
 6c2:	c3                   	ret

000006c3 <gettime>:
SYSCALL(gettime)
 6c3:	b8 18 00 00 00       	mov    $0x18,%eax
 6c8:	cd 40                	int    $0x40
 6ca:	c3                   	ret

000006cb <setcursor>:
SYSCALL(setcursor)
 6cb:	b8 19 00 00 00       	mov    $0x19,%eax
 6d0:	cd 40                	int    $0x40
 6d2:	c3                   	ret

000006d3 <uname>:
SYSCALL(uname)
 6d3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 6d8:	cd 40                	int    $0x40
 6da:	c3                   	ret

000006db <echo>:
SYSCALL(echo)
 6db:	b8 1b 00 00 00       	mov    $0x1b,%eax
 6e0:	cd 40                	int    $0x40
 6e2:	c3                   	ret
 6e3:	66 90                	xchg   %ax,%ax
 6e5:	66 90                	xchg   %ax,%ax
 6e7:	66 90                	xchg   %ax,%ax
 6e9:	66 90                	xchg   %ax,%ax
 6eb:	66 90                	xchg   %ax,%ax
 6ed:	66 90                	xchg   %ax,%ax
 6ef:	66 90                	xchg   %ax,%ax
 6f1:	66 90                	xchg   %ax,%ax
 6f3:	66 90                	xchg   %ax,%ax
 6f5:	66 90                	xchg   %ax,%ax
 6f7:	66 90                	xchg   %ax,%ax
 6f9:	66 90                	xchg   %ax,%ax
 6fb:	66 90                	xchg   %ax,%ax
 6fd:	66 90                	xchg   %ax,%ax
 6ff:	90                   	nop

00000700 <printint.constprop.0>:
{
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn, int width, char pad_char)
 700:	55                   	push   %ebp
 701:	89 e5                	mov    %esp,%ebp
 703:	57                   	push   %edi
 704:	56                   	push   %esi
 705:	89 c6                	mov    %eax,%esi
 707:	53                   	push   %ebx
 708:	89 d3                	mov    %edx,%ebx
 70a:	83 ec 3c             	sub    $0x3c,%esp
 70d:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 711:	85 f6                	test   %esi,%esi
 713:	0f 89 d7 00 00 00    	jns    7f0 <printint.constprop.0+0xf0>
 719:	83 e1 01             	and    $0x1,%ecx
 71c:	0f 84 ce 00 00 00    	je     7f0 <printint.constprop.0+0xf0>
    neg = 1;
 722:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 729:	f7 de                	neg    %esi
 72b:	89 f1                	mov    %esi,%ecx
  } else {
    x = xx;
  }

  i = 0;
 72d:	88 45 bf             	mov    %al,-0x41(%ebp)
 730:	31 ff                	xor    %edi,%edi
 732:	8d 75 d7             	lea    -0x29(%ebp),%esi
 735:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 73c:	00 
 73d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 740:	89 c8                	mov    %ecx,%eax
 742:	31 d2                	xor    %edx,%edx
 744:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 747:	83 c7 01             	add    $0x1,%edi
 74a:	f7 f3                	div    %ebx
 74c:	0f b6 92 d8 0f 00 00 	movzbl 0xfd8(%edx),%edx
 753:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 756:	89 ca                	mov    %ecx,%edx
 758:	89 c1                	mov    %eax,%ecx
 75a:	39 da                	cmp    %ebx,%edx
 75c:	73 e2                	jae    740 <printint.constprop.0+0x40>

  if(neg)
 75e:	8b 55 c0             	mov    -0x40(%ebp),%edx
 761:	0f b6 45 bf          	movzbl -0x41(%ebp),%eax
 765:	85 d2                	test   %edx,%edx
 767:	74 0b                	je     774 <printint.constprop.0+0x74>
    buf[i++] = '-';
 769:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
 76c:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 771:	8d 79 02             	lea    0x2(%ecx),%edi

  // Pad with pad_char until we hit the required width
  while(i < width)
 774:	39 7d 08             	cmp    %edi,0x8(%ebp)
 777:	0f 8e 83 00 00 00    	jle    800 <printint.constprop.0+0x100>
 77d:	8b 55 08             	mov    0x8(%ebp),%edx
 780:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 783:	01 df                	add    %ebx,%edi
 785:	01 da                	add    %ebx,%edx
 787:	89 d1                	mov    %edx,%ecx
 789:	29 f9                	sub    %edi,%ecx
 78b:	83 e1 01             	and    $0x1,%ecx
 78e:	74 10                	je     7a0 <printint.constprop.0+0xa0>
    buf[i++] = pad_char;
 790:	88 07                	mov    %al,(%edi)
  while(i < width)
 792:	83 c7 01             	add    $0x1,%edi
 795:	39 d7                	cmp    %edx,%edi
 797:	74 13                	je     7ac <printint.constprop.0+0xac>
 799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = pad_char;
 7a0:	88 07                	mov    %al,(%edi)
  while(i < width)
 7a2:	83 c7 02             	add    $0x2,%edi
    buf[i++] = pad_char;
 7a5:	88 47 ff             	mov    %al,-0x1(%edi)
  while(i < width)
 7a8:	39 d7                	cmp    %edx,%edi
 7aa:	75 f4                	jne    7a0 <printint.constprop.0+0xa0>
 7ac:	8b 45 08             	mov    0x8(%ebp),%eax
 7af:	8d 78 ff             	lea    -0x1(%eax),%edi

  while(--i >= 0)
 7b2:	01 df                	add    %ebx,%edi
 7b4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7bb:	00 
 7bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 7c0:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 7c3:	83 ec 04             	sub    $0x4,%esp
 7c6:	88 45 d7             	mov    %al,-0x29(%ebp)
 7c9:	6a 01                	push   $0x1
 7cb:	56                   	push   %esi
 7cc:	6a 01                	push   $0x1
 7ce:	e8 60 fe ff ff       	call   633 <write>
  while(--i >= 0)
 7d3:	89 f8                	mov    %edi,%eax
 7d5:	83 c4 10             	add    $0x10,%esp
 7d8:	83 ef 01             	sub    $0x1,%edi
 7db:	39 d8                	cmp    %ebx,%eax
 7dd:	75 e1                	jne    7c0 <printint.constprop.0+0xc0>
}
 7df:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7e2:	5b                   	pop    %ebx
 7e3:	5e                   	pop    %esi
 7e4:	5f                   	pop    %edi
 7e5:	5d                   	pop    %ebp
 7e6:	c3                   	ret
 7e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7ee:	00 
 7ef:	90                   	nop
  neg = 0;
 7f0:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = xx;
 7f7:	89 f1                	mov    %esi,%ecx
 7f9:	e9 2f ff ff ff       	jmp    72d <printint.constprop.0+0x2d>
 7fe:	66 90                	xchg   %ax,%ax
  while(--i >= 0)
 800:	83 ef 01             	sub    $0x1,%edi
 803:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 806:	eb aa                	jmp    7b2 <printint.constprop.0+0xb2>
 808:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 80f:	00 

00000810 <strncpy>:
{
 810:	55                   	push   %ebp
 811:	31 c0                	xor    %eax,%eax
 813:	89 e5                	mov    %esp,%ebp
 815:	56                   	push   %esi
 816:	8b 4d 08             	mov    0x8(%ebp),%ecx
 819:	8b 75 0c             	mov    0xc(%ebp),%esi
 81c:	53                   	push   %ebx
 81d:	8b 5d 10             	mov    0x10(%ebp),%ebx
  for (i = 0; i < n && src[i]; i++)
 820:	85 db                	test   %ebx,%ebx
 822:	7f 26                	jg     84a <strncpy+0x3a>
 824:	eb 58                	jmp    87e <strncpy+0x6e>
 826:	eb 18                	jmp    840 <strncpy+0x30>
 828:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 82f:	00 
 830:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 837:	00 
 838:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 83f:	00 
    dest[i] = src[i];
 840:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  for (i = 0; i < n && src[i]; i++)
 843:	83 c0 01             	add    $0x1,%eax
 846:	39 c3                	cmp    %eax,%ebx
 848:	74 34                	je     87e <strncpy+0x6e>
 84a:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
 84e:	84 d2                	test   %dl,%dl
 850:	75 ee                	jne    840 <strncpy+0x30>
  for (; i < n; i++)
 852:	39 c3                	cmp    %eax,%ebx
 854:	7e 28                	jle    87e <strncpy+0x6e>
 856:	01 c8                	add    %ecx,%eax
 858:	01 d9                	add    %ebx,%ecx
 85a:	89 ca                	mov    %ecx,%edx
 85c:	29 c2                	sub    %eax,%edx
 85e:	83 e2 01             	and    $0x1,%edx
 861:	74 0d                	je     870 <strncpy+0x60>
    dest[i] = '\0';
 863:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
 866:	83 c0 01             	add    $0x1,%eax
 869:	39 c8                	cmp    %ecx,%eax
 86b:	74 11                	je     87e <strncpy+0x6e>
 86d:	8d 76 00             	lea    0x0(%esi),%esi
    dest[i] = '\0';
 870:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
 873:	83 c0 02             	add    $0x2,%eax
    dest[i] = '\0';
 876:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  for (; i < n; i++)
 87a:	39 c8                	cmp    %ecx,%eax
 87c:	75 f2                	jne    870 <strncpy+0x60>
}
 87e:	5b                   	pop    %ebx
 87f:	5e                   	pop    %esi
 880:	5d                   	pop    %ebp
 881:	c3                   	ret
 882:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 889:	00 
 88a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000890 <printf>:

void
printf(char *fmt, ...)
{
 890:	55                   	push   %ebp
 891:	89 e5                	mov    %esp,%ebp
 893:	57                   	push   %edi
 894:	56                   	push   %esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 895:	8d 75 0c             	lea    0xc(%ebp),%esi
{
 898:	53                   	push   %ebx
 899:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  for(i = 0; fmt[i]; i++){
 89c:	8b 55 08             	mov    0x8(%ebp),%edx
  ap = (uint*)(void*)&fmt + 1;
 89f:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 8a2:	0f b6 02             	movzbl (%edx),%eax
 8a5:	84 c0                	test   %al,%al
 8a7:	0f 84 88 00 00 00    	je     935 <printf+0xa5>
 8ad:	8d 7a 01             	lea    0x1(%edx),%edi
    c = fmt[i] & 0xff;
 8b0:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
      if (c == '\f') {
 8b3:	83 fa 0c             	cmp    $0xc,%edx
 8b6:	0f 84 d4 01 00 00    	je     a90 <printf+0x200>
        setcursor();
      } else if(c == '%'){
 8bc:	83 fa 25             	cmp    $0x25,%edx
 8bf:	0f 85 0b 02 00 00    	jne    ad0 <printf+0x240>
  for(i = 0; fmt[i]; i++){
 8c5:	0f b6 1f             	movzbl (%edi),%ebx
 8c8:	83 c7 01             	add    $0x1,%edi
 8cb:	84 db                	test   %bl,%bl
 8cd:	74 66                	je     935 <printf+0xa5>
    c = fmt[i] & 0xff;
 8cf:	0f b6 c3             	movzbl %bl,%eax
 8d2:	ba 20 00 00 00       	mov    $0x20,%edx
 8d7:	31 c9                	xor    %ecx,%ecx
        pad_char = ' ';
      } else {
        putc(1, c);
      }
    } else if(state == '%'){
      if(c == '0'){
 8d9:	83 f8 78             	cmp    $0x78,%eax
 8dc:	7f 22                	jg     900 <printf+0x70>
 8de:	83 f8 62             	cmp    $0x62,%eax
 8e1:	0f 8e b9 01 00 00    	jle    aa0 <printf+0x210>
 8e7:	83 e8 63             	sub    $0x63,%eax
 8ea:	83 f8 15             	cmp    $0x15,%eax
 8ed:	77 11                	ja     900 <printf+0x70>
 8ef:	ff 24 85 28 0f 00 00 	jmp    *0xf28(,%eax,4)
 8f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8fd:	00 
 8fe:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 900:	83 ec 04             	sub    $0x4,%esp
 903:	8d 75 e7             	lea    -0x19(%ebp),%esi
 906:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 90a:	6a 01                	push   $0x1
 90c:	56                   	push   %esi
 90d:	6a 01                	push   $0x1
 90f:	e8 1f fd ff ff       	call   633 <write>
 914:	83 c4 0c             	add    $0xc,%esp
 917:	88 5d e7             	mov    %bl,-0x19(%ebp)
 91a:	6a 01                	push   $0x1
 91c:	56                   	push   %esi
 91d:	6a 01                	push   $0x1
 91f:	e8 0f fd ff ff       	call   633 <write>
      } else if(c == '%'){
        putc(1, '%');
        state = 0;
      } else {
        putc(1, '%');
        putc(1, c);
 924:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 927:	0f b6 07             	movzbl (%edi),%eax
 92a:	83 c7 01             	add    $0x1,%edi
 92d:	84 c0                	test   %al,%al
 92f:	0f 85 7b ff ff ff    	jne    8b0 <printf+0x20>
        state = 0;
      }
    }
  }
}
 935:	8d 65 f4             	lea    -0xc(%ebp),%esp
 938:	5b                   	pop    %ebx
 939:	5e                   	pop    %esi
 93a:	5f                   	pop    %edi
 93b:	5d                   	pop    %ebp
 93c:	c3                   	ret
 93d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 16, 0, width, pad_char);
 940:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 943:	83 ec 08             	sub    $0x8,%esp
 946:	8b 06                	mov    (%esi),%eax
 948:	52                   	push   %edx
 949:	ba 10 00 00 00       	mov    $0x10,%edx
 94e:	51                   	push   %ecx
 94f:	31 c9                	xor    %ecx,%ecx
        printint(1, *ap, 10, 1, width, pad_char);
 951:	e8 aa fd ff ff       	call   700 <printint.constprop.0>
        ap++;
 956:	83 c6 04             	add    $0x4,%esi
 959:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 95c:	0f b6 07             	movzbl (%edi),%eax
 95f:	83 c7 01             	add    $0x1,%edi
 962:	83 c4 10             	add    $0x10,%esp
 965:	84 c0                	test   %al,%al
 967:	0f 85 43 ff ff ff    	jne    8b0 <printf+0x20>
}
 96d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 970:	5b                   	pop    %ebx
 971:	5e                   	pop    %esi
 972:	5f                   	pop    %edi
 973:	5d                   	pop    %ebp
 974:	c3                   	ret
 975:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 10, 1, width, pad_char);
 978:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 97b:	83 ec 08             	sub    $0x8,%esp
 97e:	8b 06                	mov    (%esi),%eax
 980:	52                   	push   %edx
 981:	ba 0a 00 00 00       	mov    $0xa,%edx
 986:	51                   	push   %ecx
 987:	b9 01 00 00 00       	mov    $0x1,%ecx
 98c:	eb c3                	jmp    951 <printf+0xc1>
 98e:	66 90                	xchg   %ax,%ax
        s = (char*)*ap;
 990:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 993:	8b 06                	mov    (%esi),%eax
        ap++;
 995:	83 c6 04             	add    $0x4,%esi
 998:	89 75 d4             	mov    %esi,-0x2c(%ebp)
        if(s == 0)
 99b:	85 c0                	test   %eax,%eax
 99d:	0f 85 9d 01 00 00    	jne    b40 <printf+0x2b0>
 9a3:	c6 45 d0 28          	movb   $0x28,-0x30(%ebp)
          s = "(null)";
 9a7:	b8 1e 0f 00 00       	mov    $0xf1e,%eax
        int len = 0;
 9ac:	31 db                	xor    %ebx,%ebx
 9ae:	66 90                	xchg   %ax,%ax
        for (char *t = s; *t; t++) len++;
 9b0:	83 c3 01             	add    $0x1,%ebx
 9b3:	80 3c 18 00          	cmpb   $0x0,(%eax,%ebx,1)
 9b7:	75 f7                	jne    9b0 <printf+0x120>
        for (int j = len; j < width; j++)
 9b9:	39 cb                	cmp    %ecx,%ebx
 9bb:	0f 8d 9c 01 00 00    	jge    b5d <printf+0x2cd>
 9c1:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 9c4:	8d 75 e7             	lea    -0x19(%ebp),%esi
 9c7:	89 45 c8             	mov    %eax,-0x38(%ebp)
 9ca:	89 7d cc             	mov    %edi,-0x34(%ebp)
 9cd:	89 df                	mov    %ebx,%edi
 9cf:	89 d3                	mov    %edx,%ebx
 9d1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 9d8:	00 
 9d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 9e0:	83 ec 04             	sub    $0x4,%esp
 9e3:	88 5d e7             	mov    %bl,-0x19(%ebp)
        for (int j = len; j < width; j++)
 9e6:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 9e9:	6a 01                	push   $0x1
 9eb:	56                   	push   %esi
 9ec:	6a 01                	push   $0x1
 9ee:	e8 40 fc ff ff       	call   633 <write>
        for (int j = len; j < width; j++)
 9f3:	8b 45 d0             	mov    -0x30(%ebp),%eax
 9f6:	83 c4 10             	add    $0x10,%esp
 9f9:	39 c7                	cmp    %eax,%edi
 9fb:	7c e3                	jl     9e0 <printf+0x150>
        while(*s != 0){
 9fd:	8b 45 c8             	mov    -0x38(%ebp),%eax
 a00:	8b 7d cc             	mov    -0x34(%ebp),%edi
 a03:	0f b6 08             	movzbl (%eax),%ecx
 a06:	88 4d d0             	mov    %cl,-0x30(%ebp)
 a09:	84 c9                	test   %cl,%cl
 a0b:	0f 84 16 ff ff ff    	je     927 <printf+0x97>
 a11:	89 c3                	mov    %eax,%ebx
 a13:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 a17:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a1e:	00 
 a1f:	90                   	nop
  write(fd, &c, 1);
 a20:	83 ec 04             	sub    $0x4,%esp
 a23:	88 45 e7             	mov    %al,-0x19(%ebp)
          putc(1, *s++);
 a26:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 a29:	6a 01                	push   $0x1
 a2b:	56                   	push   %esi
 a2c:	6a 01                	push   $0x1
 a2e:	e8 00 fc ff ff       	call   633 <write>
        while(*s != 0){
 a33:	0f b6 03             	movzbl (%ebx),%eax
 a36:	83 c4 10             	add    $0x10,%esp
 a39:	84 c0                	test   %al,%al
 a3b:	75 e3                	jne    a20 <printf+0x190>
 a3d:	e9 e5 fe ff ff       	jmp    927 <printf+0x97>
 a42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        char ch = *ap++;
 a48:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 a4b:	83 ec 04             	sub    $0x4,%esp
 a4e:	8d 75 e7             	lea    -0x19(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 a51:	83 c7 01             	add    $0x1,%edi
        char ch = *ap++;
 a54:	8d 58 04             	lea    0x4(%eax),%ebx
 a57:	8b 00                	mov    (%eax),%eax
 a59:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 a5c:	6a 01                	push   $0x1
 a5e:	56                   	push   %esi
 a5f:	6a 01                	push   $0x1
 a61:	e8 cd fb ff ff       	call   633 <write>
  for(i = 0; fmt[i]; i++){
 a66:	0f b6 47 ff          	movzbl -0x1(%edi),%eax
 a6a:	83 c4 10             	add    $0x10,%esp
 a6d:	84 c0                	test   %al,%al
 a6f:	0f 84 c0 fe ff ff    	je     935 <printf+0xa5>
    c = fmt[i] & 0xff;
 a75:	0f b6 d0             	movzbl %al,%edx
        char ch = *ap++;
 a78:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      if (c == '\f') {
 a7b:	83 fa 0c             	cmp    $0xc,%edx
 a7e:	0f 85 38 fe ff ff    	jne    8bc <printf+0x2c>
 a84:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a8b:	00 
 a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        setcursor();
 a90:	e8 36 fc ff ff       	call   6cb <setcursor>
 a95:	e9 8d fe ff ff       	jmp    927 <printf+0x97>
 a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 aa0:	83 f8 30             	cmp    $0x30,%eax
 aa3:	74 7b                	je     b20 <printf+0x290>
 aa5:	7f 49                	jg     af0 <printf+0x260>
 aa7:	83 f8 25             	cmp    $0x25,%eax
 aaa:	0f 85 50 fe ff ff    	jne    900 <printf+0x70>
  write(fd, &c, 1);
 ab0:	83 ec 04             	sub    $0x4,%esp
 ab3:	8d 75 e7             	lea    -0x19(%ebp),%esi
 ab6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 aba:	6a 01                	push   $0x1
 abc:	56                   	push   %esi
 abd:	6a 01                	push   $0x1
 abf:	e8 6f fb ff ff       	call   633 <write>
        state = 0;
 ac4:	83 c4 10             	add    $0x10,%esp
 ac7:	e9 5b fe ff ff       	jmp    927 <printf+0x97>
 acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 ad0:	83 ec 04             	sub    $0x4,%esp
 ad3:	8d 75 e7             	lea    -0x19(%ebp),%esi
 ad6:	88 45 e7             	mov    %al,-0x19(%ebp)
 ad9:	6a 01                	push   $0x1
 adb:	56                   	push   %esi
 adc:	6a 01                	push   $0x1
 ade:	e8 50 fb ff ff       	call   633 <write>
  for(i = 0; fmt[i]; i++){
 ae3:	e9 74 fe ff ff       	jmp    95c <printf+0xcc>
 ae8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 aef:	00 
 af0:	8d 70 cf             	lea    -0x31(%eax),%esi
 af3:	83 fe 08             	cmp    $0x8,%esi
 af6:	0f 87 04 fe ff ff    	ja     900 <printf+0x70>
 afc:	0f b6 1f             	movzbl (%edi),%ebx
        width = width * 10 + (c - '0');
 aff:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
  for(i = 0; fmt[i]; i++){
 b02:	83 c7 01             	add    $0x1,%edi
        width = width * 10 + (c - '0');
 b05:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  for(i = 0; fmt[i]; i++){
 b09:	84 db                	test   %bl,%bl
 b0b:	0f 84 24 fe ff ff    	je     935 <printf+0xa5>
    c = fmt[i] & 0xff;
 b11:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 b14:	e9 c0 fd ff ff       	jmp    8d9 <printf+0x49>
 b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 b20:	0f b6 1f             	movzbl (%edi),%ebx
 b23:	83 c7 01             	add    $0x1,%edi
 b26:	84 db                	test   %bl,%bl
 b28:	0f 84 07 fe ff ff    	je     935 <printf+0xa5>
    c = fmt[i] & 0xff;
 b2e:	0f b6 c3             	movzbl %bl,%eax
 b31:	ba 30 00 00 00       	mov    $0x30,%edx
 b36:	e9 9e fd ff ff       	jmp    8d9 <printf+0x49>
 b3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        for (char *t = s; *t; t++) len++;
 b40:	0f b6 18             	movzbl (%eax),%ebx
 b43:	88 5d d0             	mov    %bl,-0x30(%ebp)
 b46:	84 db                	test   %bl,%bl
 b48:	0f 85 5e fe ff ff    	jne    9ac <printf+0x11c>
        int len = 0;
 b4e:	31 db                	xor    %ebx,%ebx
        for (int j = len; j < width; j++)
 b50:	85 c9                	test   %ecx,%ecx
 b52:	0f 8f 69 fe ff ff    	jg     9c1 <printf+0x131>
 b58:	e9 ca fd ff ff       	jmp    927 <printf+0x97>
 b5d:	89 c2                	mov    %eax,%edx
 b5f:	8d 75 e7             	lea    -0x19(%ebp),%esi
 b62:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 b66:	89 d3                	mov    %edx,%ebx
 b68:	e9 b3 fe ff ff       	jmp    a20 <printf+0x190>
 b6d:	8d 76 00             	lea    0x0(%esi),%esi

00000b70 <fprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
fprintf(int fd, char *fmt, ...)
{
 b70:	55                   	push   %ebp
 b71:	89 e5                	mov    %esp,%ebp
 b73:	57                   	push   %edi
 b74:	56                   	push   %esi
 b75:	53                   	push   %ebx
 b76:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 b79:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 b7c:	0f b6 13             	movzbl (%ebx),%edx
 b7f:	83 c3 01             	add    $0x1,%ebx
 b82:	84 d2                	test   %dl,%dl
 b84:	0f 84 81 00 00 00    	je     c0b <fprintf+0x9b>
 b8a:	8d 75 10             	lea    0x10(%ebp),%esi
 b8d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 b90:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if (c == '\f') { // Detect formfeed character
 b93:	83 f8 0c             	cmp    $0xc,%eax
 b96:	0f 84 04 01 00 00    	je     ca0 <fprintf+0x130>
        setcursor();
      } else
      if(c == '%'){
 b9c:	83 f8 25             	cmp    $0x25,%eax
 b9f:	0f 85 5b 01 00 00    	jne    d00 <fprintf+0x190>
  for(i = 0; fmt[i]; i++){
 ba5:	0f b6 13             	movzbl (%ebx),%edx
 ba8:	84 d2                	test   %dl,%dl
 baa:	74 5f                	je     c0b <fprintf+0x9b>
    c = fmt[i] & 0xff;
 bac:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 baf:	80 fa 25             	cmp    $0x25,%dl
 bb2:	0f 84 78 01 00 00    	je     d30 <fprintf+0x1c0>
 bb8:	83 e8 63             	sub    $0x63,%eax
 bbb:	83 f8 15             	cmp    $0x15,%eax
 bbe:	77 10                	ja     bd0 <fprintf+0x60>
 bc0:	ff 24 85 80 0f 00 00 	jmp    *0xf80(,%eax,4)
 bc7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 bce:	00 
 bcf:	90                   	nop
  write(fd, &c, 1);
 bd0:	83 ec 04             	sub    $0x4,%esp
 bd3:	8d 7d e7             	lea    -0x19(%ebp),%edi
 bd6:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 bd9:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 bdd:	6a 01                	push   $0x1
 bdf:	57                   	push   %edi
 be0:	ff 75 08             	push   0x8(%ebp)
 be3:	e8 4b fa ff ff       	call   633 <write>
        putc(fd, c);
 be8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 bec:	83 c4 0c             	add    $0xc,%esp
 bef:	88 55 e7             	mov    %dl,-0x19(%ebp)
 bf2:	6a 01                	push   $0x1
 bf4:	57                   	push   %edi
 bf5:	ff 75 08             	push   0x8(%ebp)
 bf8:	e8 36 fa ff ff       	call   633 <write>
  for(i = 0; fmt[i]; i++){
 bfd:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 c01:	83 c3 02             	add    $0x2,%ebx
 c04:	83 c4 10             	add    $0x10,%esp
 c07:	84 d2                	test   %dl,%dl
 c09:	75 85                	jne    b90 <fprintf+0x20>
      }
      state = 0;
    }
  }
}
 c0b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 c0e:	5b                   	pop    %ebx
 c0f:	5e                   	pop    %esi
 c10:	5f                   	pop    %edi
 c11:	5d                   	pop    %ebp
 c12:	c3                   	ret
 c13:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(1, *ap, 16, 0, width, pad_char);
 c18:	83 ec 08             	sub    $0x8,%esp
 c1b:	8b 06                	mov    (%esi),%eax
 c1d:	31 c9                	xor    %ecx,%ecx
 c1f:	ba 10 00 00 00       	mov    $0x10,%edx
 c24:	6a 20                	push   $0x20
 c26:	6a 00                	push   $0x0
 c28:	e8 d3 fa ff ff       	call   700 <printint.constprop.0>
        ap++;
 c2d:	83 c6 04             	add    $0x4,%esi
  for(i = 0; fmt[i]; i++){
 c30:	eb cb                	jmp    bfd <fprintf+0x8d>
 c32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s = (char*)*ap;
 c38:	8b 3e                	mov    (%esi),%edi
        ap++;
 c3a:	83 c6 04             	add    $0x4,%esi
        if(s == 0)
 c3d:	85 ff                	test   %edi,%edi
 c3f:	0f 84 fb 00 00 00    	je     d40 <fprintf+0x1d0>
        while(*s != 0){
 c45:	0f b6 07             	movzbl (%edi),%eax
 c48:	84 c0                	test   %al,%al
 c4a:	74 36                	je     c82 <fprintf+0x112>
 c4c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 c4f:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 c52:	8b 75 08             	mov    0x8(%ebp),%esi
 c55:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 c58:	89 fb                	mov    %edi,%ebx
 c5a:	89 cf                	mov    %ecx,%edi
 c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 c60:	83 ec 04             	sub    $0x4,%esp
 c63:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 c66:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 c69:	6a 01                	push   $0x1
 c6b:	57                   	push   %edi
 c6c:	56                   	push   %esi
 c6d:	e8 c1 f9 ff ff       	call   633 <write>
        while(*s != 0){
 c72:	0f b6 03             	movzbl (%ebx),%eax
 c75:	83 c4 10             	add    $0x10,%esp
 c78:	84 c0                	test   %al,%al
 c7a:	75 e4                	jne    c60 <fprintf+0xf0>
 c7c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 c7f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 c82:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 c86:	83 c3 02             	add    $0x2,%ebx
 c89:	84 d2                	test   %dl,%dl
 c8b:	0f 84 7a ff ff ff    	je     c0b <fprintf+0x9b>
    c = fmt[i] & 0xff;
 c91:	0f b6 c2             	movzbl %dl,%eax
      if (c == '\f') { // Detect formfeed character
 c94:	83 f8 0c             	cmp    $0xc,%eax
 c97:	0f 85 ff fe ff ff    	jne    b9c <fprintf+0x2c>
 c9d:	8d 76 00             	lea    0x0(%esi),%esi
        setcursor();
 ca0:	e8 26 fa ff ff       	call   6cb <setcursor>
  for(i = 0; fmt[i]; i++){
 ca5:	0f b6 13             	movzbl (%ebx),%edx
 ca8:	83 c3 01             	add    $0x1,%ebx
 cab:	84 d2                	test   %dl,%dl
 cad:	0f 85 dd fe ff ff    	jne    b90 <fprintf+0x20>
 cb3:	e9 53 ff ff ff       	jmp    c0b <fprintf+0x9b>
 cb8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 cbf:	00 
        printint(1, *ap, 10, 1, width, pad_char);
 cc0:	83 ec 08             	sub    $0x8,%esp
 cc3:	8b 06                	mov    (%esi),%eax
 cc5:	b9 01 00 00 00       	mov    $0x1,%ecx
 cca:	ba 0a 00 00 00       	mov    $0xa,%edx
 ccf:	6a 20                	push   $0x20
 cd1:	6a 00                	push   $0x0
 cd3:	e9 50 ff ff ff       	jmp    c28 <fprintf+0xb8>
 cd8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 cdf:	00 
        putc(fd, *ap);
 ce0:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
 ce2:	83 ec 04             	sub    $0x4,%esp
 ce5:	8d 7d e7             	lea    -0x19(%ebp),%edi
        putc(fd, *ap);
 ce8:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 ceb:	6a 01                	push   $0x1
 ced:	57                   	push   %edi
 cee:	ff 75 08             	push   0x8(%ebp)
 cf1:	e8 3d f9 ff ff       	call   633 <write>
 cf6:	e9 32 ff ff ff       	jmp    c2d <fprintf+0xbd>
 cfb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 d00:	83 ec 04             	sub    $0x4,%esp
 d03:	8d 45 e7             	lea    -0x19(%ebp),%eax
 d06:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 d09:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 d0c:	6a 01                	push   $0x1
 d0e:	50                   	push   %eax
 d0f:	ff 75 08             	push   0x8(%ebp)
 d12:	e8 1c f9 ff ff       	call   633 <write>
  for(i = 0; fmt[i]; i++){
 d17:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 d1b:	83 c4 10             	add    $0x10,%esp
 d1e:	84 d2                	test   %dl,%dl
 d20:	0f 85 6a fe ff ff    	jne    b90 <fprintf+0x20>
}
 d26:	8d 65 f4             	lea    -0xc(%ebp),%esp
 d29:	5b                   	pop    %ebx
 d2a:	5e                   	pop    %esi
 d2b:	5f                   	pop    %edi
 d2c:	5d                   	pop    %ebp
 d2d:	c3                   	ret
 d2e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 d30:	83 ec 04             	sub    $0x4,%esp
 d33:	88 55 e7             	mov    %dl,-0x19(%ebp)
 d36:	8d 7d e7             	lea    -0x19(%ebp),%edi
 d39:	6a 01                	push   $0x1
 d3b:	e9 b4 fe ff ff       	jmp    bf4 <fprintf+0x84>
          s = "(null)";
 d40:	bf 1e 0f 00 00       	mov    $0xf1e,%edi
 d45:	b8 28 00 00 00       	mov    $0x28,%eax
 d4a:	e9 fd fe ff ff       	jmp    c4c <fprintf+0xdc>
 d4f:	66 90                	xchg   %ax,%ax
 d51:	66 90                	xchg   %ax,%ax
 d53:	66 90                	xchg   %ax,%ax
 d55:	66 90                	xchg   %ax,%ax
 d57:	66 90                	xchg   %ax,%ax
 d59:	66 90                	xchg   %ax,%ax
 d5b:	66 90                	xchg   %ax,%ax
 d5d:	66 90                	xchg   %ax,%ax
 d5f:	90                   	nop

00000d60 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 d60:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d61:	a1 e0 17 00 00       	mov    0x17e0,%eax
{
 d66:	89 e5                	mov    %esp,%ebp
 d68:	57                   	push   %edi
 d69:	56                   	push   %esi
 d6a:	53                   	push   %ebx
 d6b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 d6e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d71:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 d78:	00 
 d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 d80:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d82:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d84:	39 ca                	cmp    %ecx,%edx
 d86:	73 30                	jae    db8 <free+0x58>
 d88:	39 c1                	cmp    %eax,%ecx
 d8a:	72 04                	jb     d90 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d8c:	39 c2                	cmp    %eax,%edx
 d8e:	72 f0                	jb     d80 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 d90:	8b 73 fc             	mov    -0x4(%ebx),%esi
 d93:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 d96:	39 f8                	cmp    %edi,%eax
 d98:	74 36                	je     dd0 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 d9a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 d9d:	8b 42 04             	mov    0x4(%edx),%eax
 da0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 da3:	39 f1                	cmp    %esi,%ecx
 da5:	74 40                	je     de7 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 da7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 da9:	5b                   	pop    %ebx
  freep = p;
 daa:	89 15 e0 17 00 00    	mov    %edx,0x17e0
}
 db0:	5e                   	pop    %esi
 db1:	5f                   	pop    %edi
 db2:	5d                   	pop    %ebp
 db3:	c3                   	ret
 db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 db8:	39 c2                	cmp    %eax,%edx
 dba:	72 c4                	jb     d80 <free+0x20>
 dbc:	39 c1                	cmp    %eax,%ecx
 dbe:	73 c0                	jae    d80 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 dc0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 dc3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 dc6:	39 f8                	cmp    %edi,%eax
 dc8:	75 d0                	jne    d9a <free+0x3a>
 dca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 dd0:	03 70 04             	add    0x4(%eax),%esi
 dd3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 dd6:	8b 02                	mov    (%edx),%eax
 dd8:	8b 00                	mov    (%eax),%eax
 dda:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 ddd:	8b 42 04             	mov    0x4(%edx),%eax
 de0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 de3:	39 f1                	cmp    %esi,%ecx
 de5:	75 c0                	jne    da7 <free+0x47>
    p->s.size += bp->s.size;
 de7:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 dea:	89 15 e0 17 00 00    	mov    %edx,0x17e0
    p->s.size += bp->s.size;
 df0:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 df3:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 df6:	89 0a                	mov    %ecx,(%edx)
}
 df8:	5b                   	pop    %ebx
 df9:	5e                   	pop    %esi
 dfa:	5f                   	pop    %edi
 dfb:	5d                   	pop    %ebp
 dfc:	c3                   	ret
 dfd:	8d 76 00             	lea    0x0(%esi),%esi

00000e00 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 e00:	55                   	push   %ebp
 e01:	89 e5                	mov    %esp,%ebp
 e03:	57                   	push   %edi
 e04:	56                   	push   %esi
 e05:	53                   	push   %ebx
 e06:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 e09:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 e0c:	8b 15 e0 17 00 00    	mov    0x17e0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 e12:	8d 78 07             	lea    0x7(%eax),%edi
 e15:	c1 ef 03             	shr    $0x3,%edi
 e18:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 e1b:	85 d2                	test   %edx,%edx
 e1d:	0f 84 8d 00 00 00    	je     eb0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e23:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 e25:	8b 48 04             	mov    0x4(%eax),%ecx
 e28:	39 f9                	cmp    %edi,%ecx
 e2a:	73 64                	jae    e90 <malloc+0x90>
  if(nu < 4096)
 e2c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 e31:	39 df                	cmp    %ebx,%edi
 e33:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 e36:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 e3d:	eb 0a                	jmp    e49 <malloc+0x49>
 e3f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e40:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 e42:	8b 48 04             	mov    0x4(%eax),%ecx
 e45:	39 f9                	cmp    %edi,%ecx
 e47:	73 47                	jae    e90 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 e49:	89 c2                	mov    %eax,%edx
 e4b:	39 05 e0 17 00 00    	cmp    %eax,0x17e0
 e51:	75 ed                	jne    e40 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 e53:	83 ec 0c             	sub    $0xc,%esp
 e56:	56                   	push   %esi
 e57:	e8 3f f8 ff ff       	call   69b <sbrk>
  if(p == (char*)-1)
 e5c:	83 c4 10             	add    $0x10,%esp
 e5f:	83 f8 ff             	cmp    $0xffffffff,%eax
 e62:	74 1c                	je     e80 <malloc+0x80>
  hp->s.size = nu;
 e64:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 e67:	83 ec 0c             	sub    $0xc,%esp
 e6a:	83 c0 08             	add    $0x8,%eax
 e6d:	50                   	push   %eax
 e6e:	e8 ed fe ff ff       	call   d60 <free>
  return freep;
 e73:	8b 15 e0 17 00 00    	mov    0x17e0,%edx
      if((p = morecore(nunits)) == 0)
 e79:	83 c4 10             	add    $0x10,%esp
 e7c:	85 d2                	test   %edx,%edx
 e7e:	75 c0                	jne    e40 <malloc+0x40>
        return 0;
  }
}
 e80:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 e83:	31 c0                	xor    %eax,%eax
}
 e85:	5b                   	pop    %ebx
 e86:	5e                   	pop    %esi
 e87:	5f                   	pop    %edi
 e88:	5d                   	pop    %ebp
 e89:	c3                   	ret
 e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 e90:	39 cf                	cmp    %ecx,%edi
 e92:	74 4c                	je     ee0 <malloc+0xe0>
        p->s.size -= nunits;
 e94:	29 f9                	sub    %edi,%ecx
 e96:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 e99:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 e9c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 e9f:	89 15 e0 17 00 00    	mov    %edx,0x17e0
}
 ea5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 ea8:	83 c0 08             	add    $0x8,%eax
}
 eab:	5b                   	pop    %ebx
 eac:	5e                   	pop    %esi
 ead:	5f                   	pop    %edi
 eae:	5d                   	pop    %ebp
 eaf:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 eb0:	c7 05 e0 17 00 00 e4 	movl   $0x17e4,0x17e0
 eb7:	17 00 00 
    base.s.size = 0;
 eba:	b8 e4 17 00 00       	mov    $0x17e4,%eax
    base.s.ptr = freep = prevp = &base;
 ebf:	c7 05 e4 17 00 00 e4 	movl   $0x17e4,0x17e4
 ec6:	17 00 00 
    base.s.size = 0;
 ec9:	c7 05 e8 17 00 00 00 	movl   $0x0,0x17e8
 ed0:	00 00 00 
    if(p->s.size >= nunits){
 ed3:	e9 54 ff ff ff       	jmp    e2c <malloc+0x2c>
 ed8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 edf:	00 
        prevp->s.ptr = p->s.ptr;
 ee0:	8b 08                	mov    (%eax),%ecx
 ee2:	89 0a                	mov    %ecx,(%edx)
 ee4:	eb b9                	jmp    e9f <malloc+0x9f>
