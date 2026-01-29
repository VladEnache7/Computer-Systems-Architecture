bits 32 
global start        
;1.	Se dă un șir de 10 numere în baza 16 în fișierul input.txt. 
;Să se determine cifra minimă din fiecare număr.
;Să se afișeze acest șir al cifrelor minime, în baza 10, pe ecran.


extern exit, fopen, fscanf, printf  
          
import exit msvcrt.dll
import fopen msvcrt.dll  
import fscanf msvcrt.dll   
import printf msvcrt.dll   

segment data use32 class=data
    filename db "input_ex1.txt", 0
    descriptor resd 1
    read_mode db "r", 0
    format_read db "%x%x%x%x%x%x%x%x%x%x", 0
    format_write db "%x, ", 0
    nrs resd 10
    sixteen dd 16

segment code use32 class=code
    start:
        
        ;opening the file
        ;fopen("input.txt", "r");
        push dword read_mode
        push dword filename
        call [fopen]
        add esp, 2 * 4
        mov [descriptor], eax
        
        ;scanning 10 numbers from the file
        ;fscanf("%x%x%x%x%x%x%x%x%x%x", &n1, &n2, &n3, &n4, &n5, &n6, &n7, &n8, &n9, &n10);
        push dword (nrs + 4 * 9)
        push dword (nrs + 4 * 8)
        push dword (nrs + 4 * 7)
        push dword (nrs + 4 * 6)
        push dword (nrs + 4 * 5)
        push dword (nrs + 4 * 4)
        push dword (nrs + 4 * 3)
        push dword (nrs + 4 * 2)
        push dword (nrs + 4 * 1)
        push dword nrs
        push dword format_read
        push dword [descriptor]
        call [fscanf]
        add esp, 12 * 4
        
        mov ecx, 10     ;executing the loop 10 times
        mov esi, nrs    ;esi = offset of the array nrs
        cld             ;DF = 0
        while_nrs:
            
            lodsd   ;eax = [esi], esi += 4
            mov ebx, 0xF    ;ebx = the smallest
            
            ;fiding the smallest digit - ebx
            while_bytes:
                mov edx, 0
                div dword [sixteen]   ;edx = eax / 16  
                cmp edx, ebx
                jnb not_minim     ;if edx is not below ebx
                
                ;if we found a smaller digit
                mov ebx, edx
                
                not_minim:
                
                cmp eax, 0
                jne while_bytes
                
            push ecx    ;saving the value of ecx
            
            ;printing the smallest digit    
            ;printf("%x ", ebx);
            push ebx
            push dword format_write
            call [printf]
            add esp, 2 * 4
            
            pop ecx     ;restoring the ecx
        loop while_nrs
            
            
        push    dword 0      
        call    [exit]       
