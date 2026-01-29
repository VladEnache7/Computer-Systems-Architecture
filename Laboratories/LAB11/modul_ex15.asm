bits 32 


extern exit               
import exit msvcrt.dll    
global transformation 

segment code use32 class=code
    transformation:
        ;input = 1 and 0 on stack and at the end a 'b'
        ;ouput = in edx - the number
        pop ebx     ;saving the address of return into ebx
        mov edx, 0  ;building the number
        mov ecx, 1  ;used for the powers of 2
        
        while_digit2:
            pop eax     ;eax = 00 00 00 0x and x = 0 or 1 or 'b'
            
            ;exiting in case of 'b' in stack
            cmp eax, 'b'
            je exit_while_digit2
            
            mul cl      ;ax = al * cl
            add edx, eax;adding in edx, the result of the multiplication
            
            ;ecx *= 2 (with the help of eax)
            mov eax, 2
            mul cl      ;ax = cl * 2
            mov ecx, eax
        jmp while_digit2
        
        exit_while_digit2:    
        push ebx    ;restoring the return address  
        ret
            
        push    dword 0      
        call    [exit]       
