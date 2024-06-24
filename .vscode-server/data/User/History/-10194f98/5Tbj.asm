%include 'functions.asm'

SECTION .data
    prompt_msg db 'Ingrese un número del 1 al 10: ', 0
    result_msg db 'Tabla de multiplicar del número ingresado:', 0x0A, 0
    newline db 0x0A, 0

SECTION .bss
    user_input resb 2  ; Reserva 2 bytes para almacenar la entrada del usuario

SECTION .text
    global _start

_start:
    ; Mostrar mensaje para ingresar un número
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt_msg
    mov edx, prompt_msg_len
    int 0x80

    ; Leer entrada del usuario
    mov eax, 3
    mov ebx, 0
    mov ecx, user_input
    mov edx, 2
    int 0x80

    ; Convertir la entrada a número (ASCII a valor numérico)
    movzx eax, byte [user_input] ; Convertir el primer byte a número
    sub eax, '0'

    ; Validar que el número esté entre 1 y 10
    cmp eax, 0
    jl  input_error
    cmp eax, 10
    jg  input_error

    ; Mostrar mensaje de la tabla de multiplicar
    mov eax, 4
    mov ebx, 1
    mov ecx, result_msg
    mov edx, result_msg_len
    int 0x80

    ; Generar y mostrar la tabla de multiplicar
    mov ecx, 1  ; Inicializar el contador en 1

print_table:
    push ecx  ; Guardar el contador
    mov ebx, eax  ; Multiplicador (número ingresado por el usuario)

    ; Convertir ebx (número ingresado) a ASCII y almacenarlo en user_input
    call print_number

    mov eax, ecx  ; Multiplicando
    mul ebx  ; eax = eax * ebx

    ; Convertir eax (resultado de la multiplicación) a ASCII y almacenarlo en user_input
    call print_number

    mov eax, 4  ; Llamada al sistema para sys_write
    mov ebx, 1  ; Descriptor de archivo (stdout)
    mov ecx, newline  ; Dirección del carácter de nueva línea
    mov edx, 1  ; Longitud del carácter de nueva línea
    int 0x80  ; Llamada al sistema

    pop ecx  ; Restaurar el contador
    inc ecx  ; Incrementar el contador
    cmp ecx, 11  ; Comprobar si se alcanzó el límite de la tabla de multiplicar (1 al 10)
    jle print_table  ; Si no se alcanzó el límite, repetir el bucle

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80

input_error:
    ; Mensaje de error si el número está fuera de rango
    mov eax, 4
    mov ebx, 1
    mov ecx, error_msg
    mov edx, error_msg_len
    int 0x80

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80
