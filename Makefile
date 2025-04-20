SYS_DIR := sys
USER_DIR := user
OUT_DIR := out

OBJS = \
	$(OUT_DIR)/bio.o \
	$(OUT_DIR)/console.o \
	$(OUT_DIR)/sys_date.o \
	$(OUT_DIR)/exec.o \
	$(OUT_DIR)/file.o \
	$(OUT_DIR)/fs.o \
	$(OUT_DIR)/ide.o \
	$(OUT_DIR)/ioapic.o \
	$(OUT_DIR)/kalloc.o \
	$(OUT_DIR)/kbd.o \
	$(OUT_DIR)/lapic.o \
	$(OUT_DIR)/log.o \
	$(OUT_DIR)/main.o \
	$(OUT_DIR)/mp.o \
	$(OUT_DIR)/picirq.o \
	$(OUT_DIR)/pipe.o \
	$(OUT_DIR)/proc.o \
	$(OUT_DIR)/sleeplock.o \
	$(OUT_DIR)/spinlock.o \
	$(OUT_DIR)/string.o \
	$(OUT_DIR)/swtch.o \
	$(OUT_DIR)/syscall.o \
	$(OUT_DIR)/sysfile.o \
	$(OUT_DIR)/sysproc.o \
	$(OUT_DIR)/trapasm.o \
	$(OUT_DIR)/trap.o \
	$(OUT_DIR)/paging.o \
	$(OUT_DIR)/uart.o \
	$(OUT_DIR)/vectors.o \
	$(OUT_DIR)/vm.o \
	$(OUT_DIR)/symbols.o \

# Cross-compiling (e.g., on Mac OS X)
# TOOLPREFIX = i386-jos-elf

# Using native tools (e.g., on X86 Linux)
#TOOLPREFIX = 

all: $(OUT_DIR)/xv6.img

# Try to infer the correct TOOLPREFIX if not set
ifndef TOOLPREFIX
TOOLPREFIX := $(shell if i386-jos-elf-objdump -i 2>&1 | grep '^elf32-i386$$' >/dev/null 2>&1; \
	then echo 'i386-jos-elf-'; \
	elif objdump -i 2>&1 | grep 'elf32-i386' >/dev/null 2>&1; \
	then echo ''; \
	else echo "***" 1>&2; \
	echo "*** Error: Couldn't find an i386-*-elf version of GCC/binutils." 1>&2; \
	echo "*** Is the directory with i386-jos-elf-gcc in your PATH?" 1>&2; \
	echo "*** If your i386-*-elf toolchain is installed with a command" 1>&2; \
	echo "*** prefix other than 'i386-jos-elf-', set your TOOLPREFIX" 1>&2; \
	echo "*** environment variable to that prefix and run 'make' again." 1>&2; \
	echo "*** To turn off this error, run 'gmake TOOLPREFIX= ...'." 1>&2; \
	echo "***" 1>&2; exit 1; fi)
endif

# If the makefile can't find QEMU, specify its path here
# QEMU = qemu-system-i386

# Try to infer the correct QEMU
ifndef QEMU
QEMU = $(shell if which qemu > /dev/null; \
	then echo qemu; exit; \
	elif which qemu-system-i386 > /dev/null; \
	then echo qemu-system-i386; exit; \
	elif which qemu-system-x86_64 > /dev/null; \
	then echo qemu-system-x86_64; exit; \
	else \
	qemu=/Applications/Q.app/Contents/MacOS/i386-softmmu.app/Contents/MacOS/i386-softmmu; \
	if test -x $$qemu; then echo $$qemu; exit; fi; fi; \
	echo "***" 1>&2; \
	echo "*** Error: Couldn't find a working QEMU executable." 1>&2; \
	echo "*** Is the directory containing the qemu binary in your PATH" 1>&2; \
	echo "*** or have you tried setting the QEMU variable in Makefile?" 1>&2; \
	echo "***" 1>&2; exit 1)
endif

CC = $(TOOLPREFIX)gcc
AS = $(TOOLPREFIX)gas
LD = $(TOOLPREFIX)ld
OBJCOPY = $(TOOLPREFIX)objcopy
OBJDUMP = $(TOOLPREFIX)objdump
CFLAGS = -fno-pic -static -fno-builtin -fno-strict-aliasing -O2 -Wall -MD -ggdb -m32  -fno-omit-frame-pointer -Wimplicit-int
#CFLAGS = -fno-pic -static -fno-builtin -fno-strict-aliasing -fvar-tracking -fvar-tracking-assignments -O0 -g -Wall -MD -gdwarf-2 -m32 -Werror -fno-omit-frame-pointer
CFLAGS += $(shell $(CC) -fno-stack-protector -E -x c /dev/null >/dev/null 2>&1 && echo -fno-stack-protector)
ASFLAGS = -m32 -gdwarf-2 -Wa,-divide
# FreeBSD ld wants ``elf_i386_fbsd''
LDFLAGS += -m $(shell $(LD) -V | grep elf_i386 2>/dev/null | head -n 1)

