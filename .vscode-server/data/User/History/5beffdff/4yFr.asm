; Calculadora ( ATOI )
; Compilar con : nasm -f elf calculator - atoi.asm
; Enlazar con : ld -m elf_i386 calculator - atoi.o -o calculator - atoi
; Ejecuta con : ./ calculator - atoi 20 1000 317

%include  'functions.asm'

SECTION .text
global _start

_start :

pop ecx ; El primer valor en la pila es el n m e r o de argumentos.
pop edx ; El segundo valor en la pila es el nombre del programa ( descartado cuando inicializamos edx ).
sub ecx , 1 ; disminuir ecx en 1 ( n m e r o de argumentos sin nombre de programa )
mov edx , 0 ; Inicializar nuestro registro de datos para almacenar adiciones.

nextArg :
cmp ecx , 0h ; comprobar si nos queda a l g n argumento
jz noMoreArgs ; si se establece el indicador cero , salte a la etiqueta noMoreArgs ( saltando sobre el final del bucle )
pop eax ; sacar el siguiente argumento de la pila
call atoi ; convertir nuestra cadena ascii a un entero decimal
add edx , eax ; realizar nuestra l g i c a de suma
dec ecx ; disminuir ecx ( n m e r o de argumentos restantes ) en 1
jmp nextArg ; saltar a la etiqueta nextArg

noMoreArgs :
mov eax , edx ; mover el resultado de nuestros datos a eax para imprimir
call iprintLF ; llame a nuestra i m p r e s i n de n m e r o s enteros con f u n c i n de avance de l n e a
call quit ; llama a nuestra f u n c i n de salida