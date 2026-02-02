Data      DCD     10,12,8,1,5,7,11,6,8

          LDR     R0,=Data
          MOV     R1,#0
          MOV     R2,#8
          BL      quicksort
          END

quicksort 
          CMP     R1,R2
          BGE     qs_end

          BL      partition ; find pivot index

          STMFD   SP!,{R2,LR}
          SUB     R2,R3,#1
          BL      quicksort ; sort left part
          LDMFD   SP!,{R2,LR}

          ADD     R1,R3,#1
          BL      quicksort ; sort right part

qs_end    MOV     PC,LR

partition 
          ADD     R5,R0,R2,LSL #2
          LDR     R6,[R5] ; pivot = arr[high]

          MOV     R7,R1
          SUB     R7,R7,#1 ; i = low - 1

          MOV     R8,R1 ; j = low

p_loop    CMP     R8,R2
          BGE     p_end_for

          ADD     R9,R0,R8,LSL #2
          LDR     R10,[R9] ; arr[j]

          CMP     R10,R6
          BGT     p_no_swap

          ADD     R7,R7,#1
          ADD     R11,R0,R7,LSL #2

          LDR     R12,[R11]
          STR     R10,[R11]
          STR     R12,[R9] ; swap

p_no_swap 
          ADD     R8,R8,#1
          B       p_loop

p_end_for 
          ADD     R7,R7,#1
          ADD     R11,R0,R7,LSL #2

          LDR     R12,[R11]
          STR     R6,[R11] ; place pivot
          STR     R12,[R5]

          MOV     R3,R7 ; return i+1
          MOV     PC,LR