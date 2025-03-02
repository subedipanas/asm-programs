    .global main
    .text

/*  problem-3

    Bible:
    w20     n
    w21     scratch
    w22     counter
    w23     result - max prime factor

*/
main:
    stp     x20, x30, [sp, -16]!
    stp     x21, x22, [sp, -16]!
    str     x23, [sp, -16]!

    ldr     x20, =600851475143
    mov     x21, 2

    //      check for factors of 2
    b       10f
5:
    mov     x23, 2
    udiv    x20, x20, x21
10:
    mov     x0, x20
    mov     x1, 2
    bl      mod
    cbz     x0, 5b

    //      check for odd factors
    //      starting from 3
    mov     x22, 1
    b       40f
15:

    //      loop while x20 is
    //      still divisible by
    //      x22 (current counter)
    b       30f
20:
    mov     x23, x22
    udiv    x20, x20, x22

30:
    mov     x0, x20
    mov     x1, x22
    bl      mod
    cbz     x0, 20b


40:
    add     x22, x22, 2
    mul     x21, x22, x22
    cmp     x21, x20
    ble     15b

    
    cmp     x20, 2
    ble     95f

    mov     x23, x20

95:
    //      display result
    ldr     x0, =format
    mov     x1, x23
    bl      printf


    //      cleanup
    ldr     x23, [sp], 16
    ldp     x21, x22, [sp], 16
    ldp     x20, x30, [sp], 16
    mov     x0, xzr
    ret


    .data
format:     .asciz  "%ld\n"

    .end