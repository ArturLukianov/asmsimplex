hello: hello.o
	ld -o hello hello.o -no-pie -s -nostdlib --gc-sections
	strip --remove-section=.note.gnu.property hello
hello.o: hello.asm
	nasm -f elf64 hello.asm -l hello.lst
