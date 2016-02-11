; sub.asm
; Date  : 10 February 2016
; Author: Ankit Pati

.model small
.stack 100h

.data
num1    db  5
num2    db 43
message db 'The difference is $'
minus   db '-$'
result  db 10 dup(?)

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ah, 9h
    mov dx, offset message
    int 21h

    mov ax, 0
    mov al, num1

    clc
    sub al, num2
    jnc nocarry                             ; jnc: Jump If No Carry

    mov ah, 255
    sub ah, al                              ; taking 1's complement
    mov al, ah
    add al, 1                               ; 2's complement = 1's compl + 1

    mov ah, 9h                              ; must use 9h, as 2h sets al
    mov dx, offset minus                    ;     and destroys the result
    int 21h

    mov ah, 0

nocarry:

    ; convert to decimal for printing
    mov bx, 10

    mov cx, 0

    loop1:
        mov dx, 0
        div bx
        push dx
        inc cx
        cmp ax, 0
        jne loop1

    mov di, offset result

    loop2:
        pop ax
        add ax, 48
        mov byte ptr [di], al
        inc di
        loop loop2

    mov byte ptr [di], '$'
    ; end of conversion to decimal

    mov ah, 9h
    mov dx, offset result
    int 21h

    mov ah, 4ch
    mov al, 0h
    int 21h
main endp

end main
; end of sub.asm

; OUTPUT
;
; The difference is -38
;
