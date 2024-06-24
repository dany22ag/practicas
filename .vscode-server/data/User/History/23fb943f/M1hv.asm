; Hello World Program ( NULL terminating bytes )
; Compile with : nasm -f elf helloworld - inc.asm
; Link with (64 bit systems require elf_i386 option ): ld -m elf_i386 helloworld - inc.o -o helloworld -inc
; Run with : ./ helloworld-inc

%include ' functions.asm '
7
8 SECTION .data
9 msg1 db 'Hello , brave new world !', 0Ah , 0 h ; NOTE the
null terminating byte
10 msg2 db 'This is how we recycle in NASM. ', 0Ah , 0 h ; NOTE the
null terminating byte
11
12 SECTION .text
13 global _start
20
14
15 _start :
16
17 mov eax , msg1
18 call sprint
19
20 mov eax , msg2
21 call sprint
22
23 call quit