    .data
msg_fail_open:  .asciz  "File open failed. Try again.\n"
msg_fail_close: .asciz  "File close failed.\n"
debug1:         .asciz  "Bytes written: %d\n"
debug2:         .asciz  "Getting input now\n"
t_size:         .word   100
in_buffer:      .space  100

    .text
    .global write_to_file

    .equ    O_FLAGS, 0001   // O_WRONLY
    fd      .req    w19
    stdin   .req    x20
    len     .req    w21
write_to_file:
    stp     x19, x30, [sp, -16]!
    stp     x21, stdin, [sp, -16]!

    mov     w1, O_FLAGS
    bl      open

    //      check if file opened properly
    cmp     w0, wzr
    blt     100f

    mov     fd, w0
    bl      getStdin
    mov     stdin, x0

    bl      clearInputBuffer

5:  //      start write loop
    //      empty line to break

    //      get input line
    ldr     x0, =debug2
    bl      printf
    
    ldr     x0, =in_buffer
    ldr     x1, =t_size
    ldr     w1, [x1]
    mov     x2, stdin
    bl      fgets

    //      get length of line
    ldr     x0, =in_buffer
    bl      plen

    //      empty line is the only line
    //      that will have 1 character (\n)
    cmp     w0, 1
    beq     10f

    //      write to file
    mov     w2, w0
    mov     w0, fd
    ldr     x1, =in_buffer
    bl      write

    mov     w1, w0
    ldr     x0, =debug1
    bl      printf

    b       5b

10:
    mov     w0, fd
    bl      close

    //      check if file closed properly
    cbnz    w0, 101f

99:
    ldp     x21, stdin, [sp], 16
    ldp     x19, x30, [sp], 16
    ret

100:
    ldr     x0, =msg_fail_open
    b       120f
101:
    ldr     x0, =msg_fail_close

120:
    bl      printf

    mov     w0, -1
    b       99b

    .end