hello: hello.o print.o
	ld -o hello hello.o print.o -no-pie -s -nostdlib --gc-sections -z noseparate-code
hello.o: hello.asm
	nasm -f elf64 hello.asm -l hello.lst
print.o: print.asm
	nasm -f elf64 print.asm -l print.lst