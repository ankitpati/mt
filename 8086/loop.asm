; loop.asm
; Date  : 06 April 2016
; Author: Ankit Pati

.model small
.stack 100h

.code
main proc
    mov ah, 2h

    mov dl, 30h
    mov cx, 10
    l1:
        int 21h
        inc dl
        loop l1

    mov dl, 13
    int 21h
    mov dl, 10
    int 21h

    mov dl, 39h
    mov cx, 10
    l2:
        int 21h
        dec dl
        loop l2

    mov ah, 4ch
    mov al, 0h
    int 21h
main endp

end main
; end of loop.asm

; OUTPUT
;
; 0123456789
; 9876543210
;
