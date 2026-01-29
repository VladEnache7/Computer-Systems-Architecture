bits 32 
global start        
;A sentence is read from the keyboard. Inverse every _words in the sentence and print the result on the screen.
;The sentence is ended by a dot.
;The _words are separated by a space.
;The _words are composed of letters only.

extern printf, gets, exit

import printf msvcrt.dll
import gets msvcrt.dll
import exit msvcrt.dll

segment data use32 class=data
    sentence resb 100
    read_format db "%s", 0
    _word resb 100
    dot db ".", 0
    inverse__word resb 100
    space db " ", 0
    read_len dd 200
    
    
segment code use32 class=code
start:

    ;Read a sentence from the keyboard
    ;gets("%s", sentence)
    push sentence
    call [gets]
    add esp, 8

    ;Inverse every _words in the sentence without using C functions
     
    ;Initialize the index of the sentence
    mov esi, sentence
    while_sentence:
        ;Initialize the index of the _word
        mov edi, _word
        while__word:
            ;Read a character from the sentence
            mov al, [esi]
            ;If the character is a space or a dot, the _word is finished
            cmp al, ' '
            je end__word
            cmp al, '.'
            je end__word
            ;Copy the character in the _word
            mov [edi], al
            ;Increment the index of the sentence and the _word
            inc esi
            inc edi
            jmp while__word
        end__word:
            mov [edi], byte 0
            ;Inverse the _word
            mov ebx, edi
            mov edi, inverse__word
            while_inverse__word:
                dec ebx
                mov al, [ebx]
                mov [edi], al
                inc edi
                cmp ebx, _word
                jne while_inverse__word
            mov [edi], byte 0
            ;Print the _word on the screen
            ;printf("%s", inverse__word)
            push inverse__word
            push read_format
            call [printf]
            add esp, 8
            ;If the character is a dot, the sentence is finished
            cmp al, '.'
            je end_sentence
            ;Print a space on the screen
            ;printf(" ")
            push space
            call [printf]
            add esp, 4
            ;Increment the index of the sentence
            inc esi
            jmp while_sentence
        end_sentence:
            ;Print a dot on the screen
            ;printf(".")
            push dot
            call [printf]
            add esp, 4
            jmp end
    end:   

    push dword 0      
    call [exit]  

        






    