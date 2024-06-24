section .data
    prompt_msg db 'Ingrese un numero del 1 al 10: ', 0
    prompt_msg_len equ $ - prompt_msg
    result_msg db 'Tabla de multiplicar de: ', 0
    result_msg_len equ $ - result_msg
    error_msg db 'Error: Ingrese un número del 1 al 10', 0
    error_msg_len equ $ - error_msg
    newline db 0x0A, 0x0D, 0   ; Salto de línea (nueva línea y retorno de carro)

section .bss
    user_input resb 10  ; Buffer para almacenar el número introducido por el usuario

section .text
    global _start

; Incluir el código de la función print_number
%include "functions"

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

    ; Generar tabla de multiplicar
    mov ecx, 1    ; inicializar contador para multiplicar (1 al 10)

bucle_multiplicar:
    cmp ecx, ebx   ; comparar contador con 10
    jg fin_multiplicar  ; si ecx > 10, terminar bucle

    ; Calcular producto
    movzx eax, byte [user_input]  ; obtener el número introducido
    sub eax, '0'                   ; convertir de ASCII a valor numérico
    imul edx, ecx                  ; multiplicar por el contador (1 al 10)

    ; Mostrar multiplicación en formato "6x1=6", "6x2=12", etc.
    push eax                       ; guardar eax (número introducido) en la pila
    push ecx                       ; guardar ecx (contador) en la pila
    call print_number              ; llamar a la función para imprimir el número calculado
    add esp, 8                     ; ajustar el puntero de pila después de la llamada (16-bit NASM)

    ; Mostrar coma y espacio si no es el último número de la tabla
    cmp ecx, 10
    je skip_comma_space            ; saltar si es el último número
    mov eax, ', '
    mov ebx, 1
    mov ecx, eax
    mov edx, 2
    int 0x80

skip_comma_space:
    inc ecx        ; incrementar contador
    jmp bucle_multiplicar ; repet