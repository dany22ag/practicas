; unlink 
;compilar con nasm - elf unlink.asm 
;enlazar con : espacio ld -m elf_i386 unlink.o -o unlink
;ejecutar con: ./unlink
%include 'functions.asm'

SECTION .data
filename db 'readme.txt', 0h ; el nombre del archivo a eliminar 

SECTION .text 
global _start 

_start: 

mov ebx, filename ; Nombre de archivo que eliminaremos 
mov eax, 10 ; Invocar SYS_UNLINK (codigo de operacion del kernel 10)
int 80h ; llamada al kernel 
call quit ; llama a nuestra funcion de salida 



