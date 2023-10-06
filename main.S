section .data
    msg     db "hello, world", 0Ah, 0
    msg2    db "HELLO, WORDL", 0Ah, 0
    ; SYS_READ equ 0
    ; SYS_WRITE equ 1
    ; SYS_EXIT equ 60

section .text
    global _start

extern print
extern readline
extern memcpy
extern get_by_index
extern set_by_index
extern set_table_size

_start:
    push msg
    call print

    call readline ; Call readline to read a line

    ; push line_buff
    call print

    mov rax, 60
    xor rdi, rdi
    syscall
