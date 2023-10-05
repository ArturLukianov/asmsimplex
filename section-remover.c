#include <linux/types.h>
#include <stdio.h>

typedef __u64	Elf64_Addr;
typedef __u16	Elf64_Half;
typedef __s16	Elf64_SHalf;
typedef __u64	Elf64_Off;
typedef __s32	Elf64_Sword;
typedef __u32	Elf64_Word;
typedef __u64	Elf64_Xword;
typedef __s64	Elf64_Sxword;

int main(int argc, char** argv) {
	if (argc != 2) {
		printf("Usage: %s <filename>\n", argv[0]);
		return -1;
	}

	// FILE* file = fopen()

	return 0;
}