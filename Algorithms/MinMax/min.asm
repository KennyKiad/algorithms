.code

get_min_asm proc
;int get_min_asm(const int* arr, unsigned int len)
;RCX = const int* arr
;RDX = unsigned int len

	push rbx
	push rsi
	push r9
	push r10
	push r11
	push r12
		
	add rsp,-16
	
	movups xmm0,[rcx]			
	movups xmm1,[rcx+16]
	pminud xmm0,xmm1		; Находит минимальный вектор

	mov ebx,4

@@do:
	lea rsi,[rbx*4]
	movups xmm1,[rcx+rsi+16]
	pminud xmm0,xmm1

	movups xmmword ptr[rsp],xmm0

	mov eax,[rsp]
	cmp eax,[rsp+4]
	cmovg eax,[rsp+4]

	cmp eax,[rsp+8]
	cmovg eax,[rsp+8]

	cmp eax,[rsp+12]
	cmovg eax,[rsp+12]

	
	add ebx,4
	cmp ebx,edx
	jb @@do

	add rsp,16

	pop r12
	pop r11
	pop r10
	pop r9
	pop rsi
	pop rbx

	ret
get_min_asm endp

end