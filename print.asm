section .text
	global print

strlen:
	add rsp, 8
	mov rax, [rsp+8]
	strlen_beginloop:
	cmp byte [rax], 0
	je  strlen_endloop
	inc rax
	jmp strlen_beginloop
	strlen_endloop:
	sub rax, [rsp+8]
	sub rsp, 8
	ret 

print:
	call strlen
	mov rdi, 1         ; stdout
	mov rsi, [rsp+8]   ; buffer
	mov rdx, rax       ; size
	mov rax, 1         ; write
	syscall
	ret