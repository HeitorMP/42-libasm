section .text

global ft_strcmp
    extern ft_strlen

ft_strcmp:
    xor rax, rax                        ; Clear rax for return value
    xor rbx, rbx                        ; Clear rbx

.loop:
    movzx rax, byte [rdi]               ; Load and zero-extend char from s1 into rax
    movzx rbx, byte [rsi]               ; Load and zero-extend char from s2 into rbx

    cmp rax, rbx                        ; Compare characters
    jne .end_loop                       ; If they are not equal, exit loop

    test rax, rax                       ; Check if we reached the end of s1 (NULL)
    jz .end_loop                        ; If end of s1, exit loop

    inc rdi                             ; Move to next char of s1
    inc rsi                             ; Move to next char of s2

    jmp .loop                           ; Repeat the loop

.end_loop:
    sub rax, rbx                        ; Compute s1 - s2 (rax - rbx)
    ret

