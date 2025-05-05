# Sugar/Unix
Thank you very much for checking out Sugar/Unix. Sugar/Unix is a Unix-Like Operating system. It aims to be a reliable, Open source operating system, using XV6 is a foundation.

# How can I build/test Sugar/Unix?
To build and test with the QEMU PC emulator, run the following:
`make qemu`

Please note that depending on your system's toolchain, it might not compile properly, especially if it targets linux (for example `x86_64-pc-linux-gnu`)

For this reason, we included a script that downloads and extracts (locally) a known working toolchain, `installtoolchain.sh`. After running it, running `make` again should automatically detect it.

The default user is 'sugar', with no password. Root has the password 'root', but we encourage you to use the SU utility instead of logging in as root. Please note that Sugar/Unix is currently hit-or-miss on real hardware.

# How can I contribute?
Submitting an issue is an excellent way to help out. I am notified of all issues, and will respond as quick as I can. I aim to (Hopefully!) get them all fixed. These can range from critical bugs, to feature-requests.

If you would like to directly contribute, feel free to clone the repository and make the changes you wish, then submit a Pull request. Your help is greatly appreciated, thank you.

# How is this source structured?
System files, and headers for the kernel/binaries are in the sys/ directory, user-space binaries are in user/ , and etc files are in etc/ . The sys/mkfs.c file directly makes all of the important directories on the disk, and by default, user programs are placed in /bin/ . You can make a rule within mkfs.c to allow the file to be in whatever directory works.
