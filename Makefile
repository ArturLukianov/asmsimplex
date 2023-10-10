main: main.o print.o strings.o table.o memory.o input.o simplex.o
# 	ld -o main main.o print.o strings.o table.o memory.o input.o -no-pie -s -nostdlib --gc-sections -z noseparate-code
	ld -o main main.o print.o strings.o table.o memory.o input.o simplex.o
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
input.o: input.S
	nasm -f elf64 input.S -l input.lst
simplex.o: simplex.S
	nasm -f elf64 simplex.S -l simplex.lst