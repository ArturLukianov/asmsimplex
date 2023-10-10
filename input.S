section .text
    global read_float

extern strlen
extern malloc
extern free
extern memcpy
extern memcpy_reverse

;; Read float from stdin to RAX
read_float:
    push rbp
    mov rbp, rsp

    fldz

integer_part_input: ; Input part before dot (integer part)
    sub rsp, 0x8
    xor rax, rax          
    xor rdi, rdi           
    mov rsi, rsp      
    xor rdx, rdx
    inc rdx
    syscall ; read(stdin, buff, 1)

    pop r12

    ; check if it's line feed
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

char_dot: ; If we found dot, switch to inputing decimal part
    xor r9, r9
    inc r9

    jmp fractional_part_input

char_minus: ;; TODO: now forces to have minus after number, not before
    fchs                ; change the sign
    jmp integer_part_input

fractional_part_input: ; Input the part after the dot
    sub rsp, 0x8
    xor rax, rax          
    xor rdi, rdi           
    mov rsi, rsp      
    xor rdx, rdx
    inc rdx
    syscall ; read(stdin, buff, 1)

    ; check if it's line feed
    pop r12
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
