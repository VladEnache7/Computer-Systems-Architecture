bits 32 

global start

extern exit

import exit msvcrt.dll
 
segment data use32 class = data
    
    a dw 1122h
    b db 05h
    c db 32h
    e dd 33445566h
    x dq 8877665544332211h
    
segment code use32 class = code
start:;a * b - (100 - c) / (b * b) + e + x - unsigned
    
    mov AL, [b]     ;AL = b
    mov AH, 0       ;AL -> AX = b (unsigned)
    mul WORD [a]    ;DX:AX = a * b
    
    push DX
    push AX         ;[ESP]1 = DX:AX = a * b
   
    ;(100 - c) -> DX:AX
    mov AL, 100
    sub AL, [c]     ;AL = (100 - c)
    mov AH, 0       ;AL -> AX = (100 - c)
    mov DX, 0       ;AX -> DX:AX = (100 - c)
    
    push DX
    push AX         ;[ESP]2 = DX:AX = (100 - c)
    
    mov AL, [b]
    mul BYTE [b]    ;AX = b * b
    mov BX, AX      ;BX = (b * b)
    
    pop AX          
    pop DX          ;pop [ESP]2 -> DX:AX = (100 - c)
    
    div BX          ;AX = (100 - c) / (b * b)
    
    ;AX -> EBX
    push WORD 0
    push AX
    pop EBX         ;EBX = (100 - c) / (b * b)
    
    pop EAX         ;pop [ESP]1 -> EAX = a * b
    
    mov ECX, [e]    ;ECX = e
    
    sub EAX, EBX    ;EAX = (a * b) - [(100 - c) / (b * b)]
    add EAX, ECX    ;EAX = [a * b - (100 - c) / (b * b)] + e
    mov EDX, 0      ;EAX -> EDX:EAX
    
    ;x -> ECX:EBX
    mov EBX, [x]
    mov ECX, [x + 4];ECX:EBX = x
    
    ;last addition
    add EAX, EBX
    adc EDX, ECX    ;EDX:EAX = a * b - (100 - c) / (b * b) + e + x
    
    push dword 0
    call [exit]


