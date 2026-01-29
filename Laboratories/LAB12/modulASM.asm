bits 32

global _ASMconcatenate
segment data public data use32
	s1 dd 0
    s2 dd 0
    len dd 0
segment code public code use32
_ASMconcatenate:
	push ebp
	mov ebp,esp
    
    mov edi, [esp + 8]  ;edi = s1
    mov esi, [esp + 12] ;esi = s2
    mov ecx, [esp + 16] ;ecx = len(s2)
    
    ;going to the last character in s1
    mov eax, 0
    while_not0:
        cmp al, [edi]
        je exit_while
        inc edi
        jmp while_not0
        
    exit_while:
    mov [edi], byte ' ' ;putting a space
    ;concatenating s2 to s1
    inc edi
    while_lens2:
        movsb ;[edi] = [esi], inc edi, inc esi
        loop while_lens2
        
    mov [edi], byte 0    ;putting the end to s1
    
    pop ebp
    ret