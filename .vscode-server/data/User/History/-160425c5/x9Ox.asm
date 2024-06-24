section .data


section .text

; Función para imprimir un número (ASCII)
; Entrada:
;   ebx: número ASCII que se va a imprimir
print_number :
    push eax  ; Guardar eax
    mov eax, 4  ; Llamada al sistema para sys_write
    mov ebx, 1  ; Descriptor de archivo (stdout)
    mov ecx, user_input  ; Dirección del número a imprimir
    mov edx, 1  ; Longitud del número (1 byte)
    int 0x80  ; Llamada al sistema
    pop eax  ; Recuperar eax
    ret  ; Retornar


