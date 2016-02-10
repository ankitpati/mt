; add.asm

.model small
.stack 100h

.data
num1    db 13
num2    db 12                               ; we are performing 13 + 12
message db 'The sum is $'
result  db 10 dup(?)                        ; reserving string with 10 chars

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ax, 0                               ; blank ax to avoid garbage values
    mov al, num1

    clc                                     ; clc: Clear Carry Flag (CF = 0)
    add al, num2
    adc ah, 0                               ; adc: Add With Carry

    ; convert to decimal for printing
    mov bx, 10                              ; convert by repeated division by 10

    mov cx, 0                               ; stores number of digits

    loop1:                                  ; extract result digits backwards
        mov dx, 0
        div bx                              ; ax = ax / bx, dx = ax % bx
        push dx                             ; push to stack
        inc cx                              ; increment Counter
        cmp ax, 0                           ; cmp: compare ax to zero
        jne loop1                           ; jne: Jump If Not Equal

    mov di, offset result

    loop2:                                  ; reverse the extracted digits
        pop ax                              ; pop from stack
        add ax, 48                          ; ASCII value of '0' is 48
        mov byte ptr [di], al               ; al is 1 byte wide, so use byte ptr
        inc di
        loop loop2                          ; decrements cx, jumps if not zero

    mov byte ptr [di], '$'                  ; terminate result string with '$'
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
