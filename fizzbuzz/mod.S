    .global mod
    .text

/*  mod         Gives remainder of two numbers

    Bible:
    x0 - x2     Scratch
*/
mod:
    udiv    w2, w0, w1
    mul     w2, w1, w2
    sub     w0, w0, w2

    ret