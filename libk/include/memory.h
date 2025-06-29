#ifndef LIBK_MEMORY_H
#define LIBK_MEMORY_H 1	

#include <portability.h>
#include <stdint.h>

/* Indicates the amount of available memory in KB
 * before the first memory hole */
struct memory_amounts {
	uint32_t lower, upper;
};

/* Each entry indicates a memory block */
struct memory_map_entry {
	uint32_t size;
	uint64_t addr;
	uint64_t len;
/* Using an enum might create issues on struct sizes */
#define MEMORY_CHUNK_AVAILABLE	1
#define MEMORY_CHUNK_RESERVED	2
#define MEMORY_CHUNK_ACPI	3 
#define MEMORY_CHUNK_NVS	4
#define MEMORY_CHUNK_BAD	5
	uint32_t type;
} ATTRIBUTES(packed);

struct memory_map {
	uint32_t len;
	struct memory_map_entry *entry;
};

#endif
