    .data
// 24 character buffer for input filename + extension
in_buffer:      .space  24

in_format:      .asciz  "%20s"
msg_get_file:   .asciz  "Enter a file name: "
msg_inv_file:   .asciz  "Invalid filename. \n"
msg_filename:   .asciz  "Full filename: %s\n"

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

    cmp     x0, 0
    ble     50f
    //      filename is valid

    ldr     x1, =in_buffer
    bl      add_extension_to_file

    //      display full filename
    ldr     x0, =msg_filename
    ldr     x1, =in_buffer
    bl      printf

    //      return filename
    ldr     x0, =in_buffer
    ldr     x30, [sp], 16
    ret

50:
    //      invalid filename message
    ldr     x0, =msg_inv_file
    bl      printf
    b       5b

    .end