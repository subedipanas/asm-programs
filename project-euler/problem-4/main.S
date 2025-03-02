    .global main
    .text

/*  problem-4

    Dictionary:
    w20     counter 1
    w21     counter 2
    w22     scratch
    w23     result

*/
main:
    stp     x20, x30, [sp, -16]!
    stp     x21, x22, [sp, -16]!
    str     x23, [sp, -16]!

    mov     w23, -1

    mov     w20, 1000
    b       20f
5:
    mov     w21, 1000
    b       15f  
10:
    mul     w22, w20, w21
    cmp     w23, w22
    bge     15f

    mov     w0, w22
    bl      is_palindrome
    cbz     w0, 15f

    mov     w23, w22

15:
    sub     w21, w21, 1
    cmp     w21, 100
    bge     10b

20:
    sub     w20, w20, 1
    cmp     w20, 100
    bge     5b


    ldr     x0, =format
    mov     w1, w23
    bl      printf

    //      cleanup
    ldr     x23, [sp], 16
    ldp     x21, x22, [sp], 16
    ldp     x20, x30, [sp], 16
    mov     x0, xzr
    ret


    .data
format:     .asciz  "%d\n"

    .end