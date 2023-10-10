section .data
  error_message db 'Assertion failed: mat[i][0] >= 0', 0
  FLOAT_ZERO: dq 0.0

section .text
  global check_b_positive
extern get_by_index
extern print_float

%macro prologue 0
  push rbp
  mov  rbp, rsp
%endmacro

%macro epilogue 0
  mov  rsp, rbp
  pop  rbp
  ret
%endmacro

; void check_b_positive(int m) rdi = m
check_b_positive:
  push rbp
  push r9
  mov rbp, rsp
  ; mov rax, rdi        ; Copy m to rax
  ; mov rdi, rsi      ; Copy mat to rdi

  xor rcx, rcx        ; Initialize loop counter (i)
  xor r8, r8
  ; fld1
  ; xor st0, st0
  ; fld qword [r9]
check_loop:
  cmp rcx, rdi        ; Compare i with m
  jge check_done      ; Jump to check_done if i >= m
  push rcx
  push r8
  call get_by_index
  pop  r8
  pop  rcx
  
  mov [rbp+0x10], rax   ; r9 = table[i][0]
  fld QWORD [rbp+0x10]  ; Load table[i][0] into st0
  fld QWORD [FLOAT_ZERO] ; loading zero

  fcom     ; test if st0 > st1 | st0
  jg assertion_failed ; Jump to assertion_failed if table[i][0] < 0

  inc rcx             ; Increment loop counter (i)
  jmp check_loop      ; Jump back to check_loop

check_done:
  pop r9
  pop rbp
  ret

assertion_failed:
    ; Print error message
  mov rax, 1           ; System call number for sys_write
  mov rdi, 1           ; File descriptor 1 (stdout)
  mov rsi, error_message
  mov rdx, 30          ; Length of the error message
  syscall

  ; Exit program
  mov rax, 60          ; System call number for sys_exit
  xor rdi, rdi         ; Exit code 0
  syscall