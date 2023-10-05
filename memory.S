section .text
	global memcpy

;; memcpy(void* dst, void* src, uint64_t count)
;; > dst   (rdx)
;;   src   (rcx)
;;   count ([rbp-0x8])
memcpy:
	push rbp
	mov  rbp, rsp

	mov  rcx, [rbp+0x20]
	mov  [rbp-0x08], rcx
	mov  rcx, [rbp+0x18]
	mov  rdx, [rbp+0x10]
	xor  rax, rax
	memcpy_loop_begin:
	cmp  rax, 
	jge  memcpy_loop_end
	mov rbx, [rcx]
	mov [rdx], rbx
	inc rcx
	inc rdx
	inc rax
	memcpy_loop_end:
	ret