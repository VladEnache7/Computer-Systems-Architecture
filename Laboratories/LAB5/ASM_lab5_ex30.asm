bits 32 


global start        

extern exit               
import exit msvcrt.dll    


segment data use32 class=data
    
    s1 db 1, 3, 6, 2, 3, 2
    s2 db 6, 3, 8, 1, 2, 5
    len equ $ - s2
    r times len db 0

segment code use32 class=code
    start: ;Two byte strings S1 and S2 of the same length are given. Obtain the string D where each element is the sum of the corresponding elements from S1 and S2
        
        mov esi, 0 ; index of both s1 and s2
        mov ecx, len
        repeat:
            mov al, [s1 + esi] 
            add al, [s2 + esi]
            mov [r + esi], al
            inc esi
        loop repeat
        
        push    dword 0      
        call    [exit]       
