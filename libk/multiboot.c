#include <multiboot.h>

struct multiboot_info multiboot_information;

void load_multiboot_information(struct multiboot_info *address)
{
	multiboot_information = *address;
}
