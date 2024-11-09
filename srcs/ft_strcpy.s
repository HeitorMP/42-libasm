section .text

global ft_strcpy

ft_strcpy:
    test rdi, rdi						; Test if parameter 1 is null;
    jz .handle_error					; Jump to handle error
	test rsi, rsi						; Test if parameter 2 is null;
	jz .handle_error					; Jump to handle error

	push rdi                            ; Save the value of rdi

.loop:
	mov al, byte [rsi]       			; save 1 byte from rsi into al
    test al, al             			; test if al is 0
    jz .end_loop           				; if al is 0, end loop
    mov byte [rdi], al       			; save 1 byte from al into rdi (swap using al as aux) - al is the 8 bits register inside rax
    
    
    inc rsi                  			; rsi++
    inc rdi                  			; rdi++
    jmp .loop            				; loop

.end_loop:
    pop rdi                             ; Restore the value of rdi
    mov rax, rdi                        ; return rdi
	ret

.handle_error:
	xor rax, rax                 		; if src is null return 0;
    ret