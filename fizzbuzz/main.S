    .global main
    .text

/*  fizzbuzz        Get input and show fizzbuzz output from 1 to the input number

    Bible:
    w22     Counter
    w21     Input value, to check for loop termination
    w23     Check if fizz/buzz already printed
*/
main:
    stp     x21, x30, [sp, -16]!
    stp     x22, x23, [sp, -16]!

    //      get number from stdin and store
    bl      get_num
    mov     w21, w0

    mov     w22, #0
    b       50f

10: //      loop start

    //      initialize fizzbuzz printed checker
    mov     w23, #0

    //      check for mod 3
    mov     w0, w22
    mov     w1, #3
    bl      mod

    cmp     w0, #0
    bne     15f

    //      print fizz for mod 3 == 0
    mov     w23, #1
    ldr     x0, =fizz
    bl      printf

15:

    //      check for mod 5
    mov     w0, w22
    mov     w1, #5
    bl      mod

    cmp     w0, #0
    bne     20f

    //      print buzz for mod 5 == 0
    mov     w23, #1
    ldr     x0, =buzz
    bl      printf

20:

    //      check whether anything's already printed
    cmp     w23, #1
    bne     25f

    //      print a new line
    ldr     x0, =nl
    bl      puts
    b       50f

25:

    //      print the current number
    mov     w1, w22
    ldr     x0, =format
    bl      printf


    //      loop comparison and end
50: add     w22, w22, #1
    cmp     w22, w21
    ble     10b


    ldp     x22, x23, [sp], 16
    ldp     x21, x30, [sp], 16
    mov     x0, xzr
    ret

    .data
format:     .asciz  "%d\n"
fizz:       .asciz  "Fizz"
buzz:       .asciz  "Buzz"
nl:         .asciz  ""

    .end