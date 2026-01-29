bits 32 

global start

extern exit

import exit msvcrt.dll
 
segment data use32 class = data
    
    R dd 1010_1111_0001_1100_1010_1101_1001_1100b
    T dd 0001_0001_1111_0101_1010_1111_1001_1010b
    Q resd 1
    
segment code use32 class = code
start: 
    ;the bits 25-31 of Q are the same as the bits 5-11 of R.
    mov eax, 0
    mov ebx, [R]
    and ebx,0000_0000_0000_0000_0000_1111_1110_0000b
    shl ebx,20
    or eax,ebx
    ;the bits 7-24 of Q are the same as the bits 7-24 of (R XOR T).
    mov ebx,[R]
    xor ebx,[T]
    and ebx,0000_0001_1111_1111_1111_1111_1000_0000b
    or eax,ebx
    ;the bits 0-6 of Q are the same as the bits 10-16 of T
    mov ebx,[T]
    and ebx,0000_0000_0000_0001_1111_1100_0000_0000b
    shr ebx,10
    or eax,ebx
    push dword 0
    call [exit]
