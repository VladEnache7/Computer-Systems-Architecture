bits 32 


global start        


extern exit, fopen, fprintf, scanf 
;importing the functions           
import exit msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import scanf msvcrt.dll


segment data use32 class=data
    file_name db "ex30_files.txt", 0;for printing
    write_mode db "w", 0
    format_print db "%s", 0
    format_scan db "%c", 0
    descriptor dd 0
    c resb 1
    string resb 100
    
    
segment code use32 class=code
    start:
        
        ;fopen(file_name, "a");
        push dword write_mode
        push dword file_name
        call [fopen]
        add esp, 4 * 2
        
        cmp eax, 0
        jz final
        mov [descriptor], eax
        
        while_not_$:
            mov dl, 0           ;digit = False
            mov edi, string     ; saving
            cld                 ;DF = 0
            while_not_space:    ; reading a word
                
                
                ;scanf("%c", c)
                push dword c
                push dword format_scan
                call [scanf]
                
                cmp byte [c], '$'
                je after1
                
                ;if c is a digit
                cmp byte [c], 48
                jb not_digit
                cmp byte [c], 57
                ja not_digit    
            
                mov dl, 1       ;digit = True
                
                 
                not_digit:
                mov al, [c]
                stosb   ;[edi] = al, inc edi
                cmp byte [c],  ' '
                jnz while_not_space
            
            after1
            cmp dl, 1
            mov [edi], byte 0
            jnz not_write
            
            ;fprintf(descriptor, "%s", string);
            push dword string
            push dword format_print
            push dword [descriptor]
            call [fprintf]
            add esp, 4 * 3
            
            
            not_write:
            
        final:    
        push    dword 0     
        call    [exit]   
