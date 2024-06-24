; Hello World Program (Calculating string length)
; Compile with : nasm -f elf helloworld-len.asm
; Link with (64 bit systems require elf_i386 option ): ld -m elf_i386 helloworld-len.o -o helloworld-len
; Run with : ./ helloworld-len
SECTION .data

msg db 'Hello, brave new world !', 0Ah ; Podemos modificar esto ahora sin tener que actualizar en ningun otro lugar del programa

SECTION .text
global _start

_start :
    mov ebx, msg ; mover la direccion de nuestra cadena de mensaje a ebx
    mov eax, ebx ; mueva la direccion en ebx a eax tambien (ahora ambos apuntan al mismo segmento en la memoria)

nextchar:
    cmp byte [eax], 0 ; mueva la direccion en ebx a eax tambien (ahora ambos apuntan al mismo segmento en la memoria)
    jz finished ; saltar (si se ha establecido el cero marcado) al punto en el codigo etiquetado como terminado
    inc eax ; incrementar la direccion en eax en un byte (si el cero marcado NO se ha establecido)
    jmp nextchar ; salte al punto en el codigo etiquetado como nextchar

finished:
    sub eax, ebx ; restar la direccion en ebx de la direccion en eax
                 ; recuerde que ambos registros comenzaron a apuntar a la misma direccion (ver linea 15)
                 ; cuando restas una direccion de memoeria de otra del mismo tipo
                 ; el resultado es el numero de segmentos entre ellos; en este caso, el numero de bytes
    
    mov edx, eax ; EAX ahora es igual al numero de bytes en nuestra cadena
    mov ecx, msg ; El resto del codigo deberia resultarle familiar ahora
    mov ebx ,1
    mov eax, 4
    int 80h

    mov ebx, 0
    mov eax, 1
    int 80h

