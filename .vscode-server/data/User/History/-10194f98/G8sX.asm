section .data
    prompt_msg db 'Ingrese un numero del 1 al 10: ', 0
    prompt_msg_len equ $ - prompt_msg
    result_msg db 'Tabla de multiplicar de: ', 0
    result_msg_len equ $ - result_msg
    error_msg db 'Error: Ingrese un número del 1 al 10', 0
    error_msg_len equ $ - error_msg
    newline db 0x0A, 0x0D, 0   ; Definición de salto de línea (nueva línea y retorno de carro)
    times_str db 'x', 0        ; Carácter 'x' para la multiplicación
    eq_str db '=', 0           ; Carácter '=' para la asignación

section .bss
    user_input resb 2          ; Buffer para almacenar el número introducido por el usuario
    result resb 4              ; Buffer para almacenar el resultado de la multiplicación

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
    mov edx, 2
    int 0x80  ; syscall para leer desde consola

    ; Convertir número de ASCII a entero
    movzx eax, byte [user_input]
    sub eax, '0'
    cmp eax, 1
    jl error_input                 ; si el número es menor a 1, mostrar mensaje de error
    cmp eax, 10
    jg error_input                 ; si el número es mayor a 10, mostrar mensaje de error

    ; Guardar el número ingresado en ebx
    mov ebx, eax

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
    mov edx, 1
    int 0x80     ; syscall para escribir en consola

    ; Mostrar salto de línea después del número
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 2   ; longitud del salto de línea
    int 0x80     ; syscall para escribir en consola

    ; Inicializar contador
    mov ecx, 1

print_table :
    ; Si el contador es mayor a 10, terminar
    cmp ecx, 11
    jge end_program

    ; Mostrar número ingresado
    mov eax, 4
    mov ebx, 1
    movzx edx, byte [user_input]
    sub edx, '0'
    add edx, '0'
    int 0x80

    ; Mostrar 'x'
    mov eax, 4
    mov ebx, 1
    mov ecx, times_str
    mov edx, 1
    int 0x80

    ; Mostrar el contador
    mov eax, 4
    mov ebx, 1
    add ecx, '0'
    mov edx, ecx
    sub ecx, '0'
    int 0x80

    ; Mostrar '='
    mov eax, 4
    mov ebx, 1
    mov ecx, eq_str
    mov edx, 1
    int 0x80

    ; Calcular multiplicación
    mov eax, ebx
    mul ecx

    ; Convertir resultado a ASCII y mostrarlo
    add eax, '0'
    mov [result], eax
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 1
    int 0x80

    ; Mostrar salto de línea después del resultado
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 2
    int 0x80     ; syscall para escribir en consola

    ; Incrementar contador
    add ecx, 1
    jmp print_table

end_program :
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
