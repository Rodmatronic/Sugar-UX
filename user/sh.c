// The Sugar shell, sush. Based on xv6 shell.

#include "../sys/types.h"
#include "../sys/user.h"
#include "../sys/fcntl.h"

#define SEEK_SET 0  // Seek from start of file
#define SEEK_CUR 1  // Seek from current position
#define SEEK_END 2  // Seek from end of file

// Parsed command representation
#define EXEC  1
#define REDIR 2
#define PIPE  3
#define LIST  4
#define BACK  5

#define MAXARGS 128

struct cmd {
  int type;
};

struct execcmd {
  int type;
  char *argv[MAXARGS];
  char *eargv[MAXARGS];
};

struct redircmd {
  int type;          // REDIR
  struct cmd *cmd;   // command to redirect
  char *file;        // filename
  char *efile;       // end of filename (for parsing)
  int mode;          // file open mode (e.g., O_WRONLY)
  int fd;            // file descriptor (e.g., 1 for stdout)
  int append;        // flag for append mode (>>)
};

struct pipecmd {
  int type;
  struct cmd *left;
  struct cmd *right;
};

struct listcmd {
  int type;
  struct cmd *left;
  struct cmd *right;
};

struct backcmd {
  int type;
  struct cmd *cmd;
};

int fork1(void);  // Fork but panics on failure.
void panic(char*);
struct cmd *parsecmd(char*);
int readline(int fd, char *buf, int max);
void process_line(char *line);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
  int p[2];
  struct backcmd *bcmd;
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  //struct redircmd *rcmd;

  if(cmd == 0)
    exit(EXIT_FAILURE);

  switch(cmd->type){
  default:
    panic("runcmd");

  case EXEC:
    ecmd = (struct execcmd*)cmd;
    if(ecmd->argv[0] == 0)
      exit(EXIT_FAILURE);

    // Check for built-in commands first
    if(strcmp(ecmd->argv[0], "cd") == 0) {
      if(ecmd->argv[1] == 0) {
        printf("cd: missing argument\n");
      } else {
        if(chdir(ecmd->argv[1]) < 0) {
          printf("cd: cannot cd to %s\n", ecmd->argv[1]);
        }
      }
      break; // Built-in handled; exit the case
    }

    // Use PATH environment variable
    char * path_env = getenv("PATH");
    char path[128];
    char *pathp = path_env;
    while (*pathp) {
      // Find next ':' or end
      char *q = pathp;
      while (*q && *q != ':') q++;
      int len = q - pathp;
      if (len > 0 && len < sizeof(path) - 2 - strlen(ecmd->argv[0])) {
        memmove(path, pathp, len);
        path[len] = '/';
        strcpy(path + len + 1, ecmd->argv[0]);
        path[len + 1 + strlen(ecmd->argv[0])] = 0;
        exec(path, ecmd->argv);
      }
      if (*q == 0) break;
      pathp = q + 1;
    }
    printf("%s: not found\n", ecmd->argv[0]);
    break;

  case REDIR: {
    struct redircmd *rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
    int fd = open(rcmd->file, rcmd->mode);
    if (fd < 0) {
      printf("open %s failed\n", rcmd->file);
      exit(EXIT_FAILURE);
    }
    if (rcmd->append) {
      // Read entire file to advance offset to EOF
      char buf[512];
      while (read(fd, buf, sizeof(buf)) > 0) {} // Read until EOF
    }
    runcmd(rcmd->cmd);
    return;
    break;
  }

  case LIST:
    lcmd = (struct listcmd*)cmd;
    if(fork1() == 0)
      runcmd(lcmd->left);
    wait();
    runcmd(lcmd->right);
    return;
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
      panic("pipe");
    if(fork1() == 0){
      close(1);
      dup(p[1]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->left);
    }
    if(fork1() == 0){
      close(0);
      dup(p[0]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->right);
    }
    close(p[0]);
    close(p[1]);
    wait();
    wait();
    return;
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
      runcmd(bcmd->cmd);
    return;
    break;
  }
  exit(EXIT_SUCCESS);
}

int
getcmd(char *buf, int nbuf)
{
  printf("%s:%s %s", getenv("HOSTNAME"), getenv("PWD"), getenv("USER"));
  if (getuid() == 0) {
    write(1, "# ", 2);
  } else {
    write(1, "$ ", 2);
  }
  memset(buf, 0, nbuf);
  gets(buf, nbuf);
  if(buf[0] == 0) // EOF
    return -1;
  return 0;
}

int
cd(char * buf)
{
  // Parse the command to handle quotes
  struct cmd *cmd = parsecmd(buf);
  if(cmd->type != EXEC){
    panic("cd: syntax error");
  }
  struct execcmd *ecmd = (struct execcmd*)cmd;
  if(ecmd->argv[1] == 0){
    printf("cd: missing argument\n");
  } else {
      if(chdir(ecmd->argv[1]) < 0){
          printf("cd: cannot cd to %s\n", ecmd->argv[1]);
      }else{
          char cwd[512];
          if (getcwd(cwd, sizeof(cwd)) < 0) {
              printf("cd: failed to getcwd\n");
          }else{
              setenv("PWD", cwd, 1);
          }
      }
  }
  return 0;
}

