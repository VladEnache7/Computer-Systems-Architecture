bits 32

global start

extern exit

import exit msvcrt.dll
 
segment data use32 class = data

    a db 1
    b db 2
    c db 3
    d db 4
    e dw 5
    f dw 6
    g dw 7
    h dw 8
    three db 3
    
segment code use32 class = code
start:
    ;f*(e-2)/[3*(d-5)]
    mov al, [d]
    sub al, 5
    mul byte [three] ; ax = 3*(d-5)
    mov bx, ax ; bx = 3*(d-5)
    mov ax, [e]
    sub ax, 2
    mul word [f] ; dx:ax = f*(e-2)
    div bx
    push dword 0
    call [exit]