$(OUT_DIR)/symbols.o: $(SYS_DIR)/symbols.S $(OUT_DIR)/entryother $(OUT_DIR)/initcode
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c -o $@ $<

# Kernel object files
$(OUT_DIR)/%.o: $(SYS_DIR)/%.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -I. -c -o $@ $<

# User object files
$(USER_DIR)/%.o: $(USER_DIR)/%.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c -o $@ $<

$(OUT_DIR)/xv6.img: $(OUT_DIR)/bootblock $(OUT_DIR)/vmunix $(OUT_DIR)/fs.img
	dd if=/dev/zero of=$(OUT_DIR)/xv6.img count=10000
	dd if=$(OUT_DIR)/bootblock of=$(OUT_DIR)/xv6.img conv=notrunc
	dd if=$(OUT_DIR)/vmunix of=$(OUT_DIR)/xv6.img seek=1 conv=notrunc

$(OUT_DIR)/vmunix: $(OBJS) $(OUT_DIR)/entry.o $(OUT_DIR)/entryother $(OUT_DIR)/initcode kernel.ld
	$(LD) $(LDFLAGS) -T kernel.ld -o $@ \
		$(OUT_DIR)/entry.o $(OBJS) \
		-b binary \
		$(OUT_DIR)/initcode \
		$(OUT_DIR)/entryother
	$(OBJDUMP) -S $@ > $(OUT_DIR)/kernel.asm
	$(OBJDUMP) -t $@ | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > $(OUT_DIR)/kernel.sym

$(OUT_DIR)/entry.o: $(SYS_DIR)/entry.S
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c -o $@ $<

$(OUT_DIR)/initcode: $(OUT_DIR)/initcode.o
	$(LD) $(LDFLAGS) -N -e start -Ttext 0 -o $(OUT_DIR)/initcode.out $<
	$(OBJCOPY) -S -O binary $(OUT_DIR)/initcode.out $@

$(OUT_DIR)/initcode.o: $(SYS_DIR)/initcode.S
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -nostdinc -I. -c -o $@ $<

$(OUT_DIR)/bootblock: $(SYS_DIR)/bootasm.S $(SYS_DIR)/bootmain.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -fno-pic -O -nostdinc -I. -c $(SYS_DIR)/bootmain.c -o $(OUT_DIR)/bootmain.o
	$(CC) $(CFLAGS) -fno-pic -nostdinc -I. -c $(SYS_DIR)/bootasm.S -o $(OUT_DIR)/bootasm.o
	$(LD) $(LDFLAGS) -N -e start -Ttext 0x7C00 -o $(OUT_DIR)/bootblock.o $(OUT_DIR)/bootasm.o $(OUT_DIR)/bootmain.o
	$(OBJDUMP) -S $(OUT_DIR)/bootblock.o > $(OUT_DIR)/bootblock.asm
	$(OBJCOPY) -S -O binary -j .text $(OUT_DIR)/bootblock.o $(OUT_DIR)/bootblock
	./sign.pl $(OUT_DIR)/bootblock

$(OUT_DIR)/entryother: $(SYS_DIR)/entryother.S
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -fno-pic -nostdinc -I. -c $< -o $(OUT_DIR)/entryother.o
	$(LD) $(LDFLAGS) -N -e start -Ttext 0x7000 -o $(OUT_DIR)/bootblockother.o $(OUT_DIR)/entryother.o
	$(OBJCOPY) -S -O binary -j .text $(OUT_DIR)/bootblockother.o $@
	$(OBJDUMP) -S $(OUT_DIR)/bootblockother.o > $(OUT_DIR)/entryother.a

$(OUT_DIR)/%.o: $(SYS_DIR)/%.S
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c -o $@ $<

ULIB = $(OUT_DIR)/ulib.o $(OUT_DIR)/usys.o $(OUT_DIR)/printf.o $(OUT_DIR)/umalloc.o

