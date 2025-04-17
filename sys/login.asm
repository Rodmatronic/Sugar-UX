
_login:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    return "???";

  return months[m - 1];
}

int main() {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	81 ec f4 03 00 00    	sub    $0x3f4,%esp
    char user[50], pass[50], line[MAX_LINE];
    int fd, match = 0;

    printf("login: ");
  17:	68 44 0f 00 00       	push   $0xf44
  1c:	e8 af 08 00 00       	call   8d0 <printf>
    gets(user, sizeof(user));  // Get username
  21:	8d 85 3c fc ff ff    	lea    -0x3c4(%ebp),%eax
  27:	59                   	pop    %ecx
  28:	5b                   	pop    %ebx
  29:	6a 32                	push   $0x32
  2b:	50                   	push   %eax
  2c:	e8 ff 04 00 00       	call   530 <gets>
    user[strlen(user)-1] = 0;  // Remove newline
  31:	8d 85 3c fc ff ff    	lea    -0x3c4(%ebp),%eax
  37:	89 04 24             	mov    %eax,(%esp)
  3a:	e8 61 04 00 00       	call   4a0 <strlen>
  3f:	c6 84 05 3b fc ff ff 	movb   $0x0,-0x3c5(%ebp,%eax,1)
  46:	00 

    printf("password: ");
  47:	c7 04 24 4c 0f 00 00 	movl   $0xf4c,(%esp)
  4e:	e8 7d 08 00 00       	call   8d0 <printf>
    echo(0);
  53:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  5a:	e8 bc 06 00 00       	call   71b <echo>
    gets(pass, sizeof(pass));  // Get Password
  5f:	8d 85 6e fc ff ff    	lea    -0x392(%ebp),%eax
  65:	5e                   	pop    %esi
  66:	5f                   	pop    %edi
  67:	6a 32                	push   $0x32
  69:	8d b5 bc fe ff ff    	lea    -0x144(%ebp),%esi
  6f:	50                   	push   %eax
  70:	e8 bb 04 00 00       	call   530 <gets>
    pass[strlen(pass)-1] = 0;  // Remove newline
  75:	8d 85 6e fc ff ff    	lea    -0x392(%ebp),%eax
  7b:	89 04 24             	mov    %eax,(%esp)
  7e:	e8 1d 04 00 00       	call   4a0 <strlen>
  83:	c6 84 05 6d fc ff ff 	movb   $0x0,-0x393(%ebp,%eax,1)
  8a:	00 
    echo(1); 
  8b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  92:	e8 84 06 00 00       	call   71b <echo>
    printf("\n");
  97:	c7 04 24 7e 0f 00 00 	movl   $0xf7e,(%esp)
  9e:	e8 2d 08 00 00       	call   8d0 <printf>
    // Open /etc/passwd
    if ((fd = open("/etc/passwd", 0)) < 0) {
  a3:	58                   	pop    %eax
  a4:	5a                   	pop    %edx
  a5:	6a 00                	push   $0x0
  a7:	68 57 0f 00 00       	push   $0xf57
  ac:	e8 e2 05 00 00       	call   693 <open>
  b1:	83 c4 10             	add    $0x10,%esp
  b4:	89 c3                	mov    %eax,%ebx
  b6:	85 c0                	test   %eax,%eax
  b8:	0f 88 4c 02 00 00    	js     30a <main+0x30a>
  be:	66 90                	xchg   %ax,%ax
        printf("Error: Cannot open passwd file\n");
        exit();
    }

    // Read file line-by-line
    while (read(fd, line, MAX_LINE) > 0) {
  c0:	83 ec 04             	sub    $0x4,%esp
  c3:	8d 85 a0 fc ff ff    	lea    -0x360(%ebp),%eax
  c9:	68 00 01 00 00       	push   $0x100
  ce:	50                   	push   %eax
  cf:	53                   	push   %ebx
  d0:	e8 96 05 00 00       	call   66b <read>
  d5:	83 c4 10             	add    $0x10,%esp
  d8:	85 c0                	test   %eax,%eax
  da:	0f 8e 0d 02 00 00    	jle    2ed <main+0x2ed>
  e0:	89 9d 10 fc ff ff    	mov    %ebx,-0x3f0(%ebp)
  e6:	8d 85 a0 fe ff ff    	lea    -0x160(%ebp),%eax
        char *p = line;
  ec:	8d 95 a0 fc ff ff    	lea    -0x360(%ebp),%edx
  f2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  f9:	00 
  fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        char *fields[7];

        // Split line into colon-separated fields
        for (int i = 0; i < 7; i++) {
            fields[i] = p;
            while (*p && *p != ':' && *p != '\n') p++;
 100:	0f b6 0a             	movzbl (%edx),%ecx
            fields[i] = p;
 103:	89 10                	mov    %edx,(%eax)
            while (*p && *p != ':' && *p != '\n') p++;
 105:	84 c9                	test   %cl,%cl
 107:	88 8d 14 fc ff ff    	mov    %cl,-0x3ec(%ebp)
 10d:	0f 95 c3             	setne  %bl
 110:	80 f9 3a             	cmp    $0x3a,%cl
 113:	89 df                	mov    %ebx,%edi
 115:	0f 95 c3             	setne  %bl
 118:	89 f9                	mov    %edi,%ecx
 11a:	84 d9                	test   %bl,%cl
 11c:	74 3f                	je     15d <main+0x15d>
 11e:	80 bd 14 fc ff ff 0a 	cmpb   $0xa,-0x3ec(%ebp)
 125:	74 36                	je     15d <main+0x15d>
 127:	89 c7                	mov    %eax,%edi
 129:	eb 1a                	jmp    145 <main+0x145>
 12b:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 132:	00 
 133:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 13a:	00 
 13b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 140:	80 f9 0a             	cmp    $0xa,%cl
 143:	74 16                	je     15b <main+0x15b>
 145:	0f b6 4a 01          	movzbl 0x1(%edx),%ecx
 149:	83 c2 01             	add    $0x1,%edx
 14c:	84 c9                	test   %cl,%cl
 14e:	0f 95 c0             	setne  %al
 151:	80 f9 3a             	cmp    $0x3a,%cl
 154:	0f 95 c3             	setne  %bl
 157:	84 d8                	test   %bl,%al
 159:	75 e5                	jne    140 <main+0x140>
 15b:	89 f8                	mov    %edi,%eax
        for (int i = 0; i < 7; i++) {
 15d:	83 c0 04             	add    $0x4,%eax
            *p++ = 0;  // Terminate field
 160:	c6 02 00             	movb   $0x0,(%edx)
 163:	8d 4a 01             	lea    0x1(%edx),%ecx
        for (int i = 0; i < 7; i++) {
 166:	39 c6                	cmp    %eax,%esi
 168:	74 06                	je     170 <main+0x170>
 16a:	89 ca                	mov    %ecx,%edx
 16c:	eb 92                	jmp    100 <main+0x100>
 16e:	66 90                	xchg   %ax,%ax
        }

        // Check username and password (fields 0 and 1)
        if (strcmp(fields[0], user) == 0 && strcmp(fields[1], pass) == 0) {
 170:	83 ec 08             	sub    $0x8,%esp
 173:	8d 85 3c fc ff ff    	lea    -0x3c4(%ebp),%eax
 179:	8b 9d 10 fc ff ff    	mov    -0x3f0(%ebp),%ebx
 17f:	50                   	push   %eax
 180:	ff b5 a0 fe ff ff    	push   -0x160(%ebp)
 186:	e8 a5 02 00 00       	call   430 <strcmp>
 18b:	83 c4 10             	add    $0x10,%esp
 18e:	85 c0                	test   %eax,%eax
 190:	0f 85 2a ff ff ff    	jne    c0 <main+0xc0>
 196:	83 ec 08             	sub    $0x8,%esp
 199:	8d 85 6e fc ff ff    	lea    -0x392(%ebp),%eax
 19f:	50                   	push   %eax
 1a0:	ff b5 a4 fe ff ff    	push   -0x15c(%ebp)
 1a6:	e8 85 02 00 00       	call   430 <strcmp>
 1ab:	83 c4 10             	add    $0x10,%esp
 1ae:	85 c0                	test   %eax,%eax
 1b0:	0f 85 0a ff ff ff    	jne    c0 <main+0xc0>
            match = 1;
            break;
        }
    }
    close(fd);
 1b6:	83 ec 0c             	sub    $0xc,%esp
 1b9:	53                   	push   %ebx
 1ba:	e8 bc 04 00 00       	call   67b <close>
    if (match) {
	// Print the date
	struct rtcdate r;
	if (gettime(&r) == 0) {
 1bf:	8d 85 24 fc ff ff    	lea    -0x3dc(%ebp),%eax
 1c5:	89 04 24             	mov    %eax,(%esp)
 1c8:	e8 36 05 00 00       	call   703 <gettime>
 1cd:	83 c4 10             	add    $0x10,%esp
 1d0:	85 c0                	test   %eax,%eax
 1d2:	75 6c                	jne    240 <main+0x240>
	  printf("%02s %02s %02d %02d:%02d:%02d\n",
 1d4:	8b 85 2c fc ff ff    	mov    -0x3d4(%ebp),%eax
 1da:	8b 95 24 fc ff ff    	mov    -0x3dc(%ebp),%edx
 1e0:	8b bd 28 fc ff ff    	mov    -0x3d8(%ebp),%edi
 1e6:	8b b5 30 fc ff ff    	mov    -0x3d0(%ebp),%esi
 1ec:	89 85 14 fc ff ff    	mov    %eax,-0x3ec(%ebp)
	         get_weekday(r.year, r.month, r.day),
	         monthname(r.month),
 1f2:	8b 85 34 fc ff ff    	mov    -0x3cc(%ebp),%eax
  if (m < 1 || m > 12)
 1f8:	8d 48 ff             	lea    -0x1(%eax),%ecx
 1fb:	83 f9 0b             	cmp    $0xb,%ecx
 1fe:	0f 87 3a 01 00 00    	ja     33e <main+0x33e>
  return months[m - 1];
 204:	8b 1c 8d 40 10 00 00 	mov    0x1040(,%ecx,4),%ebx
 20b:	89 95 10 fc ff ff    	mov    %edx,-0x3f0(%ebp)
	  printf("%02s %02s %02d %02d:%02d:%02d\n",
 211:	52                   	push   %edx
 212:	56                   	push   %esi
 213:	50                   	push   %eax
 214:	ff b5 38 fc ff ff    	push   -0x3c8(%ebp)
 21a:	e8 31 01 00 00       	call   350 <get_weekday>
 21f:	8b 95 10 fc ff ff    	mov    -0x3f0(%ebp),%edx
 225:	83 c4 0c             	add    $0xc,%esp
 228:	52                   	push   %edx
 229:	57                   	push   %edi
 22a:	ff b5 14 fc ff ff    	push   -0x3ec(%ebp)
 230:	56                   	push   %esi
 231:	53                   	push   %ebx
 232:	50                   	push   %eax
 233:	68 20 10 00 00       	push   $0x1020
 238:	e8 93 06 00 00       	call   8d0 <printf>
 23d:	83 c4 20             	add    $0x20,%esp
	         r.minute,
	         r.second);
	}
	// Banner
	struct utsname name;
	uname(&name);
 240:	83 ec 0c             	sub    $0xc,%esp
 243:	8d 85 a0 fe ff ff    	lea    -0x160(%ebp),%eax
 249:	8d 9d a0 fd ff ff    	lea    -0x260(%ebp),%ebx
 24f:	50                   	push   %eax
 250:	e8 be 04 00 00       	call   713 <uname>
	printf("%s %s (%s)\n", name.version, name.release, name.nodename);
 255:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
 25b:	50                   	push   %eax
 25c:	8d 85 22 ff ff ff    	lea    -0xde(%ebp),%eax
 262:	50                   	push   %eax
 263:	8d 85 63 ff ff ff    	lea    -0x9d(%ebp),%eax
 269:	50                   	push   %eax
 26a:	68 74 0f 00 00       	push   $0xf74
 26f:	e8 5c 06 00 00       	call   8d0 <printf>
        // Display MOTD if available
        int motd_fd = open("/etc/motd", 0);
 274:	83 c4 18             	add    $0x18,%esp
 277:	6a 00                	push   $0x0
 279:	68 80 0f 00 00       	push   $0xf80
 27e:	e8 10 04 00 00       	call   693 <open>
        if (motd_fd >= 0) {
 283:	83 c4 10             	add    $0x10,%esp
        int motd_fd = open("/etc/motd", 0);
 286:	89 c6                	mov    %eax,%esi
        if (motd_fd >= 0) {
 288:	85 c0                	test   %eax,%eax
 28a:	79 1d                	jns    2a9 <main+0x2a9>
 28c:	eb 49                	jmp    2d7 <main+0x2d7>
 28e:	66 90                	xchg   %ax,%ax
            char motd_buf[MAX_LINE];
            int bytes_read;
            while ((bytes_read = read(motd_fd, motd_buf, sizeof(motd_buf)-1)) > 0) {
                motd_buf[bytes_read] = 0;  // Null-terminate
                printf("%s", motd_buf);
 290:	83 ec 08             	sub    $0x8,%esp
                motd_buf[bytes_read] = 0;  // Null-terminate
 293:	c6 84 05 a0 fd ff ff 	movb   $0x0,-0x260(%ebp,%eax,1)
 29a:	00 
                printf("%s", motd_buf);
 29b:	53                   	push   %ebx
 29c:	68 8a 0f 00 00       	push   $0xf8a
 2a1:	e8 2a 06 00 00       	call   8d0 <printf>
 2a6:	83 c4 10             	add    $0x10,%esp
            while ((bytes_read = read(motd_fd, motd_buf, sizeof(motd_buf)-1)) > 0) {
 2a9:	83 ec 04             	sub    $0x4,%esp
 2ac:	68 ff 00 00 00       	push   $0xff
 2b1:	53                   	push   %ebx
 2b2:	56                   	push   %esi
 2b3:	e8 b3 03 00 00       	call   66b <read>
 2b8:	83 c4 10             	add    $0x10,%esp
 2bb:	85 c0                	test   %eax,%eax
 2bd:	7f d1                	jg     290 <main+0x290>
            }
            close(motd_fd);
 2bf:	83 ec 0c             	sub    $0xc,%esp
 2c2:	56                   	push   %esi
 2c3:	e8 b3 03 00 00       	call   67b <close>
            printf("\n");
 2c8:	c7 04 24 7e 0f 00 00 	movl   $0xf7e,(%esp)
 2cf:	e8 fc 05 00 00       	call   8d0 <printf>
 2d4:	83 c4 10             	add    $0x10,%esp
        }

        // Start shell
        int pid = fork();
 2d7:	e8 6f 03 00 00       	call   64b <fork>
 2dc:	89 c3                	mov    %eax,%ebx
        if (pid == 0) {
 2de:	85 c0                	test   %eax,%eax
 2e0:	74 3a                	je     31c <main+0x31c>
            exec("/bin/sh", argv);
            printf("login: exec sh failed\n");
            exit();
        }
        while (wait() != pid);  // Proper waiting
 2e2:	e8 74 03 00 00       	call   65b <wait>
 2e7:	39 d8                	cmp    %ebx,%eax
 2e9:	75 f7                	jne    2e2 <main+0x2e2>
 2eb:	eb 18                	jmp    305 <main+0x305>
    close(fd);
 2ed:	83 ec 0c             	sub    $0xc,%esp
 2f0:	53                   	push   %ebx
 2f1:	e8 85 03 00 00       	call   67b <close>

    } else {
        printf("Login incorrect\n");
 2f6:	c7 04 24 63 0f 00 00 	movl   $0xf63,(%esp)
 2fd:	e8 ce 05 00 00       	call   8d0 <printf>
 302:	83 c4 10             	add    $0x10,%esp
    }

    exit();
 305:	e8 49 03 00 00       	call   653 <exit>
        printf("Error: Cannot open passwd file\n");
 30a:	83 ec 0c             	sub    $0xc,%esp
 30d:	68 00 10 00 00       	push   $0x1000
 312:	e8 b9 05 00 00       	call   8d0 <printf>
        exit();
 317:	e8 37 03 00 00       	call   653 <exit>
            exec("/bin/sh", argv);
 31c:	50                   	push   %eax
 31d:	50                   	push   %eax
 31e:	68 b0 14 00 00       	push   $0x14b0
 323:	68 8d 0f 00 00       	push   $0xf8d
 328:	e8 5e 03 00 00       	call   68b <exec>
            printf("login: exec sh failed\n");
 32d:	c7 04 24 95 0f 00 00 	movl   $0xf95,(%esp)
 334:	e8 97 05 00 00       	call   8d0 <printf>
            exit();
 339:	e8 15 03 00 00       	call   653 <exit>
    return "???";
 33e:	bb 40 0f 00 00       	mov    $0xf40,%ebx
 343:	e9 c3 fe ff ff       	jmp    20b <main+0x20b>
 348:	66 90                	xchg   %ax,%ax
 34a:	66 90                	xchg   %ax,%ax
 34c:	66 90                	xchg   %ax,%ax
 34e:	66 90                	xchg   %ax,%ax

00000350 <get_weekday>:
char* get_weekday(int y, int m, int d) {
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	57                   	push   %edi
 354:	56                   	push   %esi
 355:	8b 75 0c             	mov    0xc(%ebp),%esi
 358:	53                   	push   %ebx
 359:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (m < 3) {
 35c:	83 fe 02             	cmp    $0x2,%esi
 35f:	7f 06                	jg     367 <get_weekday+0x17>
    m += 12;
 361:	83 c6 0c             	add    $0xc,%esi
    y -= 1;
 364:	83 eb 01             	sub    $0x1,%ebx
  int h = (d + 2*m + 3*(m+1)/5 + y + y/4 - y/100 + y/400) % 7;
 367:	8d 7c 76 03          	lea    0x3(%esi,%esi,2),%edi
 36b:	b8 67 66 66 66       	mov    $0x66666667,%eax
 370:	f7 ef                	imul   %edi
 372:	8b 45 10             	mov    0x10(%ebp),%eax
 375:	c1 ff 1f             	sar    $0x1f,%edi
 378:	8d 04 70             	lea    (%eax,%esi,2),%eax
 37b:	d1 fa                	sar    $1,%edx
 37d:	29 fa                	sub    %edi,%edx
 37f:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
 382:	8d 43 03             	lea    0x3(%ebx),%eax
 385:	01 d9                	add    %ebx,%ecx
 387:	85 db                	test   %ebx,%ebx
 389:	0f 49 c3             	cmovns %ebx,%eax
 38c:	c1 f8 02             	sar    $0x2,%eax
 38f:	01 c1                	add    %eax,%ecx
 391:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
 396:	f7 eb                	imul   %ebx
 398:	c1 fb 1f             	sar    $0x1f,%ebx
 39b:	89 d8                	mov    %ebx,%eax
 39d:	89 d6                	mov    %edx,%esi
 39f:	c1 fa 07             	sar    $0x7,%edx
 3a2:	c1 fe 05             	sar    $0x5,%esi
 3a5:	29 da                	sub    %ebx,%edx
}
 3a7:	5b                   	pop    %ebx
  int h = (d + 2*m + 3*(m+1)/5 + y + y/4 - y/100 + y/400) % 7;
 3a8:	29 f0                	sub    %esi,%eax
}
 3aa:	5e                   	pop    %esi
 3ab:	5f                   	pop    %edi
  int h = (d + 2*m + 3*(m+1)/5 + y + y/4 - y/100 + y/400) % 7;
 3ac:	01 c1                	add    %eax,%ecx
 3ae:	b8 93 24 49 92       	mov    $0x92492493,%eax
}
 3b3:	5d                   	pop    %ebp
  int h = (d + 2*m + 3*(m+1)/5 + y + y/4 - y/100 + y/400) % 7;
 3b4:	01 d1                	add    %edx,%ecx
 3b6:	f7 e9                	imul   %ecx
 3b8:	89 c8                	mov    %ecx,%eax
 3ba:	c1 f8 1f             	sar    $0x1f,%eax
 3bd:	01 ca                	add    %ecx,%edx
 3bf:	c1 fa 02             	sar    $0x2,%edx
 3c2:	29 c2                	sub    %eax,%edx
 3c4:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
 3cb:	29 d0                	sub    %edx,%eax
 3cd:	29 c1                	sub    %eax,%ecx
  return days[h];
 3cf:	8b 04 8d 70 10 00 00 	mov    0x1070(,%ecx,4),%eax
}
 3d6:	c3                   	ret
 3d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3de:	00 
 3df:	90                   	nop

000003e0 <monthname>:
char* monthname(int m) {
 3e0:	55                   	push   %ebp
 3e1:	ba 40 0f 00 00       	mov    $0xf40,%edx
 3e6:	89 e5                	mov    %esp,%ebp
  if (m < 1 || m > 12)
 3e8:	8b 45 08             	mov    0x8(%ebp),%eax
 3eb:	83 e8 01             	sub    $0x1,%eax
 3ee:	83 f8 0b             	cmp    $0xb,%eax
 3f1:	77 07                	ja     3fa <monthname+0x1a>
  return months[m - 1];
 3f3:	8b 14 85 40 10 00 00 	mov    0x1040(,%eax,4),%edx
}
 3fa:	89 d0                	mov    %edx,%eax
 3fc:	5d                   	pop    %ebp
 3fd:	c3                   	ret
 3fe:	66 90                	xchg   %ax,%ax

00000400 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 400:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 401:	31 c0                	xor    %eax,%eax
{
 403:	89 e5                	mov    %esp,%ebp
 405:	53                   	push   %ebx
 406:	8b 4d 08             	mov    0x8(%ebp),%ecx
 409:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 40c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 410:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 414:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 417:	83 c0 01             	add    $0x1,%eax
 41a:	84 d2                	test   %dl,%dl
 41c:	75 f2                	jne    410 <strcpy+0x10>
    ;
  return os;
}
 41e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 421:	89 c8                	mov    %ecx,%eax
 423:	c9                   	leave
 424:	c3                   	ret
 425:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 42c:	00 
 42d:	8d 76 00             	lea    0x0(%esi),%esi

00000430 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	53                   	push   %ebx
 434:	8b 55 08             	mov    0x8(%ebp),%edx
 437:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 43a:	0f b6 02             	movzbl (%edx),%eax
 43d:	84 c0                	test   %al,%al
 43f:	75 2f                	jne    470 <strcmp+0x40>
 441:	eb 4a                	jmp    48d <strcmp+0x5d>
 443:	eb 1b                	jmp    460 <strcmp+0x30>
 445:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 44c:	00 
 44d:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 454:	00 
 455:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 45c:	00 
 45d:	8d 76 00             	lea    0x0(%esi),%esi
 460:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 464:	83 c2 01             	add    $0x1,%edx
 467:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 46a:	84 c0                	test   %al,%al
 46c:	74 12                	je     480 <strcmp+0x50>
 46e:	89 d9                	mov    %ebx,%ecx
 470:	0f b6 19             	movzbl (%ecx),%ebx
 473:	38 c3                	cmp    %al,%bl
 475:	74 e9                	je     460 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 477:	29 d8                	sub    %ebx,%eax
}
 479:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 47c:	c9                   	leave
 47d:	c3                   	ret
 47e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 480:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 484:	31 c0                	xor    %eax,%eax
 486:	29 d8                	sub    %ebx,%eax
}
 488:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 48b:	c9                   	leave
 48c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 48d:	0f b6 19             	movzbl (%ecx),%ebx
 490:	31 c0                	xor    %eax,%eax
 492:	eb e3                	jmp    477 <strcmp+0x47>
 494:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 49b:	00 
 49c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004a0 <strlen>:

uint
strlen(char *s)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 4a6:	80 3a 00             	cmpb   $0x0,(%edx)
 4a9:	74 15                	je     4c0 <strlen+0x20>
 4ab:	31 c0                	xor    %eax,%eax
 4ad:	8d 76 00             	lea    0x0(%esi),%esi
 4b0:	83 c0 01             	add    $0x1,%eax
 4b3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 4b7:	89 c1                	mov    %eax,%ecx
 4b9:	75 f5                	jne    4b0 <strlen+0x10>
    ;
  return n;
}
 4bb:	89 c8                	mov    %ecx,%eax
 4bd:	5d                   	pop    %ebp
 4be:	c3                   	ret
 4bf:	90                   	nop
  for(n = 0; s[n]; n++)
 4c0:	31 c9                	xor    %ecx,%ecx
}
 4c2:	5d                   	pop    %ebp
 4c3:	89 c8                	mov    %ecx,%eax
 4c5:	c3                   	ret
 4c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4cd:	00 
 4ce:	66 90                	xchg   %ax,%ax

