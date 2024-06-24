section .data
    prompt db 'Ingrese un numero: ', 0
    newline db 0x0A, 0x0D, 0
    tabla db 'Tabla de multiplicar de: ', 0

section .bss
    numero resb 10       ; buffer para almacenar el número introducido

section .text
    global _start

_start :
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
    xor esi, esi   ; esi será el contador para la tabla de multiplicar (inicializado en 0)
    mov ebx, 10    ; límite de la tabla (de 1 a 10)

convertir_numero :
    movzx eax, byte [numero + esi]  ; obtener dígito ASCII
    sub eax, '0'                     ; convertir de ASCII a valor numérico
    imul ecx, 10                     ; ecx *= 10
    add ecx, eax                     ; ecx += eax
    inc esi                          ; incrementar contador
    cmp byte [numero + esi], 0       ; comprobar si hemos terminado de leer el número
    jne convertir_numero              ; si no, continuar convirtiendo

    ; Mostrar título de la tabla de multiplicar
    mov eax, 4
    mov ebx, 1
    mov ecx, tabla
    mov edx, 24  ; longitud del mensaje
    int 0x80     ; syscall para escribir en consola

    ; Mostrar el número introducido
    mov eax, 4
    mov ebx, 1
    mov ecx, numero
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

bucle_multiplicar :
    cmp ecx, ebx   ; comparar contador con 10
    jg fin_multiplicar  ; si ecx > 10, terminar bucle

    ; Calcular producto y mostrar resultado
    mov eax, ecx         ; eax = contador actual (1 al 10)
    imul eax, dword [numero]  ; eax *= número introducido
    mov ebx, 10 ; para mostrar
