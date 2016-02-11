; digitadd.asm
; Date  : 19 January 2016
; Author: Ankit Pati

.model small
.stack 100h

.data
num1    dw 1                        ; dw: Data Word
num2    dw 5                        ; we are performing 1 + 5
result  dw 1 dup(?), '$'
    ; one word of uninitialised storage denoted by '?'
    ; terminated as a string with '$' in the next word

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ax, num1                    ; load num1 into Accumulator
    mov bx, num2                    ; load num2 into Base

    add ax, bx                      ; ax = ax + bx
    add ax, 48                      ; ax = ax + 48, as ASCII value of '0' is 48

    mov di, offset result           ; di: Destination Index register
    mov [di], ax                    ; [] dereferences the address in di

    mov ah, 9h
    mov dx, offset result           ; offset gives pointer to first character
    int 21h

    mov ah, 4Ch
    mov al, 0h
    int 21h
main endp

end main
; end of digitadd.asm

; OUTPUT
;
; 6
;
