; Define data segment
data segment
    message: db "Enter a number: $"
    end_line: db "$"

    number: dw ?      ; Variable to store the entered number
    result: dw ?      ; Variable to store the multiplication result

data ends

; Define code segment
code segment
    assume cs:code, ds:data

    start:
        ; Print message to enter the number
        mov eax, 4
        mov ebx, 1
        lea ecx, message
        int 80h

        ; Read the entered number
        mov eax, 3
        mov ebx, 0
        lea ecx, number
        int 80h

        ; Store the entered number in the "number" variable
        mov ax, [number]

        ; Set the number to 6
        mov ax, 6

        ; Cycle to perform multiplications from 1 to 10
        mov cx, 10

        cycle:
            ; Multiply "number" by the cycle index (i)
            mov ax, [number]
            mov bx, cx
            mul bx

            ; Store the result in the "result" variable
            mov [result], ax

            ; Print the result
            mov eax, 4
            mov ebx, 1
            lea ecx, result_format
            int 80h

            ; Increment the cycle index
            inc cx

            ; Continue the cycle if the index is less than or equal to 10
            cmp cx, 10
            jge end_cycle

            jmp cycle

        end_cycle:

        ; Terminate the program
        mov eax, 1
        int 80h

    result_format: db "%d x %d = %d$", 0, 0, 0

code ends
end start