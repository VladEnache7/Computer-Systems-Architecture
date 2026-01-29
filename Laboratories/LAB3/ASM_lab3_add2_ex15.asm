bits 32 

global start

extern exit

import exit msvcrt.dll
 
segment data use32 class = data
    
    a db -55h
    b dw 1122h
    c dd 44667788h
    
segment code use32 class = code
start: ;c + a + b + b + a - signed
    
    ;c -> ECX
    mov ECX, [c]    ;ECX = c
    
    ;b -> EBX
    mov AX, [b]     ;AX = b
    cwde            ;AX -> EAX = b
    mov EBX, EAX    ;EBX = b
    
    ;a -> EAX
    mov AL, [a]      ;AL = a
    cbw             ;AL -> AX = a
    cwde            ;AX -> EAX = a
    
    ;adding the numbers
    add ECX, EAX    ;ECX = c + a
    add ECX, EBX    ;ECX = c + a + b
    add ECX, EBX    ;ECX = c + a + b + b
    add ECX, EAX    ;ECX = c + a + b + b + a
    
    push dword 0
    call [exit]


