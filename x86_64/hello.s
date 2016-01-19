# hello.s
# To assemble and run, do
#
#     cc -c hello.s && ld -o hello hello.o && ./hello
#
# or
#
#     cc -nostdlib -o hello hello.s && ./hello
#

    .global _start

    .text
_start:
    # write(1, message, 13);
    mov     $1, %rax                # system call 1 is write
    mov     $1, %rdi                # file descriptor 1 is stdout
    mov     $message, %rsi          # address of string to output
    mov     $13, %rdx               # number of bytes to output
    syscall                         # invoke OS to write

    # exit(0);
    mov     $60, %rax               # system call 60 is exit
    mov     $0, %rdi                # return 0 to indicate success
    syscall                         # invoke OS to exit

message:
    .ascii  "hello, world\n"
