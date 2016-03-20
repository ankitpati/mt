; subinput.asm
; Date  : 24 February 2016
; Author: Ankit Pati

.model small
.stack 100h

.data
num1    db ?
num2    db ?
prompt  db 'Enter two numbers:', 13, 10, '$'
message db 'The difference is $'
minus   db '-$'
isneg   db ?
result  db 10 dup(?)

input1  db 4, 0, 4 dup(?)
input2  db 4, 0, 4 dup(?)

.code
main proc
    mov ax, @data
    mov ds, ax

    call takeinp
    call convbin
    call subnum
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
    mov dx, offset input1
    int 21h

    mov ah, 2h
    mov dl, 10
    int 21h

    mov ah, 0ah
    mov dx, offset input2
    int 21h

    mov ah, 2h
    mov dl, 10
    int 21h

    ret
takeinp endp

convbin proc
    mov bl, 10

    ; first input conversion
    mov ch, 0
    mov cl, [input1 + 1]

    mov si, offset [input1 + 2]

    mov di, offset num1
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
    ; end of first input conversion

    ; second input conversion
    mov ch, 0
    mov cl, [input2 + 1]

    mov si, offset [input2 + 2]

    mov di, offset num2
    mov byte ptr [di], 0

    loop2:
        mov ax, 0
        mov al, byte ptr [di]
        mul bl

        add al, byte ptr [si]
        sub al, 48

        mov byte ptr [di], al

        inc si
        loop loop2
    ; end of second input conversion

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

subnum proc
    mov ax, 0
    mov al, num1

    clc
    sub al, num2
    jnc nocarry

    neg al
    mov isneg, 1
    ret

nocarry:
    mov isneg, 0
    ret
subnum endp

dispres proc
    mov ah, 9h
    mov dx, offset message
    int 21h

    cmp isneg, 0
    je notneg

    mov dx, offset minus
    int 21h

notneg:
    mov dx, offset result
    int 21h

    ret
dispres endp

end main
; end of subinput.asm

; OUTPUT
;
; Enter two numbers:
; 43
; 50
; The difference is -7
;
