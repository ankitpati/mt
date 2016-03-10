; mul.asm
; Date  : 09 March 2016
; Author: Ankit Pati

.model small
.stack 100h

.data
num1    db 13
num2    db 12
message db 'The product is $'
result  db 10 dup(?)

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ax, 0
    mov al, num1
    mov bl, num2

    mul bl

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
    mov dx, offset message
    int 21h
    mov dx, offset result
    int 21h

    mov ah, 4ch
    mov al, 0h
    int 21h
main endp

end main
; end of mul.asm

; OUTPUT
;
; The product is 156
;
