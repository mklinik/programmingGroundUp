# PURPOSE: finds the largest number in a list of numbers
# INPUT: none
# OUTPUT: returns the result as status code
# VARIABLES:
#   %eax the current number in the list
#   %ebx the so-far largest number
#   %edi the current list index

.section .data

data_items:
 .long 1,21,2,3,256,25,30,0

.section .text
.globl _start

_start:
 movl $0, %edi # initialize index to 0
 movl data_items(,%edi,4), %eax # read the first number
 movl %eax, %ebx # the first number is also the so-far largest one

start_loop:
 cmpl $0, %eax # check if the current number is 0
 je exit_loop # and if so, exit the program
 incl %edi # read the next number
 movl data_items(,%edi,4), %eax
 cmpl %ebx, %eax # compare current number and so-far largest one
 jle start_loop # if the new number is lesser or equal, continue
 movl %eax, %ebx # copy current number to largest number
 jmp start_loop # continue

exit_loop:
 movl $1, %eax # exit
 int $0x80 # syscall
