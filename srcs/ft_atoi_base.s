section .text
    global get_base_length
    global check_errors
    ; global get_nb
    global ft_atoi_base

get_base_length:
    ; Input: rdi = base (char *)
    ; Output: rax = base_length (int)
    xor rax, rax          ; base_length = 0
.loop_base_length:
    movzx rbx, byte [rsi + rax] ; load base[base_length]
    test rbx, rbx        ; check if base[base_length] == '\0'
    jz .check_length
    cmp rbx, '-'         ; check for '-'
    je .return_zero
    cmp rbx, '+'         ; check for '+'
    je .return_zero
    cmp rbx, ' '         ; check for whitespace
    je .return_zero
    cmp rbx, '\t'
    je .return_zero
    cmp rbx, '\r'
    je .return_zero
    cmp rbx, '\n'
    je .return_zero
    cmp rbx, '\v'
    je .return_zero
    cmp rbx, '\f'
    je .return_zero
    mov rcx, rax         ; j = base_length + 1
    inc rcx
.loop_inner:
    movzx rdx, byte [rsi + rcx] ; load base[j]
    test rdx, rdx        ; check if base[j] == '\0'
    jz .next_base_length
    cmp rbx, rdx         ; check if base[base_length] == base[j]
    je .return_zero
    inc rcx
    jmp .loop_inner
.next_base_length:
    inc rax               ; base_length++
    jmp .loop_base_length
.check_length:
    cmp rax, 2           ; check if base_length < 2
    jl .return_zero
.return_base_length:
    ret
.return_zero:
    xor rax, rax         ; return 0
    ret

get_nb:
    ; Input: rdi = c (char), rsi = base (char *)
    ; Output: rax = index (int)
    xor rax, rax          ; i = 0
.loop_get_nb:
    movzx r14, byte [rsi + rax] ; load base[i]
    test r14, r14        ; check if base[i] == '\0'
    jz .return_error
    cmp r14, rdi         ; check if base[i] == c
    je .return_index
    inc rax               ; i++
    jmp .loop_get_nb
.return_index:
    ret
.return_error:
    mov rax, -1         ; return -1
    ret

ft_atoi_base:
    ; Input: rdi = str (char *), rsi = base (char *)
    ; Output: rax = result (int)

    ; check errors here
    test rdi, rdi        ; check if str == NULL
    jz .return_zero_error
    test rsi, rsi        ; check if base == NULL
    jz .return_zero_error

    call get_base_length
    cmp rax, 0        ; check if base_length == 0
    jz .return_zero_error
    mov r9, rax         ; base_length
    xor rax, rax         ; start = 0
.loop_skip_whitespace:
    movzx rcx, byte [rdi + rax]
    test rcx, rcx        ; check if str[start] == '\0'
    jz .process_sign
    cmp rcx, ' '         ; check for whitespace
    je .increment_s
    cmp rcx, '\t'
    je .increment_s
    cmp rcx, '\r'
    je .increment_s
    cmp rcx, '\n'
    je .increment_s
    cmp rcx, '\v'
    je .increment_s
    cmp rcx, '\f'
    je .increment_s
    jmp .process_sign
.increment_s:
    inc rax               ; start++
    jmp .loop_skip_whitespace
.process_sign:
    dec rax
    mov rcx, rax         ; i = start
    xor rdx, rdx         ; result = 0, convet base calculation
    mov r8, 1            ; negative = 1
.loop_atoi:
    inc rcx               ; i++
    movzx rbx, byte [rdi + rcx]
    test rbx, rbx        ; check if str[i] == '\0'
    jz .return_result_final
    cmp rbx, '-'         ; check for '-'
    je .set_negative
    cmp rbx, '+'         ; check for '+'
    je .set_positive
    push rdi
    mov rdi, rbx
    call get_nb          ; get_nb(str[i], base)
    cmp rax, -1          ; check if get_nb == -1
    je .return_zero_final
    pop rdi
    imul rdx, r9        ; result = result * base_length
    add rdx, rax         ; resilt += get_nb
.next_atoi:
    jmp .loop_atoi

.set_positive:
    mov r8, 1           ; negative = 1
    jmp .next_atoi
.set_negative:
    neg r8           ; negative = -1
    jmp .next_atoi
.return_result_final:
    imul rdx, r8
    mov rax, rdx         ; return res * negative
    ret
.return_zero_error:
    xor rax, rax         ; return 0
    ret
.return_zero_final:
    pop rdi
    xor rax, rax         ; return 0
    ret