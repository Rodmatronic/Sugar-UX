#include "../sys/types.h"
#include "../sys/user.h"
#include "../sys/date.h"

int
main()
{
  int ticks = uptime();
  int total_seconds = ticks / 100;  // Convert ticks to seconds
  int minutes = total_seconds / 60;
  int seconds = total_seconds % 60;

  struct rtcdate r;

  if (gettime(&r) == 0) {
    printf(" %d:%02d  ",
           r.hour,
           r.minute,
           r.second);
  }

  printf("up %d mins, %d seconds\n", minutes, seconds);
  exit();
}
