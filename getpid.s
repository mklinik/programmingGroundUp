# PURPOSE: just exits and returns the process id of the program
# INPUT: none
# OUTPUT: returns a status code
# VARIABLES:
#   %eax holds the system call number
#   %ebx holds the return status

.section .data

.section .text
.globl _start
_start:
movl $20, %eax # getpid
int $0x80 # wakes up the kernel to run the command in %eax

movl %eax, %ebx # status number returned to the OS
movl $1, %eax # exit
int $0x80 # wakes up the kernel to run the exit command