000004d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	57                   	push   %edi
 4d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 4d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 4da:	8b 45 0c             	mov    0xc(%ebp),%eax
 4dd:	89 d7                	mov    %edx,%edi
 4df:	fc                   	cld
 4e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 4e2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 4e5:	89 d0                	mov    %edx,%eax
 4e7:	c9                   	leave
 4e8:	c3                   	ret
 4e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004f0 <strchr>:

char*
strchr(const char *s, char c)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	8b 45 08             	mov    0x8(%ebp),%eax
 4f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 4fa:	0f b6 10             	movzbl (%eax),%edx
 4fd:	84 d2                	test   %dl,%dl
 4ff:	75 1a                	jne    51b <strchr+0x2b>
 501:	eb 25                	jmp    528 <strchr+0x38>
 503:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 50a:	00 
 50b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 510:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 514:	83 c0 01             	add    $0x1,%eax
 517:	84 d2                	test   %dl,%dl
 519:	74 0d                	je     528 <strchr+0x38>
    if(*s == c)
 51b:	38 d1                	cmp    %dl,%cl
 51d:	75 f1                	jne    510 <strchr+0x20>
      return (char*)s;
  return 0;
}
 51f:	5d                   	pop    %ebp
 520:	c3                   	ret
 521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 528:	31 c0                	xor    %eax,%eax
}
 52a:	5d                   	pop    %ebp
 52b:	c3                   	ret
 52c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000530 <gets>:

