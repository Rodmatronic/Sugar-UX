#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"
#include "../sys/fcntl.h"
#include "../sys/date.h"

int
main(void )
{
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

