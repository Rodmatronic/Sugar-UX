/* uname -- print system information
   Copyright (C) 1989, 1991 Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  */

/* Option		Example

   -s, --sysname	SunOS
   -n, --nodename	rocky8
   -r, --release	4.0
   -v, --version
   -m, --machine	sun
   -a, --all		SunOS rocky8 4.0  sun

   The default behavior is equivalent to `-s'.

   David MacKenzie <djm@ai.mit.edu> */

#include "types.h"
#include "user.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
  struct utsname name;
  int print_all = 0;
  int option_s = 0;
  int option_n = 0;
  int option_r = 0;
  int option_v = 0;
  int option_m = 0;

  // Manual option parsing
  for (int i = 1; i < argc; i++) {
    if (argv[i][0] == '-') {
      char *p = &argv[i][1];
      while (*p) {
        switch (*p) {
          case 'a': print_all = 1; break;
          case 's': option_s = 1; break;
          case 'n': option_n = 1; break;
          case 'r': option_r = 1; break;
          case 'v': option_v = 1; break;
          case 'm': option_m = 1; break;
          default:
            fprintf(2, "uname: invalid option '%c'\n", *p);
            exit();
        }
        p++;
      }
    } else {
      fprintf(2, "uname: extra operand '%s'\n", argv[i]);
      exit();
    }
  }

  if (uname(&name) < 0) {
    fprintf(2, "uname: system call failed\n");
    exit();
  }

  if (print_all) {
    printf("%s %s %s %s %s\n", 
           name.sysname,
           name.nodename,
           name.release,
           name.version,
           name.machine);
  } else {
    if (option_s) printf("%s\n", name.sysname);
    if (option_n) printf("%s\n", name.nodename);
    if (option_r) printf("%s\n", name.release);
    if (option_v) printf("%s\n", name.version);
    if (option_m) printf("%s\n", name.machine);
    
    // Default behavior if no options
    if (!(option_s | option_n | option_r | option_v | option_m)) {
      printf("%s\n", name.sysname);
    }
  }

  exit();
}
