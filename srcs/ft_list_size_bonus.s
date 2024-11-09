
BITS 64

; rdi = begin

section .text
    global ft_list_size

ft_list_size:

    xor rax, rax            ; 0 to rax - it will be my counter

    test rdi, rdi           ; check if begin is null
    jz .return              ; if the resulto of test is 0 go to return with rax 0

    mov rsi, rdi            ; saving rdi in rsi, to not loose the original reference to the list in rdi

.count_loop:

    cmp rdi, 0              ; test if null, same as test,but i will use cmp here to make clear is not a error test
    jz .return              ; next = null, go to ret

    inc rax                 ; rax++
    mov rdi, [rdi + 8]      ; move rdi to next pointer (will work only in subject structure)
    jmp .count_loop         ; loop

.return:
    ret




