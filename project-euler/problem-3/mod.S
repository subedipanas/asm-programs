    .global mod
    .text

/*  mod     Gives remainder of two numbers
*/
mod:
    udiv    x2, x0, x1
    mul     x2, x1, x2
    sub     x0, x0, x2

    ret
    
    .end