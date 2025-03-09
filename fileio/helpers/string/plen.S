    .text
    .global plen

    /*  plen        returns the length of a string
        param x0    pointer to the string
    */
    counter     .req    w1
    char        .req    w2
plen:
    
    //      -1 to account for null terminator
    mov     counter, -1

5:
    ldrb    char, [x0], 1
    add     counter, counter, 1
    cbnz    char, 5b

    mov     w0, counter
    ret

    .end
