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
    mov     $4, %eax                # system call 4 is write
    mov     $1, %ebx                # file descriptor 1 is stdout
    mov     $message, %ecx          # address of string to output
    mov     $13, %edx               # number of bytes to output
    int     $0x80                   # invoke OS to write

    # exit(0);
    mov     $1, %eax                # system call 1 is exit
    mov     $0, %ebx                # return 0 to indicate success
    int     $0x80                   # invoke OS to exit

message:
    .ascii  "hello, world\n"
