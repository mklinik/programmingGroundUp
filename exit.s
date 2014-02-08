# PURPOSE: just exits and returns a status code to the kernel
# INPUT: none
# OUTPUT: returns a status code
# VARIABLES:
#   %eax holds the system call number
#   %ebx holds the return status

.section .data

.section .text
.globl _start
_start:
movl $1, %eax # system call for exiting a program
movl $0xa, %ebx # status number returned to the OS
int $0x80 # wakes up the kernel to run the exit command
