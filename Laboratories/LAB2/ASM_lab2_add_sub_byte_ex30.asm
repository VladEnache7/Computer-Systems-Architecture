bits 32 ; d-(a+b)-(c+c)

global start

extern exit

import exit msvcrt.dll
 
segment data use32 class = data
 
    a db 1
    b db 1
    c db 1
    d db 1
    
segment code use32 class = code
start:

    mov ax, [d] ; ax = d
    mov bx, [a]
    add bx, [b] ; bx = a + b
    mov cx, [c]
    add cx, [c] ; cx = c + c
    sub ax, bx ; ax = ax - bx
    sub ax, cx ; ax = ax - cx
    
    
    push dword 0
    call [exit]

