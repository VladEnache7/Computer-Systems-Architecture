bits 32 
global start      

extern exit
import exit msvcrt.dll

;Write a bubble sort in assembly language.

segment data use32 class=data
    arr db 8, 5, 2, 6, 9, 3, 1, 4, 7, 0
    len equ $-arr

segment code use32 class=code
start:

    mov dx, 1   ;changed = 1
    
    while_changed:
        cmp dx, 0   ;changed == 0
        je the_end

        mov esi, arr
        mov dx, 0
        mov ecx, len - 1

        while_j:
            mov al, [esi]
            mov bl, [esi + 1]
            cmp al, bl
            jle next

            mov [esi], bl
            mov [esi + 1], al
            mov dx, 1       ;changed = 1

            next:
                inc esi
                loop while_j
                jmp while_changed

    the_end:
    push dword 0
    call [exit]



    
    

