    .global is_palindrome
    .text

/*  is_palindrome     Checks if a number is a palindrome

    Dictionary
    w20     number to check
    w21     scratch
    w22     reverse number
*/
is_palindrome:
    stp     x20, x30, [sp, -16]!
    stp     x21, x22, [sp, -16]!

    mov     w20, w0
    mov     w21, w0
    mov     w22, wzr

5:
    mov     w0, w21
    mov     w1, 10
    bl      mod

    mov     w1, 10
    madd    w22, w22, w1, w0

    udiv    w21, w21, w1
    cbnz    w21, 5b

    cmp     w20, w22
    beq     10f
    
    mov     w0, wzr
    b       99f

10:
    mov     w0, 1

99:
    ldp     x21, x22, [sp], 16
    ldp     x20, x30, [sp], 16
    ret

    .end
