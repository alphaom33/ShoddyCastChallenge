bits 64
default rel

%include "stringfns.asm"

section .data
rand: db 0

section .text
global main

main:
    xor r12, r12
    xor r15, r15

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

        cmp r14w, r12w
        jl skip
        mov r12w, r14w
        skip:

	inc r15
	mov rsi, r15
	call iprintln
	cmp r15, 1000000
	jne loop

	mov rsi, r12
	call iprintln

	exit:
	    mov rax, 60
	    mov rdi, 0
	    syscall
