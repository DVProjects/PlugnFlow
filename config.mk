ARCH := i386
AS := nasm
LD := $(ARCH)-elf-ld
CC := $(ARCH)-elf-gcc
QEMU := qemu-system-$(ARCH)

AS_FLAGS := -f elf32
C_FLAGS	:= -Wall
QEMU_FLAGS := -monitor stdio

OBJ_DIR := obj
ROOT_DIR := root

LINK_SCRIPT := link.ld
KERNEL := $(OBJ_DIR)/kernel.bin
ISO := PlugnFlow.iso
