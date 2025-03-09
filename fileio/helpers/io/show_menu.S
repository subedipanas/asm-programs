    .data
title:      .asciz  "\n\nFile operations\n"
line1:      .asciz  "1. Create a file\n"
line2:      .asciz  "2. Write to a file\n"
line3:      .asciz  "3. Append to a file\n"
line4:      .asciz  "4. Read a file\n"
line5:      .asciz  "5. Delete a file\n"
line6:      .asciz  "6. Quit\n\n"

    .text
    .global menu

    .equ    MAX_CHOICES, 6

menu:
    str     x30, [sp, -16]!

    ldr     x0, =title
    bl      printf

    ldr     x0, =line1
    bl      printf

    ldr     x0, =line2
    bl      printf
    
    ldr     x0, =line3
    bl      printf
    
    ldr     x0, =line4
    bl      printf

    ldr     x0, =line5
    bl      printf

    ldr     x0, =line6
    bl      printf

    //      return max number
    //      of choices
    mov     x0, MAX_CHOICES

    ldr     x30, [sp], 16
    ret

    .end