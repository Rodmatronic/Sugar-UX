// Kernel configs

#ifndef CONFIG_H
#define CONFIG_H

#include "param.h"

#define KERNEL_NAME "Sugar/Unix"    // Kernel name
extern char hostname[MAXHOSTNAMELEN]; // Hostname
#define RELEASE     "0.15-RELEASE"  // Kernel release version
#define VERSION     "Sugar/Unix (Codename ALFA)" // Kernel version
#define MACHINE     "i386"          // Machine architecture

#endif