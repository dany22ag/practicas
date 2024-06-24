section .data
    prompt_msg_len equ $ - prompt_msg
    error_msg db 'Error: Ingrese un número del 1 al 10', 0
    error_msg_len equ $ - error_msg

section .text

; Función para imprimir un número
; Entradas:
;   eax: número a imprimir (ASCII)
print_number:
    push eax      ; Guardar el número
    add eax, '0'  ; Convertir a ASCII
    mov [user_input], eax  ; Colocarlo en user_input
    pop eax       ; Recuperar el número
    ret           ; Retornar

