
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

int
main(void)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	push   -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 04             	sub    $0x4,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
      11:	eb 0e                	jmp    21 <main+0x21>
      13:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(fd >= 3){
      18:	83 f8 02             	cmp    $0x2,%eax
      1b:	0f 8f fe 00 00 00    	jg     11f <main+0x11f>
  while((fd = open("console", O_RDWR)) >= 0){
      21:	83 ec 08             	sub    $0x8,%esp
      24:	6a 02                	push   $0x2
      26:	68 8e 18 00 00       	push   $0x188e
      2b:	e8 23 0f 00 00       	call   f53 <open>
      30:	83 c4 10             	add    $0x10,%esp
      33:	85 c0                	test   %eax,%eax
      35:	79 e1                	jns    18 <main+0x18>
      37:	eb 33                	jmp    6c <main+0x6c>
      39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      // Chdir must be called by the parent, not the child.
      buf[strlen(buf)-1] = 0;  // chop \n
      if(chdir(buf+3) < 0)
        printf("%s: No such file or directory\n", buf+3);
      continue;
    } if(buf[0] == 'e' && buf[1] == 'x' && buf[2] == 'i' && buf[3] == 't'){
      40:	3c 65                	cmp    $0x65,%al
      42:	75 0d                	jne    51 <main+0x51>
      44:	80 3d 01 20 00 00 78 	cmpb   $0x78,0x2001
      4b:	0f 84 af 00 00 00    	je     100 <main+0x100>
int
fork1(void)
{
  int pid;

  pid = fork();
      51:	e8 b5 0e 00 00       	call   f0b <fork>
  if(pid == -1)
      56:	83 f8 ff             	cmp    $0xffffffff,%eax
      59:	0f 84 e6 00 00 00    	je     145 <main+0x145>
    if(fork1() == 0)
      5f:	85 c0                	test   %eax,%eax
      61:	0f 84 c9 00 00 00    	je     130 <main+0x130>
    wait();
      67:	e8 af 0e 00 00       	call   f1b <wait>
  printf("# ");
      6c:	83 ec 0c             	sub    $0xc,%esp
      6f:	68 e8 17 00 00       	push   $0x17e8
      74:	e8 17 11 00 00       	call   1190 <printf>
  memset(buf, 0, nbuf);
      79:	83 c4 0c             	add    $0xc,%esp
      7c:	6a 64                	push   $0x64
      7e:	6a 00                	push   $0x0
      80:	68 00 20 00 00       	push   $0x2000
      85:	e8 06 0d 00 00       	call   d90 <memset>
  gets(buf, nbuf);
      8a:	58                   	pop    %eax
      8b:	5a                   	pop    %edx
      8c:	6a 64                	push   $0x64
      8e:	68 00 20 00 00       	push   $0x2000
      93:	e8 58 0d 00 00       	call   df0 <gets>
  if(buf[0] == 0) // EOF
      98:	0f b6 05 00 20 00 00 	movzbl 0x2000,%eax
      9f:	83 c4 10             	add    $0x10,%esp
      a2:	84 c0                	test   %al,%al
      a4:	74 74                	je     11a <main+0x11a>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      a6:	3c 63                	cmp    $0x63,%al
      a8:	75 96                	jne    40 <main+0x40>
      aa:	80 3d 01 20 00 00 64 	cmpb   $0x64,0x2001
      b1:	75 9e                	jne    51 <main+0x51>
      b3:	80 3d 02 20 00 00 20 	cmpb   $0x20,0x2002
      ba:	75 95                	jne    51 <main+0x51>
      buf[strlen(buf)-1] = 0;  // chop \n
      bc:	83 ec 0c             	sub    $0xc,%esp
      bf:	68 00 20 00 00       	push   $0x2000
      c4:	e8 97 0c 00 00       	call   d60 <strlen>
      c9:	c6 80 ff 1f 00 00 00 	movb   $0x0,0x1fff(%eax)
      if(chdir(buf+3) < 0)
      d0:	c7 04 24 03 20 00 00 	movl   $0x2003,(%esp)
      d7:	e8 a7 0e 00 00       	call   f83 <chdir>
      dc:	83 c4 10             	add    $0x10,%esp
      df:	85 c0                	test   %eax,%eax
      e1:	79 89                	jns    6c <main+0x6c>
        printf("%s: No such file or directory\n", buf+3);
      e3:	51                   	push   %ecx
      e4:	51                   	push   %ecx
      e5:	68 03 20 00 00       	push   $0x2003
      ea:	68 d0 18 00 00       	push   $0x18d0
      ef:	e8 9c 10 00 00       	call   1190 <printf>
      f4:	83 c4 10             	add    $0x10,%esp
      f7:	e9 70 ff ff ff       	jmp    6c <main+0x6c>
      fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } if(buf[0] == 'e' && buf[1] == 'x' && buf[2] == 'i' && buf[3] == 't'){
     100:	80 3d 02 20 00 00 69 	cmpb   $0x69,0x2002
     107:	0f 85 44 ff ff ff    	jne    51 <main+0x51>
     10d:	80 3d 03 20 00 00 74 	cmpb   $0x74,0x2003
     114:	0f 85 37 ff ff ff    	jne    51 <main+0x51>
      	exit();
     11a:	e8 f4 0d 00 00       	call   f13 <exit>
      close(fd);
     11f:	83 ec 0c             	sub    $0xc,%esp
     122:	50                   	push   %eax
     123:	e8 13 0e 00 00       	call   f3b <close>
      break;
     128:	83 c4 10             	add    $0x10,%esp
     12b:	e9 3c ff ff ff       	jmp    6c <main+0x6c>
      runcmd(parsecmd(buf));
     130:	83 ec 0c             	sub    $0xc,%esp
     133:	68 00 20 00 00       	push   $0x2000
     138:	e8 03 0b 00 00       	call   c40 <parsecmd>
     13d:	89 04 24             	mov    %eax,(%esp)
     140:	e8 9b 00 00 00       	call   1e0 <runcmd>
    panic("fork");
     145:	83 ec 0c             	sub    $0xc,%esp
     148:	68 eb 17 00 00       	push   $0x17eb
     14d:	e8 4e 00 00 00       	call   1a0 <panic>
     152:	66 90                	xchg   %ax,%ax
     154:	66 90                	xchg   %ax,%ax
     156:	66 90                	xchg   %ax,%ax
     158:	66 90                	xchg   %ax,%ax
     15a:	66 90                	xchg   %ax,%ax
     15c:	66 90                	xchg   %ax,%ax
     15e:	66 90                	xchg   %ax,%ax

00000160 <getcmd>:
{
     160:	55                   	push   %ebp
     161:	89 e5                	mov    %esp,%ebp
     163:	56                   	push   %esi
     164:	53                   	push   %ebx
     165:	8b 5d 08             	mov    0x8(%ebp),%ebx
     168:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf("# ");
     16b:	83 ec 0c             	sub    $0xc,%esp
     16e:	68 e8 17 00 00       	push   $0x17e8
     173:	e8 18 10 00 00       	call   1190 <printf>
  memset(buf, 0, nbuf);
     178:	83 c4 0c             	add    $0xc,%esp
     17b:	56                   	push   %esi
     17c:	6a 00                	push   $0x0
     17e:	53                   	push   %ebx
     17f:	e8 0c 0c 00 00       	call   d90 <memset>
  gets(buf, nbuf);
     184:	58                   	pop    %eax
     185:	5a                   	pop    %edx
     186:	56                   	push   %esi
     187:	53                   	push   %ebx
     188:	e8 63 0c 00 00       	call   df0 <gets>
  if(buf[0] == 0) // EOF
     18d:	83 c4 10             	add    $0x10,%esp
     190:	80 3b 01             	cmpb   $0x1,(%ebx)
     193:	19 c0                	sbb    %eax,%eax
}
     195:	8d 65 f8             	lea    -0x8(%ebp),%esp
     198:	5b                   	pop    %ebx
     199:	5e                   	pop    %esi
     19a:	5d                   	pop    %ebp
     19b:	c3                   	ret
     19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001a0 <panic>:
{
     1a0:	55                   	push   %ebp
     1a1:	89 e5                	mov    %esp,%ebp
     1a3:	83 ec 10             	sub    $0x10,%esp
  printf("%s\n", s);
     1a6:	ff 75 08             	push   0x8(%ebp)
     1a9:	68 8a 18 00 00       	push   $0x188a
     1ae:	e8 dd 0f 00 00       	call   1190 <printf>
  exit();
     1b3:	e8 5b 0d 00 00       	call   f13 <exit>
     1b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     1bf:	00 

000001c0 <fork1>:
{
     1c0:	55                   	push   %ebp
     1c1:	89 e5                	mov    %esp,%ebp
     1c3:	83 ec 08             	sub    $0x8,%esp
  pid = fork();
     1c6:	e8 40 0d 00 00       	call   f0b <fork>
  if(pid == -1)
     1cb:	83 f8 ff             	cmp    $0xffffffff,%eax
     1ce:	74 02                	je     1d2 <fork1+0x12>
  return pid;
}
     1d0:	c9                   	leave
     1d1:	c3                   	ret
    panic("fork");
     1d2:	83 ec 0c             	sub    $0xc,%esp
     1d5:	68 eb 17 00 00       	push   $0x17eb
     1da:	e8 c1 ff ff ff       	call   1a0 <panic>
     1df:	90                   	nop

000001e0 <runcmd>:
{
     1e0:	55                   	push   %ebp
     1e1:	89 e5                	mov    %esp,%ebp
     1e3:	57                   	push   %edi
     1e4:	56                   	push   %esi
     1e5:	53                   	push   %ebx
     1e6:	81 ec 8c 00 00 00    	sub    $0x8c,%esp
     1ec:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     1ef:	85 db                	test   %ebx,%ebx
     1f1:	0f 84 c2 00 00 00    	je     2b9 <runcmd+0xd9>
  switch(cmd->type){
     1f7:	83 3b 05             	cmpl   $0x5,(%ebx)
     1fa:	0f 87 69 01 00 00    	ja     369 <runcmd+0x189>
     200:	8b 03                	mov    (%ebx),%eax
     202:	ff 24 85 a0 18 00 00 	jmp    *0x18a0(,%eax,4)
  if(ecmd->argv[0] == 0)
     209:	8b 4b 04             	mov    0x4(%ebx),%ecx
     20c:	85 c9                	test   %ecx,%ecx
     20e:	0f 84 a5 00 00 00    	je     2b9 <runcmd+0xd9>
  int i = 0;
     214:	31 c0                	xor    %eax,%eax
  while (prefix[i] != '\0') {
     216:	ba 2f 00 00 00       	mov    $0x2f,%edx
     21b:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
     221:	eb 1d                	jmp    240 <runcmd+0x60>
     223:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     22a:	00 
     22b:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     232:	00 
     233:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     23a:	00 
     23b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    path[i] = prefix[i];
     240:	88 14 06             	mov    %dl,(%esi,%eax,1)
  while (prefix[i] != '\0') {
     243:	0f b6 90 f8 17 00 00 	movzbl 0x17f8(%eax),%edx
    i++;
     24a:	83 c0 01             	add    $0x1,%eax
  while (prefix[i] != '\0') {
     24d:	84 d2                	test   %dl,%dl
     24f:	75 ef                	jne    240 <runcmd+0x60>
  while (ecmd->argv[0][j] != '\0' && i < sizeof(path) - 1) {
     251:	0f b6 11             	movzbl (%ecx),%edx
     254:	83 f8 7e             	cmp    $0x7e,%eax
     257:	7f 3a                	jg     293 <runcmd+0xb3>
     259:	84 d2                	test   %dl,%dl
     25b:	74 36                	je     293 <runcmd+0xb3>
     25d:	8d bd 67 ff ff ff    	lea    -0x99(%ebp),%edi
     263:	29 c1                	sub    %eax,%ecx
     265:	eb 1e                	jmp    285 <runcmd+0xa5>
     267:	eb 17                	jmp    280 <runcmd+0xa0>
     269:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     270:	00 
     271:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     278:	00 
     279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     280:	83 f8 7f             	cmp    $0x7f,%eax
     283:	74 0e                	je     293 <runcmd+0xb3>
    path[i++] = ecmd->argv[0][j++];
     285:	83 c0 01             	add    $0x1,%eax
     288:	88 14 07             	mov    %dl,(%edi,%eax,1)
  while (ecmd->argv[0][j] != '\0' && i < sizeof(path) - 1) {
     28b:	0f b6 14 01          	movzbl (%ecx,%eax,1),%edx
     28f:	84 d2                	test   %dl,%dl
     291:	75 ed                	jne    280 <runcmd+0xa0>
  path[i] = '\0'; // Null-terminate
     293:	c6 84 05 68 ff ff ff 	movb   $0x0,-0x98(%ebp,%eax,1)
     29a:	00 
  exec(path, ecmd->argv);
     29b:	8d 43 04             	lea    0x4(%ebx),%eax
     29e:	57                   	push   %edi
     29f:	57                   	push   %edi
     2a0:	50                   	push   %eax
     2a1:	56                   	push   %esi
     2a2:	e8 a4 0c 00 00       	call   f4b <exec>
  printf("%s: not found\n", ecmd->argv[0]);
     2a7:	58                   	pop    %eax
     2a8:	5a                   	pop    %edx
     2a9:	ff 73 04             	push   0x4(%ebx)
     2ac:	68 fd 17 00 00       	push   $0x17fd
     2b1:	e8 da 0e 00 00       	call   1190 <printf>
  break;
     2b6:	83 c4 10             	add    $0x10,%esp
  exit();
     2b9:	e8 55 0c 00 00       	call   f13 <exit>
    if(fork1() == 0)
     2be:	e8 fd fe ff ff       	call   1c0 <fork1>
     2c3:	85 c0                	test   %eax,%eax
     2c5:	75 f2                	jne    2b9 <runcmd+0xd9>
     2c7:	eb 7c                	jmp    345 <runcmd+0x165>
    if(pipe(p) < 0)
     2c9:	83 ec 0c             	sub    $0xc,%esp
     2cc:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
     2d2:	50                   	push   %eax
     2d3:	e8 4b 0c 00 00       	call   f23 <pipe>
     2d8:	83 c4 10             	add    $0x10,%esp
     2db:	85 c0                	test   %eax,%eax
     2dd:	0f 88 a7 00 00 00    	js     38a <runcmd+0x1aa>
    if(fork1() == 0){
     2e3:	e8 d8 fe ff ff       	call   1c0 <fork1>
     2e8:	85 c0                	test   %eax,%eax
     2ea:	0f 84 de 00 00 00    	je     3ce <runcmd+0x1ee>
    if(fork1() == 0){
     2f0:	e8 cb fe ff ff       	call   1c0 <fork1>
     2f5:	85 c0                	test   %eax,%eax
     2f7:	0f 84 9a 00 00 00    	je     397 <runcmd+0x1b7>
    close(p[0]);
     2fd:	83 ec 0c             	sub    $0xc,%esp
     300:	ff b5 68 ff ff ff    	push   -0x98(%ebp)
     306:	e8 30 0c 00 00       	call   f3b <close>
    close(p[1]);
     30b:	58                   	pop    %eax
     30c:	ff b5 6c ff ff ff    	push   -0x94(%ebp)
     312:	e8 24 0c 00 00       	call   f3b <close>
    wait();
     317:	e8 ff 0b 00 00       	call   f1b <wait>
    wait();
     31c:	e8 fa 0b 00 00       	call   f1b <wait>
    break;
     321:	83 c4 10             	add    $0x10,%esp
     324:	eb 93                	jmp    2b9 <runcmd+0xd9>
    close(rcmd->fd);
     326:	83 ec 0c             	sub    $0xc,%esp
     329:	ff 73 14             	push   0x14(%ebx)
     32c:	e8 0a 0c 00 00       	call   f3b <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     331:	5a                   	pop    %edx
     332:	59                   	pop    %ecx
     333:	ff 73 10             	push   0x10(%ebx)
     336:	ff 73 08             	push   0x8(%ebx)
     339:	e8 15 0c 00 00       	call   f53 <open>
     33e:	83 c4 10             	add    $0x10,%esp
     341:	85 c0                	test   %eax,%eax
     343:	78 31                	js     376 <runcmd+0x196>
      runcmd(bcmd->cmd);
     345:	83 ec 0c             	sub    $0xc,%esp
     348:	ff 73 04             	push   0x4(%ebx)
     34b:	e8 90 fe ff ff       	call   1e0 <runcmd>
    if(fork1() == 0)
     350:	e8 6b fe ff ff       	call   1c0 <fork1>
     355:	85 c0                	test   %eax,%eax
     357:	74 ec                	je     345 <runcmd+0x165>
    wait();
     359:	e8 bd 0b 00 00       	call   f1b <wait>
    runcmd(lcmd->right);
     35e:	83 ec 0c             	sub    $0xc,%esp
     361:	ff 73 08             	push   0x8(%ebx)
     364:	e8 77 fe ff ff       	call   1e0 <runcmd>
    panic("runcmd");
     369:	83 ec 0c             	sub    $0xc,%esp
     36c:	68 f0 17 00 00       	push   $0x17f0
     371:	e8 2a fe ff ff       	call   1a0 <panic>
      printf("open %s failed\n", rcmd->file);
     376:	50                   	push   %eax
     377:	50                   	push   %eax
     378:	ff 73 08             	push   0x8(%ebx)
     37b:	68 0c 18 00 00       	push   $0x180c
     380:	e8 0b 0e 00 00       	call   1190 <printf>
      exit();
     385:	e8 89 0b 00 00       	call   f13 <exit>
      panic("pipe");
     38a:	83 ec 0c             	sub    $0xc,%esp
     38d:	68 1c 18 00 00       	push   $0x181c
     392:	e8 09 fe ff ff       	call   1a0 <panic>
      close(0);
     397:	83 ec 0c             	sub    $0xc,%esp
     39a:	6a 00                	push   $0x0
     39c:	e8 9a 0b 00 00       	call   f3b <close>
      dup(p[0]);
     3a1:	5a                   	pop    %edx
     3a2:	ff b5 68 ff ff ff    	push   -0x98(%ebp)
     3a8:	e8 de 0b 00 00       	call   f8b <dup>
      close(p[0]);
     3ad:	59                   	pop    %ecx
     3ae:	ff b5 68 ff ff ff    	push   -0x98(%ebp)
     3b4:	e8 82 0b 00 00       	call   f3b <close>
      close(p[1]);
     3b9:	5e                   	pop    %esi
     3ba:	ff b5 6c ff ff ff    	push   -0x94(%ebp)
     3c0:	e8 76 0b 00 00       	call   f3b <close>
      runcmd(pcmd->right);
     3c5:	5f                   	pop    %edi
     3c6:	ff 73 08             	push   0x8(%ebx)
     3c9:	e8 12 fe ff ff       	call   1e0 <runcmd>
      close(1);
     3ce:	83 ec 0c             	sub    $0xc,%esp
     3d1:	6a 01                	push   $0x1
     3d3:	e8 63 0b 00 00       	call   f3b <close>
      dup(p[1]);
     3d8:	58                   	pop    %eax
     3d9:	ff b5 6c ff ff ff    	push   -0x94(%ebp)
     3df:	e8 a7 0b 00 00       	call   f8b <dup>
      close(p[0]);
     3e4:	58                   	pop    %eax
     3e5:	ff b5 68 ff ff ff    	push   -0x98(%ebp)
     3eb:	e8 4b 0b 00 00       	call   f3b <close>
      close(p[1]);
     3f0:	58                   	pop    %eax
     3f1:	ff b5 6c ff ff ff    	push   -0x94(%ebp)
     3f7:	e8 3f 0b 00 00       	call   f3b <close>
      runcmd(pcmd->left);
     3fc:	58                   	pop    %eax
     3fd:	ff 73 04             	push   0x4(%ebx)
     400:	e8 db fd ff ff       	call   1e0 <runcmd>
     405:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     40c:	00 
     40d:	8d 76 00             	lea    0x0(%esi),%esi

00000410 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     410:	55                   	push   %ebp
     411:	89 e5                	mov    %esp,%ebp
     413:	53                   	push   %ebx
     414:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     417:	6a 54                	push   $0x54
     419:	e8 e2 12 00 00       	call   1700 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     41e:	83 c4 0c             	add    $0xc,%esp
     421:	6a 54                	push   $0x54
  cmd = malloc(sizeof(*cmd));
     423:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     425:	6a 00                	push   $0x0
     427:	50                   	push   %eax
     428:	e8 63 09 00 00       	call   d90 <memset>
  cmd->type = EXEC;
     42d:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     433:	89 d8                	mov    %ebx,%eax
     435:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     438:	c9                   	leave
     439:	c3                   	ret
     43a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000440 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     440:	55                   	push   %ebp
     441:	89 e5                	mov    %esp,%ebp
     443:	53                   	push   %ebx
     444:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     447:	6a 18                	push   $0x18
     449:	e8 b2 12 00 00       	call   1700 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     44e:	83 c4 0c             	add    $0xc,%esp
     451:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     453:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     455:	6a 00                	push   $0x0
     457:	50                   	push   %eax
     458:	e8 33 09 00 00       	call   d90 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     45d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     460:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     466:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     469:	8b 45 0c             	mov    0xc(%ebp),%eax
     46c:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     46f:	8b 45 10             	mov    0x10(%ebp),%eax
     472:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     475:	8b 45 14             	mov    0x14(%ebp),%eax
     478:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     47b:	8b 45 18             	mov    0x18(%ebp),%eax
     47e:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     481:	89 d8                	mov    %ebx,%eax
     483:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     486:	c9                   	leave
     487:	c3                   	ret
     488:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     48f:	00 

00000490 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     490:	55                   	push   %ebp
     491:	89 e5                	mov    %esp,%ebp
     493:	53                   	push   %ebx
     494:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     497:	6a 0c                	push   $0xc
     499:	e8 62 12 00 00       	call   1700 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     49e:	83 c4 0c             	add    $0xc,%esp
     4a1:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     4a3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     4a5:	6a 00                	push   $0x0
     4a7:	50                   	push   %eax
     4a8:	e8 e3 08 00 00       	call   d90 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     4ad:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     4b0:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     4b6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     4b9:	8b 45 0c             	mov    0xc(%ebp),%eax
     4bc:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     4bf:	89 d8                	mov    %ebx,%eax
     4c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     4c4:	c9                   	leave
     4c5:	c3                   	ret
     4c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     4cd:	00 
     4ce:	66 90                	xchg   %ax,%ax

000004d0 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     4d0:	55                   	push   %ebp
     4d1:	89 e5                	mov    %esp,%ebp
     4d3:	53                   	push   %ebx
     4d4:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4d7:	6a 0c                	push   $0xc
     4d9:	e8 22 12 00 00       	call   1700 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     4de:	83 c4 0c             	add    $0xc,%esp
     4e1:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     4e3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     4e5:	6a 00                	push   $0x0
     4e7:	50                   	push   %eax
     4e8:	e8 a3 08 00 00       	call   d90 <memset>
  cmd->type = LIST;
  cmd->left = left;
     4ed:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     4f0:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     4f6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     4f9:	8b 45 0c             	mov    0xc(%ebp),%eax
     4fc:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     4ff:	89 d8                	mov    %ebx,%eax
     501:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     504:	c9                   	leave
     505:	c3                   	ret
     506:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     50d:	00 
     50e:	66 90                	xchg   %ax,%ax

00000510 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     510:	55                   	push   %ebp
     511:	89 e5                	mov    %esp,%ebp
     513:	53                   	push   %ebx
     514:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     517:	6a 08                	push   $0x8
     519:	e8 e2 11 00 00       	call   1700 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     51e:	83 c4 0c             	add    $0xc,%esp
     521:	6a 08                	push   $0x8
  cmd = malloc(sizeof(*cmd));
     523:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     525:	6a 00                	push   $0x0
     527:	50                   	push   %eax
     528:	e8 63 08 00 00       	call   d90 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     52d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     530:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     536:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     539:	89 d8                	mov    %ebx,%eax
     53b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     53e:	c9                   	leave
     53f:	c3                   	ret

00000540 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     540:	55                   	push   %ebp
     541:	89 e5                	mov    %esp,%ebp
     543:	57                   	push   %edi
     544:	56                   	push   %esi
     545:	53                   	push   %ebx
     546:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;

  s = *ps;
     549:	8b 45 08             	mov    0x8(%ebp),%eax
{
     54c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     54f:	8b 75 10             	mov    0x10(%ebp),%esi
  s = *ps;
     552:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     554:	39 df                	cmp    %ebx,%edi
     556:	72 0f                	jb     567 <gettoken+0x27>
     558:	eb 25                	jmp    57f <gettoken+0x3f>
     55a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     560:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     563:	39 fb                	cmp    %edi,%ebx
     565:	74 18                	je     57f <gettoken+0x3f>
     567:	0f be 07             	movsbl (%edi),%eax
     56a:	83 ec 08             	sub    $0x8,%esp
     56d:	50                   	push   %eax
     56e:	68 f0 1f 00 00       	push   $0x1ff0
     573:	e8 38 08 00 00       	call   db0 <strchr>
     578:	83 c4 10             	add    $0x10,%esp
     57b:	85 c0                	test   %eax,%eax
     57d:	75 e1                	jne    560 <gettoken+0x20>
  if(q)
     57f:	85 f6                	test   %esi,%esi
     581:	74 02                	je     585 <gettoken+0x45>
    *q = s;
     583:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     585:	0f b6 07             	movzbl (%edi),%eax
  switch(*s){
     588:	3c 3c                	cmp    $0x3c,%al
     58a:	0f 8f c8 00 00 00    	jg     658 <gettoken+0x118>
     590:	3c 3a                	cmp    $0x3a,%al
     592:	7f 5a                	jg     5ee <gettoken+0xae>
     594:	84 c0                	test   %al,%al
     596:	75 48                	jne    5e0 <gettoken+0xa0>
     598:	31 f6                	xor    %esi,%esi
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     59a:	8b 4d 14             	mov    0x14(%ebp),%ecx
     59d:	85 c9                	test   %ecx,%ecx
     59f:	74 05                	je     5a6 <gettoken+0x66>
    *eq = s;
     5a1:	8b 45 14             	mov    0x14(%ebp),%eax
     5a4:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     5a6:	39 df                	cmp    %ebx,%edi
     5a8:	72 0d                	jb     5b7 <gettoken+0x77>
     5aa:	eb 23                	jmp    5cf <gettoken+0x8f>
     5ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s++;
     5b0:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     5b3:	39 fb                	cmp    %edi,%ebx
     5b5:	74 18                	je     5cf <gettoken+0x8f>
     5b7:	0f be 07             	movsbl (%edi),%eax
     5ba:	83 ec 08             	sub    $0x8,%esp
     5bd:	50                   	push   %eax
     5be:	68 f0 1f 00 00       	push   $0x1ff0
     5c3:	e8 e8 07 00 00       	call   db0 <strchr>
     5c8:	83 c4 10             	add    $0x10,%esp
     5cb:	85 c0                	test   %eax,%eax
     5cd:	75 e1                	jne    5b0 <gettoken+0x70>
  *ps = s;
     5cf:	8b 45 08             	mov    0x8(%ebp),%eax
     5d2:	89 38                	mov    %edi,(%eax)
  return ret;
}
     5d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     5d7:	89 f0                	mov    %esi,%eax
     5d9:	5b                   	pop    %ebx
     5da:	5e                   	pop    %esi
     5db:	5f                   	pop    %edi
     5dc:	5d                   	pop    %ebp
     5dd:	c3                   	ret
     5de:	66 90                	xchg   %ax,%ax
  switch(*s){
     5e0:	78 22                	js     604 <gettoken+0xc4>
     5e2:	3c 26                	cmp    $0x26,%al
     5e4:	74 08                	je     5ee <gettoken+0xae>
     5e6:	8d 48 d8             	lea    -0x28(%eax),%ecx
     5e9:	80 f9 01             	cmp    $0x1,%cl
     5ec:	77 16                	ja     604 <gettoken+0xc4>
  ret = *s;
     5ee:	0f be f0             	movsbl %al,%esi
    s++;
     5f1:	83 c7 01             	add    $0x1,%edi
    break;
     5f4:	eb a4                	jmp    59a <gettoken+0x5a>
     5f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     5fd:	00 
     5fe:	66 90                	xchg   %ax,%ax
  switch(*s){
     600:	3c 7c                	cmp    $0x7c,%al
     602:	74 ea                	je     5ee <gettoken+0xae>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     604:	39 df                	cmp    %ebx,%edi
     606:	72 27                	jb     62f <gettoken+0xef>
     608:	e9 87 00 00 00       	jmp    694 <gettoken+0x154>
     60d:	8d 76 00             	lea    0x0(%esi),%esi
     610:	0f be 07             	movsbl (%edi),%eax
     613:	83 ec 08             	sub    $0x8,%esp
     616:	50                   	push   %eax
     617:	68 e8 1f 00 00       	push   $0x1fe8
     61c:	e8 8f 07 00 00       	call   db0 <strchr>
     621:	83 c4 10             	add    $0x10,%esp
     624:	85 c0                	test   %eax,%eax
     626:	75 1f                	jne    647 <gettoken+0x107>
      s++;
     628:	83 c7 01             	add    $0x1,%edi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     62b:	39 fb                	cmp    %edi,%ebx
     62d:	74 4d                	je     67c <gettoken+0x13c>
     62f:	0f be 07             	movsbl (%edi),%eax
     632:	83 ec 08             	sub    $0x8,%esp
     635:	50                   	push   %eax
     636:	68 f0 1f 00 00       	push   $0x1ff0
     63b:	e8 70 07 00 00       	call   db0 <strchr>
     640:	83 c4 10             	add    $0x10,%esp
     643:	85 c0                	test   %eax,%eax
     645:	74 c9                	je     610 <gettoken+0xd0>
    ret = 'a';
     647:	be 61 00 00 00       	mov    $0x61,%esi
     64c:	e9 49 ff ff ff       	jmp    59a <gettoken+0x5a>
     651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     658:	3c 3e                	cmp    $0x3e,%al
     65a:	75 a4                	jne    600 <gettoken+0xc0>
    if(*s == '>'){
     65c:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
     660:	74 0d                	je     66f <gettoken+0x12f>
    s++;
     662:	83 c7 01             	add    $0x1,%edi
  ret = *s;
     665:	be 3e 00 00 00       	mov    $0x3e,%esi
     66a:	e9 2b ff ff ff       	jmp    59a <gettoken+0x5a>
      s++;
     66f:	83 c7 02             	add    $0x2,%edi
      ret = '+';
     672:	be 2b 00 00 00       	mov    $0x2b,%esi
     677:	e9 1e ff ff ff       	jmp    59a <gettoken+0x5a>
  if(eq)
     67c:	8b 45 14             	mov    0x14(%ebp),%eax
     67f:	85 c0                	test   %eax,%eax
     681:	74 05                	je     688 <gettoken+0x148>
    *eq = s;
     683:	8b 45 14             	mov    0x14(%ebp),%eax
     686:	89 18                	mov    %ebx,(%eax)
  while(s < es && strchr(whitespace, *s))
     688:	89 df                	mov    %ebx,%edi
    ret = 'a';
     68a:	be 61 00 00 00       	mov    $0x61,%esi
     68f:	e9 3b ff ff ff       	jmp    5cf <gettoken+0x8f>
  if(eq)
     694:	8b 55 14             	mov    0x14(%ebp),%edx
     697:	85 d2                	test   %edx,%edx
     699:	74 ef                	je     68a <gettoken+0x14a>
    *eq = s;
     69b:	8b 45 14             	mov    0x14(%ebp),%eax
     69e:	89 38                	mov    %edi,(%eax)
  while(s < es && strchr(whitespace, *s))
     6a0:	eb e8                	jmp    68a <gettoken+0x14a>
     6a2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     6a9:	00 
     6aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000006b0 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     6b0:	55                   	push   %ebp
     6b1:	89 e5                	mov    %esp,%ebp
     6b3:	57                   	push   %edi
     6b4:	56                   	push   %esi
     6b5:	53                   	push   %ebx
     6b6:	83 ec 0c             	sub    $0xc,%esp
     6b9:	8b 7d 08             	mov    0x8(%ebp),%edi
     6bc:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     6bf:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     6c1:	39 f3                	cmp    %esi,%ebx
     6c3:	72 12                	jb     6d7 <peek+0x27>
     6c5:	eb 28                	jmp    6ef <peek+0x3f>
     6c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     6ce:	00 
     6cf:	90                   	nop
    s++;
     6d0:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
     6d3:	39 de                	cmp    %ebx,%esi
     6d5:	74 18                	je     6ef <peek+0x3f>
     6d7:	0f be 03             	movsbl (%ebx),%eax
     6da:	83 ec 08             	sub    $0x8,%esp
     6dd:	50                   	push   %eax
     6de:	68 f0 1f 00 00       	push   $0x1ff0
     6e3:	e8 c8 06 00 00       	call   db0 <strchr>
     6e8:	83 c4 10             	add    $0x10,%esp
     6eb:	85 c0                	test   %eax,%eax
     6ed:	75 e1                	jne    6d0 <peek+0x20>
  *ps = s;
     6ef:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     6f1:	0f be 03             	movsbl (%ebx),%eax
     6f4:	31 d2                	xor    %edx,%edx
     6f6:	84 c0                	test   %al,%al
     6f8:	75 0e                	jne    708 <peek+0x58>
}
     6fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6fd:	89 d0                	mov    %edx,%eax
     6ff:	5b                   	pop    %ebx
     700:	5e                   	pop    %esi
     701:	5f                   	pop    %edi
     702:	5d                   	pop    %ebp
     703:	c3                   	ret
     704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return *s && strchr(toks, *s);
     708:	83 ec 08             	sub    $0x8,%esp
     70b:	50                   	push   %eax
     70c:	ff 75 10             	push   0x10(%ebp)
     70f:	e8 9c 06 00 00       	call   db0 <strchr>
     714:	83 c4 10             	add    $0x10,%esp
     717:	31 d2                	xor    %edx,%edx
     719:	85 c0                	test   %eax,%eax
     71b:	0f 95 c2             	setne  %dl
}
     71e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     721:	5b                   	pop    %ebx
     722:	89 d0                	mov    %edx,%eax
     724:	5e                   	pop    %esi
     725:	5f                   	pop    %edi
     726:	5d                   	pop    %ebp
     727:	c3                   	ret
     728:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     72f:	00 

00000730 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     730:	55                   	push   %ebp
     731:	89 e5                	mov    %esp,%ebp
     733:	57                   	push   %edi
     734:	56                   	push   %esi
     735:	53                   	push   %ebx
     736:	83 ec 2c             	sub    $0x2c,%esp
     739:	8b 75 0c             	mov    0xc(%ebp),%esi
     73c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     73f:	90                   	nop
     740:	83 ec 04             	sub    $0x4,%esp
     743:	68 3e 18 00 00       	push   $0x183e
     748:	53                   	push   %ebx
     749:	56                   	push   %esi
     74a:	e8 61 ff ff ff       	call   6b0 <peek>
     74f:	83 c4 10             	add    $0x10,%esp
     752:	85 c0                	test   %eax,%eax
     754:	0f 84 f6 00 00 00    	je     850 <parseredirs+0x120>
    tok = gettoken(ps, es, 0, 0);
     75a:	6a 00                	push   $0x0
     75c:	6a 00                	push   $0x0
     75e:	53                   	push   %ebx
     75f:	56                   	push   %esi
     760:	e8 db fd ff ff       	call   540 <gettoken>
     765:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     767:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     76a:	50                   	push   %eax
     76b:	8d 45 e0             	lea    -0x20(%ebp),%eax
     76e:	50                   	push   %eax
     76f:	53                   	push   %ebx
     770:	56                   	push   %esi
     771:	e8 ca fd ff ff       	call   540 <gettoken>
     776:	83 c4 20             	add    $0x20,%esp
     779:	83 f8 61             	cmp    $0x61,%eax
     77c:	0f 85 d9 00 00 00    	jne    85b <parseredirs+0x12b>
      panic("missing file for redirection");
    switch(tok){
     782:	83 ff 3c             	cmp    $0x3c,%edi
     785:	74 69                	je     7f0 <parseredirs+0xc0>
     787:	83 ff 3e             	cmp    $0x3e,%edi
     78a:	74 05                	je     791 <parseredirs+0x61>
     78c:	83 ff 2b             	cmp    $0x2b,%edi
     78f:	75 af                	jne    740 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     791:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     794:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     797:	83 ec 0c             	sub    $0xc,%esp
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     79a:	89 55 d0             	mov    %edx,-0x30(%ebp)
     79d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     7a0:	6a 18                	push   $0x18
     7a2:	e8 59 0f 00 00       	call   1700 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     7a7:	83 c4 0c             	add    $0xc,%esp
     7aa:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     7ac:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     7ae:	6a 00                	push   $0x0
     7b0:	50                   	push   %eax
     7b1:	e8 da 05 00 00       	call   d90 <memset>
  cmd->type = REDIR;
     7b6:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     7bc:	8b 45 08             	mov    0x8(%ebp),%eax
      break;
     7bf:	83 c4 10             	add    $0x10,%esp
  cmd->cmd = subcmd;
     7c2:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     7c5:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     7c8:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     7cb:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->mode = mode;
     7ce:	c7 47 10 01 02 00 00 	movl   $0x201,0x10(%edi)
  cmd->efile = efile;
     7d5:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->fd = fd;
     7d8:	c7 47 14 01 00 00 00 	movl   $0x1,0x14(%edi)
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     7df:	89 7d 08             	mov    %edi,0x8(%ebp)
      break;
     7e2:	e9 59 ff ff ff       	jmp    740 <parseredirs+0x10>
     7e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     7ee:	00 
     7ef:	90                   	nop
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     7f0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     7f3:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     7f6:	83 ec 0c             	sub    $0xc,%esp
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     7f9:	89 55 d0             	mov    %edx,-0x30(%ebp)
     7fc:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     7ff:	6a 18                	push   $0x18
     801:	e8 fa 0e 00 00       	call   1700 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     806:	83 c4 0c             	add    $0xc,%esp
     809:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     80b:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     80d:	6a 00                	push   $0x0
     80f:	50                   	push   %eax
     810:	e8 7b 05 00 00       	call   d90 <memset>
  cmd->cmd = subcmd;
     815:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->file = file;
     818:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      break;
     81b:	83 c4 10             	add    $0x10,%esp
  cmd->efile = efile;
     81e:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->type = REDIR;
     821:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     827:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     82a:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     82d:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->mode = mode;
     830:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%edi)
  cmd->fd = fd;
     837:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     83e:	89 7d 08             	mov    %edi,0x8(%ebp)
      break;
     841:	e9 fa fe ff ff       	jmp    740 <parseredirs+0x10>
     846:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     84d:	00 
     84e:	66 90                	xchg   %ax,%ax
    }
  }
  return cmd;
}
     850:	8b 45 08             	mov    0x8(%ebp),%eax
     853:	8d 65 f4             	lea    -0xc(%ebp),%esp
     856:	5b                   	pop    %ebx
     857:	5e                   	pop    %esi
     858:	5f                   	pop    %edi
     859:	5d                   	pop    %ebp
     85a:	c3                   	ret
      panic("missing file for redirection");
     85b:	83 ec 0c             	sub    $0xc,%esp
     85e:	68 21 18 00 00       	push   $0x1821
     863:	e8 38 f9 ff ff       	call   1a0 <panic>
     868:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     86f:	00 

00000870 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     870:	55                   	push   %ebp
     871:	89 e5                	mov    %esp,%ebp
     873:	57                   	push   %edi
     874:	56                   	push   %esi
     875:	53                   	push   %ebx
     876:	83 ec 30             	sub    $0x30,%esp
     879:	8b 5d 08             	mov    0x8(%ebp),%ebx
     87c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     87f:	68 41 18 00 00       	push   $0x1841
     884:	56                   	push   %esi
     885:	53                   	push   %ebx
     886:	e8 25 fe ff ff       	call   6b0 <peek>
     88b:	83 c4 10             	add    $0x10,%esp
     88e:	85 c0                	test   %eax,%eax
     890:	0f 85 aa 00 00 00    	jne    940 <parseexec+0xd0>
  cmd = malloc(sizeof(*cmd));
     896:	83 ec 0c             	sub    $0xc,%esp
     899:	89 c7                	mov    %eax,%edi
     89b:	6a 54                	push   $0x54
     89d:	e8 5e 0e 00 00       	call   1700 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     8a2:	83 c4 0c             	add    $0xc,%esp
     8a5:	6a 54                	push   $0x54
     8a7:	6a 00                	push   $0x0
     8a9:	89 45 d0             	mov    %eax,-0x30(%ebp)
     8ac:	50                   	push   %eax
     8ad:	e8 de 04 00 00       	call   d90 <memset>
  cmd->type = EXEC;
     8b2:	8b 45 d0             	mov    -0x30(%ebp),%eax

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     8b5:	83 c4 0c             	add    $0xc,%esp
  cmd->type = EXEC;
     8b8:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  ret = parseredirs(ret, ps, es);
     8be:	56                   	push   %esi
     8bf:	53                   	push   %ebx
     8c0:	50                   	push   %eax
     8c1:	e8 6a fe ff ff       	call   730 <parseredirs>
  while(!peek(ps, es, "|)&;")){
     8c6:	83 c4 10             	add    $0x10,%esp
  ret = parseredirs(ret, ps, es);
     8c9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     8cc:	eb 15                	jmp    8e3 <parseexec+0x73>
     8ce:	66 90                	xchg   %ax,%ax
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     8d0:	83 ec 04             	sub    $0x4,%esp
     8d3:	56                   	push   %esi
     8d4:	53                   	push   %ebx
     8d5:	ff 75 d4             	push   -0x2c(%ebp)
     8d8:	e8 53 fe ff ff       	call   730 <parseredirs>
     8dd:	83 c4 10             	add    $0x10,%esp
     8e0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     8e3:	83 ec 04             	sub    $0x4,%esp
     8e6:	68 58 18 00 00       	push   $0x1858
     8eb:	56                   	push   %esi
     8ec:	53                   	push   %ebx
     8ed:	e8 be fd ff ff       	call   6b0 <peek>
     8f2:	83 c4 10             	add    $0x10,%esp
     8f5:	85 c0                	test   %eax,%eax
     8f7:	75 5f                	jne    958 <parseexec+0xe8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     8f9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     8fc:	50                   	push   %eax
     8fd:	8d 45 e0             	lea    -0x20(%ebp),%eax
     900:	50                   	push   %eax
     901:	56                   	push   %esi
     902:	53                   	push   %ebx
     903:	e8 38 fc ff ff       	call   540 <gettoken>
     908:	83 c4 10             	add    $0x10,%esp
     90b:	85 c0                	test   %eax,%eax
     90d:	74 49                	je     958 <parseexec+0xe8>
    if(tok != 'a')
     90f:	83 f8 61             	cmp    $0x61,%eax
     912:	75 62                	jne    976 <parseexec+0x106>
    cmd->argv[argc] = q;
     914:	8b 45 e0             	mov    -0x20(%ebp),%eax
     917:	8b 55 d0             	mov    -0x30(%ebp),%edx
     91a:	89 44 ba 04          	mov    %eax,0x4(%edx,%edi,4)
    cmd->eargv[argc] = eq;
     91e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     921:	89 44 ba 2c          	mov    %eax,0x2c(%edx,%edi,4)
    argc++;
     925:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARGS)
     928:	83 ff 0a             	cmp    $0xa,%edi
     92b:	75 a3                	jne    8d0 <parseexec+0x60>
      panic("too many args");
     92d:	83 ec 0c             	sub    $0xc,%esp
     930:	68 4a 18 00 00       	push   $0x184a
     935:	e8 66 f8 ff ff       	call   1a0 <panic>
     93a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     940:	89 75 0c             	mov    %esi,0xc(%ebp)
     943:	89 5d 08             	mov    %ebx,0x8(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     946:	8d 65 f4             	lea    -0xc(%ebp),%esp
     949:	5b                   	pop    %ebx
     94a:	5e                   	pop    %esi
     94b:	5f                   	pop    %edi
     94c:	5d                   	pop    %ebp
    return parseblock(ps, es);
     94d:	e9 ae 01 00 00       	jmp    b00 <parseblock>
     952:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  cmd->argv[argc] = 0;
     958:	8b 45 d0             	mov    -0x30(%ebp),%eax
     95b:	c7 44 b8 04 00 00 00 	movl   $0x0,0x4(%eax,%edi,4)
     962:	00 
  cmd->eargv[argc] = 0;
     963:	c7 44 b8 2c 00 00 00 	movl   $0x0,0x2c(%eax,%edi,4)
     96a:	00 
}
     96b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     96e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     971:	5b                   	pop    %ebx
     972:	5e                   	pop    %esi
     973:	5f                   	pop    %edi
     974:	5d                   	pop    %ebp
     975:	c3                   	ret
      panic("syntax");
     976:	83 ec 0c             	sub    $0xc,%esp
     979:	68 43 18 00 00       	push   $0x1843
     97e:	e8 1d f8 ff ff       	call   1a0 <panic>
     983:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     98a:	00 
     98b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000990 <parsepipe>:
{
     990:	55                   	push   %ebp
     991:	89 e5                	mov    %esp,%ebp
     993:	57                   	push   %edi
     994:	56                   	push   %esi
     995:	53                   	push   %ebx
     996:	83 ec 14             	sub    $0x14,%esp
     999:	8b 75 08             	mov    0x8(%ebp),%esi
     99c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parseexec(ps, es);
     99f:	57                   	push   %edi
     9a0:	56                   	push   %esi
     9a1:	e8 ca fe ff ff       	call   870 <parseexec>
  if(peek(ps, es, "|")){
     9a6:	83 c4 0c             	add    $0xc,%esp
     9a9:	68 5d 18 00 00       	push   $0x185d
  cmd = parseexec(ps, es);
     9ae:	89 c3                	mov    %eax,%ebx
  if(peek(ps, es, "|")){
     9b0:	57                   	push   %edi
     9b1:	56                   	push   %esi
     9b2:	e8 f9 fc ff ff       	call   6b0 <peek>
     9b7:	83 c4 10             	add    $0x10,%esp
     9ba:	85 c0                	test   %eax,%eax
     9bc:	75 12                	jne    9d0 <parsepipe+0x40>
}
     9be:	8d 65 f4             	lea    -0xc(%ebp),%esp
     9c1:	89 d8                	mov    %ebx,%eax
     9c3:	5b                   	pop    %ebx
     9c4:	5e                   	pop    %esi
     9c5:	5f                   	pop    %edi
     9c6:	5d                   	pop    %ebp
     9c7:	c3                   	ret
     9c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     9cf:	00 
    gettoken(ps, es, 0, 0);
     9d0:	6a 00                	push   $0x0
     9d2:	6a 00                	push   $0x0
     9d4:	57                   	push   %edi
     9d5:	56                   	push   %esi
     9d6:	e8 65 fb ff ff       	call   540 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     9db:	58                   	pop    %eax
     9dc:	5a                   	pop    %edx
     9dd:	57                   	push   %edi
     9de:	56                   	push   %esi
     9df:	e8 ac ff ff ff       	call   990 <parsepipe>
  cmd = malloc(sizeof(*cmd));
     9e4:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = pipecmd(cmd, parsepipe(ps, es));
     9eb:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     9ed:	e8 0e 0d 00 00       	call   1700 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     9f2:	83 c4 0c             	add    $0xc,%esp
     9f5:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     9f7:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     9f9:	6a 00                	push   $0x0
     9fb:	50                   	push   %eax
     9fc:	e8 8f 03 00 00       	call   d90 <memset>
  cmd->left = left;
     a01:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     a04:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     a07:	89 f3                	mov    %esi,%ebx
  cmd->type = PIPE;
     a09:	c7 06 03 00 00 00    	movl   $0x3,(%esi)
}
     a0f:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     a11:	89 7e 08             	mov    %edi,0x8(%esi)
}
     a14:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a17:	5b                   	pop    %ebx
     a18:	5e                   	pop    %esi
     a19:	5f                   	pop    %edi
     a1a:	5d                   	pop    %ebp
     a1b:	c3                   	ret
     a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a20 <parseline>:
{
     a20:	55                   	push   %ebp
     a21:	89 e5                	mov    %esp,%ebp
     a23:	57                   	push   %edi
     a24:	56                   	push   %esi
     a25:	53                   	push   %ebx
     a26:	83 ec 24             	sub    $0x24,%esp
     a29:	8b 75 08             	mov    0x8(%ebp),%esi
     a2c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parsepipe(ps, es);
     a2f:	57                   	push   %edi
     a30:	56                   	push   %esi
     a31:	e8 5a ff ff ff       	call   990 <parsepipe>
  while(peek(ps, es, "&")){
     a36:	83 c4 10             	add    $0x10,%esp
  cmd = parsepipe(ps, es);
     a39:	89 c3                	mov    %eax,%ebx
  while(peek(ps, es, "&")){
     a3b:	eb 3b                	jmp    a78 <parseline+0x58>
     a3d:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     a40:	6a 00                	push   $0x0
     a42:	6a 00                	push   $0x0
     a44:	57                   	push   %edi
     a45:	56                   	push   %esi
     a46:	e8 f5 fa ff ff       	call   540 <gettoken>
  cmd = malloc(sizeof(*cmd));
     a4b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     a52:	e8 a9 0c 00 00       	call   1700 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     a57:	83 c4 0c             	add    $0xc,%esp
     a5a:	6a 08                	push   $0x8
     a5c:	6a 00                	push   $0x0
     a5e:	50                   	push   %eax
     a5f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     a62:	e8 29 03 00 00       	call   d90 <memset>
  cmd->type = BACK;
     a67:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  cmd->cmd = subcmd;
     a6a:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     a6d:	c7 02 05 00 00 00    	movl   $0x5,(%edx)
  cmd->cmd = subcmd;
     a73:	89 5a 04             	mov    %ebx,0x4(%edx)
    cmd = backcmd(cmd);
     a76:	89 d3                	mov    %edx,%ebx
  while(peek(ps, es, "&")){
     a78:	83 ec 04             	sub    $0x4,%esp
     a7b:	68 5f 18 00 00       	push   $0x185f
     a80:	57                   	push   %edi
     a81:	56                   	push   %esi
     a82:	e8 29 fc ff ff       	call   6b0 <peek>
     a87:	83 c4 10             	add    $0x10,%esp
     a8a:	85 c0                	test   %eax,%eax
     a8c:	75 b2                	jne    a40 <parseline+0x20>
  if(peek(ps, es, ";")){
     a8e:	83 ec 04             	sub    $0x4,%esp
     a91:	68 5b 18 00 00       	push   $0x185b
     a96:	57                   	push   %edi
     a97:	56                   	push   %esi
     a98:	e8 13 fc ff ff       	call   6b0 <peek>
     a9d:	83 c4 10             	add    $0x10,%esp
     aa0:	85 c0                	test   %eax,%eax
     aa2:	75 0c                	jne    ab0 <parseline+0x90>
}
     aa4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     aa7:	89 d8                	mov    %ebx,%eax
     aa9:	5b                   	pop    %ebx
     aaa:	5e                   	pop    %esi
     aab:	5f                   	pop    %edi
     aac:	5d                   	pop    %ebp
     aad:	c3                   	ret
     aae:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
     ab0:	6a 00                	push   $0x0
     ab2:	6a 00                	push   $0x0
     ab4:	57                   	push   %edi
     ab5:	56                   	push   %esi
     ab6:	e8 85 fa ff ff       	call   540 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     abb:	58                   	pop    %eax
     abc:	5a                   	pop    %edx
     abd:	57                   	push   %edi
     abe:	56                   	push   %esi
     abf:	e8 5c ff ff ff       	call   a20 <parseline>
  cmd = malloc(sizeof(*cmd));
     ac4:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = listcmd(cmd, parseline(ps, es));
     acb:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     acd:	e8 2e 0c 00 00       	call   1700 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     ad2:	83 c4 0c             	add    $0xc,%esp
     ad5:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     ad7:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     ad9:	6a 00                	push   $0x0
     adb:	50                   	push   %eax
     adc:	e8 af 02 00 00       	call   d90 <memset>
  cmd->left = left;
     ae1:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     ae4:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
     ae7:	89 f3                	mov    %esi,%ebx
  cmd->type = LIST;
     ae9:	c7 06 04 00 00 00    	movl   $0x4,(%esi)
}
     aef:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     af1:	89 7e 08             	mov    %edi,0x8(%esi)
}
     af4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     af7:	5b                   	pop    %ebx
     af8:	5e                   	pop    %esi
     af9:	5f                   	pop    %edi
     afa:	5d                   	pop    %ebp
     afb:	c3                   	ret
     afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000b00 <parseblock>:
{
     b00:	55                   	push   %ebp
     b01:	89 e5                	mov    %esp,%ebp
     b03:	57                   	push   %edi
     b04:	56                   	push   %esi
     b05:	53                   	push   %ebx
     b06:	83 ec 10             	sub    $0x10,%esp
     b09:	8b 5d 08             	mov    0x8(%ebp),%ebx
     b0c:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     b0f:	68 41 18 00 00       	push   $0x1841
     b14:	56                   	push   %esi
     b15:	53                   	push   %ebx
     b16:	e8 95 fb ff ff       	call   6b0 <peek>
     b1b:	83 c4 10             	add    $0x10,%esp
     b1e:	85 c0                	test   %eax,%eax
     b20:	74 4a                	je     b6c <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     b22:	6a 00                	push   $0x0
     b24:	6a 00                	push   $0x0
     b26:	56                   	push   %esi
     b27:	53                   	push   %ebx
     b28:	e8 13 fa ff ff       	call   540 <gettoken>
  cmd = parseline(ps, es);
     b2d:	58                   	pop    %eax
     b2e:	5a                   	pop    %edx
     b2f:	56                   	push   %esi
     b30:	53                   	push   %ebx
     b31:	e8 ea fe ff ff       	call   a20 <parseline>
  if(!peek(ps, es, ")"))
     b36:	83 c4 0c             	add    $0xc,%esp
     b39:	68 7d 18 00 00       	push   $0x187d
  cmd = parseline(ps, es);
     b3e:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     b40:	56                   	push   %esi
     b41:	53                   	push   %ebx
     b42:	e8 69 fb ff ff       	call   6b0 <peek>
     b47:	83 c4 10             	add    $0x10,%esp
     b4a:	85 c0                	test   %eax,%eax
     b4c:	74 2b                	je     b79 <parseblock+0x79>
  gettoken(ps, es, 0, 0);
     b4e:	6a 00                	push   $0x0
     b50:	6a 00                	push   $0x0
     b52:	56                   	push   %esi
     b53:	53                   	push   %ebx
     b54:	e8 e7 f9 ff ff       	call   540 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     b59:	83 c4 0c             	add    $0xc,%esp
     b5c:	56                   	push   %esi
     b5d:	53                   	push   %ebx
     b5e:	57                   	push   %edi
     b5f:	e8 cc fb ff ff       	call   730 <parseredirs>
}
     b64:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b67:	5b                   	pop    %ebx
     b68:	5e                   	pop    %esi
     b69:	5f                   	pop    %edi
     b6a:	5d                   	pop    %ebp
     b6b:	c3                   	ret
    panic("parseblock");
     b6c:	83 ec 0c             	sub    $0xc,%esp
     b6f:	68 61 18 00 00       	push   $0x1861
     b74:	e8 27 f6 ff ff       	call   1a0 <panic>
    panic("syntax - missing )");
     b79:	83 ec 0c             	sub    $0xc,%esp
     b7c:	68 6c 18 00 00       	push   $0x186c
     b81:	e8 1a f6 ff ff       	call   1a0 <panic>
     b86:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     b8d:	00 
     b8e:	66 90                	xchg   %ax,%ax

00000b90 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     b90:	55                   	push   %ebp
     b91:	89 e5                	mov    %esp,%ebp
     b93:	53                   	push   %ebx
     b94:	83 ec 04             	sub    $0x4,%esp
     b97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     b9a:	85 db                	test   %ebx,%ebx
     b9c:	74 29                	je     bc7 <nulterminate+0x37>
    return 0;

  switch(cmd->type){
     b9e:	83 3b 05             	cmpl   $0x5,(%ebx)
     ba1:	77 24                	ja     bc7 <nulterminate+0x37>
     ba3:	8b 03                	mov    (%ebx),%eax
     ba5:	ff 24 85 b8 18 00 00 	jmp    *0x18b8(,%eax,4)
     bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     bb0:	83 ec 0c             	sub    $0xc,%esp
     bb3:	ff 73 04             	push   0x4(%ebx)
     bb6:	e8 d5 ff ff ff       	call   b90 <nulterminate>
    nulterminate(lcmd->right);
     bbb:	58                   	pop    %eax
     bbc:	ff 73 08             	push   0x8(%ebx)
     bbf:	e8 cc ff ff ff       	call   b90 <nulterminate>
    break;
     bc4:	83 c4 10             	add    $0x10,%esp
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     bc7:	89 d8                	mov    %ebx,%eax
     bc9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bcc:	c9                   	leave
     bcd:	c3                   	ret
     bce:	66 90                	xchg   %ax,%ax
    nulterminate(bcmd->cmd);
     bd0:	83 ec 0c             	sub    $0xc,%esp
     bd3:	ff 73 04             	push   0x4(%ebx)
     bd6:	e8 b5 ff ff ff       	call   b90 <nulterminate>
}
     bdb:	89 d8                	mov    %ebx,%eax
    break;
     bdd:	83 c4 10             	add    $0x10,%esp
}
     be0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     be3:	c9                   	leave
     be4:	c3                   	ret
     be5:	8d 76 00             	lea    0x0(%esi),%esi
    for(i=0; ecmd->argv[i]; i++)
     be8:	8b 4b 04             	mov    0x4(%ebx),%ecx
     beb:	85 c9                	test   %ecx,%ecx
     bed:	74 d8                	je     bc7 <nulterminate+0x37>
     bef:	8d 43 08             	lea    0x8(%ebx),%eax
     bf2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     bf9:	00 
     bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     c00:	8b 50 24             	mov    0x24(%eax),%edx
    for(i=0; ecmd->argv[i]; i++)
     c03:	83 c0 04             	add    $0x4,%eax
      *ecmd->eargv[i] = 0;
     c06:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     c09:	8b 50 fc             	mov    -0x4(%eax),%edx
     c0c:	85 d2                	test   %edx,%edx
     c0e:	75 f0                	jne    c00 <nulterminate+0x70>
}
     c10:	89 d8                	mov    %ebx,%eax
     c12:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c15:	c9                   	leave
     c16:	c3                   	ret
     c17:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     c1e:	00 
     c1f:	90                   	nop
    nulterminate(rcmd->cmd);
     c20:	83 ec 0c             	sub    $0xc,%esp
     c23:	ff 73 04             	push   0x4(%ebx)
     c26:	e8 65 ff ff ff       	call   b90 <nulterminate>
    *rcmd->efile = 0;
     c2b:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
     c2e:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     c31:	c6 00 00             	movb   $0x0,(%eax)
}
     c34:	89 d8                	mov    %ebx,%eax
     c36:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c39:	c9                   	leave
     c3a:	c3                   	ret
     c3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000c40 <parsecmd>:
{
     c40:	55                   	push   %ebp
     c41:	89 e5                	mov    %esp,%ebp
     c43:	57                   	push   %edi
     c44:	56                   	push   %esi
  cmd = parseline(&s, es);
     c45:	8d 7d 08             	lea    0x8(%ebp),%edi
{
     c48:	53                   	push   %ebx
     c49:	83 ec 18             	sub    $0x18,%esp
  es = s + strlen(s);
     c4c:	8b 5d 08             	mov    0x8(%ebp),%ebx
     c4f:	53                   	push   %ebx
     c50:	e8 0b 01 00 00       	call   d60 <strlen>
  cmd = parseline(&s, es);
     c55:	59                   	pop    %ecx
     c56:	5e                   	pop    %esi
  es = s + strlen(s);
     c57:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     c59:	53                   	push   %ebx
     c5a:	57                   	push   %edi
     c5b:	e8 c0 fd ff ff       	call   a20 <parseline>
  peek(&s, es, "");
     c60:	83 c4 0c             	add    $0xc,%esp
     c63:	68 1b 18 00 00       	push   $0x181b
  cmd = parseline(&s, es);
     c68:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     c6a:	53                   	push   %ebx
     c6b:	57                   	push   %edi
     c6c:	e8 3f fa ff ff       	call   6b0 <peek>
  if(s != es){
     c71:	8b 45 08             	mov    0x8(%ebp),%eax
     c74:	83 c4 10             	add    $0x10,%esp
     c77:	39 d8                	cmp    %ebx,%eax
     c79:	75 13                	jne    c8e <parsecmd+0x4e>
  nulterminate(cmd);
     c7b:	83 ec 0c             	sub    $0xc,%esp
     c7e:	56                   	push   %esi
     c7f:	e8 0c ff ff ff       	call   b90 <nulterminate>
}
     c84:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c87:	89 f0                	mov    %esi,%eax
     c89:	5b                   	pop    %ebx
     c8a:	5e                   	pop    %esi
     c8b:	5f                   	pop    %edi
     c8c:	5d                   	pop    %ebp
     c8d:	c3                   	ret
    printf("leftovers: %s\n", s);
     c8e:	52                   	push   %edx
     c8f:	52                   	push   %edx
     c90:	50                   	push   %eax
     c91:	68 7f 18 00 00       	push   $0x187f
     c96:	e8 f5 04 00 00       	call   1190 <printf>
    panic("syntax");
     c9b:	c7 04 24 43 18 00 00 	movl   $0x1843,(%esp)
     ca2:	e8 f9 f4 ff ff       	call   1a0 <panic>
     ca7:	66 90                	xchg   %ax,%ax
     ca9:	66 90                	xchg   %ax,%ax
     cab:	66 90                	xchg   %ax,%ax
     cad:	66 90                	xchg   %ax,%ax
     caf:	66 90                	xchg   %ax,%ax
     cb1:	66 90                	xchg   %ax,%ax
     cb3:	66 90                	xchg   %ax,%ax
     cb5:	66 90                	xchg   %ax,%ax
     cb7:	66 90                	xchg   %ax,%ax
     cb9:	66 90                	xchg   %ax,%ax
     cbb:	66 90                	xchg   %ax,%ax
     cbd:	66 90                	xchg   %ax,%ax
     cbf:	90                   	nop

00000cc0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     cc0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     cc1:	31 c0                	xor    %eax,%eax
{
     cc3:	89 e5                	mov    %esp,%ebp
     cc5:	53                   	push   %ebx
     cc6:	8b 4d 08             	mov    0x8(%ebp),%ecx
     cc9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
     cd0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     cd4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
     cd7:	83 c0 01             	add    $0x1,%eax
     cda:	84 d2                	test   %dl,%dl
     cdc:	75 f2                	jne    cd0 <strcpy+0x10>
    ;
  return os;
}
     cde:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ce1:	89 c8                	mov    %ecx,%eax
     ce3:	c9                   	leave
     ce4:	c3                   	ret
     ce5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     cec:	00 
     ced:	8d 76 00             	lea    0x0(%esi),%esi

00000cf0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     cf0:	55                   	push   %ebp
     cf1:	89 e5                	mov    %esp,%ebp
     cf3:	53                   	push   %ebx
     cf4:	8b 55 08             	mov    0x8(%ebp),%edx
     cf7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     cfa:	0f b6 02             	movzbl (%edx),%eax
     cfd:	84 c0                	test   %al,%al
     cff:	75 2f                	jne    d30 <strcmp+0x40>
     d01:	eb 4a                	jmp    d4d <strcmp+0x5d>
     d03:	eb 1b                	jmp    d20 <strcmp+0x30>
     d05:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     d0c:	00 
     d0d:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     d14:	00 
     d15:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     d1c:	00 
     d1d:	8d 76 00             	lea    0x0(%esi),%esi
     d20:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
     d24:	83 c2 01             	add    $0x1,%edx
     d27:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
     d2a:	84 c0                	test   %al,%al
     d2c:	74 12                	je     d40 <strcmp+0x50>
     d2e:	89 d9                	mov    %ebx,%ecx
     d30:	0f b6 19             	movzbl (%ecx),%ebx
     d33:	38 c3                	cmp    %al,%bl
     d35:	74 e9                	je     d20 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
     d37:	29 d8                	sub    %ebx,%eax
}
     d39:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     d3c:	c9                   	leave
     d3d:	c3                   	ret
     d3e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
     d40:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
     d44:	31 c0                	xor    %eax,%eax
     d46:	29 d8                	sub    %ebx,%eax
}
     d48:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     d4b:	c9                   	leave
     d4c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
     d4d:	0f b6 19             	movzbl (%ecx),%ebx
     d50:	31 c0                	xor    %eax,%eax
     d52:	eb e3                	jmp    d37 <strcmp+0x47>
     d54:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     d5b:	00 
     d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000d60 <strlen>:

uint
strlen(char *s)
{
     d60:	55                   	push   %ebp
     d61:	89 e5                	mov    %esp,%ebp
     d63:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
     d66:	80 3a 00             	cmpb   $0x0,(%edx)
     d69:	74 15                	je     d80 <strlen+0x20>
     d6b:	31 c0                	xor    %eax,%eax
     d6d:	8d 76 00             	lea    0x0(%esi),%esi
     d70:	83 c0 01             	add    $0x1,%eax
     d73:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
     d77:	89 c1                	mov    %eax,%ecx
     d79:	75 f5                	jne    d70 <strlen+0x10>
    ;
  return n;
}
     d7b:	89 c8                	mov    %ecx,%eax
     d7d:	5d                   	pop    %ebp
     d7e:	c3                   	ret
     d7f:	90                   	nop
  for(n = 0; s[n]; n++)
     d80:	31 c9                	xor    %ecx,%ecx
}
     d82:	5d                   	pop    %ebp
     d83:	89 c8                	mov    %ecx,%eax
     d85:	c3                   	ret
     d86:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     d8d:	00 
     d8e:	66 90                	xchg   %ax,%ax

00000d90 <memset>:

void*
memset(void *dst, int c, uint n)
{
     d90:	55                   	push   %ebp
     d91:	89 e5                	mov    %esp,%ebp
     d93:	57                   	push   %edi
     d94:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     d97:	8b 4d 10             	mov    0x10(%ebp),%ecx
     d9a:	8b 45 0c             	mov    0xc(%ebp),%eax
     d9d:	89 d7                	mov    %edx,%edi
     d9f:	fc                   	cld
     da0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     da2:	8b 7d fc             	mov    -0x4(%ebp),%edi
     da5:	89 d0                	mov    %edx,%eax
     da7:	c9                   	leave
     da8:	c3                   	ret
     da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000db0 <strchr>:

char*
strchr(const char *s, char c)
{
     db0:	55                   	push   %ebp
     db1:	89 e5                	mov    %esp,%ebp
     db3:	8b 45 08             	mov    0x8(%ebp),%eax
     db6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     dba:	0f b6 10             	movzbl (%eax),%edx
     dbd:	84 d2                	test   %dl,%dl
     dbf:	75 1a                	jne    ddb <strchr+0x2b>
     dc1:	eb 25                	jmp    de8 <strchr+0x38>
     dc3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     dca:	00 
     dcb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
     dd0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
     dd4:	83 c0 01             	add    $0x1,%eax
     dd7:	84 d2                	test   %dl,%dl
     dd9:	74 0d                	je     de8 <strchr+0x38>
    if(*s == c)
     ddb:	38 d1                	cmp    %dl,%cl
     ddd:	75 f1                	jne    dd0 <strchr+0x20>
      return (char*)s;
  return 0;
}
     ddf:	5d                   	pop    %ebp
     de0:	c3                   	ret
     de1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
     de8:	31 c0                	xor    %eax,%eax
}
     dea:	5d                   	pop    %ebp
     deb:	c3                   	ret
     dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000df0 <gets>:

char*
gets(char *buf, int max)
{
     df0:	55                   	push   %ebp
     df1:	89 e5                	mov    %esp,%ebp
     df3:	57                   	push   %edi
     df4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
     df5:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
     df8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
     df9:	31 db                	xor    %ebx,%ebx
{
     dfb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
     dfe:	eb 27                	jmp    e27 <gets+0x37>
    cc = read(0, &c, 1);
     e00:	83 ec 04             	sub    $0x4,%esp
     e03:	6a 01                	push   $0x1
     e05:	56                   	push   %esi
     e06:	6a 00                	push   $0x0
     e08:	e8 1e 01 00 00       	call   f2b <read>
    if(cc < 1)
     e0d:	83 c4 10             	add    $0x10,%esp
     e10:	85 c0                	test   %eax,%eax
     e12:	7e 1d                	jle    e31 <gets+0x41>
      break;
    buf[i++] = c;
     e14:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     e18:	8b 55 08             	mov    0x8(%ebp),%edx
     e1b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
     e1f:	3c 0a                	cmp    $0xa,%al
     e21:	74 10                	je     e33 <gets+0x43>
     e23:	3c 0d                	cmp    $0xd,%al
     e25:	74 0c                	je     e33 <gets+0x43>
  for(i=0; i+1 < max; ){
     e27:	89 df                	mov    %ebx,%edi
     e29:	83 c3 01             	add    $0x1,%ebx
     e2c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     e2f:	7c cf                	jl     e00 <gets+0x10>
     e31:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
     e33:	8b 45 08             	mov    0x8(%ebp),%eax
     e36:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
     e3a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e3d:	5b                   	pop    %ebx
     e3e:	5e                   	pop    %esi
     e3f:	5f                   	pop    %edi
     e40:	5d                   	pop    %ebp
     e41:	c3                   	ret
     e42:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     e49:	00 
     e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000e50 <stat>:

int
stat(char *n, struct stat *st)
{
     e50:	55                   	push   %ebp
     e51:	89 e5                	mov    %esp,%ebp
     e53:	56                   	push   %esi
     e54:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     e55:	83 ec 08             	sub    $0x8,%esp
     e58:	6a 00                	push   $0x0
     e5a:	ff 75 08             	push   0x8(%ebp)
     e5d:	e8 f1 00 00 00       	call   f53 <open>
  if(fd < 0)
     e62:	83 c4 10             	add    $0x10,%esp
     e65:	85 c0                	test   %eax,%eax
     e67:	78 27                	js     e90 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     e69:	83 ec 08             	sub    $0x8,%esp
     e6c:	ff 75 0c             	push   0xc(%ebp)
     e6f:	89 c3                	mov    %eax,%ebx
     e71:	50                   	push   %eax
     e72:	e8 f4 00 00 00       	call   f6b <fstat>
  close(fd);
     e77:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     e7a:	89 c6                	mov    %eax,%esi
  close(fd);
     e7c:	e8 ba 00 00 00       	call   f3b <close>
  return r;
     e81:	83 c4 10             	add    $0x10,%esp
}
     e84:	8d 65 f8             	lea    -0x8(%ebp),%esp
     e87:	89 f0                	mov    %esi,%eax
     e89:	5b                   	pop    %ebx
     e8a:	5e                   	pop    %esi
     e8b:	5d                   	pop    %ebp
     e8c:	c3                   	ret
     e8d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     e90:	be ff ff ff ff       	mov    $0xffffffff,%esi
     e95:	eb ed                	jmp    e84 <stat+0x34>
     e97:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     e9e:	00 
     e9f:	90                   	nop

00000ea0 <atoi>:

int
atoi(const char *s)
{
     ea0:	55                   	push   %ebp
     ea1:	89 e5                	mov    %esp,%ebp
     ea3:	53                   	push   %ebx
     ea4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     ea7:	0f be 02             	movsbl (%edx),%eax
     eaa:	8d 48 d0             	lea    -0x30(%eax),%ecx
     ead:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
     eb0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
     eb5:	77 1e                	ja     ed5 <atoi+0x35>
     eb7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     ebe:	00 
     ebf:	90                   	nop
    n = n*10 + *s++ - '0';
     ec0:	83 c2 01             	add    $0x1,%edx
     ec3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
     ec6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
     eca:	0f be 02             	movsbl (%edx),%eax
     ecd:	8d 58 d0             	lea    -0x30(%eax),%ebx
     ed0:	80 fb 09             	cmp    $0x9,%bl
     ed3:	76 eb                	jbe    ec0 <atoi+0x20>
  return n;
}
     ed5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ed8:	89 c8                	mov    %ecx,%eax
     eda:	c9                   	leave
     edb:	c3                   	ret
     edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ee0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     ee0:	55                   	push   %ebp
     ee1:	89 e5                	mov    %esp,%ebp
     ee3:	57                   	push   %edi
     ee4:	8b 45 10             	mov    0x10(%ebp),%eax
     ee7:	8b 55 08             	mov    0x8(%ebp),%edx
     eea:	56                   	push   %esi
     eeb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     eee:	85 c0                	test   %eax,%eax
     ef0:	7e 13                	jle    f05 <memmove+0x25>
     ef2:	01 d0                	add    %edx,%eax
  dst = vdst;
     ef4:	89 d7                	mov    %edx,%edi
     ef6:	66 90                	xchg   %ax,%ax
     ef8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     eff:	00 
    *dst++ = *src++;
     f00:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
     f01:	39 f8                	cmp    %edi,%eax
     f03:	75 fb                	jne    f00 <memmove+0x20>
  return vdst;
}
     f05:	5e                   	pop    %esi
     f06:	89 d0                	mov    %edx,%eax
     f08:	5f                   	pop    %edi
     f09:	5d                   	pop    %ebp
     f0a:	c3                   	ret

00000f0b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     f0b:	b8 01 00 00 00       	mov    $0x1,%eax
     f10:	cd 40                	int    $0x40
     f12:	c3                   	ret

00000f13 <exit>:
SYSCALL(exit)
     f13:	b8 02 00 00 00       	mov    $0x2,%eax
     f18:	cd 40                	int    $0x40
     f1a:	c3                   	ret

00000f1b <wait>:
SYSCALL(wait)
     f1b:	b8 03 00 00 00       	mov    $0x3,%eax
     f20:	cd 40                	int    $0x40
     f22:	c3                   	ret

00000f23 <pipe>:
SYSCALL(pipe)
     f23:	b8 04 00 00 00       	mov    $0x4,%eax
     f28:	cd 40                	int    $0x40
     f2a:	c3                   	ret

00000f2b <read>:
SYSCALL(read)
     f2b:	b8 05 00 00 00       	mov    $0x5,%eax
     f30:	cd 40                	int    $0x40
     f32:	c3                   	ret

00000f33 <write>:
SYSCALL(write)
     f33:	b8 10 00 00 00       	mov    $0x10,%eax
     f38:	cd 40                	int    $0x40
     f3a:	c3                   	ret

00000f3b <close>:
SYSCALL(close)
     f3b:	b8 15 00 00 00       	mov    $0x15,%eax
     f40:	cd 40                	int    $0x40
     f42:	c3                   	ret

00000f43 <kill>:
SYSCALL(kill)
     f43:	b8 06 00 00 00       	mov    $0x6,%eax
     f48:	cd 40                	int    $0x40
     f4a:	c3                   	ret

00000f4b <exec>:
SYSCALL(exec)
     f4b:	b8 07 00 00 00       	mov    $0x7,%eax
     f50:	cd 40                	int    $0x40
     f52:	c3                   	ret

00000f53 <open>:
SYSCALL(open)
     f53:	b8 0f 00 00 00       	mov    $0xf,%eax
     f58:	cd 40                	int    $0x40
     f5a:	c3                   	ret

00000f5b <mknod>:
SYSCALL(mknod)
     f5b:	b8 11 00 00 00       	mov    $0x11,%eax
     f60:	cd 40                	int    $0x40
     f62:	c3                   	ret

00000f63 <unlink>:
SYSCALL(unlink)
     f63:	b8 12 00 00 00       	mov    $0x12,%eax
     f68:	cd 40                	int    $0x40
     f6a:	c3                   	ret

00000f6b <fstat>:
SYSCALL(fstat)
     f6b:	b8 08 00 00 00       	mov    $0x8,%eax
     f70:	cd 40                	int    $0x40
     f72:	c3                   	ret

00000f73 <link>:
SYSCALL(link)
     f73:	b8 13 00 00 00       	mov    $0x13,%eax
     f78:	cd 40                	int    $0x40
     f7a:	c3                   	ret

00000f7b <mkdir>:
SYSCALL(mkdir)
     f7b:	b8 14 00 00 00       	mov    $0x14,%eax
     f80:	cd 40                	int    $0x40
     f82:	c3                   	ret

00000f83 <chdir>:
SYSCALL(chdir)
     f83:	b8 09 00 00 00       	mov    $0x9,%eax
     f88:	cd 40                	int    $0x40
     f8a:	c3                   	ret

00000f8b <dup>:
SYSCALL(dup)
     f8b:	b8 0a 00 00 00       	mov    $0xa,%eax
     f90:	cd 40                	int    $0x40
     f92:	c3                   	ret

00000f93 <getpid>:
SYSCALL(getpid)
     f93:	b8 0b 00 00 00       	mov    $0xb,%eax
     f98:	cd 40                	int    $0x40
     f9a:	c3                   	ret

00000f9b <sbrk>:
SYSCALL(sbrk)
     f9b:	b8 0c 00 00 00       	mov    $0xc,%eax
     fa0:	cd 40                	int    $0x40
     fa2:	c3                   	ret

00000fa3 <sleep>:
SYSCALL(sleep)
     fa3:	b8 0d 00 00 00       	mov    $0xd,%eax
     fa8:	cd 40                	int    $0x40
     faa:	c3                   	ret

00000fab <uptime>:
SYSCALL(uptime)
     fab:	b8 0e 00 00 00       	mov    $0xe,%eax
     fb0:	cd 40                	int    $0x40
     fb2:	c3                   	ret

00000fb3 <bstat>:
SYSCALL(bstat)
     fb3:	b8 16 00 00 00       	mov    $0x16,%eax
     fb8:	cd 40                	int    $0x40
     fba:	c3                   	ret

00000fbb <swap>:
SYSCALL(swap)
     fbb:	b8 17 00 00 00       	mov    $0x17,%eax
     fc0:	cd 40                	int    $0x40
     fc2:	c3                   	ret

00000fc3 <gettime>:
SYSCALL(gettime)
     fc3:	b8 18 00 00 00       	mov    $0x18,%eax
     fc8:	cd 40                	int    $0x40
     fca:	c3                   	ret

00000fcb <setcursor>:
SYSCALL(setcursor)
     fcb:	b8 19 00 00 00       	mov    $0x19,%eax
     fd0:	cd 40                	int    $0x40
     fd2:	c3                   	ret

00000fd3 <uname>:
SYSCALL(uname)
     fd3:	b8 1a 00 00 00       	mov    $0x1a,%eax
     fd8:	cd 40                	int    $0x40
     fda:	c3                   	ret

00000fdb <echo>:
SYSCALL(echo)
     fdb:	b8 1b 00 00 00       	mov    $0x1b,%eax
     fe0:	cd 40                	int    $0x40
     fe2:	c3                   	ret
     fe3:	66 90                	xchg   %ax,%ax
     fe5:	66 90                	xchg   %ax,%ax
     fe7:	66 90                	xchg   %ax,%ax
     fe9:	66 90                	xchg   %ax,%ax
     feb:	66 90                	xchg   %ax,%ax
     fed:	66 90                	xchg   %ax,%ax
     fef:	66 90                	xchg   %ax,%ax
     ff1:	66 90                	xchg   %ax,%ax
     ff3:	66 90                	xchg   %ax,%ax
     ff5:	66 90                	xchg   %ax,%ax
     ff7:	66 90                	xchg   %ax,%ax
     ff9:	66 90                	xchg   %ax,%ax
     ffb:	66 90                	xchg   %ax,%ax
     ffd:	66 90                	xchg   %ax,%ax
     fff:	90                   	nop

00001000 <printint.constprop.0>:
{
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn, int width, char pad_char)
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	57                   	push   %edi
    1004:	56                   	push   %esi
    1005:	89 c6                	mov    %eax,%esi
    1007:	53                   	push   %ebx
    1008:	89 d3                	mov    %edx,%ebx
    100a:	83 ec 3c             	sub    $0x3c,%esp
    100d:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1011:	85 f6                	test   %esi,%esi
    1013:	0f 89 d7 00 00 00    	jns    10f0 <printint.constprop.0+0xf0>
    1019:	83 e1 01             	and    $0x1,%ecx
    101c:	0f 84 ce 00 00 00    	je     10f0 <printint.constprop.0+0xf0>
    neg = 1;
    1022:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
    1029:	f7 de                	neg    %esi
    102b:	89 f1                	mov    %esi,%ecx
  } else {
    x = xx;
  }

  i = 0;
    102d:	88 45 bf             	mov    %al,-0x41(%ebp)
    1030:	31 ff                	xor    %edi,%edi
    1032:	8d 75 d7             	lea    -0x29(%ebp),%esi
    1035:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    103c:	00 
    103d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1040:	89 c8                	mov    %ecx,%eax
    1042:	31 d2                	xor    %edx,%edx
    1044:	89 7d c4             	mov    %edi,-0x3c(%ebp)
    1047:	83 c7 01             	add    $0x1,%edi
    104a:	f7 f3                	div    %ebx
    104c:	0f b6 92 a0 19 00 00 	movzbl 0x19a0(%edx),%edx
    1053:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
    1056:	89 ca                	mov    %ecx,%edx
    1058:	89 c1                	mov    %eax,%ecx
    105a:	39 da                	cmp    %ebx,%edx
    105c:	73 e2                	jae    1040 <printint.constprop.0+0x40>

  if(neg)
    105e:	8b 55 c0             	mov    -0x40(%ebp),%edx
    1061:	0f b6 45 bf          	movzbl -0x41(%ebp),%eax
    1065:	85 d2                	test   %edx,%edx
    1067:	74 0b                	je     1074 <printint.constprop.0+0x74>
    buf[i++] = '-';
    1069:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
    106c:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    1071:	8d 79 02             	lea    0x2(%ecx),%edi

  // Pad with pad_char until we hit the required width
  while(i < width)
    1074:	39 7d 08             	cmp    %edi,0x8(%ebp)
    1077:	0f 8e 83 00 00 00    	jle    1100 <printint.constprop.0+0x100>
    107d:	8b 55 08             	mov    0x8(%ebp),%edx
    1080:	8d 5d d8             	lea    -0x28(%ebp),%ebx
    1083:	01 df                	add    %ebx,%edi
    1085:	01 da                	add    %ebx,%edx
    1087:	89 d1                	mov    %edx,%ecx
    1089:	29 f9                	sub    %edi,%ecx
    108b:	83 e1 01             	and    $0x1,%ecx
    108e:	74 10                	je     10a0 <printint.constprop.0+0xa0>
    buf[i++] = pad_char;
    1090:	88 07                	mov    %al,(%edi)
  while(i < width)
    1092:	83 c7 01             	add    $0x1,%edi
    1095:	39 d7                	cmp    %edx,%edi
    1097:	74 13                	je     10ac <printint.constprop.0+0xac>
    1099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = pad_char;
    10a0:	88 07                	mov    %al,(%edi)
  while(i < width)
    10a2:	83 c7 02             	add    $0x2,%edi
    buf[i++] = pad_char;
    10a5:	88 47 ff             	mov    %al,-0x1(%edi)
  while(i < width)
    10a8:	39 d7                	cmp    %edx,%edi
    10aa:	75 f4                	jne    10a0 <printint.constprop.0+0xa0>
    10ac:	8b 45 08             	mov    0x8(%ebp),%eax
    10af:	8d 78 ff             	lea    -0x1(%eax),%edi

  while(--i >= 0)
    10b2:	01 df                	add    %ebx,%edi
    10b4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    10bb:	00 
    10bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
    10c0:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
    10c3:	83 ec 04             	sub    $0x4,%esp
    10c6:	88 45 d7             	mov    %al,-0x29(%ebp)
    10c9:	6a 01                	push   $0x1
    10cb:	56                   	push   %esi
    10cc:	6a 01                	push   $0x1
    10ce:	e8 60 fe ff ff       	call   f33 <write>
  while(--i >= 0)
    10d3:	89 f8                	mov    %edi,%eax
    10d5:	83 c4 10             	add    $0x10,%esp
    10d8:	83 ef 01             	sub    $0x1,%edi
    10db:	39 d8                	cmp    %ebx,%eax
    10dd:	75 e1                	jne    10c0 <printint.constprop.0+0xc0>
}
    10df:	8d 65 f4             	lea    -0xc(%ebp),%esp
    10e2:	5b                   	pop    %ebx
    10e3:	5e                   	pop    %esi
    10e4:	5f                   	pop    %edi
    10e5:	5d                   	pop    %ebp
    10e6:	c3                   	ret
    10e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    10ee:	00 
    10ef:	90                   	nop
  neg = 0;
    10f0:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = xx;
    10f7:	89 f1                	mov    %esi,%ecx
    10f9:	e9 2f ff ff ff       	jmp    102d <printint.constprop.0+0x2d>
    10fe:	66 90                	xchg   %ax,%ax
  while(--i >= 0)
    1100:	83 ef 01             	sub    $0x1,%edi
    1103:	8d 5d d8             	lea    -0x28(%ebp),%ebx
    1106:	eb aa                	jmp    10b2 <printint.constprop.0+0xb2>
    1108:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    110f:	00 

00001110 <strncpy>:
{
    1110:	55                   	push   %ebp
    1111:	31 c0                	xor    %eax,%eax
    1113:	89 e5                	mov    %esp,%ebp
    1115:	56                   	push   %esi
    1116:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1119:	8b 75 0c             	mov    0xc(%ebp),%esi
    111c:	53                   	push   %ebx
    111d:	8b 5d 10             	mov    0x10(%ebp),%ebx
  for (i = 0; i < n && src[i]; i++)
    1120:	85 db                	test   %ebx,%ebx
    1122:	7f 26                	jg     114a <strncpy+0x3a>
    1124:	eb 58                	jmp    117e <strncpy+0x6e>
    1126:	eb 18                	jmp    1140 <strncpy+0x30>
    1128:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    112f:	00 
    1130:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    1137:	00 
    1138:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    113f:	00 
    dest[i] = src[i];
    1140:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  for (i = 0; i < n && src[i]; i++)
    1143:	83 c0 01             	add    $0x1,%eax
    1146:	39 c3                	cmp    %eax,%ebx
    1148:	74 34                	je     117e <strncpy+0x6e>
    114a:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
    114e:	84 d2                	test   %dl,%dl
    1150:	75 ee                	jne    1140 <strncpy+0x30>
  for (; i < n; i++)
    1152:	39 c3                	cmp    %eax,%ebx
    1154:	7e 28                	jle    117e <strncpy+0x6e>
    1156:	01 c8                	add    %ecx,%eax
    1158:	01 d9                	add    %ebx,%ecx
    115a:	89 ca                	mov    %ecx,%edx
    115c:	29 c2                	sub    %eax,%edx
    115e:	83 e2 01             	and    $0x1,%edx
    1161:	74 0d                	je     1170 <strncpy+0x60>
    dest[i] = '\0';
    1163:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
    1166:	83 c0 01             	add    $0x1,%eax
    1169:	39 c8                	cmp    %ecx,%eax
    116b:	74 11                	je     117e <strncpy+0x6e>
    116d:	8d 76 00             	lea    0x0(%esi),%esi
    dest[i] = '\0';
    1170:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
    1173:	83 c0 02             	add    $0x2,%eax
    dest[i] = '\0';
    1176:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  for (; i < n; i++)
    117a:	39 c8                	cmp    %ecx,%eax
    117c:	75 f2                	jne    1170 <strncpy+0x60>
}
    117e:	5b                   	pop    %ebx
    117f:	5e                   	pop    %esi
    1180:	5d                   	pop    %ebp
    1181:	c3                   	ret
    1182:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    1189:	00 
    118a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001190 <printf>:

void
printf(char *fmt, ...)
{
    1190:	55                   	push   %ebp
    1191:	89 e5                	mov    %esp,%ebp
    1193:	57                   	push   %edi
    1194:	56                   	push   %esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    1195:	8d 75 0c             	lea    0xc(%ebp),%esi
{
    1198:	53                   	push   %ebx
    1199:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  for(i = 0; fmt[i]; i++){
    119c:	8b 55 08             	mov    0x8(%ebp),%edx
  ap = (uint*)(void*)&fmt + 1;
    119f:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
    11a2:	0f b6 02             	movzbl (%edx),%eax
    11a5:	84 c0                	test   %al,%al
    11a7:	0f 84 88 00 00 00    	je     1235 <printf+0xa5>
    11ad:	8d 7a 01             	lea    0x1(%edx),%edi
    c = fmt[i] & 0xff;
    11b0:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
      if (c == '\f') {
    11b3:	83 fa 0c             	cmp    $0xc,%edx
    11b6:	0f 84 d4 01 00 00    	je     1390 <printf+0x200>
        setcursor();
      } else if(c == '%'){
    11bc:	83 fa 25             	cmp    $0x25,%edx
    11bf:	0f 85 0b 02 00 00    	jne    13d0 <printf+0x240>
  for(i = 0; fmt[i]; i++){
    11c5:	0f b6 1f             	movzbl (%edi),%ebx
    11c8:	83 c7 01             	add    $0x1,%edi
    11cb:	84 db                	test   %bl,%bl
    11cd:	74 66                	je     1235 <printf+0xa5>
    c = fmt[i] & 0xff;
    11cf:	0f b6 c3             	movzbl %bl,%eax
    11d2:	ba 20 00 00 00       	mov    $0x20,%edx
    11d7:	31 c9                	xor    %ecx,%ecx
        pad_char = ' ';
      } else {
        putc(1, c);
      }
    } else if(state == '%'){
      if(c == '0'){
    11d9:	83 f8 78             	cmp    $0x78,%eax
    11dc:	7f 22                	jg     1200 <printf+0x70>
    11de:	83 f8 62             	cmp    $0x62,%eax
    11e1:	0f 8e b9 01 00 00    	jle    13a0 <printf+0x210>
    11e7:	83 e8 63             	sub    $0x63,%eax
    11ea:	83 f8 15             	cmp    $0x15,%eax
    11ed:	77 11                	ja     1200 <printf+0x70>
    11ef:	ff 24 85 f0 18 00 00 	jmp    *0x18f0(,%eax,4)
    11f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    11fd:	00 
    11fe:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
    1200:	83 ec 04             	sub    $0x4,%esp
    1203:	8d 75 e7             	lea    -0x19(%ebp),%esi
    1206:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    120a:	6a 01                	push   $0x1
    120c:	56                   	push   %esi
    120d:	6a 01                	push   $0x1
    120f:	e8 1f fd ff ff       	call   f33 <write>
    1214:	83 c4 0c             	add    $0xc,%esp
    1217:	88 5d e7             	mov    %bl,-0x19(%ebp)
    121a:	6a 01                	push   $0x1
    121c:	56                   	push   %esi
    121d:	6a 01                	push   $0x1
    121f:	e8 0f fd ff ff       	call   f33 <write>
      } else if(c == '%'){
        putc(1, '%');
        state = 0;
      } else {
        putc(1, '%');
        putc(1, c);
    1224:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    1227:	0f b6 07             	movzbl (%edi),%eax
    122a:	83 c7 01             	add    $0x1,%edi
    122d:	84 c0                	test   %al,%al
    122f:	0f 85 7b ff ff ff    	jne    11b0 <printf+0x20>
        state = 0;
      }
    }
  }
}
    1235:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1238:	5b                   	pop    %ebx
    1239:	5e                   	pop    %esi
    123a:	5f                   	pop    %edi
    123b:	5d                   	pop    %ebp
    123c:	c3                   	ret
    123d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 16, 0, width, pad_char);
    1240:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    1243:	83 ec 08             	sub    $0x8,%esp
    1246:	8b 06                	mov    (%esi),%eax
    1248:	52                   	push   %edx
    1249:	ba 10 00 00 00       	mov    $0x10,%edx
    124e:	51                   	push   %ecx
    124f:	31 c9                	xor    %ecx,%ecx
        printint(1, *ap, 10, 1, width, pad_char);
    1251:	e8 aa fd ff ff       	call   1000 <printint.constprop.0>
        ap++;
    1256:	83 c6 04             	add    $0x4,%esi
    1259:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
    125c:	0f b6 07             	movzbl (%edi),%eax
    125f:	83 c7 01             	add    $0x1,%edi
    1262:	83 c4 10             	add    $0x10,%esp
    1265:	84 c0                	test   %al,%al
    1267:	0f 85 43 ff ff ff    	jne    11b0 <printf+0x20>
}
    126d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1270:	5b                   	pop    %ebx
    1271:	5e                   	pop    %esi
    1272:	5f                   	pop    %edi
    1273:	5d                   	pop    %ebp
    1274:	c3                   	ret
    1275:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 10, 1, width, pad_char);
    1278:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    127b:	83 ec 08             	sub    $0x8,%esp
    127e:	8b 06                	mov    (%esi),%eax
    1280:	52                   	push   %edx
    1281:	ba 0a 00 00 00       	mov    $0xa,%edx
    1286:	51                   	push   %ecx
    1287:	b9 01 00 00 00       	mov    $0x1,%ecx
    128c:	eb c3                	jmp    1251 <printf+0xc1>
    128e:	66 90                	xchg   %ax,%ax
        s = (char*)*ap;
    1290:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    1293:	8b 06                	mov    (%esi),%eax
        ap++;
    1295:	83 c6 04             	add    $0x4,%esi
    1298:	89 75 d4             	mov    %esi,-0x2c(%ebp)
        if(s == 0)
    129b:	85 c0                	test   %eax,%eax
    129d:	0f 85 9d 01 00 00    	jne    1440 <printf+0x2b0>
    12a3:	c6 45 d0 28          	movb   $0x28,-0x30(%ebp)
          s = "(null)";
    12a7:	b8 96 18 00 00       	mov    $0x1896,%eax
        int len = 0;
    12ac:	31 db                	xor    %ebx,%ebx
    12ae:	66 90                	xchg   %ax,%ax
        for (char *t = s; *t; t++) len++;
    12b0:	83 c3 01             	add    $0x1,%ebx
    12b3:	80 3c 18 00          	cmpb   $0x0,(%eax,%ebx,1)
    12b7:	75 f7                	jne    12b0 <printf+0x120>
        for (int j = len; j < width; j++)
    12b9:	39 cb                	cmp    %ecx,%ebx
    12bb:	0f 8d 9c 01 00 00    	jge    145d <printf+0x2cd>
    12c1:	89 4d d0             	mov    %ecx,-0x30(%ebp)
    12c4:	8d 75 e7             	lea    -0x19(%ebp),%esi
    12c7:	89 45 c8             	mov    %eax,-0x38(%ebp)
    12ca:	89 7d cc             	mov    %edi,-0x34(%ebp)
    12cd:	89 df                	mov    %ebx,%edi
    12cf:	89 d3                	mov    %edx,%ebx
    12d1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    12d8:	00 
    12d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
    12e0:	83 ec 04             	sub    $0x4,%esp
    12e3:	88 5d e7             	mov    %bl,-0x19(%ebp)
        for (int j = len; j < width; j++)
    12e6:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
    12e9:	6a 01                	push   $0x1
    12eb:	56                   	push   %esi
    12ec:	6a 01                	push   $0x1
    12ee:	e8 40 fc ff ff       	call   f33 <write>
        for (int j = len; j < width; j++)
    12f3:	8b 45 d0             	mov    -0x30(%ebp),%eax
    12f6:	83 c4 10             	add    $0x10,%esp
    12f9:	39 c7                	cmp    %eax,%edi
    12fb:	7c e3                	jl     12e0 <printf+0x150>
        while(*s != 0){
    12fd:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1300:	8b 7d cc             	mov    -0x34(%ebp),%edi
    1303:	0f b6 08             	movzbl (%eax),%ecx
    1306:	88 4d d0             	mov    %cl,-0x30(%ebp)
    1309:	84 c9                	test   %cl,%cl
    130b:	0f 84 16 ff ff ff    	je     1227 <printf+0x97>
    1311:	89 c3                	mov    %eax,%ebx
    1313:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
    1317:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    131e:	00 
    131f:	90                   	nop
  write(fd, &c, 1);
    1320:	83 ec 04             	sub    $0x4,%esp
    1323:	88 45 e7             	mov    %al,-0x19(%ebp)
          putc(1, *s++);
    1326:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
    1329:	6a 01                	push   $0x1
    132b:	56                   	push   %esi
    132c:	6a 01                	push   $0x1
    132e:	e8 00 fc ff ff       	call   f33 <write>
        while(*s != 0){
    1333:	0f b6 03             	movzbl (%ebx),%eax
    1336:	83 c4 10             	add    $0x10,%esp
    1339:	84 c0                	test   %al,%al
    133b:	75 e3                	jne    1320 <printf+0x190>
    133d:	e9 e5 fe ff ff       	jmp    1227 <printf+0x97>
    1342:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        char ch = *ap++;
    1348:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
    134b:	83 ec 04             	sub    $0x4,%esp
    134e:	8d 75 e7             	lea    -0x19(%ebp),%esi
  for(i = 0; fmt[i]; i++){
    1351:	83 c7 01             	add    $0x1,%edi
        char ch = *ap++;
    1354:	8d 58 04             	lea    0x4(%eax),%ebx
    1357:	8b 00                	mov    (%eax),%eax
    1359:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    135c:	6a 01                	push   $0x1
    135e:	56                   	push   %esi
    135f:	6a 01                	push   $0x1
    1361:	e8 cd fb ff ff       	call   f33 <write>
  for(i = 0; fmt[i]; i++){
    1366:	0f b6 47 ff          	movzbl -0x1(%edi),%eax
    136a:	83 c4 10             	add    $0x10,%esp
    136d:	84 c0                	test   %al,%al
    136f:	0f 84 c0 fe ff ff    	je     1235 <printf+0xa5>
    c = fmt[i] & 0xff;
    1375:	0f b6 d0             	movzbl %al,%edx
        char ch = *ap++;
    1378:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      if (c == '\f') {
    137b:	83 fa 0c             	cmp    $0xc,%edx
    137e:	0f 85 38 fe ff ff    	jne    11bc <printf+0x2c>
    1384:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    138b:	00 
    138c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        setcursor();
    1390:	e8 36 fc ff ff       	call   fcb <setcursor>
    1395:	e9 8d fe ff ff       	jmp    1227 <printf+0x97>
    139a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    13a0:	83 f8 30             	cmp    $0x30,%eax
    13a3:	74 7b                	je     1420 <printf+0x290>
    13a5:	7f 49                	jg     13f0 <printf+0x260>
    13a7:	83 f8 25             	cmp    $0x25,%eax
    13aa:	0f 85 50 fe ff ff    	jne    1200 <printf+0x70>
  write(fd, &c, 1);
    13b0:	83 ec 04             	sub    $0x4,%esp
    13b3:	8d 75 e7             	lea    -0x19(%ebp),%esi
    13b6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    13ba:	6a 01                	push   $0x1
    13bc:	56                   	push   %esi
    13bd:	6a 01                	push   $0x1
    13bf:	e8 6f fb ff ff       	call   f33 <write>
        state = 0;
    13c4:	83 c4 10             	add    $0x10,%esp
    13c7:	e9 5b fe ff ff       	jmp    1227 <printf+0x97>
    13cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
    13d0:	83 ec 04             	sub    $0x4,%esp
    13d3:	8d 75 e7             	lea    -0x19(%ebp),%esi
    13d6:	88 45 e7             	mov    %al,-0x19(%ebp)
    13d9:	6a 01                	push   $0x1
    13db:	56                   	push   %esi
    13dc:	6a 01                	push   $0x1
    13de:	e8 50 fb ff ff       	call   f33 <write>
  for(i = 0; fmt[i]; i++){
    13e3:	e9 74 fe ff ff       	jmp    125c <printf+0xcc>
    13e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    13ef:	00 
    13f0:	8d 70 cf             	lea    -0x31(%eax),%esi
    13f3:	83 fe 08             	cmp    $0x8,%esi
    13f6:	0f 87 04 fe ff ff    	ja     1200 <printf+0x70>
    13fc:	0f b6 1f             	movzbl (%edi),%ebx
        width = width * 10 + (c - '0');
    13ff:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
  for(i = 0; fmt[i]; i++){
    1402:	83 c7 01             	add    $0x1,%edi
        width = width * 10 + (c - '0');
    1405:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  for(i = 0; fmt[i]; i++){
    1409:	84 db                	test   %bl,%bl
    140b:	0f 84 24 fe ff ff    	je     1235 <printf+0xa5>
    c = fmt[i] & 0xff;
    1411:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1414:	e9 c0 fd ff ff       	jmp    11d9 <printf+0x49>
    1419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
    1420:	0f b6 1f             	movzbl (%edi),%ebx
    1423:	83 c7 01             	add    $0x1,%edi
    1426:	84 db                	test   %bl,%bl
    1428:	0f 84 07 fe ff ff    	je     1235 <printf+0xa5>
    c = fmt[i] & 0xff;
    142e:	0f b6 c3             	movzbl %bl,%eax
    1431:	ba 30 00 00 00       	mov    $0x30,%edx
    1436:	e9 9e fd ff ff       	jmp    11d9 <printf+0x49>
    143b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        for (char *t = s; *t; t++) len++;
    1440:	0f b6 18             	movzbl (%eax),%ebx
    1443:	88 5d d0             	mov    %bl,-0x30(%ebp)
    1446:	84 db                	test   %bl,%bl
    1448:	0f 85 5e fe ff ff    	jne    12ac <printf+0x11c>
        int len = 0;
    144e:	31 db                	xor    %ebx,%ebx
        for (int j = len; j < width; j++)
    1450:	85 c9                	test   %ecx,%ecx
    1452:	0f 8f 69 fe ff ff    	jg     12c1 <printf+0x131>
    1458:	e9 ca fd ff ff       	jmp    1227 <printf+0x97>
    145d:	89 c2                	mov    %eax,%edx
    145f:	8d 75 e7             	lea    -0x19(%ebp),%esi
    1462:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
    1466:	89 d3                	mov    %edx,%ebx
    1468:	e9 b3 fe ff ff       	jmp    1320 <printf+0x190>
    146d:	8d 76 00             	lea    0x0(%esi),%esi

00001470 <fprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
fprintf(int fd, char *fmt, ...)
{
    1470:	55                   	push   %ebp
    1471:	89 e5                	mov    %esp,%ebp
    1473:	57                   	push   %edi
    1474:	56                   	push   %esi
    1475:	53                   	push   %ebx
    1476:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1479:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    147c:	0f b6 13             	movzbl (%ebx),%edx
    147f:	83 c3 01             	add    $0x1,%ebx
    1482:	84 d2                	test   %dl,%dl
    1484:	0f 84 81 00 00 00    	je     150b <fprintf+0x9b>
    148a:	8d 75 10             	lea    0x10(%ebp),%esi
    148d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    1490:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if (c == '\f') { // Detect formfeed character
    1493:	83 f8 0c             	cmp    $0xc,%eax
    1496:	0f 84 04 01 00 00    	je     15a0 <fprintf+0x130>
        setcursor();
      } else
      if(c == '%'){
    149c:	83 f8 25             	cmp    $0x25,%eax
    149f:	0f 85 5b 01 00 00    	jne    1600 <fprintf+0x190>
  for(i = 0; fmt[i]; i++){
    14a5:	0f b6 13             	movzbl (%ebx),%edx
    14a8:	84 d2                	test   %dl,%dl
    14aa:	74 5f                	je     150b <fprintf+0x9b>
    c = fmt[i] & 0xff;
    14ac:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
    14af:	80 fa 25             	cmp    $0x25,%dl
    14b2:	0f 84 78 01 00 00    	je     1630 <fprintf+0x1c0>
    14b8:	83 e8 63             	sub    $0x63,%eax
    14bb:	83 f8 15             	cmp    $0x15,%eax
    14be:	77 10                	ja     14d0 <fprintf+0x60>
    14c0:	ff 24 85 48 19 00 00 	jmp    *0x1948(,%eax,4)
    14c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    14ce:	00 
    14cf:	90                   	nop
  write(fd, &c, 1);
    14d0:	83 ec 04             	sub    $0x4,%esp
    14d3:	8d 7d e7             	lea    -0x19(%ebp),%edi
    14d6:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    14d9:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
    14dd:	6a 01                	push   $0x1
    14df:	57                   	push   %edi
    14e0:	ff 75 08             	push   0x8(%ebp)
    14e3:	e8 4b fa ff ff       	call   f33 <write>
        putc(fd, c);
    14e8:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
    14ec:	83 c4 0c             	add    $0xc,%esp
    14ef:	88 55 e7             	mov    %dl,-0x19(%ebp)
    14f2:	6a 01                	push   $0x1
    14f4:	57                   	push   %edi
    14f5:	ff 75 08             	push   0x8(%ebp)
    14f8:	e8 36 fa ff ff       	call   f33 <write>
  for(i = 0; fmt[i]; i++){
    14fd:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
    1501:	83 c3 02             	add    $0x2,%ebx
    1504:	83 c4 10             	add    $0x10,%esp
    1507:	84 d2                	test   %dl,%dl
    1509:	75 85                	jne    1490 <fprintf+0x20>
      }
      state = 0;
    }
  }
}
    150b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    150e:	5b                   	pop    %ebx
    150f:	5e                   	pop    %esi
    1510:	5f                   	pop    %edi
    1511:	5d                   	pop    %ebp
    1512:	c3                   	ret
    1513:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(1, *ap, 16, 0, width, pad_char);
    1518:	83 ec 08             	sub    $0x8,%esp
    151b:	8b 06                	mov    (%esi),%eax
    151d:	31 c9                	xor    %ecx,%ecx
    151f:	ba 10 00 00 00       	mov    $0x10,%edx
    1524:	6a 20                	push   $0x20
    1526:	6a 00                	push   $0x0
    1528:	e8 d3 fa ff ff       	call   1000 <printint.constprop.0>
        ap++;
    152d:	83 c6 04             	add    $0x4,%esi
  for(i = 0; fmt[i]; i++){
    1530:	eb cb                	jmp    14fd <fprintf+0x8d>
    1532:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s = (char*)*ap;
    1538:	8b 3e                	mov    (%esi),%edi
        ap++;
    153a:	83 c6 04             	add    $0x4,%esi
        if(s == 0)
    153d:	85 ff                	test   %edi,%edi
    153f:	0f 84 fb 00 00 00    	je     1640 <fprintf+0x1d0>
        while(*s != 0){
    1545:	0f b6 07             	movzbl (%edi),%eax
    1548:	84 c0                	test   %al,%al
    154a:	74 36                	je     1582 <fprintf+0x112>
    154c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    154f:	8d 4d e7             	lea    -0x19(%ebp),%ecx
    1552:	8b 75 08             	mov    0x8(%ebp),%esi
    1555:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    1558:	89 fb                	mov    %edi,%ebx
    155a:	89 cf                	mov    %ecx,%edi
    155c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
    1560:	83 ec 04             	sub    $0x4,%esp
    1563:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
    1566:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
    1569:	6a 01                	push   $0x1
    156b:	57                   	push   %edi
    156c:	56                   	push   %esi
    156d:	e8 c1 f9 ff ff       	call   f33 <write>
        while(*s != 0){
    1572:	0f b6 03             	movzbl (%ebx),%eax
    1575:	83 c4 10             	add    $0x10,%esp
    1578:	84 c0                	test   %al,%al
    157a:	75 e4                	jne    1560 <fprintf+0xf0>
    157c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    157f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
    1582:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
    1586:	83 c3 02             	add    $0x2,%ebx
    1589:	84 d2                	test   %dl,%dl
    158b:	0f 84 7a ff ff ff    	je     150b <fprintf+0x9b>
    c = fmt[i] & 0xff;
    1591:	0f b6 c2             	movzbl %dl,%eax
      if (c == '\f') { // Detect formfeed character
    1594:	83 f8 0c             	cmp    $0xc,%eax
    1597:	0f 85 ff fe ff ff    	jne    149c <fprintf+0x2c>
    159d:	8d 76 00             	lea    0x0(%esi),%esi
        setcursor();
    15a0:	e8 26 fa ff ff       	call   fcb <setcursor>
  for(i = 0; fmt[i]; i++){
    15a5:	0f b6 13             	movzbl (%ebx),%edx
    15a8:	83 c3 01             	add    $0x1,%ebx
    15ab:	84 d2                	test   %dl,%dl
    15ad:	0f 85 dd fe ff ff    	jne    1490 <fprintf+0x20>
    15b3:	e9 53 ff ff ff       	jmp    150b <fprintf+0x9b>
    15b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    15bf:	00 
        printint(1, *ap, 10, 1, width, pad_char);
    15c0:	83 ec 08             	sub    $0x8,%esp
    15c3:	8b 06                	mov    (%esi),%eax
    15c5:	b9 01 00 00 00       	mov    $0x1,%ecx
    15ca:	ba 0a 00 00 00       	mov    $0xa,%edx
    15cf:	6a 20                	push   $0x20
    15d1:	6a 00                	push   $0x0
    15d3:	e9 50 ff ff ff       	jmp    1528 <fprintf+0xb8>
    15d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    15df:	00 
        putc(fd, *ap);
    15e0:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
    15e2:	83 ec 04             	sub    $0x4,%esp
    15e5:	8d 7d e7             	lea    -0x19(%ebp),%edi
        putc(fd, *ap);
    15e8:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    15eb:	6a 01                	push   $0x1
    15ed:	57                   	push   %edi
    15ee:	ff 75 08             	push   0x8(%ebp)
    15f1:	e8 3d f9 ff ff       	call   f33 <write>
    15f6:	e9 32 ff ff ff       	jmp    152d <fprintf+0xbd>
    15fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    1600:	83 ec 04             	sub    $0x4,%esp
    1603:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1606:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
    1609:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
    160c:	6a 01                	push   $0x1
    160e:	50                   	push   %eax
    160f:	ff 75 08             	push   0x8(%ebp)
    1612:	e8 1c f9 ff ff       	call   f33 <write>
  for(i = 0; fmt[i]; i++){
    1617:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    161b:	83 c4 10             	add    $0x10,%esp
    161e:	84 d2                	test   %dl,%dl
    1620:	0f 85 6a fe ff ff    	jne    1490 <fprintf+0x20>
}
    1626:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1629:	5b                   	pop    %ebx
    162a:	5e                   	pop    %esi
    162b:	5f                   	pop    %edi
    162c:	5d                   	pop    %ebp
    162d:	c3                   	ret
    162e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
    1630:	83 ec 04             	sub    $0x4,%esp
    1633:	88 55 e7             	mov    %dl,-0x19(%ebp)
    1636:	8d 7d e7             	lea    -0x19(%ebp),%edi
    1639:	6a 01                	push   $0x1
    163b:	e9 b4 fe ff ff       	jmp    14f4 <fprintf+0x84>
          s = "(null)";
    1640:	bf 96 18 00 00       	mov    $0x1896,%edi
    1645:	b8 28 00 00 00       	mov    $0x28,%eax
    164a:	e9 fd fe ff ff       	jmp    154c <fprintf+0xdc>
    164f:	66 90                	xchg   %ax,%ax
    1651:	66 90                	xchg   %ax,%ax
    1653:	66 90                	xchg   %ax,%ax
    1655:	66 90                	xchg   %ax,%ax
    1657:	66 90                	xchg   %ax,%ax
    1659:	66 90                	xchg   %ax,%ax
    165b:	66 90                	xchg   %ax,%ax
    165d:	66 90                	xchg   %ax,%ax
    165f:	90                   	nop

00001660 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1660:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1661:	a1 64 20 00 00       	mov    0x2064,%eax
{
    1666:	89 e5                	mov    %esp,%ebp
    1668:	57                   	push   %edi
    1669:	56                   	push   %esi
    166a:	53                   	push   %ebx
    166b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    166e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1671:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    1678:	00 
    1679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1680:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1682:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1684:	39 ca                	cmp    %ecx,%edx
    1686:	73 30                	jae    16b8 <free+0x58>
    1688:	39 c1                	cmp    %eax,%ecx
    168a:	72 04                	jb     1690 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    168c:	39 c2                	cmp    %eax,%edx
    168e:	72 f0                	jb     1680 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1690:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1693:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1696:	39 f8                	cmp    %edi,%eax
    1698:	74 36                	je     16d0 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    169a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    169d:	8b 42 04             	mov    0x4(%edx),%eax
    16a0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    16a3:	39 f1                	cmp    %esi,%ecx
    16a5:	74 40                	je     16e7 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    16a7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
    16a9:	5b                   	pop    %ebx
  freep = p;
    16aa:	89 15 64 20 00 00    	mov    %edx,0x2064
}
    16b0:	5e                   	pop    %esi
    16b1:	5f                   	pop    %edi
    16b2:	5d                   	pop    %ebp
    16b3:	c3                   	ret
    16b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16b8:	39 c2                	cmp    %eax,%edx
    16ba:	72 c4                	jb     1680 <free+0x20>
    16bc:	39 c1                	cmp    %eax,%ecx
    16be:	73 c0                	jae    1680 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
    16c0:	8b 73 fc             	mov    -0x4(%ebx),%esi
    16c3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    16c6:	39 f8                	cmp    %edi,%eax
    16c8:	75 d0                	jne    169a <free+0x3a>
    16ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
    16d0:	03 70 04             	add    0x4(%eax),%esi
    16d3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    16d6:	8b 02                	mov    (%edx),%eax
    16d8:	8b 00                	mov    (%eax),%eax
    16da:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    16dd:	8b 42 04             	mov    0x4(%edx),%eax
    16e0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    16e3:	39 f1                	cmp    %esi,%ecx
    16e5:	75 c0                	jne    16a7 <free+0x47>
    p->s.size += bp->s.size;
    16e7:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    16ea:	89 15 64 20 00 00    	mov    %edx,0x2064
    p->s.size += bp->s.size;
    16f0:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    16f3:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    16f6:	89 0a                	mov    %ecx,(%edx)
}
    16f8:	5b                   	pop    %ebx
    16f9:	5e                   	pop    %esi
    16fa:	5f                   	pop    %edi
    16fb:	5d                   	pop    %ebp
    16fc:	c3                   	ret
    16fd:	8d 76 00             	lea    0x0(%esi),%esi

00001700 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1700:	55                   	push   %ebp
    1701:	89 e5                	mov    %esp,%ebp
    1703:	57                   	push   %edi
    1704:	56                   	push   %esi
    1705:	53                   	push   %ebx
    1706:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1709:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    170c:	8b 15 64 20 00 00    	mov    0x2064,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1712:	8d 78 07             	lea    0x7(%eax),%edi
    1715:	c1 ef 03             	shr    $0x3,%edi
    1718:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    171b:	85 d2                	test   %edx,%edx
    171d:	0f 84 8d 00 00 00    	je     17b0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1723:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1725:	8b 48 04             	mov    0x4(%eax),%ecx
    1728:	39 f9                	cmp    %edi,%ecx
    172a:	73 64                	jae    1790 <malloc+0x90>
  if(nu < 4096)
    172c:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1731:	39 df                	cmp    %ebx,%edi
    1733:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    1736:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    173d:	eb 0a                	jmp    1749 <malloc+0x49>
    173f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1740:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1742:	8b 48 04             	mov    0x4(%eax),%ecx
    1745:	39 f9                	cmp    %edi,%ecx
    1747:	73 47                	jae    1790 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1749:	89 c2                	mov    %eax,%edx
    174b:	39 05 64 20 00 00    	cmp    %eax,0x2064
    1751:	75 ed                	jne    1740 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
    1753:	83 ec 0c             	sub    $0xc,%esp
    1756:	56                   	push   %esi
    1757:	e8 3f f8 ff ff       	call   f9b <sbrk>
  if(p == (char*)-1)
    175c:	83 c4 10             	add    $0x10,%esp
    175f:	83 f8 ff             	cmp    $0xffffffff,%eax
    1762:	74 1c                	je     1780 <malloc+0x80>
  hp->s.size = nu;
    1764:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1767:	83 ec 0c             	sub    $0xc,%esp
    176a:	83 c0 08             	add    $0x8,%eax
    176d:	50                   	push   %eax
    176e:	e8 ed fe ff ff       	call   1660 <free>
  return freep;
    1773:	8b 15 64 20 00 00    	mov    0x2064,%edx
      if((p = morecore(nunits)) == 0)
    1779:	83 c4 10             	add    $0x10,%esp
    177c:	85 d2                	test   %edx,%edx
    177e:	75 c0                	jne    1740 <malloc+0x40>
        return 0;
  }
}
    1780:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    1783:	31 c0                	xor    %eax,%eax
}
    1785:	5b                   	pop    %ebx
    1786:	5e                   	pop    %esi
    1787:	5f                   	pop    %edi
    1788:	5d                   	pop    %ebp
    1789:	c3                   	ret
    178a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1790:	39 cf                	cmp    %ecx,%edi
    1792:	74 4c                	je     17e0 <malloc+0xe0>
        p->s.size -= nunits;
    1794:	29 f9                	sub    %edi,%ecx
    1796:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1799:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    179c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    179f:	89 15 64 20 00 00    	mov    %edx,0x2064
}
    17a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    17a8:	83 c0 08             	add    $0x8,%eax
}
    17ab:	5b                   	pop    %ebx
    17ac:	5e                   	pop    %esi
    17ad:	5f                   	pop    %edi
    17ae:	5d                   	pop    %ebp
    17af:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
    17b0:	c7 05 64 20 00 00 68 	movl   $0x2068,0x2064
    17b7:	20 00 00 
    base.s.size = 0;
    17ba:	b8 68 20 00 00       	mov    $0x2068,%eax
    base.s.ptr = freep = prevp = &base;
    17bf:	c7 05 68 20 00 00 68 	movl   $0x2068,0x2068
    17c6:	20 00 00 
    base.s.size = 0;
    17c9:	c7 05 6c 20 00 00 00 	movl   $0x0,0x206c
    17d0:	00 00 00 
    if(p->s.size >= nunits){
    17d3:	e9 54 ff ff ff       	jmp    172c <malloc+0x2c>
    17d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    17df:	00 
        prevp->s.ptr = p->s.ptr;
    17e0:	8b 08                	mov    (%eax),%ecx
    17e2:	89 0a                	mov    %ecx,(%edx)
    17e4:	eb b9                	jmp    179f <malloc+0x9f>
