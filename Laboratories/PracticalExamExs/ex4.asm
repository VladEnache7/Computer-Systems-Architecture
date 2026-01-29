bits 32 
global start      

;A sentence is read from the keyboard. To be counted the letters from every word and to be prented on the screen

extern printf, gets, exit

import printf msvcrt.dll
import gets msvcrt.dll
import exit msvcrt.dll

segment data use32 class=data
    sentence resb 100
    format db "%d ", 0

segment code use32 class=code\

start:
    ;read a sentence from the keyboard
    push sentence
    call [gets]
    add esp, 4
    
    mov esi, sentence
    ;count the letters from every word
    while_sentence:
        mov ecx, 0  ;storing the number of letters from the current word
        while_word:
            ;if the current character is the end of the sentence, then the sentence is finished
            cmp byte [esi], 0
            je end_word
            ;if the current character is a space, then the word is finished
            cmp byte [esi], ' '
            je end_word
            
            inc ecx     ;count the letters from the word
            inc esi     ;go to the next character

            jmp while_word
        end_word:

        ;printing ecx on the screen
        ;printf("%d ", ecx)
        push ecx
        push format
        call [printf]
        add esp, 8


        ;go to the next word
        while_space:
            ;if the current character is the end of the sentence, then the sentence is finished
            cmp byte [esi], 0
            je end_sentence
            ;if the current character is not a space, then the word is finished
            cmp byte [esi], ' '
            jne end_space

            inc esi     ;go to the next character

            jmp while_space
        end_space:

    jmp while_sentence

    end_sentence:

    ;exiting
    push 0
    call [exit]

    