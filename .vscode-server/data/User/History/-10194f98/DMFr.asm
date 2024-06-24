Fragmento de código
; Definir segmento de datos
data segment
    mensaje: db "Ingrese un número: $"
    fin_linea: db "$"

    numero: dw      ?      ; Variable para almacenar el número ingresado
    resultado: dw      ?      ; Variable para almacenar el resultado de la multiplicación

data ends

; Definir segmento de código
code segment
    assume cs:code, ds:data

    start:
        ; Imprimir mensaje para ingresar el número
        mov eax, 4
        mov ebx, 1
        lea ecx, mensaje
        int 80h

        ; Leer el número ingresado
        mov eax, 3
        mov ebx, 0
        lea ecx, numero
        int 80h

        ; Guardar el número ingresado en la variable "numero"
        mov ax, [numero]

        ; Ciclo para recorrer las multiplicaciones del 1 al 10
        mov cx, 10

        ciclo:
            ; Multiplicar el "numero" por el índice del ciclo (i)
            mov ax, [numero]
            mov bx, cx
            mul bx

            ; Guardar el resultado en la variable "resultado"
            mov [resultado], ax

            ; Imprimir el resultado
            mov eax, 4
            mov ebx, 1
            lea ecx, formato_resultado
            int 80h

            ; Incrementar el índice del ciclo
            inc cx

            ; Continuar el ciclo si el índice es menor o igual a 10
            cmp cx, 10
            jge fin_ciclo

            jmp ciclo

        fin_ciclo:

        ; Terminar el programa
        mov eax, 4
        mov ebx, 1
        lea ecx, fin_mensaje
        int 80h

        mov eax, 1
        int 80h

    ; Formato para imprimir el resultado
    formato_resultado: db "%d x %d = %d$", 0, 0, 0

code ends
end start