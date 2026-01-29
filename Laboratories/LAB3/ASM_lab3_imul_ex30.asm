bits 32 

global start

extern exit

import exit msvcrt.dll
 
segment data use32 class = data
    
    a dw 8855h
    b db 4h
    c db 44h
    e dd 44883366h
    x dq 2233445566778899h
  
segment code use32 class = code
start:;a * b - (100 - c) / (b * b) + e + x
    
    ;a * b -> DX:AX
    mov AL, [b]     ;AL = b
    cbw             ;AL -> AX = b
    imul WORD [a]    ;DX:AX = a * b
    
    push DX
    push AX         ;[ESP]1 = DX:AX = a * b
    
    ;b * b -> BX 
    mov AL, [b]     ;AL = b
    imul BYTE [b]    ;AX = b * b
    mov BX, AX      ;BX = b * b
    
    ;(100 - c) -> DX:AX
    mov AL, 100
    sub AL, [c]     ;AL = (100 - c)
    cbw             ;AL -> AX
    cwd             ;AX -> DX:AX = (100 - c)
    
    idiv BX         ;AX = (100 - c) / (b * b)
    cwde            ;AX -> EAX = (100 - c) / (b * b)
    
    pop EBX         ;EBX = a * b
    
    sub EBX, EAX    ;EBX = a * b - [(100 - c) / (b * b)]
    
    add EBX, [e]    ;EBX = [a * b - (100 - c) / (b * b)] + e
    
    ;EBX -> EDX:EAX
    mov EAX, EBX    ;EAX = EBX
    cdq             ;EAX -> EDX:EAX
    
    ;x -> ECX:EBX 
    mov EBX, [x]
    mov ECX, [x + 4];ECX:EBX = x
    
    ;[a * b - (100 - c) / (b * b) + e] + x -> EDX:EAX
    add EAX, EBX
    adc EDX, ECX    ;EDX:EAX = a * b - (100 - c) / (b * b) + e + x
    
    push dword 0
    call [exit]


