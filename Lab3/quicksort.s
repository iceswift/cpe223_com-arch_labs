ADR     R0, DATA_ARR
        MOV     R1, #0
        MOV     R2, #9
        BL      QUICKSORT
        END

QUICKSORT
        PUSH    {R1-R3, LR}
        CMP     R1, R2
        BGE     QS_EXIT

        BL      PARTITION

        PUSH    {R1, R2, R3}
        SUB     R2, R3, #1
        BL      QUICKSORT
        POP     {R1, R2, R3}

        ADD     R1, R3, #1
        BL      QUICKSORT

QS_EXIT
        POP     {R1-R3, PC}

PARTITION
        PUSH    {R4-R8}
        LDR     R8, [R0, R2, LSL #2]
        SUB     R3, R1, #1
        MOV     R4, R1

PART_LOOP
        CMP     R4, R2
        BGE     PART_SWAP
        LDR     R5, [R0, R4, LSL #2]
        CMP     R5, R8
        BGT     PART_NEXT

        ADD     R3, R3, #1
        LDR     R6, [R0, R3, LSL #2]
        STR     R5, [R0, R3, LSL #2]
        STR     R6, [R0, R4, LSL #2]

PART_NEXT
        ADD     R4, R4, #1
        B       PART_LOOP

PART_SWAP
        ADD     R3, R3, #1
        LDR     R6, [R0, R3, LSL #2]
        STR     R8, [R0, R3, LSL #2]
        STR     R6, [R0, R2, LSL #2]

        POP     {R4-R8}
        MOV     PC, LR

DATA_ARR
        DCD     45, 12, 89, 3, 15, 1, 99, 21, 5, 50