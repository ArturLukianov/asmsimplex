section .bss
  table resq 100 * 100
  rows_count resq 1
  columns_count resq 1
  
section .text
  global get_by_index
  global set_by_index


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

  mov rcx, [table + rbx * 8]

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
	mov rbx, [rbp+0x10] ; Value
	mov rax, [rbp+0x18] ; Column
	mov rcx, [rbp+0x20] ; Row

  mov rdx, [columns_count]
  imul rbx, rdx

  mov [table + rbx * 8], rcx

  mov rsp, rbp
  pop rbp
  ret
