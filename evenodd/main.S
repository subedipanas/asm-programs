    .global main
    .text

/*  main        Checks whether an input number is odd or even

    Bible:
    x0 - x1     Scratch
    x21         Input number
*/
main:
    stp     x21, x30, [sp, -16]!

    //      get number from stdin
    bl      get_num
    mov     x21, x0

    //      get mod with 2
    mov     x1, #2
    bl      mod

    //      odd/even branch based on mod 2
    cmp     x0, xzr
    beq     1f

    ldr     x0, =odd
    b       2f

1:
    ldr     x0, =even

2:
    //      display output
    mov     x1, x21
    bl      printf

    ldp     x21, x30, [sp], 16
    mov     x0, #0
    ret

    .data
even:       .asciz  "%d is even\n"
odd:        .asciz  "%d is odd\n"

    .end