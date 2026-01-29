bits 32
global start        

extern exit              
import exit msvcrt.dll    
segment data use32 class=data
    s1 db "Does", 0
    between resb 30
    s2 db "work?", 0
    len db 5
    
segment code use32 class=code
    start:
    mov edi, s1  ;edi = s1
    mov esi, s2 ;esi = s2
    mov ecx, [len] ;ecx = len(s2)
    
    ;going to the last character in s1
    mov eax, 0
    while_not0:
        cmp al, [edi]
        je exit_while
        inc edi
        jmp while_not0
        
    exit_while:
    
    mov [edi], byte ' ' ;putting a space
    inc edi
    ;concatenating s2 to s1
    while_lens2:
        movsb ;[edi] = [esi], inc esi, inc edi
        loop while_lens2
        
    mov [edi], byte 0
    inc edi   
        push    dword 0      
        call    [exit]       