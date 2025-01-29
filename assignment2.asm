; Write an X68/64 ALP to accept a string and to display its length
; Manish Kumar
; 7231

%macro io 4
	mov rax,%1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
	syscall
%endmacro

section .data
	msg1 db "Enter Your String:",10
	msg1len equ $-msg1
	msg2 db "Method 1(without loop):",10
	msg2len equ $-msg2
	msg3 db "Method 2(with loop):",10
	msg3len equ $-msg3
	count db 5
	newline db 10
	len2 db 0

section .bss
	
	string resb 30
	asciinum resb 2


section .code
global _start
	_start:
	io 1,1,msg1,msg1len
	io 0,0,string,30
	
	dec rax
	mov rbx,rax
	io 1,1,msg2,msg2len
	call hex_ascii8

	io 1,1,msg3,msg3len
	mov rsi,string
	
	back:	
		mov al,[rsi]	
		cmp al,10
		je skip
		inc byte[len2]
		inc rsi
		loop back

	skip:
	mov bl,[len2]
	call hex_ascii8
mov rax,60
mov rdi,0
syscall

hex_ascii8:
	mov rsi,asciinum
	mov rcx,2

	next2:
		rol bl,4
		mov al,bl
		and al,0fh
		cmp al,9
		jbe add30h
		add al,7h

		add30h:
			ADD al,30h
			mov [rsi],al
			inc rsi
	loop next2
		io 1,1,asciinum,2
		io 1,1,newline,1
	ret 
