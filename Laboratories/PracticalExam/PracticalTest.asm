bits 32 
global start    
    
;Se citeste de la tastatura un nume de fisier input.txt si un caracter c. Fisierul input.txt contine cuvinte separate prin spatiu. Sa se scrie in fisierul output.txt doar cuvintele in care apare caracterul c citit pe ultima pozitie (adica apare ca ultima litera din cuvant).

;input.txt: totem pere banane mandarine   c: m     output.txt: totem


extern exit, fopen, fscanf, fprintf, scanf, fclose             
import exit msvcrt.dll   
import fopen msvcrt.dll  
import fprintf msvcrt.dll  
import scanf msvcrt.dll 
import fscanf msvcrt.dll 
import fclose msvcrt.dll 
                          
segment data use32 class=data
    file_in resb 20
    read_mode db "r", 0
    descriptor1 resd 1
    
    file_out db "output.txt", 0
    write_mode db "w", 0
    descriptor2 resd 1
    
    string_format db "%s", 0
    character_format db "%c", 0
    
    c resd 1
    
    aword resb 30
segment code use32 class=code
    start:
    
        ;reading the caracter form the keyboard
        ;scanf(character_format, &c)
        push dword c
        push dword character_format
        call [scanf]
        add esp, 2 * 4
        
        ;reading the file name from the user
        ;scanf(string_format, &file_in);
        push dword file_in
        push dword string_format
        call [scanf]
        add esp, 2 * 4
        
        
        
        ;openning the file for reading
        ;fopen(file_in, read_mode)
        push dword read_mode
        push dword file_in
        call [fopen]
        add esp, 2 * 4
        mov [descriptor1], eax
        
        
        
        ;openning the file for writing
        ;fopen(file_out, write_mode)
        push dword write_mode
        push dword file_out
        call [fopen]
        add esp, 2 * 4
        mov [descriptor2], eax
        
        
        ;reading from the file
        ;while(fscanf(descriptor1, string_format, aword) != EOF)
        while_fscanf:
            ;fscanf(descriptor1, string_format, aword)
            push dword aword
            push dword string_format
            push dword [descriptor1]
            call [fscanf]
            add esp, 3 * 4
            
            ;if we finished to read the words
            cmp eax, -1
            je exit_while_fscanf
            
            
            ;going to the last character
            mov esi, aword
            while_not_space:
                cmp [esi], byte 0
                je space
                inc esi
                jmp while_not_space
            space:    
            ;[esi-1] - the last character
            mov eax, [esi - 1]
            cmp eax, [c]
            jne not_printing
            
            ;printing
            ;fprintf(descriptor2, string_format, aword)
            push dword aword
            push dword string_format
            push dword [descriptor2]
            call [fprintf]
            add esp, 3 * 4
            
            not_printing:
            jmp while_fscanf
        
        exit_while_fscanf:
        
        ;closing the files
        ;fclose(descriptor1)
        push dword [descriptor1]
        call [fclose]
        add esp, 1 * 4
        
        ;fclose(descriptor2)
        push dword [descriptor2]
        call [fclose]
        add esp, 1 * 4
        
        
        push    dword 0      
        call    [exit]       
