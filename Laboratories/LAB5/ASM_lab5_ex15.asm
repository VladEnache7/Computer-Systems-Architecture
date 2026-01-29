bits 32 v

global start

extern exit

import exit msvcrt.dll
 
segment data use32 class = data
    
    a db '2', '1', '3', '3', '4', '2', '6'
    la equ $ - a
    b db '4', '5', '7', '6', '2', '1'
    lb equ $ - b
    r times (la + lb) db 0
    dif equ 'a' - '0' - 1
    
segment code use32 class = code
start: ;Two byte strings A and B are given. Obtain the string R by concatenating the elements of B in reverse order and the odd elements of A.
    
    mov ecx, lb 
    mov edi, 0
    jecxz final1 ; it skips the loop if the length of b is 0
    reverse1:
        mov al, [b + ecx - 1]
        mov [r + edi], al
        
        inc edi
    loop reverse1
    final1:
    
    mov ecx, la
    jecxz final2 ; it skips the loop if the length of b is 0
    mov esi, 0
    reverse2:
        mov al, [a + esi]
        sub al, '0' ;caracter in number
        test al, 01h
        jz even_number
            ;if is an odd number
            mov bl, [a + esi]
            add bl, '0' ;number in caracter
            sub bl, dif
            mov [r + edi], bl
            inc edi
        
        even_number:
            inc esi  
            
        cmp esi, la 
    jb reverse2
    final2         
    push dword 0
    call [exit]


