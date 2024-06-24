; Función para calcular la longitud de una cadena (slen)
; Input: String en eax
; Output: Longitud de la cadena en eax
slen:
    push ebx
    mov ebx, eax

nextchar:
    cmp byte [eax], 0
    jz .finished
    inc eax
    jmp nextchar

.finished:
    sub eax, ebx
    pop ebx
    ret

; Función para convertir una cadena numérica en entero (atoi)
; Input: String numérico en eax
; Output: Entero en eax
atoi:
    push ebx
    push ecx
    push edx
    push esi

    mov esi, eax     ; Movemos el puntero en eax a esi (nuestro número para convertir)
    mov eax, 0       ; Inicializamos eax con valor decimal 0
    mov ecx, 0       ; Inicializamos ecx con valor decimal 0

.multiplyLoop:
    xor ebx, ebx     ; Resetea los bytes inferior y superior de ebx a 0
    mov bl, [esi + ecx]  ; Mueve un solo byte a la mitad inferior del registro ebx
    cmp bl, '0'      ; Compara la mitad inferior del valor del registro ebx con el valor ascii '0'
    jl .finished     ; Salta a la etiqueta finished si es menor
    cmp bl, '9'      ; Compara la mitad inferior del valor del registro ebx con el valor ascii '9'
    jg .finished     ; Salta a la etiqueta finished si es mayor
    sub bl, '0'      ; Convierte la mitad inferior del registro ebx a una representación decimal del valor ascii '0'
    add eax, ebx     ; Agrega ebx a nuestro valor entero en eax
    mov ebx, 10      ; Mueve el valor decimal 10 a ebx
    mul ebx          ; Multiplica eax por ebx para obtener el valor posicional
    inc ecx          ; Incrementa ecx (nuestro registro contador)
    jmp .multiplyLoop ; Continúa multiplicando el ciclo

.finished:
    cmp ecx, 0       ; Compara el valor del registro ecx con el decimal 0 (nuestro registro contador)
    je .restore      ; Salta si es igual a 0 (no se pasaron argumentos enteros a atoi)
    mov ebx, 10      ; Mueve el valor decimal 10 a ebx
    div ebx          ; Divide eax por el valor en ebx (en este caso, 10)

.restore:
    pop esi          ; Restaura esi a partir del valor que colocamos en la pila al principio
    pop edx          ; Restaura edx a partir del valor que colocamos en la pila al principio
    pop ecx          ; Restaura ecx a partir del valor que colocamos en la pila al principio
    pop ebx          ; Restaura ebx a partir del valor que colocamos en la pila al principio
    ret

; Función para imprimir un número entero (iprint)
; Input: Número entero en eax
; Output: No tiene salida directa, imprime el número por consola
iprint:
    push eax
    push ecx
    push edx
    push esi

    mov ecx, 0       ; Inicializa el contador de cuántos bytes necesitamos imprimir

divideLoop:
    inc ecx          ; Cuenta cada byte para imprimir - número de caracteres
    mov edx, 0       ; Limpia edx
    mov esi, 10      ; Pone 10 en esi
    idiv esi         ; Divide eax por esi
    add dl, '0'      ; Convierte dl a su representación ascii: dl retiene el resto después de una instrucción de división
    push dx          ; Empuja dx (representación de cadena de un número entero) en la pila
    cmp eax, 0       ; ¿Se puede seguir dividiendo el número entero?
    jnz divideLoop   ; Salta si no es cero a la etiqueta divideLoop

printLoop:
    dec ecx          ; Cuenta cada byte que pusimos en la pila
    mov eax, esp     ; Mueve el puntero de la pila a eax para imprimir

    call sprint      ; Llama a nuestra función de impresión de cadenas
    pop eax          ; Elimina el último carácter de la pila para avanzar especialmente
    cmp ecx, 0       ; ¿Hemos impreso todos los bytes que colocamos en la pila?
    jnz printLoop    ; Salta si no es cero a la etiqueta printLoop

    pop esi          ; Restaura esi a partir del valor que colocamos en la pila al principio
    pop edx          ; Restaura edx a partir del valor que colocamos en la pila al principio
    pop ecx          ; Restaura ecx a partir del valor que colocamos en la pila al principio
    pop eax          ; Restaura eax a partir del valor que colocamos en la pila al principio
    ret

; Función para imprimir un número entero con salto de línea (iprintLF)
; Input: Número entero en eax
; Output: No tiene salida directa, imprime el número por consola seguido de un salto de línea
iprintLF:
    call iprint      ; Llama a nuestra función de impresión de números enteros
    push eax         ; Pone eax en la pila para conservarlo mientras usamos el registro eax en esta función
    mov eax, 0Ah     ; Mueve 0Ah a eax - 0Ah es el carácter ascii para un salto de línea
    push eax         ; Pone el salto de línea a la pila para que podamos obtener la dirección
    mov eax, esp     ; Mueve la dirección del puntero de la pila actual a eax para sprint
    call sprint      ; Llama a nuestra función de sprint
    pop eax          ; Elimina nuestro carácter de salto de línea de la pila
    pop eax          ; Restaura el valor original de eax antes de que se llamara nuestra función
    ret

; Función para imprimir una cadena (sprint)
; Input: Dirección de la cadena en eax
; Output: No tiene salida directa, imprime la cadena por consola
sprint:
    push edx
    push ecx
    push ebx
    push eax

    call slen        ; Llama a nuestra función para calcular la longitud de la cadena

    mov edx, eax     ; Mueve la longitud de la cadena a edx
    pop eax

    mov ecx, eax     ; Mueve la dirección de la cadena a ecx
    mov ebx, 1       ; Mueve 1 a ebx
    mov eax, 4       ; Mueve 4 a eax
    int 80h           ; Llama al sistema

    pop ebx
    pop ecx
    pop edx
    ret

; Función para imprimir una cadena con salto de línea (sprintLF)
; Input: Dirección de la cadena en eax
; Output: No tiene salida directa, imprime la cadena por consola seguido de un salto de línea
sprintLF:
    call sprint      ; Llama a nuestra función de impresión de cadenas
    push eax         ; Pone eax en la pila para conservarlo mientras usamos el registro eax en esta función
    mov eax, 0Ah     ; Mueve 0Ah a eax - 0Ah es el carácter ascii para un salto de línea
    push eax         ; Pone el salto de línea a la pila para que podamos obtener la dirección
    mov eax, esp     ; Mueve la dirección del puntero de la pila actual a eax para sprint
    call sprint      ; Llama a nuestra función de sprint
    pop eax          ; Elimina nuestro carácter de salto de línea de la pila
    pop eax          ; Restaura el valor original de eax antes de que se llamara nuestra función
    ret
