section .data
    format db "%.1f", 0
    some_float db "2.342145", 0
    integer times 4 db 0
    
section .bss
    line_buff resb 8
    farray resq 100
    char_buff resb 100
    res resq 1  ; reserve 1 quadword(4 bytes) for result | 

section .text
    global readline
    global read_float
    global read_line_into_float
    extern scanf


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

; reading string and then converting all ascii -> int -> double
read_line_into_float:
    push rbp
    mov rbp, rsp
nextchar:
    ; reading one char
    mov rax, 0              ; read
    mov rdi, 0              ; stdin
    mov rsi, char_buff      ; buff
    mov rdx, 1              ; only 1 char
    syscall

    ; check if it's line feed
    mov al, [char_buff]
    cmp al, 0Ah
    je finished

    ; check if it's space
    cmp al, 20h
    je char_space

    ; check if it's dot
    cmp al, 2eh
    je char_dot
    ; check if it's minus
    cmp al, 2dh
    je char_minus

    inc rsi
    jmp nextchar
char_space:
    inc r8
    inc rsi
    jmp nextchar
put_into_array:
    mov [farray + r8*4 + r9], char_buff  ; base offset + base addr of next element + next number
    jmp nextchar
char_dot:
    mov r8, -1
    jmp nextchar
char_minus:
    fchs                ; change the sign
    jmp nextchar
finished:
    pop rbp
    ret

int_to_float:
    push rbp
    mov rbp, rsp

    pop rbp
    ret
