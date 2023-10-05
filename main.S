; hello.asm
	section .data
	msg     db "hello, world", 0Ah, 0

	section .text
	global _start

extern print

_start:
	push msg
	call print
	mov rax, 60
	mov rdi, 0
	syscall
