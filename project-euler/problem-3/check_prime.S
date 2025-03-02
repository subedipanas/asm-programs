    .global check_prime
    .text

/*  check_prime     Checks if a number is prime

    Bible:
    w20     N
    w21     counter
*/
check_prime:
    stp     x20, x30, [sp, -16]!
    str     x21, [sp, -16]!

    mov     x21, 1
    mov     x20, x0
    b       10f

5:
    mov     x0, x20
    mov     x1, x21
    bl      mod

    cbz     x0, 15f

10:
    add     x21, x21, 1
    cmp     x21, x20
    blt     5b

    mov     w0, 1
    b       99f

15:
    mov     w0, 0

99:
    ldr     x21, [sp], 16
    ldp     x20, x30, [sp], 16
    ret
    
    .end