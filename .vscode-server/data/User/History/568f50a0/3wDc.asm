; Create
; Compilar con : nasm -f elf create.asm
; Enlace con : ld -m elf_i386 create.o -o créate
; Ejecuta con : ./ créate
%include ' functions.asm ' 
SECTION .data
filename db 'readme.txt ', 0 h ; el nombre del archivo a crear

SECTION .text
global _start

_start :
mov ecx , 0777 o ; establecer todos los permisos para leer , escribir y ejecutarset all permissions to read , write , execute
mov ebx , filename ; nombre de archivo que crearemos
mov eax , 8 ; invocar SYS_CREAT (código de operación del kernel 8)
int 80 h ; llamar al kernel

call quit ; llama a nuestra función de salida
