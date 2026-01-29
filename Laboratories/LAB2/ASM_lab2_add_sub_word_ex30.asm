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
    mov bx, [c] ; bx = c
    sub bx, [d] ; bx = c - d
    add bx, [a] ; bx = c - d + a
    add ax, bx ; ax = a-b+(c-d+a)
    
    push dword 0
    call [exit]

