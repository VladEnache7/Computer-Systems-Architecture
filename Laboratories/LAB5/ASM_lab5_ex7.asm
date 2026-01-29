bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class = data
    s1 db 1, 3, 5, 7
    len equ $ - s1
    s2 db 2, 6, 9, 4
    d resb 2 * len
    
    
segment code use32 class = code
    start:
    
    
    mov ecx, len
    mov eax, 0
    mov ebx, 0
    
    jecxz final
    Repeta:
        mov dl, [s1 + eax]
        mov [d + ebx], dl       ;first puting an element from s1
        inc ebx             
        
        mov dl, [s2 + eax]
        mov [d + ebx], dl       ;than puting an element from s2
        inc ebx             
        
        inc eax
        loop Repeta
    final:
    
    push dword 0
    call [exit]