; dispnum.asm
; Date  : 20 April 2016
; Author: Ankit Pati

.model small
.stack 100h

.data
num     db ?
prompt  db 'Enter a number:', 13, 10, '$'
message db 'The number is $'
result  db 10 dup(?)

input   db 4, 0, 4 dup(?)

.code
main proc
    mov ax, @data
    mov ds, ax

    call takeinp
    call convbin
    call convdec
    call dispres

    mov ah, 4ch
    mov al, 0h
    int 21h
main endp

takeinp proc
    mov ah, 9h
    mov dx, offset prompt
    int 21h

    mov ah, 0ah
    mov dx, offset input
    int 21h

    mov ah, 2h
    mov dl, 10
    int 21h

    ret
takeinp endp

convbin proc
    mov bl, 10

    mov ch, 0
    mov cl, [input + 1]

    mov si, offset [input + 2]

    mov di, offset num
    mov byte ptr [di], 0

    loop1:
        mov ax, 0
        mov al, byte ptr [di]
        mul bl

        add al, byte ptr [si]
        sub al, 48

        mov byte ptr [di], al

        inc si
        loop loop1

    ret
convbin endp

convdec proc
    mov bx, 10

    mov cx, 0

    loop3:
        mov dx, 0
        div bx
        push dx
        inc cx
        cmp ax, 0
        jne loop3

    mov di, offset result

    loop4:
        pop ax
        add ax, 48
        mov byte ptr [di], al
        inc di
        loop loop4

    mov byte ptr [di], '$'

    ret
convdec endp

dispres proc
    mov ah, 9h
    mov dx, offset message
    int 21h
    mov dx, offset result
    int 21h

    ret
dispres endp

end main
; end of dispnum.asm

; OUTPUT
;
; Enter a number:
; 43
; The number is 43
;
