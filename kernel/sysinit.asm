; Import multiboot relevant macros
%include "multiboot.inc"

section .bss
align 16
tmpstack_bottom:
resb 1024		; 1 KiB to use before correct stack initialization
tmpstack_top:

; Declare constants for the multiboot header
MULTIBOOT_HEADER_FLAGS equ MULTIBOOT_PAGE_ALIGN	; Will add other flags 
MULTIBOOT_CHECKSUM equ -(MULTIBOOT_HEADER_FLAGS + MULTIBOOT_HEADER_MAGIC)

; Multiboot searches in the first 8 KiB of the kernel image looking for the 
; magic value 0X1BADB002 and looks for the checksum such as:
; CHECKSUM + MAGIC + FLAGS = 0

; Define the header needed for the multiboot standard
section .multiboot_header
align 4
	dd MULTIBOOT_HEADER_MAGIC
	dd MULTIBOOT_HEADER_FLAGS
	dd MULTIBOOT_CHECKSUM
        dd 0            ; header_addr   (unused)
        dd 0            ; load_addr     (unused)
        dd 0            ; load_end_addr (unused)
        dd 0            ; bss_end_addr  (unused)
        dd 0            ; entry_addr    (unused)
        dd 0            ; mode_type	(unused)
        dd 0            ; width		(unused)
        dd 0            ; height	(unused)
        dd 0            ; depth 	(unused)


section .text
global sysinit:function (sysinit.end - sysinit)
sysinit:
	; The current machine state:
	; EAX = 0X2BADB002
	; EBX is the addressof the multiboot info structure
	; CS, DS, ES, FS, GS, SS are all valid segments from 0 to 0xFFFFFFFF
	; A20 gate is enabled
	; CR0 bit 0 set, bit 31 (PG) cleared
	; EFLAGS bit 9 and bit 17 are cleared
	; GDTR needs to be set by the kernel
	; IDTR needs to be set by the kernel

	; To check the multiboot info struct 
	; mov edx, [ebx + offset]
	; hlt

.hang:
	hlt
	jmp .hang	; In case of interrupt
.end:
