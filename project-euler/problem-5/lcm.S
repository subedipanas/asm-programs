    .global lcm
    .text

/*  lcm     LCM of two numbers
*/
lcm:
    stp     x20, x30, [sp, -16]!
    stp     x21, x22, [sp, -16]!

    mov     w20, w0
    mov     w21, w1

    mov     w0, w20
    mov     w1, w21
    bl      gcd

    udiv    w0, w20, w0
    mul     w0, w0, w21

    ldp     x21, x22, [sp], 16
    ldp     x20, x30, [sp], 16
    ret
    
    .end