UPROGS = \
	$(OUT_DIR)/_basename \
	$(OUT_DIR)/_cat \
	$(OUT_DIR)/_clear \
	$(OUT_DIR)/_echo \
	$(OUT_DIR)/_date \
	$(OUT_DIR)/_getuid \
	$(OUT_DIR)/_grep \
	$(OUT_DIR)/_hostname \
	$(OUT_DIR)/_init \
	$(OUT_DIR)/_kill \
	$(OUT_DIR)/_ln \
	$(OUT_DIR)/_login \
	$(OUT_DIR)/_ls \
	$(OUT_DIR)/_mkdir \
	$(OUT_DIR)/_more \
	$(OUT_DIR)/_mv \
	$(OUT_DIR)/_nologin \
	$(OUT_DIR)/_pwd \
	$(OUT_DIR)/_reboot \
	$(OUT_DIR)/_rm \
	$(OUT_DIR)/_rmdir \
	$(OUT_DIR)/_sh \
	$(OUT_DIR)/_su \
	$(OUT_DIR)/_uname \
	$(OUT_DIR)/_uptime \
	$(OUT_DIR)/_wc \
	$(OUT_DIR)/_yes

$(OUT_DIR)/_%: $(USER_DIR)/%.o $(ULIB)
	@mkdir -p $(@D)
	$(LD) $(LDFLAGS) -N -e main -Ttext 0 -o $@ $^
	$(OBJDUMP) -S $@ > $(OUT_DIR)/$*.asm
	$(OBJDUMP) -t $@ | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > $(OUT_DIR)/$*.sym

$(OUT_DIR)/vectors.S: $(SYS_DIR)/vectors.pl
	@mkdir -p $(@D)
	perl $< > $@

$(OUT_DIR)/mkfs: $(SYS_DIR)/mkfs.c
	@mkdir -p $(@D)
	gcc -Wall -o $@ $<

$(OUT_DIR)/fs.img: $(OUT_DIR)/mkfs README $(UPROGS)
	@mkdir -p $(@D)
	cp README $(OUT_DIR)/README
	cd $(OUT_DIR) && \
	./mkfs fs.img README $(notdir $(UPROGS))

tags: $(OBJS) $(SYS_DIR)/entryother.S $(OUT_DIR)/_init
	etags $(SYS_DIR)/*.S $(SYS_DIR)/*.c $(USER_DIR)/*.c

clean: 
	rm -rf $(OUT_DIR)/*
	rm -f xv6.img $(OUT_DIR)/*.img
	rm -r ./user/*.d &
	rm -r ./user/*.o &
	rm -r ./sys/*.asm &

.PHONY: clean dist-test dist

# run in emulators

bochs : fs.img xv6.img
	if [ ! -e .bochsrc ]; then ln -s dot-bochsrc .bochsrc; fi
	bochs -q

# try to generate a unique GDB port
GDBPORT = $(shell expr `id -u` % 5000 + 25000)
# QEMU's gdb stub command line changed in 0.11
QEMUGDB = $(shell if $(QEMU) -help | grep -q '^-gdb'; \
	then echo "-gdb tcp::$(GDBPORT)"; \
	else echo "-s -p $(GDBPORT)"; fi)
ifndef CPUS
CPUS := 2
endif
QEMUOPTS = -accel kvm --no-reboot -drive file=$(OUT_DIR)/fs.img,index=1,media=disk,format=raw -drive file=$(OUT_DIR)/xv6.img,index=0,media=disk,format=raw -smp $(CPUS) -m 4 $(QEMUEXTRA)

qemu: $(OUT_DIR)/fs.img $(OUT_DIR)/xv6.img
#	$(QEMU) $(QEMUOPTS)
	$(QEMU) -serial mon:stdio $(QEMUOPTS)

qemu-memfs: $(OUT_DIR)/xv6memfs.img
	$(QEMU) -drive file=$(OUT_DIR)/xv6memfs.img,index=0,media=disk,format=raw -smp $(CPUS) -m 256

qemu-nox: $(OUT_DIR)/fs.img $(OUT_DIR)/xv6.img
	$(QEMU) -nographic $(QEMUOPTS)

.gdbinit: .gdbinit.tmpl
	sed "s/localhost:1234/localhost:$(GDBPORT)/" < $^ > $@

qemu-gdb: $(OUT_DIR)/fs.img $(OUT_DIR)/xv6.img .gdbinit
	@echo "*** Now run 'gdb'." 1>&2
	$(QEMU) -serial mon:stdio $(QEMUOPTS) -S $(QEMUGDB)

qemu-nox-gdb: $(OUT_DIR)/fs.img $(OUT_DIR)/xv6.img .gdbinit
	@echo "*** Now run 'gdb'." 1>&2
	$(QEMU) -nographic $(QEMUOPTS) -S $(QEMUGDB)
