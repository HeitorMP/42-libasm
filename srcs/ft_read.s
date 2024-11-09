
;   ssize_t read(int fd, void *buf, size_t count);
;	rdi = fd
;	rsi = buf
;	rdx = count

section .text
    global ft_read
    extern __errno_location

ft_read:

    mov rax, 0                          ; syscall write
    syscall                             ; params already in order, calling syscall
    
    cmp rax, 0                          ; checks if return of rax with 0
    jge .return                         ; if rax >= 0, no error goto return

    ;error handler
    neg rax
    mov rdi, rax                        ; rdi = rax(erro code)
    call __errno_location WRT ..plt     ; call errno_location external function, errno now is set but rax is changed to
    mov [rax], rdi                      ; move the value in rdi to rax now rax has the original return
    mov rax, -1                           

.return:
    ret