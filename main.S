; hello.asm
	section .data
	msg     db "hello, world", 0Ah, 0

	section .text
	global _start

extern print
extern get_by_index
extern set_by_index

_start:
  push 0
  push 0
  call get_by_index

  push 0
  push 0
  push 100
  call set_by_index

  push 0
  push 0
  call get_by_index

	push msg
	call print

	mov rax, 60
	mov rdi, 0
	syscall