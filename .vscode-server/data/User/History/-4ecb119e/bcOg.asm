; int atoi ( Integer number )
; Ascii a f u n c i n entera ( atoi )
atoi :
push ebx ; conservar ebx en la pila para restaurarlo d e s p u s de que se ejecute la f u n c i n
push ecx ; conservar ecx en la pila para restaurarlo d e s p u s de que se ejecute la f u n c i n
push edx ; conservar edx en la pila para restaurarlo d e s p u s de que se ejecute la f u n c i n
push esi ; conservar esi en la pila para restaurarlo d e s p u s de que se ejecute la f u n c i n
mov esi , eax ; mover el puntero en eax a esi ( nuestro n m e r o para convertir )
mov eax , 0 ; inicializar eax con valor decimal 0
mov ecx , 0 ; inicializar ecx con valor decimal 0
.multiplyLoop :
xor ebx , ebx ; restablece los bytes inferior y superior de ebx a 0
mov bl , [ esi +ecx ] ; mover un solo byte a la mitad inferior del registro ebx
cmp bl , 48 ; compare la mitad inferior del valor del registro ebx con el valor ascii 48 ( valor de c a r c t e r 0)
jl .finished ; saltar a la etiqueta finished si es menor
cmp bl , 57 ; compare la mitad inferior del valor del registro ebx con el valor ascii 57 ( valor de c a r c t e r 9)
jg .finished ; saltar a la etiqueta finished si es mayor
sub bl , 48 ; convierta la mitad inferior del registro ebx a una r e p r e s e n t a c i n decimal del valor ascii
add eax , ebx ; agregue ebx a nuestro valor entero en eax
mov ebx , 10 ; mover el valor decimal 10 a ebx
mul ebx ; multiplica eax por ebx para obtener el valor posicional
inc ecx ; incrementar ecx ( nuestro registro contador )
jmp .multiplyLoop ; continuar multiplicando el ciclo
.finished :
cmp ecx , 0 ; compare el valor del registro ecx con el decimal 0 ( nuestro registro contador )
je .restore ; saltar si es igual a 0 (no se pasaron argumentos enteros a atoi )
mov ebx , 10 ; mover el valor decimal 10 a ebx
div ebx ; dividir eax por el valor en ebx (en este caso 10)
.restore :
pop esi ; restaurar esi a partir del valor que colocamos en la pila al principio
pop edx ; restaurar edx a partir del valor que colocamos en la pila al principio
pop ecx ; restaurar ecx a partir del valor que colocamos en la pila al principio
pop ebx ; restaurar ebx a partir del valor que colocamos en la pila al principio
ret