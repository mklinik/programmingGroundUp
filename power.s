.section .data
# empty

.section .text

.globl _start
_start:
    pushq $3 # second argument: power
    pushq $2 # first argument:  base
    call  power
    addq  $8, %rsp # clean up function arguments

    # copy return value to ebx
    movl  %eax, %ebx
    movl  $1, %eax # exit
    int $0x80 # syscall

# arguments:
#    first argument:  base number
#    second argument: power
#
# variables:
#    %rdi: remaining power
#    -8(%rbp): current value
#    %rax: base value

.type power, @function
power:
    # function setup
    pushq %rbp
    movq  %rsp, %rbp
    subq  $8, %rsp # make space for local variable

    # initialize index register with power
    movq 24(%rbp), %rdi

    # initialize variables
    movq 16(%rbp), %rax # first argument goes to %rax
    movq %rax, -8(%rbp) # first argument goes to local var

power_loop:
    cmpq  $1, %rdi
    je    end_power # if power is one, we're done

    movq 16(%rbp), %rbx # fetch local variable to %rbx
    imulq %rax, %rbx # multiply, store result in %rbx
    movq %rbx, 16(%rbp) # store result to local variable
    decq   %rdi
    jmp   power_loop

    # function cleanup, return value is in %rax
end_power:
    movq 16(%rbp), %rax # copy result to return register
    movq %rbp, %rsp
    popq %rbp
    ret
