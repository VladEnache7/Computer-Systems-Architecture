bits 32

global start

extern exit

import exit msvcrt.dll
 
segment data use32 class = data

    a dw 1
    b dw 1
    c dw 1
    d dw 1 
    
segment code use32 class = code
start:

    mov ax, [a] ; ax = a
    sub ax, [b] ; ax = a - b
    add ax, [c] ; ax = a - b + c
    mov bx, [d] ; bx = d
    add bx, [d] ; bx = d + d
    sub ax, bx  ; ax = ax - bx
    push dword 0
    call [exit]

