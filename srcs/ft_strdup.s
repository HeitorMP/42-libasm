section .text
    global ft_strdup
    extern ft_strlen
    extern malloc

ft_strdup:
    push rbp                            ; save the current rbp on the stack
    mov rbp, rsp                        ; set up stack frame

    push rdi                            ; save the original pointer (s) on the stack
    call ft_strlen                      ; call ft_strlen to get the string length
    inc rax                             ; increment rax to include null terminator
    
    mov rdi, rax                        ; prepare the argument for malloc
    call malloc WRT ..plt               ; call malloc

    test rax, rax                       ; check if malloc returned NULL
    jz allocation_failed                ; if NULL, jump to allocation failed

    pop rsi                             ; restore the original pointer to rsi
    mov rdi, rax                        ; rdi now holds the pointer to the new string
    xor rcx, rcx                        ; clear rcx for the loop counter

copy_loop:
    mov al, byte [rsi+rcx]              ; load the current character from the original string
    mov byte [rdi+rcx], al              ; copy the character to the new string
    test al, al                         ; check if it's the null terminator
    jz end_copy                         ; if null, jump to end
    inc rcx                             ; advance to the next character
    jmp copy_loop                       ; repeat the loop

end_copy:
    leave                               ; restore original rbp
    mov rax, rdi                        ; set rax to point to the new string
    ret
    
allocation_failed:
    mov rax, 0                          ; return NULL on failure
    leave                               ; restore stack frame and return
    ret
