bits 32 

global start

extern exit

import exit msvcrt.dll
 
segment data use32 class = data
    
    a db 6h
    b dd 11223344h
    c db 22h
    d db 33h
    x dq 1122334455667788h
    
segment code use32 class = code
start:;x - (a + b + c * d) / (9 - a) - unsigned
    
    ;c * d
    mov AL, [c]     ;AL = c
    mul BYTE [d]    ;AX = c * d
    
    ;c * d -> ECX
    push WORD 0
    push AX         ;[ESP]1 = EAX = c * d
    pop ECX         ;ECX = c * d
    
    ;a -> EAX
    mov EAX, 0      ;EAX = 00 00 00 00
    mov AL, [a]     ;AL -> EAX = a
    
    ;b -> EBX
    mov EBX, [b]
    
    ;dword -> (a + b + c * d)
    add EAX, EBX    ;EAX = a + b 
    add EAX, ECX    ;EAX = (a + b) + c * d
    
    
    ;word -> (9 - a)
    mov BL, 9
    sub BL, [a]     ;BL = (9 - a)
    mov BH, 0       ;BL -> BX = (9 - a)
    
    ;converting EAX to EDX:EAX and BX to EBX in order to not loose numbers dividing the elements
    mov EDX, 0      ;EAX -> EDX:EAX
    push WORD 0
    push BX
    pop EBX         ;BX -> EBX
    
    div EBX          ;EAX = (a + b + c * d) / (9 - a)
    
    ;(a + b + c * d) / (9 - a) -> EDX:EAX
    mov EDX, 0      ;EAX -> EDX:EAX
    
    ;x -> ECX:EBX
    mov EBX, [x]
    mov ECX, [x + 4];ECX:EBX = x
    
    ;ECX:EBX - EDX:EAX = x - (a + b + c * d) / (9 - a)
    sub EBX, EAX
    sbb ECX, EDX    ;ECX:EBX = x - (a + b + c * d) / (9 - a)
    
    push dword 0
    call [exit]