char*
gets(char *buf, int max)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	57                   	push   %edi
 534:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 535:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 538:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 539:	31 db                	xor    %ebx,%ebx
{
 53b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 53e:	eb 27                	jmp    567 <gets+0x37>
    cc = read(0, &c, 1);
 540:	83 ec 04             	sub    $0x4,%esp
 543:	6a 01                	push   $0x1
 545:	56                   	push   %esi
 546:	6a 00                	push   $0x0
 548:	e8 1e 01 00 00       	call   66b <read>
    if(cc < 1)
 54d:	83 c4 10             	add    $0x10,%esp
 550:	85 c0                	test   %eax,%eax
 552:	7e 1d                	jle    571 <gets+0x41>
      break;
    buf[i++] = c;
 554:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 558:	8b 55 08             	mov    0x8(%ebp),%edx
 55b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 55f:	3c 0a                	cmp    $0xa,%al
 561:	74 10                	je     573 <gets+0x43>
 563:	3c 0d                	cmp    $0xd,%al
 565:	74 0c                	je     573 <gets+0x43>
  for(i=0; i+1 < max; ){
 567:	89 df                	mov    %ebx,%edi
 569:	83 c3 01             	add    $0x1,%ebx
 56c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 56f:	7c cf                	jl     540 <gets+0x10>
 571:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 573:	8b 45 08             	mov    0x8(%ebp),%eax
 576:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 57a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 57d:	5b                   	pop    %ebx
 57e:	5e                   	pop    %esi
 57f:	5f                   	pop    %edi
 580:	5d                   	pop    %ebp
 581:	c3                   	ret
 582:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 589:	00 
 58a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000590 <stat>:

int
stat(char *n, struct stat *st)
{
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	56                   	push   %esi
 594:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 595:	83 ec 08             	sub    $0x8,%esp
 598:	6a 00                	push   $0x0
 59a:	ff 75 08             	push   0x8(%ebp)
 59d:	e8 f1 00 00 00       	call   693 <open>
  if(fd < 0)
 5a2:	83 c4 10             	add    $0x10,%esp
 5a5:	85 c0                	test   %eax,%eax
 5a7:	78 27                	js     5d0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 5a9:	83 ec 08             	sub    $0x8,%esp
 5ac:	ff 75 0c             	push   0xc(%ebp)
 5af:	89 c3                	mov    %eax,%ebx
 5b1:	50                   	push   %eax
 5b2:	e8 f4 00 00 00       	call   6ab <fstat>
  close(fd);
 5b7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 5ba:	89 c6                	mov    %eax,%esi
  close(fd);
 5bc:	e8 ba 00 00 00       	call   67b <close>
  return r;
 5c1:	83 c4 10             	add    $0x10,%esp
}
 5c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 5c7:	89 f0                	mov    %esi,%eax
 5c9:	5b                   	pop    %ebx
 5ca:	5e                   	pop    %esi
 5cb:	5d                   	pop    %ebp
 5cc:	c3                   	ret
 5cd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 5d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 5d5:	eb ed                	jmp    5c4 <stat+0x34>
 5d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5de:	00 
 5df:	90                   	nop

000005e0 <atoi>:

int
atoi(const char *s)
{
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	53                   	push   %ebx
 5e4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 5e7:	0f be 02             	movsbl (%edx),%eax
 5ea:	8d 48 d0             	lea    -0x30(%eax),%ecx
 5ed:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 5f0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 5f5:	77 1e                	ja     615 <atoi+0x35>
 5f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5fe:	00 
 5ff:	90                   	nop
    n = n*10 + *s++ - '0';
 600:	83 c2 01             	add    $0x1,%edx
 603:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 606:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 60a:	0f be 02             	movsbl (%edx),%eax
 60d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 610:	80 fb 09             	cmp    $0x9,%bl
 613:	76 eb                	jbe    600 <atoi+0x20>
  return n;
}
 615:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 618:	89 c8                	mov    %ecx,%eax
 61a:	c9                   	leave
 61b:	c3                   	ret
 61c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000620 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	57                   	push   %edi
 624:	8b 45 10             	mov    0x10(%ebp),%eax
 627:	8b 55 08             	mov    0x8(%ebp),%edx
 62a:	56                   	push   %esi
 62b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 62e:	85 c0                	test   %eax,%eax
 630:	7e 13                	jle    645 <memmove+0x25>
 632:	01 d0                	add    %edx,%eax
  dst = vdst;
 634:	89 d7                	mov    %edx,%edi
 636:	66 90                	xchg   %ax,%ax
 638:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 63f:	00 
    *dst++ = *src++;
 640:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 641:	39 f8                	cmp    %edi,%eax
 643:	75 fb                	jne    640 <memmove+0x20>
  return vdst;
}
 645:	5e                   	pop    %esi
 646:	89 d0                	mov    %edx,%eax
 648:	5f                   	pop    %edi
 649:	5d                   	pop    %ebp
 64a:	c3                   	ret

0000064b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 64b:	b8 01 00 00 00       	mov    $0x1,%eax
 650:	cd 40                	int    $0x40
 652:	c3                   	ret

00000653 <exit>:
SYSCALL(exit)
 653:	b8 02 00 00 00       	mov    $0x2,%eax
 658:	cd 40                	int    $0x40
 65a:	c3                   	ret

0000065b <wait>:
SYSCALL(wait)
 65b:	b8 03 00 00 00       	mov    $0x3,%eax
 660:	cd 40                	int    $0x40
 662:	c3                   	ret

00000663 <pipe>:
SYSCALL(pipe)
 663:	b8 04 00 00 00       	mov    $0x4,%eax
 668:	cd 40                	int    $0x40
 66a:	c3                   	ret

0000066b <read>:
SYSCALL(read)
 66b:	b8 05 00 00 00       	mov    $0x5,%eax
 670:	cd 40                	int    $0x40
 672:	c3                   	ret

00000673 <write>:
SYSCALL(write)
 673:	b8 10 00 00 00       	mov    $0x10,%eax
 678:	cd 40                	int    $0x40
 67a:	c3                   	ret

0000067b <close>:
SYSCALL(close)
 67b:	b8 15 00 00 00       	mov    $0x15,%eax
 680:	cd 40                	int    $0x40
 682:	c3                   	ret

00000683 <kill>:
SYSCALL(kill)
 683:	b8 06 00 00 00       	mov    $0x6,%eax
 688:	cd 40                	int    $0x40
 68a:	c3                   	ret

0000068b <exec>:
SYSCALL(exec)
 68b:	b8 07 00 00 00       	mov    $0x7,%eax
 690:	cd 40                	int    $0x40
 692:	c3                   	ret

00000693 <open>:
SYSCALL(open)
 693:	b8 0f 00 00 00       	mov    $0xf,%eax
 698:	cd 40                	int    $0x40
 69a:	c3                   	ret

0000069b <mknod>:
SYSCALL(mknod)
 69b:	b8 11 00 00 00       	mov    $0x11,%eax
 6a0:	cd 40                	int    $0x40
 6a2:	c3                   	ret

000006a3 <unlink>:
SYSCALL(unlink)
 6a3:	b8 12 00 00 00       	mov    $0x12,%eax
 6a8:	cd 40                	int    $0x40
 6aa:	c3                   	ret

000006ab <fstat>:
SYSCALL(fstat)
 6ab:	b8 08 00 00 00       	mov    $0x8,%eax
 6b0:	cd 40                	int    $0x40
 6b2:	c3                   	ret

000006b3 <link>:
SYSCALL(link)
 6b3:	b8 13 00 00 00       	mov    $0x13,%eax
 6b8:	cd 40                	int    $0x40
 6ba:	c3                   	ret

000006bb <mkdir>:
SYSCALL(mkdir)
 6bb:	b8 14 00 00 00       	mov    $0x14,%eax
 6c0:	cd 40                	int    $0x40
 6c2:	c3                   	ret

000006c3 <chdir>:
SYSCALL(chdir)
 6c3:	b8 09 00 00 00       	mov    $0x9,%eax
 6c8:	cd 40                	int    $0x40
 6ca:	c3                   	ret

000006cb <dup>:
SYSCALL(dup)
 6cb:	b8 0a 00 00 00       	mov    $0xa,%eax
 6d0:	cd 40                	int    $0x40
 6d2:	c3                   	ret

000006d3 <getpid>:
SYSCALL(getpid)
 6d3:	b8 0b 00 00 00       	mov    $0xb,%eax
 6d8:	cd 40                	int    $0x40
 6da:	c3                   	ret

000006db <sbrk>:
SYSCALL(sbrk)
 6db:	b8 0c 00 00 00       	mov    $0xc,%eax
 6e0:	cd 40                	int    $0x40
 6e2:	c3                   	ret

000006e3 <sleep>:
SYSCALL(sleep)
 6e3:	b8 0d 00 00 00       	mov    $0xd,%eax
 6e8:	cd 40                	int    $0x40
 6ea:	c3                   	ret

000006eb <uptime>:
SYSCALL(uptime)
 6eb:	b8 0e 00 00 00       	mov    $0xe,%eax
 6f0:	cd 40                	int    $0x40
 6f2:	c3                   	ret

000006f3 <bstat>:
SYSCALL(bstat)
 6f3:	b8 16 00 00 00       	mov    $0x16,%eax
 6f8:	cd 40                	int    $0x40
 6fa:	c3                   	ret

000006fb <swap>:
SYSCALL(swap)
 6fb:	b8 17 00 00 00       	mov    $0x17,%eax
 700:	cd 40                	int    $0x40
 702:	c3                   	ret

00000703 <gettime>:
SYSCALL(gettime)
 703:	b8 18 00 00 00       	mov    $0x18,%eax
 708:	cd 40                	int    $0x40
 70a:	c3                   	ret

0000070b <setcursor>:
SYSCALL(setcursor)
 70b:	b8 19 00 00 00       	mov    $0x19,%eax
 710:	cd 40                	int    $0x40
 712:	c3                   	ret

00000713 <uname>:
SYSCALL(uname)
 713:	b8 1a 00 00 00       	mov    $0x1a,%eax
 718:	cd 40                	int    $0x40
 71a:	c3                   	ret

0000071b <echo>:
SYSCALL(echo)
 71b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 720:	cd 40                	int    $0x40
 722:	c3                   	ret
 723:	66 90                	xchg   %ax,%ax
 725:	66 90                	xchg   %ax,%ax
 727:	66 90                	xchg   %ax,%ax
 729:	66 90                	xchg   %ax,%ax
 72b:	66 90                	xchg   %ax,%ax
 72d:	66 90                	xchg   %ax,%ax
 72f:	66 90                	xchg   %ax,%ax
 731:	66 90                	xchg   %ax,%ax
 733:	66 90                	xchg   %ax,%ax
 735:	66 90                	xchg   %ax,%ax
 737:	66 90                	xchg   %ax,%ax
 739:	66 90                	xchg   %ax,%ax
 73b:	66 90                	xchg   %ax,%ax
 73d:	66 90                	xchg   %ax,%ax
 73f:	90                   	nop

00000740 <printint.constprop.0>:
{
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn, int width, char pad_char)
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	57                   	push   %edi
 744:	56                   	push   %esi
 745:	89 c6                	mov    %eax,%esi
 747:	53                   	push   %ebx
 748:	89 d3                	mov    %edx,%ebx
 74a:	83 ec 3c             	sub    $0x3c,%esp
 74d:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 751:	85 f6                	test   %esi,%esi
 753:	0f 89 d7 00 00 00    	jns    830 <printint.constprop.0+0xf0>
 759:	83 e1 01             	and    $0x1,%ecx
 75c:	0f 84 ce 00 00 00    	je     830 <printint.constprop.0+0xf0>
    neg = 1;
 762:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
 769:	f7 de                	neg    %esi
 76b:	89 f1                	mov    %esi,%ecx
  } else {
    x = xx;
  }

  i = 0;
 76d:	88 45 bf             	mov    %al,-0x41(%ebp)
 770:	31 ff                	xor    %edi,%edi
 772:	8d 75 d7             	lea    -0x29(%ebp),%esi
 775:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 77c:	00 
 77d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 780:	89 c8                	mov    %ecx,%eax
 782:	31 d2                	xor    %edx,%edx
 784:	89 7d c4             	mov    %edi,-0x3c(%ebp)
 787:	83 c7 01             	add    $0x1,%edi
 78a:	f7 f3                	div    %ebx
 78c:	0f b6 92 3c 11 00 00 	movzbl 0x113c(%edx),%edx
 793:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
 796:	89 ca                	mov    %ecx,%edx
 798:	89 c1                	mov    %eax,%ecx
 79a:	39 da                	cmp    %ebx,%edx
 79c:	73 e2                	jae    780 <printint.constprop.0+0x40>

  if(neg)
 79e:	8b 55 c0             	mov    -0x40(%ebp),%edx
 7a1:	0f b6 45 bf          	movzbl -0x41(%ebp),%eax
 7a5:	85 d2                	test   %edx,%edx
 7a7:	74 0b                	je     7b4 <printint.constprop.0+0x74>
    buf[i++] = '-';
 7a9:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
 7ac:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 7b1:	8d 79 02             	lea    0x2(%ecx),%edi

  // Pad with pad_char until we hit the required width
  while(i < width)
 7b4:	39 7d 08             	cmp    %edi,0x8(%ebp)
 7b7:	0f 8e 83 00 00 00    	jle    840 <printint.constprop.0+0x100>
 7bd:	8b 55 08             	mov    0x8(%ebp),%edx
 7c0:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 7c3:	01 df                	add    %ebx,%edi
 7c5:	01 da                	add    %ebx,%edx
 7c7:	89 d1                	mov    %edx,%ecx
 7c9:	29 f9                	sub    %edi,%ecx
 7cb:	83 e1 01             	and    $0x1,%ecx
 7ce:	74 10                	je     7e0 <printint.constprop.0+0xa0>
    buf[i++] = pad_char;
 7d0:	88 07                	mov    %al,(%edi)
  while(i < width)
 7d2:	83 c7 01             	add    $0x1,%edi
 7d5:	39 d7                	cmp    %edx,%edi
 7d7:	74 13                	je     7ec <printint.constprop.0+0xac>
 7d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = pad_char;
 7e0:	88 07                	mov    %al,(%edi)
  while(i < width)
 7e2:	83 c7 02             	add    $0x2,%edi
    buf[i++] = pad_char;
 7e5:	88 47 ff             	mov    %al,-0x1(%edi)
  while(i < width)
 7e8:	39 d7                	cmp    %edx,%edi
 7ea:	75 f4                	jne    7e0 <printint.constprop.0+0xa0>
 7ec:	8b 45 08             	mov    0x8(%ebp),%eax
 7ef:	8d 78 ff             	lea    -0x1(%eax),%edi

  while(--i >= 0)
 7f2:	01 df                	add    %ebx,%edi
 7f4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7fb:	00 
 7fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 800:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 803:	83 ec 04             	sub    $0x4,%esp
 806:	88 45 d7             	mov    %al,-0x29(%ebp)
 809:	6a 01                	push   $0x1
 80b:	56                   	push   %esi
 80c:	6a 01                	push   $0x1
 80e:	e8 60 fe ff ff       	call   673 <write>
  while(--i >= 0)
 813:	89 f8                	mov    %edi,%eax
 815:	83 c4 10             	add    $0x10,%esp
 818:	83 ef 01             	sub    $0x1,%edi
 81b:	39 d8                	cmp    %ebx,%eax
 81d:	75 e1                	jne    800 <printint.constprop.0+0xc0>
}
 81f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 822:	5b                   	pop    %ebx
 823:	5e                   	pop    %esi
 824:	5f                   	pop    %edi
 825:	5d                   	pop    %ebp
 826:	c3                   	ret
 827:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 82e:	00 
 82f:	90                   	nop
  neg = 0;
 830:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = xx;
 837:	89 f1                	mov    %esi,%ecx
 839:	e9 2f ff ff ff       	jmp    76d <printint.constprop.0+0x2d>
 83e:	66 90                	xchg   %ax,%ax
  while(--i >= 0)
 840:	83 ef 01             	sub    $0x1,%edi
 843:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 846:	eb aa                	jmp    7f2 <printint.constprop.0+0xb2>
 848:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 84f:	00 

