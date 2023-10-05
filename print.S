section .text
	global print

extern strlen

print:
	call strlen
	mov rdi, 1         ; stdout
	mov rsi, [rsp+8]   ; buffer
	mov rdx, rax       ; size
	mov rax, 1         ; write
	syscall
	ret