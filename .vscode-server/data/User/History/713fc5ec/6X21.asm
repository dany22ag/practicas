; Time
; Compilar con : nasm -f elf time.asm
; Enlace con : ld -m elf_i386 time.o -o time
; Ejecuta con : ./ time

%include 'functions.asm'

SECTION .data
msg db 'Segundos desde Ene 01 1970: ', 0h ; una cadena de mensaje

SECTION .text
global _start

_start:
    mov eax, msg     ; mueve nuestra cadena de mensaje a eax para imprimir
    call sprint      ; llama a nuestra función de impresión de cadenas
    
    mov eax, 13      ; código de operación del kernel para SYS_TIME
    int 80h           ; llama al kernel
    
    mov ebx, eax     ; mueve el resultado (segundos desde 1970) a ebx
    call iprintLF    ; llama a nuestra función de impresión de números enteros con salto de línea
    
    call quit        ; llama a nuestra función de salida

