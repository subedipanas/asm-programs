    .global main
    .text

/*  problem-1

    Bible:
    w20     Counter
    w21     Sum
    w22     1000 as per question, but can be
            changed to any 32 bit number on
            line 19

*/
main:
    stp     x20, x30, [sp, -16]!
    str     x21, [sp, -16]!

    //      set input to 1000
    mov     w22, #1000


    mov     w20, wzr
    mov     w21, wzr
    b       50f

10: //      loop start
    //      check mod 3
    mov     w0, w20
    mov     w1, #3
    bl      mod
    cbz     w0, 40f


20: //      check mod 5
    mov     w0, w20
    mov     w1, #5
    bl      mod
    cbnz    w0, 50f


40: //      add current number
    add     w21, w21, w20


50: add     w20, w20, #1
    cmp     w20, w22
    blt     10b

    //      print final sum
    ldr     x0, =format
    mov     w1, w21
    bl      printf


    ldr     x21, [sp], 16
    ldp     x20, x30, [sp], 16
    mov     x0, xzr
    ret



    .data
format:     .asciz  "%d\n"

    .end