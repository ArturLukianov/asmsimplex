section .bss
    line_buff resb 100 ; reserving 100 bytes for buffer

section .text
    global readline

readline:
    push rbp
    mov rbp, rsp
nextchar:
    mov rax, 0
    mov rdx, 1         ; size_t count
    mov rdi, 0         ; STDIN
    mov rsi, line_buff ; char *buf
    syscall

    ; Check if the read character is a newline
    mov al, [line_buff]
    cmp al, 0Ah
    je  end_of_line
    
    ; Move to the next character in the buffer
    inc rsi 
    jmp nextchar
end_of_line:
    mov byte [rsi], 0 ; Null-terminate the string
    mov rax, rsi
    pop rbp
    ret
