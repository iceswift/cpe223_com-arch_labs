.LC0:
        .ascii  "Fibonacci of %d is %lld\000"
main:
        push    {r4, r5, r7, lr}
        sub     sp, sp, #32
        add     r7, sp, #0
        movs    r3, #44
        str     r3, [r7, #8]
        vmov.i32        d16, #0  @ di
        vstr.64 d16, [r7, #24]    @ int
        mov     r2, #1
        mov     r3, #0
        strd    r2, [r7, #16]
        movs    r3, #2
        str     r3, [r7, #12]
        b       .L2
.L3:
        ldrd    r0, [r7, #24]
        ldrd    r2, [r7, #16]
        adds    r4, r0, r2
        adc     r5, r1, r3
        strd    r4, [r7]
        ldrd    r2, [r7, #16]
        strd    r2, [r7, #24]
        ldrd    r2, [r7]
        strd    r2, [r7, #16]
        ldr     r3, [r7, #12]
        adds    r3, r3, #1
        str     r3, [r7, #12]
.L2:
        ldr     r2, [r7, #12]
        ldr     r3, [r7, #8]
        cmp     r2, r3
        ble     .L3
        ldrd    r2, [r7, #16]
        ldr     r1, [r7, #8]
        movw    r0, #:lower16:.LC0
        movt    r0, #:upper16:.LC0
        bl      printf
        movs    r3, #0
        mov     r0, r3
        adds    r7, r7, #32
        mov     sp, r7
        pop     {r4, r5, r7, pc}