section	.text
    global	ft_list_push_front
    extern	malloc

ft_list_push_front:		
			xor		rax, rax
			push	rsp				
			push	rdi				
			push	rsi				
			mov		rdi, 16

			call	malloc WRT ..plt
			cmp		rax, 0
			jz		return
            
			pop		rsi
			pop		rdi

			mov		[rax], rsi		; data goes into pointer returned by malloc
			mov		rcx, [rdi]      ; rcx = old first node
			mov		[rax + 8], rcx	; new_head.next = old first node
			mov		[rdi], rax		; begin first node  = new node inside rax
return:
			pop		rsp				
			ret