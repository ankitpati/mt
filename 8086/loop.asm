; loop.asm
; Date  : 06 April 2016
; Author: Ankit Pati

.model small
.stack 100h

.code
main proc
    mov ah, 2h

    mov dl, 31h
    mov cx, 5
    l1:
        int 21h
        inc dl
        loop l1

    mov dl, 13
    int 21h
    mov dl, 10
    int 21h

    mov dl, 35h
    mov cx, 5
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
; 12345
; 54321
;
