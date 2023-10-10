section .bss
  table resq 1 ; Pointer to table (it takes less mem to save it here than to use .bss segment)
  rows_count resq 1 
  columns_count resq 1
  
section .text
  global get_by_index
  global set_by_index
  global init_table

extern malloc

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
  shr rbx, 3
  add rbx, rax

  mov rax, [r12 + rbx]; rax = *(table + (row * columns_count) * 8 + column)

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
  shr rbx, 3
  add rbx, rax

  mov [r12 + rbx], rcx

  mov rsp, rbp
  pop rbp
  ret
