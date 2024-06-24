SECTION .data
    prompt_msg_len equ $ - prompt_msg
    result_msg_len equ $ - result_msg
    error_msg db 'Error: Ingrese un número del 1 al 10', 0
    error_msg_len equ $ - error_msg

SECTION .text

; Función para imprimir un número (ASCII) y un carácter de nueva línea
; Entrada:
;   ebx: número ASCII que se va a imprimir
print_number :
    push eax  ; Guardar eax
    add ebx, '0'  ; Convertir a ASCII
    mov [user_input], ebx  ; Almacenar en user_input
    pop eax  ; Recuperar eax
    ret  ; Retornar

