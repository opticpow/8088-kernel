# Makefile for Wayne's Kernel Bootloader

AS_TARGETS = boot_sect.bin
IMG_TARGETS = boot.img
TARGETS = $(AS_TARGETS) $(IMG_TARGETS)
SRCDIR = src
EMULATOR_PATH = ~/8086tiny

ASFLAGS =-f bin

%.bin : $(SRCDIR)/%.asm; nasm $(ASFLAGS) -o $@ $<

all: $(IMG_TARGETS)

asm: $(AS_TARGETS)

boot.img: boot_sect.bin 
	dd if=/dev/zero of=$@ bs=512 count=2880
	dd status=noxfer conv=notrunc if=$< of=$@

clean:
	rm -f $(TARGETS)

run: $(IMG_TARGETS)
	$(EMULATOR_PATH)/8086tiny $(EMULATOR_PATH)/bios $<
	@echo
	@echo




