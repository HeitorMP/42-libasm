BITS 64

section .text
    global ft_list_sort

    ;rdi = head
    ;rsi = cmp function

ft_list_sort:
    
    mov rax, [rdi]
    test rax, rax
    jz .return_from_null
    test rsi, rsi
    jz .return_from_null

    push rbp
    mov rbp, rsp
    mov r15, rsi ; r15 = cmp function


    push rdi
    mov r9, rdi 

.sort_start:
    mov r14, 0             	; Reseta a flag de troca para a nova passagem
	pop rdi					; Restaura rdi
    mov r10, [rdi]         	; r10 = begin_list node
	push rdi

.sort_loop:

    mov r11, [r10 + 8] 		; r11 = r10.next

    test r11, r11
    jz .return

	push rdi
    mov rdi, [r10]     		; rdi = r10.data
    mov rsi, [r11]     		; rsi = r11.data
    
	call r15           		; rax = cmp(r11, r11)
	pop rdi
    cmp rax, 0
    jg .swap           		; if r11 < r10, swap

    mov r10, [r10 + 8] 		; r10 = r10.next
    jmp .sort_loop

.swap:
    mov r12, [r10]      	; r12 = r10.data
    mov r13, [r11]      	; r13 = r11.data

    mov [r10], r13      	; r10.data = r11.data
    mov [r11], r12      	; r11.data = r10.data

    mov r14, 1             	; Marca que houve uma troca

    ; Avança para o próximo par de nós
    mov r10, [r10 + 8]      ; r10 = r10.next

.check_if_sorted:
    cmp r14, 1
    je .sort_start          ; Se houve troca, reinicia a partir do início

.return:
    pop rdi                 ; Restaura rdi
    leave
    ret

.return_from_null:
    ret