bits 32 
global start        
extern exit   
import exit msvcrt.dll  
  
segment data use32 class=data
   s DD 12345607h, 1A2B3C15h
   lens equ $ - s ;length of s in bytes
   d resb lens 
segment code use32 class=code
    start: ;Given an array S of doublewords, build the array of bytes D formed from bytes of doublewords sorted as unsigned numbers in descending order.
    
        mov ESI, s      ; load offset of s in ESI
        mov EDI, d      ; load offset of d in EDI
        mov ECX, lens   ;number of bytes in s
        CLD             ;making sure it does not go in reverse - DF = 0
        
        ;coping the bites from s into d
        copy_bytes:
            MOVSB       ;[EDI] = [ESI], inc(ESI), inc(EDI)
        loop copy_bytes    
        
        ;sorting in descending order with sort
        
        CLD                             ;DF = 0
        mov ESI, d                      ;ESI = offset(d), i = 0
        loopI:                          ;i = 0 -> lens - 1
            mov EDI, ESI                 
            inc EDI                     ;j = i + 1
            mov EBX, ESI                ;EBX = offset of local maximum value
            lodsb                       ;AL = [DS:ESI], inc ESI = i++
            loopJ:                      ;j = i + 1 -> lens
                mov AL, [EBX]           ;AL = the maximum value untill now
                scasb                   ;cmp AL, [ES:EDI], inc EDI = j++
                jae not_below           ;AL >= [ES:EDI] jump over saving the value
                    mov EBX, EDI        ;if AL < [ES:EDI] save the offset of the value 
                    dec EBX
                not_below:
               
                cmp EDI, d + lens   
            jb loopJ                    ;if j < lens
            ;swap(ESI-1, EBX)
            mov CL, [ESI - 1]
            mov DL, [EBX] 
            mov byte [ESI - 1], DL      ;[ESI-1] = the greatest value from position i to lens
            mov byte [EBX], CL
            cmp ESI, d + lens - 1       ;[base] + [const]
        jb loopI                        ;if i < lens-1
        
        push    dword 0      
        call    [exit]     
