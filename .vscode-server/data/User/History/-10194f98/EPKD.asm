section .data
    prompt_msg db 'Ingrese un numero del 1 al 10: ', 0
    prompt_msg_len equ $ - prompt_msg
    result_msg db 'Tabla de multiplicar de: ', 0
    result_msg_len equ $ - result_msg
    error_msg db 'Error: Ingrese un número del 1 al 10', 0
    error_msg_len equ $ - error_msg

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

    ; Mostrar salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 3   ; longitud del salto de línea
    int 0x80     ; syscall para escribir en consola

    ; Generar tabla de multiplicar
    mov ecx, 1    ; inicializar contador para multiplicar (1 al 10)

bucle_multiplicar:
    cmp ecx, ebx   ; comparar contador con 10
    jg fin_multiplicar  ; si ecx > 10, terminar bucle

    ; Calcular producto y mostrar resultado
    movzx eax, byte [user_input]  ; obtener el número introducido
    sub eax, '0'                   ; convertir de ASCII a valor numérico
    imul eax, ecx                  ; multiplicar por el contador (1 al 10)
    call print_number              ; llamar a la función para imprimir el número calculado

    ; Mostrar coma y espacio
    mov eax, ', '
    mov ebx, 1
    mov ecx, eax
    mov edx, 2
    int 0x80

    inc ecx        ; incrementar contador
    jmp bucle_multiplicar          ; repetir bucle

fin_multiplicar:
    ; Mostrar salto de línea al final
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 3
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

; Función para imprimir un número (ASCII)
; Entrada:
;   ebx: número ASCII que se va a imprimir
print_number:
    push eax  ; Guardar eax
    mov eax, 4  ; Llamada al sistema para sys_write
    mov ebx, 1  ; Descriptor de archivo (stdout)
    mov ecx, user_input  ; Dirección del número a imprimir
    mov edx, 1  ; Longitud del número (1 byte)
    int 0x80  ; Llamada al sistema
    pop eax  ; Recuperar eax
    ret ; Retornar