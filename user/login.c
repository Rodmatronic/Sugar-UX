#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"
#include "../sys/date.h"

char *argv[] = { "sh", 0 };

#define MAX_LINE 256

// Use Zeller's Congruence to get weekday name
char* get_weekday(int y, int m, int d) {
  static char* days[] = {
    "Sat", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri"
  };

  if (m < 3) {
    m += 12;
    y -= 1;
  }

  int h = (d + 2*m + 3*(m+1)/5 + y + y/4 - y/100 + y/400) % 7;
  return days[h];
}

// Convert month number to name
char* monthname(int m) {
  static char* months[] = {
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
  };

  if (m < 1 || m > 12)
    return "???";

  return months[m - 1];
}

int main() {
    char user[50], pass[50], line[MAX_LINE];
    int fd, match = 0;

    printf("login: ");
    gets(user, sizeof(user));  // Get username
    user[strlen(user)-1] = 0;  // Remove newline

    if (strlen(user) == 0) {
        exit(EXIT_FAILURE);
    }

    printf("Password: ");
    echo(0);
    gets(pass, sizeof(pass));  // Get Password
    pass[strlen(pass)-1] = 0;  // Remove newline
    echo(1); 
    printf("\n");
    // Open /etc/passwd
    if ((fd = open("/etc/passwd", 0)) < 0) {
        printf("Error: Cannot open passwd file\n");
        exit(EXIT_FAILURE);
    }
    char *fields[7];
    char c;
    int pos = 0;
    while (read(fd, &c, 1) == 1) {
        // Accumulate characters until newline or buffer full
        if (c != '\n' && pos < MAX_LINE - 1) {
            line[pos++] = c;
        } else {
            line[pos] = 0;  // Null-terminate the line
            pos = 0;
    
            // Split line into colon-separated fields
            char *p = line;
            for (int i = 0; i < 7; i++) {
                fields[i] = p;
                while (*p && *p != ':' && *p != '\n') p++;
                *p++ = 0;  // Terminate field
            }
    
            // Check username and password (fields 0 and 1)
            if (strcmp(fields[0], user) == 0 && strcmp(fields[1], pass) == 0) {
                match = 1;
                break;
            }
        }
    }
    close(fd);
    if (match) {
        setenv("USER", fields[0], 1);
        setenv("LOGNAME", fields[0], 1);
        setenv("HOME", fields[5], 1);
        setenv("SHELL", fields[6], 1);
        setenv("PWD", fields[5], 1);
        int uid = atoi(fields[2]);
	      // Print the date
	      struct rtcdate r;
	      if (gettime(&r) == 0) {
	          printf("%02s %02s %02d %02d:%02d:%02d\n",
	          get_weekday(r.year, r.month, r.day),
	          monthname(r.month),
	          r.day,
	          r.hour,
	          r.minute,
	          r.second);
	      }
	      // Banner
	      struct utsname name;
	      uname(&name);
	      printf("%s %s (%s)\n", name.version, name.release, name.nodename);
        // Display MOTD if available
        int motd_fd = open("/etc/motd", 0);
        if (motd_fd >= 0) {
            char motd_buf[MAX_LINE];
            int bytes_read;
            while ((bytes_read = read(motd_fd, motd_buf, sizeof(motd_buf)-1)) > 0) {
                motd_buf[bytes_read] = 0;  // Null-terminate
                printf("%s", motd_buf);
            }
            close(motd_fd);
            printf("\n");
        }
        if (uid == 0) {
            printf("Don't login as root, use the su command.\n");
        }
        if (chdir(fields[5])) {
            printf("No home directory, defaulting to '/'\n");
            setenv("HOME", "/", 1);
        }
        // Start shell
        int pid = fork();
        if (pid == 0) {
            // Child process
            if (setuid(uid) < 0) {
                printf("login: setuid failed\n");
                exit(EXIT_FAILURE);
            }
            exec(fields[6], argv);
            printf("login: exec sh failed\n");
            exit(EXIT_FAILURE);
        }
        while (wait() != pid);

    } else {
        printf("Login incorrect\n");
    }

    exit(EXIT_SUCCESS);
}
