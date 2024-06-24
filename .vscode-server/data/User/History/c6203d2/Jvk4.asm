; Programa Hola Mundo (Imprimir con avance de linea)
; Compilar con: nasm -f elf holaMundo-lf-asm
;Enlace con: ld -m elf_i386 holaMundo-lf.o -o holaMundo-lf
; Ejecuta con: ./holaMundo-lf

%include 'functions.asm'

SECTION .data
msg1 db 'Hola, feliz mundo nuevo!', 0h ; NOTA: hemos eliminado el caracter de avamce de linea 0Ah
msg2 db 'Asi es como reciclamos en NASM.', 0h ; NOTA: hemos eliminado el caracter de avance de l9nea 0Ah

SECTION .text
global _start

_start:
    mov eax, msg1
    call sprintLF ; NOTA: Estamos llamando a nuestra nueva impresion con funcion de avance de linea

    mov eax, msg2
    call sprintLF ; NOTA: Estamos llamando a nuestra nueva impresion con funcion de avance de linea

    call quit
    
