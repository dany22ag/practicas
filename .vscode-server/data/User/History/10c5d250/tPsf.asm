; Espacio de nombres 
; Compilar con: nasm -f elf fizzbuzz.asm
; Enlazar con: ld -m elf_i386 fizzbuzz.o -o fizzbuzz
; Ejecuta con: ./fizzbuzz

section .data
    fizz db 'Fizz', 0
    buzz db 'Buzz', 0
    fizzbuzz db 'FizzBuzz', 0
    newline db 10, 0

section .bss
    buffer resb 4

section .text
    global _start

_start:
    mov ecx, 1      ; contador i = 1

print_number:
    cmp ecx, 101    ; si i > 100, termina el programa
    jge exit

    mov eax, ecx
    mov ebx, 3
    cdq
    div ebx
    test edx, edx
    jnz check_buzz
    mov eax, ecx
    mov ebx, 5
    cdq
    div ebx
    test edx, edx
    jnz print_fizz
    mov edx, fizzbuzz
    jmp print_string

print_fizz:
    mov edx, fizz
    jmp print_string

check_buzz:
    mov eax, ecx
    mov ebx, 5
    cdq
    div ebx
    test edx, edx
    jnz print_integer
    mov eax, ecx
    mov ebx, 3
    cdq
    div ebx
    test edx, edx
    jnz print_buzz
    mov edx, fizzbuzz
    jmp print_string

print_buzz:
    mov edx, buzz
    jmp print_string

print_integer:
    mov eax, ecx
    call itoa
    mov edx, buffer

print_string:
    mov eax, 4
    mov ebx, 1
    mov ecx, edx
    mov edx, [ecx - 4]
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    inc ecx
    jmp print_number

exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80

itoa:
    mov edi, buffer
    add edi, 4
    mov byte [edi], 0
    mov ebx, 10

convert_loop:
    dec edi
    xor edx, edx
    div ebx
    add dl, '0'
    mov [edi], dl
    test eax, eax
    jnz convert_loop

    sub edi, buffer
    mov [buffer - 4], edi
    ret