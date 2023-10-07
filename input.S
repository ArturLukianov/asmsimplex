section .bss
    line_buff resb 8
    farray resq 100

section .text
    global readline
    global read_n_float

;; Read untill '\n'
;; writes result string in rax
readline:
    push rbp
    mov rbp, rsp

    mov rax, 0          ; read
    mov rdx, 512        ; size_t count | 512 - randomly picked value 
    mov rdi, 0          ; STDIN 
    mov rsi, line_buff  ; char *buf
    syscall

    mov rax, line_buff  ; saving it
    pop rbp
    ret


read_n_float:
    push