int
main(int argc, char *argv[])
{
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
    if(fd >= 3){
      close(fd);
      break;
    }
  }

  // Check if a script file is provided
  if(argc >= 2){
    int script_fd = open(argv[1], O_RDONLY);
    if(script_fd < 0){
      printf("shell: cannot open %s\n", argv[1]);
      exit(EXIT_FAILURE);
    }

    char line[100];
    while(readline(script_fd, line, sizeof(line)) > 0){
      process_line(line);
      if(strlen(line) == 0)
        continue;

      // Handle 'exit' command
      if(strcmp(line, "exit") == 0){
        exit(EXIT_SUCCESS);
      }
      if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
        cd(buf);
        continue;
      }
      // Execute other commands
      else {
        struct cmd *cmd = parsecmd(line);
        if(fork1() == 0)
          runcmd(cmd);
        wait();
      }
    }
    close(script_fd);
    exit(EXIT_SUCCESS);
  }

  // interactive loop
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
        cd(buf);
        continue;
      }
    if(buf[0] == 'e' && buf[1] == 'x' && buf[2] == 'i' && buf[3] == 't'){
      exit(EXIT_SUCCESS);
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
    wait();
  }
  exit(EXIT_SUCCESS);
}

void
process_line(char *line)
{
  // Remove comment part
  char *p = strchr(line, '#');
  if(p != 0)
    *p = '\0';

  // Trim leading whitespace
  char *start = line;
  while(*start == ' ' || *start == '\t')
    start++;
  memmove(line, start, strlen(start) + 1);

  // Trim trailing whitespace
  char *end = line + strlen(line) - 1;
  while(end >= line && (*end == ' ' || *end == '\t' || *end == '\n' || *end == '\r'))
    *end-- = '\0';
}

int
readline(int fd, char *buf, int max)
{
  int i = 0;
  char c;
  while(i < max - 1){
    if(read(fd, &c, 1) <= 0)
      break;
    if(c == '\n')
      break;
    buf[i++] = c;
  }
  buf[i] = '\0';
  return i;
}


void
panic(char *s)
{
  printf("%s\n", s);
  exit(EXIT_FAILURE);
}

int
fork1(void)
{
  int pid;

  pid = fork();
  if(pid == -1)
    panic("fork");
  return pid;
}

//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = EXEC;
  return (struct cmd*)cmd;
}

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd, int append) {
  struct redircmd *cmd;
  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = REDIR;
  cmd->cmd = subcmd;
  cmd->file = file;
  cmd->efile = efile;
  cmd->mode = mode;
  cmd->fd = fd;
  cmd->append = append;  // store append flag
  return (struct cmd*)cmd;
}

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = PIPE;
  cmd->left = left;
  cmd->right = right;
  return (struct cmd*)cmd;
}

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = LIST;
  cmd->left = left;
  cmd->right = right;
  return (struct cmd*)cmd;
}

struct cmd*
backcmd(struct cmd *subcmd)
{
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = BACK;
  cmd->cmd = subcmd;
  return (struct cmd*)cmd;
}
//PAGEBREAK!
// Parsing

char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
  char *s;
  int ret;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
  case 0:
    break;
  case '|':
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
    break;
  case '>':
    s++;
    if(*s == '>'){
      ret = '+';
      s++;
    }
    break;
  default:
    ret = 'a';
    if (*s == '"') {
        // Quoted string
        s++; // Skip opening quote
        char *dest = s;
        char *src = s;
        while (src < es) {
            if (*src == '\\') {
                // Escape: skip backslash, take next char
                src++;
                if (src < es) {
                    *dest++ = *src++;
                } else {
                    break;
                }
            } else if (*src == '"') {
                break;
            } else {
                *dest++ = *src++;
            }
        }
        if (q)
            *q = s;
        if (eq)
            *eq = dest;
        // Move s to after closing quote
        if (src < es && *src == '"') {
            src++;
        }
        s = src;
    } else {
        // Regular token
        char *src = s;
        char *dest = s;
        while (src < es) {
            if (*src == '\\') {
                // Escape: skip backslash, take next char
                src++;
                if (src < es) {
                    *dest++ = *src++;
                } else {
                    break;
                }
            } else if (strchr(whitespace, *src) || strchr(symbols, *src)) {
                break;
            } else {
                *dest++ = *src++;
            }
        }
        if (eq)
            *eq = dest;
        s = src;
    }
    // Skip trailing whitespace after token
    while(s < es && strchr(whitespace, *s))
        s++;
    break;
  }
  *ps = s;
  return ret;
}

int
peek(char **ps, char *es, char *toks)
{
  char *s;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  *ps = s;
  return *s && strchr(toks, *s);
}

struct cmd *parseline(char**, char*);
struct cmd *parsepipe(char**, char*);
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
  cmd = parseline(&s, es);
  peek(&s, es, "");
  if(s != es){
    printf("leftovers: %s\n", s);
    panic("sh: syntax error");
  }
  nulterminate(cmd);
  return cmd;
}

struct cmd*
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
  }
  return cmd;
}

struct cmd*
parsepipe(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
  }
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
      panic("missing file for redirection");
    switch(tok){
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0, 0);
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1, 0);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_RDWR|O_CREATE, 1, 1);
      break;
    }
  }
  return cmd;
}

struct cmd*
parseblock(char **ps, char *es)
{
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    panic("parseblock");
  gettoken(ps, es, 0, 0);
  cmd = parseline(ps, es);
  if(!peek(ps, es, ")"))
    panic("syntax - missing )");
  gettoken(ps, es, 0, 0);
  cmd = parseredirs(cmd, ps, es);
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
    return parseblock(ps, es);

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
  int i;
  struct backcmd *bcmd;
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    return 0;

  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
      *ecmd->eargv[i] = 0;
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
    *rcmd->efile = 0;
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    nulterminate(pcmd->left);
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
