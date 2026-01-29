bits 32 

global start

extern exit

import exit msvcrt.dll
 
segment data use32 class = data
    
    a db 11h
    b db 22h
    c db 33h
    e dd 11223344h
    x dq 1122334455667788h
    
    
segment code use32 class = code
start:;x - (a * b * 25 + c * 3) / (a + b) + e - signed
    
    ;(a * b * 25)
    mov AL, [a]     ;AL = a
    mul BYTE [b]    ;AX = a * b
    cwd             ;AX -> DX:AX
    mov BX, 25      ;BX = 25
    imul BX         ;DX:AX = a * b * 25
    
    push DX
    push AX         ;[ESP]1 = DX:AX = a * b * 25
    pop EBX         ;EBX = a * b * 25
    
    ;(c * 3)
    mov AL, [c]     ;AL = c
    mov CL, 3       ;BL = 3
    imul CL         ;AX = c * 3
    cwde            ;AX -> EAX = c * 3
    
    add EAX, EBX    ;EAX = (a * b * 25 + c * 3)
    
    push EAX        ;[ESP]1 = EAX = (a * b * 25 + c * 3)
    
    
    mov AL, [a]     ;AL = a
    mov BL, [b]     ;BL = b
    add AL, BL      ;AL = (a + b)
    cbw             ;AL -> AX = (a + b)
    mov BX, AX      ;BX = (a + b)
    
    pop AX
    pop DX          ;DX:AX = (a * b * 25 + c * 3)
    
    idiv BX         ;AX = (a * b * 25 + c * 3) / (a + b)
    cwde            ;AX -> EAX
    
    ;dword -> [(a * b * 25 + c * 3) / (a + b)] + e
    mov ECX, [e]
    add EAX, ECX    ;EAX = (a * b * 25 + c * 3) / (a + b) + e
    cdq             ;EAX -> EDX:EAX
    
    mov EBX, [x]
    mov ECX, [x + 4];ECX:EBX = x
    
    ;x - ((a * b * 25 + c * 3) / (a + b) + e)
    sub EBX, EAX
    sbb ECX, EDX    ;ECX:EBX = x - (a * b * 25 + c * 3) / (a + b) + e
    
    push dword 0
    call [exit]


