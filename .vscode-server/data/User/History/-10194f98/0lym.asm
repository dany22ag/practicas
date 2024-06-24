section .data
    prompt_msg db 'Ingrese un numero del 1 al 10: ', 0
    prompt_msg_len equ $ - prompt_msg
    result_msg db 'Tabla de multiplicar de: ', 0
    result_msg_len equ $ - result_msg
    error_msg db 'Error: Ingrese un número del 1 al 10', 0
    error_msg_len equ $ - error_msg
    newline db 0x0A, 0x0D, 0   ; Definición de salto de línea (nueva línea y retorno de carro)

section .bss
    user_input resb 10  ; Buffer para almacenar el número introducido por el usuario

section .text
    global _start

_start:
    ; Mostrar prompt para que el usuario ingrese un número
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt_msg
    mov edx, prompt_msg_len
    int 0x80  ; syscall para escribir en consola

    ; Leer número desde consola
    mov eax, 3
    mov ebx, 0
    mov ecx, user_input
    mov edx, 10
    int 0x80  ; syscall para leer desde consola

    ; Convertir número de ASCII a entero
    xor esi, esi   ; esi será el contador para la tabla de multiplicar (inicializado en 0)
    mov ebx, 10    ; límite de la tabla (de 1 a 10)
    movzx eax, byte [user_input]  ; obtener el primer dígito ASCII del número introducido
    sub eax, '0'                   ; convertir de ASCII a valor numérico
    cmp eax, 1
    jl error_input                 ; si el número es menor a 1, mostrar mensaje de error
    cmp eax, 10
    jg error_input                 ; si el número es mayor a 10, mostrar mensaje de error

    ; Mostrar mensaje de título para la tabla de multiplicar
    mov eax, 4
    mov ebx, 1
    mov ecx, result_msg
    mov edx, result_msg_len
    int 0x80  ; syscall para escribir en consola

    ; Mostrar el número introducido
    mov eax, 4
    mov ebx, 1
    mov ecx, user_input
    mov edx, 10  ; longitud del número introducido
    int 0x80     ; syscall para escribir en consola

    ; Mostrar salto de línea después del número
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 2   ; longitud del salto de línea
    int 0x80     ; syscall para escribir en consola

    ; Mostrar la tabla de multiplicar del número ingresado
    mov eax, 4
    mov ebx, 1

    ; Primer línea de la tabla de multiplicar
    mov ecx, user_input   ; número ingresado
    mov edx, 1
    int 0x80              ; syscall para escribir en consola

    mov eax, 4
    mov ebx, 1
    mov ecx, 'x1='
    mov edx, 3
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, user_input
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 2
    int 0x80

    ; Segunda línea de la tabla de multiplicar
    mov eax, 4
    mov ebx, 1
    mov ecx, user_input
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, 'x2='
    mov edx, 3
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, user_input
    mov edx, 2
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 2
    int 0x80

    ; Tercera línea de la tabla de multiplicar
    mov eax, 4
    mov ebx, 1
    mov ecx, user_input
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, 'x3='
    mov edx, 3
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, user_input
    mov edx, 3
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 2
    int 0x80

    ; Cuarta línea de la tabla de multiplicar
    mov eax, 4
    mov ebx, 1
    mov ecx, user_input
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, 'x4='
    mov edx, 3
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, user_input
    mov edx, 4
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 2
    int 0x80

    ; Quinta línea de la tabla de multiplicar
    mov eax, 4
    mov ebx, 1
    mov ecx, user_input
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, 'x5='
    mov edx, 3
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, user_input
    mov edx, 5
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 2
    int 0x80

    ; Sexta línea de la tabla de multiplicar
    mov eax, 4
    mov ebx, 1
    mov ecx, user_input
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, 'x6='
    mov edx, 3
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, user_input
    mov edx, 6
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 2
    int 0x80

    ; Séptima línea de la tabla de multiplicar
    mov eax, 4
    mov ebx, 1
    mov ecx, user_input
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, 'x7='
    mov edx, 3
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, user_input
    mov edx, 7
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 2
    int 0x80

    ; Octava línea de la tabla de multiplicar
    mov eax, 4
    mov ebx, 1
    mov ecx, user_input
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, 'x8='
    mov edx, 3
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, user_input
    mov edx, 8
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 2
    int 0x80

    ; Novena línea de la tabla de multiplicar
    mov eax, 4
    mov ebx, 1
    mov ecx, user_input
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, 'x9='
    mov edx, 3
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, user_input
    mov edx, 9
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 2
    int 0x80

    ; Décima línea de la tabla de multiplicar
    mov eax, 4
    mov ebx, 1
    mov ecx, user_input
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, 'x10='
    mov edx, 4
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, user_input
    mov edx, 10
    int 0x80

    ; Mostrar salto de línea al final
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 2
    int 0x80

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80

error_input:
    ; Mostrar mensaje de error
    mov eax, 4
    mov ebx, 1
    mov ecx, error_msg
    mov edx, error_msg_len
    int 0x80

    ; Salir del programa con error
    mov eax, 1
    mov ebx, 1
    int 0x80