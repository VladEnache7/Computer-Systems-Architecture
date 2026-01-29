bits 32 
global start        

;A file name is given in the data segment. This contains digits separated by space (the digits are from the set of 16 base digits separated).
;Print each digit read from the file and the number of 0 bits in the binary representation of it.

extern exit, fopen, printf, fclose, fscanf               
import exit msvcrt.dll    
import fopen msvcrt.dll
import printf msvcrt.dll
import fclose msvcrt.dll
import fscanf msvcrt.dll


segment data use32 class=data
    file db "input-ex22.txt", 0
    read_mode db "r", 0
    descriptor resd 1
    x resd 1
    scanf_format db "%x", 0
    printf_format db "%x - %d,", 0

segment code use32 class=code
    start:
        
        ;fopen(file, "r")
        push dword read_mode
        push dword file
        call [fopen]
        add esp, 4 * 2
        mov [descriptor], eax

        ;while(fscanf(descriptor, "%x", &number) != EOF)
        while_reading:
            ;fscanf(descriptor, "%x", &number)
            push dword x
            push dword scanf_format
            push dword [descriptor]
            call [fscanf]
            add esp, 4 * 3

            ;if(fscanf(descriptor, "%x", &number) == EOF)
            cmp eax, -1
            je end_reading
            
            ;counting the bits from x
            mov ecx, 4      ;4 executions of the loop
            mov ebx, 0      ;counter
            mov eax, [x]
            while_eax:
                test eax, 1     ;if the last bit is 1
                jnz bit_is_1

                ;if the last bit is 0
                inc ebx

                bit_is_1:
                shr eax, 1      ;shift right

                loop while_eax
            

            ;printf(printf_format, x, ecx)
            push dword ebx
            push dword [x]
            push dword printf_format
            call [printf]
            add esp, 4 * 3

            jmp while_reading

        end_reading:

        ;fclose(descriptor)
        push dword [descriptor]
        call [fclose]
        add esp, 4


        push    dword 0      
        call    [exit]       
