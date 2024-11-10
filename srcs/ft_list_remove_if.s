BITS 64

section .text
    global ft_list_remove_if
    extern ft_strcmp
    extern free

ft_list_remove_if:
    push rbp                        
    mov rbp, rsp                    ; Update rsp to point to the stack

    mov r15, rdi                    ; r15 = head (pointer to the start of the list)
    mov r14, [rdi]                  ; r14 = current node (start of the list)
    mov r11, rsi                    ; r11 = data_ref (data to compare)
    mov r12, rdx                    ; r12 = cmp function
    mov r13, rcx                    ; r13 = free function
    mov qword r10, 0                ; r10 = previous node (initially NULL)

.loop_list:
    test r14, r14                   ; Check if r14 is NULL (end of the list)
    jz .return                       ; If NULL, return (end of list)

    ; prepare the stack for the call to the cmp function
    push r14
    push r10
    push r15
    push r11
    push r12
    push r13

    mov rdi, [r14]                  ; rdi = r14.data (data of the current node)
    mov rsi, r11                    ; rsi = data_ref
    call r12                        ; Call the cmp function (comparison)

    pop r13
    pop r12
    pop r11
    pop r15
    pop r10
    pop r14

    cmp rax, 0                      ; Check the result of the comparison
    jne .next_node                  ; If not equal, go to the next node

    ; Delete the current node
    cmp qword [r15], r14            ; Check if we are at the first node
    je .delete_first_node           ; If yes, treat it as a special case to update the head

    mov qword r9, [r14 + 8]         ; r9 = next node (save the next node before calling free)
    mov [r10 + 8], r9               ; r10.next = r14.next (previous node points to the next one)

    ; prepare the stack for the call to free
    push r14                        
    push r10                        
    push r15                        
    push r11                        
    push r12                        
    push r13                        

    mov rdi, r14                    ; Prepare rdi to call free with the current node
    call r13                        ; Call the free function to free the memory

    pop r13                         
    pop r12                         
    pop r11                         
    pop r15                         
    pop r10                         
    pop r14                         
    ; stack resored after the call to free

    mov r14, r9                     ; Update r14 to the next node after removal
    jmp .loop_list                  ; Continue iterating through the list

.delete_first_node:
    mov qword r9, [r14 + 8]         ; r9 = next node
    mov qword [r15], r9             ; Update head = r14.next (removes the first node)

    push r14                        
    push r10                        
    push r15                        
    push r11                        
    push r12                        
    push r13                        

    mov rdi, r14                    ; Prepare rdi to call free with the current node
    call 13                         ; Call the free function to free the memory

    pop r13                         
    pop r12                         
    pop r11                         
    pop r15                         
    pop r10                         
    pop r14                         

    mov r14, r9                     ; Update r14 to the next node after removal
    jmp .loop_list                  ; Continue iterating through the list

.next_node:
    mov qword r10, r14              ; r10 = current node (keeps the previous node)
    mov r14, [r14 + 8]              ; r14 = next node
    jmp .loop_list                  ; Go back to the start of the loop to check the next node

.return:
    leave                           
    ret
