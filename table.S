section .bss
  table resq 1 ; Pointer to table (it takes less mem to save it here than to use .bss segment)
  rows_count resq 1 
  columns_count resq 1
  var_num resq 1    ; Number of variables
  con_num resq 1    ; Number of constraints
  
section .text
  global get_by_index
  global set_by_index
  global init_table
  global print_table
  global set_var_num
  global set_con_num
  global input_table_1
  global input_table_2
  global input_table_3

extern malloc

extern putchar
extern print_float

extern read_float

%macro prologue 0
  push rbp
  mov  rbp, rsp
%endmacro

%macro epilogue 0
  mov  rsp, rbp
  pop  rbp
  ret
%endmacro

;; Initialize table 
;; > columns_count
;;   rows_count
init_table:
  push rbp
  mov rbp, rsp
  ; mov rax, [rbp+0x10] ; Column count
  ; mov rbx, [rbp+0x18] ; Row count

  mov rax, [var_num]
  mov rbx, [con_num]
  lea rax, [rax+rbx+2]
  add rbx, 1

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
  cmp r8b, [rows_count]
  je print_table_end
  
    xor r9, r9
    print_table_print_cell_begin:
    cmp r9b, [columns_count]
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

;; void set_var_num(n: rax)
set_var_num:
  mov [var_num], rax
  ret

;; void set_con_num(n: rax)
set_con_num:
  mov [con_num], rax
  ret

;; void input_table_1()
input_table_1:
  prologue

  xor r10, r10
  xor r13, r13

; ;; Input format:
; ; C
; ; x1
; ; xN
; ; z
  input_table_A:
    call read_float
    push r10
    push r13
    push rax
    call set_by_index

    inc r10
    cmp r10, [var_num]
    je input_table_A_next_row
    jmp input_table_A

  input_table_A_next_row:
    inc r13
    xor r10, r10
    cmp r13, [con_num]
    je input_table_A_end
    jmp input_table_A

  input_table_A_end:

  ; S Identity
  xor r10, r10
  input_table_S:
    mov r11, r10
    add r11, [var_num]
    push r11
    push r10
    mov  rax, 0x3ff0000000000000
    push rax
    call set_by_index
    pop  r11
    pop  r10
    pop  r11
    inc  r10
    cmp  r10, [con_num]
    jne input_table_S
  
  inc r11
  mov  rax, 0x3ff0000000000000
  push r11
  push r10
  push rax
  call set_by_index

  epilogue

input_table_2:
  prologue

  xor r10, r10
  input_table_B:
    push r10
    call read_float
    pop r10
    mov r11, 1
    add r11, [var_num]
    add r11, [con_num]
    push r11
    push r10
    push rax
    call set_by_index
    pop  rax
    pop  r10
    pop  r11

    inc r10
    cmp r10, [con_num]
    jne input_table_B

  epilogue

input_table_3:
  prologue

  xor r10, r10
  input_table_C:
    push r10
    call read_float
    pop  r10

    mov r11, 0
    add r11, [con_num]
    push r10
    push r11
    push rax
    call set_by_index
    pop  rax
    pop  r11
    pop  r10

    inc r10
    cmp r10, [var_num]
    jne input_table_C

  epilogue