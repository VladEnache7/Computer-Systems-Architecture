bits 32 v

global start

extern exit

import exit msvcrt.dll
 
segment data use32 class = data
    
    a db 10h
    b dw 2000h
    c dd 1000h
    d dq 50000000000000h
         
    
segment code use32 class = code
start: ;a + b - c + (d - a)
    mov AL, [a]     ;AL = a
    mov AH, 0       ;unsigned conversion AL -> AX
    add AX, [b]     ;AX = a + b
    mov DX, 0       ;unsigned conversion AX -> DX:AX = a + b
    push DX
    push AX         ;stack = DX:AX = a + b
    pop EAX         ;EAX = a + b
    sub EAX, [c]    ;EAX = a + b - c
    push EAX        ;[ESP]1 = a + b - c
    
    mov AL, [a]     ;AL = a
    mov AH, 0       ;AL -> AX = a
    push WORD 0     
    push AX
    pop EAX         ;AX -> EAX = a
    mov EDX, 0      ;EAX -> EDX:EAX
    
    mov EBX, [d]
    mov ECX, [d + 4];ECX:EBX = d
    
    sub EBX, EAX 
    sbb ECX, EDX    ;ECX:EBX = d - a
    
    pop EAX         ;EAX = a + b - c
    mov EDX, 0      ;EAX -> EDX:EAX = a + b - c
    
    add EAX, EBX
    adc EDX, ECX    ;EDX:EAX = a + b - c + (d - a)
    
    push dword 0
    call [exit]


