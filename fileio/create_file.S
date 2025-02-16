    .data
debug:          .asciz  "(create_file) Filename: %s\n"
choice:         .word   0

    .text
    .global create_file

    .equ    O_FLAGS, 0100
    .equ    O_MODE, 0660
    fd      .req    x19
create_file:
    stp     fd, x30, [sp, -16]!

    mov     w1, O_FLAGS
    mov     w2, O_MODE

    //      open and close
    //      to just create the file
    bl      open
    mov     fd, x0

    bl      close

    mov     x0, fd
    ldp     fd, x30, [sp], 16
    ret

    .end