bits 32 
global start        

extern exit, printf              
import exit msvcrt.dll  
import printf msvcrt.dll  
extern transformation
                          
segment data use32 class=data
    given db '10100111b', '01100011b', '110b', '101011b', '10101010b', 0
    obtain resb 100
    format2 db "b = %d ,", 0
    format1 db "%c", 0
    
segment code use32 class=code
    start:
        mov edi, given  ;edi = the address of given
        mov esi, obtain ;esi the address of obtain
        while_elms:     ;while we haven't arrived at the end of the string
            
            cmp [edi], byte 0
            je exit_while_elms  ;if is the end of the string
            
            
           
            push dword 'b'      ;the sign of the end of bits in the stack
            while_bits:
                mov eax, 'b'         ;for scasb
                scasb       ;if the caracter is 'b' - the end of the string, inc(edi)
                je exit_while_digit ;if the end of the string of bits
                
                ;ebx = '0' or '1'
                mov ebx, 0
                mov bl, [edi - 1]
                
                ;printf("%c", ebx);
                push ebx
                push dword format1
                call [printf]
                add esp, 4 * 2
                
                mov edx, 0
                mov dl, [edi - 1]  ;edx = '0' or '1'
                sub dl, '0'        ;edx = 0 or 1
                push edx            ;pushing the bits on the stack
                jmp while_bits
            
            exit_while_digit:
            
            call transformation     ;calling the function
            
            ;saving the number in the obtain array
            mov [esi], edx
            inc esi
            
            ;printf("%d ", edx)
            push edx
            push dword format2
            call [printf]
            add esp, 4 * 2
            
        jmp while_elms
            
        exit_while_elms:
        push    dword 0  
        call    [exit]       
