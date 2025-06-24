/* Set the sysinit function as the elf binary entry point */

ENTRY(sysinit)

/* Define kernel image placement */

SECTIONS {
	/* BIOS standards raccomend to place the image at 1M
	 * However UEFI seems to throw all that out the window
	 * so we use 2M */ 

	. = 2M;
	
	/* We align the sections on 4K pages */

	.text BLOCK(4K) : ALIGN(4K)
	{
		*(.multiboot_header)
		*(.text)
	}

	.rodata BLOCK(4K) : ALIGN(4K)
	{
		*(.rodata)
	}

	.data BLOCK(4K) : ALIGN(4K)
	{
		*(.data)
	}
	
	.bss BLOCK(4K) : ALIGN(4K)
	{
		*(.bss)
	}
}
