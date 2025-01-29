; Write X86/64 ALP to accept five 64 bit hexadecimal number from user and store it in an array and display the accepted number.
; Manish Kumar
; 7231


%macro io 4
	mov rax,%1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
	syscall
%endmacro

%macro exit 0
	mov rax,60
	mov rdi,0
	syscall
%endmacro


section .data
	msg2 db "Enter 5 64bit hexadecimal number:",18
	msg2len equ $-msg2
	msg3 db "5 64bit hexadecimal number are: ",18
	msg3len equ $-msg3	
	newline db 10

section .bss
	asciinum resb 17
	hexnum resq 5


section .code
global _start
	_start:
	io 1,1,msg2,msg2len
	mov rcx,5
	mov rsi,hexnum
	next1:
		push rsi
		push rcx
		io 0,0,asciinum,17
		call ascii_hex64
		pop rcx
		pop rsi
		mov [rsi],rbx
		add rsi,8
		loop next1

	io 1,1,msg3,msg3len
	mov rsi,hexnum
	mov rcx,5
	next2:
		push rsi
		push rcx
		mov rbx,[rsi]
		call hex_ascii64
		pop rcx
		pop rsi
		add rsi,8
		loop next2

	exit

	ascii_hex64:
	mov rsi,asciinum

		mov rbx,0
		mov rcx,16

		next3:
			rol rbx,4
			mov al,[rsi]
			cmp al,39h
			jbe sub30h
			sub al,7h

			sub30h:
				sub al,30h
				add bl,al
				inc rsi
		loop next3

	ret
	hex_ascii64:
		mov rsi,asciinum
		mov rcx,16

		next4:
			rol rbx,4
			mov al,bl
			and al,0fh
			cmp al,9
			jbe add30h
			add al,7h

			add30h:
				ADD al,30h
				mov [rsi],al
				inc rsi
		loop next4
			io 1,1,asciinum,16
			io 1,1,newline,1
		ret


	
