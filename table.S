section .bss
  table resq 1 ; Pointer to table (it takes less mem to save it here than to use .bss segment)
  rows_count resq 1 
  columns_count resq 1
  
section .text
  global get_by_index
  global set_by_index
  global init_table
  global print_table

extern malloc

extern putchar
extern print_float

;; Initialize table 
;; > columns_count
;;   rows_count
init_table:
  push rbp
  mov rbp, rsp
  mov rax, [rbp+0x10] ; Column count
  mov rbx, [rbp+0x18] ; Row count

  mov [columns_count], rax
  mov [rows_count], rbx

  imul rax, rbx
  push rax
  call malloc
  mov [table], rax

  mov rsp, rbp
  pop rbp
  ret

;; Get data in table by index
;; > column
;;   row
get_by_index:
  push rbp
  mov rbp, rsp
	mov rax, [rbp+0x10] ; Column
	mov rbx, [rbp+0x18] ; Row

  mov r12, [table] ; Load table address

  mov rdx, [columns_count]
  imul rbx, rdx
  add rbx, rax

  mov rax, [r12 + rbx * 8]; rax = *(table + (row * columns_count) * 8 + column)

  mov rsp, rbp
  pop rbp
  ret

;; Set data in table 
;; > value
;;   column
;;   row
set_by_index:
  push rbp
  mov rbp, rsp
	mov rcx, [rbp+0x10] ; Value
	mov rax, [rbp+0x18] ; Column
	mov rbx, [rbp+0x20] ; Row

  mov r12, [table] ; Load table address

  mov rdx, [columns_count]
  imul rbx, rdx
  add rbx, rax

  mov [r12 + rbx * 8], rcx

  mov rsp, rbp
  pop rbp
  ret

print_table:
  push rbp
  mov rbp, rsp

  ; for (int i = 0; i < 3; i ++) {
  ;   for (int j = 0; j < 3; j ++) {
  ;     print_float(get_by_index(i, j))
  ;     putchar(' ')
  ;   }
  ;   putchar('\n')

  ; Init i = 0
  xor r8, r8
  print_table_print_row_begin:
  cmp r8b, 3
  je print_table_end
  
    xor r9, r9
    print_table_print_cell_begin:
    cmp r9b, 3
    je print_table_print_cell_end

      push r9
      push r8
      call get_by_index
      pop  r8
      pop  r9

      push r9
      push r8
      push rax
      call print_float
      pop  rax
      pop  r8
      pop  r9

      mov rax, 20h
      call putchar
      inc r9b
    jmp print_table_print_cell_begin
    print_table_print_cell_end:

  mov rax, 0Ah
  call putchar
  inc r8b
  jmp print_table_print_row_begin
  print_table_end:

  mov rsp, rbp
  pop rbp
  ret