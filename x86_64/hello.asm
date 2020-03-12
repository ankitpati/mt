; hello.asm
; Output string to console.

%include 'include/syscalls.inc'

%define EXIT_SUCCESS 0
%define STDIN 0
%define STDOUT 1
%define STDERR 2

%define LF 10
%define NULL 0
%define FALSE 0
%define TRUE 1

section .data
message1 db "hello, world", LF, NULL

section .text
global _start
_start:
    ; print_string(message1)
    mov rdi, message1
    call print_string

start_done:
    mov rax, SYS_exit
    mov rdi, EXIT_SUCCESS
    syscall

global print_string
print_string:
    push rbx ; Save `rbx` value to stack.

    mov rbx, rdi
    mov rdx, 0

count_loop:
    cmp byte [rbx], NULL
    je count_loop_done
    inc rdx
    inc rbx
    jmp count_loop
count_loop_done:

    ; Avoid expensive syscall for zero-length string.
    cmp rdx, 0
    jz print_string_done

    ; write(STDOUT, string)
    mov rax, SYS_write
    mov rsi, rdi
    mov rdi, STDOUT
    syscall

print_string_done:
    pop rbx
    ret
