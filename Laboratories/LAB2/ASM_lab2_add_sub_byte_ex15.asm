bits 32 ;a-b-d+2+c+(10-b)
        ;10 - 5 - 8 + 2 + 6 + 5
global start

extern exit

import exit msvcrt.dll
 
segment data use32 class = data

    a: db 12h
    
    
segment code use32 class = code
start:

    mov ax, [a]
    
    push dword 0
    call [exit]

