%include 'functions.asm'
 SECTION .data
 filename db 'readme.txt', 0h ; el nombre del archivo a crear 
 contents db '-updated-', 0h ; El contenido a escribir al inicio del archivo 
 SECTION .text 
 global _start
 
 _start:
    mov ecx, 1 ; Indicador para el modo de acceso de solo escritura (O_WRONLY)
    mov ebx, filename ; NOmbre de larchivo a abrir 
    mov eax, 5 ; Invocar SYS_OPEN (codigo de opreacion del kernel 5)
    int 80h ; llamar al kernel 


    mov edx, 2 ; De donde argumento (SEEK_END)
    mov ecx, 0 ; Mover el cursor 0 bytes
    mov ebx, eax ; Mover al descriptor del archivo abierto a EBX
    mov eax, 19 ; invocar SYS_LSEEK (codigo de operacion del kernel 19)
    int 80h ; Llamar al kernel

    mov edx, 9 ;numero de bytes para escribir: 1 para cada letra de nuestra cadena de contenido
    mov ecx, contents ; mover la direccion de memoria de nuestra cadena de contenido a ecx
    mov ebx, ebx ;moeve al descriptor del archivo abierto A EBX (no es necesario ya que EBX ya tiene el FD)
    mov eax, 4 ;invoca SYS_WRITE (codigo de operacion del kernel 4)
    int 80h ; Llama la kernel 
    call quit ;Llama a nuestra funcion de salida 

    
