bits 32 


global start        


extern exit, fopen, fprintf  
;importing the functions           
import exit msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll


segment data use32 class=data
    file_name db "ex15_files.txt", 0;for printing
    string db "Ana @re $$$ m&r& si *# b!n%n^", 0
    len_string equ $ - string
    write_mode db "w", 0
    format db "%s", 0
    descriptor dd 0
    
    
segment code use32 class=code
    start:
        
        mov esi, string
        mov ecx, len_string
        jecxz final
        
        loop_change:
            cmp [esi], byte '!'
            jz special
            cmp [esi], byte '@'
            jz special
            cmp [esi], byte '#'
            jz special
            cmp [esi], byte '$'
            jz special
            cmp [esi], byte '%'
            jz special
            cmp [esi], byte '^'
            jz special
            cmp [esi], byte '&'
            jz special
            cmp [esi], byte '*'
            jz special
            jmp after
            special:
            ;if it is a special character
            mov [esi], byte 'X'
            
            after:
            inc esi
        loop loop_change
            
            
        ;fopen("ex15_files.txt", "w");    
        push dword write_mode
        push dword file_name
        call [fopen]
        add esp, 4 * 2
        mov [descriptor], eax
        
        ;fprintf(FILE * stream, "%s", string);
        push dword string
        push dword format
        push dword [descriptor]
        call [fprintf]
        add esp, 4 * 2
        
        final:
        push    dword 0     
        call    [exit]   
