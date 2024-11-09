BITS 64

section .text
    global ft_list_remove_if
    extern ft_strcmp


;ft_list_remove_if(&head, "z", &ft_strcmp, &free);
;head = rdi
;z = rsi
;ft_strcmp = rdx
;free = rcx


ft_list_remove_if:
    push rbp
    mov rbp, rsp

    push rcx                    ; save free function

    test rdi, rdi                   ; test NULL
    jz .return
    mov r15, rdi                    ; r15 = head
    mov r10, [rdi]                    ; r10 = begin_list (cabeça da lista)
    mov r11, rsi                    ; r11 = data_ref (dado para comparar)
    mov r12, rdx                    ; r12 = cmp function

.loop_list:              
    cmp r10, 0
    je .return

    mov rdi, [r10]                  ; rdi = r10.data
    call r12
    cmp rax, 0
    je .delete_node

    mov r14, r10
    mov r10, [r10 + 8]
    
    jmp .loop_list

.delete_node:

    cmp [r15], r10
    je .delete_first_node

    mov rax, [r10 + 8]             ; rax = r10.next
    mov [r14 + 8], rax              ; r14.next = r10.next

    mov rdi, r10
    pop rcx                     ; rcx = free function
    call rcx                    ; Libera os dados
    
    jmp .loop_list

.delete_first_node:
    mov rax, [r10 + 8]             ; rax = r10.next
    mov [r15], rax                  ; head = r10.next

    mov rdi, r10
    pop rcx                     ; rcx = free function
    call rcx                    ; Libera os dados

    jmp .loop_list

.return:
    leave
    ret



