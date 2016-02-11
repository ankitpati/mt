; addinput.asm
; Date  : 19 January 2016
; Author: Ankit Pati

.model small
.stack 100h

.data
num1    db ?
num2    db ?
prompt  db 'Enter two numbers:', 13, 10, '$'
message db 'The sum is $'
result  db 10 dup(?)

input1  db 4, 0, 4 dup(?)
input2  db 4, 0, 4 dup(?)
    ; ~~~~ DOS Input Buffer Format ~~~~
    ; byte 0 : maximum capacity of buffer, including terminating carriage return
    ; byte 1 : (before call) number of bytes to recycle from previous input
    ;          (after  call) number of bytes read in this input
    ; byte 2+: characters read in this input

.code
main proc
    mov ax, @data
    mov ds, ax

    call takeinp                            ; take user input
    call convbin                            ; convert to binary for addition
    call addnum                             ; perform the addition
    call convdec                            ; convert to decimal for display
    call dispres                            ; display result

    mov ah, 4ch
    mov al, 0h
    int 21h
main endp

takeinp proc                                ; main is caller, takeinp is callee
    mov ah, 9h
    mov dx, offset prompt                   ; display prompt
    int 21h

    mov ah, 0ah                             ; 0ah is the Buffered Input service
    mov dx, offset input1
    int 21h

    mov ah, 2h                              ; 2h is the Display Char DOS service
    mov dl, 10                              ; ASCII value of linefeed is 10
    int 21h

    mov ah, 0ah
    mov dx, offset input2
    int 21h

    mov ah, 2h
    mov dl, 10
    int 21h

    ret                                     ; ret: returns control to caller
takeinp endp

convbin proc
    mov bl, 10                              ; convert by repeated multiplication

    ; first input conversion
    mov ch, 0
    mov cl, [input1 + 1]                    ; set Counter to number of chars

    mov si, offset [input1 + 2]             ; si: Source Index register

    mov di, offset num1
    mov byte ptr [di], 0

    loop1:
        mov ax, 0
        mov al, byte ptr [di]
        mul bl                              ; ax = al * bl

        add al, byte ptr [si]
        sub al, 48                          ; ASCII value of '0' is 48

        mov byte ptr [di], al

        inc si
        loop loop1;
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
        loop loop2;
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

addnum proc
    mov ax, 0
    mov al, num1

    clc
    add al, num2
    adc ah, 0

    ret
addnum endp

dispres proc
    mov ah, 9h
    mov dx, offset message
    int 21h
    mov dx, offset result
    int 21h

    ret
dispres endp

end main
; end of addinput.asm
