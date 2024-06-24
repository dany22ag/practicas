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
    xor esi, esi   ; esi será el contador para la tabla de multiplicar (inicializado en 0)
    mov ebx, 10    ; límite de la tabla (de 1 a 10)

convertir_numero:
    movzx eax, byte [numero + esi]  ; obtener dígito ASCII
    sub eax, '0'                     ; convertir de ASCII a valor numérico
    mov edx, 0
    lea eax, [edx + eax]             ; eax = número introducido por el usuario

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
    xor ecx, ecx   ; ecx será el contador para la tabla de multiplicar (inicializado en 0)

bucle_multiplicar:
    inc ecx        ; incrementar contador
    cmp ecx, ebx   ; comparar contador con 10
    jg fin_multiplicar  ; si ecx > 10, terminar bucle

    ; Calcular producto y mostrar resultado
    mov eax, dword [numero]  ; obtener el número introducido
    imul eax, ecx            ; multiplicar por ecx (1 a 10)
    mov ebx, ecx             ; ebx = ecx (para mostrar multiplicador)
    
    ; Mostrar el multiplicador
    mov eax, 4
    mov ebx, 1
    mov ecx, numero
    mov edx, 10  ; longitud del multiplicador
    int 0x80     ; syscall para escribir en consola

    ; Mostrar el signo de multiplicación
    mov eax, 4
    mov ebx, 1
    mov ecx, ":"
    mov edx, 1
    int  en