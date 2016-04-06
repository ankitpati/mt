; evenodd.asm
; Date  : 06 April 2016
; Author: Ankit Pati

.model small
.stack 100h

.data
prompt db 13, 10, "Enter a digit: $"
evn    db 13, 10, "Even$"
odd    db 13, 10, "Odd $"

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ah, 9h
    lea dx, prompt
    int 21h

    mov ah, 1h
    int 21h

    sub al, 30h

    shl al, 7                               ; shl: Shift Left

    mov ah, 9h
    cmp al, 0
    je digitevn
    lea dx, odd
    jmp digitodd
digitevn:
    lea dx, evn
digitodd:
    int 21h

    mov ax, 4c00h
    int 21h
main endp

end main
; end of evenodd.asm

; OUTPUT
;
; Enter a digit: 5
; Odd
;
