section .data
    prompt_msg_len equ $ - prompt_msg
    result_msg_len equ $ - result_msg
    error_msg db 'Error: Ingrese un número del 1 al 10', 0
    error_msg_len equ $ - error_msg

section .text

; Función para imprimir un número (ASCII)
; Entrada:
;   ebx: número ASCII que se va a imprimir
print_number :
    push eax  ; Guardar eax
    add ebx, '0'  ; Convertir a ASCII
    mov [user_input], ebx  ; Almacenar en user_input

    mov eax, 4  ; Llamada al sistema para sys_write
    mov ebx, 1  ; Descriptor de archivo (stdout)
    mov ecx, user_input  ; Dirección del número a imprimir
    mov edx, 1  ; Longitud del número (1 byte)
    int 0x80  ; Llamada al sistema

    pop eax  ; Recuperar eax
    ret  ; Retornar


