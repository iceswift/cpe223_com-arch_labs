data       DCD     10, 12, 8, 1, 5, 7, 11, 6, 9

main       
           LDR     R0, =data
           MOV     R1, #0
           MOV     R2, #8
           BL      quicksort
stop       B       stop

quicksort  
           CMP     R1, R2
           BGE     qs_exit

           STMFD   SP!, {R1, R2, LR}

           BL      partition

           STMFD   SP!, {R3}
           SUB     R2, R3, #1
           BL      quicksort
           LDMFD   SP!, {R3}

           LDR     R2, [SP, #4]
           ADD     R1, R3, #1
           BL      quicksort

           LDMFD   SP!, {R1, R2, PC}

qs_exit    
           MOV     PC, LR

partition  
           ADD     R4, R0, R2, LSL #2
           LDR     R5, [R4]

           SUB     R6, R1, #1
           MOV     R7, R1

loop_check 
           CMP     R7, R2
           BGE     loop_end

           ADD     R8, R0, R7, LSL #2
           LDR     R9, [R8]

           CMP     R9, R5
           BGT     no_swap

           ADD     R6, R6, #1
           ADD     R10, R0, R6, LSL #2
           LDR     R11, [R10]
           STR     R9, [R10]
           STR     R11, [R8]

no_swap    
           ADD     R7, R7, #1
           B       loop_check

loop_end   
           ADD     R6, R6, #1
           ADD     R10, R0, R6, LSL #2
           LDR     R11, [R10]
           STR     R5, [R10]
           STR     R11, [R4]

           MOV     R3, R6
           MOV     PC, LR