section .bss
  table resq 100 * 100 ;; array of 100*100 reals
  rows_count resq 1
  columns_count resq 1
  
section .text
  global get_by_index
  global set_by_index
  global set_table_size


;; Initialize table size
;; > columns_count
;;   rows_count
set_table_size:
  push rbp
  mov rbp, rsp
  mov rax, [rbp+0x10] ; Column count
  mov rbx, [rbp+0x18] ; Row count

  mov [columns_count], rax
  mov [rows_count], rbx

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

  mov rdx, [columns_count]
  imul rbx, rdx
  shr rbx, 3
  add rbx, rax

  mov rax, [table + rbx]; rax = *(table + (row * columns_count) * 8 + column)

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

  mov rdx, [columns_count]
  imul rbx, rdx
  shr rbx, 3
  add rbx, rax

  mov [table + rbx], rcx

  mov rsp, rbp
  pop rbp
  ret
