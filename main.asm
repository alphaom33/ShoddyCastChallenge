bits 64
default rel

%include "stringfns.asm"

section .data
rand: db 0
count: dq 0
max: dw 0

section .text
global main

main:
    xor r12, r12
    xor r15, r15

	spawner:
		mov rax, 58
		syscall
		
		cmp rax, 0
		je loop

        inc r15
        cmp r15, 1000000
        jne spawner

	waiter:
		cmp qword [count], 1000000
		jne waiter

	mov rsi, [max]
	call iprintln
	jmp exit

    loop:
        xor r14, r14
        xor r13, r13
        innerloop:
            mov rdi, rand
            mov rsi, 1
            mov rdx, 0
            mov rax, 318
            syscall

            cmp byte [rand], 64
            jl skipy
            inc r14w
            skipy:

            inc r13w
            cmp r13w, 231
            jne innerloop

        cmp r14w, word [max]
        jl skip
        mov [max], r14w
        skip:

	inc qword [count]
	mov rsi, [count]
	call iprintln

	exit:
	    mov rax, 60
	    mov rdi, 0
	    syscall
