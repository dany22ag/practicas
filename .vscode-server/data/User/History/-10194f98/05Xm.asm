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

_start :
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

    ; Mostrar la tabla de multiplicar del número 6 manualmente
    mov eax, 4
    mov ebx, 1
    mov ecx, '6x1=6'
    mov edx, 6
    int 0x80     ; syscall para escribir en consola

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 2
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, '6x2=12'
    mov edx, 7
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 2
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, '6x3=18'
    mov edx, 7
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 2
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, '6x4=24'
    mov edx, 7
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 2
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, '6x5=30'
    mov edx, 7
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 2
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, '6x6=36'
    mov edx, 7
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 2
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, '6x7=42'
    mov edx, 7
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 2
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, '6x8=48'
    mov edx, 7
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 2
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, '6x9=54'
    mov edx, 7
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 2
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, '6x10=60'
    mov edx, 8
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

error_input :
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