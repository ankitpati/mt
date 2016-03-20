; usersub.asm
; Date  : 16 March 2016
; Author: Ankit Pati

.model small
.stack 100h

.data
prompt db 13, 10, "Enter a digit: $"
respos db 13, 10, "Difference: $"
resneg db 13, 10, "Difference: -$"

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ah, 9h
    lea dx, prompt
    int 21h

    mov ah, 1h
    int 21h

    mov bl, al

    mov ah, 9h
    lea dx, prompt
    int 21h

    mov ah, 1h
    int 21h

    sub bl, al

    mov ah, 9h
    jnc positive
    neg bl
    lea dx, resneg
    jmp negative
positive:
    lea dx, respos
negative:
    int 21h

    mov dl, bl
    add dl, 30h

    mov ah, 2h
    int 21h

    mov ah, 4ch
    mov al, 0
    int 21h
main endp

end main
; end of usersub.asm

; OUTPUT
;
; Enter a digit: 9
; Enter a digit: 5
; Difference: -4
;
