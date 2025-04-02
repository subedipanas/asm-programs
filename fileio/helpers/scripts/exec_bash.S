    .data
bash_path:      .asciz  "/bin/bash"
debug:          .asciz  "Freed\n"
debug_mem:      .asciz  "Allocated address: %p\n"
exec_status:    .word   0
msg_exec_end_bad:   .asciz  "(exec_bash) execve terminated abnormally\n"
msg_exec_end:   .asciz  "(exec_bash) execve exited with status %d\n"
msg_no_fork:    .asciz  "(exec_bash) Unable to create child process\n"
msg_no_alloc:   .asciz  "(exec_bash) Unable to allocate extra memory\n"
msg_no_execve:  .asciz  "(exec_bash) Unable to run bash program\n"

    .text
    .global exec_bash
    
    /**
    *   @param x0   - script path
    *   @param w1   - arg count
    *   @param x2   - arg array
    *
    */
    exec_args       .req    x19
    in_arg_count    .req    w20
    in_args         .req    x21
    script_path     .req    x22
exec_bash:
    stp     exec_args, x30, [sp, -16]!
    stp     x20, in_args, [sp, -16]!
    str     script_path, [sp, -16]!

    //      store params
    mov     script_path, x0
    mov     in_arg_count, w1
    mov     in_args, x2

    //      create args array
    //      add arg_count + 3 extra bytes
    //      for bash_path, script_path, and NULL
    //      args = {bash_path, script_path, arg1,..., NULL}
    add     w0, in_arg_count, 3
    bl      malloc
    cbz     x0, 200f
    mov     exec_args, x0

    bl      fork
    cmp     w0, wzr
    blt     205f
    bgt     10f

    //      Child process:
    //      Setup args and run
    //      execve(bash_path, args, NULL)
    //      NULL to inherit current env

    //      Setup args from arg_array
    mov     x0, exec_args

    ldr     x1, =bash_path
    str     x1, [x0], 8
    str     script_path, [x0], 8

    mov     w2, wzr
    mov     x3, in_args
    b       5f

1:
    ldr     x4, [x3], 8
    str     x4, [x0], 8

5:
    add     w2, w2, 1
    cmp     w2, in_arg_count
    ble     1b

    str     xzr, [x0]

    //      setup params and execute execve
    ldr     x0, =bash_path
    mov     x1, exec_args
    mov     x2, xzr
    bl      execve
    b       210f

10:
    //      parent process
    ldr     x0, =exec_status
    bl      wait

    //      check successful exit
    ldr     x0, =exec_status
    ldr     w0, [x0]
    and     w0, w0, 0x7f
    cbnz    w0, 15f

    //      on successful exit
    //      get exit status number
    ldr     x0, =exec_status
    ldr     w0, [x0]

    lsr     w0, w0, 8
    and     w23, w0, 15
    b       20f

15:
    ldr     x0, =msg_exec_end_bad
    bl      printf

20:

    mov     x0, exec_args
    bl      free

    mov     w0, w23

99:

    ldr     script_path, [sp], 16
    ldp     x20, in_args, [sp], 16
    ldp     exec_args, x30, [sp], 16
    ret

100:
    mov     w0, -1
    b       99b

200:
    ldr     x0, =msg_no_alloc
    b       299f

205:
    ldr     x0, =msg_no_fork
    b       298f

210:
    ldr     x0, =msg_no_execve

298:
    //      free allocated memory
    mov     x0, exec_args
    bl      free

299:
    //      print errors from 2xx
    bl      printf
    b       100b