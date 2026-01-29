section .data
    num_count db "Enter the number of numbers: "
    num_prompt db "Enter a number: "
    even_sum db "Even sum: "
    odd_sum db "Odd sum: "
    diff db "Difference: "
    output db "output.txt"
    newline db 0x0A

section .bss
    n resb 2
    num resb 2
    even_total resb 4
    odd_total resb 4

section .text
    global _start

_start:
    ; Print the number count prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, num_count
    mov edx, num_count.len
    int 0x80

    ; Read the number count
    mov eax, 3
    mov ebx, 0
    mov ecx, n
    mov edx, 2
    int 0x80

    ; Convert the number count to an integer
    movzx ebx, byte [n]
    movzx ecx, byte [n + 1]
    mov eax, ebx
    mov edx, ecx
    shl eax, 8
    or eax, edx

    ; Loop to read and process each number
    mov ebx, 0
    mov ecx, 0
    mov edx, 0
    mov esi, 0
    mov edi, 0
    mov [even_total], 0
    mov [odd_total], 0

read_loop:
    ; Print the number prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, num_prompt
    mov edx, num_prompt.len
    int 0x80

    ; Read the number
    mov eax, 3
    mov ebx, 0
    mov ecx, num
    mov edx, 2
    int 0x80

    ; Convert the number to an integer
    movzx ebx, byte [num]
    movzx ecx, byte [num + 1]
    mov eax, ebx
    mov edx, ecx
    shl eax, 8
    or eax, edx

    ; Check if the number is even or odd
    test eax, 1
    jz even
    ; The number is odd
    add dword [odd_total], eax
    jmp next
even:
    ; The number is even
    add dword [even_total], eax
next:
    ; Increment the loop counter
    inc ebx
    cmp ebx, eax
    jl read_loop

    ; Calculate the difference between the even and odd sums
    mov eax, [even_total]
    mov ebx, [odd_total]
    sub eax, ebx
    mov [diff], eax

    ; Open the output file
    mov eax, 5
    mov ebx, output
    mov ecx, 2
    mov edx, 0
    int 0x80

    ; Write the even sum to the output file
    mov eax, 4
    mov ebx, eax
    mov ecx, even_sum
    mov edx, even_sum.len
    int 0x80
    
    mov eax, 4
mov ebx, eax
mov ecx, even_total
mov edx, 4
int 0x80

mov eax, 4
mov ebx, eax
mov ecx, newline
mov edx, 1
int 0x80

; Write the odd sum to the output file
mov eax, 4
mov ebx, eax
mov ecx, odd_sum
mov edx, odd_sum.len
int 0x80

mov eax, 4
mov ebx, eax
mov ecx, odd_total
mov edx, 4
int 0x80

mov eax, 4
mov ebx, eax
mov ecx, newline
mov edx, 1
int 0x80

; Write the difference to the output file
mov eax, 4
mov ebx, eax
mov ecx, diff
mov edx, diff.len
int 0x80

mov eax, 4
mov ebx, eax
mov ecx, diff
mov edx, 4
int 0x80

mov eax, 4
mov ebx, eax
mov ecx, newline
mov edx, 1
int 0x80

; Close the output file
mov eax, 6
mov ebx, eax
int 0x80

; Exit the program
mov eax, 1
xor ebx, ebx
int 0x80

