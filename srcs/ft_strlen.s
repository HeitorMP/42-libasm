

section .text                         	; Define the code section
global ft_strlen

ft_strlen:
    test rdi, rdi                       ; Test if null
    jz .handle_error           		    ; Jump to the null handling code if ZF is set

    xor rax, rax                        ; 0 rax value

.loop: 				               		; this loop for strng length
    cmp byte [rdi + rax], 0             ; Compare rdi(byte position of string) + rax(index) with 0(null terminator)
    je .end_loop      					; je = jump if equal. If cpm = 0 break the loop
    inc rax                             ; if cmp != 0 rax++
    jmp .loop 					        ; loop

.end_loop:
    ret                                 ; Return from the function

.handle_error:
    ret