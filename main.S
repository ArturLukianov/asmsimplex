; hello.asm
	section .data
	msg     db "hello, world", 0Ah, 0

	section .text
	global _start

extern print

extern memcpy
extern malloc
extern free

extern get_by_index
extern set_by_index
extern set_table_size

_start:
  ; push 10
  ; push 10
  ; call set_table_size

  ; push 0
  ; push 0
  ; call get_by_index

  ; push 0
  ; push 0
  ; push 100
  ; call set_by_index

  ; push 0
  ; push 0
  ; call get_by_index

  push 16
  call malloc

  push 5
  push msg
  push rax
  call memcpy

  pop  rax
  push rax
	push rax
	call print

  pop rax
  call free

	mov rax, 60
	mov rdi, 0
	syscall
