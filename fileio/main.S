    .data
debug:      .asciz  "(main) In create\n"
debug2:     .asciz  "(main) In write\n"
debug3:     .asciz  "(main) In append\n"
debug4:     .asciz  "(main) In read\n"
debug5:     .asciz  "(main) In delete\n"

    .text
    .global main

    //  ensure max choice is always Quit
    max_choice  .req    w19
    choice      .req    w20
    file_name   .req    x21

main:
    stp     x19, x30, [sp, -16]!
    str     x20, [sp, -16]!
    
5:
    bl      menu
    mov     max_choice, w0

    bl      get_menu_choice
    mov     choice, w0

    //      assuming max choice is always Quit
    cmp     choice, max_choice
    beq     95f
    //      got file name
    
    bl      get_file_name
    mov     file_name, x0

    //      jumptable switch to
    //      go to the chosen action
    sub     w0, choice, 1
    lsl     w0, w0, 2
    ldr     x1, =jt
    add     x1, x1, x0

    //      store file_name in x0
    //      before branching
    mov     x0, file_name
    br      x1

jt:
    b       10f
    b       15f
    b       20f
    b       25f
    b       30f

10:
    //      create file
    bl      create_file
    b       50f

15:
    //      write to a file
    bl      write_to_file
    b       50f

20:
    //      append to a file
    b       50f

25:
    //      read a file
    b       50f

30:
    //      delete a file

50:
    //      loop to start
    b       5b


95:

    ldr     x20, [sp], 16
    ldp     x19, x30, [sp], 16
    ret

    .end