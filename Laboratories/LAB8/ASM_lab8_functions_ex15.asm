bits 32 


global start        


extern exit, scanf, printf  
;importing the functions           
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll


segment data use32 class=data
    message db "%x + %x = %x (in hexa)", 0;for printing
    a dd 0                      ;the first number           
    b dd 0                      ;the second number
    format db "%d", 0           ;for reading
    result dd 0
    
    
segment code use32 class=code
    start:
        ;scanf("%d", a);
        push dword a
        push dword format
        call [scanf]
        add esp, 4 * 2
        
        ;scanf("%d", b);
        push dword b
        push dword format
        call [scanf]
        add esp, 4 * 2
        
        ;computing the sum
        mov eax, [a]
        add eax, [b]
        mov [result], eax
        
        ;printf("%d + %d = %d", a, b, result);
        push dword [result]
        push dword [b]
        push dword [a]
        push dword message
        call [printf]
        add esp, 4 * 4
        
        push    dword 0     
        call    [exit]   
