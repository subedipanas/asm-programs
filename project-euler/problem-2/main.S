    .global main
    .text

/*  problem-2

    Bible:
    w20     counter 1
    w21     counter 2
    w22     Sum
    w23     Limit 4000000 as per the question,
            but can be changed to any 32 bit
            number on line 26

*/
main:
    stp     x20, x30, [sp, -16]!
    stp     x21, x22, [sp, -16]!
    str     x23, [sp, -16]!

    //      initialize first 2 numbers
    //      and sum to 0, and limit to
    //      4000000
    mov     w20, #1
    mov     w21, #2
    mov     w22, wzr
    ldr     w23, =4000000

    b       50f

10: //      loop start
    mov     w0, w21
    mov     w1, #2
    bl      mod
    cbnz    w0, 20f

    //      sum even numbers
    add     w22, w22, w21

20: //      get next number in sequence
    add     w21, w20, w21
    sub     w20, w21, w20

50: //      loop condition
    cmp     w21, w23
    ble     10b

    //      print sum
    ldr     x0, =format
    mov     w1, w22
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