    .data
extension:      .asciz  ".dat"

    .text
    .global add_extension_to_file

    //  params:
    //  x0 - size of filename (including \0)
    //  x1 - address of filename
    //
    //  x2 - address of extension
    ext             .req    x2
    ext_c           .req    w3
add_extension_to_file:
    ldr     ext, =extension

    //      go to end of in_buffer
    //      remove null-terminator
    add     x1, x1, x0
    sub     x1, x1, 1

    b       10f

5:
    strb    ext_c, [x1], 1

10:
    ldrb    ext_c, [ext], 1
    cbnz    ext_c, 5b

    //      add null terminator
    strb    wzr, [x1]
    ret