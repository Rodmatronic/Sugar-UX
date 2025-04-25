#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"
#include "../sys/fcntl.h"
#include "../sys/file.h"
#include "../sys/param.h"
#include "../sys/fs.h"
#include "../sys/syscall.h"
#include "../sys/traps.h"

#define stderr 2
#define stdin  0
#define NSIG		64
#define SIG_IGN 0

/* UNIX V7 source code: see /COPYRIGHT or www.tuhs.org for details. */

/*
 * mv file1 file2
 */

#define	DOT	"."
#define	DOTDOT	".."
#define	DELIM	'/'
#define SDELIM "/"
#define	MAXN	100
#define MODEBITS 07777
//#define ROOTINO 2

char	*pname();
char	*dname();
struct	stat s1, s2;

int move(char *source, char *target);
int mvdir(char *source, char *target);
int chkdot(register char *s);
int check(char *spth, uint dinode);

int
main(int argc, register char *argv[])
{
	register int i, r;

	if (argc < 3)
		goto usage;
	if (stat(argv[1], &s1) < 0) {
		fprintf(stderr, "mv: cannot access %s\n", argv[1]);
		exit(EXIT_FAILURE);
	}
	if ((s1.st_mode & S_IFMT) == S_IFDIR) {
		if (argc != 3)
			goto usage;
		return mvdir(argv[1], argv[2]);
	}
//	setuid(getuid());
	if (argc > 3)
		if (stat(argv[argc-1], &s2) < 0 || (s2.st_mode & S_IFMT) != S_IFDIR)
			goto usage;
	r = 0;
	for (i=1; i<argc-1; i++)
		r |= move(argv[i], argv[argc-1]);
	return(r);
usage:
	fprintf(stderr, "usage: mv f1 f2; or mv d1 d2; or mv f1 ... fn d1\n");
	exit(EXIT_FAILURE);
}

int
move(char *source, char *target)
{
	register int c, i;
	//int	status;
	char	buf[MAXN];

	if (stat(source, &s1) < 0) {
		fprintf(stderr, "mv: cannot access %s\n", source);
		exit(EXIT_FAILURE);
	}
	if ((s1.st_mode & S_IFMT) == S_IFDIR) {
		fprintf(stderr, "mv: directory rename only\n");
		exit(EXIT_FAILURE);
	}
	if (stat(target, &s2) >= 0) {
		if ((s2.st_mode & S_IFMT) == S_IFDIR) {
			strcpy(buf, target);            // Copy target directory
			char *end = buf + strlen(buf);  // Find end of string
			*end++ = '/';                   // Add slash
			strcpy(end, dname(source));      // Append filename
			//sprintf(buf, "%s/%s", target, dname(source));
			//target = buf;
		}
		if (stat(target, &s2) >= 0) {
			if ((s2.st_mode & S_IFMT) == S_IFDIR) {
				fprintf(stderr, "mv: %s is a directory\n", target);
				exit(EXIT_FAILURE);
			}
			if (s1.dev==s2.dev && s1.ino==s2.ino) {
				fprintf(stderr, "mv: %s and %s are identical\n",
						source, target);
				exit(0);
			}
			if ((s2.st_mode & 0222) == 0) {
				fprintf(stderr, "mv: %s: %o mode ", target,
					s2.st_mode & MODEBITS);
			    char response[2];
			    fprintf(stderr, "mv: %s: read-only - overwrite? (y/n) ", target);
			    gets(response, sizeof(response));
			    if (response[0] != 'y' && response[0] != 'Y') {
			        exit(EXIT_SUCCESS);
			    }
			}
			if (unlink(target) < 0) {
				fprintf(stderr, "mv: cannot unlink %s\n", target);
				exit(EXIT_FAILURE);
			}
		}
	}
	if (link(source, target) < 0) {
		int status = 0;
		i = fork();
		if (i == -1) {
			fprintf(stderr, "mv: try again\n");
			exit(EXIT_FAILURE);
		}
		if (i == 0) {
			while ((c = wait()) != i && c != -1);
			fprintf(stderr, "mv: cannot exec cp\n");
			exit(EXIT_FAILURE);
		}
		while ((c = wait()) != i && c != -1);
		if (status != 0)
			return(1);
//		utime(target, &s1.st_atime);
	}
	if (unlink(source) < 0) {
		fprintf(stderr, "mv: cannot unlink %s\n", source);
		exit(EXIT_FAILURE);
	}
	//return(0);
	exit(EXIT_SUCCESS);
}

