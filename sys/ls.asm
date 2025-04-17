
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
        break;
    }
    close(fd);
}

int main(int argc, char *argv[]) {
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	push   -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	57                   	push   %edi
       e:	56                   	push   %esi
       f:	53                   	push   %ebx
      10:	bb 01 00 00 00       	mov    $0x1,%ebx
      15:	51                   	push   %ecx
      16:	83 ec 08             	sub    $0x8,%esp
      19:	8b 31                	mov    (%ecx),%esi
      1b:	8b 79 04             	mov    0x4(%ecx),%edi
    int i;

    if(argc < 2){
      1e:	83 fe 01             	cmp    $0x1,%esi
      21:	7e 27                	jle    4a <main+0x4a>
      23:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
      2a:	00 
      2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        ls(".");
        exit();
    }
    for(i=1; i<argc; i++)
        ls(argv[i]);
      30:	83 ec 0c             	sub    $0xc,%esp
      33:	ff 34 9f             	push   (%edi,%ebx,4)
    for(i=1; i<argc; i++)
      36:	83 c3 01             	add    $0x1,%ebx
        ls(argv[i]);
      39:	e8 92 00 00 00       	call   d0 <ls>
    for(i=1; i<argc; i++)
      3e:	83 c4 10             	add    $0x10,%esp
      41:	39 de                	cmp    %ebx,%esi
      43:	75 eb                	jne    30 <main+0x30>
    exit();
      45:	e8 49 08 00 00       	call   893 <exit>
        ls(".");
      4a:	83 ec 0c             	sub    $0xc,%esp
      4d:	68 a8 11 00 00       	push   $0x11a8
      52:	e8 79 00 00 00       	call   d0 <ls>
        exit();
      57:	e8 37 08 00 00       	call   893 <exit>
      5c:	66 90                	xchg   %ax,%ax
      5e:	66 90                	xchg   %ax,%ax

00000060 <fmtname>:
fmtname(char *path) {
      60:	55                   	push   %ebp
      61:	89 e5                	mov    %esp,%ebp
      63:	56                   	push   %esi
      64:	53                   	push   %ebx
      65:	8b 75 08             	mov    0x8(%ebp),%esi
    for(p = path + strlen(path); p >= path && *p != '/'; p--)
      68:	83 ec 0c             	sub    $0xc,%esp
      6b:	56                   	push   %esi
      6c:	e8 6f 06 00 00       	call   6e0 <strlen>
      71:	83 c4 10             	add    $0x10,%esp
      74:	01 f0                	add    %esi,%eax
      76:	89 c3                	mov    %eax,%ebx
      78:	73 0f                	jae    89 <fmtname+0x29>
      7a:	eb 12                	jmp    8e <fmtname+0x2e>
      7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      80:	8d 43 ff             	lea    -0x1(%ebx),%eax
      83:	39 f0                	cmp    %esi,%eax
      85:	72 0a                	jb     91 <fmtname+0x31>
      87:	89 c3                	mov    %eax,%ebx
      89:	80 3b 2f             	cmpb   $0x2f,(%ebx)
      8c:	75 f2                	jne    80 <fmtname+0x20>
    p++;
      8e:	83 c3 01             	add    $0x1,%ebx
    int len = strlen(p);
      91:	83 ec 0c             	sub    $0xc,%esp
      94:	53                   	push   %ebx
      95:	e8 46 06 00 00       	call   6e0 <strlen>
    if (len >= DIRSIZ)
      9a:	ba 0e 00 00 00       	mov    $0xe,%edx
      9f:	39 d0                	cmp    %edx,%eax
      a1:	0f 4e d0             	cmovle %eax,%edx
    memmove(buf, p, len);
      a4:	83 c4 0c             	add    $0xc,%esp
      a7:	52                   	push   %edx
    if (len >= DIRSIZ)
      a8:	89 d6                	mov    %edx,%esi
    memmove(buf, p, len);
      aa:	53                   	push   %ebx
      ab:	68 04 16 00 00       	push   $0x1604
      b0:	e8 ab 07 00 00       	call   860 <memmove>
    buf[len] = '\0';
      b5:	c6 86 04 16 00 00 00 	movb   $0x0,0x1604(%esi)
}
      bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
      bf:	b8 04 16 00 00       	mov    $0x1604,%eax
      c4:	5b                   	pop    %ebx
      c5:	5e                   	pop    %esi
      c6:	5d                   	pop    %ebp
      c7:	c3                   	ret
      c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
      cf:	00 

000000d0 <ls>:
void ls(char *path) {
      d0:	55                   	push   %ebp
      d1:	89 e5                	mov    %esp,%ebp
      d3:	57                   	push   %edi
      d4:	56                   	push   %esi
      d5:	53                   	push   %ebx
      d6:	81 ec 00 10 00 00    	sub    $0x1000,%esp
      dc:	83 0c 24 00          	orl    $0x0,(%esp)
      e0:	81 ec 00 10 00 00    	sub    $0x1000,%esp
      e6:	83 0c 24 00          	orl    $0x0,(%esp)
      ea:	81 ec d4 00 00 00    	sub    $0xd4,%esp
      f0:	8b 75 08             	mov    0x8(%ebp),%esi
    if((fd = open(path, 0)) < 0){
      f3:	6a 00                	push   $0x0
      f5:	56                   	push   %esi
      f6:	e8 d8 07 00 00       	call   8d3 <open>
      fb:	83 c4 10             	add    $0x10,%esp
      fe:	89 85 40 df ff ff    	mov    %eax,-0x20c0(%ebp)
     104:	85 c0                	test   %eax,%eax
     106:	0f 88 b1 01 00 00    	js     2bd <ls+0x1ed>
    if(fstat(fd, &st) < 0){
     10c:	83 ec 08             	sub    $0x8,%esp
     10f:	8d 9d 84 df ff ff    	lea    -0x207c(%ebp),%ebx
     115:	53                   	push   %ebx
     116:	ff b5 40 df ff ff    	push   -0x20c0(%ebp)
     11c:	e8 ca 07 00 00       	call   8eb <fstat>
     121:	83 c4 10             	add    $0x10,%esp
     124:	85 c0                	test   %eax,%eax
     126:	0f 88 c3 01 00 00    	js     2ef <ls+0x21f>
    switch(st.type){
     12c:	0f b7 85 86 df ff ff 	movzwl -0x207a(%ebp),%eax
     133:	66 83 f8 01          	cmp    $0x1,%ax
     137:	74 38                	je     171 <ls+0xa1>
     139:	66 83 f8 02          	cmp    $0x2,%ax
     13d:	75 19                	jne    158 <ls+0x88>
        printf("%s\n", fmtname(path));
     13f:	83 ec 0c             	sub    $0xc,%esp
     142:	56                   	push   %esi
     143:	e8 18 ff ff ff       	call   60 <fmtname>
     148:	59                   	pop    %ecx
     149:	5b                   	pop    %ebx
     14a:	50                   	push   %eax
     14b:	68 78 11 00 00       	push   $0x1178
     150:	e8 bb 09 00 00       	call   b10 <printf>
        break;
     155:	83 c4 10             	add    $0x10,%esp
    close(fd);
     158:	83 ec 0c             	sub    $0xc,%esp
     15b:	ff b5 40 df ff ff    	push   -0x20c0(%ebp)
     161:	e8 55 07 00 00       	call   8bb <close>
     166:	83 c4 10             	add    $0x10,%esp
}
     169:	8d 65 f4             	lea    -0xc(%ebp),%esp
     16c:	5b                   	pop    %ebx
     16d:	5e                   	pop    %esi
     16e:	5f                   	pop    %edi
     16f:	5d                   	pop    %ebp
     170:	c3                   	ret
        if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
     171:	83 ec 0c             	sub    $0xc,%esp
     174:	56                   	push   %esi
     175:	e8 66 05 00 00       	call   6e0 <strlen>
     17a:	83 c4 10             	add    $0x10,%esp
     17d:	83 c0 10             	add    $0x10,%eax
     180:	3d 00 02 00 00       	cmp    $0x200,%eax
     185:	0f 87 4d 01 00 00    	ja     2d8 <ls+0x208>
        strcpy(buf, path);
     18b:	83 ec 08             	sub    $0x8,%esp
     18e:	8d bd e8 df ff ff    	lea    -0x2018(%ebp),%edi
     194:	56                   	push   %esi
     195:	8d b5 74 df ff ff    	lea    -0x208c(%ebp),%esi
     19b:	57                   	push   %edi
     19c:	e8 9f 04 00 00       	call   640 <strcpy>
        p = buf + strlen(buf);
     1a1:	89 3c 24             	mov    %edi,(%esp)
     1a4:	e8 37 05 00 00       	call   6e0 <strlen>
        while(read(fd, &de, sizeof(de)) == sizeof(de)){
     1a9:	83 c4 10             	add    $0x10,%esp
        int num_entries = 0;
     1ac:	c7 85 4c df ff ff 00 	movl   $0x0,-0x20b4(%ebp)
     1b3:	00 00 00 
        p = buf + strlen(buf);
     1b6:	01 f8                	add    %edi,%eax
        *p++ = '/';
     1b8:	8d 48 01             	lea    0x1(%eax),%ecx
        p = buf + strlen(buf);
     1bb:	89 85 54 df ff ff    	mov    %eax,-0x20ac(%ebp)
        *p++ = '/';
     1c1:	89 8d 50 df ff ff    	mov    %ecx,-0x20b0(%ebp)
     1c7:	c6 00 2f             	movb   $0x2f,(%eax)
        while(read(fd, &de, sizeof(de)) == sizeof(de)){
     1ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     1d0:	83 ec 04             	sub    $0x4,%esp
     1d3:	6a 10                	push   $0x10
     1d5:	56                   	push   %esi
     1d6:	ff b5 40 df ff ff    	push   -0x20c0(%ebp)
     1dc:	e8 ca 06 00 00       	call   8ab <read>
     1e1:	83 c4 10             	add    $0x10,%esp
     1e4:	83 f8 10             	cmp    $0x10,%eax
     1e7:	0f 85 41 01 00 00    	jne    32e <ls+0x25e>
            if(de.inum == 0)
     1ed:	66 83 bd 74 df ff ff 	cmpw   $0x0,-0x208c(%ebp)
     1f4:	00 
     1f5:	74 d9                	je     1d0 <ls+0x100>
            memmove(p, de.name, DIRSIZ);
     1f7:	83 ec 04             	sub    $0x4,%esp
     1fa:	8d 85 76 df ff ff    	lea    -0x208a(%ebp),%eax
     200:	6a 0e                	push   $0xe
     202:	50                   	push   %eax
     203:	ff b5 50 df ff ff    	push   -0x20b0(%ebp)
     209:	e8 52 06 00 00       	call   860 <memmove>
            p[DIRSIZ] = 0;
     20e:	8b 85 54 df ff ff    	mov    -0x20ac(%ebp),%eax
     214:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
            if(stat(buf, &st) < 0){
     218:	58                   	pop    %eax
     219:	5a                   	pop    %edx
     21a:	53                   	push   %ebx
     21b:	57                   	push   %edi
     21c:	e8 af 05 00 00       	call   7d0 <stat>
     221:	83 c4 10             	add    $0x10,%esp
     224:	85 c0                	test   %eax,%eax
     226:	0f 88 ea 00 00 00    	js     316 <ls+0x246>
            memmove(entry_name, de.name, DIRSIZ);
     22c:	83 ec 04             	sub    $0x4,%esp
     22f:	8d 85 76 df ff ff    	lea    -0x208a(%ebp),%eax
     235:	6a 0e                	push   $0xe
     237:	50                   	push   %eax
     238:	8d 85 65 df ff ff    	lea    -0x209b(%ebp),%eax
     23e:	50                   	push   %eax
     23f:	e8 1c 06 00 00       	call   860 <memmove>
            int len = strlen(entry_name);
     244:	8d 85 65 df ff ff    	lea    -0x209b(%ebp),%eax
            entry_name[DIRSIZ] = '\0';
     24a:	c6 85 73 df ff ff 00 	movb   $0x0,-0x208d(%ebp)
            int len = strlen(entry_name);
     251:	89 04 24             	mov    %eax,(%esp)
     254:	e8 87 04 00 00       	call   6e0 <strlen>
            if (len == 0)
     259:	83 c4 10             	add    $0x10,%esp
     25c:	85 c0                	test   %eax,%eax
     25e:	0f 84 6c ff ff ff    	je     1d0 <ls+0x100>
            if (num_entries < MAX_ENTRIES) {
     264:	81 bd 4c df ff ff ff 	cmpl   $0x1ff,-0x20b4(%ebp)
     26b:	01 00 00 
     26e:	0f 8f 5c ff ff ff    	jg     1d0 <ls+0x100>
                strncpy(names[num_entries], entry_name, DIRSIZ);
     274:	83 ec 04             	sub    $0x4,%esp
     277:	8d 85 65 df ff ff    	lea    -0x209b(%ebp),%eax
     27d:	6a 0e                	push   $0xe
     27f:	50                   	push   %eax
     280:	8b 8d 4c df ff ff    	mov    -0x20b4(%ebp),%ecx
     286:	89 c8                	mov    %ecx,%eax
     288:	c1 e0 04             	shl    $0x4,%eax
     28b:	29 c8                	sub    %ecx,%eax
     28d:	8d 94 05 e8 e1 ff ff 	lea    -0x1e18(%ebp,%eax,1),%edx
     294:	89 85 48 df ff ff    	mov    %eax,-0x20b8(%ebp)
     29a:	52                   	push   %edx
     29b:	e8 f0 07 00 00       	call   a90 <strncpy>
                names[num_entries][DIRSIZ] = '\0';
     2a0:	8b 85 48 df ff ff    	mov    -0x20b8(%ebp),%eax
                num_entries++;
     2a6:	83 85 4c df ff ff 01 	addl   $0x1,-0x20b4(%ebp)
     2ad:	83 c4 10             	add    $0x10,%esp
                names[num_entries][DIRSIZ] = '\0';
     2b0:	c6 84 05 f6 e1 ff ff 	movb   $0x0,-0x1e0a(%ebp,%eax,1)
     2b7:	00 
                num_entries++;
     2b8:	e9 13 ff ff ff       	jmp    1d0 <ls+0x100>
        fprintf(2, "ls: cannot open %s\n", path);
     2bd:	83 ec 04             	sub    $0x4,%esp
     2c0:	56                   	push   %esi
     2c1:	68 68 11 00 00       	push   $0x1168
     2c6:	6a 02                	push   $0x2
     2c8:	e8 23 0b 00 00       	call   df0 <fprintf>
        return;
     2cd:	83 c4 10             	add    $0x10,%esp
}
     2d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
     2d3:	5b                   	pop    %ebx
     2d4:	5e                   	pop    %esi
     2d5:	5f                   	pop    %edi
     2d6:	5d                   	pop    %ebp
     2d7:	c3                   	ret
            fprintf(2, "ls: path too long\n");
     2d8:	83 ec 08             	sub    $0x8,%esp
     2db:	68 90 11 00 00       	push   $0x1190
     2e0:	6a 02                	push   $0x2
     2e2:	e8 09 0b 00 00       	call   df0 <fprintf>
            break;
     2e7:	83 c4 10             	add    $0x10,%esp
     2ea:	e9 69 fe ff ff       	jmp    158 <ls+0x88>
        fprintf(2, "ls: cannot stat %s\n", path);
     2ef:	83 ec 04             	sub    $0x4,%esp
     2f2:	56                   	push   %esi
     2f3:	68 7c 11 00 00       	push   $0x117c
     2f8:	6a 02                	push   $0x2
     2fa:	e8 f1 0a 00 00       	call   df0 <fprintf>
        close(fd);
     2ff:	5e                   	pop    %esi
     300:	ff b5 40 df ff ff    	push   -0x20c0(%ebp)
     306:	e8 b0 05 00 00       	call   8bb <close>
        return;
     30b:	83 c4 10             	add    $0x10,%esp
}
     30e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     311:	5b                   	pop    %ebx
     312:	5e                   	pop    %esi
     313:	5f                   	pop    %edi
     314:	5d                   	pop    %ebp
     315:	c3                   	ret
                fprintf(2, "ls: cannot stat %s\n", buf);
     316:	83 ec 04             	sub    $0x4,%esp
     319:	57                   	push   %edi
     31a:	68 7c 11 00 00       	push   $0x117c
     31f:	6a 02                	push   $0x2
     321:	e8 ca 0a 00 00       	call   df0 <fprintf>
                continue;
     326:	83 c4 10             	add    $0x10,%esp
     329:	e9 a2 fe ff ff       	jmp    1d0 <ls+0x100>
        for (i = 0; i < num_entries - 1; i++) {
     32e:	8b 95 4c df ff ff    	mov    -0x20b4(%ebp),%edx
     334:	83 fa 01             	cmp    $0x1,%edx
     337:	0f 8e aa 02 00 00    	jle    5e7 <ls+0x517>
     33d:	8d 85 e8 e1 ff ff    	lea    -0x1e18(%ebp),%eax
     343:	89 d6                	mov    %edx,%esi
     345:	89 85 50 df ff ff    	mov    %eax,-0x20b0(%ebp)
     34b:	89 d0                	mov    %edx,%eax
     34d:	c1 e0 04             	shl    $0x4,%eax
     350:	29 d0                	sub    %edx,%eax
     352:	8d bc 05 d9 e1 ff ff 	lea    -0x1e27(%ebp,%eax,1),%edi
     359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            for (j = 0; j < num_entries - i - 1; j++) {
     360:	8b 9d 50 df ff ff    	mov    -0x20b0(%ebp),%ebx
     366:	83 fe 01             	cmp    $0x1,%esi
     369:	7e 60                	jle    3cb <ls+0x2fb>
     36b:	89 b5 54 df ff ff    	mov    %esi,-0x20ac(%ebp)
     371:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     378:	00 
     379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                if (strcmp(names[j], names[j+1]) > 0) {
     380:	83 ec 08             	sub    $0x8,%esp
     383:	89 de                	mov    %ebx,%esi
     385:	83 c3 0f             	add    $0xf,%ebx
     388:	53                   	push   %ebx
     389:	56                   	push   %esi
     38a:	e8 e1 02 00 00       	call   670 <strcmp>
     38f:	83 c4 10             	add    $0x10,%esp
     392:	85 c0                	test   %eax,%eax
     394:	7e 2b                	jle    3c1 <ls+0x2f1>
                    strcpy(temp, names[j]);
     396:	83 ec 08             	sub    $0x8,%esp
     399:	8d 85 65 df ff ff    	lea    -0x209b(%ebp),%eax
     39f:	56                   	push   %esi
     3a0:	50                   	push   %eax
     3a1:	e8 9a 02 00 00       	call   640 <strcpy>
                    strcpy(names[j], names[j+1]);
     3a6:	58                   	pop    %eax
     3a7:	5a                   	pop    %edx
     3a8:	53                   	push   %ebx
     3a9:	56                   	push   %esi
     3aa:	e8 91 02 00 00       	call   640 <strcpy>
                    strcpy(names[j+1], temp);
     3af:	8d 85 65 df ff ff    	lea    -0x209b(%ebp),%eax
     3b5:	59                   	pop    %ecx
     3b6:	5e                   	pop    %esi
     3b7:	50                   	push   %eax
     3b8:	53                   	push   %ebx
     3b9:	e8 82 02 00 00       	call   640 <strcpy>
     3be:	83 c4 10             	add    $0x10,%esp
            for (j = 0; j < num_entries - i - 1; j++) {
     3c1:	39 fb                	cmp    %edi,%ebx
     3c3:	75 bb                	jne    380 <ls+0x2b0>
     3c5:	8b b5 54 df ff ff    	mov    -0x20ac(%ebp),%esi
        for (i = 0; i < num_entries - 1; i++) {
     3cb:	8b 85 50 df ff ff    	mov    -0x20b0(%ebp),%eax
     3d1:	83 ef 0f             	sub    $0xf,%edi
     3d4:	83 ee 01             	sub    $0x1,%esi
     3d7:	39 c7                	cmp    %eax,%edi
     3d9:	75 85                	jne    360 <ls+0x290>
     3db:	8b 85 4c df ff ff    	mov    -0x20b4(%ebp),%eax
     3e1:	8b bd 50 df ff ff    	mov    -0x20b0(%ebp),%edi
     3e7:	89 c3                	mov    %eax,%ebx
     3e9:	c1 e3 04             	shl    $0x4,%ebx
     3ec:	29 c3                	sub    %eax,%ebx
     3ee:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
        int max_len = 0;
     3f1:	31 db                	xor    %ebx,%ebx
     3f3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     3fa:	00 
     3fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
            int len = strlen(names[i]);
     400:	83 ec 0c             	sub    $0xc,%esp
     403:	57                   	push   %edi
     404:	e8 d7 02 00 00       	call   6e0 <strlen>
            if (len > max_len)
     409:	39 c3                	cmp    %eax,%ebx
     40b:	0f 4c d8             	cmovl  %eax,%ebx
        for (i = 0; i < num_entries; i++) {
     40e:	83 c7 0f             	add    $0xf,%edi
     411:	83 c4 10             	add    $0x10,%esp
     414:	39 f7                	cmp    %esi,%edi
     416:	75 e8                	jne    400 <ls+0x330>
        if (max_len == 0)
     418:	85 db                	test   %ebx,%ebx
     41a:	0f 84 a9 01 00 00    	je     5c9 <ls+0x4f9>
        int col_width = max_len + 2;
     420:	8d 43 02             	lea    0x2(%ebx),%eax
        int cols = terminal_width / col_width;
     423:	31 d2                	xor    %edx,%edx
     425:	89 c1                	mov    %eax,%ecx
        int col_width = max_len + 2;
     427:	89 85 44 df ff ff    	mov    %eax,-0x20bc(%ebp)
        int cols = terminal_width / col_width;
     42d:	b8 50 00 00 00       	mov    $0x50,%eax
     432:	f7 f9                	idiv   %ecx
     434:	89 c3                	mov    %eax,%ebx
        if (cols == 0)
     436:	85 c0                	test   %eax,%eax
     438:	0f 85 c0 01 00 00    	jne    5fe <ls+0x52e>
     43e:	c7 85 48 df ff ff 01 	movl   $0x1,-0x20b8(%ebp)
     445:	00 00 00 
            cols = 1;
     448:	bb 01 00 00 00       	mov    $0x1,%ebx
        int rows = (num_entries + cols - 1) / cols;
     44d:	8b 85 4c df ff ff    	mov    -0x20b4(%ebp),%eax
     453:	8d 44 18 ff          	lea    -0x1(%eax,%ebx,1),%eax
     457:	99                   	cltd
     458:	f7 fb                	idiv   %ebx
     45a:	89 85 34 df ff ff    	mov    %eax,-0x20cc(%ebp)
                for (int k = 0; k < padding; k++)
     460:	c7 85 38 df ff ff 00 	movl   $0x0,-0x20c8(%ebp)
     467:	00 00 00 
        for (i = 0; i < rows; i++) {
     46a:	31 f6                	xor    %esi,%esi
            for (j = 0; j < cols; j++) {
     46c:	85 db                	test   %ebx,%ebx
     46e:	0f 8e 23 01 00 00    	jle    597 <ls+0x4c7>
     474:	89 b5 3c df ff ff    	mov    %esi,-0x20c4(%ebp)
     47a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     480:	c7 85 54 df ff ff 00 	movl   $0x0,-0x20ac(%ebp)
     487:	00 00 00 
        int max_len = 0;
     48a:	8b b5 38 df ff ff    	mov    -0x20c8(%ebp),%esi
            for (j = 0; j < cols; j++) {
     490:	89 f7                	mov    %esi,%edi
     492:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     499:	00 
     49a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                if (index >= num_entries)
     4a0:	39 bd 4c df ff ff    	cmp    %edi,-0x20b4(%ebp)
     4a6:	0f 8e af 00 00 00    	jle    55b <ls+0x48b>
                printf("%s", names[index]);
     4ac:	89 f8                	mov    %edi,%eax
     4ae:	8b 8d 50 df ff ff    	mov    -0x20b0(%ebp),%ecx
     4b4:	83 ec 08             	sub    $0x8,%esp
     4b7:	c1 e0 04             	shl    $0x4,%eax
     4ba:	29 f8                	sub    %edi,%eax
     4bc:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
     4bf:	53                   	push   %ebx
     4c0:	68 a3 11 00 00       	push   $0x11a3
     4c5:	e8 46 06 00 00       	call   b10 <printf>
                int len = strlen(names[index]);
     4ca:	89 1c 24             	mov    %ebx,(%esp)
                for (int k = 0; k < padding; k++)
     4cd:	31 db                	xor    %ebx,%ebx
                int len = strlen(names[index]);
     4cf:	e8 0c 02 00 00       	call   6e0 <strlen>
                int padding = col_width - len;
     4d4:	8b b5 44 df ff ff    	mov    -0x20bc(%ebp),%esi
                for (int k = 0; k < padding; k++)
     4da:	83 c4 10             	add    $0x10,%esp
                int padding = col_width - len;
     4dd:	29 c6                	sub    %eax,%esi
                for (int k = 0; k < padding; k++)
     4df:	85 f6                	test   %esi,%esi
     4e1:	7e 24                	jle    507 <ls+0x437>
     4e3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     4ea:	00 
     4eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
                    printf(" ");
     4f0:	83 ec 0c             	sub    $0xc,%esp
                for (int k = 0; k < padding; k++)
     4f3:	83 c3 01             	add    $0x1,%ebx
                    printf(" ");
     4f6:	68 a6 11 00 00       	push   $0x11a6
     4fb:	e8 10 06 00 00       	call   b10 <printf>
                for (int k = 0; k < padding; k++)
     500:	83 c4 10             	add    $0x10,%esp
     503:	39 de                	cmp    %ebx,%esi
     505:	75 e9                	jne    4f0 <ls+0x420>
            for (j = 0; j < cols; j++) {
     507:	83 85 54 df ff ff 01 	addl   $0x1,-0x20ac(%ebp)
     50e:	83 c7 01             	add    $0x1,%edi
     511:	8b 85 54 df ff ff    	mov    -0x20ac(%ebp),%eax
     517:	39 85 48 df ff ff    	cmp    %eax,-0x20b8(%ebp)
     51d:	7f 81                	jg     4a0 <ls+0x3d0>
            printf("\n");
     51f:	83 ec 0c             	sub    $0xc,%esp
     522:	68 a1 11 00 00       	push   $0x11a1
     527:	e8 e4 05 00 00       	call   b10 <printf>
        for (i = 0; i < rows; i++) {
     52c:	83 85 3c df ff ff 01 	addl   $0x1,-0x20c4(%ebp)
     533:	8b 95 34 df ff ff    	mov    -0x20cc(%ebp),%edx
     539:	83 c4 10             	add    $0x10,%esp
     53c:	8b 85 3c df ff ff    	mov    -0x20c4(%ebp),%eax
     542:	8b 8d 48 df ff ff    	mov    -0x20b8(%ebp),%ecx
     548:	01 8d 38 df ff ff    	add    %ecx,-0x20c8(%ebp)
     54e:	39 d0                	cmp    %edx,%eax
     550:	0f 85 2a ff ff ff    	jne    480 <ls+0x3b0>
     556:	e9 fd fb ff ff       	jmp    158 <ls+0x88>
            printf("\n");
     55b:	83 ec 0c             	sub    $0xc,%esp
     55e:	68 a1 11 00 00       	push   $0x11a1
     563:	e8 a8 05 00 00       	call   b10 <printf>
        for (i = 0; i < rows; i++) {
     568:	83 85 3c df ff ff 01 	addl   $0x1,-0x20c4(%ebp)
     56f:	8b 8d 34 df ff ff    	mov    -0x20cc(%ebp),%ecx
     575:	83 c4 10             	add    $0x10,%esp
     578:	8b 85 3c df ff ff    	mov    -0x20c4(%ebp),%eax
     57e:	8b 95 48 df ff ff    	mov    -0x20b8(%ebp),%edx
     584:	01 95 38 df ff ff    	add    %edx,-0x20c8(%ebp)
     58a:	39 c8                	cmp    %ecx,%eax
     58c:	0f 85 ee fe ff ff    	jne    480 <ls+0x3b0>
     592:	e9 c1 fb ff ff       	jmp    158 <ls+0x88>
            printf("\n");
     597:	83 ec 0c             	sub    $0xc,%esp
        for (i = 0; i < rows; i++) {
     59a:	83 c6 01             	add    $0x1,%esi
            printf("\n");
     59d:	68 a1 11 00 00       	push   $0x11a1
     5a2:	e8 69 05 00 00       	call   b10 <printf>
        for (i = 0; i < rows; i++) {
     5a7:	8b 85 34 df ff ff    	mov    -0x20cc(%ebp),%eax
     5ad:	8b 8d 48 df ff ff    	mov    -0x20b8(%ebp),%ecx
     5b3:	83 c4 10             	add    $0x10,%esp
     5b6:	01 8d 38 df ff ff    	add    %ecx,-0x20c8(%ebp)
     5bc:	39 c6                	cmp    %eax,%esi
     5be:	0f 85 a8 fe ff ff    	jne    46c <ls+0x39c>
     5c4:	e9 8f fb ff ff       	jmp    158 <ls+0x88>
     5c9:	c7 85 48 df ff ff 05 	movl   $0x5,-0x20b8(%ebp)
     5d0:	00 00 00 
        int cols = terminal_width / col_width;
     5d3:	bb 1a 00 00 00       	mov    $0x1a,%ebx
        int col_width = max_len + 2;
     5d8:	c7 85 44 df ff ff 03 	movl   $0x3,-0x20bc(%ebp)
     5df:	00 00 00 
     5e2:	e9 66 fe ff ff       	jmp    44d <ls+0x37d>
        for (i = 0; i < num_entries; i++) {
     5e7:	0f 85 6b fb ff ff    	jne    158 <ls+0x88>
     5ed:	8d 85 e8 e1 ff ff    	lea    -0x1e18(%ebp),%eax
     5f3:	89 85 50 df ff ff    	mov    %eax,-0x20b0(%ebp)
     5f9:	e9 dd fd ff ff       	jmp    3db <ls+0x30b>
	if (cols > 5){cols = 5;}
     5fe:	bf 05 00 00 00       	mov    $0x5,%edi
     603:	39 f8                	cmp    %edi,%eax
     605:	0f 4e f8             	cmovle %eax,%edi
        int rows = (num_entries + cols - 1) / cols;
     608:	8b 85 4c df ff ff    	mov    -0x20b4(%ebp),%eax
     60e:	8d 44 18 ff          	lea    -0x1(%eax,%ebx,1),%eax
	if (cols > 5){cols = 5;}
     612:	89 bd 48 df ff ff    	mov    %edi,-0x20b8(%ebp)
        int rows = (num_entries + cols - 1) / cols;
     618:	99                   	cltd
     619:	f7 fb                	idiv   %ebx
     61b:	89 85 34 df ff ff    	mov    %eax,-0x20cc(%ebp)
        for (i = 0; i < rows; i++) {
     621:	85 c0                	test   %eax,%eax
     623:	0f 8f 37 fe ff ff    	jg     460 <ls+0x390>
     629:	e9 2a fb ff ff       	jmp    158 <ls+0x88>
     62e:	66 90                	xchg   %ax,%ax
     630:	66 90                	xchg   %ax,%ax
     632:	66 90                	xchg   %ax,%ax
     634:	66 90                	xchg   %ax,%ax
     636:	66 90                	xchg   %ax,%ax
     638:	66 90                	xchg   %ax,%ax
     63a:	66 90                	xchg   %ax,%ax
     63c:	66 90                	xchg   %ax,%ax
     63e:	66 90                	xchg   %ax,%ax

00000640 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     640:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     641:	31 c0                	xor    %eax,%eax
{
     643:	89 e5                	mov    %esp,%ebp
     645:	53                   	push   %ebx
     646:	8b 4d 08             	mov    0x8(%ebp),%ecx
     649:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     64c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
     650:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     654:	88 14 01             	mov    %dl,(%ecx,%eax,1)
     657:	83 c0 01             	add    $0x1,%eax
     65a:	84 d2                	test   %dl,%dl
     65c:	75 f2                	jne    650 <strcpy+0x10>
    ;
  return os;
}
     65e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     661:	89 c8                	mov    %ecx,%eax
     663:	c9                   	leave
     664:	c3                   	ret
     665:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     66c:	00 
     66d:	8d 76 00             	lea    0x0(%esi),%esi

00000670 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     670:	55                   	push   %ebp
     671:	89 e5                	mov    %esp,%ebp
     673:	53                   	push   %ebx
     674:	8b 55 08             	mov    0x8(%ebp),%edx
     677:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     67a:	0f b6 02             	movzbl (%edx),%eax
     67d:	84 c0                	test   %al,%al
     67f:	75 2f                	jne    6b0 <strcmp+0x40>
     681:	eb 4a                	jmp    6cd <strcmp+0x5d>
     683:	eb 1b                	jmp    6a0 <strcmp+0x30>
     685:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     68c:	00 
     68d:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     694:	00 
     695:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     69c:	00 
     69d:	8d 76 00             	lea    0x0(%esi),%esi
     6a0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
     6a4:	83 c2 01             	add    $0x1,%edx
     6a7:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
     6aa:	84 c0                	test   %al,%al
     6ac:	74 12                	je     6c0 <strcmp+0x50>
     6ae:	89 d9                	mov    %ebx,%ecx
     6b0:	0f b6 19             	movzbl (%ecx),%ebx
     6b3:	38 c3                	cmp    %al,%bl
     6b5:	74 e9                	je     6a0 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
     6b7:	29 d8                	sub    %ebx,%eax
}
     6b9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     6bc:	c9                   	leave
     6bd:	c3                   	ret
     6be:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
     6c0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
     6c4:	31 c0                	xor    %eax,%eax
     6c6:	29 d8                	sub    %ebx,%eax
}
     6c8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     6cb:	c9                   	leave
     6cc:	c3                   	ret
  return (uchar)*p - (uchar)*q;
     6cd:	0f b6 19             	movzbl (%ecx),%ebx
     6d0:	31 c0                	xor    %eax,%eax
     6d2:	eb e3                	jmp    6b7 <strcmp+0x47>
     6d4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     6db:	00 
     6dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006e0 <strlen>:

uint
strlen(char *s)
{
     6e0:	55                   	push   %ebp
     6e1:	89 e5                	mov    %esp,%ebp
     6e3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
     6e6:	80 3a 00             	cmpb   $0x0,(%edx)
     6e9:	74 15                	je     700 <strlen+0x20>
     6eb:	31 c0                	xor    %eax,%eax
     6ed:	8d 76 00             	lea    0x0(%esi),%esi
     6f0:	83 c0 01             	add    $0x1,%eax
     6f3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
     6f7:	89 c1                	mov    %eax,%ecx
     6f9:	75 f5                	jne    6f0 <strlen+0x10>
    ;
  return n;
}
     6fb:	89 c8                	mov    %ecx,%eax
     6fd:	5d                   	pop    %ebp
     6fe:	c3                   	ret
     6ff:	90                   	nop
  for(n = 0; s[n]; n++)
     700:	31 c9                	xor    %ecx,%ecx
}
     702:	5d                   	pop    %ebp
     703:	89 c8                	mov    %ecx,%eax
     705:	c3                   	ret
     706:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     70d:	00 
     70e:	66 90                	xchg   %ax,%ax

00000710 <memset>:

void*
memset(void *dst, int c, uint n)
{
     710:	55                   	push   %ebp
     711:	89 e5                	mov    %esp,%ebp
     713:	57                   	push   %edi
     714:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     717:	8b 4d 10             	mov    0x10(%ebp),%ecx
     71a:	8b 45 0c             	mov    0xc(%ebp),%eax
     71d:	89 d7                	mov    %edx,%edi
     71f:	fc                   	cld
     720:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     722:	8b 7d fc             	mov    -0x4(%ebp),%edi
     725:	89 d0                	mov    %edx,%eax
     727:	c9                   	leave
     728:	c3                   	ret
     729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000730 <strchr>:

char*
strchr(const char *s, char c)
{
     730:	55                   	push   %ebp
     731:	89 e5                	mov    %esp,%ebp
     733:	8b 45 08             	mov    0x8(%ebp),%eax
     736:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     73a:	0f b6 10             	movzbl (%eax),%edx
     73d:	84 d2                	test   %dl,%dl
     73f:	75 1a                	jne    75b <strchr+0x2b>
     741:	eb 25                	jmp    768 <strchr+0x38>
     743:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     74a:	00 
     74b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
     750:	0f b6 50 01          	movzbl 0x1(%eax),%edx
     754:	83 c0 01             	add    $0x1,%eax
     757:	84 d2                	test   %dl,%dl
     759:	74 0d                	je     768 <strchr+0x38>
    if(*s == c)
     75b:	38 d1                	cmp    %dl,%cl
     75d:	75 f1                	jne    750 <strchr+0x20>
      return (char*)s;
  return 0;
}
     75f:	5d                   	pop    %ebp
     760:	c3                   	ret
     761:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
     768:	31 c0                	xor    %eax,%eax
}
     76a:	5d                   	pop    %ebp
     76b:	c3                   	ret
     76c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000770 <gets>:

char*
gets(char *buf, int max)
{
     770:	55                   	push   %ebp
     771:	89 e5                	mov    %esp,%ebp
     773:	57                   	push   %edi
     774:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
     775:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
     778:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
     779:	31 db                	xor    %ebx,%ebx
{
     77b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
     77e:	eb 27                	jmp    7a7 <gets+0x37>
    cc = read(0, &c, 1);
     780:	83 ec 04             	sub    $0x4,%esp
     783:	6a 01                	push   $0x1
     785:	56                   	push   %esi
     786:	6a 00                	push   $0x0
     788:	e8 1e 01 00 00       	call   8ab <read>
    if(cc < 1)
     78d:	83 c4 10             	add    $0x10,%esp
     790:	85 c0                	test   %eax,%eax
     792:	7e 1d                	jle    7b1 <gets+0x41>
      break;
    buf[i++] = c;
     794:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     798:	8b 55 08             	mov    0x8(%ebp),%edx
     79b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
     79f:	3c 0a                	cmp    $0xa,%al
     7a1:	74 10                	je     7b3 <gets+0x43>
     7a3:	3c 0d                	cmp    $0xd,%al
     7a5:	74 0c                	je     7b3 <gets+0x43>
  for(i=0; i+1 < max; ){
     7a7:	89 df                	mov    %ebx,%edi
     7a9:	83 c3 01             	add    $0x1,%ebx
     7ac:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     7af:	7c cf                	jl     780 <gets+0x10>
     7b1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
     7b3:	8b 45 08             	mov    0x8(%ebp),%eax
     7b6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
     7ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7bd:	5b                   	pop    %ebx
     7be:	5e                   	pop    %esi
     7bf:	5f                   	pop    %edi
     7c0:	5d                   	pop    %ebp
     7c1:	c3                   	ret
     7c2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     7c9:	00 
     7ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000007d0 <stat>:

int
stat(char *n, struct stat *st)
{
     7d0:	55                   	push   %ebp
     7d1:	89 e5                	mov    %esp,%ebp
     7d3:	56                   	push   %esi
     7d4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     7d5:	83 ec 08             	sub    $0x8,%esp
     7d8:	6a 00                	push   $0x0
     7da:	ff 75 08             	push   0x8(%ebp)
     7dd:	e8 f1 00 00 00       	call   8d3 <open>
  if(fd < 0)
     7e2:	83 c4 10             	add    $0x10,%esp
     7e5:	85 c0                	test   %eax,%eax
     7e7:	78 27                	js     810 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     7e9:	83 ec 08             	sub    $0x8,%esp
     7ec:	ff 75 0c             	push   0xc(%ebp)
     7ef:	89 c3                	mov    %eax,%ebx
     7f1:	50                   	push   %eax
     7f2:	e8 f4 00 00 00       	call   8eb <fstat>
  close(fd);
     7f7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     7fa:	89 c6                	mov    %eax,%esi
  close(fd);
     7fc:	e8 ba 00 00 00       	call   8bb <close>
  return r;
     801:	83 c4 10             	add    $0x10,%esp
}
     804:	8d 65 f8             	lea    -0x8(%ebp),%esp
     807:	89 f0                	mov    %esi,%eax
     809:	5b                   	pop    %ebx
     80a:	5e                   	pop    %esi
     80b:	5d                   	pop    %ebp
     80c:	c3                   	ret
     80d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     810:	be ff ff ff ff       	mov    $0xffffffff,%esi
     815:	eb ed                	jmp    804 <stat+0x34>
     817:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     81e:	00 
     81f:	90                   	nop

00000820 <atoi>:

int
atoi(const char *s)
{
     820:	55                   	push   %ebp
     821:	89 e5                	mov    %esp,%ebp
     823:	53                   	push   %ebx
     824:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     827:	0f be 02             	movsbl (%edx),%eax
     82a:	8d 48 d0             	lea    -0x30(%eax),%ecx
     82d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
     830:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
     835:	77 1e                	ja     855 <atoi+0x35>
     837:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     83e:	00 
     83f:	90                   	nop
    n = n*10 + *s++ - '0';
     840:	83 c2 01             	add    $0x1,%edx
     843:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
     846:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
     84a:	0f be 02             	movsbl (%edx),%eax
     84d:	8d 58 d0             	lea    -0x30(%eax),%ebx
     850:	80 fb 09             	cmp    $0x9,%bl
     853:	76 eb                	jbe    840 <atoi+0x20>
  return n;
}
     855:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     858:	89 c8                	mov    %ecx,%eax
     85a:	c9                   	leave
     85b:	c3                   	ret
     85c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000860 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     860:	55                   	push   %ebp
     861:	89 e5                	mov    %esp,%ebp
     863:	57                   	push   %edi
     864:	8b 45 10             	mov    0x10(%ebp),%eax
     867:	8b 55 08             	mov    0x8(%ebp),%edx
     86a:	56                   	push   %esi
     86b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     86e:	85 c0                	test   %eax,%eax
     870:	7e 13                	jle    885 <memmove+0x25>
     872:	01 d0                	add    %edx,%eax
  dst = vdst;
     874:	89 d7                	mov    %edx,%edi
     876:	66 90                	xchg   %ax,%ax
     878:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     87f:	00 
    *dst++ = *src++;
     880:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
     881:	39 f8                	cmp    %edi,%eax
     883:	75 fb                	jne    880 <memmove+0x20>
  return vdst;
}
     885:	5e                   	pop    %esi
     886:	89 d0                	mov    %edx,%eax
     888:	5f                   	pop    %edi
     889:	5d                   	pop    %ebp
     88a:	c3                   	ret

0000088b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     88b:	b8 01 00 00 00       	mov    $0x1,%eax
     890:	cd 40                	int    $0x40
     892:	c3                   	ret

00000893 <exit>:
SYSCALL(exit)
     893:	b8 02 00 00 00       	mov    $0x2,%eax
     898:	cd 40                	int    $0x40
     89a:	c3                   	ret

0000089b <wait>:
SYSCALL(wait)
     89b:	b8 03 00 00 00       	mov    $0x3,%eax
     8a0:	cd 40                	int    $0x40
     8a2:	c3                   	ret

000008a3 <pipe>:
SYSCALL(pipe)
     8a3:	b8 04 00 00 00       	mov    $0x4,%eax
     8a8:	cd 40                	int    $0x40
     8aa:	c3                   	ret

000008ab <read>:
SYSCALL(read)
     8ab:	b8 05 00 00 00       	mov    $0x5,%eax
     8b0:	cd 40                	int    $0x40
     8b2:	c3                   	ret

000008b3 <write>:
SYSCALL(write)
     8b3:	b8 10 00 00 00       	mov    $0x10,%eax
     8b8:	cd 40                	int    $0x40
     8ba:	c3                   	ret

000008bb <close>:
SYSCALL(close)
     8bb:	b8 15 00 00 00       	mov    $0x15,%eax
     8c0:	cd 40                	int    $0x40
     8c2:	c3                   	ret

000008c3 <kill>:
SYSCALL(kill)
     8c3:	b8 06 00 00 00       	mov    $0x6,%eax
     8c8:	cd 40                	int    $0x40
     8ca:	c3                   	ret

000008cb <exec>:
SYSCALL(exec)
     8cb:	b8 07 00 00 00       	mov    $0x7,%eax
     8d0:	cd 40                	int    $0x40
     8d2:	c3                   	ret

000008d3 <open>:
SYSCALL(open)
     8d3:	b8 0f 00 00 00       	mov    $0xf,%eax
     8d8:	cd 40                	int    $0x40
     8da:	c3                   	ret

000008db <mknod>:
SYSCALL(mknod)
     8db:	b8 11 00 00 00       	mov    $0x11,%eax
     8e0:	cd 40                	int    $0x40
     8e2:	c3                   	ret

000008e3 <unlink>:
SYSCALL(unlink)
     8e3:	b8 12 00 00 00       	mov    $0x12,%eax
     8e8:	cd 40                	int    $0x40
     8ea:	c3                   	ret

000008eb <fstat>:
SYSCALL(fstat)
     8eb:	b8 08 00 00 00       	mov    $0x8,%eax
     8f0:	cd 40                	int    $0x40
     8f2:	c3                   	ret

000008f3 <link>:
SYSCALL(link)
     8f3:	b8 13 00 00 00       	mov    $0x13,%eax
     8f8:	cd 40                	int    $0x40
     8fa:	c3                   	ret

000008fb <mkdir>:
SYSCALL(mkdir)
     8fb:	b8 14 00 00 00       	mov    $0x14,%eax
     900:	cd 40                	int    $0x40
     902:	c3                   	ret

00000903 <chdir>:
SYSCALL(chdir)
     903:	b8 09 00 00 00       	mov    $0x9,%eax
     908:	cd 40                	int    $0x40
     90a:	c3                   	ret

0000090b <dup>:
SYSCALL(dup)
     90b:	b8 0a 00 00 00       	mov    $0xa,%eax
     910:	cd 40                	int    $0x40
     912:	c3                   	ret

00000913 <getpid>:
SYSCALL(getpid)
     913:	b8 0b 00 00 00       	mov    $0xb,%eax
     918:	cd 40                	int    $0x40
     91a:	c3                   	ret

0000091b <sbrk>:
SYSCALL(sbrk)
     91b:	b8 0c 00 00 00       	mov    $0xc,%eax
     920:	cd 40                	int    $0x40
     922:	c3                   	ret

00000923 <sleep>:
SYSCALL(sleep)
     923:	b8 0d 00 00 00       	mov    $0xd,%eax
     928:	cd 40                	int    $0x40
     92a:	c3                   	ret

0000092b <uptime>:
SYSCALL(uptime)
     92b:	b8 0e 00 00 00       	mov    $0xe,%eax
     930:	cd 40                	int    $0x40
     932:	c3                   	ret

00000933 <bstat>:
SYSCALL(bstat)
     933:	b8 16 00 00 00       	mov    $0x16,%eax
     938:	cd 40                	int    $0x40
     93a:	c3                   	ret

0000093b <swap>:
SYSCALL(swap)
     93b:	b8 17 00 00 00       	mov    $0x17,%eax
     940:	cd 40                	int    $0x40
     942:	c3                   	ret

00000943 <gettime>:
SYSCALL(gettime)
     943:	b8 18 00 00 00       	mov    $0x18,%eax
     948:	cd 40                	int    $0x40
     94a:	c3                   	ret

0000094b <setcursor>:
SYSCALL(setcursor)
     94b:	b8 19 00 00 00       	mov    $0x19,%eax
     950:	cd 40                	int    $0x40
     952:	c3                   	ret

00000953 <uname>:
SYSCALL(uname)
     953:	b8 1a 00 00 00       	mov    $0x1a,%eax
     958:	cd 40                	int    $0x40
     95a:	c3                   	ret

0000095b <echo>:
SYSCALL(echo)
     95b:	b8 1b 00 00 00       	mov    $0x1b,%eax
     960:	cd 40                	int    $0x40
     962:	c3                   	ret
     963:	66 90                	xchg   %ax,%ax
     965:	66 90                	xchg   %ax,%ax
     967:	66 90                	xchg   %ax,%ax
     969:	66 90                	xchg   %ax,%ax
     96b:	66 90                	xchg   %ax,%ax
     96d:	66 90                	xchg   %ax,%ax
     96f:	66 90                	xchg   %ax,%ax
     971:	66 90                	xchg   %ax,%ax
     973:	66 90                	xchg   %ax,%ax
     975:	66 90                	xchg   %ax,%ax
     977:	66 90                	xchg   %ax,%ax
     979:	66 90                	xchg   %ax,%ax
     97b:	66 90                	xchg   %ax,%ax
     97d:	66 90                	xchg   %ax,%ax
     97f:	90                   	nop

00000980 <printint.constprop.0>:
{
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn, int width, char pad_char)
     980:	55                   	push   %ebp
     981:	89 e5                	mov    %esp,%ebp
     983:	57                   	push   %edi
     984:	56                   	push   %esi
     985:	89 c6                	mov    %eax,%esi
     987:	53                   	push   %ebx
     988:	89 d3                	mov    %edx,%ebx
     98a:	83 ec 3c             	sub    $0x3c,%esp
     98d:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     991:	85 f6                	test   %esi,%esi
     993:	0f 89 d7 00 00 00    	jns    a70 <printint.constprop.0+0xf0>
     999:	83 e1 01             	and    $0x1,%ecx
     99c:	0f 84 ce 00 00 00    	je     a70 <printint.constprop.0+0xf0>
    neg = 1;
     9a2:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
    x = -xx;
     9a9:	f7 de                	neg    %esi
     9ab:	89 f1                	mov    %esi,%ecx
  } else {
    x = xx;
  }

  i = 0;
     9ad:	88 45 bf             	mov    %al,-0x41(%ebp)
     9b0:	31 ff                	xor    %edi,%edi
     9b2:	8d 75 d7             	lea    -0x29(%ebp),%esi
     9b5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     9bc:	00 
     9bd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
     9c0:	89 c8                	mov    %ecx,%eax
     9c2:	31 d2                	xor    %edx,%edx
     9c4:	89 7d c4             	mov    %edi,-0x3c(%ebp)
     9c7:	83 c7 01             	add    $0x1,%edi
     9ca:	f7 f3                	div    %ebx
     9cc:	0f b6 92 64 12 00 00 	movzbl 0x1264(%edx),%edx
     9d3:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
     9d6:	89 ca                	mov    %ecx,%edx
     9d8:	89 c1                	mov    %eax,%ecx
     9da:	39 da                	cmp    %ebx,%edx
     9dc:	73 e2                	jae    9c0 <printint.constprop.0+0x40>

  if(neg)
     9de:	8b 55 c0             	mov    -0x40(%ebp),%edx
     9e1:	0f b6 45 bf          	movzbl -0x41(%ebp),%eax
     9e5:	85 d2                	test   %edx,%edx
     9e7:	74 0b                	je     9f4 <printint.constprop.0+0x74>
    buf[i++] = '-';
     9e9:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
     9ec:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
     9f1:	8d 79 02             	lea    0x2(%ecx),%edi

  // Pad with pad_char until we hit the required width
  while(i < width)
     9f4:	39 7d 08             	cmp    %edi,0x8(%ebp)
     9f7:	0f 8e 83 00 00 00    	jle    a80 <printint.constprop.0+0x100>
     9fd:	8b 55 08             	mov    0x8(%ebp),%edx
     a00:	8d 5d d8             	lea    -0x28(%ebp),%ebx
     a03:	01 df                	add    %ebx,%edi
     a05:	01 da                	add    %ebx,%edx
     a07:	89 d1                	mov    %edx,%ecx
     a09:	29 f9                	sub    %edi,%ecx
     a0b:	83 e1 01             	and    $0x1,%ecx
     a0e:	74 10                	je     a20 <printint.constprop.0+0xa0>
    buf[i++] = pad_char;
     a10:	88 07                	mov    %al,(%edi)
  while(i < width)
     a12:	83 c7 01             	add    $0x1,%edi
     a15:	39 d7                	cmp    %edx,%edi
     a17:	74 13                	je     a2c <printint.constprop.0+0xac>
     a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = pad_char;
     a20:	88 07                	mov    %al,(%edi)
  while(i < width)
     a22:	83 c7 02             	add    $0x2,%edi
    buf[i++] = pad_char;
     a25:	88 47 ff             	mov    %al,-0x1(%edi)
  while(i < width)
     a28:	39 d7                	cmp    %edx,%edi
     a2a:	75 f4                	jne    a20 <printint.constprop.0+0xa0>
     a2c:	8b 45 08             	mov    0x8(%ebp),%eax
     a2f:	8d 78 ff             	lea    -0x1(%eax),%edi

  while(--i >= 0)
     a32:	01 df                	add    %ebx,%edi
     a34:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     a3b:	00 
     a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
     a40:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
     a43:	83 ec 04             	sub    $0x4,%esp
     a46:	88 45 d7             	mov    %al,-0x29(%ebp)
     a49:	6a 01                	push   $0x1
     a4b:	56                   	push   %esi
     a4c:	6a 01                	push   $0x1
     a4e:	e8 60 fe ff ff       	call   8b3 <write>
  while(--i >= 0)
     a53:	89 f8                	mov    %edi,%eax
     a55:	83 c4 10             	add    $0x10,%esp
     a58:	83 ef 01             	sub    $0x1,%edi
     a5b:	39 d8                	cmp    %ebx,%eax
     a5d:	75 e1                	jne    a40 <printint.constprop.0+0xc0>
}
     a5f:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a62:	5b                   	pop    %ebx
     a63:	5e                   	pop    %esi
     a64:	5f                   	pop    %edi
     a65:	5d                   	pop    %ebp
     a66:	c3                   	ret
     a67:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     a6e:	00 
     a6f:	90                   	nop
  neg = 0;
     a70:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
    x = xx;
     a77:	89 f1                	mov    %esi,%ecx
     a79:	e9 2f ff ff ff       	jmp    9ad <printint.constprop.0+0x2d>
     a7e:	66 90                	xchg   %ax,%ax
  while(--i >= 0)
     a80:	83 ef 01             	sub    $0x1,%edi
     a83:	8d 5d d8             	lea    -0x28(%ebp),%ebx
     a86:	eb aa                	jmp    a32 <printint.constprop.0+0xb2>
     a88:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     a8f:	00 

00000a90 <strncpy>:
{
     a90:	55                   	push   %ebp
     a91:	31 c0                	xor    %eax,%eax
     a93:	89 e5                	mov    %esp,%ebp
     a95:	56                   	push   %esi
     a96:	8b 4d 08             	mov    0x8(%ebp),%ecx
     a99:	8b 75 0c             	mov    0xc(%ebp),%esi
     a9c:	53                   	push   %ebx
     a9d:	8b 5d 10             	mov    0x10(%ebp),%ebx
  for (i = 0; i < n && src[i]; i++)
     aa0:	85 db                	test   %ebx,%ebx
     aa2:	7f 26                	jg     aca <strncpy+0x3a>
     aa4:	eb 58                	jmp    afe <strncpy+0x6e>
     aa6:	eb 18                	jmp    ac0 <strncpy+0x30>
     aa8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     aaf:	00 
     ab0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     ab7:	00 
     ab8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     abf:	00 
    dest[i] = src[i];
     ac0:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  for (i = 0; i < n && src[i]; i++)
     ac3:	83 c0 01             	add    $0x1,%eax
     ac6:	39 c3                	cmp    %eax,%ebx
     ac8:	74 34                	je     afe <strncpy+0x6e>
     aca:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
     ace:	84 d2                	test   %dl,%dl
     ad0:	75 ee                	jne    ac0 <strncpy+0x30>
  for (; i < n; i++)
     ad2:	39 c3                	cmp    %eax,%ebx
     ad4:	7e 28                	jle    afe <strncpy+0x6e>
     ad6:	01 c8                	add    %ecx,%eax
     ad8:	01 d9                	add    %ebx,%ecx
     ada:	89 ca                	mov    %ecx,%edx
     adc:	29 c2                	sub    %eax,%edx
     ade:	83 e2 01             	and    $0x1,%edx
     ae1:	74 0d                	je     af0 <strncpy+0x60>
    dest[i] = '\0';
     ae3:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
     ae6:	83 c0 01             	add    $0x1,%eax
     ae9:	39 c8                	cmp    %ecx,%eax
     aeb:	74 11                	je     afe <strncpy+0x6e>
     aed:	8d 76 00             	lea    0x0(%esi),%esi
    dest[i] = '\0';
     af0:	c6 00 00             	movb   $0x0,(%eax)
  for (; i < n; i++)
     af3:	83 c0 02             	add    $0x2,%eax
    dest[i] = '\0';
     af6:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  for (; i < n; i++)
     afa:	39 c8                	cmp    %ecx,%eax
     afc:	75 f2                	jne    af0 <strncpy+0x60>
}
     afe:	5b                   	pop    %ebx
     aff:	5e                   	pop    %esi
     b00:	5d                   	pop    %ebp
     b01:	c3                   	ret
     b02:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     b09:	00 
     b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000b10 <printf>:

void
printf(char *fmt, ...)
{
     b10:	55                   	push   %ebp
     b11:	89 e5                	mov    %esp,%ebp
     b13:	57                   	push   %edi
     b14:	56                   	push   %esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
     b15:	8d 75 0c             	lea    0xc(%ebp),%esi
{
     b18:	53                   	push   %ebx
     b19:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  for(i = 0; fmt[i]; i++){
     b1c:	8b 55 08             	mov    0x8(%ebp),%edx
  ap = (uint*)(void*)&fmt + 1;
     b1f:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
     b22:	0f b6 02             	movzbl (%edx),%eax
     b25:	84 c0                	test   %al,%al
     b27:	0f 84 88 00 00 00    	je     bb5 <printf+0xa5>
     b2d:	8d 7a 01             	lea    0x1(%edx),%edi
    c = fmt[i] & 0xff;
     b30:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
      if (c == '\f') {
     b33:	83 fa 0c             	cmp    $0xc,%edx
     b36:	0f 84 d4 01 00 00    	je     d10 <printf+0x200>
        setcursor();
      } else if(c == '%'){
     b3c:	83 fa 25             	cmp    $0x25,%edx
     b3f:	0f 85 0b 02 00 00    	jne    d50 <printf+0x240>
  for(i = 0; fmt[i]; i++){
     b45:	0f b6 1f             	movzbl (%edi),%ebx
     b48:	83 c7 01             	add    $0x1,%edi
     b4b:	84 db                	test   %bl,%bl
     b4d:	74 66                	je     bb5 <printf+0xa5>
    c = fmt[i] & 0xff;
     b4f:	0f b6 c3             	movzbl %bl,%eax
     b52:	ba 20 00 00 00       	mov    $0x20,%edx
     b57:	31 c9                	xor    %ecx,%ecx
        pad_char = ' ';
      } else {
        putc(1, c);
      }
    } else if(state == '%'){
      if(c == '0'){
     b59:	83 f8 78             	cmp    $0x78,%eax
     b5c:	7f 22                	jg     b80 <printf+0x70>
     b5e:	83 f8 62             	cmp    $0x62,%eax
     b61:	0f 8e b9 01 00 00    	jle    d20 <printf+0x210>
     b67:	83 e8 63             	sub    $0x63,%eax
     b6a:	83 f8 15             	cmp    $0x15,%eax
     b6d:	77 11                	ja     b80 <printf+0x70>
     b6f:	ff 24 85 b4 11 00 00 	jmp    *0x11b4(,%eax,4)
     b76:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     b7d:	00 
     b7e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
     b80:	83 ec 04             	sub    $0x4,%esp
     b83:	8d 75 e7             	lea    -0x19(%ebp),%esi
     b86:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
     b8a:	6a 01                	push   $0x1
     b8c:	56                   	push   %esi
     b8d:	6a 01                	push   $0x1
     b8f:	e8 1f fd ff ff       	call   8b3 <write>
     b94:	83 c4 0c             	add    $0xc,%esp
     b97:	88 5d e7             	mov    %bl,-0x19(%ebp)
     b9a:	6a 01                	push   $0x1
     b9c:	56                   	push   %esi
     b9d:	6a 01                	push   $0x1
     b9f:	e8 0f fd ff ff       	call   8b3 <write>
      } else if(c == '%'){
        putc(1, '%');
        state = 0;
      } else {
        putc(1, '%');
        putc(1, c);
     ba4:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
     ba7:	0f b6 07             	movzbl (%edi),%eax
     baa:	83 c7 01             	add    $0x1,%edi
     bad:	84 c0                	test   %al,%al
     baf:	0f 85 7b ff ff ff    	jne    b30 <printf+0x20>
        state = 0;
      }
    }
  }
}
     bb5:	8d 65 f4             	lea    -0xc(%ebp),%esp
     bb8:	5b                   	pop    %ebx
     bb9:	5e                   	pop    %esi
     bba:	5f                   	pop    %edi
     bbb:	5d                   	pop    %ebp
     bbc:	c3                   	ret
     bbd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 16, 0, width, pad_char);
     bc0:	8b 75 d4             	mov    -0x2c(%ebp),%esi
     bc3:	83 ec 08             	sub    $0x8,%esp
     bc6:	8b 06                	mov    (%esi),%eax
     bc8:	52                   	push   %edx
     bc9:	ba 10 00 00 00       	mov    $0x10,%edx
     bce:	51                   	push   %ecx
     bcf:	31 c9                	xor    %ecx,%ecx
        printint(1, *ap, 10, 1, width, pad_char);
     bd1:	e8 aa fd ff ff       	call   980 <printint.constprop.0>
        ap++;
     bd6:	83 c6 04             	add    $0x4,%esi
     bd9:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
     bdc:	0f b6 07             	movzbl (%edi),%eax
     bdf:	83 c7 01             	add    $0x1,%edi
     be2:	83 c4 10             	add    $0x10,%esp
     be5:	84 c0                	test   %al,%al
     be7:	0f 85 43 ff ff ff    	jne    b30 <printf+0x20>
}
     bed:	8d 65 f4             	lea    -0xc(%ebp),%esp
     bf0:	5b                   	pop    %ebx
     bf1:	5e                   	pop    %esi
     bf2:	5f                   	pop    %edi
     bf3:	5d                   	pop    %ebp
     bf4:	c3                   	ret
     bf5:	8d 76 00             	lea    0x0(%esi),%esi
        printint(1, *ap, 10, 1, width, pad_char);
     bf8:	8b 75 d4             	mov    -0x2c(%ebp),%esi
     bfb:	83 ec 08             	sub    $0x8,%esp
     bfe:	8b 06                	mov    (%esi),%eax
     c00:	52                   	push   %edx
     c01:	ba 0a 00 00 00       	mov    $0xa,%edx
     c06:	51                   	push   %ecx
     c07:	b9 01 00 00 00       	mov    $0x1,%ecx
     c0c:	eb c3                	jmp    bd1 <printf+0xc1>
     c0e:	66 90                	xchg   %ax,%ax
        s = (char*)*ap;
     c10:	8b 75 d4             	mov    -0x2c(%ebp),%esi
     c13:	8b 06                	mov    (%esi),%eax
        ap++;
     c15:	83 c6 04             	add    $0x4,%esi
     c18:	89 75 d4             	mov    %esi,-0x2c(%ebp)
        if(s == 0)
     c1b:	85 c0                	test   %eax,%eax
     c1d:	0f 85 9d 01 00 00    	jne    dc0 <printf+0x2b0>
     c23:	c6 45 d0 28          	movb   $0x28,-0x30(%ebp)
          s = "(null)";
     c27:	b8 aa 11 00 00       	mov    $0x11aa,%eax
        int len = 0;
     c2c:	31 db                	xor    %ebx,%ebx
     c2e:	66 90                	xchg   %ax,%ax
        for (char *t = s; *t; t++) len++;
     c30:	83 c3 01             	add    $0x1,%ebx
     c33:	80 3c 18 00          	cmpb   $0x0,(%eax,%ebx,1)
     c37:	75 f7                	jne    c30 <printf+0x120>
        for (int j = len; j < width; j++)
     c39:	39 cb                	cmp    %ecx,%ebx
     c3b:	0f 8d 9c 01 00 00    	jge    ddd <printf+0x2cd>
     c41:	89 4d d0             	mov    %ecx,-0x30(%ebp)
     c44:	8d 75 e7             	lea    -0x19(%ebp),%esi
     c47:	89 45 c8             	mov    %eax,-0x38(%ebp)
     c4a:	89 7d cc             	mov    %edi,-0x34(%ebp)
     c4d:	89 df                	mov    %ebx,%edi
     c4f:	89 d3                	mov    %edx,%ebx
     c51:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     c58:	00 
     c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
     c60:	83 ec 04             	sub    $0x4,%esp
     c63:	88 5d e7             	mov    %bl,-0x19(%ebp)
        for (int j = len; j < width; j++)
     c66:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
     c69:	6a 01                	push   $0x1
     c6b:	56                   	push   %esi
     c6c:	6a 01                	push   $0x1
     c6e:	e8 40 fc ff ff       	call   8b3 <write>
        for (int j = len; j < width; j++)
     c73:	8b 45 d0             	mov    -0x30(%ebp),%eax
     c76:	83 c4 10             	add    $0x10,%esp
     c79:	39 c7                	cmp    %eax,%edi
     c7b:	7c e3                	jl     c60 <printf+0x150>
        while(*s != 0){
     c7d:	8b 45 c8             	mov    -0x38(%ebp),%eax
     c80:	8b 7d cc             	mov    -0x34(%ebp),%edi
     c83:	0f b6 08             	movzbl (%eax),%ecx
     c86:	88 4d d0             	mov    %cl,-0x30(%ebp)
     c89:	84 c9                	test   %cl,%cl
     c8b:	0f 84 16 ff ff ff    	je     ba7 <printf+0x97>
     c91:	89 c3                	mov    %eax,%ebx
     c93:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
     c97:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     c9e:	00 
     c9f:	90                   	nop
  write(fd, &c, 1);
     ca0:	83 ec 04             	sub    $0x4,%esp
     ca3:	88 45 e7             	mov    %al,-0x19(%ebp)
          putc(1, *s++);
     ca6:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
     ca9:	6a 01                	push   $0x1
     cab:	56                   	push   %esi
     cac:	6a 01                	push   $0x1
     cae:	e8 00 fc ff ff       	call   8b3 <write>
        while(*s != 0){
     cb3:	0f b6 03             	movzbl (%ebx),%eax
     cb6:	83 c4 10             	add    $0x10,%esp
     cb9:	84 c0                	test   %al,%al
     cbb:	75 e3                	jne    ca0 <printf+0x190>
     cbd:	e9 e5 fe ff ff       	jmp    ba7 <printf+0x97>
     cc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        char ch = *ap++;
     cc8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  write(fd, &c, 1);
     ccb:	83 ec 04             	sub    $0x4,%esp
     cce:	8d 75 e7             	lea    -0x19(%ebp),%esi
  for(i = 0; fmt[i]; i++){
     cd1:	83 c7 01             	add    $0x1,%edi
        char ch = *ap++;
     cd4:	8d 58 04             	lea    0x4(%eax),%ebx
     cd7:	8b 00                	mov    (%eax),%eax
     cd9:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
     cdc:	6a 01                	push   $0x1
     cde:	56                   	push   %esi
     cdf:	6a 01                	push   $0x1
     ce1:	e8 cd fb ff ff       	call   8b3 <write>
  for(i = 0; fmt[i]; i++){
     ce6:	0f b6 47 ff          	movzbl -0x1(%edi),%eax
     cea:	83 c4 10             	add    $0x10,%esp
     ced:	84 c0                	test   %al,%al
     cef:	0f 84 c0 fe ff ff    	je     bb5 <printf+0xa5>
    c = fmt[i] & 0xff;
     cf5:	0f b6 d0             	movzbl %al,%edx
        char ch = *ap++;
     cf8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      if (c == '\f') {
     cfb:	83 fa 0c             	cmp    $0xc,%edx
     cfe:	0f 85 38 fe ff ff    	jne    b3c <printf+0x2c>
     d04:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     d0b:	00 
     d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        setcursor();
     d10:	e8 36 fc ff ff       	call   94b <setcursor>
     d15:	e9 8d fe ff ff       	jmp    ba7 <printf+0x97>
     d1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     d20:	83 f8 30             	cmp    $0x30,%eax
     d23:	74 7b                	je     da0 <printf+0x290>
     d25:	7f 49                	jg     d70 <printf+0x260>
     d27:	83 f8 25             	cmp    $0x25,%eax
     d2a:	0f 85 50 fe ff ff    	jne    b80 <printf+0x70>
  write(fd, &c, 1);
     d30:	83 ec 04             	sub    $0x4,%esp
     d33:	8d 75 e7             	lea    -0x19(%ebp),%esi
     d36:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
     d3a:	6a 01                	push   $0x1
     d3c:	56                   	push   %esi
     d3d:	6a 01                	push   $0x1
     d3f:	e8 6f fb ff ff       	call   8b3 <write>
        state = 0;
     d44:	83 c4 10             	add    $0x10,%esp
     d47:	e9 5b fe ff ff       	jmp    ba7 <printf+0x97>
     d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
     d50:	83 ec 04             	sub    $0x4,%esp
     d53:	8d 75 e7             	lea    -0x19(%ebp),%esi
     d56:	88 45 e7             	mov    %al,-0x19(%ebp)
     d59:	6a 01                	push   $0x1
     d5b:	56                   	push   %esi
     d5c:	6a 01                	push   $0x1
     d5e:	e8 50 fb ff ff       	call   8b3 <write>
  for(i = 0; fmt[i]; i++){
     d63:	e9 74 fe ff ff       	jmp    bdc <printf+0xcc>
     d68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     d6f:	00 
     d70:	8d 70 cf             	lea    -0x31(%eax),%esi
     d73:	83 fe 08             	cmp    $0x8,%esi
     d76:	0f 87 04 fe ff ff    	ja     b80 <printf+0x70>
     d7c:	0f b6 1f             	movzbl (%edi),%ebx
        width = width * 10 + (c - '0');
     d7f:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
  for(i = 0; fmt[i]; i++){
     d82:	83 c7 01             	add    $0x1,%edi
        width = width * 10 + (c - '0');
     d85:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  for(i = 0; fmt[i]; i++){
     d89:	84 db                	test   %bl,%bl
     d8b:	0f 84 24 fe ff ff    	je     bb5 <printf+0xa5>
    c = fmt[i] & 0xff;
     d91:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
     d94:	e9 c0 fd ff ff       	jmp    b59 <printf+0x49>
     d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
     da0:	0f b6 1f             	movzbl (%edi),%ebx
     da3:	83 c7 01             	add    $0x1,%edi
     da6:	84 db                	test   %bl,%bl
     da8:	0f 84 07 fe ff ff    	je     bb5 <printf+0xa5>
    c = fmt[i] & 0xff;
     dae:	0f b6 c3             	movzbl %bl,%eax
     db1:	ba 30 00 00 00       	mov    $0x30,%edx
     db6:	e9 9e fd ff ff       	jmp    b59 <printf+0x49>
     dbb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        for (char *t = s; *t; t++) len++;
     dc0:	0f b6 18             	movzbl (%eax),%ebx
     dc3:	88 5d d0             	mov    %bl,-0x30(%ebp)
     dc6:	84 db                	test   %bl,%bl
     dc8:	0f 85 5e fe ff ff    	jne    c2c <printf+0x11c>
        int len = 0;
     dce:	31 db                	xor    %ebx,%ebx
        for (int j = len; j < width; j++)
     dd0:	85 c9                	test   %ecx,%ecx
     dd2:	0f 8f 69 fe ff ff    	jg     c41 <printf+0x131>
     dd8:	e9 ca fd ff ff       	jmp    ba7 <printf+0x97>
     ddd:	89 c2                	mov    %eax,%edx
     ddf:	8d 75 e7             	lea    -0x19(%ebp),%esi
     de2:	0f b6 45 d0          	movzbl -0x30(%ebp),%eax
     de6:	89 d3                	mov    %edx,%ebx
     de8:	e9 b3 fe ff ff       	jmp    ca0 <printf+0x190>
     ded:	8d 76 00             	lea    0x0(%esi),%esi

00000df0 <fprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
fprintf(int fd, char *fmt, ...)
{
     df0:	55                   	push   %ebp
     df1:	89 e5                	mov    %esp,%ebp
     df3:	57                   	push   %edi
     df4:	56                   	push   %esi
     df5:	53                   	push   %ebx
     df6:	83 ec 2c             	sub    $0x2c,%esp
  int width = 0;
  char pad_char = ' ';

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     df9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     dfc:	0f b6 13             	movzbl (%ebx),%edx
     dff:	83 c3 01             	add    $0x1,%ebx
     e02:	84 d2                	test   %dl,%dl
     e04:	0f 84 81 00 00 00    	je     e8b <fprintf+0x9b>
     e0a:	8d 75 10             	lea    0x10(%ebp),%esi
     e0d:	8d 76 00             	lea    0x0(%esi),%esi
    c = fmt[i] & 0xff;
     e10:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
      if (c == '\f') { // Detect formfeed character
     e13:	83 f8 0c             	cmp    $0xc,%eax
     e16:	0f 84 04 01 00 00    	je     f20 <fprintf+0x130>
        setcursor();
      } else
      if(c == '%'){
     e1c:	83 f8 25             	cmp    $0x25,%eax
     e1f:	0f 85 5b 01 00 00    	jne    f80 <fprintf+0x190>
  for(i = 0; fmt[i]; i++){
     e25:	0f b6 13             	movzbl (%ebx),%edx
     e28:	84 d2                	test   %dl,%dl
     e2a:	74 5f                	je     e8b <fprintf+0x9b>
    c = fmt[i] & 0xff;
     e2c:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
     e2f:	80 fa 25             	cmp    $0x25,%dl
     e32:	0f 84 78 01 00 00    	je     fb0 <fprintf+0x1c0>
     e38:	83 e8 63             	sub    $0x63,%eax
     e3b:	83 f8 15             	cmp    $0x15,%eax
     e3e:	77 10                	ja     e50 <fprintf+0x60>
     e40:	ff 24 85 0c 12 00 00 	jmp    *0x120c(,%eax,4)
     e47:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     e4e:	00 
     e4f:	90                   	nop
  write(fd, &c, 1);
     e50:	83 ec 04             	sub    $0x4,%esp
     e53:	8d 7d e7             	lea    -0x19(%ebp),%edi
     e56:	88 55 d4             	mov    %dl,-0x2c(%ebp)
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     e59:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
     e5d:	6a 01                	push   $0x1
     e5f:	57                   	push   %edi
     e60:	ff 75 08             	push   0x8(%ebp)
     e63:	e8 4b fa ff ff       	call   8b3 <write>
        putc(fd, c);
     e68:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
     e6c:	83 c4 0c             	add    $0xc,%esp
     e6f:	88 55 e7             	mov    %dl,-0x19(%ebp)
     e72:	6a 01                	push   $0x1
     e74:	57                   	push   %edi
     e75:	ff 75 08             	push   0x8(%ebp)
     e78:	e8 36 fa ff ff       	call   8b3 <write>
  for(i = 0; fmt[i]; i++){
     e7d:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
     e81:	83 c3 02             	add    $0x2,%ebx
     e84:	83 c4 10             	add    $0x10,%esp
     e87:	84 d2                	test   %dl,%dl
     e89:	75 85                	jne    e10 <fprintf+0x20>
      }
      state = 0;
    }
  }
}
     e8b:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e8e:	5b                   	pop    %ebx
     e8f:	5e                   	pop    %esi
     e90:	5f                   	pop    %edi
     e91:	5d                   	pop    %ebp
     e92:	c3                   	ret
     e93:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(1, *ap, 16, 0, width, pad_char);
     e98:	83 ec 08             	sub    $0x8,%esp
     e9b:	8b 06                	mov    (%esi),%eax
     e9d:	31 c9                	xor    %ecx,%ecx
     e9f:	ba 10 00 00 00       	mov    $0x10,%edx
     ea4:	6a 20                	push   $0x20
     ea6:	6a 00                	push   $0x0
     ea8:	e8 d3 fa ff ff       	call   980 <printint.constprop.0>
        ap++;
     ead:	83 c6 04             	add    $0x4,%esi
  for(i = 0; fmt[i]; i++){
     eb0:	eb cb                	jmp    e7d <fprintf+0x8d>
     eb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        s = (char*)*ap;
     eb8:	8b 3e                	mov    (%esi),%edi
        ap++;
     eba:	83 c6 04             	add    $0x4,%esi
        if(s == 0)
     ebd:	85 ff                	test   %edi,%edi
     ebf:	0f 84 fb 00 00 00    	je     fc0 <fprintf+0x1d0>
        while(*s != 0){
     ec5:	0f b6 07             	movzbl (%edi),%eax
     ec8:	84 c0                	test   %al,%al
     eca:	74 36                	je     f02 <fprintf+0x112>
     ecc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
     ecf:	8d 4d e7             	lea    -0x19(%ebp),%ecx
     ed2:	8b 75 08             	mov    0x8(%ebp),%esi
     ed5:	89 5d d0             	mov    %ebx,-0x30(%ebp)
     ed8:	89 fb                	mov    %edi,%ebx
     eda:	89 cf                	mov    %ecx,%edi
     edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
     ee0:	83 ec 04             	sub    $0x4,%esp
     ee3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
     ee6:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
     ee9:	6a 01                	push   $0x1
     eeb:	57                   	push   %edi
     eec:	56                   	push   %esi
     eed:	e8 c1 f9 ff ff       	call   8b3 <write>
        while(*s != 0){
     ef2:	0f b6 03             	movzbl (%ebx),%eax
     ef5:	83 c4 10             	add    $0x10,%esp
     ef8:	84 c0                	test   %al,%al
     efa:	75 e4                	jne    ee0 <fprintf+0xf0>
     efc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
     eff:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
     f02:	0f b6 53 01          	movzbl 0x1(%ebx),%edx
     f06:	83 c3 02             	add    $0x2,%ebx
     f09:	84 d2                	test   %dl,%dl
     f0b:	0f 84 7a ff ff ff    	je     e8b <fprintf+0x9b>
    c = fmt[i] & 0xff;
     f11:	0f b6 c2             	movzbl %dl,%eax
      if (c == '\f') { // Detect formfeed character
     f14:	83 f8 0c             	cmp    $0xc,%eax
     f17:	0f 85 ff fe ff ff    	jne    e1c <fprintf+0x2c>
     f1d:	8d 76 00             	lea    0x0(%esi),%esi
        setcursor();
     f20:	e8 26 fa ff ff       	call   94b <setcursor>
  for(i = 0; fmt[i]; i++){
     f25:	0f b6 13             	movzbl (%ebx),%edx
     f28:	83 c3 01             	add    $0x1,%ebx
     f2b:	84 d2                	test   %dl,%dl
     f2d:	0f 85 dd fe ff ff    	jne    e10 <fprintf+0x20>
     f33:	e9 53 ff ff ff       	jmp    e8b <fprintf+0x9b>
     f38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     f3f:	00 
        printint(1, *ap, 10, 1, width, pad_char);
     f40:	83 ec 08             	sub    $0x8,%esp
     f43:	8b 06                	mov    (%esi),%eax
     f45:	b9 01 00 00 00       	mov    $0x1,%ecx
     f4a:	ba 0a 00 00 00       	mov    $0xa,%edx
     f4f:	6a 20                	push   $0x20
     f51:	6a 00                	push   $0x0
     f53:	e9 50 ff ff ff       	jmp    ea8 <fprintf+0xb8>
     f58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     f5f:	00 
        putc(fd, *ap);
     f60:	8b 06                	mov    (%esi),%eax
  write(fd, &c, 1);
     f62:	83 ec 04             	sub    $0x4,%esp
     f65:	8d 7d e7             	lea    -0x19(%ebp),%edi
        putc(fd, *ap);
     f68:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
     f6b:	6a 01                	push   $0x1
     f6d:	57                   	push   %edi
     f6e:	ff 75 08             	push   0x8(%ebp)
     f71:	e8 3d f9 ff ff       	call   8b3 <write>
     f76:	e9 32 ff ff ff       	jmp    ead <fprintf+0xbd>
     f7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
     f80:	83 ec 04             	sub    $0x4,%esp
     f83:	8d 45 e7             	lea    -0x19(%ebp),%eax
     f86:	88 55 e7             	mov    %dl,-0x19(%ebp)
  for(i = 0; fmt[i]; i++){
     f89:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
     f8c:	6a 01                	push   $0x1
     f8e:	50                   	push   %eax
     f8f:	ff 75 08             	push   0x8(%ebp)
     f92:	e8 1c f9 ff ff       	call   8b3 <write>
  for(i = 0; fmt[i]; i++){
     f97:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
     f9b:	83 c4 10             	add    $0x10,%esp
     f9e:	84 d2                	test   %dl,%dl
     fa0:	0f 85 6a fe ff ff    	jne    e10 <fprintf+0x20>
}
     fa6:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fa9:	5b                   	pop    %ebx
     faa:	5e                   	pop    %esi
     fab:	5f                   	pop    %edi
     fac:	5d                   	pop    %ebp
     fad:	c3                   	ret
     fae:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
     fb0:	83 ec 04             	sub    $0x4,%esp
     fb3:	88 55 e7             	mov    %dl,-0x19(%ebp)
     fb6:	8d 7d e7             	lea    -0x19(%ebp),%edi
     fb9:	6a 01                	push   $0x1
     fbb:	e9 b4 fe ff ff       	jmp    e74 <fprintf+0x84>
          s = "(null)";
     fc0:	bf aa 11 00 00       	mov    $0x11aa,%edi
     fc5:	b8 28 00 00 00       	mov    $0x28,%eax
     fca:	e9 fd fe ff ff       	jmp    ecc <fprintf+0xdc>
     fcf:	66 90                	xchg   %ax,%ax
     fd1:	66 90                	xchg   %ax,%ax
     fd3:	66 90                	xchg   %ax,%ax
     fd5:	66 90                	xchg   %ax,%ax
     fd7:	66 90                	xchg   %ax,%ax
     fd9:	66 90                	xchg   %ax,%ax
     fdb:	66 90                	xchg   %ax,%ax
     fdd:	66 90                	xchg   %ax,%ax
     fdf:	90                   	nop

00000fe0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     fe0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fe1:	a1 14 16 00 00       	mov    0x1614,%eax
{
     fe6:	89 e5                	mov    %esp,%ebp
     fe8:	57                   	push   %edi
     fe9:	56                   	push   %esi
     fea:	53                   	push   %ebx
     feb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
     fee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     ff1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     ff8:	00 
     ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1000:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1002:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1004:	39 ca                	cmp    %ecx,%edx
    1006:	73 30                	jae    1038 <free+0x58>
    1008:	39 c1                	cmp    %eax,%ecx
    100a:	72 04                	jb     1010 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    100c:	39 c2                	cmp    %eax,%edx
    100e:	72 f0                	jb     1000 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1010:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1013:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1016:	39 f8                	cmp    %edi,%eax
    1018:	74 36                	je     1050 <free+0x70>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    101a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    101d:	8b 42 04             	mov    0x4(%edx),%eax
    1020:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    1023:	39 f1                	cmp    %esi,%ecx
    1025:	74 40                	je     1067 <free+0x87>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    1027:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
    1029:	5b                   	pop    %ebx
  freep = p;
    102a:	89 15 14 16 00 00    	mov    %edx,0x1614
}
    1030:	5e                   	pop    %esi
    1031:	5f                   	pop    %edi
    1032:	5d                   	pop    %ebp
    1033:	c3                   	ret
    1034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1038:	39 c2                	cmp    %eax,%edx
    103a:	72 c4                	jb     1000 <free+0x20>
    103c:	39 c1                	cmp    %eax,%ecx
    103e:	73 c0                	jae    1000 <free+0x20>
  if(bp + bp->s.size == p->s.ptr){
    1040:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1043:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1046:	39 f8                	cmp    %edi,%eax
    1048:	75 d0                	jne    101a <free+0x3a>
    104a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
    1050:	03 70 04             	add    0x4(%eax),%esi
    1053:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1056:	8b 02                	mov    (%edx),%eax
    1058:	8b 00                	mov    (%eax),%eax
    105a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    105d:	8b 42 04             	mov    0x4(%edx),%eax
    1060:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    1063:	39 f1                	cmp    %esi,%ecx
    1065:	75 c0                	jne    1027 <free+0x47>
    p->s.size += bp->s.size;
    1067:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    106a:	89 15 14 16 00 00    	mov    %edx,0x1614
    p->s.size += bp->s.size;
    1070:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    1073:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    1076:	89 0a                	mov    %ecx,(%edx)
}
    1078:	5b                   	pop    %ebx
    1079:	5e                   	pop    %esi
    107a:	5f                   	pop    %edi
    107b:	5d                   	pop    %ebp
    107c:	c3                   	ret
    107d:	8d 76 00             	lea    0x0(%esi),%esi

00001080 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1080:	55                   	push   %ebp
    1081:	89 e5                	mov    %esp,%ebp
    1083:	57                   	push   %edi
    1084:	56                   	push   %esi
    1085:	53                   	push   %ebx
    1086:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1089:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    108c:	8b 15 14 16 00 00    	mov    0x1614,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1092:	8d 78 07             	lea    0x7(%eax),%edi
    1095:	c1 ef 03             	shr    $0x3,%edi
    1098:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    109b:	85 d2                	test   %edx,%edx
    109d:	0f 84 8d 00 00 00    	je     1130 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    10a3:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    10a5:	8b 48 04             	mov    0x4(%eax),%ecx
    10a8:	39 f9                	cmp    %edi,%ecx
    10aa:	73 64                	jae    1110 <malloc+0x90>
  if(nu < 4096)
    10ac:	bb 00 10 00 00       	mov    $0x1000,%ebx
    10b1:	39 df                	cmp    %ebx,%edi
    10b3:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    10b6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    10bd:	eb 0a                	jmp    10c9 <malloc+0x49>
    10bf:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    10c0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    10c2:	8b 48 04             	mov    0x4(%eax),%ecx
    10c5:	39 f9                	cmp    %edi,%ecx
    10c7:	73 47                	jae    1110 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    10c9:	89 c2                	mov    %eax,%edx
    10cb:	39 05 14 16 00 00    	cmp    %eax,0x1614
    10d1:	75 ed                	jne    10c0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
    10d3:	83 ec 0c             	sub    $0xc,%esp
    10d6:	56                   	push   %esi
    10d7:	e8 3f f8 ff ff       	call   91b <sbrk>
  if(p == (char*)-1)
    10dc:	83 c4 10             	add    $0x10,%esp
    10df:	83 f8 ff             	cmp    $0xffffffff,%eax
    10e2:	74 1c                	je     1100 <malloc+0x80>
  hp->s.size = nu;
    10e4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    10e7:	83 ec 0c             	sub    $0xc,%esp
    10ea:	83 c0 08             	add    $0x8,%eax
    10ed:	50                   	push   %eax
    10ee:	e8 ed fe ff ff       	call   fe0 <free>
  return freep;
    10f3:	8b 15 14 16 00 00    	mov    0x1614,%edx
      if((p = morecore(nunits)) == 0)
    10f9:	83 c4 10             	add    $0x10,%esp
    10fc:	85 d2                	test   %edx,%edx
    10fe:	75 c0                	jne    10c0 <malloc+0x40>
        return 0;
  }
}
    1100:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    1103:	31 c0                	xor    %eax,%eax
}
    1105:	5b                   	pop    %ebx
    1106:	5e                   	pop    %esi
    1107:	5f                   	pop    %edi
    1108:	5d                   	pop    %ebp
    1109:	c3                   	ret
    110a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1110:	39 cf                	cmp    %ecx,%edi
    1112:	74 4c                	je     1160 <malloc+0xe0>
        p->s.size -= nunits;
    1114:	29 f9                	sub    %edi,%ecx
    1116:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1119:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    111c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    111f:	89 15 14 16 00 00    	mov    %edx,0x1614
}
    1125:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1128:	83 c0 08             	add    $0x8,%eax
}
    112b:	5b                   	pop    %ebx
    112c:	5e                   	pop    %esi
    112d:	5f                   	pop    %edi
    112e:	5d                   	pop    %ebp
    112f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
    1130:	c7 05 14 16 00 00 18 	movl   $0x1618,0x1614
    1137:	16 00 00 
    base.s.size = 0;
    113a:	b8 18 16 00 00       	mov    $0x1618,%eax
    base.s.ptr = freep = prevp = &base;
    113f:	c7 05 18 16 00 00 18 	movl   $0x1618,0x1618
    1146:	16 00 00 
    base.s.size = 0;
    1149:	c7 05 1c 16 00 00 00 	movl   $0x0,0x161c
    1150:	00 00 00 
    if(p->s.size >= nunits){
    1153:	e9 54 ff ff ff       	jmp    10ac <malloc+0x2c>
    1158:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    115f:	00 
        prevp->s.ptr = p->s.ptr;
    1160:	8b 08                	mov    (%eax),%ecx
    1162:	89 0a                	mov    %ecx,(%edx)
    1164:	eb b9                	jmp    111f <malloc+0x9f>
