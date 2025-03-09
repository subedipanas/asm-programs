    .data
in_format:          .asciz  "%d"
choice_msg:         .asciz  "Choose between 1 and %d: "
msg_inv_input:      .asciz  "Invalid input. "
choice:             .word   0

    .text
    .global get_menu_choice

    //  get_menu_choice (max_choice)
    //  params
    //      max_choice - 1 to max_choice allowed
    //
    //  registers:
    //  x19     - max_choice
    max_choice  .req    w19
get_menu_choice:
    stp     x19, x30, [sp, -16]!

    mov     max_choice, w0

5:
    //      display choice message
    ldr     x0, =choice_msg
    mov     w1, max_choice
    bl      printf

    //      get choice
    ldr     x0, =in_format
    ldr     x1, =choice
    bl      scanf

    //      check if an input was read
    cbnz    x0, 10f

    //      no input read
    //      print invalid input message
    ldr     x0, =msg_inv_input
    bl      printf

    //      clear stdin and loop back
    bl      clearInputBuffer
    b       5b


10:
    //      at least one input read
    ldr     x1, =choice
    ldr     x1, [x1]

    //      choice <= 0
    cmp     w1, wzr
    ble     15f

    //      choice > max_choice
    cmp     w1, max_choice
    bgt     15f

    //      choice in (0, max_choice]
    b       20f

15:
    ldr     x0, =msg_inv_input
    mov     w1, max_choice
    bl      printf

    b       5b

20:
    //      return choice
    ldr     x0, =choice
    ldr     x0, [x0]

99:
    ldp     x19, x30, [sp], 16
    ret

    .end