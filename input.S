section .bss
    line_buff resb 256 ; reserving 100 bytes for buffer

section .text
    global readline

readline:
    push rbp
    mov rbp, rsp

    mov rax, 0          ; read
    mov rdx, 256        ; size_t count
    mov rdi, 0          ; STDIN
    mov rsi, line_buff  ; char *buf
    syscall

    mov rax, line_buff  ; saving it
    pop rbp
    ret
