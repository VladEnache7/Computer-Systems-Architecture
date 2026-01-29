bits 32 

global start

extern exit

import exit msvcrt.dll
 
segment data use32 class = data
    
    A db 1011_0100b
    B dw 1000_0110_0001_0101b
    
segment code use32 class = code
start: 
    
    ;the bits 0-3 are the same as the bits 2-5 of A
    mov ecx, 0
    mov al, [A]
    and al, 0011_1100b
    shr al, 2
    or cl, al
    
    ;the bits 4-7 are the same as the bits 6-9 of B.
    mov ax, [B]
    and ax, 0000_0011_1100_0000b
    shr ax, 2
    or cl, al
    push dword 0
    call [exit]
