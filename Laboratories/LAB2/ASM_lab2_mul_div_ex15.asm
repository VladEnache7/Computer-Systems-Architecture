bits 32 ; (a*2)+2*(b-3)-d-2*c

global start

extern exit

import exit msvcrt.dll
 
segment data use32 class = data

    a db 1
    b db 1
    c db 1
    d dw 1
    two db 2
    
segment code use32 class = code
start:
    
    mov al, [a] 
    imul byte [two]  ; ax = a * 2
    mov bx, ax  ; bx = a * 2
    mov cl, [b]
    sub cl, 3
    mov al, cl ; al = b - 3
    imul byte [two] ; ax = 2 * (b - 3)
    add bx, ax ; bx = a * 2 + 2 * (b - 3)
    sub bx, [d] ; bx = a * 2 + 2 * (b - 3) - d-2*c
    mov al, [c]
    imul byte [two] ; ax = c * 2
    sub bx, ax
    push dword 0
    call [exit]


