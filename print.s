# print a string to stdout

.section .data

hello:
 .ascii "Hello World!\n\0"

.section .text
.globl _start

_start:

 movl $0, %edx # initialize edx with 0
strlen_loop:
 cmpb $0, hello(,%edx,1) # cmpb: compare a single byte
 je strlen_end # if the current byte is zero, we found the end of the string
 incl %edx
 jmp strlen_loop
strlen_end: # edx now holds the string length

 movl $4, %eax # syscall: write
 movl $1, %ebx # file handle: stdout
 movl $hello, %ecx # buffer start
 int $0x80 # syscall

 movl $1, %eax # exit
 movl $0, %ebx # return code
 int $0x80 # syscall
