;programa hola mundo (pasar argumentos desde la linea de comando)
;compila con: nasm -f elf holaMundo-args.asm
;Enlaza con: ld -m elf_i386 helloworld-args.o -o helloword -args
;Ejecutar con: ./holaMundo-args
%include           ' function.asm '
SECTION .text
global _start
_start :

    pop ecx  ;el primer valor en la pila (stack) es eln mero de argumentos.

nextArg :
    cmp ecx, 0h ; comprobar si nos queda alg n argumento

    jz noMoreArgs ;si se establece el inicador cero, salte etiqueta noMoreArgs (saltando sobre le final del bucle)
    pop eax ; saca el siguiente argumento de la pila (stack)
    call sprintLF ; llama a nuestra funcion de inpresion con salto de linea
    dec ecx ; disminuir ecx (numero de argumentos restantes) en 1
    jmp nextArg ; saltar las etiquetas nextArg

noMoreArgs :
    call quit

