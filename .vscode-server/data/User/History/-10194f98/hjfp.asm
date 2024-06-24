%include 'functions.asm'

section .data
    prompt db 'Ingrese un numero: ', 0
    newline db 0x0A, 0x0D, 0
    tabla db 'Tabla de multiplicar de: ', 0

section .bss
    numero resb 10       ; buffer para almacenar el número introducido

section .text
    global _start

_start:
    ; Mostrar prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 18  ; longitud del prompt
    int 0x80     ; syscall para escribir en consola

    ; Leer número desde consola
    mov eax, 3
    mov ebx, 0
    mov ecx, numero
    mov edx, 10  ; tamaño del buffer
    int 0x80     ; syscall para leer desde consola

    ; Convertir número de ASCII a entero
    xor ecx, ecx   ; ecx será el contador para la tabla de multiplicar (inicializado en 0)
    mov ebx, 10    ; límite de la tabla (de 1 a 10)

convertir_numero:
    movzx eax, byte [numero + ecx]  ; obtener dígito ASCII
    sub eax, '0'                     ; convertir de ASCII a valor numérico
    mov edx, 0
    lea esi, [eax*2 + eax]           ; esi = eax * 3
    lea eax, [edx + esi * 4]         ; eax = 4 * esi + edx
 Ah Also Can w Ask Help of Can