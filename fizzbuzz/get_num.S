    .global get_num
    .text

/*  get_num     Displays an input prompt and takes one input from stdin

    Bible:
    x0 - x1     Scratch
*/
get_num:
    str     x30, [sp, -16]!

    //      Display input prompt
    ldr     x0, =prompt
    bl      printf

    //      Scan an input
    sub     sp, sp, #16

    ldr     x0, =format
    mov     x1, sp
    bl      scanf

    ldr     x0, [sp]
    add     sp, sp, #16

    ldr     x30, [sp], 16
    ret


    .data
prompt:     .asciz "Enter a number: "
format:     .asciz  "%d"

    .end