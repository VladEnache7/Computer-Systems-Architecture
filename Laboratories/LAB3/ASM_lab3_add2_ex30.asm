bits 32 

global start

extern exit

import exit msvcrt.dll
 
segment data use32 class = data
    
    a db 11h
    b dw 2233h
    c dd 44556677h
    d dq 1122334455667788h
    
segment code use32 class = code
start: ; d - a + c + c - b + a - signed
    
    ;d -> ECX:EBX
    mov EBX, [d]
    mov ECX, [d + 4]    ;ECX:EBX = d
    
    ;a -> EDX:EAX
    mov AL, [a]         ;AL = a
    cbw                 ;AL -> AX = a
    cwde                ;AX -> EAX = a
    cdq                 ;EAX -> EDX:EAX
    
    ;qword -> d - a 
    sub EBX, EAX
    sbb ECX, EDX        ;ECX:EBX = d - a
    
    push EDX            ;[ESP]1 = EDX 
    push EAX            ;[ESP]2 = EAX 
    
    ;c -> EDX:EAX
    mov EAX, [c]        ;EAX = c
    cdq                 ;EAX -> EDX:EAX = c
    
    ;qword -> (d - a) + c
    add EBX, EAX        
    adc ECX, EDX        ;ECX:EBX = d - a + c
    
    ;qword -> (d - a + c) + c
    add EBX, EAX        
    adc ECX, EDX        ;ECX:EBX = d - a + c + c
    
    ;b -> EDX:EAX
    mov AX, [b]         ;AX = b
    cwde                ;AX -> EAX = b
    cdq                 ;EAX -> EDX:EAX = b
    
    ;qword -> (d - a + c + c) - b
    sub EBX, EAX
    sbb ECX, EDX        ;ECX:EBX = d - a + c + c - b
    
    pop EAX
    pop EDX             ;EDX:EAX = a
    
    ;qword -> (d - a + c + c - b) + a
    add EBX, EAX
    adc ECX, EDX        ;ECX:EBX = d - a + c + c - b + a
    
    push dword 0
    call [exit]


