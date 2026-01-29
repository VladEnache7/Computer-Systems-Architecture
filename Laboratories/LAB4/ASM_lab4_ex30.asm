bits 32 v

global start

extern exit

import exit msvcrt.dll
 
segment data use32 class = data
   
    A dw 1011_0110_0011_1101b
    B resd 1
    
segment code use32 class = code
start: 
    ;the bits 12-19 of B have the value 0
    mov ebx, 0
    
    ;the bits 26-31 of C are the same as the bits 3-8 of A complemented
    mov ax, [A]
    not ax
    and ax, 0000_0001_1111_1000b
    mov bx, ax 
    shl bx, 7; punem pe poz 15-10 bitii 3-8 din A
    
    ;the bits 20-25 of B have the value 1
    or bx, 0000_0011_1111_0000b ; punem cei 6 de 1
    shl ebx, 16 ;punem in high part
    
    ;the bits 0-3 of B are the same as the bits 1-4 of the result A XOR 0Ah
    mov ax, [A]
    xor ax, 0Ah
    and ax, 0000_0000_0001_1110b
    shr ax, 1
    or bx, ax
    
    ;the bits 4-11 of B are the same as the bits 7-14 of A
    mov ax, [A]
    and ax, 0111_1111_1000_0000b
    shr ax, 3
    or bx, ax
    
    push dword 0
    call [exit]

