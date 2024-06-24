; Time
; Compilar con : nasm -f elf time.asm
; Enlace con : ld -m elf_i386 time.o -o time
; Ejecuta con : ./ time

%include 'functions.asm'

SECTION .data
msg db 'Segundos desde Ene 01 1970: ', 0h ; una cadena de mensaje
SECTION .text
global _start
_start :
mov eax , msg ; mueva nuestra cadena de mensaje a eax para imprimir
call sprint ; llame a nuestra función de impresión de cadenas
mov eax ,
            ; invocar SYS_TIME (código de operación del kernel 13)
int 80h ; llamar al kernel
call iprintLF ; llame a nuestra función de impresión de números enteros con salto de línea
call quit ; llama a nuestra función de salida
