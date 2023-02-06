        ORG     #8000
;
START   EQU     #9000
REG_AY  EQU     #FFFD
DAT_AY  EQU     #BFFD
;

; This code will clear the screen and print "TXT1" on the screen.
        DI
        LD      A,1
        OUT     (#FE),A
        CALL    CLS
        LD      DE,0
        LD      HL,TXT1
        CALL    PRI_BB

; This code checks if the bit 7 of the value stored at memory address #FE is set. 
If it is, the code calls a function to clear the screen and then prints the text stored at TXT2 and TXT20.

L1
        LD      A,#7F
        IN      A,(#FE)
        RRA
        JR      C,L1
        CALL    CLS
        LD      DE,#0005
        LD      HL,TXT2
        CALL    PRI_BB
        LD      DE,#0100
        LD      HL,TXT20
        CALL    PRI_BB
;
; This code displays three lines of text, then waits for input from the user.
; It loads the address of TXT3 into HL, 0200 into DE, and calls the PRI_BB subroutine. 
; It then loads the address of TXT4 into HL, 0300 into DE, and calls PRI_BB again. 
; It does the same thing for TXT5 and 0400. 
; Finally it calls PRINTHLP and INPUT, and then prints the result.
        LD      HL,TXT3
        LD      DE,#0200
        CALL    PRI_BB
        LD      HL,TXT4
        LD      DE,#0300
        CALL    PRI_BB
        LD      HL,TXT5
        LD      DE,#0400
        CALL    PRI_BB
        CALL    PRINTHLP
        LD      HL,START
        LD      (ADRES),HL
        CALL    INPUT

        CALL    PRINT


; The code loops infinitely, outputting 1 to port FE and waiting for a keypress. If the keypress is <SPACE>, the program exits. 
; It runs an infinite loop that loads the value 1 into register A, outputs that value to port FE, loads the value 127 into 
; register A, reads from port FE into register A, right-shifts register A, and if the carry bit is not set, 
; jumps to the label CONT1. If the carry bit is set, it enables interrupts and returns.

LOOP
        LD      A,1
        OUT     (#FE),A
;
        LD      A,#7F
        IN      A,(#FE)
        RRA                     ;EXIT FROM PROGRAM
        JR      C,CONT1         ;BY <SPACE>
        EI
        RET


; This code increments the value at the address stored in ADRES, then calls PRINT to output the new value.
CONT1
        RRA                     ;INC 1 ADDRESS
        JR      C,CONT2         ;BY <SHIFT>
        LD      HL,(ADRES)
        INC     HL
        LD      (ADRES),HL
        CALL    PRINT
        JR      LOOP

; This code decrements the value at the address stored in the ADRES register, then calls the PRINT routine.
CONT2
        RRA                     ;DEC 1 ADDRESS
        JR      C,CONT3         ;BY <M>
        LD      HL,(ADRES)
        DEC     HL
        LD      (ADRES),HL
        CALL    PRINT
        JR      LOOP

; This code increments the value in the ADRES memory location, prints the new value, and then pauses.
CONT3
        RRA                     ;INC 256 ADDRESS
        JR      C,CONT4         ;BY "N"
        LD      HL,(ADRES)
        INC     H
        LD      (ADRES),HL
        CALL    PRINT
        CALL    PAUSE
        JR      LOOP

; It decrements the value at memory location ADRES, prints the new value, and then pauses.
CONT4
        RRA                     ;DEC 256 ADDRESS
        JR      C,CONT5         ;BY "B"
        LD      HL,(ADRES)
        DEC     H
        LD      (ADRES),HL
        CALL    PRINT
        CALL    PAUSE
        JR      LOOP

; It reads a character from the keyboard and prints it to the screen. This code loops through inputting and printing data.
CONT5
        LD      A,#BF           ;REINPUT DATA
        IN      A,(#FE)         ;BY <ENTER>
        RRA
        JP      C,LOOKOUT
        LD      A,4
        OUT     (#FE),A
        CALL    INPUT
        CALL    PRINT
        JP      LOOP

; 
This code looks for a specific data value, and if it finds it, it sends a code.
LOOKOUT
        RRA                     ;LOOKOUT DATA
        JP      NC,LOOK1        ;BY <L>
        RRA                     ;SEARCH START SECTION
        JP      NC,SEARCH       ;BY <K>
        RRA                     ;MODE SENDING CODE
        JP      C,LOOP          ;BY <J>
;----------------------
; The code is responsible for sending a code out on the data line. 
; It first sets the direction of the data line to output, 
; then it sends the code out on the data line, 
; then it sets the direction of the data line back to input.
SENDCODE
        LD      BC,REG_AY       ;SELECT B PORT
        LD      A,15
        OUT     (C),A
LOOPSEND
        DI
        LD      A,3
        OUT     (#FE),A
LOOPS1
        EI
        HALT
        LD      HL,23560
        LD      A,(HL)
        AND     A
        JP      Z,LOOPSEND
        LD      (HL),0
        CP      15
        JP      NZ,LOOPS2

        LD      BC,REG_AY       ;SELECT A PORT
        LD      A,14
        OUT     (C),A
        JP      LOOP
LOOPS2
        LD      B,8
        LD      E,A
LOOPSM_0
        PUSH    BC
        RL      E
        RL      A
        OR      #FE
        LD      BC,DAT_AY
        OUT     (C),A
        POP     BC
        DJNZ    LOOPSM_0

        LD      A,#FF           ;SET TO 1
        LD      BC,DAT_AY
        OUT     (C),A

        JP      LOOPSEND
;---------------------------

; 
This code searches for a specific value in memory. It starts by XORing the value with the number 7F. 
; This is done in order to get a unique value that can be easily identified. 
; Next, the code loops through all of the values in memory, looking for the unique value. 
; When it finds the value, it stores the address in the BC register.

SEARCH
        XOR     A               ;SEARCH START SECTION
        OUT     (#FE),A         ;BY <K>
        LD      A,#7F
        IN      A,(#FE)         ;EXIT FROM SEARCH
        RRA                     ;BY <SHIFT>
        RRA
        JP      NC,LOOP
        LD      BC,REG_AY
SEARCH1
        IN      A,(C)
        RRA
        JP      NC,SEARCH       ;CS is NOT 1
        RRA
        JP      NC,SEARCH       ;SDA is NOT 1
        RRA
        JP      NC,SEARCH       ;SCL is NOT 1

;Wait SDA in 0

SEARCH2
        IN      A,(C)
        RRA
        JP      NC,SEARCH       ;CS is NOT 1
        RRA
        JP      C,SEARCH2       ;SDA in 1
        RRA
        JP      NC,SEARCH       ;SCL is NOT 1

;SDA in 0,
;SCL in 1, Wait SCL in 0

SEARCH3
        IN      A,(C)
        RRA
        JP      NC,SEARCH       ;CS is NOT 1
        RRA
        JP      C,SEARCH        ;SDA is NOT 0
        RRA
        JP      C,SEARCH3       ;SCL in 1

;SDA in 0
;SCL in 0



;*** START SECTION ***
; The code loads the value 7 into the A register and outputs it to port FE. 
; It then enables and disables interrupts and jumps to the SEARCH label.
        LD      A,7
        OUT     (#FE),A
        EI
        HALT
        DI
        JP      SEARCH
LOOK1
        LD      A,2
        OUT     (#FE),A
        LD      A,#7F           ;EXIT FROM LOOKOUT
        IN      A,(#FE)         ;BY <SHIFT>
        RRA
        RRA
        JP      NC,LOOP

        CALL    GET_1_
        LD      (#4000),HL
        CALL    GET_1_
        LD      (#4100),HL
        CALL    GET_1_
        LD      (#4200),HL
        CALL    GET_1_
        LD      (#4300),HL
        CALL    GET_1_
        LD      (#4400),HL
        CALL    GET_1_
        LD      (#4500),HL
        CALL    GET_1_
        LD      (#4600),HL
        CALL    GET_1_
        LD      (#4700),HL
;
        CALL    GET_1_
        LD      (#4020),HL
        CALL    GET_1_
        LD      (#4120),HL
        CALL    GET_1_
        LD      (#4220),HL
        CALL    GET_1_
        LD      (#4320),HL
        CALL    GET_1_
        LD      (#4420),HL
        CALL    GET_1_
        LD      (#4520),HL
        CALL    GET_1_
        LD      (#4620),HL
        CALL    GET_1_
        LD      (#4720),HL
;
        JP      LOOK1
;------------------------

; The code gets the value of the AY register, strobes it once, and then returns the value.
GET_1_
        LD      HL,0
HANDH
        LD      BC,REG_AY
;
HANDH1
        IN      A,(C)           ;STROB 1
        RRA
        JP      NC,HANDH1
;
        LD      B,14
LP_H
        PUSH    BC
        CALL    GET_BYT
        RL      L
        RL      H
        POP     BC
        DJNZ    LP_H
        RET

; 
; The code gets a byte from the AY register. 
GET_BYT
        LD      BC,REG_AY
GET_BYT0
        IN      A,(C)
        RRA
        BIT     1,A             ;NOT STROB
        JP      Z,GET_BYT0
        RRA
        PUSH    AF
GET_BYT1
        IN      A,(C)
        RRA
        BIT     1,A
        JP      NZ,GET_BYT1
        POP     AF
        RET


; 
; It pauses the program for a moment.
PAUSE
        LD      HL,#4000
PAUSE1
        DEC     HL
        LD      A,H
        OR      L
        JR      NZ,PAUSE1
        RET
;
; It clears the screen and loads the program at 4000h-17FFh into memory.
CLS
        LD      HL,#4000
        LD      D,H
        LD      E,L
        INC     DE
        LD      BC,#17FF
        LD      (HL),L
        LDIR
        RET

; This code prints a decimal number stored in memory at the address ADRES.
PRINT
        LD      HL,(ADRES)
        LD      DE,#0021
        CALL    DECIMAL
;
        LD      C,1
        LD      HL,(ADRES)
        LD      DE,#0205
        CALL    LINE1
;
        LD      C,2
        LD      HL,(ADRES)
        LD      DE,#0305
        CALL    LINE1
;
        LD      C,4
        LD      HL,(ADRES)
        LD      DE,#0405
;
; The code specifically Convert from binary to decimal
LINE1
        LD      (_MPX),DE
        EX      DE,HL
        CALL    _OOR_Y
        LD      B,#33
LINE2
        PUSH    HL
        PUSH    BC
        LD      A,(HL)
        AND     C
        LD      E,"0"
        JR      Z,LINE3
        LD      E,"1"
LINE3
        LD      A,E
        CALL    _RIA
        POP     BC
        POP     HL
        INC     HL
        DJNZ    LINE2
        RET
;----------------------
;GENERAL INPUT FROM BUS
; This code reads data from an input port on a bus.  
; The code first sets up the A and B ports on the bus as input and output respectively. 
; It then sets the A port to #FF. 
; Next, it reads from the input port into HL, starting at the address START. 
; Finally, it loops until the H register is zero, at which point it returns.
;----------------------
INPUT
        LD      BC,REG_AY       ;SELECT 7 REGISTER
        LD      A,7
        OUT     (C),A
        LD      BC,DAT_AY
        LD      A,#80           ;A PORT - INPUT
        OUT     (C),A           ;B PORT - OUTPUT
;
        LD      BC,REG_AY       ;SELECT B PORT
        LD      A,15
        OUT     (C),A
        LD      BC,DAT_AY       ;B PORT = #FF
        LD      A,#FF
        OUT     (C),A
;
        LD      BC,REG_AY       ;SELECT A PORT
        LD      A,14
        OUT     (C),A
;
        LD      HL,START
        LD      BC,REG_AY
LOOP_I
        INI
        INC     B
        LD      A,H
        AND     A
        JP      NZ,LOOP_I
        RET
;----------------
; The code defines text strings that are to be displayed on a screen, and their corresponding memory addresses.

TXT1    DEFB    "PRESS <SPACE> TO INPUT DATA FROM I2C",0
TXT2    DEFB    "SHOW CHANNELS FROM ADDRESS:",0
TXT20   DEFB    "     |0   |1   |2   |3   |4   |5   |6   |7"
        DEFB    "   |8   |9   |10",0
TXT3    DEFB    "CH0>",0
TXT4    DEFB    "CH1>",0
TXT5    DEFB    "CH2>",0
TXTHLP1 DEFB    "HELP: <SPACE> - EXIT",0
        DEFB    "<SHIFT> - RIGHT 1, <M> - LEFT 1",0
        DEFB    "<N> - RIGHT 256, <B> - LEFT 256",0
        DEFB    "<L> - MODE LOOKOUT (<SHIFT> - EXIT)",0
        DEFB    "<K> - MODE SEARCH START SECTION (<SHIFT> - EXIT)",0
        DEFB    "<J> - MODE SEND CODE (GRF - EXIT)",0
;------------------------
; This code is responsible for printing the help text for the PRINTHLP command.

; This code defines the PRINTHLP label and uses it to print text stored in TXTHLP1, starting at memory location 1000. 
; It then prints text stored in memory locations 1106, 1206, 1306, and 1406. 
; Finally, it prints text stored in memory location 1506 and branches to the PRI_BB label.PRINTHLP
        LD      HL,TXTHLP1
        LD      DE,#1000
        CALL    PRI_BB
        LD      DE,#1106
        CALL    PRI_BB
        LD      DE,#1206
        CALL    PRI_BB
        LD      DE,#1306
        CALL    PRI_BB
        LD      DE,#1406
        CALL    PRI_BB
        LD      DE,#1506
        JP      PRI_BB
;
; It is looking for the value in the MPX register and comparing it to the value in the HL register. 
If it is greater, it will call the _OOR_Y function. If it is not greater, it will continue to the next instruction.
PRI_B   LD      (_MPX),DE
        EX      DE,HL
        CALL    _OOR_Y
LPRI_B  PUSH    BC
        LD      A,(HL)
        AND     A
        JR      Z,LPRI_C
        PUSH    HL
        CALL    _RIA
        POP     HL
        INC     HL
LPRI_C  POP     BC
        DJNZ    LPRI_B
        RET
;
; 
; This code is looping through a buffer and printing each character in the buffer to the screen.
PRI_BB  LD      (_MPX),DE
        EX      DE,HL
        CALL    _OOR_Y
LPRI_BB LD      A,(HL)
        INC     HL
        AND     A
        RET     Z
        CP      #20
        JR      C,LPRI_BB
        PUSH    HL
        CALL    _RIA
        POP     HL
        JP      LPRI_BB
;
; This code is loading the contents of register A into register C, and the contents of register B into register 0. 
; Then it is loading the value at address FPRIA into HL, and the value at address _MPX into DE. 
; Finally, it is calling the _OOR_Y routine and jumping to address #1A1B. why 
; The code is likely performing some kind of operation on the contents of registers A and B, 
;using the values at addresses FPRIA and _MPX as input. 

DEC99   LD      C,A
        LD      B,0
DEC9999 LD      HL,FPRIA
        LD      (#5C51),HL
        LD      (_MPX),DE
        CALL    _OOR_Y
        JP      #1A1B
FPRIA   DEFW    _RIA
;
; The code is pushing the AF register onto the stack, loading the DE register with the value in MPX, 
; calling the OOR_Y function, and then popping the AF register. 
; The code then loads the L register with the A register and the H register with 0. The code then jumps to DECIMA3.

DECIMA2 PUSH    AF
        LD      (_MPX),DE
        CALL    _OOR_Y
        POP     AF
        LD      L,A
        LD      H,0
        JR      DECIMA3
;
; It is printing out a number in decimal form. The code is first loading the value to be printed into the DE register, 
; then calling the PRIDCM routine to print it out. Finally, it is increasing the value in the MPX register 
; (which presumably contains the next value to be printed) and returning.
DECIMAL LD      (_MPX),DE
        EX      DE,HL
        CALL    _OOR_Y
        LD      DE,#2710
        CALL    PRIDCM
        LD      DE,#3E8
        CALL    PRIDCM
DECIMA3 LD      DE,#64
        CALL    PRIDCM
        LD      DE,10
        CALL    PRIDCM
        LD      A,L
        ADD     A,#30
        JP      _RIA
PRIDCM  LD      A,#2F
PRIDCM2 ADD     A,1
        SBC     HL,DE
        JR      NC,PRIDCM2
        ADD     HL,DE
        PUSH    HL
        CALL    _RIA
        POP     HL
        RET
_RIA    LD      (_OFO),A
        LD      A,(_MPX)
        LD      C,A
        SRL     A
        LD      HL,(_OADRS)
        ADD     A,L
        LD      L,A
        LD      A,C
        RRA
        LD      DE,FONT
_OFO    EQU     $-2
        LD      B,#0F
        JR      C,_OCHET
        LD      B,#F0
_OCHET  DEFW    #AE1A,#AEA0,#2477
        DEFB    #14
        DEFW    #AE1A,#AEA0,#2477
        DEFB    #14
        DEFW    #AE1A,#AEA0,#2477
        DEFB    #14
        DEFW    #AE1A,#AEA0,#2477
        DEFB    #14
        DEFW    #AE1A,#AEA0,#2477
        DEFB    #14
        DEFW    #AE1A,#AEA0,#2477
        DEFB    #14
        DEFW    #AE1A,#AEA0,#2477
        DEFB    #14
        DEFW    #AE1A,#AEA0
        DEFB    #77
        LD      HL,_MPX
        INC     (HL)
        RET
_OOR_Y  LD      H,TABSCR/256
        LD      A,(_MPY)
        ADD     A,A
        LD      L,A
        LD      A,(HL)
        INC     HL
        LD      H,(HL)
        LD      L,A
        LD      (_OADRS),HL
        EX      DE,HL
        RET
;---------------------
; This code is defining two variables, _MPX and _MPY, both of which are set to 0. 
; It is also defining a variable called ADRES, which is set to the value 0x8700.
; The code then includes a file called "FONT" which contains the code for a font. 
; This font is then used to display the text "EOF" on the screen.

_MPX    DEFB    0
_MPY    DEFB    0
_OADRS  DEFW    0
ADRES   DEFW    0
;
EOF     DISPLAY EOF
        ORG     #8700
TABSCR  DEFW    #4000,#4020,#4040,#4060,#4080,#40A0
        DEFW    #40C0,#40E0,#4800,#4820,#4840,#4860
        DEFW    #4880,#48A0,#48C0,#48E0,#5000,#5020
        DEFW    #5040,#5060,#5080,#50A0,#50C0,#50E0
;
        ORG     #8800
FONT
;       .INCBIN FONT
        .RUN    #8000
