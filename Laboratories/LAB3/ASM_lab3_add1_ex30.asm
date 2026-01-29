bits 32 

global start

extern exit

import exit msvcrt.dll
 
segment data use32 class = data
    
    a db 10
    b dw 20
    c dd 5
    d dq 4
    
segment code use32 class = code
start: ;(b + c + a) - (d + c + a) - unsigned

    ;b -> EBX
    mov BX, [b]     ;BX = b
    push WORD 0
    push BX
    pop EBX         ;BX -> EBX = b
    
    ;a -> EAX
    mov AL, [a]     ;AL = a
    mov AH, 0       ;AL -> AX = a
    push WORD 0
    push AX
    pop EAX         ;AX -> EAX = a
    mov EDX, EAX    ;EDX = a
    
    ;adding a + b + c 
    add EAX, EBX    ;EAX = a + b
    add EAX, [c]    ;EAX = b + c + a
    push EAX        ;[ESP]1 = b + c + a
    
    add EDX, [c]    ;EDX = a + c
    mov EAX, EDX    ;EAX = a + c
    mov EDX, 0      ;EAX -> EDX:EAX = a + c
    
    ;d -> ECX:EBX
    mov EBX, [d]
    mov ECX, [d + 4];ECX:EBX = d
    
    ;adding d + c + a (qword)
    add EAX, EBX
    adc EDX, ECX    ;EDX:EAX = (d + c + a)
    
    ;(b + c + a) -> ECX:EBX
    pop EBX         ;EBX = (b + c + a)
    mov ECX, 0      ;EBX -> ECX:EBX = (b + c + a)
    
    ;final subtraction
    sub EBX, EAX
    sbb ECX, EDX    ;ECX:EBX = (b + c + a) - (d + c + a)
    
    push dword 0
    call [exit]


