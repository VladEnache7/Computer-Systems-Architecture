
bits 32 

global start

extern exit

import exit msvcrt.dll
 
segment data use32 class = data

    a db 1
    b db 2
    c db 3
    d dw 4
    five db 5
    two db 2
    
segment code use32 class = code
start:
    ;[(a-b)*5+d]-2*c
    mov al, [a] ; al = a
    sub al, [b] ; al = a-b
    imul byte [five]    ; ax = (a-b)*5
    add ax, [d] ; ax = (a-b)*5+d
    mov bx, ax  ; bx = (a-b)*5+d
    mov al, [c] ; al = c
    imul byte [two]     ; ax = 2 * c
    sub bx, ax  ; bx = (a-b)*5+d-2*c 
    
    push dword 0
    call [exit]