int
mvdir(char *source, char *target)
{
	register char *p;
	//register int i;
	char buf[MAXN];

	if (stat(target, &s2) >= 0) {
		if ((s2.st_mode&S_IFMT) != S_IFDIR) {
			fprintf(stderr, "mv: %s exists\n", target);
			return(1);
		}
		if (strlen(target) > MAXN-DIRSIZ-2) {
			fprintf(stderr, "mv :target name too long\n");
			return(1);
		}
		strcpy(buf, target);
		target = buf;
		strcat(buf, SDELIM);
		strcat(buf, dname(source));
		if (stat(target, &s2) >= 0) {
			fprintf(stderr, "mv: %s exists\n", buf);
			return(1);
		}
	}
	if (strcmp(source, target) == 0) {
		fprintf(stderr, "mv: ?? source == target, source exists and target doesnt\n");
		return(1);
	}
	p = dname(source);
	if (!strcmp(p, DOT) || !strcmp(p, DOTDOT) || !strcmp(p, "") || p[strlen(p)-1]=='/') {
		fprintf(stderr, "mv: cannot rename %s\n", p);
		return(1);
	}
	if (stat(pname(source), &s1) < 0 || stat(pname(target), &s2) < 0) {
		fprintf(stderr, "mv: cannot locate parent\n");
		return(1);
	}
	if ((s2.st_mode & 0200) == 0) {
		fprintf(stderr, "mv: no write access to %s\n", pname(target));
		return(1);
	}
	if ((s2.st_mode & 0200) == 0) {
		fprintf(stderr, "mv: no write access to %s\n", pname(source));
		return(1);
	}
	if ((s2.st_mode & 0200) == 0) {
		fprintf(stderr, "mv: no write access to %s\n", source);
		return(1);
	}
	if (s1.dev != s2.dev) {
		fprintf(stderr, "mv: cannot move directories across devices\n");
		return(1);
	}
	if (s1.ino != s2.ino) {
		char dst[MAXN+5];

		if (chkdot(source) || chkdot(target)) {
			fprintf(stderr, "mv: Sorry, path names including %s aren't allowed\n", DOTDOT);
			return(1);
		}
		stat(source, &s1);
		if (check(pname(target), s1.ino))
			return(1);
//		for (i = 1; i <= NSIG; i++)
//			signal(i, SIG_IGN);
		if (link(source, target) < 0) {
			fprintf(stderr, "mv: cannot link %s to %s\n", target, source);
			return(1);
		}
		if (unlink(source) < 0) {
			fprintf(stderr, "mv: %s: cannot unlink\n", source);
			unlink(target);
			return(1);
		}
		strcat(dst, target);
		strcat(dst, "/");
		strcat(dst, DOTDOT);
		if (unlink(dst) < 0) {
			fprintf(stderr, "mv: %s: cannot unlink\n", dst);
			if (link(target, source) >= 0)
				unlink(target);
			return(1);
		}
		if (link(pname(target), dst) < 0) {
			fprintf(stderr, "mv: cannot link %s to %s\n",
				dst, pname(target));
			if (link(pname(source), dst) >= 0)
				if (link(target, source) >= 0)
					unlink(target);
			return(1);
		}
		return(0);
	}
	if (link(source, target) < 0) {
		fprintf(stderr, "mv: cannot link %s and %s\n",
			source, target);
		return(1);
	}
	if (unlink(source) < 0) {
		fprintf(stderr, "mv: ?? cannot unlink %s\n", source);
		return(1);
	}
	return(0);
}

char * 
pname(char * name)
{
	register int c;
	register char *p, *q;
	static	char buf[MAXN];

	p = q = buf;
	while ((c = *p++ = *name++))
		if (c == DELIM)
			q = p-1;
	if (q == buf && *q == DELIM)
		q++;
	*q = 0;
	return buf[0]? buf : DOT;
}

char *
dname(char * name)
{
	register char *p;

	p = name;
	while (*p)
		if (*p++ == DELIM && *p)
			name = p;
	return name;
}

int 
check(char *spth, uint dinode)
{
	char nspth[MAXN];
	struct stat sbuf;

	sbuf.ino = 0;

	strcpy(nspth, spth);
	while (sbuf.ino != ROOTINO) {
		if (stat(nspth, &sbuf) < 0) {
			fprintf(stderr, "mv: cannot access %s\n", nspth);
			return(1);
		}
		if (sbuf.ino == dinode) {
			fprintf(stderr, "mv: cannot move a directory into itself\n");
			return(1);
		}
		if (strlen(nspth) > MAXN-2-sizeof(DOTDOT)) {
			fprintf(stderr, "mv: name too long\n");
			return(1);
		}
		strcat(nspth, SDELIM);
		strcat(nspth, DOTDOT);
	}
	return(0);
}

int
chkdot(register char *s)
{
	do {
		if (strcmp(dname(s), DOTDOT) == 0)
			return(1);
		s = pname(s);
	} while (strcmp(s, DOT) != 0 && strcmp(s, SDELIM) != 0);
	return(0);
}
