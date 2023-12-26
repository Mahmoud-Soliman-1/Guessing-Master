assume cs:code

data segment
    assume ds:data
    secret_number db 0
    player_guess db 0
    message db 13, 10, "Guess the number between 1 and 10: $"
    winning_message db 13, 10, "Congratulations! You guessed correctly!$"
    losing_message db 13, 10, "Sorry, you didn't guess correctly. Try again!$"
data ends

code segment
start:
    ; set data segment pointer
    push ax
    mov ax, data
    mov ds, ax
    pop ax
    
    ; initialize random seed
    mov ah, 2Ch
    int 21h
    mov secret_number, dl ; save the random number
    
    ; display message
    lea dx, message
    mov ah, 09h
    int 21h

game_loop:
    ; get player input
    mov ah, 01h
    int 21h
    sub al, '0' ; convert ASCII to integer
    mov player_guess, al
    
    ; compare the guess with the secret number
    cmp al, secret_number
    je  player_wins
    jne player_loses

player_wins:
    ; display winning message
    lea dx, winning_message
    mov ah, 09h
    int 21h
    jmp end_game

player_loses:
    ; display losing message
    lea dx, losing_message
    mov ah, 09h
    int 21h
    jmp game_loop

end_game:
    ; exit program
    mov ah, 4Ch
    int 21h

code ends
end start