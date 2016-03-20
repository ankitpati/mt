; useradd.asm
; Date  : 16 March 2016
; Author: Ankit Pati

.model small
.stack 100h

.data
prompt db 13, 10, "Enter a digit: $"
result db 13, 10, "Sum: $"

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ah, 9h
    lea dx, prompt                          ; lea: Load Effective Address
    int 21h

    mov ah, 1h
    int 21h

    mov bl, al

    mov ah, 9h
    lea dx, prompt
    int 21h

    mov ah, 1h
    int 21h

    mov ah, 9h
    lea dx, result
    int 21h

    add bl, al

    mov dl, bl
    sub dl, 30h

    mov ah, 2h
    int 21h

    mov ah, 4ch
    mov al, 0
    int 21h
main endp

end main
; end of useradd.asm

; OUTPUT
;
; Enter a digit: 4
; Enter a digit: 3
; Sum: 7
;
