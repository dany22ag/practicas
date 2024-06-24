; Espacio de nombres 
; Compilar con: nasm -f elf fizzbuzz.asm
; Enlazar con: ld -m elf_i386 fizzbuzz.o -o fizzbuzz
; Ejecuta con: ./fizzbuzz

%include 'functions.asm'

section .data
    fizz db "Fizz", 0
    buzz db "Buzz", 0
    fizzbuzz db "FizzBuzz", 0
    newline db 0Ah, 0
    format db "%d", 0

section .bss
    num resb 4

section .text
    global _start

extern slen
extern iprintLF
extern sprintLF
extern quit

_start:
    ; Set counter to 1
    mov ecx, 1

.loop:
    ; Check if counter > 100
    cmp ecx, 100
    jg .exit

    ; Check if divisible by 15 (FizzBuzz)
    mov eax, ecx
    mov ebx, 15
    cdq
    idiv ebx
    cmp edx, 0
    je .fizzbuzz

    ; Check if divisible by 3 (Fizz)
    mov eax, ecx
    mov ebx, 3
    cdq
    idiv ebx
    cmp edx, 0
    je .fizz

    ; Check if divisible by 5 (Buzz)
    mov eax, ecx
    mov ebx, 5
    cdq
    idiv ebx
    cmp edx, 0
    je .buzz

    ; Print the number
    mov eax, ecx
    call iprintLF
    jmp .next

.fizzbuzz:
    mov eax, fizzbuzz
    call sprintLF
    jmp .next

.fizz:
    mov eax, fizz
    call sprintLF
    jmp .next

.buzz:
    mov eax, buzz
    call sprintLF
    jmp .next

.next:
    ; Increment counter
    inc ecx
    jmp .loop

.exit:
    call quit