; disphex.asm
; Date  : 20 April 2016
; Author: Ankit Pati

.model small
.stack 100h

.data
n1   db ?
n2   db ?
n3   db ?
msg1 db 'Enter a number:', 13, 10, '$'
msg2 db 13, 10, 'The number is ', '$'

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ah, 9h
    lea dx, msg1
    int 21h

    mov ah, 1h
    int 21h

    cmp al, 3ah
    jc down1
    sub al, 7

down1:
    and al, 0fh
    mov n1, al

    mov ah, 1h
    int 21h

    cmp al, 3ah
    jc down2
    sub al, 7

down2:
    and al, 0fh
    mov n2, al

    mov al, n1

    mov cl, 4
    rol al, cl
    add al, n2
    mov bl, al

    mov ah, 9h
    lea dx, msg2
    int 21h

    mov dl, bl
    mov n3, dl
    and dl, 0f0h

    mov cl, 4
    rol dl, cl

    cmp dl, 0ah
    jc down3
    add dl, 27h

down3:
    add dl, 30h
    mov ah, 2h
    int 21h

    mov dl, n3
    and dl, 0fh
    cmp dl, 0ah
    jc down4
    add dl, 27h

down4:
    add dl, 30h
    mov ah, 2h
    int 21h

    mov ah, 4ch
    mov al, 0h
    int 21h
main endp

end main
; end of disphex.asm

; OUTPUT
;
; Enter a number:
; 5b
; The number is 5b
;
