; hello.asm
section .data
  enterVarNum   db "Enter number of variables: ", 0
  enterConNum   db "Enter number of constraints: ", 0
  enterConCoeff db "Enter the constraints' coefficients:", 0Ah, 0
  enterVarCoeff db "Enter the variables' coefficients:", 0Ah, 0
  enterConB     db "Enter the constraints' B:", 0Ah, 0

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
extern set_var_num
extern set_con_num
extern input_table_1
extern input_table_2
extern input_table_3
extern find_pivot_column
extern find_pivot_row

; input.S
extern read_float
extern read_int

%macro print 1
  push %1
  call print
  add  rsp, 8
%endmacro
; simple.S
extern check_b_positive

_start:
  print enterVarNum
  call read_int
  call set_var_num

  print enterConNum
  call read_int
  call set_con_num

  call init_table

  print enterConCoeff
  call input_table_1

  print enterConB
  call input_table_2

  print enterVarCoeff
  call input_table_3

  call print_table

  mov rdi, 3
  call check_b_positive
  ; mov rdi, 3
  ; call check_b_positive
  ; call find_pivot_column
  mov rdi, 3
  mov rsi, 3
  mov rdx, 3
  call find_pivot_row
  call print_int

exit:
	mov rax, 60
	mov rdi, 0
	syscall ; exit(0)
