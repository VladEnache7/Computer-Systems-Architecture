bits 32 


global start        


extern exit, scanf, printf  
;importing the functions           
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll


segment data use32 class=data
    message db "The smallest number is %d", 0;for printing
    x dd 0                      ;used for reding the numbers          
    format db "%d", 0           ;for reading
    smallest dd 0
    
    
segment code use32 class=code
    start:
        ;reading the first element
        ;scanf("%d", smallest);
        push dword smallest
        push dword format
        call [scanf]
        add esp, 4 * 2
        
        
        Repeat:
        
            ;scanf("%d", x);
            push dword x
            push dword format
            call [scanf]
            add esp, 4 * 2
            
            mov eax, [x]
            cmp eax, 0
            jz after
            
            cmp eax, [smallest]
            jnle not_smaller
                ;if x < smallest
                mov [smallest], eax
            ;else    
            not_smaller:
            
            
            jmp Repeat   ;it stops the loop at the first 0 read
            
        after:
        
        ;printf("The smallest number is %d", smallest);
        push dword [smallest]
        push dword message
        call [printf]
        add esp, 4 * 2
        
        push    dword 0     
        call    [exit]   
