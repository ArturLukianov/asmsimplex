; hello.asm
	section .text
	global _start

extern print
extern print_float
extern putchar

extern memcpy
extern malloc
extern free

extern get_by_index
extern set_by_index
extern init_table
extern print_table

extern read_float

_start:
  push 3
  push 3
  call init_table

  xor r10, r10
  xor r13, r13

;; Input format:
; C
; x1
; xN
; z
input_table:
  call read_float

  push r10
  push r13
  push rax
  call set_by_index

  inc r10
  test r10, 3
  jz input_table_next_row
  jmp input_table

input_table_next_row:
  inc r13
  test r10, 3
  jz input_table_end
  jmp input_table

input_table_end:

  call print_table

	mov rax, 60
	mov rdi, 0
	syscall ; exit(0)
