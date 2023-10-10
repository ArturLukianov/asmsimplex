; hello.asm
section .data
  enterVarNum db "Enter number of variables: ", 0

	section .text
	global _start

; print.S
extern print
extern print_float
extern print_int
extern putchar
; memory.S
extern memcpy
extern malloc
extern free
; table.S
extern get_by_index
extern set_by_index
extern init_table
extern print_table

; input.S
extern read_float
extern read_int

%macro print 1
  push %1
  call print
  sub  rsp, 8
%endmacro
; simple.S
extern check_b_positive

_start:
  ; print enterVarNum
  ; call read_int
  ; call print_int

  ; jmp exit

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
  cmp r10, 3
  je input_table_next_row
  jmp input_table

input_table_next_row:
  inc r13
  xor r10, r10
  cmp r13, 3
  je input_table_end
  jmp input_table

input_table_end:

  call print_table

debug_simplex_label:
  mov rdi, 3
  call check_b_positive

exit:
	mov rax, 60
	mov rdi, 0
	syscall ; exit(0)
