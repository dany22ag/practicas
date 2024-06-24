; Execute
; Compilar con : nasm -f elf execute.asm
; Enlazar con : ld -m elf_i386 execute.o -o execute
; Ejecutar con : ./ execute

%include 'functions.asm'

SECTION .data

command db '/bin / echo ', 0h ; comando para ejecutar
arg1 db 'Hola Mundo !', 0h 
arguments dd command 
dd arg1 ; argumentos para pasar a la lí nea de comando (en este caso solo uno )
dd 0h ; terminar la estructura environment dd 0h 
; Los argumentos para pasar como variables de entorno (en este caso , ninguno ) finalizan la estructura.
environment dd 0h ;puntero nulo indicando final del arreglo de varibales del entorno

SECTION .text
global _start
_start :
mov edx , environment ; dirección de variables de entorno
mov ecx , arguments ; direcci ón de los argumentos para pasar a la línea de comando
mov ebx , command ; direcci ón del archivo a ejecutar
mov eax , 11 ; invocar SYS_EXECVE (có digo de operación del kernel 11)
int 80h
call quit ; llama a nuestra funci ón de salida