section .data
    format db "%.1f", 0
    some_float db "2.342145", 0
    integer times 4 db 0
    
section .bss
    line_buff RESB 8
    farray RESQ 100
    fvalue RESQ 1  ; reserve 1 quadword(4 bytes) for result | 
    char_buff RESB 100

section .text
    global readline
    global read_float
    global read_line_into_float
    extern scanf

extern strlen
extern malloc
extern free
extern memcpy
extern memcpy_reverse
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
    push 80
	call malloc
    ; mov rbx, rax
    fld QWORD [rax]         ; loading float point value into the stack
nextchar:
    ; reading one char
    mov rax, 0              ; read
    mov rdi, 0              ; stdin
    mov rsi, char_buff      ; buff
    mov rdx, 1              ; only 1 char
    syscall

    ; check if it's line feed
    mov rax, [char_buff]
    cmp rax, 0Ah
    je finished

    ; check if it's space
    cmp rax, 20h
    je char_space

    ; check if it's dot
    cmp rax, 2eh
    je char_dot
    ; check if it's minus
    cmp rax, 2dh
    je char_minus

    ; GET INT FROM ASCII
    sub rax, '0'
    ; mov fvalue, rax
    ; fld fvalue
    ; movss xmm0, [fvalue]
    inc rsi
    jmp nextchar
char_space:
    jmp put_into_array
    inc r8
    inc rsi
    jmp nextchar
put_into_array:
    mov QWORD [farray + r8*4 + r9], char_buff  ; [base offset + base addr of next element + next number] = char_buff[some index:)]
    ret
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
