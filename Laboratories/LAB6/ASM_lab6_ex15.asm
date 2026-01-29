bits 32 
global start        
extern exit   
import exit msvcrt.dll  
  ;A string of words is given. Build two strings of bytes, s1 and s2, in the following way: for each word,
            ;if the number of bits 1 from the high byte of the word is larger than the number of bits 1 from its low byte, then s1 will contain the high byte and s2 will contain the low byte of the word
            ;if the number of bits 1 from the high byte of the word is equal to the number of bits 1 from its low byte, then s1 will contain the number of bits 1 from the low byte and s2 will contain 0
            ;otherwise, s1 will contain the low byte and s2 will contain the high byte of the word.
segment data use32 class=data
   s dw 5607h, 3C15h, 1546h, 8745h, 4561h, 18E0h
   lens equ ($ - s)/2 ;length of s in bytes
   s1 resb lens
   s2 resb lens
segment code use32 class=code
    start: 
        
        CLD             ;DF = 0
        mov EDI, 0      ;index of s1 and s2
        mov ESI, s      ;ESI = offset s
        loop1:
            ;counting the number of bits 1 from low byte
            mov CL, 0       ;the counter for low byte
            lodsb           ;AL = [ESI], inc ESI
            
            loop_start:
                test AL, 1
                jz next
                inc CL
            next:
                shr AL, 1
                cmp AL, 0
            ja loop_start
            ;counting the number of bits 1 from high byte  
            mov DL, 0       ;the counter for high byte
            lodsb           ;AL = [ESI], inc ESI
            loop_start2:
                test AL, 1
                jz next2
                inc DL
            next2:
                shr AL, 1
                cmp AL, 0
            ja loop_start2
            
            cmp DL, CL
            ja larger
            jb smaller
            
            ;if equal
            mov [s1 + EDI], CL
            mov byte [s2 + EDI], 0
            jmp final
            
            larger:
                mov BL, [ESI - 1]
                mov [s1 + EDI], BL
                
                mov BL, [ESI - 2]
                mov [s2 + EDI], BL
                
                jmp final
            smaller:
                mov BL, [ESI - 1]
                mov [s2 + EDI], BL
                
                mov BL, [ESI - 2]
                mov [s1 + EDI], BL
                
                jmp final
            final:
            inc EDI
            cmp EDI, lens
        jb loop1
        
        push    dword 0      
        call    [exit]     
