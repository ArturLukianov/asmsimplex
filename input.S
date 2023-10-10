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

    fldz

integer_part_input:
    xor rax, rax          
    xor rdi, rdi           
    mov rsi, char_buff      
    xor rdx, rdx
    inc rdx
    syscall ; read(stdin, buff, 1)

    xor r12, r12

    ; check if it's line feed
    mov r12b, byte [char_buff]
    cmp r12b, 0Ah
    je read_line_into_float_end

    ; check if it's space
    cmp r12b, 20h
    je read_line_into_float_end

    ; check if it's dot
    cmp r12b, 2eh
    je char_dot

    ; check if it's minus
    cmp r12b, 2dh
    je char_minus

    ; Process digit
    push 10
    fild QWORD [rsp]
    fmulp 

    ; Get digit from ASCII
    sub r12b, '0'

    push r12
    fild QWORD [rsp]
    faddp

    inc rsi
    jmp integer_part_input

char_dot:
    xor r9, r9
    inc r9

    jmp fractional_part_input

char_minus:
    fchs                ; change the sign
    jmp integer_part_input

fractional_part_input: ; Input the part after the dot
    xor rax, rax          
    xor rdi, rdi           
    mov rsi, char_buff      
    xor rdx, rdx
    inc rdx
    syscall ; read(stdin, buff, 1)

    ; check if it's line feed
    mov r12b, byte [char_buff]
    cmp r12b, 0Ah
    je fractional_part_input_end

    ; check if it's space
    cmp r12b, 20h
    je fractional_part_input_end

    sub r12b, '0'
    push QWORD 10
    fild QWORD [rsp]
    fmulp

    push r12
    fild QWORD [rsp]
    faddp

    imul r9, QWORD 10

    jmp fractional_part_input

fractional_part_input_end:
    push r9
    fild QWORD [rsp]
    fdivp

read_line_into_float_end:
    fstp QWORD [rsp]
    pop rax

    mov rsp, rbp
    pop rbp
    ret

    mov rax, r12

    push rbp
    mov rbp, rsp

    pop rbp
    ret
