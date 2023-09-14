hello: hello.o
	ld -o hello hello.o -no-pie -s -nostdlib --gc-sections -z noseparate-code
hello.o: hello.asm
	nasm -f elf64 hello.asm -l hello.lst
