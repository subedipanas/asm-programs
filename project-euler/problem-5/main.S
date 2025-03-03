    .global main
    .text

/*  problem-5

    Dictionary:
    w20     current max lcm
    w21     counter
*/
main:
    stp     x20, x30, [sp, -16]!
    str     x21, [sp, -16]!

    mov     w20, 20
    mov     w21, 20
    b       10f

5:
    mov     w0, w20
    mov     w1, w21
    bl      lcm

    mov     w20, w0

10:
    sub     w21, w21, 1
    cbnz    w21, 5b

    ldr     x0, =format
    mov     w1, w20
    bl      printf

    //      cleanup
    ldr     x21, [sp], 16
    ldp     x20, x30, [sp], 16
    mov     x0, xzr
    ret


    .data
format:     .asciz  "%d\n"

    .end