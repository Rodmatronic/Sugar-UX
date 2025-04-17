
_mv:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
int chkdot(register char *s);
int check(char *spth, uint dinode);

int
main(int argc, register char *argv[])
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
      11:	83 ec 08             	sub    $0x8,%esp
      14:	8b 31                	mov    (%ecx),%esi
      16:	8b 59 04             	mov    0x4(%ecx),%ebx
	register int i, r;

	if (argc < 3)
      19:	83 fe 02             	cmp    $0x2,%esi
      1c:	7e 58                	jle    76 <main+0x76>
		goto usage;
	if (stat(argv[1], &s1) < 0) {
      1e:	83 ec 08             	sub    $0x8,%esp
      21:	68 a0 21 00 00       	push   $0x21a0
      26:	ff 73 04             	push   0x4(%ebx)
      29:	e8 62 0f 00 00       	call   f90 <stat>
      2e:	83 c4 10             	add    $0x10,%esp
      31:	85 c0                	test   %eax,%eax
      33:	78 7e                	js     b3 <main+0xb3>
		fprintf(stderr, "mv: cannot access %s\n", argv[1]);
		exit();
	}
	if ((s1.st_mode & S_IFMT) == S_IFDIR) {
      35:	0f b7 05 a0 21 00 00 	movzwl 0x21a0,%eax
      3c:	66 25 00 f0          	and    $0xf000,%ax
      40:	66 3d 00 40          	cmp    $0x4000,%ax
      44:	74 4f                	je     95 <main+0x95>
			goto usage;
		return mvdir(argv[1], argv[2]);
	}
//	setuid(getuid());
	if (argc > 3)
		if (stat(argv[argc-1], &s2) < 0 || (s2.st_mode & S_IFMT) != S_IFDIR)
      46:	8d 7c b3 fc          	lea    -0x4(%ebx,%esi,4),%edi
      4a:	8b 07                	mov    (%edi),%eax
	if (argc > 3)
      4c:	83 fe 03             	cmp    $0x3,%esi
      4f:	74 38                	je     89 <main+0x89>
		if (stat(argv[argc-1], &s2) < 0 || (s2.st_mode & S_IFMT) != S_IFDIR)
      51:	51                   	push   %ecx
      52:	51                   	push   %ecx
      53:	68 20 21 00 00       	push   $0x2120
      58:	50                   	push   %eax
      59:	e8 32 0f 00 00       	call   f90 <stat>
      5e:	83 c4 10             	add    $0x10,%esp
      61:	85 c0                	test   %eax,%eax
      63:	78 11                	js     76 <main+0x76>
      65:	0f b7 05 20 21 00 00 	movzwl 0x2120,%eax
      6c:	66 25 00 f0          	and    $0xf000,%ax
      70:	66 3d 00 40          	cmp    $0x4000,%ax
      74:	74 13                	je     89 <main+0x89>
	r = 0;
	for (i=1; i<argc-1; i++)
		r |= move(argv[i], argv[argc-1]);
	return(r);
usage:
	fprintf(stderr, "usage: mv f1 f2; or mv d1 d2; or mv f1 ... fn d1\n");
      76:	52                   	push   %edx
      77:	52                   	push   %edx
      78:	68 c0 1b 00 00       	push   $0x1bc0
      7d:	6a 02                	push   $0x2
      7f:	e8 2c 15 00 00       	call   15b0 <fprintf>
	exit();
      84:	e8 ca 0f 00 00       	call   1053 <exit>
		r |= move(argv[i], argv[argc-1]);
      89:	56                   	push   %esi
      8a:	56                   	push   %esi
      8b:	ff 37                	push   (%edi)
      8d:	ff 73 04             	push   0x4(%ebx)
      90:	e8 8b 00 00 00       	call   120 <move>
		if (argc != 3)
      95:	83 fe 03             	cmp    $0x3,%esi
      98:	75 dc                	jne    76 <main+0x76>
		return mvdir(argv[1], argv[2]);
      9a:	50                   	push   %eax
      9b:	50                   	push   %eax
      9c:	ff 73 08             	push   0x8(%ebx)
      9f:	ff 73 04             	push   0x4(%ebx)
      a2:	e8 29 06 00 00       	call   6d0 <mvdir>
}
      a7:	8d 65 f0             	lea    -0x10(%ebp),%esp
      aa:	59                   	pop    %ecx
      ab:	5b                   	pop    %ebx
      ac:	5e                   	pop    %esi
      ad:	5f                   	pop    %edi
      ae:	5d                   	pop    %ebp
      af:	8d 61 fc             	lea    -0x4(%ecx),%esp
      b2:	c3                   	ret
		fprintf(stderr, "mv: cannot access %s\n", argv[1]);
      b3:	57                   	push   %edi
      b4:	ff 73 04             	push   0x4(%ebx)
      b7:	68 28 19 00 00       	push   $0x1928
      bc:	6a 02                	push   $0x2
      be:	e8 ed 14 00 00       	call   15b0 <fprintf>
		exit();
      c3:	e8 8b 0f 00 00       	call   1053 <exit>
      c8:	66 90                	xchg   %ax,%ax
      ca:	66 90                	xchg   %ax,%ax
      cc:	66 90                	xchg   %ax,%ax
      ce:	66 90                	xchg   %ax,%ax
      d0:	66 90                	xchg   %ax,%ax
      d2:	66 90                	xchg   %ax,%ax
      d4:	66 90                	xchg   %ax,%ax
      d6:	66 90                	xchg   %ax,%ax
      d8:	66 90                	xchg   %ax,%ax
      da:	66 90                	xchg   %ax,%ax
      dc:	66 90                	xchg   %ax,%ax
      de:	66 90                	xchg   %ax,%ax

000000e0 <strcat>:

