bits 32 
global start        

;2.	Se citește de la tastatură un număr N și apoi N numere.
;Să se calculeze suma numerelor pare introduse, să se calculeze suma numerelor impare introduse, apoi diferența dintre cele două sume.
;Să se afișeze în fișierul output.txt cele 3 rezultate, în baza 16, pe linii separate.


extern exit, scanf, fprintf, fopen       
       
import exit msvcrt.dll    
import scanf msvcrt.dll 
import fprintf msvcrt.dll 
import fopen msvcrt.dll

segment data use32 class=data
    n resd 1
    format_read db "%d", 0
    x resd 1
    evenSum resd 1
    oddSum resd 1
    ;format_write db "Test please work %x %x %x", 0
    format_write db "Even sum = %x", 10, 13, "Odd sum = %x", 10, 13, "The difference = %x", 0
    file_out db "output.txt", 0
    descriptor resd 1
    write_mode db "w", 0
    
segment code use32 class=code
    start:
        
        ;reading N
        ;scanf("%d", &n);
        push dword n
        push dword format_read
        call [scanf]
        add esp, 2 * 4
        
        ;reading N numbers and computing the sums
        mov ecx, [n]
        while_n:
            push ecx    ;saving ecx
            
            push dword x
            push dword format_read
            call [scanf]
            add esp, 2 * 4
            
            test [x], dword 1
            je odd_number
            
            ;even number
            mov ebx, [x]
            add [evenSum], ebx
            jmp over
            
            ;odd number
            odd_number:
            mov ebx, [x]
            add [oddSum], ebx
            
            over:
            pop ecx     ;restoring ecx value
            
            loop while_n
        
        ;computing the difference = ebx
        mov eax, [oddSum]
        mov ebx, [evenSum]
        cmp eax, ebx
        ja oddSum_greater
        
        ;evenSum greater
        sub ebx, eax
        jmp over2
        
        oddSum_greater:
        
        xchg eax, ebx   ;exchanging eax with ebx to have the result in 
        sub ebx, eax
        over2:
        
        ;oppening the file
        ;fopen(file_out, "w");
        push dword write_mode
        push dword file_out
        call [fopen]
        add esp, 2 * 4
        
        mov [descriptor], eax
        
        ;printing in the file
        ;fprintf(descriptor, "Even sum = %x\n Odd sum = %x\n The difference = %x", [evenSum], [oddSum], eax);
        push ebx
        push dword [oddSum]
        push dword [evenSum]
        push dword format_write
        push dword [descriptor]
        call [fprintf]
        add esp, 4 * 4
        
        push    dword 0      
        call    [exit]       
