section .text
    global ft_write
    extern __errno_location

ft_write:

    mov rax, 0x1                        ; syscall write
    syscall                             ; params already in order, calling syscall

    cmp rax, 0                          ; checks if return of rax with 0
    jge .return                         ; if rax >= 0, no error goto return

    ; error handler
    neg rax                             ; save the error code (negative value)
    mov rdi, rax
    call __errno_location WRT ..plt     ; call errno_location external function
    mov [rax], rdi
    mov rax, -1                         ; set return value to -1 (error indicator)

.return:
    ret