void strcat(char *dest, const char *src) {
      e0:	55                   	push   %ebp
      e1:	89 e5                	mov    %esp,%ebp
      e3:	53                   	push   %ebx
      e4:	8b 55 08             	mov    0x8(%ebp),%edx
      e7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    while (*dest) dest++;
      ea:	80 3a 00             	cmpb   $0x0,(%edx)
      ed:	74 09                	je     f8 <strcat+0x18>
      ef:	90                   	nop
      f0:	83 c2 01             	add    $0x1,%edx
      f3:	80 3a 00             	cmpb   $0x0,(%edx)
      f6:	75 f8                	jne    f0 <strcat+0x10>
void strcat(char *dest, const char *src) {
      f8:	31 c0                	xor    %eax,%eax
      fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while ((*dest++ = *src++));
     100:	0f b6 0c 03          	movzbl (%ebx,%eax,1),%ecx
     104:	88 0c 02             	mov    %cl,(%edx,%eax,1)
     107:	83 c0 01             	add    $0x1,%eax
     10a:	84 c9                	test   %cl,%cl
     10c:	75 f2                	jne    100 <strcat+0x20>
}
     10e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     111:	c9                   	leave
     112:	c3                   	ret
     113:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     11a:	00 
     11b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000120 <move>:

int
move(char *source, char *target)
{
     120:	55                   	push   %ebp
     121:	89 e5                	mov    %esp,%ebp
     123:	57                   	push   %edi
     124:	56                   	push   %esi
     125:	53                   	push   %ebx
     126:	81 ec 84 00 00 00    	sub    $0x84,%esp
     12c:	8b 5d 08             	mov    0x8(%ebp),%ebx
     12f:	8b 75 0c             	mov    0xc(%ebp),%esi
	register int c, i;
	//int	status;
	char	buf[MAXN];

	if (stat(source, &s1) < 0) {
     132:	68 a0 21 00 00       	push   $0x21a0
     137:	53                   	push   %ebx
     138:	e8 53 0e 00 00       	call   f90 <stat>
     13d:	83 c4 10             	add    $0x10,%esp
     140:	85 c0                	test   %eax,%eax
     142:	0f 88 13 01 00 00    	js     25b <move+0x13b>
		fprintf(stderr, "mv: cannot access %s\n", source);
		exit();
	}
	if ((s1.st_mode & S_IFMT) == S_IFDIR) {
     148:	0f b7 05 a0 21 00 00 	movzwl 0x21a0,%eax
     14f:	66 25 00 f0          	and    $0xf000,%ax
     153:	66 3d 00 40          	cmp    $0x4000,%ax
     157:	0f 84 eb 00 00 00    	je     248 <move+0x128>
		fprintf(stderr, "mv: directory rename only\n");
		exit();
	}
	if (stat(target, &s2) >= 0) {
     15d:	50                   	push   %eax
     15e:	50                   	push   %eax
     15f:	68 20 21 00 00       	push   $0x2120
     164:	56                   	push   %esi
     165:	e8 26 0e 00 00       	call   f90 <stat>
     16a:	83 c4 10             	add    $0x10,%esp
     16d:	85 c0                	test   %eax,%eax
     16f:	0f 88 ae 00 00 00    	js     223 <move+0x103>
		if ((s2.st_mode & S_IFMT) == S_IFDIR) {
     175:	0f b7 05 20 21 00 00 	movzwl 0x2120,%eax
     17c:	66 25 00 f0          	and    $0xf000,%ax
     180:	66 3d 00 40          	cmp    $0x4000,%ax
     184:	0f 84 42 01 00 00    	je     2cc <move+0x1ac>
			*end++ = '/';                   // Add slash
			strcpy(end, dname(source));      // Append filename
			//sprintf(buf, "%s/%s", target, dname(source));
			//target = buf;
		}
		if (stat(target, &s2) >= 0) {
     18a:	57                   	push   %edi
     18b:	57                   	push   %edi
     18c:	68 20 21 00 00       	push   $0x2120
     191:	56                   	push   %esi
     192:	e8 f9 0d 00 00       	call   f90 <stat>
     197:	83 c4 10             	add    $0x10,%esp
     19a:	85 c0                	test   %eax,%eax
     19c:	0f 88 81 00 00 00    	js     223 <move+0x103>
			if ((s2.st_mode & S_IFMT) == S_IFDIR) {
     1a2:	0f b7 05 20 21 00 00 	movzwl 0x2120,%eax
     1a9:	89 c2                	mov    %eax,%edx
     1ab:	66 81 e2 00 f0       	and    $0xf000,%dx
     1b0:	66 81 fa 00 40       	cmp    $0x4000,%dx
     1b5:	0f 84 8e 01 00 00    	je     349 <move+0x229>
				fprintf(stderr, "mv: %s is a directory\n", target);
				exit();
			}
			if (s1.dev==s2.dev && s1.ino==s2.ino) {
     1bb:	8b 0d 24 21 00 00    	mov    0x2124,%ecx
     1c1:	39 0d a4 21 00 00    	cmp    %ecx,0x21a4
     1c7:	0f 84 57 01 00 00    	je     324 <move+0x204>
				fprintf(stderr, "mv: %s and %s are identical\n",
						source, target);
				exit();
			}
			if ((s2.st_mode & 0222) == 0) {
     1cd:	a8 92                	test   $0x92,%al
     1cf:	75 3e                	jne    20f <move+0xef>
				fprintf(stderr, "mv: %s: %o mode ", target,
     1d1:	25 ff 0f 00 00       	and    $0xfff,%eax
     1d6:	50                   	push   %eax
     1d7:	56                   	push   %esi
     1d8:	68 8d 19 00 00       	push   $0x198d
     1dd:	6a 02                	push   $0x2
     1df:	e8 cc 13 00 00       	call   15b0 <fprintf>
					s2.st_mode & MODEBITS);
			    char response[2];
			    fprintf(stderr, "mv: %s: read-only - overwrite? (y/n) ", target);
     1e4:	83 c4 0c             	add    $0xc,%esp
     1e7:	56                   	push   %esi
     1e8:	68 d0 1a 00 00       	push   $0x1ad0
     1ed:	6a 02                	push   $0x2
     1ef:	e8 bc 13 00 00       	call   15b0 <fprintf>
			    gets(response, sizeof(response));
     1f4:	58                   	pop    %eax
     1f5:	8d 45 82             	lea    -0x7e(%ebp),%eax
     1f8:	5a                   	pop    %edx
     1f9:	6a 02                	push   $0x2
     1fb:	50                   	push   %eax
     1fc:	e8 2f 0d 00 00       	call   f30 <gets>
			    if (response[0] != 'y' && response[0] != 'Y') {
     201:	0f b6 45 82          	movzbl -0x7e(%ebp),%eax
     205:	83 c4 10             	add    $0x10,%esp
     208:	83 e0 df             	and    $0xffffffdf,%eax
     20b:	3c 59                	cmp    $0x59,%al
     20d:	75 34                	jne    243 <move+0x123>
			        exit();
			    }
			}
			if (unlink(target) < 0) {
     20f:	83 ec 0c             	sub    $0xc,%esp
     212:	56                   	push   %esi
     213:	e8 8b 0e 00 00       	call   10a3 <unlink>
     218:	83 c4 10             	add    $0x10,%esp
     21b:	85 c0                	test   %eax,%eax
     21d:	0f 88 39 01 00 00    	js     35c <move+0x23c>
				fprintf(stderr, "mv: cannot unlink %s\n", target);
				exit();
			}
		}
	}
	if (link(source, target) < 0) {
     223:	57                   	push   %edi
     224:	57                   	push   %edi
     225:	56                   	push   %esi
     226:	53                   	push   %ebx
     227:	e8 87 0e 00 00       	call   10b3 <link>
     22c:	83 c4 10             	add    $0x10,%esp
     22f:	85 c0                	test   %eax,%eax
     231:	78 4e                	js     281 <move+0x161>
		while ((c = wait()) != i && c != -1);
		if (status != 0)
			return(1);
//		utime(target, &s1.st_atime);
	}
	if (unlink(source) < 0) {
     233:	83 ec 0c             	sub    $0xc,%esp
     236:	53                   	push   %ebx
     237:	e8 67 0e 00 00       	call   10a3 <unlink>
     23c:	83 c4 10             	add    $0x10,%esp
     23f:	85 c0                	test   %eax,%eax
     241:	78 2b                	js     26e <move+0x14e>
			        exit();
     243:	e8 0b 0e 00 00       	call   1053 <exit>
		fprintf(stderr, "mv: directory rename only\n");
     248:	50                   	push   %eax
     249:	50                   	push   %eax
     24a:	68 3e 19 00 00       	push   $0x193e
     24f:	6a 02                	push   $0x2
     251:	e8 5a 13 00 00       	call   15b0 <fprintf>
		exit();
     256:	e8 f8 0d 00 00       	call   1053 <exit>
		fprintf(stderr, "mv: cannot access %s\n", source);
     25b:	50                   	push   %eax
     25c:	53                   	push   %ebx
     25d:	68 28 19 00 00       	push   $0x1928
     262:	6a 02                	push   $0x2
     264:	e8 47 13 00 00       	call   15b0 <fprintf>
		exit();
     269:	e8 e5 0d 00 00       	call   1053 <exit>
		fprintf(stderr, "mv: cannot unlink %s\n", source);
     26e:	50                   	push   %eax
     26f:	53                   	push   %ebx
     270:	68 9e 19 00 00       	push   $0x199e
     275:	6a 02                	push   $0x2
     277:	e8 34 13 00 00       	call   15b0 <fprintf>
		exit();
     27c:	e8 d2 0d 00 00       	call   1053 <exit>
		i = fork();
     281:	e8 c5 0d 00 00       	call   104b <fork>
     286:	89 c6                	mov    %eax,%esi
		if (i == -1) {
     288:	83 f8 ff             	cmp    $0xffffffff,%eax
     28b:	0f 84 de 00 00 00    	je     36f <move+0x24f>
		if (i == 0) {
     291:	85 c0                	test   %eax,%eax
     293:	75 28                	jne    2bd <move+0x19d>
			while ((c = wait()) != i && c != -1);
     295:	e8 c1 0d 00 00       	call   105b <wait>
     29a:	83 c0 01             	add    $0x1,%eax
     29d:	83 f8 01             	cmp    $0x1,%eax
     2a0:	77 f3                	ja     295 <move+0x175>
			fprintf(stderr, "mv: cannot exec cp\n");
     2a2:	52                   	push   %edx
     2a3:	52                   	push   %edx
     2a4:	68 c3 19 00 00       	push   $0x19c3
     2a9:	6a 02                	push   $0x2
     2ab:	e8 00 13 00 00       	call   15b0 <fprintf>
			exit();
     2b0:	e8 9e 0d 00 00       	call   1053 <exit>
		while ((c = wait()) != i && c != -1);
     2b5:	39 c6                	cmp    %eax,%esi
     2b7:	0f 84 76 ff ff ff    	je     233 <move+0x113>
     2bd:	e8 99 0d 00 00       	call   105b <wait>
     2c2:	83 f8 ff             	cmp    $0xffffffff,%eax
     2c5:	75 ee                	jne    2b5 <move+0x195>
     2c7:	e9 67 ff ff ff       	jmp    233 <move+0x113>
			strcpy(buf, target);            // Copy target directory
     2cc:	8d 7d 84             	lea    -0x7c(%ebp),%edi
     2cf:	50                   	push   %eax
     2d0:	50                   	push   %eax
     2d1:	56                   	push   %esi
     2d2:	57                   	push   %edi
     2d3:	e8 28 0b 00 00       	call   e00 <strcpy>
			char *end = buf + strlen(buf);  // Find end of string
     2d8:	89 3c 24             	mov    %edi,(%esp)
     2db:	e8 c0 0b 00 00       	call   ea0 <strlen>
dname(char * name)
{
	register char *p;

	p = name;
	while (*p)
     2e0:	0f b6 13             	movzbl (%ebx),%edx
     2e3:	83 c4 10             	add    $0x10,%esp
			char *end = buf + strlen(buf);  // Find end of string
     2e6:	01 c7                	add    %eax,%edi
			*end++ = '/';                   // Add slash
     2e8:	c6 07 2f             	movb   $0x2f,(%edi)
     2eb:	8d 4f 01             	lea    0x1(%edi),%ecx
	while (*p)
     2ee:	89 df                	mov    %ebx,%edi
     2f0:	84 d2                	test   %dl,%dl
     2f2:	74 18                	je     30c <move+0x1ec>
	p = name;
     2f4:	89 d8                	mov    %ebx,%eax
		if (*p++ == DELIM && *p)
     2f6:	83 c0 01             	add    $0x1,%eax
     2f9:	80 fa 2f             	cmp    $0x2f,%dl
     2fc:	74 09                	je     307 <move+0x1e7>
	while (*p)
     2fe:	0f b6 10             	movzbl (%eax),%edx
     301:	84 d2                	test   %dl,%dl
     303:	75 f1                	jne    2f6 <move+0x1d6>
     305:	eb 05                	jmp    30c <move+0x1ec>
		if (*p++ == DELIM && *p)
     307:	80 38 00             	cmpb   $0x0,(%eax)
     30a:	75 11                	jne    31d <move+0x1fd>
			strcpy(end, dname(source));      // Append filename
     30c:	50                   	push   %eax
     30d:	50                   	push   %eax
     30e:	57                   	push   %edi
     30f:	51                   	push   %ecx
     310:	e8 eb 0a 00 00       	call   e00 <strcpy>
     315:	83 c4 10             	add    $0x10,%esp
     318:	e9 6d fe ff ff       	jmp    18a <move+0x6a>
	while (*p)
     31d:	0f b6 10             	movzbl (%eax),%edx
			name = p;
     320:	89 c7                	mov    %eax,%edi
     322:	eb d2                	jmp    2f6 <move+0x1d6>
			if (s1.dev==s2.dev && s1.ino==s2.ino) {
     324:	8b 0d 28 21 00 00    	mov    0x2128,%ecx
     32a:	39 0d a8 21 00 00    	cmp    %ecx,0x21a8
     330:	0f 85 97 fe ff ff    	jne    1cd <move+0xad>
				fprintf(stderr, "mv: %s and %s are identical\n",
     336:	56                   	push   %esi
     337:	53                   	push   %ebx
     338:	68 70 19 00 00       	push   $0x1970
     33d:	6a 02                	push   $0x2
     33f:	e8 6c 12 00 00       	call   15b0 <fprintf>
				exit();
     344:	e8 0a 0d 00 00       	call   1053 <exit>
				fprintf(stderr, "mv: %s is a directory\n", target);
     349:	51                   	push   %ecx
     34a:	56                   	push   %esi
     34b:	68 59 19 00 00       	push   $0x1959
     350:	6a 02                	push   $0x2
     352:	e8 59 12 00 00       	call   15b0 <fprintf>
				exit();
     357:	e8 f7 0c 00 00       	call   1053 <exit>
				fprintf(stderr, "mv: cannot unlink %s\n", target);
     35c:	50                   	push   %eax
     35d:	56                   	push   %esi
     35e:	68 9e 19 00 00       	push   $0x199e
     363:	6a 02                	push   $0x2
     365:	e8 46 12 00 00       	call   15b0 <fprintf>
				exit();
     36a:	e8 e4 0c 00 00       	call   1053 <exit>
			fprintf(stderr, "mv: try again\n");
     36f:	51                   	push   %ecx
     370:	51                   	push   %ecx
     371:	68 b4 19 00 00       	push   $0x19b4
     376:	6a 02                	push   $0x2
     378:	e8 33 12 00 00       	call   15b0 <fprintf>
			exit();
     37d:	e8 d1 0c 00 00       	call   1053 <exit>
     382:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     389:	00 
     38a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000390 <pname>:
{
     390:	55                   	push   %ebp
     391:	89 e5                	mov    %esp,%ebp
     393:	53                   	push   %ebx
     394:	8b 45 08             	mov    0x8(%ebp),%eax
	while ((c = *p++ = *name++))
     397:	8d 48 01             	lea    0x1(%eax),%ecx
     39a:	0f be 00             	movsbl (%eax),%eax
     39d:	a2 20 22 00 00       	mov    %al,0x2220
     3a2:	85 c0                	test   %eax,%eax
     3a4:	74 68                	je     40e <pname+0x7e>
     3a6:	ba 20 22 00 00       	mov    $0x2220,%edx
	p = q = buf;
     3ab:	89 d3                	mov    %edx,%ebx
     3ad:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     3b4:	00 
     3b5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     3bc:	00 
     3bd:	8d 76 00             	lea    0x0(%esi),%esi
			q = p-1;
     3c0:	83 f8 2f             	cmp    $0x2f,%eax
     3c3:	0f 44 da             	cmove  %edx,%ebx
	while ((c = *p++ = *name++))
     3c6:	0f be 01             	movsbl (%ecx),%eax
     3c9:	83 c1 01             	add    $0x1,%ecx
     3cc:	83 c2 01             	add    $0x1,%edx
     3cf:	88 02                	mov    %al,(%edx)
     3d1:	85 c0                	test   %eax,%eax
     3d3:	75 eb                	jne    3c0 <pname+0x30>
	if (q == buf && *q == DELIM)
     3d5:	81 fb 20 22 00 00    	cmp    $0x2220,%ebx
     3db:	74 23                	je     400 <pname+0x70>
	*q = 0;
     3dd:	c6 03 00             	movb   $0x0,(%ebx)
	return buf[0]? buf : DOT;
     3e0:	b8 ed 19 00 00       	mov    $0x19ed,%eax
     3e5:	ba 20 22 00 00       	mov    $0x2220,%edx
}
     3ea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
	return buf[0]? buf : DOT;
     3ed:	80 3d 20 22 00 00 00 	cmpb   $0x0,0x2220
}
     3f4:	c9                   	leave
	return buf[0]? buf : DOT;
     3f5:	0f 45 c2             	cmovne %edx,%eax
}
     3f8:	c3                   	ret
     3f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	if (q == buf && *q == DELIM)
     400:	80 3d 20 22 00 00 2f 	cmpb   $0x2f,0x2220
		q++;
     407:	bb 21 22 00 00       	mov    $0x2221,%ebx
	if (q == buf && *q == DELIM)
     40c:	74 cf                	je     3dd <pname+0x4d>
			q = p-1;
     40e:	bb 20 22 00 00       	mov    $0x2220,%ebx
     413:	eb c8                	jmp    3dd <pname+0x4d>
     415:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     41c:	00 
     41d:	8d 76 00             	lea    0x0(%esi),%esi

00000420 <dname>:
{
     420:	55                   	push   %ebp
     421:	89 e5                	mov    %esp,%ebp
     423:	8b 45 08             	mov    0x8(%ebp),%eax
	while (*p)
     426:	0f b6 10             	movzbl (%eax),%edx
     429:	89 c1                	mov    %eax,%ecx
     42b:	84 d2                	test   %dl,%dl
     42d:	74 10                	je     43f <dname+0x1f>
     42f:	90                   	nop
		if (*p++ == DELIM && *p)
     430:	83 c0 01             	add    $0x1,%eax
     433:	80 fa 2f             	cmp    $0x2f,%dl
     436:	74 10                	je     448 <dname+0x28>
	while (*p)
     438:	0f b6 10             	movzbl (%eax),%edx
     43b:	84 d2                	test   %dl,%dl
     43d:	75 f1                	jne    430 <dname+0x10>
	return name;
}
     43f:	89 c8                	mov    %ecx,%eax
     441:	5d                   	pop    %ebp
     442:	c3                   	ret
     443:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
		if (*p++ == DELIM && *p)
     448:	80 38 00             	cmpb   $0x0,(%eax)
     44b:	74 eb                	je     438 <dname+0x18>
	while (*p)
     44d:	0f b6 10             	movzbl (%eax),%edx
			name = p;
     450:	89 c1                	mov    %eax,%ecx
     452:	eb dc                	jmp    430 <dname+0x10>
     454:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     45b:	00 
     45c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000460 <check>:

int 
check(char *spth, uint dinode)
{
     460:	55                   	push   %ebp
     461:	89 e5                	mov    %esp,%ebp
     463:	57                   	push   %edi
     464:	56                   	push   %esi
     465:	53                   	push   %ebx
	char nspth[MAXN];
	struct stat sbuf;

	sbuf.ino = 0;

	strcpy(nspth, spth);
     466:	8d 5d 84             	lea    -0x7c(%ebp),%ebx
{
     469:	81 ec e4 00 00 00    	sub    $0xe4,%esp
     46f:	8b 7d 0c             	mov    0xc(%ebp),%edi
	sbuf.ino = 0;
     472:	c7 85 28 ff ff ff 00 	movl   $0x0,-0xd8(%ebp)
     479:	00 00 00 
	strcpy(nspth, spth);
     47c:	ff 75 08             	push   0x8(%ebp)
     47f:	53                   	push   %ebx
     480:	e8 7b 09 00 00       	call   e00 <strcpy>
	while (sbuf.ino != ROOTINO) {
     485:	83 c4 10             	add    $0x10,%esp
     488:	83 bd 28 ff ff ff 01 	cmpl   $0x1,-0xd8(%ebp)
     48f:	0f 84 c9 00 00 00    	je     55e <check+0xfe>
     495:	8d b5 20 ff ff ff    	lea    -0xe0(%ebp),%esi
     49b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
		if (stat(nspth, &sbuf) < 0) {
     4a0:	83 ec 08             	sub    $0x8,%esp
     4a3:	56                   	push   %esi
     4a4:	53                   	push   %ebx
     4a5:	e8 e6 0a 00 00       	call   f90 <stat>
     4aa:	83 c4 10             	add    $0x10,%esp
     4ad:	85 c0                	test   %eax,%eax
     4af:	0f 88 b3 00 00 00    	js     568 <check+0x108>
			fprintf(stderr, "mv: cannot access %s\n", nspth);
			return(1);
		}
		if (sbuf.ino == dinode) {
     4b5:	39 bd 28 ff ff ff    	cmp    %edi,-0xd8(%ebp)
     4bb:	0f 84 c7 00 00 00    	je     588 <check+0x128>
			fprintf(stderr, "mv: cannot move a directory into itself\n");
			return(1);
		}
		if (strlen(nspth) > MAXN-2-sizeof(DOTDOT)) {
     4c1:	83 ec 0c             	sub    $0xc,%esp
     4c4:	53                   	push   %ebx
     4c5:	e8 d6 09 00 00       	call   ea0 <strlen>
     4ca:	83 c4 10             	add    $0x10,%esp
     4cd:	83 f8 5f             	cmp    $0x5f,%eax
     4d0:	0f 87 c6 00 00 00    	ja     59c <check+0x13c>
    while (*dest) dest++;
     4d6:	80 7d 84 00          	cmpb   $0x0,-0x7c(%ebp)
     4da:	89 da                	mov    %ebx,%edx
     4dc:	74 0a                	je     4e8 <check+0x88>
     4de:	66 90                	xchg   %ax,%ax
     4e0:	83 c2 01             	add    $0x1,%edx
     4e3:	80 3a 00             	cmpb   $0x0,(%edx)
     4e6:	75 f8                	jne    4e0 <check+0x80>
     4e8:	31 c0                	xor    %eax,%eax
     4ea:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     4f1:	00 
     4f2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     4f9:	00 
     4fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while ((*dest++ = *src++));
     500:	0f b6 88 ea 19 00 00 	movzbl 0x19ea(%eax),%ecx
     507:	88 0c 02             	mov    %cl,(%edx,%eax,1)
     50a:	83 c0 01             	add    $0x1,%eax
     50d:	84 c9                	test   %cl,%cl
     50f:	75 ef                	jne    500 <check+0xa0>
    while (*dest) dest++;
     511:	80 7d 84 00          	cmpb   $0x0,-0x7c(%ebp)
     515:	89 da                	mov    %ebx,%edx
     517:	74 0f                	je     528 <check+0xc8>
     519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     520:	83 c2 01             	add    $0x1,%edx
     523:	80 3a 00             	cmpb   $0x0,(%edx)
     526:	75 f8                	jne    520 <check+0xc0>
     528:	31 c0                	xor    %eax,%eax
     52a:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     531:	00 
     532:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     539:	00 
     53a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while ((*dest++ = *src++));
     540:	0f b6 88 ec 19 00 00 	movzbl 0x19ec(%eax),%ecx
     547:	88 0c 02             	mov    %cl,(%edx,%eax,1)
     54a:	83 c0 01             	add    $0x1,%eax
     54d:	84 c9                	test   %cl,%cl
     54f:	75 ef                	jne    540 <check+0xe0>
	while (sbuf.ino != ROOTINO) {
     551:	83 bd 28 ff ff ff 01 	cmpl   $0x1,-0xd8(%ebp)
     558:	0f 85 42 ff ff ff    	jne    4a0 <check+0x40>
		}
		strcat(nspth, SDELIM);
		strcat(nspth, DOTDOT);
	}
	return(0);
}
     55e:	8d 65 f4             	lea    -0xc(%ebp),%esp
	return(0);
     561:	31 c0                	xor    %eax,%eax
}
     563:	5b                   	pop    %ebx
     564:	5e                   	pop    %esi
     565:	5f                   	pop    %edi
     566:	5d                   	pop    %ebp
     567:	c3                   	ret
			fprintf(stderr, "mv: cannot access %s\n", nspth);
     568:	83 ec 04             	sub    $0x4,%esp
     56b:	53                   	push   %ebx
     56c:	68 28 19 00 00       	push   $0x1928
     571:	6a 02                	push   $0x2
     573:	e8 38 10 00 00       	call   15b0 <fprintf>
			return(1);
     578:	83 c4 10             	add    $0x10,%esp
}
     57b:	8d 65 f4             	lea    -0xc(%ebp),%esp
			return(1);
     57e:	b8 01 00 00 00       	mov    $0x1,%eax
}
     583:	5b                   	pop    %ebx
     584:	5e                   	pop    %esi
     585:	5f                   	pop    %edi
     586:	5d                   	pop    %ebp
     587:	c3                   	ret
			fprintf(stderr, "mv: cannot move a directory into itself\n");
     588:	83 ec 08             	sub    $0x8,%esp
     58b:	68 f8 1a 00 00       	push   $0x1af8
     590:	6a 02                	push   $0x2
     592:	e8 19 10 00 00       	call   15b0 <fprintf>
			return(1);
     597:	83 c4 10             	add    $0x10,%esp
     59a:	eb df                	jmp    57b <check+0x11b>
			fprintf(stderr, "mv: name too long\n");
     59c:	83 ec 08             	sub    $0x8,%esp
     59f:	68 d7 19 00 00       	push   $0x19d7
     5a4:	6a 02                	push   $0x2
     5a6:	e8 05 10 00 00       	call   15b0 <fprintf>
			return(1);
     5ab:	83 c4 10             	add    $0x10,%esp
     5ae:	eb cb                	jmp    57b <check+0x11b>

000005b0 <chkdot>:

int
chkdot(register char *s)
{
     5b0:	55                   	push   %ebp
     5b1:	89 e5                	mov    %esp,%ebp
     5b3:	56                   	push   %esi
     5b4:	53                   	push   %ebx
     5b5:	8b 75 08             	mov    0x8(%ebp),%esi
	return buf[0]? buf : DOT;
     5b8:	bb 20 22 00 00       	mov    $0x2220,%ebx
     5bd:	8d 76 00             	lea    0x0(%esi),%esi
	while (*p)
     5c0:	0f b6 16             	movzbl (%esi),%edx
     5c3:	89 f1                	mov    %esi,%ecx
     5c5:	84 d2                	test   %dl,%dl
     5c7:	74 22                	je     5eb <chkdot+0x3b>
	p = name;
     5c9:	89 f0                	mov    %esi,%eax
		if (*p++ == DELIM && *p)
     5cb:	83 c0 01             	add    $0x1,%eax
     5ce:	80 fa 2f             	cmp    $0x2f,%dl
     5d1:	74 0f                	je     5e2 <chkdot+0x32>
	while (*p)
     5d3:	0f b6 10             	movzbl (%eax),%edx
     5d6:	84 d2                	test   %dl,%dl
     5d8:	74 11                	je     5eb <chkdot+0x3b>
		if (*p++ == DELIM && *p)
     5da:	83 c0 01             	add    $0x1,%eax
     5dd:	80 fa 2f             	cmp    $0x2f,%dl
     5e0:	75 f1                	jne    5d3 <chkdot+0x23>
     5e2:	80 38 00             	cmpb   $0x0,(%eax)
     5e5:	0f 85 a5 00 00 00    	jne    690 <chkdot+0xe0>
	do {
		if (strcmp(dname(s), DOTDOT) == 0)
     5eb:	83 ec 08             	sub    $0x8,%esp
     5ee:	68 ec 19 00 00       	push   $0x19ec
     5f3:	51                   	push   %ecx
     5f4:	e8 37 08 00 00       	call   e30 <strcmp>
     5f9:	83 c4 10             	add    $0x10,%esp
     5fc:	85 c0                	test   %eax,%eax
     5fe:	0f 84 b1 00 00 00    	je     6b5 <chkdot+0x105>
	while ((c = *p++ = *name++))
     604:	0f be 06             	movsbl (%esi),%eax
     607:	8d 4e 01             	lea    0x1(%esi),%ecx
     60a:	a2 20 22 00 00       	mov    %al,0x2220
     60f:	85 c0                	test   %eax,%eax
     611:	0f 84 97 00 00 00    	je     6ae <chkdot+0xfe>
     617:	ba 20 22 00 00       	mov    $0x2220,%edx
	p = q = buf;
     61c:	89 d6                	mov    %edx,%esi
     61e:	66 90                	xchg   %ax,%ax
			q = p-1;
     620:	83 f8 2f             	cmp    $0x2f,%eax
     623:	0f 44 f2             	cmove  %edx,%esi
	while ((c = *p++ = *name++))
     626:	0f be 01             	movsbl (%ecx),%eax
     629:	83 c1 01             	add    $0x1,%ecx
     62c:	83 c2 01             	add    $0x1,%edx
     62f:	88 02                	mov    %al,(%edx)
     631:	85 c0                	test   %eax,%eax
     633:	75 eb                	jne    620 <chkdot+0x70>
	if (q == buf && *q == DELIM)
     635:	81 fe 20 22 00 00    	cmp    $0x2220,%esi
     63b:	74 63                	je     6a0 <chkdot+0xf0>
	*q = 0;
     63d:	c6 06 00             	movb   $0x0,(%esi)
	return buf[0]? buf : DOT;
     640:	be ed 19 00 00       	mov    $0x19ed,%esi
     645:	80 3d 20 22 00 00 00 	cmpb   $0x0,0x2220
     64c:	0f 45 f3             	cmovne %ebx,%esi
			return(1);
		s = pname(s);
	} while (strcmp(s, DOT) != 0 && strcmp(s, SDELIM) != 0);
     64f:	83 ec 08             	sub    $0x8,%esp
     652:	68 ed 19 00 00       	push   $0x19ed
     657:	56                   	push   %esi
     658:	e8 d3 07 00 00       	call   e30 <strcmp>
     65d:	83 c4 10             	add    $0x10,%esp
     660:	85 c0                	test   %eax,%eax
     662:	74 19                	je     67d <chkdot+0xcd>
     664:	83 ec 08             	sub    $0x8,%esp
     667:	68 ea 19 00 00       	push   $0x19ea
     66c:	56                   	push   %esi
     66d:	e8 be 07 00 00       	call   e30 <strcmp>
     672:	83 c4 10             	add    $0x10,%esp
     675:	85 c0                	test   %eax,%eax
     677:	0f 85 43 ff ff ff    	jne    5c0 <chkdot+0x10>
	return(0);
}
     67d:	8d 65 f8             	lea    -0x8(%ebp),%esp
	return(0);
     680:	31 c0                	xor    %eax,%eax
}
     682:	5b                   	pop    %ebx
     683:	5e                   	pop    %esi
     684:	5d                   	pop    %ebp
     685:	c3                   	ret
     686:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     68d:	00 
     68e:	66 90                	xchg   %ax,%ax
	while (*p)
     690:	0f b6 10             	movzbl (%eax),%edx
			name = p;
     693:	89 c1                	mov    %eax,%ecx
     695:	e9 31 ff ff ff       	jmp    5cb <chkdot+0x1b>
     69a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	if (q == buf && *q == DELIM)
     6a0:	80 3d 20 22 00 00 2f 	cmpb   $0x2f,0x2220
		q++;
     6a7:	be 21 22 00 00       	mov    $0x2221,%esi
	if (q == buf && *q == DELIM)
     6ac:	74 8f                	je     63d <chkdot+0x8d>
			q = p-1;
     6ae:	be 20 22 00 00       	mov    $0x2220,%esi
     6b3:	eb 88                	jmp    63d <chkdot+0x8d>
}
     6b5:	8d 65 f8             	lea    -0x8(%ebp),%esp
			return(1);
     6b8:	b8 01 00 00 00       	mov    $0x1,%eax
}
     6bd:	5b                   	pop    %ebx
     6be:	5e                   	pop    %esi
     6bf:	5d                   	pop    %ebp
     6c0:	c3                   	ret
     6c1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     6c8:	00 
     6c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006d0 <mvdir>:
{
     6d0:	55                   	push   %ebp
     6d1:	89 e5                	mov    %esp,%ebp
     6d3:	57                   	push   %edi
     6d4:	56                   	push   %esi
     6d5:	53                   	push   %ebx
     6d6:	81 ec f4 00 00 00    	sub    $0xf4,%esp
     6dc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     6df:	8b 75 08             	mov    0x8(%ebp),%esi
	if (stat(target, &s2) >= 0) {
     6e2:	68 20 21 00 00       	push   $0x2120
     6e7:	53                   	push   %ebx
     6e8:	e8 a3 08 00 00       	call   f90 <stat>
     6ed:	83 c4 10             	add    $0x10,%esp
     6f0:	85 c0                	test   %eax,%eax
     6f2:	0f 88 11 01 00 00    	js     809 <mvdir+0x139>
		if ((s2.st_mode&S_IFMT) != S_IFDIR) {
     6f8:	0f b7 05 20 21 00 00 	movzwl 0x2120,%eax
     6ff:	66 25 00 f0          	and    $0xf000,%ax
     703:	66 3d 00 40          	cmp    $0x4000,%ax
     707:	74 27                	je     730 <mvdir+0x60>
			fprintf(stderr, "mv: %s exists\n", target);
     709:	83 ec 04             	sub    $0x4,%esp
     70c:	53                   	push   %ebx
     70d:	68 ef 19 00 00       	push   $0x19ef
     712:	6a 02                	push   $0x2
     714:	e8 97 0e 00 00       	call   15b0 <fprintf>
			return(1);
     719:	83 c4 10             	add    $0x10,%esp
			return(1);
     71c:	ba 01 00 00 00       	mov    $0x1,%edx
}
     721:	8d 65 f4             	lea    -0xc(%ebp),%esp
     724:	89 d0                	mov    %edx,%eax
     726:	5b                   	pop    %ebx
     727:	5e                   	pop    %esi
     728:	5f                   	pop    %edi
     729:	5d                   	pop    %ebp
     72a:	c3                   	ret
     72b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
		if (strlen(target) > MAXN-DIRSIZ-2) {
     730:	83 ec 0c             	sub    $0xc,%esp
     733:	53                   	push   %ebx
     734:	e8 67 07 00 00       	call   ea0 <strlen>
     739:	83 c4 10             	add    $0x10,%esp
     73c:	83 f8 54             	cmp    $0x54,%eax
     73f:	0f 87 9b 04 00 00    	ja     be0 <mvdir+0x510>
		strcpy(buf, target);
     745:	83 ec 08             	sub    $0x8,%esp
     748:	8d bd 1b ff ff ff    	lea    -0xe5(%ebp),%edi
     74e:	53                   	push   %ebx
     74f:	57                   	push   %edi
     750:	e8 ab 06 00 00       	call   e00 <strcpy>
    while (*dest) dest++;
     755:	83 c4 10             	add    $0x10,%esp
     758:	80 bd 1b ff ff ff 00 	cmpb   $0x0,-0xe5(%ebp)
     75f:	89 fa                	mov    %edi,%edx
     761:	74 15                	je     778 <mvdir+0xa8>
     763:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
     768:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     76f:	00 
     770:	83 c2 01             	add    $0x1,%edx
     773:	80 3a 00             	cmpb   $0x0,(%edx)
     776:	75 f8                	jne    770 <mvdir+0xa0>
     778:	31 c0                	xor    %eax,%eax
     77a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while ((*dest++ = *src++));
     780:	0f b6 88 ea 19 00 00 	movzbl 0x19ea(%eax),%ecx
     787:	88 0c 02             	mov    %cl,(%edx,%eax,1)
     78a:	83 c0 01             	add    $0x1,%eax
     78d:	84 c9                	test   %cl,%cl
     78f:	75 ef                	jne    780 <mvdir+0xb0>
	while (*p)
     791:	0f b6 16             	movzbl (%esi),%edx
     794:	89 f1                	mov    %esi,%ecx
     796:	84 d2                	test   %dl,%dl
     798:	74 22                	je     7bc <mvdir+0xec>
	p = name;
     79a:	89 f0                	mov    %esi,%eax
		if (*p++ == DELIM && *p)
     79c:	83 c0 01             	add    $0x1,%eax
     79f:	80 fa 2f             	cmp    $0x2f,%dl
     7a2:	74 0f                	je     7b3 <mvdir+0xe3>
	while (*p)
     7a4:	0f b6 10             	movzbl (%eax),%edx
     7a7:	84 d2                	test   %dl,%dl
     7a9:	74 11                	je     7bc <mvdir+0xec>
		if (*p++ == DELIM && *p)
     7ab:	83 c0 01             	add    $0x1,%eax
     7ae:	80 fa 2f             	cmp    $0x2f,%dl
     7b1:	75 f1                	jne    7a4 <mvdir+0xd4>
     7b3:	80 38 00             	cmpb   $0x0,(%eax)
     7b6:	0f 85 e4 00 00 00    	jne    8a0 <mvdir+0x1d0>
    while (*dest) dest++;
     7bc:	80 bd 1b ff ff ff 00 	cmpb   $0x0,-0xe5(%ebp)
     7c3:	89 fa                	mov    %edi,%edx
     7c5:	74 11                	je     7d8 <mvdir+0x108>
     7c7:	90                   	nop
     7c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     7cf:	00 
     7d0:	83 c2 01             	add    $0x1,%edx
     7d3:	80 3a 00             	cmpb   $0x0,(%edx)
     7d6:	75 f8                	jne    7d0 <mvdir+0x100>
     7d8:	31 c0                	xor    %eax,%eax
     7da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while ((*dest++ = *src++));
     7e0:	0f b6 1c 01          	movzbl (%ecx,%eax,1),%ebx
     7e4:	88 1c 02             	mov    %bl,(%edx,%eax,1)
     7e7:	83 c0 01             	add    $0x1,%eax
     7ea:	84 db                	test   %bl,%bl
     7ec:	75 f2                	jne    7e0 <mvdir+0x110>
		if (stat(target, &s2) >= 0) {
     7ee:	83 ec 08             	sub    $0x8,%esp
		target = buf;
     7f1:	89 fb                	mov    %edi,%ebx
		if (stat(target, &s2) >= 0) {
     7f3:	68 20 21 00 00       	push   $0x2120
     7f8:	57                   	push   %edi
     7f9:	e8 92 07 00 00       	call   f90 <stat>
     7fe:	83 c4 10             	add    $0x10,%esp
     801:	85 c0                	test   %eax,%eax
     803:	0f 89 b7 03 00 00    	jns    bc0 <mvdir+0x4f0>
	if (strcmp(source, target) == 0) {
     809:	83 ec 08             	sub    $0x8,%esp
     80c:	53                   	push   %ebx
     80d:	56                   	push   %esi
     80e:	e8 1d 06 00 00       	call   e30 <strcmp>
     813:	83 c4 10             	add    $0x10,%esp
     816:	85 c0                	test   %eax,%eax
     818:	0f 84 e2 03 00 00    	je     c00 <mvdir+0x530>
	while (*p)
     81e:	0f b6 16             	movzbl (%esi),%edx
     821:	89 f7                	mov    %esi,%edi
	p = name;
     823:	89 f0                	mov    %esi,%eax
	while (*p)
     825:	84 d2                	test   %dl,%dl
     827:	74 1c                	je     845 <mvdir+0x175>
		if (*p++ == DELIM && *p)
     829:	83 c0 01             	add    $0x1,%eax
     82c:	80 fa 2f             	cmp    $0x2f,%dl
     82f:	74 0f                	je     840 <mvdir+0x170>
	while (*p)
     831:	0f b6 10             	movzbl (%eax),%edx
     834:	84 d2                	test   %dl,%dl
     836:	74 0d                	je     845 <mvdir+0x175>
		if (*p++ == DELIM && *p)
     838:	83 c0 01             	add    $0x1,%eax
     83b:	80 fa 2f             	cmp    $0x2f,%dl
     83e:	75 f1                	jne    831 <mvdir+0x161>
     840:	80 38 00             	cmpb   $0x0,(%eax)
     843:	75 4b                	jne    890 <mvdir+0x1c0>
	if (!strcmp(p, DOT) || !strcmp(p, DOTDOT) || !strcmp(p, "") || p[strlen(p)-1]=='/') {
     845:	83 ec 08             	sub    $0x8,%esp
     848:	68 ed 19 00 00       	push   $0x19ed
     84d:	57                   	push   %edi
     84e:	e8 dd 05 00 00       	call   e30 <strcmp>
     853:	83 c4 10             	add    $0x10,%esp
     856:	85 c0                	test   %eax,%eax
     858:	74 15                	je     86f <mvdir+0x19f>
     85a:	83 ec 08             	sub    $0x8,%esp
     85d:	68 ec 19 00 00       	push   $0x19ec
     862:	57                   	push   %edi
     863:	e8 c8 05 00 00       	call   e30 <strcmp>
     868:	83 c4 10             	add    $0x10,%esp
     86b:	85 c0                	test   %eax,%eax
     86d:	75 41                	jne    8b0 <mvdir+0x1e0>
		fprintf(stderr, "mv: cannot rename %s\n", p);
     86f:	83 ec 04             	sub    $0x4,%esp
     872:	57                   	push   %edi
     873:	68 18 1a 00 00       	push   $0x1a18
     878:	6a 02                	push   $0x2
     87a:	e8 31 0d 00 00       	call   15b0 <fprintf>
		return(1);
     87f:	83 c4 10             	add    $0x10,%esp
     882:	e9 95 fe ff ff       	jmp    71c <mvdir+0x4c>
     887:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     88e:	00 
     88f:	90                   	nop
	while (*p)
     890:	0f b6 10             	movzbl (%eax),%edx
			name = p;
     893:	89 c7                	mov    %eax,%edi
     895:	eb 92                	jmp    829 <mvdir+0x159>
     897:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     89e:	00 
     89f:	90                   	nop
	while (*p)
     8a0:	0f b6 10             	movzbl (%eax),%edx
			name = p;
     8a3:	89 c1                	mov    %eax,%ecx
     8a5:	e9 f2 fe ff ff       	jmp    79c <mvdir+0xcc>
     8aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	if (!strcmp(p, DOT) || !strcmp(p, DOTDOT) || !strcmp(p, "") || p[strlen(p)-1]=='/') {
     8b0:	83 ec 08             	sub    $0x8,%esp
     8b3:	68 e9 19 00 00       	push   $0x19e9
     8b8:	57                   	push   %edi
     8b9:	e8 72 05 00 00       	call   e30 <strcmp>
     8be:	83 c4 10             	add    $0x10,%esp
     8c1:	85 c0                	test   %eax,%eax
     8c3:	74 aa                	je     86f <mvdir+0x19f>
     8c5:	83 ec 0c             	sub    $0xc,%esp
     8c8:	57                   	push   %edi
     8c9:	e8 d2 05 00 00       	call   ea0 <strlen>
     8ce:	83 c4 10             	add    $0x10,%esp
     8d1:	80 7c 07 ff 2f       	cmpb   $0x2f,-0x1(%edi,%eax,1)
     8d6:	74 97                	je     86f <mvdir+0x19f>
	while ((c = *p++ = *name++))
     8d8:	0f be 06             	movsbl (%esi),%eax
     8db:	ba 20 22 00 00       	mov    $0x2220,%edx
     8e0:	8d 4e 01             	lea    0x1(%esi),%ecx
	p = q = buf;
     8e3:	89 d7                	mov    %edx,%edi
	while ((c = *p++ = *name++))
     8e5:	a2 20 22 00 00       	mov    %al,0x2220
     8ea:	85 c0                	test   %eax,%eax
     8ec:	0f 84 4e 03 00 00    	je     c40 <mvdir+0x570>
     8f2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     8f9:	00 
     8fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			q = p-1;
     900:	83 f8 2f             	cmp    $0x2f,%eax
     903:	0f 44 fa             	cmove  %edx,%edi
	while ((c = *p++ = *name++))
     906:	0f be 01             	movsbl (%ecx),%eax
     909:	83 c1 01             	add    $0x1,%ecx
     90c:	83 c2 01             	add    $0x1,%edx
     90f:	88 02                	mov    %al,(%edx)
     911:	85 c0                	test   %eax,%eax
     913:	75 eb                	jne    900 <mvdir+0x230>
	if (q == buf && *q == DELIM)
     915:	81 ff 20 22 00 00    	cmp    $0x2220,%edi
     91b:	0f 84 0d 03 00 00    	je     c2e <mvdir+0x55e>
	*q = 0;
     921:	c6 07 00             	movb   $0x0,(%edi)
	return buf[0]? buf : DOT;
     924:	ba 20 22 00 00       	mov    $0x2220,%edx
     929:	b8 ed 19 00 00       	mov    $0x19ed,%eax
     92e:	80 3d 20 22 00 00 00 	cmpb   $0x0,0x2220
     935:	0f 45 c2             	cmovne %edx,%eax
	if (stat(pname(source), &s1) < 0 || stat(pname(target), &s2) < 0) {
     938:	83 ec 08             	sub    $0x8,%esp
     93b:	68 a0 21 00 00       	push   $0x21a0
     940:	50                   	push   %eax
     941:	e8 4a 06 00 00       	call   f90 <stat>
     946:	83 c4 10             	add    $0x10,%esp
     949:	85 c0                	test   %eax,%eax
     94b:	0f 88 c6 02 00 00    	js     c17 <mvdir+0x547>
	while ((c = *p++ = *name++))
     951:	0f be 03             	movsbl (%ebx),%eax
     954:	8d 4b 01             	lea    0x1(%ebx),%ecx
     957:	89 8d 14 ff ff ff    	mov    %ecx,-0xec(%ebp)
     95d:	a2 20 22 00 00       	mov    %al,0x2220
     962:	85 c0                	test   %eax,%eax
     964:	0f 84 f2 02 00 00    	je     c5c <mvdir+0x58c>
     96a:	ba 20 22 00 00       	mov    $0x2220,%edx
	p = q = buf;
     96f:	89 d7                	mov    %edx,%edi
     971:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     978:	00 
     979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			q = p-1;
     980:	83 f8 2f             	cmp    $0x2f,%eax
     983:	0f 44 fa             	cmove  %edx,%edi
	while ((c = *p++ = *name++))
     986:	0f be 01             	movsbl (%ecx),%eax
     989:	83 c1 01             	add    $0x1,%ecx
     98c:	83 c2 01             	add    $0x1,%edx
     98f:	88 02                	mov    %al,(%edx)
     991:	85 c0                	test   %eax,%eax
     993:	75 eb                	jne    980 <mvdir+0x2b0>
	if (q == buf && *q == DELIM)
     995:	81 ff 20 22 00 00    	cmp    $0x2220,%edi
     99b:	0f 84 a9 02 00 00    	je     c4a <mvdir+0x57a>
	*q = 0;
     9a1:	c6 07 00             	movb   $0x0,(%edi)
	return buf[0]? buf : DOT;
     9a4:	ba 20 22 00 00       	mov    $0x2220,%edx
     9a9:	b8 ed 19 00 00       	mov    $0x19ed,%eax
     9ae:	80 3d 20 22 00 00 00 	cmpb   $0x0,0x2220
     9b5:	0f 45 c2             	cmovne %edx,%eax
	if (stat(pname(source), &s1) < 0 || stat(pname(target), &s2) < 0) {
     9b8:	83 ec 08             	sub    $0x8,%esp
     9bb:	68 20 21 00 00       	push   $0x2120
     9c0:	50                   	push   %eax
     9c1:	e8 ca 05 00 00       	call   f90 <stat>
     9c6:	83 c4 10             	add    $0x10,%esp
     9c9:	85 c0                	test   %eax,%eax
     9cb:	0f 88 46 02 00 00    	js     c17 <mvdir+0x547>
	if ((s2.st_mode & 0200) == 0) {
     9d1:	f6 05 20 21 00 00 80 	testb  $0x80,0x2120
     9d8:	0f 84 bb 02 00 00    	je     c99 <mvdir+0x5c9>
	if (s1.dev != s2.dev) {
     9de:	a1 24 21 00 00       	mov    0x2124,%eax
     9e3:	39 05 a4 21 00 00    	cmp    %eax,0x21a4
     9e9:	0f 85 77 02 00 00    	jne    c66 <mvdir+0x596>
	if (s1.ino != s2.ino) {
     9ef:	a1 28 21 00 00       	mov    0x2128,%eax
     9f4:	39 05 a8 21 00 00    	cmp    %eax,0x21a8
     9fa:	0f 84 10 03 00 00    	je     d10 <mvdir+0x640>
		if (chkdot(source) || chkdot(target)) {
     a00:	83 ec 0c             	sub    $0xc,%esp
     a03:	56                   	push   %esi
     a04:	e8 a7 fb ff ff       	call   5b0 <chkdot>
     a09:	83 c4 10             	add    $0x10,%esp
     a0c:	85 c0                	test   %eax,%eax
     a0e:	0f 85 69 02 00 00    	jne    c7d <mvdir+0x5ad>
     a14:	83 ec 0c             	sub    $0xc,%esp
     a17:	53                   	push   %ebx
     a18:	e8 93 fb ff ff       	call   5b0 <chkdot>
     a1d:	83 c4 10             	add    $0x10,%esp
     a20:	85 c0                	test   %eax,%eax
     a22:	0f 85 55 02 00 00    	jne    c7d <mvdir+0x5ad>
		stat(source, &s1);
     a28:	83 ec 08             	sub    $0x8,%esp
     a2b:	68 a0 21 00 00       	push   $0x21a0
     a30:	56                   	push   %esi
     a31:	e8 5a 05 00 00       	call   f90 <stat>
	while ((c = *p++ = *name++))
     a36:	0f be 03             	movsbl (%ebx),%eax
     a39:	ba 20 22 00 00       	mov    $0x2220,%edx
     a3e:	83 c4 10             	add    $0x10,%esp
		if (check(pname(target), s1.ino))
     a41:	8b 3d a8 21 00 00    	mov    0x21a8,%edi
	p = q = buf;
     a47:	89 d1                	mov    %edx,%ecx
	while ((c = *p++ = *name++))
     a49:	a2 20 22 00 00       	mov    %al,0x2220
     a4e:	85 c0                	test   %eax,%eax
     a50:	0f 84 3b 03 00 00    	je     d91 <mvdir+0x6c1>
     a56:	89 bd 10 ff ff ff    	mov    %edi,-0xf0(%ebp)
     a5c:	8b bd 14 ff ff ff    	mov    -0xec(%ebp),%edi
			q = p-1;
     a62:	83 f8 2f             	cmp    $0x2f,%eax
     a65:	0f 44 ca             	cmove  %edx,%ecx
	while ((c = *p++ = *name++))
     a68:	0f be 07             	movsbl (%edi),%eax
     a6b:	83 c7 01             	add    $0x1,%edi
     a6e:	83 c2 01             	add    $0x1,%edx
     a71:	88 02                	mov    %al,(%edx)
     a73:	85 c0                	test   %eax,%eax
     a75:	75 eb                	jne    a62 <mvdir+0x392>
	if (q == buf && *q == DELIM)
     a77:	8b bd 10 ff ff ff    	mov    -0xf0(%ebp),%edi
     a7d:	81 f9 20 22 00 00    	cmp    $0x2220,%ecx
     a83:	0f 84 f6 02 00 00    	je     d7f <mvdir+0x6af>
	*q = 0;
     a89:	c6 01 00             	movb   $0x0,(%ecx)
	return buf[0]? buf : DOT;
     a8c:	ba 20 22 00 00       	mov    $0x2220,%edx
     a91:	b8 ed 19 00 00       	mov    $0x19ed,%eax
     a96:	80 3d 20 22 00 00 00 	cmpb   $0x0,0x2220
     a9d:	0f 45 c2             	cmovne %edx,%eax
		if (check(pname(target), s1.ino))
     aa0:	83 ec 08             	sub    $0x8,%esp
     aa3:	57                   	push   %edi
     aa4:	50                   	push   %eax
     aa5:	e8 b6 f9 ff ff       	call   460 <check>
     aaa:	83 c4 10             	add    $0x10,%esp
     aad:	85 c0                	test   %eax,%eax
     aaf:	0f 85 67 fc ff ff    	jne    71c <mvdir+0x4c>
		if (link(source, target) < 0) {
     ab5:	83 ec 08             	sub    $0x8,%esp
     ab8:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
     abe:	53                   	push   %ebx
     abf:	56                   	push   %esi
     ac0:	e8 ee 05 00 00       	call   10b3 <link>
     ac5:	83 c4 10             	add    $0x10,%esp
     ac8:	8b 95 14 ff ff ff    	mov    -0xec(%ebp),%edx
     ace:	85 c0                	test   %eax,%eax
     ad0:	0f 88 e3 02 00 00    	js     db9 <mvdir+0x6e9>
		if (unlink(source) < 0) {
     ad6:	83 ec 0c             	sub    $0xc,%esp
     ad9:	89 95 14 ff ff ff    	mov    %edx,-0xec(%ebp)
     adf:	56                   	push   %esi
     ae0:	e8 be 05 00 00       	call   10a3 <unlink>
     ae5:	83 c4 10             	add    $0x10,%esp
     ae8:	8b 95 14 ff ff ff    	mov    -0xec(%ebp),%edx
     aee:	85 c0                	test   %eax,%eax
     af0:	0f 88 a5 02 00 00    	js     d9b <mvdir+0x6cb>
		strcat(dst, target);
     af6:	8d bd 7f ff ff ff    	lea    -0x81(%ebp),%edi
     afc:	89 95 14 ff ff ff    	mov    %edx,-0xec(%ebp)
     b02:	50                   	push   %eax
     b03:	50                   	push   %eax
     b04:	53                   	push   %ebx
     b05:	57                   	push   %edi
     b06:	e8 d5 f5 ff ff       	call   e0 <strcat>
		strcat(dst, "/");
     b0b:	58                   	pop    %eax
     b0c:	5a                   	pop    %edx
     b0d:	68 ea 19 00 00       	push   $0x19ea
     b12:	57                   	push   %edi
     b13:	e8 c8 f5 ff ff       	call   e0 <strcat>
		strcat(dst, DOTDOT);
     b18:	59                   	pop    %ecx
     b19:	58                   	pop    %eax
     b1a:	68 ec 19 00 00       	push   $0x19ec
     b1f:	57                   	push   %edi
     b20:	e8 bb f5 ff ff       	call   e0 <strcat>
		if (unlink(dst) < 0) {
     b25:	89 3c 24             	mov    %edi,(%esp)
     b28:	e8 76 05 00 00       	call   10a3 <unlink>
     b2d:	83 c4 10             	add    $0x10,%esp
     b30:	8b 95 14 ff ff ff    	mov    -0xec(%ebp),%edx
     b36:	85 c0                	test   %eax,%eax
     b38:	0f 88 91 02 00 00    	js     dcf <mvdir+0x6ff>
		if (link(pname(target), dst) < 0) {
     b3e:	83 ec 0c             	sub    $0xc,%esp
     b41:	89 95 14 ff ff ff    	mov    %edx,-0xec(%ebp)
     b47:	53                   	push   %ebx
     b48:	e8 43 f8 ff ff       	call   390 <pname>
     b4d:	59                   	pop    %ecx
     b4e:	5a                   	pop    %edx
     b4f:	57                   	push   %edi
     b50:	50                   	push   %eax
     b51:	e8 5d 05 00 00       	call   10b3 <link>
     b56:	83 c4 10             	add    $0x10,%esp
     b59:	8b 95 14 ff ff ff    	mov    -0xec(%ebp),%edx
     b5f:	85 c0                	test   %eax,%eax
     b61:	0f 89 ba fb ff ff    	jns    721 <mvdir+0x51>
			fprintf(stderr, "mv: cannot link %s to %s\n",
     b67:	83 ec 0c             	sub    $0xc,%esp
     b6a:	53                   	push   %ebx
     b6b:	e8 20 f8 ff ff       	call   390 <pname>
     b70:	50                   	push   %eax
     b71:	57                   	push   %edi
     b72:	68 63 1a 00 00       	push   $0x1a63
     b77:	6a 02                	push   $0x2
     b79:	e8 32 0a 00 00       	call   15b0 <fprintf>
			if (link(pname(source), dst) >= 0)
     b7e:	83 c4 14             	add    $0x14,%esp
     b81:	56                   	push   %esi
     b82:	e8 09 f8 ff ff       	call   390 <pname>
     b87:	59                   	pop    %ecx
     b88:	5a                   	pop    %edx
     b89:	57                   	push   %edi
     b8a:	50                   	push   %eax
     b8b:	e8 23 05 00 00       	call   10b3 <link>
     b90:	83 c4 10             	add    $0x10,%esp
     b93:	85 c0                	test   %eax,%eax
     b95:	0f 88 81 fb ff ff    	js     71c <mvdir+0x4c>
				if (link(target, source) >= 0)
     b9b:	52                   	push   %edx
     b9c:	52                   	push   %edx
     b9d:	56                   	push   %esi
     b9e:	53                   	push   %ebx
     b9f:	e8 0f 05 00 00       	call   10b3 <link>
     ba4:	83 c4 10             	add    $0x10,%esp
     ba7:	85 c0                	test   %eax,%eax
     ba9:	0f 88 6d fb ff ff    	js     71c <mvdir+0x4c>
					unlink(target);
     baf:	83 ec 0c             	sub    $0xc,%esp
     bb2:	53                   	push   %ebx
     bb3:	e8 eb 04 00 00       	call   10a3 <unlink>
     bb8:	83 c4 10             	add    $0x10,%esp
     bbb:	e9 5c fb ff ff       	jmp    71c <mvdir+0x4c>
			fprintf(stderr, "mv: %s exists\n", buf);
     bc0:	83 ec 04             	sub    $0x4,%esp
     bc3:	57                   	push   %edi
     bc4:	68 ef 19 00 00       	push   $0x19ef
     bc9:	6a 02                	push   $0x2
     bcb:	e8 e0 09 00 00       	call   15b0 <fprintf>
			return(1);
     bd0:	83 c4 10             	add    $0x10,%esp
     bd3:	e9 44 fb ff ff       	jmp    71c <mvdir+0x4c>
     bd8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     bdf:	00 
			fprintf(stderr, "mv :target name too long\n");
     be0:	83 ec 08             	sub    $0x8,%esp
     be3:	68 fe 19 00 00       	push   $0x19fe
     be8:	6a 02                	push   $0x2
     bea:	e8 c1 09 00 00       	call   15b0 <fprintf>
			return(1);
     bef:	83 c4 10             	add    $0x10,%esp
     bf2:	e9 25 fb ff ff       	jmp    71c <mvdir+0x4c>
     bf7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     bfe:	00 
     bff:	90                   	nop
		fprintf(stderr, "mv: ?? source == target, source exists and target doesnt\n");
     c00:	83 ec 08             	sub    $0x8,%esp
     c03:	68 24 1b 00 00       	push   $0x1b24
     c08:	6a 02                	push   $0x2
     c0a:	e8 a1 09 00 00       	call   15b0 <fprintf>
		return(1);
     c0f:	83 c4 10             	add    $0x10,%esp
     c12:	e9 05 fb ff ff       	jmp    71c <mvdir+0x4c>
		fprintf(stderr, "mv: cannot locate parent\n");
     c17:	83 ec 08             	sub    $0x8,%esp
     c1a:	68 2e 1a 00 00       	push   $0x1a2e
     c1f:	6a 02                	push   $0x2
     c21:	e8 8a 09 00 00       	call   15b0 <fprintf>
		return(1);
     c26:	83 c4 10             	add    $0x10,%esp
     c29:	e9 ee fa ff ff       	jmp    71c <mvdir+0x4c>
	if (q == buf && *q == DELIM)
     c2e:	80 3d 20 22 00 00 2f 	cmpb   $0x2f,0x2220
		q++;
     c35:	bf 21 22 00 00       	mov    $0x2221,%edi
	if (q == buf && *q == DELIM)
     c3a:	0f 84 e1 fc ff ff    	je     921 <mvdir+0x251>
			q = p-1;
     c40:	bf 20 22 00 00       	mov    $0x2220,%edi
     c45:	e9 d7 fc ff ff       	jmp    921 <mvdir+0x251>
	if (q == buf && *q == DELIM)
     c4a:	80 3d 20 22 00 00 2f 	cmpb   $0x2f,0x2220
		q++;
     c51:	bf 21 22 00 00       	mov    $0x2221,%edi
	if (q == buf && *q == DELIM)
     c56:	0f 84 45 fd ff ff    	je     9a1 <mvdir+0x2d1>
			q = p-1;
     c5c:	bf 20 22 00 00       	mov    $0x2220,%edi
     c61:	e9 3b fd ff ff       	jmp    9a1 <mvdir+0x2d1>
		fprintf(stderr, "mv: cannot move directories across devices\n");
     c66:	83 ec 08             	sub    $0x8,%esp
     c69:	68 60 1b 00 00       	push   $0x1b60
     c6e:	6a 02                	push   $0x2
     c70:	e8 3b 09 00 00       	call   15b0 <fprintf>
		return(1);
     c75:	83 c4 10             	add    $0x10,%esp
     c78:	e9 9f fa ff ff       	jmp    71c <mvdir+0x4c>
			fprintf(stderr, "mv: Sorry, path names including %s aren't allowed\n", DOTDOT);
     c7d:	83 ec 04             	sub    $0x4,%esp
     c80:	68 ec 19 00 00       	push   $0x19ec
     c85:	68 8c 1b 00 00       	push   $0x1b8c
     c8a:	6a 02                	push   $0x2
     c8c:	e8 1f 09 00 00       	call   15b0 <fprintf>
			return(1);
     c91:	83 c4 10             	add    $0x10,%esp
     c94:	e9 83 fa ff ff       	jmp    71c <mvdir+0x4c>
	while ((c = *p++ = *name++))
     c99:	0f be 03             	movsbl (%ebx),%eax
     c9c:	ba 20 22 00 00       	mov    $0x2220,%edx
     ca1:	8b 9d 14 ff ff ff    	mov    -0xec(%ebp),%ebx
	p = q = buf;
     ca7:	89 d1                	mov    %edx,%ecx
	while ((c = *p++ = *name++))
     ca9:	a2 20 22 00 00       	mov    %al,0x2220
     cae:	85 c0                	test   %eax,%eax
     cb0:	0f 84 bf 00 00 00    	je     d75 <mvdir+0x6a5>
     cb6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     cbd:	00 
     cbe:	66 90                	xchg   %ax,%ax
			q = p-1;
     cc0:	83 f8 2f             	cmp    $0x2f,%eax
     cc3:	0f 44 ca             	cmove  %edx,%ecx
	while ((c = *p++ = *name++))
     cc6:	0f be 03             	movsbl (%ebx),%eax
     cc9:	83 c3 01             	add    $0x1,%ebx
     ccc:	83 c2 01             	add    $0x1,%edx
     ccf:	88 02                	mov    %al,(%edx)
     cd1:	85 c0                	test   %eax,%eax
     cd3:	75 eb                	jne    cc0 <mvdir+0x5f0>
	if (q == buf && *q == DELIM)
     cd5:	81 f9 20 22 00 00    	cmp    $0x2220,%ecx
     cdb:	0f 84 82 00 00 00    	je     d63 <mvdir+0x693>
	*q = 0;
     ce1:	c6 01 00             	movb   $0x0,(%ecx)
	return buf[0]? buf : DOT;
     ce4:	ba 20 22 00 00       	mov    $0x2220,%edx
     ce9:	b8 ed 19 00 00       	mov    $0x19ed,%eax
     cee:	80 3d 20 22 00 00 00 	cmpb   $0x0,0x2220
     cf5:	0f 45 c2             	cmovne %edx,%eax
		fprintf(stderr, "mv: no write access to %s\n", pname(target));
     cf8:	83 ec 04             	sub    $0x4,%esp
     cfb:	50                   	push   %eax
     cfc:	68 48 1a 00 00       	push   $0x1a48
     d01:	6a 02                	push   $0x2
     d03:	e8 a8 08 00 00       	call   15b0 <fprintf>
		return(1);
     d08:	83 c4 10             	add    $0x10,%esp
     d0b:	e9 0c fa ff ff       	jmp    71c <mvdir+0x4c>
	if (link(source, target) < 0) {
     d10:	83 ec 08             	sub    $0x8,%esp
     d13:	53                   	push   %ebx
     d14:	56                   	push   %esi
     d15:	e8 99 03 00 00       	call   10b3 <link>
     d1a:	83 c4 10             	add    $0x10,%esp
     d1d:	85 c0                	test   %eax,%eax
     d1f:	78 2c                	js     d4d <mvdir+0x67d>
	if (unlink(source) < 0) {
     d21:	83 ec 0c             	sub    $0xc,%esp
     d24:	56                   	push   %esi
     d25:	e8 79 03 00 00       	call   10a3 <unlink>
     d2a:	83 c4 10             	add    $0x10,%esp
	return(0);
     d2d:	31 d2                	xor    %edx,%edx
	if (unlink(source) < 0) {
     d2f:	85 c0                	test   %eax,%eax
     d31:	0f 89 ea f9 ff ff    	jns    721 <mvdir+0x51>
		fprintf(stderr, "mv: ?? cannot unlink %s\n", source);
     d37:	50                   	push   %eax
     d38:	56                   	push   %esi
     d39:	68 af 1a 00 00       	push   $0x1aaf
     d3e:	6a 02                	push   $0x2
     d40:	e8 6b 08 00 00       	call   15b0 <fprintf>
		return(1);
     d45:	83 c4 10             	add    $0x10,%esp
     d48:	e9 cf f9 ff ff       	jmp    71c <mvdir+0x4c>
		fprintf(stderr, "mv: cannot link %s and %s\n",
     d4d:	53                   	push   %ebx
     d4e:	56                   	push   %esi
     d4f:	68 94 1a 00 00       	push   $0x1a94
     d54:	6a 02                	push   $0x2
     d56:	e8 55 08 00 00       	call   15b0 <fprintf>
		return(1);
     d5b:	83 c4 10             	add    $0x10,%esp
     d5e:	e9 b9 f9 ff ff       	jmp    71c <mvdir+0x4c>
	if (q == buf && *q == DELIM)
     d63:	80 3d 20 22 00 00 2f 	cmpb   $0x2f,0x2220
		q++;
     d6a:	b9 21 22 00 00       	mov    $0x2221,%ecx
	if (q == buf && *q == DELIM)
     d6f:	0f 84 6c ff ff ff    	je     ce1 <mvdir+0x611>
			q = p-1;
     d75:	b9 20 22 00 00       	mov    $0x2220,%ecx
     d7a:	e9 62 ff ff ff       	jmp    ce1 <mvdir+0x611>
	if (q == buf && *q == DELIM)
     d7f:	80 3d 20 22 00 00 2f 	cmpb   $0x2f,0x2220
		q++;
     d86:	b9 21 22 00 00       	mov    $0x2221,%ecx
	if (q == buf && *q == DELIM)
     d8b:	0f 84 f8 fc ff ff    	je     a89 <mvdir+0x3b9>
			q = p-1;
     d91:	b9 20 22 00 00       	mov    $0x2220,%ecx
     d96:	e9 ee fc ff ff       	jmp    a89 <mvdir+0x3b9>
			fprintf(stderr, "mv: %s: cannot unlink\n", source);
     d9b:	50                   	push   %eax
     d9c:	56                   	push   %esi
     d9d:	68 7d 1a 00 00       	push   $0x1a7d
     da2:	6a 02                	push   $0x2
     da4:	e8 07 08 00 00       	call   15b0 <fprintf>
			unlink(target);
     da9:	89 1c 24             	mov    %ebx,(%esp)
     dac:	e8 f2 02 00 00       	call   10a3 <unlink>
			return(1);
     db1:	83 c4 10             	add    $0x10,%esp
     db4:	e9 63 f9 ff ff       	jmp    71c <mvdir+0x4c>
			fprintf(stderr, "mv: cannot link %s to %s\n", target, source);
     db9:	56                   	push   %esi
     dba:	53                   	push   %ebx
     dbb:	68 63 1a 00 00       	push   $0x1a63
     dc0:	6a 02                	push   $0x2
     dc2:	e8 e9 07 00 00       	call   15b0 <fprintf>
			return(1);
     dc7:	83 c4 10             	add    $0x10,%esp
     dca:	e9 4d f9 ff ff       	jmp    71c <mvdir+0x4c>
			fprintf(stderr, "mv: %s: cannot unlink\n", dst);
     dcf:	51                   	push   %ecx
     dd0:	57                   	push   %edi
     dd1:	68 7d 1a 00 00       	push   $0x1a7d
     dd6:	6a 02                	push   $0x2
     dd8:	e8 d3 07 00 00       	call   15b0 <fprintf>
			if (link(target, source) >= 0)
     ddd:	5f                   	pop    %edi
     dde:	58                   	pop    %eax
     ddf:	e9 b9 fd ff ff       	jmp    b9d <mvdir+0x4cd>
     de4:	66 90                	xchg   %ax,%ax
     de6:	66 90                	xchg   %ax,%ax
     de8:	66 90                	xchg   %ax,%ax
     dea:	66 90                	xchg   %ax,%ax
     dec:	66 90                	xchg   %ax,%ax
     dee:	66 90                	xchg   %ax,%ax
     df0:	66 90                	xchg   %ax,%ax
     df2:	66 90                	xchg   %ax,%ax
     df4:	66 90                	xchg   %ax,%ax
     df6:	66 90                	xchg   %ax,%ax
     df8:	66 90                	xchg   %ax,%ax
     dfa:	66 90                	xchg   %ax,%ax
     dfc:	66 90                	xchg   %ax,%ax
     dfe:	66 90                	xchg   %ax,%ax

00000e00 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     e00:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     e01:	31 c0                	xor    %eax,%eax
{
     e03:	89 e5                	mov    %esp,%ebp
     e05:	53                   	push   %ebx
     e06:	8b 4d 08             	mov    0x8(%ebp),%ecx
     e09:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
     e10:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     e14:	88 14 01             	mov    %dl,(%ecx,%eax,1)
     e17:	83 c0 01             	add    $0x1,%eax
     e1a:	84 d2                	test   %dl,%dl
     e1c:	75 f2                	jne    e10 <strcpy+0x10>
    ;
  return os;
}
     e1e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     e21:	89 c8                	mov    %ecx,%eax
     e23:	c9                   	leave
     e24:	c3                   	ret
     e25:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     e2c:	00 
     e2d:	8d 76 00             	lea    0x0(%esi),%esi

00000e30 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     e30:	55                   	push   %ebp
     e31:	89 e5                	mov    %esp,%ebp
     e33:	53                   	push   %ebx
     e34:	8b 55 08             	mov    0x8(%ebp),%edx
     e37:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     e3a:	0f b6 02             	movzbl (%edx),%eax
     e3d:	84 c0                	test   %al,%al
     e3f:	75 2f                	jne    e70 <strcmp+0x40>
     e41:	eb 4a                	jmp    e8d <strcmp+0x5d>
     e43:	eb 1b                	jmp    e60 <strcmp+0x30>
     e45:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     e4c:	00 
     e4d:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     e54:	00 
     e55:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     e5c:	00 
     e5d:	8d 76 00             	lea    0x0(%esi),%esi
     e60:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
     e64:	83 c2 01             	add    $0x1,%edx
     e67:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
     e6a:	84 c0                	test   %al,%al
     e6c:	74 12                	je     e80 <strcmp+0x50>
     e6e:	89 d9                	mov    %ebx,%ecx
     e70:	0f b6 19             	movzbl (%ecx),%ebx
     e73:	38 c3                	cmp    %al,%bl
     e75:	74 e9                	je     e60 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
     e77:	29 d8                	sub    %ebx,%eax
}
     e79:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     e7c:	c9                   	leave
     e7d:	c3                   	ret
     e7e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
     e80:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
     e84:	31 c0                	xor    %eax,%eax
     e86:	29 d8                	sub    %ebx,%eax
}
     e88:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     e8b:	c9                   	leave
     e8c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
     e8d:	0f b6 19             	movzbl (%ecx),%ebx
     e90:	31 c0                	xor    %eax,%eax
     e92:	eb e3                	jmp    e77 <strcmp+0x47>
     e94:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     e9b:	00 
     e9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ea0 <strlen>:

uint
strlen(char *s)
{
     ea0:	55                   	push   %ebp
     ea1:	89 e5                	mov    %esp,%ebp
     ea3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
     ea6:	80 3a 00             	cmpb   $0x0,(%edx)
     ea9:	74 15                	je     ec0 <strlen+0x20>
     eab:	31 c0                	xor    %eax,%eax
     ead:	8d 76 00             	lea    0x0(%esi),%esi
     eb0:	83 c0 01             	add    $0x1,%eax
     eb3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
     eb7:	89 c1                	mov    %eax,%ecx
     eb9:	75 f5                	jne    eb0 <strlen+0x10>
    ;
  return n;
}
     ebb:	89 c8                	mov    %ecx,%eax
     ebd:	5d                   	pop    %ebp
     ebe:	c3                   	ret
     ebf:	90                   	nop
  for(n = 0; s[n]; n++)
     ec0:	31 c9                	xor    %ecx,%ecx
}
     ec2:	5d                   	pop    %ebp
     ec3:	89 c8                	mov    %ecx,%eax
     ec5:	c3                   	ret
     ec6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     ecd:	00 
     ece:	66 90                	xchg   %ax,%ax

00000ed0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     ed0:	55                   	push   %ebp
     ed1:	89 e5                	mov    %esp,%ebp
     ed3:	57                   	push   %edi
     ed4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     ed7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     eda:	8b 45 0c             	mov    0xc(%ebp),%eax
     edd:	89 d7                	mov    %edx,%edi
     edf:	fc                   	cld
     ee0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     ee2:	8b 7d fc             	mov    -0x4(%ebp),%edi
     ee5:	89 d0                	mov    %edx,%eax
     ee7:	c9                   	leave
     ee8:	c3                   	ret
     ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000ef0 <strchr>:

char*
strchr(const char *s, char c)
{
     ef0:	55                   	push   %ebp
     ef1:	89 e5                	mov    %esp,%ebp
     ef3:	8b 45 08             	mov    0x8(%ebp),%eax
     ef6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     efa:	0f b6 10             	movzbl (%eax),%edx
     efd:	84 d2                	test   %dl,%dl
     eff:	75 1a                	jne    f1b <strchr+0x2b>
     f01:	eb 25                	jmp    f28 <strchr+0x38>
     f03:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     f0a:	00 
     f0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
     f10:	0f b6 50 01          	movzbl 0x1(%eax),%edx
     f14:	83 c0 01             	add    $0x1,%eax
     f17:	84 d2                	test   %dl,%dl
     f19:	74 0d                	je     f28 <strchr+0x38>
    if(*s == c)
     f1b:	38 d1                	cmp    %dl,%cl
     f1d:	75 f1                	jne    f10 <strchr+0x20>
      return (char*)s;
  return 0;
}
     f1f:	5d                   	pop    %ebp
     f20:	c3                   	ret
     f21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
     f28:	31 c0                	xor    %eax,%eax
}
     f2a:	5d                   	pop    %ebp
     f2b:	c3                   	ret
     f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000f30 <gets>:

char*
gets(char *buf, int max)
{
     f30:	55                   	push   %ebp
     f31:	89 e5                	mov    %esp,%ebp
     f33:	57                   	push   %edi
     f34:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
     f35:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
     f38:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
     f39:	31 db                	xor    %ebx,%ebx
{
     f3b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
     f3e:	eb 27                	jmp    f67 <gets+0x37>
    cc = read(0, &c, 1);
     f40:	83 ec 04             	sub    $0x4,%esp
     f43:	6a 01                	push   $0x1
     f45:	56                   	push   %esi
     f46:	6a 00                	push   $0x0
     f48:	e8 1e 01 00 00       	call   106b <read>
    if(cc < 1)
     f4d:	83 c4 10             	add    $0x10,%esp
     f50:	85 c0                	test   %eax,%eax
     f52:	7e 1d                	jle    f71 <gets+0x41>
      break;
    buf[i++] = c;
     f54:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     f58:	8b 55 08             	mov    0x8(%ebp),%edx
     f5b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
     f5f:	3c 0a                	cmp    $0xa,%al
     f61:	74 10                	je     f73 <gets+0x43>
     f63:	3c 0d                	cmp    $0xd,%al
     f65:	74 0c                	je     f73 <gets+0x43>
  for(i=0; i+1 < max; ){
     f67:	89 df                	mov    %ebx,%edi
     f69:	83 c3 01             	add    $0x1,%ebx
     f6c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     f6f:	7c cf                	jl     f40 <gets+0x10>
     f71:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
     f73:	8b 45 08             	mov    0x8(%ebp),%eax
     f76:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
     f7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f7d:	5b                   	pop    %ebx
     f7e:	5e                   	pop    %esi
     f7f:	5f                   	pop    %edi
     f80:	5d                   	pop    %ebp
     f81:	c3                   	ret
     f82:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     f89:	00 
     f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000f90 <stat>:

int
stat(char *n, struct stat *st)
{
     f90:	55                   	push   %ebp
     f91:	89 e5                	mov    %esp,%ebp
     f93:	56                   	push   %esi
     f94:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     f95:	83 ec 08             	sub    $0x8,%esp
     f98:	6a 00                	push   $0x0
     f9a:	ff 75 08             	push   0x8(%ebp)
     f9d:	e8 f1 00 00 00       	call   1093 <open>
  if(fd < 0)
     fa2:	83 c4 10             	add    $0x10,%esp
     fa5:	85 c0                	test   %eax,%eax
     fa7:	78 27                	js     fd0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     fa9:	83 ec 08             	sub    $0x8,%esp
     fac:	ff 75 0c             	push   0xc(%ebp)
     faf:	89 c3                	mov    %eax,%ebx
     fb1:	50                   	push   %eax
     fb2:	e8 f4 00 00 00       	call   10ab <fstat>
  close(fd);
     fb7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     fba:	89 c6                	mov    %eax,%esi
  close(fd);
     fbc:	e8 ba 00 00 00       	call   107b <close>
  return r;
     fc1:	83 c4 10             	add    $0x10,%esp
}
     fc4:	8d 65 f8             	lea    -0x8(%ebp),%esp
     fc7:	89 f0                	mov    %esi,%eax
     fc9:	5b                   	pop    %ebx
     fca:	5e                   	pop    %esi
     fcb:	5d                   	pop    %ebp
     fcc:	c3                   	ret
     fcd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     fd0:	be ff ff ff ff       	mov    $0xffffffff,%esi
     fd5:	eb ed                	jmp    fc4 <stat+0x34>
     fd7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     fde:	00 
     fdf:	90                   	nop

00000fe0 <atoi>:

int
atoi(const char *s)
{
     fe0:	55                   	push   %ebp
     fe1:	89 e5                	mov    %esp,%ebp
     fe3:	53                   	push   %ebx
     fe4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     fe7:	0f be 02             	movsbl (%edx),%eax
     fea:	8d 48 d0             	lea    -0x30(%eax),%ecx
     fed:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
     ff0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
     ff5:	77 1e                	ja     1015 <atoi+0x35>
     ff7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     ffe:	00 
     fff:	90                   	nop
    n = n*10 + *s++ - '0';
    1000:	83 c2 01             	add    $0x1,%edx
    1003:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    1006:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    100a:	0f be 02             	movsbl (%edx),%eax
    100d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    1010:	80 fb 09             	cmp    $0x9,%bl
    1013:	76 eb                	jbe    1000 <atoi+0x20>
  return n;
}
    1015:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1018:	89 c8                	mov    %ecx,%eax
    101a:	c9                   	leave
    101b:	c3                   	ret
    101c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001020 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1020:	55                   	push   %ebp
    1021:	89 e5                	mov    %esp,%ebp
    1023:	57                   	push   %edi
    1024:	8b 45 10             	mov    0x10(%ebp),%eax
    1027:	8b 55 08             	mov    0x8(%ebp),%edx
    102a:	56                   	push   %esi
    102b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    102e:	85 c0                	test   %eax,%eax
    1030:	7e 13                	jle    1045 <memmove+0x25>
    1032:	01 d0                	add    %edx,%eax
  dst = vdst;
    1034:	89 d7                	mov    %edx,%edi
    1036:	66 90                	xchg   %ax,%ax
    1038:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    103f:	00 
    *dst++ = *src++;
    1040:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    1041:	39 f8                	cmp    %edi,%eax
    1043:	75 fb                	jne    1040 <memmove+0x20>
  return vdst;
}
    1045:	5e                   	pop    %esi
    1046:	89 d0                	mov    %edx,%eax
    1048:	5f                   	pop    %edi
    1049:	5d                   	pop    %ebp
    104a:	c3                   	ret

0000104b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    104b:	b8 01 00 00 00       	mov    $0x1,%eax
    1050:	cd 40                	int    $0x40
    1052:	c3                   	ret

00001053 <exit>:
SYSCALL(exit)
    1053:	b8 02 00 00 00       	mov    $0x2,%eax
    1058:	cd 40                	int    $0x40
    105a:	c3                   	ret

0000105b <wait>:
SYSCALL(wait)
    105b:	b8 03 00 00 00       	mov    $0x3,%eax
    1060:	cd 40                	int    $0x40
    1062:	c3                   	ret

00001063 <pipe>:
SYSCALL(pipe)
    1063:	b8 04 00 00 00       	mov    $0x4,%eax
    1068:	cd 40                	int    $0x40
    106a:	c3                   	ret

0000106b <read>:
SYSCALL(read)
    106b:	b8 05 00 00 00       	mov    $0x5,%eax
    1070:	cd 40                	int    $0x40
    1072:	c3                   	ret

00001073 <write>:
SYSCALL(write)
    1073:	b8 10 00 00 00       	mov    $0x10,%eax
    1078:	cd 40                	int    $0x40
    107a:	c3                   	ret

0000107b <close>:
SYSCALL(close)
    107b:	b8 15 00 00 00       	mov    $0x15,%eax
    1080:	cd 40                	int    $0x40
    1082:	c3                   	ret

00001083 <kill>:
SYSCALL(kill)
    1083:	b8 06 00 00 00       	mov    $0x6,%eax
    1088:	cd 40                	int    $0x40
    108a:	c3                   	ret

0000108b <exec>:
SYSCALL(exec)
    108b:	b8 07 00 00 00       	mov    $0x7,%eax
    1090:	cd 40                	int    $0x40
    1092:	c3                   	ret

00001093 <open>:
SYSCALL(open)
    1093:	b8 0f 00 00 00       	mov    $0xf,%eax
    1098:	cd 40                	int    $0x40
    109a:	c3                   	ret

0000109b <mknod>:
SYSCALL(mknod)
    109b:	b8 11 00 00 00       	mov    $0x11,%eax
    10a0:	cd 40                	int    $0x40
    10a2:	c3                   	ret

000010a3 <unlink>:
SYSCALL(unlink)
    10a3:	b8 12 00 00 00       	mov    $0x12,%eax
    10a8:	cd 40                	int    $0x40
    10aa:	c3                   	ret

000010ab <fstat>:
SYSCALL(fstat)
    10ab:	b8 08 00 00 00       	mov    $0x8,%eax
    10b0:	cd 40                	int    $0x40
    10b2:	c3                   	ret

000010b3 <link>:
SYSCALL(link)
    10b3:	b8 13 00 00 00       	mov    $0x13,%eax
    10b8:	cd 40                	int    $0x40
    10ba:	c3                   	ret

000010bb <mkdir>:
SYSCALL(mkdir)
    10bb:	b8 14 00 00 00       	mov    $0x14,%eax
    10c0:	cd 40                	int    $0x40
    10c2:	c3                   	ret

000010c3 <chdir>:
SYSCALL(chdir)
    10c3:	b8 09 00 00 00       	mov    $0x9,%eax
    10c8:	cd 40                	int    $0x40
    10ca:	c3                   	ret

000010cb <dup>:
SYSCALL(dup)
    10cb:	b8 0a 00 00 00       	mov    $0xa,%eax
    10d0:	cd 40                	int    $0x40
    10d2:	c3                   	ret

000010d3 <getpid>:
SYSCALL(getpid)
    10d3:	b8 0b 00 00 00       	mov    $0xb,%eax
    10d8:	cd 40                	int    $0x40
    10da:	c3                   	ret

000010db <sbrk>:
SYSCALL(sbrk)
    10db:	b8 0c 00 00 00       	mov    $0xc,%eax
    10e0:	cd 40                	int    $0x40
    10e2:	c3                   	ret

000010e3 <sleep>:
SYSCALL(sleep)
    10e3:	b8 0d 00 00 00       	mov    $0xd,%eax
    10e8:	cd 40                	int    $0x40
    10ea:	c3                   	ret

000010eb <uptime>:
SYSCALL(uptime)
    10eb:	b8 0e 00 00 00       	mov    $0xe,%eax
    10f0:	cd 40                	int    $0x40
    10f2:	c3                   	ret

000010f3 <bstat>:
SYSCALL(bstat)
    10f3:	b8 16 00 00 00       	mov    $0x16,%eax
    10f8:	cd 40                	int    $0x40
    10fa:	c3                   	ret

000010fb <swap>:
SYSCALL(swap)
    10fb:	b8 17 00 00 00       	mov    $0x17,%eax
    1100:	cd 40                	int    $0x40
    1102:	c3                   	ret

00001103 <gettime>:
SYSCALL(gettime)
    1103:	b8 18 00 00 00       	mov    $0x18,%eax
    1108:	cd 40                	int    $0x40
    110a:	c3                   	ret

0000110b <setcursor>:
SYSCALL(setcursor)
    110b:	b8 19 00 00 00       	mov    $0x19,%eax
    1110:	cd 40                	int    $0x40
    1112:	c3                   	ret

00001113 <uname>:
SYSCALL(uname)
    1113:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1118:	cd 40                	int    $0x40
    111a:	c3                   	ret

0000111b <echo>:
SYSCALL(echo)
    111b:	b8 1b 00 00 00       	mov    $0x1b,%eax
    1120:	cd 40                	int    $0x40
    1122:	c3                   	ret
    1123:	66 90                	xchg   %ax,%ax
    1125:	66 90                	xchg   %ax,%ax
    1127:	66 90                	xchg   %ax,%ax
    1129:	66 90                	xchg   %ax,%ax
    112b:	66 90                	xchg   %ax,%ax
    112d:	66 90                	xchg   %ax,%ax
    112f:	66 90                	xchg   %ax,%ax
    1131:	66 90                	xchg   %ax,%ax
    1133:	66 90                	xchg   %ax,%ax
    1135:	66 90                	xchg   %ax,%ax
    1137:	66 90                	xchg   %ax,%ax
    1139:	66 90                	xchg   %ax,%ax
    113b:	66 90                	xchg   %ax,%ax
    113d:	66 90                	xchg   %ax,%ax
    113f:	90                   	nop

00001140 <printint.constprop.0>:
{
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn, int width, char pad_char)
    1140:	55                   	push   %ebp
    1141:	89 e5                	mov    %esp,%ebp
    1143:	57                   	push   %edi
    1144:	56                   	push   %esi
    1145:	89 c6                	mov    %eax,%esi
    1147:	53                   	push   %ebx
    1148:	89 d3                	mov    %edx,%ebx
    114a:	83 ec 3c             	sub    $0x3c,%esp
    114d:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1151:	85 f6                	test   %esi,%esi
    1153:	0f 89 d7 00 00 00    	jns    1230 <printint.constprop.0+0xf0>
    1159:	83 e1 01             	and    $0x1,%ecx
    115c:	0f 84 ce 00 00 00    	je     1230 <printint.constprop.0+0xf0>
    neg = 1;
    1162:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
    1169:	f7 de                	neg    %esi
    116b:	89 f1                	mov    %esi,%ecx
  } else {
    x = xx;
  }

  i = 0;
    116d:	88 45 bf             	mov    %al,-0x41(%ebp)
    1170:	31 ff                	xor    %edi,%edi
    1172:	8d 75 d7             	lea    -0x29(%ebp),%esi
    1175:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    117c:	00 
    117d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1180:	89 c8                	mov    %ecx,%eax
    1182:	31 d2                	xor    %edx,%edx
    1184:	89 7d c4             	mov    %edi,-0x3c(%ebp)
    1187:	83 c7 01             	add    $0x1,%edi
    118a:	f7 f3                	div    %ebx
    118c:	0f b6 92 a4 1c 00 00 	movzbl 0x1ca4(%edx),%edx
    1193:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
    1196:	89 ca                	mov    %ecx,%edx
    1198:	89 c1                	mov    %eax,%ecx
    119a:	39 da                	cmp    %ebx,%edx
    119c:	73 e2                	jae    1180 <printint.constprop.0+0x40>

  if(neg)
    119e:	8b 55 c0             	mov    -0x40(%ebp),%edx
    11a1:	0f b6 45 bf          	movzbl -0x41(%ebp),%eax
    11a5:	85 d2                	test   %edx,%edx
    11a7:	74 0b                	je     11b4 <printint.constprop.0+0x74>
    buf[i++] = '-';
    11a9:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
    11ac:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    11b1:	8d 79 02             	lea    0x2(%ecx),%edi

  // Pad with pad_char until we hit the required width
  while(i < width)
    11b4:	39 7d 08             	cmp    %edi,0x8(%ebp)
    11b7:	0f 8e 83 00 00 00    	jle    1240 <printint.constprop.0+0x100>
    11bd:	8b 55 08             	mov    0x8(%ebp),%edx
    11c0:	8d 5d d8             	lea    -0x28(%ebp),%ebx
    11c3:	01 df                	add    %ebx,%edi
    11c5:	01 da                	add    %ebx,%edx
    11c7:	89 d1                	mov    %edx,%ecx
    11c9:	29 f9                	sub    %edi,%ecx
    11cb:	83 e1 01             	and    $0x1,%ecx
    11ce:	74 10                	je     11e0 <printint.constprop.0+0xa0>
    buf[i++] = pad_char;
    11d0:	88 07                	mov    %al,(%edi)
  while(i < width)
    11d2:	83 c7 01             	add    $0x1,%edi
    11d5:	39 d7                	cmp    %edx,%edi
    11d7:	74 13                	je     11ec <printint.constprop.0+0xac>
    11d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = pad_char;
    11e0:	88 07                	mov    %al,(%edi)
  while(i < width)
    11e2:	83 c7 02             	add    $0x2,%edi
    buf[i++] = pad_char;
    11e5:	88 47 ff             	mov    %al,-0x1(%edi)
  while(i < width)
    11e8:	39 d7                	cmp    %edx,%edi
    11ea:	75 f4                	jne    11e0 <printint.constprop.0+0xa0>
    11ec:	8b 45 08             	mov    0x8(%ebp),%eax
    11ef:	8d 78 ff             	lea    -0x1(%eax),%edi

  while(--i >= 0)
    11f2:	01 df                	add    %ebx,%edi
    11f4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    11fb:	00 
    11fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
    1200:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
    1203:	83 ec 04             	sub    $0x4,%esp
    1206:	88 45 d7             	mov    %al,-0x29(%ebp)
    1209:	6a 01                	push   $0x1
    120b:	56                   	push   %esi
    120c:	6a 01                	push   $0x1
    120e:	e8 60 fe ff ff       	call   1073 <write>
  while(--i >= 0)
    1213:	89 f8                	mov    %edi,%eax
    1215:	83 c4 10             	add    $0x10,%esp
    1218:	83 ef 01             	sub    $0x1,%edi
    121b:	39 d8                	cmp    %ebx,%eax
    121d:	75 e1                	jne    1200 <printint.constprop.0+0xc0>
}
    121f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1222:	5b                   	pop    %ebx
    1223:	5e                   	pop    %esi
    1224:	5f                   	pop    %edi
    1225:	5d                   	pop    %ebp
    1226:	c3                   	ret
    1227:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    122e:	00 
    122f:	90                   	nop
  neg = 0;
    1230:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = xx;
    1237:	89 f1                	mov    %esi,%ecx
    1239:	e9 2f ff ff ff       	jmp    116d <printint.constprop.0+0x2d>
    123e:	66 90                	xchg   %ax,%ax
  while(--i >= 0)
    1240:	83 ef 01             	sub    $0x1,%edi
    1243:	8d 5d d8             	lea    -0x28(%ebp),%ebx
    1246:	eb aa                	jmp    11f2 <printint.constprop.0+0xb2>
    1248:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    124f:	00 

00001250 <strncpy>:
{
    1250:	55                   	push   %ebp
    1251:	31 c0                	xor    %eax,%eax
    1253:	89 e5                	mov    %esp,%ebp
    1255:	56                   	push   %esi
    1256:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1259:	8b 75 0c             	mov    0xc(%ebp),%esi
    125c:	53                   	push   %ebx
    125d:	8b 5d 10             	mov    0x10(%ebp),%ebx
  for (i = 0; i < n && src[i]; i++)
    1260:	85 db                	test   %ebx,%ebx
    1262:	7f 26                	jg     128a <strncpy+0x3a>
    1264:	eb 58                	jmp    12be <strncpy+0x6e>
    1266:	eb 18                	jmp    1280 <strncpy+0x30>
    1268:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    126f:	00 
    1270:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    1277:	00 
    1278:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    127f:	00 
    dest[i] = src[i];
    1280:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  for (i = 0; i < n && src[i]; i++)
    1283:	83 c0 01             	add    $0x1,%eax
    1286:	39 c3                	cmp    %eax,%ebx
    1288:	74 34                	je     12be <strncpy+0x6e>
    128a:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
    128e:	84 d2                	test   %dl,%dl
    1290:	75 ee                	jne    1280 <strncpy+0x30>
  for (; i < n; i++)
    1292:	39 c3                	cmp    %eax,%ebx
    1294:	7e 28                	jle    12be <strncpy+0x6e>
    1296:	01 c8                	add    %ecx,%eax
    1298:	01 d9                	add    %ebx,%ecx
    129a:	89 ca                	mov    %ecx,%edx
    129c:	29 c2                	sub    %eax,%edx
    129e:	83 e2 01             	and    $0x1,%edx
    12a1:	74 0d                	je     12b0 <strncpy+0x60>
    dest[i] = '\0';
    12a3:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
    12a6:	83 c0 01             	add    $0x1,%eax
    12a9:	39 c8                	cmp    %ecx,%eax
    12ab:	74 11                	je     12be <strncpy+0x6e>
    12ad:	8d 76 00             	lea    0x0(%esi),%esi
    dest[i] = '\0';
    12b0:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
    12b3:	83 c0 02             	add    $0x2,%eax
    dest[i] = '\0';
    12b6:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  for (; i < n; i++)
    12ba:	39 c8                	cmp    %ecx,%eax
    12bc:	75 f2                	jne    12b0 <strncpy+0x60>
}
    12be:	5b                   	pop    %ebx
    12bf:	5e                   	pop    %esi
    12c0:	5d                   	pop    %ebp
    12c1:	c3                   	ret
    12c2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    12c9:	00 
    12ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000012d0 <printf>:

void
printf(char *fmt, ...)
{
    12d0:	55                   	push   %ebp
    12d1:	89 e5                	mov    %esp,%ebp
    12d3:	57                   	push   %edi
    12d4:	56                   	push   %esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    12d5:	8d 75 0c             	lea    0xc(%ebp),%esi
{
    12d8:	53                   	push   %ebx
    12d9:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  for(i = 0; fmt[i]; i++){
    12dc:	8b 55 08             	mov    0x8(%ebp),%edx
  ap = (uint*)(void*)&fmt + 1;
    12df:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
    12e2:	0f b6 02             	movzbl (%edx),%eax
    12e5:	84 c0                	test   %al,%al
    12e7:	0f 84 88 00 00 00    	je     1375 <printf+0xa5>
    12ed:	8d 7a 01             	lea    0x1(%edx),%edi
    c = fmt[i] & 0xff;
    12f0:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
      if (c == '\f') {
    12f3:	83 fa 0c             	cmp    $0xc,%edx
    12f6:	0f 84 d4 01 00 00    	je     14d0 <printf+0x200>
        setcursor();
      } else if(c == '%'){
    12fc:	83 fa 25             	cmp    $0x25,%edx
    12ff:	0f 85 0b 02 00 00    	jne    1510 <printf+0x240>
  for(i = 0; fmt[i]; i++){
    1305:	0f b6 1f             	movzbl (%edi),%ebx
    1308:	83 c7 01             	add    $0x1,%edi
    130b:	84 db                	test   %bl,%bl
    130d:	74 66                	je     1375 <printf+0xa5>
    c = fmt[i] & 0xff;
    130f:	0f b6 c3             	movzbl %bl,%eax
    1312:	ba 20 00 00 00       	mov    $0x20,%edx
    1317:	31 c9                	xor    %ecx,%ecx
        pad_char = ' ';
      } else {
        putc(1, c);
      }
    } else if(state == '%'){
      if(c == '0'){
    1319:	83 f8 78             	cmp    $0x78,%eax
    131c:	7f 22                	jg     1340 <printf+0x70>
    131e:	83 f8 62             	cmp    $0x62,%eax
    1321:	0f 8e b9 01 00 00    	jle    14e0 <printf+0x210>
    1327:	83 e8 63             	sub    $0x63,%eax
    132a:	83 f8 15             	cmp    $0x15,%eax
    132d:	77 11                	ja     1340 <printf+0x70>
    132f:	ff 24 85 f4 1b 00 00 	jmp    *0x1bf4(,%eax,4)
    1336:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    133d:	00 
    133e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
    1340:	83 ec 04             	sub    $0x4,%esp
    1343:	8d 75 e7             	lea    -0x19(%ebp),%esi
    1346:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    134a:	6a 01                	push   $0x1
    134c:	56                   	push   %esi
    134d:	6a 01                	push   $0x1
    134f:	e8 1f fd ff ff       	call   1073 <write>
    1354:	83 c4 0c             	add    $0xc,%esp
    1357:	88 5d e7             	mov    %bl,-0x19(%ebp)
    135a:	6a 01                	push   $0x1
    135c:	56                   	push   %esi
    135d:	6a 01                	push   $0x1
    135f:	e8 0f fd ff ff       	call   1073 <write>
      } else if(c == '%'){
        putc(1, '%');
        state = 0;
      } else {
        putc(1, '%');
        putc(1, c);
    1364:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    1367:	0f b6 07             	movzbl (%edi),%eax
    136a:	83 c7 01             	add    $0x1,%edi
    136d:	84 c0                	test   %al,%al
    136f:	0f 85 7b ff ff ff    	jne    12f0 <printf+0x20>
        state = 0;
      }
    }
  }
}
    1375:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1378:	5b                   	pop    %ebx
    1379:	5e                   	pop    %esi
    137a:	5f                   	pop    %edi
    137b:	5d                   	pop    %ebp
    137c:	c3                   	ret
    137d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 16, 0, width, pad_char);
    1380:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    1383:	83 ec 08             	sub    $0x8,%esp
    1386:	8b 06                	mov    (%esi),%eax
    1388:	52                   	push   %edx
    1389:	ba 10 00 00 00       	mov    $0x10,%edx
    138e:	51                   	push   %ecx
    138f:	31 c9                	xor    %ecx,%ecx
        printint(1, *ap, 10, 1, width, pad_char);
    1391:	e8 aa fd ff ff       	call   1140 <printint.constprop.0>
        ap++;
    1396:	83 c6 04             	add    $0x4,%esi
    1399:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
    139c:	0f b6 07             	movzbl (%edi),%eax
    139f:	83 c7 01             	add    $0x1,%edi
    13a2:	83 c4 10             	add    $0x10,%esp
    13a5:	84 c0                	test   %al,%al
    13a7:	0f 85 43 ff ff ff    	jne    12f0 <printf+0x20>
}
    13ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
    13b0:	5b                   	pop    %ebx
    13b1:	5e                   	pop    %esi
    13b2:	5f                   	pop    %edi
    13b3:	5d                   	pop    %ebp
    13b4:	c3                   	ret
    13b5:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 10, 1, width, pad_char);
    13b8:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    13bb:	83 ec 08             	sub    $0x8,%esp
    13be:	8b 06                	mov    (%esi),%eax
    13c0:	52                   	push   %edx
    13c1:	ba 0a 00 00 00       	mov    $0xa,%edx
    13c6:	51                   	push   %ecx
    13c7:	b9 01 00 00 00       	mov    $0x1,%ecx
    13cc:	eb c3                	jmp    1391 <printf+0xc1>
    13ce:	66 90                	xchg   %ax,%ax
        s = (char*)*ap;
    13d0:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    13d3:	8b 06                	mov    (%esi),%eax
        ap++;
    13d5:	83 c6 04             	add    $0x4,%esi
    13d8:	89 75 d4             	mov    %esi,-0x2c(%ebp)
        if(s == 0)
    13db:	85 c0                	test   %eax,%eax
    13dd:	0f 85 9d 01 00 00    	jne    1580 <printf+0x2b0>
    13e3:	c6 45 d0 28          	movb   $0x28,-0x30(%ebp)
          s = "(null)";
    13e7:	b8 c8 1a 00 00       	mov    $0x1ac8,%eax
        int len = 0;
    13ec:	31 db                	xor    %ebx,%ebx
    13ee:	66 90                	xchg   %ax,%ax
        for (char *t = s; *t; t++) len++;
    13f0:	83 c3 01             	add    $0x1,%ebx
    13f3:	80 3c 18 00          	cmpb   $0x0,(%eax,%ebx,1)
    13f7:	75 f7                	jne    13f0 <printf+0x120>
        for (int j = len; j < width; j++)
    13f9:	39 cb                	cmp    %ecx,%ebx
    13fb:	0f 8d 9c 01 00 00    	jge    159d <printf+0x2cd>
    1401:	89 4d d0             	mov    %ecx,-0x30(%ebp)
    1404:	8d 75 e7             	lea    -0x19(%ebp),%esi
    1407:	89 45 c8             	mov    %eax,-0x38(%ebp)
    140a:	89 7d cc             	mov    %edi,-0x34(%ebp)
    140d:	89 df                	mov    %ebx,%edi
    140f:	89 d3                	mov    %edx,%ebx
    1411:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    1418:	00 
    1419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
    1420:	83 ec 04             	sub    $0x4,%esp
    1423:	88 5d e7             	mov    %bl,-0x19(%ebp)
        for (int j = len; j < width; j++)
    1426:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
    1429:	6a 01                	push   $0x1
    142b:	56                   	push   %esi
    142c:	6a 01                	push   $0x1
    142e:	e8 40 fc ff ff       	call   1073 <write>
        for (int j = len; j < width; j++)
    1433:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1436:	83 c4 10             	add    $0x10,%esp
    1439:	39 c7                	cmp    %eax,%edi
    143b:	7c e3                	jl     1420 <printf+0x150>
        while(*s != 0){
    143d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1440:	8b 7d cc             	mov    -0x34(%ebp),%edi
    1443:	0f b6 08             	movzbl (%eax),%ecx
    1446:	88 4d d0             	mov    %cl,-0x30(%ebp)
    1449:	84 c9                	test   %cl,%cl
    144b:	0f 84 16 ff ff ff    	je     1367 <printf+0x97>
    1451:	89 c3                	mov    %eax,%ebx
    1453:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
    1457:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    145e:	00 
    145f:	90                   	nop
  write(fd, &c, 1);
    1460:	83 ec 04             	sub    $0x4,%esp
    1463:	88 45 e7             	mov    %al,-0x19(%ebp)
          putc(1, *s++);
    1466:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
    1469:	6a 01                	push   $0x1
    146b:	56                   	push   %esi
    146c:	6a 01                	push   $0x1
    146e:	e8 00 fc ff ff       	call   1073 <write>
        while(*s != 0){
    1473:	0f b6 03             	movzbl (%ebx),%eax
    1476:	83 c4 10             	add    $0x10,%esp
    1479:	84 c0                	test   %al,%al
    147b:	75 e3                	jne    1460 <printf+0x190>
    147d:	e9 e5 fe ff ff       	jmp    1367 <printf+0x97>
    1482:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        char ch = *ap++;
    1488:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
    148b:	83 ec 04             	sub    $0x4,%esp
    148e:	8d 75 e7             	lea    -0x19(%ebp),%esi
  for(i = 0; fmt[i]; i++){
    1491:	83 c7 01             	add    $0x1,%edi
        char ch = *ap++;
    1494:	8d 58 04             	lea    0x4(%eax),%ebx
    1497:	8b 00                	mov    (%eax),%eax
    1499:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    149c:	6a 01                	push   $0x1
    149e:	56                   	push   %esi
    149f:	6a 01                	push   $0x1
    14a1:	e8 cd fb ff ff       	call   1073 <write>
  for(i = 0; fmt[i]; i++){
    14a6:	0f b6 47 ff          	movzbl -0x1(%edi),%eax
    14aa:	83 c4 10             	add    $0x10,%esp
    14ad:	84 c0                	test   %al,%al
    14af:	0f 84 c0 fe ff ff    	je     1375 <printf+0xa5>
    c = fmt[i] & 0xff;
    14b5:	0f b6 d0             	movzbl %al,%edx
        char ch = *ap++;
    14b8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      if (c == '\f') {
    14bb:	83 fa 0c             	cmp    $0xc,%edx
    14be:	0f 85 38 fe ff ff    	jne    12fc <printf+0x2c>
    14c4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    14cb:	00 
    14cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        setcursor();
    14d0:	e8 36 fc ff ff       	call   110b <setcursor>
    14d5:	e9 8d fe ff ff       	jmp    1367 <printf+0x97>
    14da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    14e0:	83 f8 30             	cmp    $0x30,%eax
    14e3:	74 7b                	je     1560 <printf+0x290>
    14e5:	7f 49                	jg     1530 <printf+0x260>
    14e7:	83 f8 25             	cmp    $0x25,%eax
    14ea:	0f 85 50 fe ff ff    	jne    1340 <printf+0x70>
  write(fd, &c, 1);
    14f0:	83 ec 04             	sub    $0x4,%esp
    14f3:	8d 75 e7             	lea    -0x19(%ebp),%esi
    14f6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    14fa:	6a 01                	push   $0x1
    14fc:	56                   	push   %esi
    14fd:	6a 01                	push   $0x1
    14ff:	e8 6f fb ff ff       	call   1073 <write>
        state = 0;
    1504:	83 c4 10             	add    $0x10,%esp
    1507:	e9 5b fe ff ff       	jmp    1367 <printf+0x97>
    150c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
    1510:	83 ec 04             	sub    $0x4,%esp
    1513:	8d 75 e7             	lea    -0x19(%ebp),%esi
    1516:	88 45 e7             	mov    %al,-0x19(%ebp)
    1519:	6a 01                	push   $0x1
    151b:	56                   	push   %esi
    151c:	6a 01                	push   $0x1
    151e:	e8 50 fb ff ff       	call   1073 <write>
  for(i = 0; fmt[i]; i++){
    1523:	e9 74 fe ff ff       	jmp    139c <printf+0xcc>
    1528:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    152f:	00 
    1530:	8d 70 cf             	lea    -0x31(%eax),%esi
    1533:	83 fe 08             	cmp    $0x8,%esi
    1536:	0f 87 04 fe ff ff    	ja     1340 <printf+0x70>
    153c:	0f b6 1f             	movzbl (%edi),%ebx
        width = width * 10 + (c - '0');
    153f:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
  for(i = 0; fmt[i]; i++){
    1542:	83 c7 01             	add    $0x1,%edi
        width = width * 10 + (c - '0');
    1545:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  for(i = 0; fmt[i]; i++){
    1549:	84 db                	test   %bl,%bl
    154b:	0f 84 24 fe ff ff    	je     1375 <printf+0xa5>
    c = fmt[i] & 0xff;
    1551:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1554:	e9 c0 fd ff ff       	jmp    1319 <printf+0x49>
    1559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
    1560:	0f b6 1f             	movzbl (%edi),%ebx
    1563:	83 c7 01             	add    $0x1,%edi
    1566:	84 db                	test   %bl,%bl
    1568:	0f 84 07 fe ff ff    	je     1375 <printf+0xa5>
    c = fmt[i] & 0xff;
    156e:	0f b6 c3             	movzbl %bl,%eax
    1571:	ba 30 00 00 00       	mov    $0x30,%edx
    1576:	e9 9e fd ff ff       	jmp    1319 <printf+0x49>
    157b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        for (char *t = s; *t; t++) len++;
    1580:	0f b6 18             	movzbl (%eax),%ebx
    1583:	88 5d d0             	mov    %bl,-0x30(%ebp)
    1586:	84 db                	test   %bl,%bl
    1588:	0f 85 5e fe ff ff    	jne    13ec <printf+0x11c>
        int len = 0;
    158e:	31 db                	xor    %ebx,%ebx
        for (int j = len; j < width; j++)
    1590:	85 c9                	test   %ecx,%ecx
    1592:	0f 8f 69 fe ff ff    	jg     1401 <printf+0x131>
    1598:	e9 ca fd ff ff       	jmp    1367 <printf+0x97>
    159d:	89 c2                	mov    %eax,%edx
    159f:	8d 75 e7             	lea    -0x19(%ebp),%esi
    15a2:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
    15a6:	89 d3                	mov    %edx,%ebx
    15a8:	e9 b3 fe ff ff       	jmp    1460 <printf+0x190>
    15ad:	8d 76 00             	lea    0x0(%esi),%esi

000015b0 <fprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
fprintf(int fd, char *fmt, ...)
{
    15b0:	55                   	push   %ebp
    15b1:	89 e5                	mov    %esp,%ebp
    15b3:	57                   	push   %edi
    15b4:	56                   	push   %esi
    15b5:	53                   	push   %ebx
    15b6:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    15b9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    15bc:	0f b6 13             	movzbl (%ebx),%edx
    15bf:	83 c3 01             	add    $0x1,%ebx
    15c2:	84 d2                	test   %dl,%dl
    15c4:	0f 84 81 00 00 00    	je     164b <fprintf+0x9b>
    15ca:	8d 75 10             	lea    0x10(%ebp),%esi
    15cd:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
    15d0:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if (c == '\f') { // Detect formfeed character
    15d3:	83 f8 0c             	cmp    $0xc,%eax
    15d6:	0f 84 04 01 00 00    	je     16e0 <fprintf+0x130>
        setcursor();
      } else
      if(c == '%'){
    15dc:	83 f8 25             	cmp    $0x25,%eax
    15df:	0f 85 5b 01 00 00    	jne    1740 <fprintf+0x190>
  for(i = 0; fmt[i]; i++){
    15e5:	0f b6 13             	movzbl (%ebx),%edx
    15e8:	84 d2                	test   %dl,%dl
    15ea:	74 5f                	je     164b <fprintf+0x9b>
    c = fmt[i] & 0xff;
    15ec:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
    15ef:	80 fa 25             	cmp    $0x25,%dl
    15f2:	0f 84 78 01 00 00    	je     1770 <fprintf+0x1c0>
    15f8:	83 e8 63             	sub    $0x63,%eax
    15fb:	83 f8 15             	cmp    $0x15,%eax
    15fe:	77 10                	ja     1610 <fprintf+0x60>
    1600:	ff 24 85 4c 1c 00 00 	jmp    *0x1c4c(,%eax,4)
    1607:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    160e:	00 
    160f:	90                   	nop
  write(fd, &c, 1);
    1610:	83 ec 04             	sub    $0x4,%esp
    1613:	8d 7d e7             	lea    -0x19(%ebp),%edi
    1616:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1619:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
    161d:	6a 01                	push   $0x1
    161f:	57                   	push   %edi
    1620:	ff 75 08             	push   0x8(%ebp)
    1623:	e8 4b fa ff ff       	call   1073 <write>
        putc(fd, c);
    1628:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
    162c:	83 c4 0c             	add    $0xc,%esp
    162f:	88 55 e7             	mov    %dl,-0x19(%ebp)
    1632:	6a 01                	push   $0x1
    1634:	57                   	push   %edi
    1635:	ff 75 08             	push   0x8(%ebp)
    1638:	e8 36 fa ff ff       	call   1073 <write>
  for(i = 0; fmt[i]; i++){
    163d:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
    1641:	83 c3 02             	add    $0x2,%ebx
    1644:	83 c4 10             	add    $0x10,%esp
    1647:	84 d2                	test   %dl,%dl
    1649:	75 85                	jne    15d0 <fprintf+0x20>
      }
      state = 0;
    }
  }
}
    164b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    164e:	5b                   	pop    %ebx
    164f:	5e                   	pop    %esi
    1650:	5f                   	pop    %edi
    1651:	5d                   	pop    %ebp
    1652:	c3                   	ret
    1653:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(1, *ap, 16, 0, width, pad_char);
    1658:	83 ec 08             	sub    $0x8,%esp
    165b:	8b 06                	mov    (%esi),%eax
    165d:	31 c9                	xor    %ecx,%ecx
    165f:	ba 10 00 00 00       	mov    $0x10,%edx
    1664:	6a 20                	push   $0x20
    1666:	6a 00                	push   $0x0
    1668:	e8 d3 fa ff ff       	call   1140 <printint.constprop.0>
        ap++;
    166d:	83 c6 04             	add    $0x4,%esi
  for(i = 0; fmt[i]; i++){
    1670:	eb cb                	jmp    163d <fprintf+0x8d>
    1672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s = (char*)*ap;
    1678:	8b 3e                	mov    (%esi),%edi
        ap++;
    167a:	83 c6 04             	add    $0x4,%esi
        if(s == 0)
    167d:	85 ff                	test   %edi,%edi
    167f:	0f 84 fb 00 00 00    	je     1780 <fprintf+0x1d0>
        while(*s != 0){
    1685:	0f b6 07             	movzbl (%edi),%eax
    1688:	84 c0                	test   %al,%al
    168a:	74 36                	je     16c2 <fprintf+0x112>
    168c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    168f:	8d 4d e7             	lea    -0x19(%ebp),%ecx
    1692:	8b 75 08             	mov    0x8(%ebp),%esi
    1695:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    1698:	89 fb                	mov    %edi,%ebx
    169a:	89 cf                	mov    %ecx,%edi
    169c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
    16a0:	83 ec 04             	sub    $0x4,%esp
    16a3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
    16a6:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
    16a9:	6a 01                	push   $0x1
    16ab:	57                   	push   %edi
    16ac:	56                   	push   %esi
    16ad:	e8 c1 f9 ff ff       	call   1073 <write>
        while(*s != 0){
    16b2:	0f b6 03             	movzbl (%ebx),%eax
    16b5:	83 c4 10             	add    $0x10,%esp
    16b8:	84 c0                	test   %al,%al
    16ba:	75 e4                	jne    16a0 <fprintf+0xf0>
    16bc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    16bf:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
    16c2:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
    16c6:	83 c3 02             	add    $0x2,%ebx
    16c9:	84 d2                	test   %dl,%dl
    16cb:	0f 84 7a ff ff ff    	je     164b <fprintf+0x9b>
    c = fmt[i] & 0xff;
    16d1:	0f b6 c2             	movzbl %dl,%eax
      if (c == '\f') { // Detect formfeed character
    16d4:	83 f8 0c             	cmp    $0xc,%eax
    16d7:	0f 85 ff fe ff ff    	jne    15dc <fprintf+0x2c>
    16dd:	8d 76 00             	lea    0x0(%esi),%esi
        setcursor();
    16e0:	e8 26 fa ff ff       	call   110b <setcursor>
  for(i = 0; fmt[i]; i++){
    16e5:	0f b6 13             	movzbl (%ebx),%edx
    16e8:	83 c3 01             	add    $0x1,%ebx
    16eb:	84 d2                	test   %dl,%dl
    16ed:	0f 85 dd fe ff ff    	jne    15d0 <fprintf+0x20>
    16f3:	e9 53 ff ff ff       	jmp    164b <fprintf+0x9b>
    16f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    16ff:	00 
        printint(1, *ap, 10, 1, width, pad_char);
    1700:	83 ec 08             	sub    $0x8,%esp
    1703:	8b 06                	mov    (%esi),%eax
    1705:	b9 01 00 00 00       	mov    $0x1,%ecx
    170a:	ba 0a 00 00 00       	mov    $0xa,%edx
    170f:	6a 20                	push   $0x20
    1711:	6a 00                	push   $0x0
    1713:	e9 50 ff ff ff       	jmp    1668 <fprintf+0xb8>
    1718:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    171f:	00 
        putc(fd, *ap);
    1720:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
    1722:	83 ec 04             	sub    $0x4,%esp
    1725:	8d 7d e7             	lea    -0x19(%ebp),%edi
        putc(fd, *ap);
    1728:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    172b:	6a 01                	push   $0x1
    172d:	57                   	push   %edi
    172e:	ff 75 08             	push   0x8(%ebp)
    1731:	e8 3d f9 ff ff       	call   1073 <write>
    1736:	e9 32 ff ff ff       	jmp    166d <fprintf+0xbd>
    173b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    1740:	83 ec 04             	sub    $0x4,%esp
    1743:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1746:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
    1749:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
    174c:	6a 01                	push   $0x1
    174e:	50                   	push   %eax
    174f:	ff 75 08             	push   0x8(%ebp)
    1752:	e8 1c f9 ff ff       	call   1073 <write>
  for(i = 0; fmt[i]; i++){
    1757:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    175b:	83 c4 10             	add    $0x10,%esp
    175e:	84 d2                	test   %dl,%dl
    1760:	0f 85 6a fe ff ff    	jne    15d0 <fprintf+0x20>
}
    1766:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1769:	5b                   	pop    %ebx
    176a:	5e                   	pop    %esi
    176b:	5f                   	pop    %edi
    176c:	5d                   	pop    %ebp
    176d:	c3                   	ret
    176e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
    1770:	83 ec 04             	sub    $0x4,%esp
    1773:	88 55 e7             	mov    %dl,-0x19(%ebp)
    1776:	8d 7d e7             	lea    -0x19(%ebp),%edi
    1779:	6a 01                	push   $0x1
    177b:	e9 b4 fe ff ff       	jmp    1634 <fprintf+0x84>
          s = "(null)";
    1780:	bf c8 1a 00 00       	mov    $0x1ac8,%edi
    1785:	b8 28 00 00 00       	mov    $0x28,%eax
    178a:	e9 fd fe ff ff       	jmp    168c <fprintf+0xdc>
    178f:	66 90                	xchg   %ax,%ax
    1791:	66 90                	xchg   %ax,%ax
    1793:	66 90                	xchg   %ax,%ax
    1795:	66 90                	xchg   %ax,%ax
    1797:	66 90                	xchg   %ax,%ax
    1799:	66 90                	xchg   %ax,%ax
    179b:	66 90                	xchg   %ax,%ax
    179d:	66 90                	xchg   %ax,%ax
    179f:	90                   	nop

000017a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    17a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    17a1:	a1 84 22 00 00       	mov    0x2284,%eax
{
    17a6:	89 e5                	mov    %esp,%ebp
    17a8:	57                   	push   %edi
    17a9:	56                   	push   %esi
    17aa:	53                   	push   %ebx
    17ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    17ae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    17b1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    17b8:	00 
    17b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    17c0:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    17c2:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    17c4:	39 ca                	cmp    %ecx,%edx
    17c6:	73 30                	jae    17f8 <free+0x58>
    17c8:	39 c1                	cmp    %eax,%ecx
    17ca:	72 04                	jb     17d0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    17cc:	39 c2                	cmp    %eax,%edx
    17ce:	72 f0                	jb     17c0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
    17d0:	8b 73 fc             	mov    -0x4(%ebx),%esi
    17d3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    17d6:	39 f8                	cmp    %edi,%eax
    17d8:	74 36                	je     1810 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    17da:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    17dd:	8b 42 04             	mov    0x4(%edx),%eax
    17e0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    17e3:	39 f1                	cmp    %esi,%ecx
    17e5:	74 40                	je     1827 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    17e7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
    17e9:	5b                   	pop    %ebx
  freep = p;
    17ea:	89 15 84 22 00 00    	mov    %edx,0x2284
}
    17f0:	5e                   	pop    %esi
    17f1:	5f                   	pop    %edi
    17f2:	5d                   	pop    %ebp
    17f3:	c3                   	ret
    17f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    17f8:	39 c2                	cmp    %eax,%edx
    17fa:	72 c4                	jb     17c0 <free+0x20>
    17fc:	39 c1                	cmp    %eax,%ecx
    17fe:	73 c0                	jae    17c0 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
    1800:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1803:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1806:	39 f8                	cmp    %edi,%eax
    1808:	75 d0                	jne    17da <free+0x3a>
    180a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
    1810:	03 70 04             	add    0x4(%eax),%esi
    1813:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1816:	8b 02                	mov    (%edx),%eax
    1818:	8b 00                	mov    (%eax),%eax
    181a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    181d:	8b 42 04             	mov    0x4(%edx),%eax
    1820:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    1823:	39 f1                	cmp    %esi,%ecx
    1825:	75 c0                	jne    17e7 <free+0x47>
    p->s.size += bp->s.size;
    1827:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    182a:	89 15 84 22 00 00    	mov    %edx,0x2284
    p->s.size += bp->s.size;
    1830:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    1833:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    1836:	89 0a                	mov    %ecx,(%edx)
}
    1838:	5b                   	pop    %ebx
    1839:	5e                   	pop    %esi
    183a:	5f                   	pop    %edi
    183b:	5d                   	pop    %ebp
    183c:	c3                   	ret
    183d:	8d 76 00             	lea    0x0(%esi),%esi

00001840 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1840:	55                   	push   %ebp
    1841:	89 e5                	mov    %esp,%ebp
    1843:	57                   	push   %edi
    1844:	56                   	push   %esi
    1845:	53                   	push   %ebx
    1846:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1849:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    184c:	8b 15 84 22 00 00    	mov    0x2284,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1852:	8d 78 07             	lea    0x7(%eax),%edi
    1855:	c1 ef 03             	shr    $0x3,%edi
    1858:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    185b:	85 d2                	test   %edx,%edx
    185d:	0f 84 8d 00 00 00    	je     18f0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1863:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1865:	8b 48 04             	mov    0x4(%eax),%ecx
    1868:	39 f9                	cmp    %edi,%ecx
    186a:	73 64                	jae    18d0 <malloc+0x90>
  if(nu < 4096)
    186c:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1871:	39 df                	cmp    %ebx,%edi
    1873:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    1876:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    187d:	eb 0a                	jmp    1889 <malloc+0x49>
    187f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1880:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1882:	8b 48 04             	mov    0x4(%eax),%ecx
    1885:	39 f9                	cmp    %edi,%ecx
    1887:	73 47                	jae    18d0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1889:	89 c2                	mov    %eax,%edx
    188b:	39 05 84 22 00 00    	cmp    %eax,0x2284
    1891:	75 ed                	jne    1880 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
    1893:	83 ec 0c             	sub    $0xc,%esp
    1896:	56                   	push   %esi
    1897:	e8 3f f8 ff ff       	call   10db <sbrk>
  if(p == (char*)-1)
    189c:	83 c4 10             	add    $0x10,%esp
    189f:	83 f8 ff             	cmp    $0xffffffff,%eax
    18a2:	74 1c                	je     18c0 <malloc+0x80>
  hp->s.size = nu;
    18a4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    18a7:	83 ec 0c             	sub    $0xc,%esp
    18aa:	83 c0 08             	add    $0x8,%eax
    18ad:	50                   	push   %eax
    18ae:	e8 ed fe ff ff       	call   17a0 <free>
  return freep;
    18b3:	8b 15 84 22 00 00    	mov    0x2284,%edx
      if((p = morecore(nunits)) == 0)
    18b9:	83 c4 10             	add    $0x10,%esp
    18bc:	85 d2                	test   %edx,%edx
    18be:	75 c0                	jne    1880 <malloc+0x40>
        return 0;
  }
}
    18c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    18c3:	31 c0                	xor    %eax,%eax
}
    18c5:	5b                   	pop    %ebx
    18c6:	5e                   	pop    %esi
    18c7:	5f                   	pop    %edi
    18c8:	5d                   	pop    %ebp
    18c9:	c3                   	ret
    18ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    18d0:	39 cf                	cmp    %ecx,%edi
    18d2:	74 4c                	je     1920 <malloc+0xe0>
        p->s.size -= nunits;
    18d4:	29 f9                	sub    %edi,%ecx
    18d6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    18d9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    18dc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    18df:	89 15 84 22 00 00    	mov    %edx,0x2284
}
    18e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    18e8:	83 c0 08             	add    $0x8,%eax
}
    18eb:	5b                   	pop    %ebx
    18ec:	5e                   	pop    %esi
    18ed:	5f                   	pop    %edi
    18ee:	5d                   	pop    %ebp
    18ef:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
    18f0:	c7 05 84 22 00 00 88 	movl   $0x2288,0x2284
    18f7:	22 00 00 
    base.s.size = 0;
    18fa:	b8 88 22 00 00       	mov    $0x2288,%eax
    base.s.ptr = freep = prevp = &base;
    18ff:	c7 05 88 22 00 00 88 	movl   $0x2288,0x2288
    1906:	22 00 00 
    base.s.size = 0;
    1909:	c7 05 8c 22 00 00 00 	movl   $0x0,0x228c
    1910:	00 00 00 
    if(p->s.size >= nunits){
    1913:	e9 54 ff ff ff       	jmp    186c <malloc+0x2c>
    1918:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    191f:	00 
        prevp->s.ptr = p->s.ptr;
    1920:	8b 08                	mov    (%eax),%ecx
    1922:	89 0a                	mov    %ecx,(%edx)
    1924:	eb b9                	jmp    18df <malloc+0x9f>
