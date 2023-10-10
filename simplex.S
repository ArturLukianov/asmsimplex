section .data
  error_message db 'Assertion failed: mat[i][0] >= 0', 0

section .text
  global check_b_positive
extern printf, exit
extern get_by_index

; void check_b_positive(int m) rdi = m
check_b_positive:

  ; mov rax, rdi        ; Copy m to rax
  ; mov rdi, rsi      ; Copy mat to rdi

  xor rcx, rcx        ; Initialize loop counter (i)
  xor r8, r8
check_loop:
  cmp rcx, rdi        ; Compare i with m
  jge check_done      ; Jump to check_done if i >= m
  push rcx
  push r8
  call get_by_index
  pop  r8
  pop  rcx

  movq xmm0, rax  ; Load mat[i][0] into xmm0

  compps xmm0, xmm0    ; Test if mat[i][0] is less than 0
  jl assertion_failed ; Jump to assertion_failed if mat[i][0] < 0

  inc rcx             ; Increment loop counter (i)
  jmp check_loop      ; Jump back to check_loop

check_done:
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
