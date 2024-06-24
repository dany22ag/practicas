; Hello World Program ( Calculating string length )
2 ; Compile with : nasm -f elf helloworld - len.asm
3 ; Link with (64 bit systems require elf_i386 option ): ld -m elf_i386
helloworld - len.o -o helloworld -len
4 ; Run with : ./ helloworld -len
5
6 SECTION .data
7 msg db 'Hello , brave new world !', 0Ah ; Podemos modificar esto
ahora sin tener que actualizar en ningun otro lugar del programa.
8 SECTION .text
9 global _start
10
11 _start :
12
13 mov ebx , msg ; mover la direccion de nuestra cadena de
mensaje a EBX
14 mov eax , ebx ; mueva la direccion en EBX a EAX tambien (
ahora ambos apuntan al mismo segmento en la memoria )
15
16 nextchar :
17 cmp byte [eax ] , 0 ; mueva la direccion en EBX a EAX tambien (
ahora ambos apuntan al mismo segmento en la memoria )
18 jz finished ; saltar (si se ha establecido el cero
marcado ) al punto en el codigo etiquetado como terminadoS
19 inc eax ; incrementar la direccion en EAX en un
byte (si el cero marcado NO se ha establecido )
20 jmp nextchar ; salte al punto en el codigo etiquetado
como nextchar
21 finished :
22 sub eax , ebx ; restar la direccion en EBX de la
direccion en EAX
23 ; recuerde que ambos registros comenzaron a
apuntar a la misma direccion (ver linea 15)
24 ; pero EAX se ha incrementado un byte por
cada caracter en la cadena del mensaje
25 ; cuando restas una direccion de memoria de
otra del mismo tipo
26 ; el resultado es el numero de segmentos
entre ellos ; en este caso , el numero de bytes
27
28 mov edx , eax ; EAX ahora es igual al numero de bytes en
nuestra cadena
29 mov ecx , msg ; El resto del codigo deberia resultarle
familiar ahora
30 mov ebx , 1
31 mov eax , 4
32 int 80 h
33
34 mov ebx , 0
35 mov eax , 1
36 int 80 h
