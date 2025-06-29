#ifndef LIBK_VIDEO_H
#define LIBK_VIDEO_H 1

/* TODO: Properly document the structs in this header
 * For now refer to https://www.gnu.org/software/grub/manual/multiboot/multiboot.html#Boot-information-format
 */

struct vbe_table {
	uint32_t control_info;
	uint32_t mode_info;
	uint16_t mode;
	uint16_t interface_seg;
	uint16_t interface_off;
	uint16_t interface_len;
};

struct framebuffer_palette_colors {
	uint8_t red, green, blue;
};

struct framebuffer_color_palette {
	struct framebuffer_palette_colors *addr;
	uint16_t num_colors;
};

struct framebuffer_rgb_colors {
	uint8_t red_field_pos;
	uint8_t red_field_size;
	uint8_t green_field_pos;
	uint8_t green_field_size;
	uint8_t blue_field_pos;
	uint8_t blue_field_size;
};

union framebuffer_color_information {
	struct framebuffer_color_palette palette;
	struct framebuffer_rgb_colors rgb;
};

struct framebuffer {
	uint64_t addr;
	uint32_t pitch;
	uint32_t width;
	uint32_t height;
	uint8_t bpp;
	uint8_t type;
	union framebuffer_color_information color_info;	
};

#endif
