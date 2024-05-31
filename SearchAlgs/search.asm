.code

asm_search proc
;unsigned asm_search(const int* arr, unsigned len, int elem);
;RCX = arr
;EDX = len
;R8d = elem

	push rbx
	push rsi
	push rdi
	push r9
	push r10
	push r11
	push r12

	add rsp,-16						; Выделяем место в стеке для локальных переменных
	xor eax,eax			
	
	xor ebx,ebx
	mov rsi,4294967295				; 0xFFFFFFFF

	mov r11,3						; Временные значения, используются дальше
	mov r12,2						;

	movq xmm2,r8
@@do:
	pshufd xmm0,xmm2,0				; Загружаем значение из XMM2 во все ячейки регистра XMM0
	movups xmm1,[rcx+rbx*4]			; Загружаем значения из массива
	pcmpeqd xmm0,xmm1				; Сравниваем. Результат в виде маски
	movdqu xmmword ptr[rsp],xmm0	; Загружаем результат в стек

	mov r9,[rsp]
	mov r10,[rsp+8]

	; Находим индекс нужного элемента по маске
	or r9,r9
	je @@R10

	test r9d,r9d
	jne @@end
	inc eax
	jmp @@end

@@R10:
	or r10,r10
	je @@next

	test r10d,r10d
	cmove eax,r11d
	cmovne eax,r12d
	jmp @@end

@@next:

	add ebx,4
	cmp ebx,edx
	jb @@do

@@end:
	add eax,ebx

	add rsp,16

	pop r12
	pop r11
	pop r10
	pop r9
	pop rdi
	pop rsi
	pop rbx

	ret
asm_search endp


end