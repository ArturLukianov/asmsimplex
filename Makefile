main: main.o print.o strings.o table.o
	ld -o main main.o print.o strings.o table.o -no-pie -s -nostdlib --gc-sections -z noseparate-code
main.o: main.S
	nasm -f elf64 main.S -l main.lst
print.o: print.S
	nasm -f elf64 print.S -l print.lst
strings.o: strings.S
	nasm -f elf64 strings.S -l strings.lst
table.o: table.S
	nasm -f elf64 table.S -l table.lst
memory.o: memory.S
	nasm -f elf64 memory.S -l memory.lst
