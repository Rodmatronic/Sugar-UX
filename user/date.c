#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"
#include "../sys/fcntl.h"
#include "../sys/date.h"

char *argv[] = { "login", 0 };

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

int
main(void ) {
  struct rtcdate r;
  if (gettime(&r) == 0) {
    printf("%s %s %02d %02d:%02d:%02d UTC %02d\n",
           get_weekday(r.year, r.month, r.day),
           monthname(r.month),
           r.day,
           r.hour,
           r.minute,
           r.second,
           r.year);
  }
  exit(EXIT_SUCCESS);
}

