    .data
in_buffer:      .space  20  // 20 character buffer for input filename
msg_get_file:   .asciz  "Enter a file name: "
msg_inv_file:   .asciz  "Invalid filename. "
in_format:      .asciz  "%20s"
debug1:         .asciz  "Is filename valid? %d\n\n"

    .text
    .global get_file_name
get_file_name:
    str     x30, [sp, -16]!
    
5:
    //      get file name from stdin
    ldr     x0, =msg_get_file
    bl      printf

    ldr     x0, =in_format
    ldr     x1, =in_buffer
    bl      scanf

    //      validate filename
    ldr     x0, =in_buffer
    bl      validate_filename

    cbnz    x0, 50f

    ldr     x0, =in_buffer
    ldr     x30, [sp], 16
    ret

50:
    //      invalid filename message
    ldr     x0, =msg_inv_file
    bl      printf
    b       5b

    .end