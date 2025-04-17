#include "../sys/types.h"
#include "../sys/stat.h"
#include "../sys/user.h"

/*
 *
 * TODO: Don't... don't do this.
 *
 */

int
main(int argc, char *argv[]){
	int i=0;
  for ( i = 0; i < 24; i++) {
    printf("\n");
  }
  printf("\f");

  exit();
}

