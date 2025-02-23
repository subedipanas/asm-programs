    .data
msg_fail:   .asciz  "File creation failed. Check if file already exists.\n"

    .text
    .global create_file

    .equ    O_FLAGS, 0300   // O_CREAT | O_EXCL
    .equ    O_MODE, 0770    // rwxrwx---
    fd      .req    w19
create_file:
    stp     x19, x30, [sp, -16]!

    mov     w1, O_FLAGS
    mov     w2, O_MODE

    //      open and close
    //      to just create the file
    bl      open

    cmp     w0, wzr
    blt     10f

    mov     fd, w0
    bl      close
    b       99f

10:
    ldr     x0, =msg_fail
    bl      printf

    mov     w0, -1

99:
    ldp     x19, x30, [sp], 16
    ret

    .end