00000850 <strncpy>:
{
 850:	55                   	push   %ebp
 851:	31 c0                	xor    %eax,%eax
 853:	89 e5                	mov    %esp,%ebp
 855:	56                   	push   %esi
 856:	8b 4d 08             	mov    0x8(%ebp),%ecx
 859:	8b 75 0c             	mov    0xc(%ebp),%esi
 85c:	53                   	push   %ebx
 85d:	8b 5d 10             	mov    0x10(%ebp),%ebx
  for (i = 0; i < n && src[i]; i++)
 860:	85 db                	test   %ebx,%ebx
 862:	7f 26                	jg     88a <strncpy+0x3a>
 864:	eb 58                	jmp    8be <strncpy+0x6e>
 866:	eb 18                	jmp    880 <strncpy+0x30>
 868:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 86f:	00 
 870:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 877:	00 
 878:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 87f:	00 
    dest[i] = src[i];
 880:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  for (i = 0; i < n && src[i]; i++)
 883:	83 c0 01             	add    $0x1,%eax
 886:	39 c3                	cmp    %eax,%ebx
 888:	74 34                	je     8be <strncpy+0x6e>
 88a:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
 88e:	84 d2                	test   %dl,%dl
 890:	75 ee                	jne    880 <strncpy+0x30>
  for (; i < n; i++)
 892:	39 c3                	cmp    %eax,%ebx
 894:	7e 28                	jle    8be <strncpy+0x6e>
 896:	01 c8                	add    %ecx,%eax
 898:	01 d9                	add    %ebx,%ecx
 89a:	89 ca                	mov    %ecx,%edx
 89c:	29 c2                	sub    %eax,%edx
 89e:	83 e2 01             	and    $0x1,%edx
 8a1:	74 0d                	je     8b0 <strncpy+0x60>
    dest[i] = '\0';
 8a3:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
 8a6:	83 c0 01             	add    $0x1,%eax
 8a9:	39 c8                	cmp    %ecx,%eax
 8ab:	74 11                	je     8be <strncpy+0x6e>
 8ad:	8d 76 00             	lea    0x0(%esi),%esi
    dest[i] = '\0';
 8b0:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
 8b3:	83 c0 02             	add    $0x2,%eax
    dest[i] = '\0';
 8b6:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  for (; i < n; i++)
 8ba:	39 c8                	cmp    %ecx,%eax
 8bc:	75 f2                	jne    8b0 <strncpy+0x60>
}
 8be:	5b                   	pop    %ebx
 8bf:	5e                   	pop    %esi
 8c0:	5d                   	pop    %ebp
 8c1:	c3                   	ret
 8c2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8c9:	00 
 8ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000008d0 <printf>:

