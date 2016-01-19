; HELLO.ASM

.model small                              ; directive for 128 kB code
.stack 100h                               ; directive for 256 kB stack

.data                                     ; data segment
message db 'hello, world $'
    ; message is the variable name
    ; db: Data Byte
    ; 'hello, world ' is the printable string
    ; '$' terminates the string

.code                                     ; code segment
main proc                                 ; main procedure
    mov    ax, @data                      ; load address of data in Accumulator
    mov    ds, ax                         ; ds: Data Segment register

    mov    ah, 9h                         ; 9h is Display String DOS service
    mov    dx, offset message             ; dx: Data register, offset is pointer
    int    21h                            ; 21h is DOS system call

    mov    ah, 4Ch                        ; 4Ch is Terminate DOS service
    mov    al, 0h                         ; 0h is return code for success
    int    21h                            ; 21h is DOS system call
main endp                                 ; end main procedure

end main                                  ; mentions entry point for linker
