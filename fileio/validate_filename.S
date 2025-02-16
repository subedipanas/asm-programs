    .data
in_buffer:      .space  100  // 100 character buffer for input
msg_get_file:   .asciz  "Enter a file name: "
in_format:      .asciz  "%s"
debug1:         .asciz  "%d "
debug2:         .asciz  "Counter: %d\n"

    .text
    .global validate_filename

    filename        .req    x0
    current_char    .req    w1
validate_filename:

    mov     filename, x0

    b       10f
5:

    //      before 0
    cmp     current_char, 48
    blt     95f

    //      before 9
    cmp     current_char, 57
    ble     10f

    //      before A
    cmp     current_char, 65
    blt     95f

    //      before Z
    cmp     current_char, 90
    ble     10f

    //      before a
    cmp     current_char, 97
    blt     95f

    //      after z
    cmp     current_char, 122
    bgt     95f

10:
    ldrb    current_char, [filename], 1

    //      check for null terminator
    cbnz    current_char, 5b

90:
    //      valid filename
    mov     x0, xzr
    ret

95:
    mov     x0, -1
    ret

    .end