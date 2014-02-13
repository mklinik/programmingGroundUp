.section .data
# empty

.section .text

.globl _start
_start:
    pushq $3 # second argument: power
    pushq $2 # first argument:  base
    call  power
    addq  $8, %rsp

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
#    %rax: current value
#    %rbx: base value

.type power, @function
power:
    # function setup
    pushq %rbp
    movq  %rsp, %rbp

    # initialize index register with power
    movq 24(%rbp), %rdi

    # initialize variables
    movq 16(%rbp), %rax
    movq 16(%rbp), %rbx

power_loop:
    cmpq  $1, %rdi
    je    end_power # if power is one, we're done

    imulq %rbx, %rax # multiply, store result in %rax
    dec   %rdi
    jmp   power_loop

    # function cleanup, return value is in %rax
end_power:
    movq %rbp, %rsp
    popq %rbp
    ret
