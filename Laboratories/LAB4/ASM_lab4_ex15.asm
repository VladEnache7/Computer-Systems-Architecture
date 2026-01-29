bits 32 

global start

extern exit

import exit msvcrt.dll
 
segment data use32 class = data
    
    A dw 1101_0100_0110_0000b
    B dw 1010_0101_1100_0011b
    C resd 1
    
segment code use32 class = code
start: 
    ;the bits 16-31 of C have the value 1
    ;the bits 0-2 of C have the value 0
    mov ecx, 0
    or cx, 1111_1111_1111_1111b
    shl ecx, 16 
    
    ;the bits 3-5 of C have the value 1
    or cx, 0000_0000_0011_1000b
    
    ;the bits 6-9 of C are the same as the bits 11-14 of A
    mov bx, [A]
    and bx, 0111_1000_0000_0000b
    shr bx, 5
    or cx, bx
    
    ;the bits 10-15 of C are the same as the bits 1-6 of B
    mov bx, [B]
    and bx, 0000_0000_0111_1110b
    shl bx, 9
    or cx, bx
    
    
    push dword 0
    call [exit]

