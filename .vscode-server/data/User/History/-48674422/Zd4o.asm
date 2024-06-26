; Hello World Program
; Compilacion con : nasm -f elf helloworld.asm
; Link con (64 bit systems require elf_i386 option ): ld -m elf_i386 helloworld.o -o helloworld
; Run con : ./ helloworld

SECTION .data
msg db 'Hello World !', 0Ah

SECTION .text
global _start

_start :

mov edx , 13
mov ecx , msg
mov ebx , 1
mov eax , 4
int 80h

mov ebx , 0 ; return 0 status on exit - 'No Errors '
mov eax , 1 ; invoke SYS_EXIT ( kernel opcode 1)
int 80h
