    .global gcd
    .text

/*  gcd     Get greatest common divisor of two numbers
*/
gcd:
    stp     x20, x30, [sp, -16]!
    str     x21, [sp, -16]!

    cbz     w0, 10f


    mov     w20, w0
    mov     w21, w1

    mov     w0, w21
    mov     w1, w20
    bl      mod

    mov     w1, w20
    bl      gcd
    b       99f

10:
    mov     w0, w1

99:
    ldr     x21, [sp], 16
    ldp     x20, x30, [sp], 16
    ret
    
    .end