void
printf(char *fmt, ...)
{
 8d0:	55                   	push   %ebp
 8d1:	89 e5                	mov    %esp,%ebp
 8d3:	57                   	push   %edi
 8d4:	56                   	push   %esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 8d5:	8d 75 0c             	lea    0xc(%ebp),%esi
{
 8d8:	53                   	push   %ebx
 8d9:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  for(i = 0; fmt[i]; i++){
 8dc:	8b 55 08             	mov    0x8(%ebp),%edx
  ap = (uint*)(void*)&fmt + 1;
 8df:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 8e2:	0f b6 02             	movzbl (%edx),%eax
 8e5:	84 c0                	test   %al,%al
 8e7:	0f 84 88 00 00 00    	je     975 <printf+0xa5>
 8ed:	8d 7a 01             	lea    0x1(%edx),%edi
    c = fmt[i] & 0xff;
 8f0:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
      if (c == '\f') {
 8f3:	83 fa 0c             	cmp    $0xc,%edx
 8f6:	0f 84 d4 01 00 00    	je     ad0 <printf+0x200>
        setcursor();
      } else if(c == '%'){
 8fc:	83 fa 25             	cmp    $0x25,%edx
 8ff:	0f 85 0b 02 00 00    	jne    b10 <printf+0x240>
  for(i = 0; fmt[i]; i++){
 905:	0f b6 1f             	movzbl (%edi),%ebx
 908:	83 c7 01             	add    $0x1,%edi
 90b:	84 db                	test   %bl,%bl
 90d:	74 66                	je     975 <printf+0xa5>
    c = fmt[i] & 0xff;
 90f:	0f b6 c3             	movzbl %bl,%eax
 912:	ba 20 00 00 00       	mov    $0x20,%edx
 917:	31 c9                	xor    %ecx,%ecx
        pad_char = ' ';
      } else {
        putc(1, c);
      }
    } else if(state == '%'){
      if(c == '0'){
 919:	83 f8 78             	cmp    $0x78,%eax
 91c:	7f 22                	jg     940 <printf+0x70>
 91e:	83 f8 62             	cmp    $0x62,%eax
 921:	0f 8e b9 01 00 00    	jle    ae0 <printf+0x210>
 927:	83 e8 63             	sub    $0x63,%eax
 92a:	83 f8 15             	cmp    $0x15,%eax
 92d:	77 11                	ja     940 <printf+0x70>
 92f:	ff 24 85 8c 10 00 00 	jmp    *0x108c(,%eax,4)
 936:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 93d:	00 
 93e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 940:	83 ec 04             	sub    $0x4,%esp
 943:	8d 75 e7             	lea    -0x19(%ebp),%esi
 946:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 94a:	6a 01                	push   $0x1
 94c:	56                   	push   %esi
 94d:	6a 01                	push   $0x1
 94f:	e8 1f fd ff ff       	call   673 <write>
 954:	83 c4 0c             	add    $0xc,%esp
 957:	88 5d e7             	mov    %bl,-0x19(%ebp)
 95a:	6a 01                	push   $0x1
 95c:	56                   	push   %esi
 95d:	6a 01                	push   $0x1
 95f:	e8 0f fd ff ff       	call   673 <write>
      } else if(c == '%'){
        putc(1, '%');
        state = 0;
      } else {
        putc(1, '%');
        putc(1, c);
 964:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 967:	0f b6 07             	movzbl (%edi),%eax
 96a:	83 c7 01             	add    $0x1,%edi
 96d:	84 c0                	test   %al,%al
 96f:	0f 85 7b ff ff ff    	jne    8f0 <printf+0x20>
        state = 0;
      }
    }
  }
}
 975:	8d 65 f4             	lea    -0xc(%ebp),%esp
 978:	5b                   	pop    %ebx
 979:	5e                   	pop    %esi
 97a:	5f                   	pop    %edi
 97b:	5d                   	pop    %ebp
 97c:	c3                   	ret
 97d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 16, 0, width, pad_char);
 980:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 983:	83 ec 08             	sub    $0x8,%esp
 986:	8b 06                	mov    (%esi),%eax
 988:	52                   	push   %edx
 989:	ba 10 00 00 00       	mov    $0x10,%edx
 98e:	51                   	push   %ecx
 98f:	31 c9                	xor    %ecx,%ecx
        printint(1, *ap, 10, 1, width, pad_char);
 991:	e8 aa fd ff ff       	call   740 <printint.constprop.0>
        ap++;
 996:	83 c6 04             	add    $0x4,%esi
 999:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 99c:	0f b6 07             	movzbl (%edi),%eax
 99f:	83 c7 01             	add    $0x1,%edi
 9a2:	83 c4 10             	add    $0x10,%esp
 9a5:	84 c0                	test   %al,%al
 9a7:	0f 85 43 ff ff ff    	jne    8f0 <printf+0x20>
}
 9ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9b0:	5b                   	pop    %ebx
 9b1:	5e                   	pop    %esi
 9b2:	5f                   	pop    %edi
 9b3:	5d                   	pop    %ebp
 9b4:	c3                   	ret
 9b5:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 10, 1, width, pad_char);
 9b8:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 9bb:	83 ec 08             	sub    $0x8,%esp
 9be:	8b 06                	mov    (%esi),%eax
 9c0:	52                   	push   %edx
 9c1:	ba 0a 00 00 00       	mov    $0xa,%edx
 9c6:	51                   	push   %ecx
 9c7:	b9 01 00 00 00       	mov    $0x1,%ecx
 9cc:	eb c3                	jmp    991 <printf+0xc1>
 9ce:	66 90                	xchg   %ax,%ax
        s = (char*)*ap;
 9d0:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 9d3:	8b 06                	mov    (%esi),%eax
        ap++;
 9d5:	83 c6 04             	add    $0x4,%esi
 9d8:	89 75 d4             	mov    %esi,-0x2c(%ebp)
        if(s == 0)
 9db:	85 c0                	test   %eax,%eax
 9dd:	0f 85 9d 01 00 00    	jne    b80 <printf+0x2b0>
 9e3:	c6 45 d0 28          	movb   $0x28,-0x30(%ebp)
          s = "(null)";
 9e7:	b8 f8 0f 00 00       	mov    $0xff8,%eax
        int len = 0;
 9ec:	31 db                	xor    %ebx,%ebx
 9ee:	66 90                	xchg   %ax,%ax
        for (char *t = s; *t; t++) len++;
 9f0:	83 c3 01             	add    $0x1,%ebx
 9f3:	80 3c 18 00          	cmpb   $0x0,(%eax,%ebx,1)
 9f7:	75 f7                	jne    9f0 <printf+0x120>
        for (int j = len; j < width; j++)
 9f9:	39 cb                	cmp    %ecx,%ebx
 9fb:	0f 8d 9c 01 00 00    	jge    b9d <printf+0x2cd>
 a01:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 a04:	8d 75 e7             	lea    -0x19(%ebp),%esi
 a07:	89 45 c8             	mov    %eax,-0x38(%ebp)
 a0a:	89 7d cc             	mov    %edi,-0x34(%ebp)
 a0d:	89 df                	mov    %ebx,%edi
 a0f:	89 d3                	mov    %edx,%ebx
 a11:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a18:	00 
 a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 a20:	83 ec 04             	sub    $0x4,%esp
 a23:	88 5d e7             	mov    %bl,-0x19(%ebp)
        for (int j = len; j < width; j++)
 a26:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 a29:	6a 01                	push   $0x1
 a2b:	56                   	push   %esi
 a2c:	6a 01                	push   $0x1
 a2e:	e8 40 fc ff ff       	call   673 <write>
        for (int j = len; j < width; j++)
 a33:	8b 45 d0             	mov    -0x30(%ebp),%eax
 a36:	83 c4 10             	add    $0x10,%esp
 a39:	39 c7                	cmp    %eax,%edi
 a3b:	7c e3                	jl     a20 <printf+0x150>
        while(*s != 0){
 a3d:	8b 45 c8             	mov    -0x38(%ebp),%eax
 a40:	8b 7d cc             	mov    -0x34(%ebp),%edi
 a43:	0f b6 08             	movzbl (%eax),%ecx
 a46:	88 4d d0             	mov    %cl,-0x30(%ebp)
 a49:	84 c9                	test   %cl,%cl
 a4b:	0f 84 16 ff ff ff    	je     967 <printf+0x97>
 a51:	89 c3                	mov    %eax,%ebx
 a53:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 a57:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a5e:	00 
 a5f:	90                   	nop
  write(fd, &c, 1);
 a60:	83 ec 04             	sub    $0x4,%esp
 a63:	88 45 e7             	mov    %al,-0x19(%ebp)
          putc(1, *s++);
 a66:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 a69:	6a 01                	push   $0x1
 a6b:	56                   	push   %esi
 a6c:	6a 01                	push   $0x1
 a6e:	e8 00 fc ff ff       	call   673 <write>
        while(*s != 0){
 a73:	0f b6 03             	movzbl (%ebx),%eax
 a76:	83 c4 10             	add    $0x10,%esp
 a79:	84 c0                	test   %al,%al
 a7b:	75 e3                	jne    a60 <printf+0x190>
 a7d:	e9 e5 fe ff ff       	jmp    967 <printf+0x97>
 a82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        char ch = *ap++;
 a88:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
 a8b:	83 ec 04             	sub    $0x4,%esp
 a8e:	8d 75 e7             	lea    -0x19(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 a91:	83 c7 01             	add    $0x1,%edi
        char ch = *ap++;
 a94:	8d 58 04             	lea    0x4(%eax),%ebx
 a97:	8b 00                	mov    (%eax),%eax
 a99:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 a9c:	6a 01                	push   $0x1
 a9e:	56                   	push   %esi
 a9f:	6a 01                	push   $0x1
 aa1:	e8 cd fb ff ff       	call   673 <write>
  for(i = 0; fmt[i]; i++){
 aa6:	0f b6 47 ff          	movzbl -0x1(%edi),%eax
 aaa:	83 c4 10             	add    $0x10,%esp
 aad:	84 c0                	test   %al,%al
 aaf:	0f 84 c0 fe ff ff    	je     975 <printf+0xa5>
    c = fmt[i] & 0xff;
 ab5:	0f b6 d0             	movzbl %al,%edx
        char ch = *ap++;
 ab8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      if (c == '\f') {
 abb:	83 fa 0c             	cmp    $0xc,%edx
 abe:	0f 85 38 fe ff ff    	jne    8fc <printf+0x2c>
 ac4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 acb:	00 
 acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        setcursor();
 ad0:	e8 36 fc ff ff       	call   70b <setcursor>
 ad5:	e9 8d fe ff ff       	jmp    967 <printf+0x97>
 ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 ae0:	83 f8 30             	cmp    $0x30,%eax
 ae3:	74 7b                	je     b60 <printf+0x290>
 ae5:	7f 49                	jg     b30 <printf+0x260>
 ae7:	83 f8 25             	cmp    $0x25,%eax
 aea:	0f 85 50 fe ff ff    	jne    940 <printf+0x70>
  write(fd, &c, 1);
 af0:	83 ec 04             	sub    $0x4,%esp
 af3:	8d 75 e7             	lea    -0x19(%ebp),%esi
 af6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 afa:	6a 01                	push   $0x1
 afc:	56                   	push   %esi
 afd:	6a 01                	push   $0x1
 aff:	e8 6f fb ff ff       	call   673 <write>
        state = 0;
 b04:	83 c4 10             	add    $0x10,%esp
 b07:	e9 5b fe ff ff       	jmp    967 <printf+0x97>
 b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 b10:	83 ec 04             	sub    $0x4,%esp
 b13:	8d 75 e7             	lea    -0x19(%ebp),%esi
 b16:	88 45 e7             	mov    %al,-0x19(%ebp)
 b19:	6a 01                	push   $0x1
 b1b:	56                   	push   %esi
 b1c:	6a 01                	push   $0x1
 b1e:	e8 50 fb ff ff       	call   673 <write>
  for(i = 0; fmt[i]; i++){
 b23:	e9 74 fe ff ff       	jmp    99c <printf+0xcc>
 b28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 b2f:	00 
 b30:	8d 70 cf             	lea    -0x31(%eax),%esi
 b33:	83 fe 08             	cmp    $0x8,%esi
 b36:	0f 87 04 fe ff ff    	ja     940 <printf+0x70>
 b3c:	0f b6 1f             	movzbl (%edi),%ebx
        width = width * 10 + (c - '0');
 b3f:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
  for(i = 0; fmt[i]; i++){
 b42:	83 c7 01             	add    $0x1,%edi
        width = width * 10 + (c - '0');
 b45:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  for(i = 0; fmt[i]; i++){
 b49:	84 db                	test   %bl,%bl
 b4b:	0f 84 24 fe ff ff    	je     975 <printf+0xa5>
    c = fmt[i] & 0xff;
 b51:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 b54:	e9 c0 fd ff ff       	jmp    919 <printf+0x49>
 b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
 b60:	0f b6 1f             	movzbl (%edi),%ebx
 b63:	83 c7 01             	add    $0x1,%edi
 b66:	84 db                	test   %bl,%bl
 b68:	0f 84 07 fe ff ff    	je     975 <printf+0xa5>
    c = fmt[i] & 0xff;
 b6e:	0f b6 c3             	movzbl %bl,%eax
 b71:	ba 30 00 00 00       	mov    $0x30,%edx
 b76:	e9 9e fd ff ff       	jmp    919 <printf+0x49>
 b7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        for (char *t = s; *t; t++) len++;
 b80:	0f b6 18             	movzbl (%eax),%ebx
 b83:	88 5d d0             	mov    %bl,-0x30(%ebp)
 b86:	84 db                	test   %bl,%bl
 b88:	0f 85 5e fe ff ff    	jne    9ec <printf+0x11c>
        int len = 0;
 b8e:	31 db                	xor    %ebx,%ebx
        for (int j = len; j < width; j++)
 b90:	85 c9                	test   %ecx,%ecx
 b92:	0f 8f 69 fe ff ff    	jg     a01 <printf+0x131>
 b98:	e9 ca fd ff ff       	jmp    967 <printf+0x97>
 b9d:	89 c2                	mov    %eax,%edx
 b9f:	8d 75 e7             	lea    -0x19(%ebp),%esi
 ba2:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
 ba6:	89 d3                	mov    %edx,%ebx
 ba8:	e9 b3 fe ff ff       	jmp    a60 <printf+0x190>
 bad:	8d 76 00             	lea    0x0(%esi),%esi

00000bb0 <fprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
fprintf(int fd, char *fmt, ...)
{
 bb0:	55                   	push   %ebp
 bb1:	89 e5                	mov    %esp,%ebp
 bb3:	57                   	push   %edi
 bb4:	56                   	push   %esi
 bb5:	53                   	push   %ebx
 bb6:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 bb9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 bbc:	0f b6 13             	movzbl (%ebx),%edx
 bbf:	83 c3 01             	add    $0x1,%ebx
 bc2:	84 d2                	test   %dl,%dl
 bc4:	0f 84 81 00 00 00    	je     c4b <fprintf+0x9b>
 bca:	8d 75 10             	lea    0x10(%ebp),%esi
 bcd:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
 bd0:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if (c == '\f') { // Detect formfeed character
 bd3:	83 f8 0c             	cmp    $0xc,%eax
 bd6:	0f 84 04 01 00 00    	je     ce0 <fprintf+0x130>
        setcursor();
      } else
      if(c == '%'){
 bdc:	83 f8 25             	cmp    $0x25,%eax
 bdf:	0f 85 5b 01 00 00    	jne    d40 <fprintf+0x190>
  for(i = 0; fmt[i]; i++){
 be5:	0f b6 13             	movzbl (%ebx),%edx
 be8:	84 d2                	test   %dl,%dl
 bea:	74 5f                	je     c4b <fprintf+0x9b>
    c = fmt[i] & 0xff;
 bec:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 bef:	80 fa 25             	cmp    $0x25,%dl
 bf2:	0f 84 78 01 00 00    	je     d70 <fprintf+0x1c0>
 bf8:	83 e8 63             	sub    $0x63,%eax
 bfb:	83 f8 15             	cmp    $0x15,%eax
 bfe:	77 10                	ja     c10 <fprintf+0x60>
 c00:	ff 24 85 e4 10 00 00 	jmp    *0x10e4(,%eax,4)
 c07:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 c0e:	00 
 c0f:	90                   	nop
  write(fd, &c, 1);
 c10:	83 ec 04             	sub    $0x4,%esp
 c13:	8d 7d e7             	lea    -0x19(%ebp),%edi
 c16:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 c19:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 c1d:	6a 01                	push   $0x1
 c1f:	57                   	push   %edi
 c20:	ff 75 08             	push   0x8(%ebp)
 c23:	e8 4b fa ff ff       	call   673 <write>
        putc(fd, c);
 c28:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 c2c:	83 c4 0c             	add    $0xc,%esp
 c2f:	88 55 e7             	mov    %dl,-0x19(%ebp)
 c32:	6a 01                	push   $0x1
 c34:	57                   	push   %edi
 c35:	ff 75 08             	push   0x8(%ebp)
 c38:	e8 36 fa ff ff       	call   673 <write>
  for(i = 0; fmt[i]; i++){
 c3d:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 c41:	83 c3 02             	add    $0x2,%ebx
 c44:	83 c4 10             	add    $0x10,%esp
 c47:	84 d2                	test   %dl,%dl
 c49:	75 85                	jne    bd0 <fprintf+0x20>
      }
      state = 0;
    }
  }
}
 c4b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 c4e:	5b                   	pop    %ebx
 c4f:	5e                   	pop    %esi
 c50:	5f                   	pop    %edi
 c51:	5d                   	pop    %ebp
 c52:	c3                   	ret
 c53:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(1, *ap, 16, 0, width, pad_char);
 c58:	83 ec 08             	sub    $0x8,%esp
 c5b:	8b 06                	mov    (%esi),%eax
 c5d:	31 c9                	xor    %ecx,%ecx
 c5f:	ba 10 00 00 00       	mov    $0x10,%edx
 c64:	6a 20                	push   $0x20
 c66:	6a 00                	push   $0x0
 c68:	e8 d3 fa ff ff       	call   740 <printint.constprop.0>
        ap++;
 c6d:	83 c6 04             	add    $0x4,%esi
  for(i = 0; fmt[i]; i++){
 c70:	eb cb                	jmp    c3d <fprintf+0x8d>
 c72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s = (char*)*ap;
 c78:	8b 3e                	mov    (%esi),%edi
        ap++;
 c7a:	83 c6 04             	add    $0x4,%esi
        if(s == 0)
 c7d:	85 ff                	test   %edi,%edi
 c7f:	0f 84 fb 00 00 00    	je     d80 <fprintf+0x1d0>
        while(*s != 0){
 c85:	0f b6 07             	movzbl (%edi),%eax
 c88:	84 c0                	test   %al,%al
 c8a:	74 36                	je     cc2 <fprintf+0x112>
 c8c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 c8f:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 c92:	8b 75 08             	mov    0x8(%ebp),%esi
 c95:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 c98:	89 fb                	mov    %edi,%ebx
 c9a:	89 cf                	mov    %ecx,%edi
 c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 ca0:	83 ec 04             	sub    $0x4,%esp
 ca3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 ca6:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 ca9:	6a 01                	push   $0x1
 cab:	57                   	push   %edi
 cac:	56                   	push   %esi
 cad:	e8 c1 f9 ff ff       	call   673 <write>
        while(*s != 0){
 cb2:	0f b6 03             	movzbl (%ebx),%eax
 cb5:	83 c4 10             	add    $0x10,%esp
 cb8:	84 c0                	test   %al,%al
 cba:	75 e4                	jne    ca0 <fprintf+0xf0>
 cbc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 cbf:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 cc2:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
 cc6:	83 c3 02             	add    $0x2,%ebx
 cc9:	84 d2                	test   %dl,%dl
 ccb:	0f 84 7a ff ff ff    	je     c4b <fprintf+0x9b>
    c = fmt[i] & 0xff;
 cd1:	0f b6 c2             	movzbl %dl,%eax
      if (c == '\f') { // Detect formfeed character
 cd4:	83 f8 0c             	cmp    $0xc,%eax
 cd7:	0f 85 ff fe ff ff    	jne    bdc <fprintf+0x2c>
 cdd:	8d 76 00             	lea    0x0(%esi),%esi
        setcursor();
 ce0:	e8 26 fa ff ff       	call   70b <setcursor>
  for(i = 0; fmt[i]; i++){
 ce5:	0f b6 13             	movzbl (%ebx),%edx
 ce8:	83 c3 01             	add    $0x1,%ebx
 ceb:	84 d2                	test   %dl,%dl
 ced:	0f 85 dd fe ff ff    	jne    bd0 <fprintf+0x20>
 cf3:	e9 53 ff ff ff       	jmp    c4b <fprintf+0x9b>
 cf8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 cff:	00 
        printint(1, *ap, 10, 1, width, pad_char);
 d00:	83 ec 08             	sub    $0x8,%esp
 d03:	8b 06                	mov    (%esi),%eax
 d05:	b9 01 00 00 00       	mov    $0x1,%ecx
 d0a:	ba 0a 00 00 00       	mov    $0xa,%edx
 d0f:	6a 20                	push   $0x20
 d11:	6a 00                	push   $0x0
 d13:	e9 50 ff ff ff       	jmp    c68 <fprintf+0xb8>
 d18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 d1f:	00 
        putc(fd, *ap);
 d20:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
 d22:	83 ec 04             	sub    $0x4,%esp
 d25:	8d 7d e7             	lea    -0x19(%ebp),%edi
        putc(fd, *ap);
 d28:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 d2b:	6a 01                	push   $0x1
 d2d:	57                   	push   %edi
 d2e:	ff 75 08             	push   0x8(%ebp)
 d31:	e8 3d f9 ff ff       	call   673 <write>
 d36:	e9 32 ff ff ff       	jmp    c6d <fprintf+0xbd>
 d3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 d40:	83 ec 04             	sub    $0x4,%esp
 d43:	8d 45 e7             	lea    -0x19(%ebp),%eax
 d46:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
 d49:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 d4c:	6a 01                	push   $0x1
 d4e:	50                   	push   %eax
 d4f:	ff 75 08             	push   0x8(%ebp)
 d52:	e8 1c f9 ff ff       	call   673 <write>
  for(i = 0; fmt[i]; i++){
 d57:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 d5b:	83 c4 10             	add    $0x10,%esp
 d5e:	84 d2                	test   %dl,%dl
 d60:	0f 85 6a fe ff ff    	jne    bd0 <fprintf+0x20>
}
 d66:	8d 65 f4             	lea    -0xc(%ebp),%esp
 d69:	5b                   	pop    %ebx
 d6a:	5e                   	pop    %esi
 d6b:	5f                   	pop    %edi
 d6c:	5d                   	pop    %ebp
 d6d:	c3                   	ret
 d6e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 d70:	83 ec 04             	sub    $0x4,%esp
 d73:	88 55 e7             	mov    %dl,-0x19(%ebp)
 d76:	8d 7d e7             	lea    -0x19(%ebp),%edi
 d79:	6a 01                	push   $0x1
 d7b:	e9 b4 fe ff ff       	jmp    c34 <fprintf+0x84>
          s = "(null)";
 d80:	bf f8 0f 00 00       	mov    $0xff8,%edi
 d85:	b8 28 00 00 00       	mov    $0x28,%eax
 d8a:	e9 fd fe ff ff       	jmp    c8c <fprintf+0xdc>
 d8f:	66 90                	xchg   %ax,%ax
 d91:	66 90                	xchg   %ax,%ax
 d93:	66 90                	xchg   %ax,%ax
 d95:	66 90                	xchg   %ax,%ax
 d97:	66 90                	xchg   %ax,%ax
 d99:	66 90                	xchg   %ax,%ax
 d9b:	66 90                	xchg   %ax,%ax
 d9d:	66 90                	xchg   %ax,%ax
 d9f:	90                   	nop

00000da0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 da0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 da1:	a1 b8 14 00 00       	mov    0x14b8,%eax
{
 da6:	89 e5                	mov    %esp,%ebp
 da8:	57                   	push   %edi
 da9:	56                   	push   %esi
 daa:	53                   	push   %ebx
 dab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 dae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 db1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 db8:	00 
 db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 dc0:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 dc2:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 dc4:	39 ca                	cmp    %ecx,%edx
 dc6:	73 30                	jae    df8 <free+0x58>
 dc8:	39 c1                	cmp    %eax,%ecx
 dca:	72 04                	jb     dd0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 dcc:	39 c2                	cmp    %eax,%edx
 dce:	72 f0                	jb     dc0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 dd0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 dd3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 dd6:	39 f8                	cmp    %edi,%eax
 dd8:	74 36                	je     e10 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 dda:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 ddd:	8b 42 04             	mov    0x4(%edx),%eax
 de0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 de3:	39 f1                	cmp    %esi,%ecx
 de5:	74 40                	je     e27 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 de7:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 de9:	5b                   	pop    %ebx
  freep = p;
 dea:	89 15 b8 14 00 00    	mov    %edx,0x14b8
}
 df0:	5e                   	pop    %esi
 df1:	5f                   	pop    %edi
 df2:	5d                   	pop    %ebp
 df3:	c3                   	ret
 df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 df8:	39 c2                	cmp    %eax,%edx
 dfa:	72 c4                	jb     dc0 <free+0x20>
 dfc:	39 c1                	cmp    %eax,%ecx
 dfe:	73 c0                	jae    dc0 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
 e00:	8b 73 fc             	mov    -0x4(%ebx),%esi
 e03:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 e06:	39 f8                	cmp    %edi,%eax
 e08:	75 d0                	jne    dda <free+0x3a>
 e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 e10:	03 70 04             	add    0x4(%eax),%esi
 e13:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 e16:	8b 02                	mov    (%edx),%eax
 e18:	8b 00                	mov    (%eax),%eax
 e1a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 e1d:	8b 42 04             	mov    0x4(%edx),%eax
 e20:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 e23:	39 f1                	cmp    %esi,%ecx
 e25:	75 c0                	jne    de7 <free+0x47>
    p->s.size += bp->s.size;
 e27:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 e2a:	89 15 b8 14 00 00    	mov    %edx,0x14b8
    p->s.size += bp->s.size;
 e30:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 e33:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 e36:	89 0a                	mov    %ecx,(%edx)
}
 e38:	5b                   	pop    %ebx
 e39:	5e                   	pop    %esi
 e3a:	5f                   	pop    %edi
 e3b:	5d                   	pop    %ebp
 e3c:	c3                   	ret
 e3d:	8d 76 00             	lea    0x0(%esi),%esi

00000e40 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 e40:	55                   	push   %ebp
 e41:	89 e5                	mov    %esp,%ebp
 e43:	57                   	push   %edi
 e44:	56                   	push   %esi
 e45:	53                   	push   %ebx
 e46:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 e49:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 e4c:	8b 15 b8 14 00 00    	mov    0x14b8,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 e52:	8d 78 07             	lea    0x7(%eax),%edi
 e55:	c1 ef 03             	shr    $0x3,%edi
 e58:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 e5b:	85 d2                	test   %edx,%edx
 e5d:	0f 84 8d 00 00 00    	je     ef0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e63:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 e65:	8b 48 04             	mov    0x4(%eax),%ecx
 e68:	39 f9                	cmp    %edi,%ecx
 e6a:	73 64                	jae    ed0 <malloc+0x90>
  if(nu < 4096)
 e6c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 e71:	39 df                	cmp    %ebx,%edi
 e73:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 e76:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 e7d:	eb 0a                	jmp    e89 <malloc+0x49>
 e7f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e80:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 e82:	8b 48 04             	mov    0x4(%eax),%ecx
 e85:	39 f9                	cmp    %edi,%ecx
 e87:	73 47                	jae    ed0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 e89:	89 c2                	mov    %eax,%edx
 e8b:	39 05 b8 14 00 00    	cmp    %eax,0x14b8
 e91:	75 ed                	jne    e80 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 e93:	83 ec 0c             	sub    $0xc,%esp
 e96:	56                   	push   %esi
 e97:	e8 3f f8 ff ff       	call   6db <sbrk>
  if(p == (char*)-1)
 e9c:	83 c4 10             	add    $0x10,%esp
 e9f:	83 f8 ff             	cmp    $0xffffffff,%eax
 ea2:	74 1c                	je     ec0 <malloc+0x80>
  hp->s.size = nu;
 ea4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 ea7:	83 ec 0c             	sub    $0xc,%esp
 eaa:	83 c0 08             	add    $0x8,%eax
 ead:	50                   	push   %eax
 eae:	e8 ed fe ff ff       	call   da0 <free>
  return freep;
 eb3:	8b 15 b8 14 00 00    	mov    0x14b8,%edx
      if((p = morecore(nunits)) == 0)
 eb9:	83 c4 10             	add    $0x10,%esp
 ebc:	85 d2                	test   %edx,%edx
 ebe:	75 c0                	jne    e80 <malloc+0x40>
        return 0;
  }
}
 ec0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 ec3:	31 c0                	xor    %eax,%eax
}
 ec5:	5b                   	pop    %ebx
 ec6:	5e                   	pop    %esi
 ec7:	5f                   	pop    %edi
 ec8:	5d                   	pop    %ebp
 ec9:	c3                   	ret
 eca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 ed0:	39 cf                	cmp    %ecx,%edi
 ed2:	74 4c                	je     f20 <malloc+0xe0>
        p->s.size -= nunits;
 ed4:	29 f9                	sub    %edi,%ecx
 ed6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 ed9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 edc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 edf:	89 15 b8 14 00 00    	mov    %edx,0x14b8
}
 ee5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 ee8:	83 c0 08             	add    $0x8,%eax
}
 eeb:	5b                   	pop    %ebx
 eec:	5e                   	pop    %esi
 eed:	5f                   	pop    %edi
 eee:	5d                   	pop    %ebp
 eef:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 ef0:	c7 05 b8 14 00 00 bc 	movl   $0x14bc,0x14b8
 ef7:	14 00 00 
    base.s.size = 0;
 efa:	b8 bc 14 00 00       	mov    $0x14bc,%eax
    base.s.ptr = freep = prevp = &base;
 eff:	c7 05 bc 14 00 00 bc 	movl   $0x14bc,0x14bc
 f06:	14 00 00 
    base.s.size = 0;
 f09:	c7 05 c0 14 00 00 00 	movl   $0x0,0x14c0
 f10:	00 00 00 
    if(p->s.size >= nunits){
 f13:	e9 54 ff ff ff       	jmp    e6c <malloc+0x2c>
 f18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 f1f:	00 
        prevp->s.ptr = p->s.ptr;
 f20:	8b 08                	mov    (%eax),%ecx
 f22:	89 0a                	mov    %ecx,(%edx)
 f24:	eb b9                	jmp    edf <malloc+0x9f>
