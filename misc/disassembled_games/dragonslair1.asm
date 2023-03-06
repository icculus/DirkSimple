;
; (this file came from http://www.jeffsromhack.com/code/files/DLOne.zip   --ryan.)
;
;----------------------------------------------------
;    Disassembly of the file Dragon's Lair (set #1)
;    By Jeff Kulczycki, October 17, 2005
;    www.jeffsromhack.com
;----------------------------------------------------
;  Game Info
;----------------------------------------------------

;----------------------------------------------------
;                Reset/Powerup
;----------------------------------------------------
L0000:  JP      L2003           ;

;----------------------------------------------------
; This area tends to be a work area full of unused code
; possibly remnant code from not erasing? DL1
;----------------------------------------------------
        LD      SP,0A3FFh       ;
        LD      HL,0A000h       ;
        LD      DE,0A001h       ;
        LD      BC,003FFh       ;
        LD      (HL),000h       ;
        LDIR                    ;
        CALL    L2925           ;
        LD      A,(0A020h)      ;
        SET     4,A             ;
        LD      (0A020h),A      ;
        LD      (0E008h),A      ;
        CALL    L05EF           ;
        LD      (0A011h),A      ;
        CALL    L05E6           ;
        LD      (0A010h),A      ;
        BIT     3,A             ;
        JR      Z,L0048         ;
        LD      A,(0A011h)      ;
        LD      B,A             ;
        AND     0F0h            ;
        SET     0,E             ;
        NOP                     ;
        JR      NZ,L007B        ;
        SRL     A               ;
        ADD     A,C             ;
        LD      C,A             ;
        LD      A,B             ;
        AND     00Fh            ;
        ADD     A,C             ;
        OR      080h            ;
        JR      L004B           ;
L0048:  LD      A,(03815h)      ;
L004B:  LD      (0A018h),A      ;
;----------------------------------------------------
;  Check setting for Number of Dirks per credit (repeated)
;----------------------------------------------------
; This area tends to be a work area full of unused code
; possibly remnant code from not erasing? DL1
;----------------------------------------------------
        LD      HL,0A010h       ; Get DIP Switch A
        BIT     5,(HL)          ; Test A5 (Number of Dirks)
        JR      NZ,L005C        ; If set then do 5 Dirks   
        LD      A,0C3h          ; Set 3 Dirks
        LD      (0A015h),A      ; Store Number of Dirks
        JR      L0061           ; Skip ahead       
L005C:  LD      A,0C5h          ; Set 5 Dirks
        LD      (0A015h),A      ; Store Number of Dirks
L0061:  IM      1               ;
        EI                      ;
        LD      HL,0E030h       ;
        LD      B,010h          ;
L0069:  LD      (HL),00Fh       ;
        INC     HL              ;
        DJNZ    L0069           ;
        LD      A,001h          ;
        CALL    L27BE           ;
        LD      A,0F0h          ;
        CALL    L28C5           ;
        CALL    L01F4           ;
L007B:  CALL    L01F4           ;
        LD      A,001h          ;
        CALL    L27BE           ;
        LD      A,0F0h          ;
        CALL    L28C5           ;
        CALL    L022A           ;
        CALL    L0218           ;
        LD      A,000h          ;
        CALL    L27BE           ;
        LD      HL,0A00Eh       ;
        LD      A,(03814h)      ;
        LD      (HL),A          ;
        LD      L,00Fh          ;
        LD      (HL),000h       ;
        LD      DE,0A030h       ;
        LD      A,(0A011h)      ;
        BIT     1,A             ;
        JR      NZ,L00BF        ;
        LD      A,(0A011h)      ;
        BIT     0,A             ;
        JR      Z,L00BA         ;
        LD      HL,0A006h       ;
        INC     (HL)            ;
        LD      A,(HL)          ;
        AND     007h            ;
        CP      000h            ;
        JR      NZ,L00BF        ;
L00BA:  CALL    L0218           ;
        JR      L00C2           ;
L00BF:  CALL    L0221           ;
L00C2:  CALL    L23C4           ;
        CALL    L24BD           ;
        CALL    L022A           ;
        CALL    L05EF           ;
        LD      (0A011h),A      ;
        CALL    L05E6           ;
        LD      (0A010h),A      ;
        LD      HL,0A009h       ;
        XOR     A               ;
        CP      (HL)            ;
        JR      NZ,L012D        ;
        LD      HL,0A019h       ;
        CP      (HL)            ;
        JR      NZ,L011E        ;
        LD      A,(0A010h)      ;
        BIT     6,A             ;
        JR      NZ,L00F9        ;
        BIT     5,A             ;
        JR      Z,L00F4         ;
        LD      HL,03819h       ;
        JR      L00FC           ;
L00F4:  LD      HL,03816h       ;
        JR      L00FC           ;
        
        
        
        
L00F9:  LD      HL,0381Ch       ;
L00FC:  AND     003h            ;
        CP      000h            ;
        
        
;----------------------------------------------------
;     Convert number (frame number or score) to BCD 
;     BCD is Binary-Coded Decimal
;               A00B-A00D   Number awaiting conversion to BCD
;               A02C-A02E   BCD, Number after converted to BCD
;----------------------------------------------------        
;            Clear out BCD area A02C - A02E
;----------------------------------------------------
L0100:  LD      HL,0A02Ch       ; Setup BCD location to A02C
        LD      B,004h          ; B = 4, set Loop
L0105:  LD      (HL),000h       ; Store a zeros in BCD location
        INC     HL              ; Increment byte pointer
        DJNZ    L0105           ; B = B - 1, Loop until B = 0
;----------------------------------------------------
;               Begin BCD conversion
;----------------------------------------------------        
        LD      B,018h          ; B = 24, set Loop
L010C:  LD      HL,0A00Bh       ; Number to convert starts at A00B
        LD      C,003h          ; C = 3, set Loop
        XOR     A               ; Clear carry
L0112:  RL      (HL)            ; Roll BCD bits to the left
        INC     HL              ; Increment byte pointer
        DEC     C               ; C = C - 1
        JP      NZ,L0112        ; Loop until C = 0
        LD      HL,0A02Ch       ; Set beginning of BCD area
        LD      C,004h          ; C = 4, set Loop
L011E:  LD      A,(HL)          ; Get BCD byte
        ADC     A,(HL)          ; BCD = BCD * 2 + Carry
        DAA                     ; Convert to decimal
        LD      (HL),A          ; Store calculation in BCD
        INC     HL              ; Go to next BCD byte 
        DEC     C               ; C = C - 1
        JP      NZ,L011E        ; Loop until C = 0, all BCD bytes
        DJNZ    L010C           ; B = B - 1, Get next bit until B = 0
        RET                     ; Return


   
;----------------------------------------------------
;           LDPlayer Search for Frame Command
;----------------------------------------------------
L012A:  CALL    L0100           ; Convert frame number to BCD
L012D:  LD      HL,0A02Eh       ; Set pointer to first number
        LD      A,(HL)          ; Get number
        AND     00Fh            ; Get lower nibble of digit
        CALL    L019D           ; Convert data to LDPlayer Command Code
        CALL    L01A8           ; Send $FF then Command byte to LDPlayer
        DEC     HL              ; Point to next digit
        LD      A,(HL)          ; Get next digit
        SRL     A               ; Shift right, Isolate upper nibble
        SRL     A               ; Shift right
        SRL     A               ; Shift right
        SRL     A               ; Shift right
        CALL    L019D           ; Convert data to LDPlayer Command Code
        CALL    L01A8           ; Send $FF then Command byte to LDPlayer
        
        LD      A,(HL)          ; Get next digit
        AND     00Fh            ; Isolate lower nibble digit
        CALL    L019D           ; Convert data to LDPlayer Command Code
        CALL    L01A8           ; Send $FF then Command byte to LDPlayer
        DEC     HL              ; Point to next digit
        LD      A,(HL)          ; Get next digit
        SRL     A               ; Shift right, Isolate upper nibble
        SRL     A               ; Shift right
        SRL     A               ; Shift right
        SRL     A               ; Shift right
        CALL    L019D           ; Convert data to LDPlayer Command Code
L015F:  CALL    L01A8           ; Send $FF then Command byte to LDPlayer

        LD      A,(HL)          ; Get next digit
        AND     00Fh            ; Get lower nibble
        CALL    L019D           ; Convert data to LDPlayer Command Code
        CALL    L01A8           ; Send $FF then Command byte to LDPlayer
        
        LD      A,00Ah          ; Set data to SEARCH ($0A)
        CALL    L019D           ; Convert data to LDPlayer Command Code
        CALL    L01A8           ; Send $FF then Command byte to LDPlayer
        
;----------------------------------------------------
;    LDPlayer routine for DL1 include BONUS Timeout
;----------------------------------------------------        
L0173:  LD      DE,0151Eh       ; DL1 Include SEARCH Timeout
;----------------------------------------------------
;           Get SEARCH Data status from LDPlayer
;----------------------------------------------------
L0176:  LD      HL,0C010h       ; Wait for falling edge
        BIT     7,(HL)          ; of Status Strobe
        JP      Z,L018A         ; Loop until Status Strobe low
        
        DEC     DE              ; Decrement SEARCH Timeout
        LD      A,D             ; Check if expired
        OR      D               ; Has timeout expired?
        JP      NZ,L0176        ; No, so continue to wait
        
;----------------------------------------------------
;     DL1 decrements the BONUS, but why here?
;----------------------------------------------------        
        CALL    L282F           ; Decrement BONUS and increment score
        JP      L0173           ; Loop back and read LDPlayer data
        
;----------------------------------------------------
;         SEARCH complete, now send PLAY command
;----------------------------------------------------        
L018A:  LD      HL,0A008h       ; HL = StatusA Register
        SET     2,(HL)          ; Turn OFF SEARCHing bit
        BIT     4,(HL)          ; Put scene in Freeza Frame?
        JP      Z,L019C         ; Yes, so skip PLAY command
        LD      A,00Bh          ; Set data to PLAY ($0B)
        CALL    L019D           ; Convert data to LDPlayer Command Code
        CALL    L01A8           ; Send $FF then Command byte to LDPlayer
L019C:  RET                     ; Return


   
;----------------------------------------------------
;               Get LDPlayer Command from Table
;----------------------------------------------------
;         A = index to command
;     $1000 = Start of Command Table (CommandTable)
;     $A021 = Gets loaded with Command Code
;----------------------------------------------------
L019D:  PUSH    HL              ; Save HL 
        LD      HL,01000h       ; Load start of table
        LD      L,A             ; Use A as index
        LD      A,(HL)          ; Get Command Code from table
        LD      (0A021h),A      ; Store Command Code in $A021
        POP     HL              ; Retrieve HL
        RET                     ; Return




;  Following commented lines appear in rev D, but not here (DL1)
;----------------------------------------------------
;   Two byte send command, works as follows:
;     -  Send $FF to LDPlayer
;     -  Send $(Command Code) to LDPlayer
;----------------------------------------------------
;L01AC:  PUSH    HL              ; Save HL to stack
;        PUSH    BC              ; Save BC to stack
;
;        LD      A,(0A021h)      ; Get Command Code
;        LD      B,A             ; B holds Command Code temporarily
;        LD      A,0FFh          ; Send $FF to LDPlayer first
;        LD      (0A021h),A      ; Put byte into send buffer
;        CALL    L01C4           ; Send byte to LDPlayer
;        LD      A,B             ; Send Command Code next
;        LD      (0A021h),A      ; Put byte into send buffer
;        CALL    L01C4           ; Send byte to LDPlayer

;        POP     BC              ; Get BC from stack
;        POP     HL              ; Get HL from stack
;        RET                     ; Return
        
   
;----------------------------------------------------
;                LDPlayer Communication
;----------------------------------------------------
;    Sends out a single byte to the LDPlayer
;    $A021 = location of command byte to send
;
;       1)  Send command to LDPlayer port
;       2)  Wait for Status Strobe to go high
;       3)  Wait for Status Strobe to go low
;       4)  Set LDV control register
;       5)  Wait for Command Strobe to go low
;       6)  Wait for Command Strobe to go high
;       7)  Set LDV control register
;----------------------------------------------------
;    Comm is slightly different in DL1 (diff player?)
;----------------------------------------------------
L01A8:  PUSH    HL              ;
        LD      HL,0A020h       ;
        RES     7,(HL)          ;
        LD      A,(HL)          ;
        LD      (0E008h),A      ;
        LD      A,(0A021h)      ;
        LD      (0E020h),A      ; 1) Send command to LDPlayer
        
        LD      HL,0A020h       ; Clear control register
        RES     5,(HL)          ;
        LD      A,(HL)          ;
        LD      (0E008h),A      ;
        RES     6,(HL)          ;
        LD      A,(HL)          ;
        LD      (0E008h),A      ;
        CALL    L01E1           ; Call DELAY (found in DL1)
        LD      HL,0A020h       ;
        SET     6,(HL)          ;
        LD      A,(HL)          ;
        LD      (0E008h),A      ;
        CALL    L01E1           ; Call DELAY (found in DL1)
        LD      HL,0A020h       ;
        SET     5,(HL)          ;
        LD      A,(HL)          ;
        LD      (0E008h),A      ;
        POP     HL              ;
        RET                     ;


   
;----------------------------------------------------
;                        DELAY
;----------------------------------------------------
L01E1:  LD      DE,0FFFFh       ; FFFF = -1
        LD      HL,00DF6h       ; Load delay value
L01E7:  ADD     HL,DE           ; Subtract 1 from loop
        JR      C,L01E7         ; Loop until delay expires
        RET                     ; Return

;----------------------------------------------------
;    Send Enable/Disable Audio command to LDPlayer
; moved in DL1 to L0218
;----------------------------------------------------
;    Send DISPLAY ENABLE/DISABLE command to LDPlayer
; moved in DL1 to L022A
;----------------------------------------------------   

;----------------------------------------------------
;        Send STOP command to LDPlayer (not used)
;----------------------------------------------------
        LD      A,00Ch          ; Set data to STOP ($0C)
        CALL    L019D           ; Convert data to LDPlayer Command Code
        CALL    L01A8           ; Send $FF then Command byte to LDPlayer
        RET                     ;


   
;----------------------------------------------------
;          Send PLAY command to LDPlayer 
;----------------------------------------------------
L01F4:  LD      A,00Bh          ; Set data to PLAY ($0B)        
        CALL    L019D           ; Convert data to LDPlayer Command Code
        CALL    L01A8           ; Send $FF then Command byte to LDPlayer
        RET                     ; Return


   
;----------------------------------------------------
;              Send <unknown> command to LDPlayer
;----------------------------------------------------
        LD      A,016h          ; Set data to <unknown> ($16)
        CALL    L019D           ; Convert data to LDPlayer Command Code
        CALL    L01A8           ; Send $FF then Command byte to LDPlayer
        RET                     ;


   
;----------------------------------------------------
;      Send AUDIO 1 command to LDPlayer (not used)
;----------------------------------------------------
        LD      A,010h          ; Set data to AUDIO 1 ($10)           
        CALL    L019D           ; Convert data to LDPlayer Command Code
        CALL    L01A8           ; Send $FF then Command byte to LDPlayer
        RET                     ; Return


   
;----------------------------------------------------
;      Send AUDIO 2 command to LDPlayer (not used)
;----------------------------------------------------
        LD      A,011h          ; Set data to AUDIO 2 ($11)
        CALL    L019D           ; Convert data to LDPlayer Command Code
        CALL    L01A8           ; Send $FF then Command byte to LDPlayer
        RET                     ; Return


   
;----------------------------------------------------
;         Send Enable Audio command to LDPlayer
;  not on rev D (DL1)
;----------------------------------------------------
L0218:  LD      A,012h          ; Set data to ENABLE AUDIO ($12)
        CALL    L019D           ; Convert data to LDPlayer Command Code
        CALL    L01A8           ; Send $FF then Command byte to LDPlayer
        RET                     ; Return


   
;----------------------------------------------------
;         Send Disable Audio command to LDPlayer
;  not on rev D (DL1)
;----------------------------------------------------
L0221:  LD      A,013h          ; Set data to DISABLE AUDIO ($13)
        CALL    L019D           ; Convert data to LDPlayer Command Code
        CALL    L01A8           ; Send $FF then Command byte to LDPlayer
        RET                     ; Return


   
;----------------------------------------------------
;        Send DISPLAY DISABLE command to LDPlayer
;----------------------------------------------------
L022A:  LD      A,014h          ; Set data to DISPLAY DISABLE ($14)
        CALL    L019D           ; Convert data to LDPlayer Command Code
        CALL    L01A8           ; Send $FF then Command byte to LDPlayer
        RET                     ; Return


   
;----------------------------------------------------
;        Send DISPLAY ENABLE command to LDPlayer
;----------------------------------------------------
        LD      A,015h          ; Set data to DISPLAY ENABLE ($15)
        CALL    L019D           ; Convert data to LDPlayer Command Code
        CALL    L01A8           ; Send $FF then Command byte to LDPlayer
        RET                     ; Return


   
;----------------------------------------------------
;             Begin Running Diagnostics
;----------------------------------------------------
L023C:  DI                      ; Disable Interrupts
        LD      SP,0A7FFh       ; Set stack pointer
;----------------------------------------------------
;    Display Screen: "Begin Diagnostics, RAM Test"
;----------------------------------------------------        
        LD      HL,00099h       ; Load frame number
        LD      (0A00Bh),HL     ; Store frame number
        LD      A,000h          ; Load frame number
        LD      (0A00Dh),A      ; Store frame number
        LD      HL,0A008h       ; HL = StatusA Register
        RES     4,(HL)          ; Enable Freeze Frame
        CALL    L012A           ; Send SEARCH to LDPlayer
        CALL    L04D7           ; Delay for x seconds
;----------------------------------------------------
;                   RAM Test
;----------------------------------------------------        
        LD      HL,0A000h       ; Fill 2K RAM
        LD      DE,0A001h       ; Setup Loop
        LD      BC,007FFh       ; Setup Loop
        LD      (HL),055h       ; Write $55 to RAM
        LDIR                    ; Loop until RAM full
        LD      HL,0A000h       ; Read 2K RAM
        LD      BC,00800h       ; Setup Loop
        LD      A,055h          ; Check for $55
L026B:  CPI                     ;
        JP      NZ,L0293        ; RAM incorrect
        JP      PE,L026B        ; Continue reading RAM
        LD      HL,0A000h       ; Fill 2K RAM
        LD      DE,0A001h       ; Setup Loop
        LD      BC,007FFh       ; Setup Loop
        LD      (HL),0AAh       ; Write $AA to RAM
        LDIR                    ; Loop until RAM full
        LD      HL,0A000h       ; Read 2K RAM
        LD      BC,00800h       ; Setup Loop
        LD      A,0AAh          ; Check for $AA
L0288:  CPI                     ;
        JP      NZ,L0293        ; RAM incorrect
        JP      PE,L0288        ; Continue reading RAM
        JP      L02AC           ; Begin EEPROM test
;----------------------------------------------------
;           Display Screen: "RAM Test Fail"
;----------------------------------------------------        
L0293:  LD      SP,0A7FFh       ; Set stack pointer
        LD      HL,000ADh       ; Load frame number
        LD      (0A00Bh),HL     ; Store frame number
        LD      A,000h          ; Load frame number
        LD      (0A000h),A      ; Store frame number
        LD      HL,0A008h       ; HL = StatusA Register
        RES     4,(HL)          ; Enable Freeze Frame
        CALL    L012A           ; Send SEARCH to LDPlayer
L02A9:  JP      L02A9           ; Wait for RESET -- FAIL



;----------------------------------------------------
;                   EEPROM Test
;----------------------------------------------------
L02AC:  LD      SP,0A7FFh       ; Set stack pointer
;----------------------------------------------------
;    Display Screen: "RAM Passed, begin ROM Test"
;----------------------------------------------------
        LD      HL,0009Ch       ; Get frame number
        LD      (0A00Bh),HL     ; Store frame number
        LD      A,000h          ; Get frame number
        LD      (0A00Dh),A      ; Store frame number
        LD      HL,0A008h       ; HL = StatusA Register 
        RES     4,(HL)          ; Enable Freeze Frame
        CALL    L012A           ; Send SEARCH to LDPlayer
        CALL    L04D7           ; Delay for x seconds
;----------------------------------------------------
;               Diagnose U1 EEPROM
;----------------------------------------------------        
        LD      DE,00000h       ; DE = Start of ROM1 ($0000)
        LD      A,020h          ; End of ROM1 = $20 ($2000)
        LD      (0A022h),A      ; Store End of ROM
        CALL    L0322           ; Calculate Checksum
        LD      DE,(0A023h)     ; DE = Calculated Checksum
        LD      HL,(06FFCh)     ; HL = Correct Checksum
;       CALL    Verify    <--this line is missing
;----------------------------------------------------
;                 Diagnose U2 EEPROM
;----------------------------------------------------        
        LD      DE,02000h       ; DE = Start of ROM2 ($2000)
        LD      A,040h          ; End of ROM2 = $40 ($4000)
        LD      (0A022h),A      ; Store End of ROM
        CALL    L0322           ; Calculate Checksum
        LD      DE,(0A023h)     ; DE = Calculated Checksum
        LD      HL,(06FFEh)     ; HL = Correct Checksum
;       CALL    Verify    <--this line is missing        
;----------------------------------------------------
;                 Diagnose U3 EEPROM
;----------------------------------------------------
        LD      DE,04000h       ; DE = Start of ROM3 ($4000)
        LD      A,060h          ; End of ROM3 = $60 ($6000)
        LD      (0A022h),A      ; Store End of ROM
        CALL    L0322           ; Calculate Checksum
        LD      DE,(0A023h)     ; DE = Calculated Checksum
        LD      HL,(06FFAh)     ; HL = Correct Checksum
;       CALL    Verify    <--this line is missing
;----------------------------------------------------
;                 Diagnose U4 EEPROM
;----------------------------------------------------        
        LD      DE,06000h       ; DE = Start of ROM4 ($6000)
        LD      A,080h          ; End of ROM4 = $80 ($8000)
        LD      (0A022h),A      ; Store End of ROM 
        CALL    L0322           ; Calculate Checksum
        LD      DE,(0A023h)     ; DE = Calculated Checksum
        LD      HL,(06FF8h)     ; HL = Correct Checksum
;       CALL    Verify    <--this line is missing        
;----------------------------------------------------
;                 Diagnose U5 EEPROM
;----------------------------------------------------
        LD      DE,08000h       ; DE = Start of ROM5 ($8000)
        LD      A,0A0h          ; End of ROM5 = $A0 ($A000)
        LD      (0A022h),A      ; Store End of ROM
        CALL    L0322           ; Calculate Checksum
        LD      DE,(0A023h)     ; DE = Calculated Checksum
        LD      HL,(06FF6h)     ; HL = Correct Checksum
;       CALL    Verify    <--this line is missing        
        JP      L03B3           ; Begin next test:  Sound Test
        
        
        
;----------------------------------------------------
;                Calculate Checksum
; Checksum = Total of all byte values added together
;----------------------------------------------------        
L0322:  LD      HL,00000h       ; HL = 0000
        LD      (0A023h),HL     ; Clear Calculated Checksum to zero
L0328:  LD      B,000h          ; B = 0
        EX      DE,HL           ; Swap DE,HL
        LD      C,(HL)          ; Get byte from ROM location
        EX      DE,HL           ; Swap DE,HL back
        LD      HL,(0A023h)     ; Get Calculated Checksum
        ADD     HL,BC           ; Add byte value to the Calculated Checksum
        LD      (0A023h),HL     ; Store Calculated Checksum
        INC     DE              ; Point to next ROM location
        LD      A,(0A022h)      ; Get ending ROM location
        CP      D               ; Have we reached end of ROM?
        JR      NZ,L0328        ; No, so continue until all ROM is checked  
        RET                     ; Return


   
;----------------------------------------------------
;                Verify Checksum (not used)
;      DE = Calculated Checksum
;      HL = Correct Checksum
;----------------------------------------------------
;Verify:
        LD      A,D             ; Get Checksum upper nibble
        CP      H               ; Is Checksum upper nibble correct?
        JP      NZ,L0347        ; No, EEPROM FAILED
        LD      A,E             ; Get Checksum lower nibble
        CP      L               ; Is Checksum lower nibble correct?
        JP      NZ,L0347        ; No, EEPROM FAILED
        RET                     ; Return


   
;----------------------------------------------------
;         Determine which EEPROM failed
;----------------------------------------------------
L0347:  LD      A,(0A022h)      ; Get status
        CP      040h            ; U2 Checksum FAIL?
        JP      Z,L036F         ; Yes, show screen
        CP      060h            ; U3 Checksum FAIL?
        JP      Z,L0380         ; Yes, show screen
        CP      080h            ; U4 Checksum FAIL?
        JP      Z,L0391         ; Yes, show screen
        CP      0A0h            ; U5 Checksum FAIL?
        JP      Z,L03A2         ; Yes, show screen
        
;----------------------------------------------------
;        Display Screen: "EEPROM U1 Failed"
;----------------------------------------------------        
        LD      HL,000B0h       ; Get frame number
        LD      (0A00Bh),HL     ; Store frame number
        LD      A,000h          ; Get frame number
        LD      (0A00Dh),A      ; Store frame number
        CALL    L012A           ; Send SEARCH to LDPlayer
        JP      L02A9           ; Jump Wait for RESET -- FAIL

;----------------------------------------------------
;        Display Screen: "EEPROM U2 Failed"
;----------------------------------------------------        
L036F:  LD      HL,000B3h       ; Get frame number
        LD      (0A00Bh),HL     ; Store frame number
        LD      A,000h          ; Get frame number
        LD      (0A00Dh),A      ; Store frame number
        CALL    L012A           ; Send SEARCH to LDPlayer
        JP      L02A9           ; Jump Wait for RESET -- FAIL
        
;----------------------------------------------------
;        Display Screen: "EEPROM U3 Failed"
;----------------------------------------------------        
L0380:  LD      HL,000B6h       ; Get frame number
        LD      (0A00Bh),HL     ; Store frame number
        LD      A,000h          ; Get frame number
        LD      (0A00Dh),A      ; Store frame number
        CALL    L012A           ; Send SEARCH to LDPlayer
        JP      L02A9           ; Jump Wait for RESET -- FAIL
        
;----------------------------------------------------
;        Display Screen: "EEPROM U4 Failed"
;----------------------------------------------------        
L0391:  LD      HL,000B9h       ; Get frame number
        LD      (0A00Bh),HL     ; Store frame number
        LD      A,000h          ; Get frame number
        LD      (0A00Dh),A      ; Store frame number
        CALL    L012A           ; Send SEARCH to LDPlayer
        JP      L02A9           ; Jump Wait for RESET -- FAIL
        
;----------------------------------------------------
;        Display Screen: "EEPROM U5 Failed"
;----------------------------------------------------        
L03A2:  LD      HL,000BCh       ; Get frame number
        LD      (0A00Bh),HL     ; Store frame number
        LD      A,000h          ; Get frame number
        LD      (0A00Dh),A      ; Store frame number
        CALL    L012A           ; Send SEARCH to LDPlayer
        JP      L02A9           ; Jump Wait for RESET -- FAIL
        
        
        
;----------------------------------------------------
;                68705 TEST for Interrupt
;----------------------------------------------------
;   Display Screen: "ROM Passed, begin 68705 Test"
;----------------------------------------------------        
L03B3:  LD      HL,0009Eh       ; Get frame number
        LD      (0A00Bh),HL     ; Store frame number
        LD      A,000h          ; Get frame number
        LD      (0A00Dh),A      ; Store frame number
        CALL    L012A           ; Send SEARCH to LDPlayer
        CALL    L04D7           ; Delay for x seconds
        LD      HL,0A00Ah       ; HL = StatusB Register
        RES     6,(HL)          ; Clear Interrupt Occured bit
        SET     5,(HL)          ; Disable Interrupt Maintainance
        EI                      ; Enable Interrupt
        CALL    L04D7           ; Delay for 32.7ms
        DI                      ; Disable Interrupt
        LD      HL,0000Ah       ; <-- Should be LD HL, A00Ah
        BIT     6,(HL)          ; Has interrupt occured during delay?
        JP      Z,L03E4         ; Yes, so begin Sound Test <--Should be JP NZ,L03E4
;----------------------------------------------------
;        Display Screen: "68705 TEST FAILED"
;----------------------------------------------------        
        LD      HL,L00BF        ; Get frame number
        LD      (0A00Bh),HL     ; Store frame number
        CALL    L012A           ; Send SEARCH to LDPlayer
        JP      L02A9           ; Jump Wait for RESET -- FAIL
        
        
        
;----------------------------------------------------
;                 Beign Sound Test
;----------------------------------------------------
;        Sound Tone 1 - Channel A
;        Sound Tone 2 - Channel B
;        Sound Tone 3 - Channel C
;----------------------------------------------------
;    AY-3-8910 Sound Chip Internal Registers
;
;            00h   Channel A fine pitch            
;            01h   Channel A course pitch          
;            02h   Channel B fine pitch      
;            03h   Channel B course pitch    
;            04h   Channel C fine pitch      
;            05h   Channel C course pitch    
;            06h   Noise pitch               
;            07h   Mixer               
;            08h   Channel A volume    
;            09h   Channel B volume    
;            0Ah   Channel C volume    
;            0Bh   Envelope fine duration
;            0Ch   Envelope course duration
;            0Dh   Envelope shape          
;            0Eh   I/O port A              
;            0Fh   I/O port B
;----------------------------------------------------
;        Display Screen: "Sound Test"
;----------------------------------------------------        
L03E4:  LD      HL,000A2h       ; Get frame number
        LD      (0A00Bh),HL     ; Store frame number
        LD      A,000h          ; Get frame number
        LD      (0A00Dh),A      ; Store frame number
        CALL    L012A           ; Send SEARCH to LDPlayer
        JP      L03F5           ; Jump 1 line ahead
L03F5:  CALL    L048E           ; Clear Sound Chip registers
;----------------------------------------------------
;            Setup Tone 1 - Channel A
;----------------------------------------------------
        LD      A,007h          ; ADDRESS = Mixer
        LD      (0E010h),A      ; Latch Address to Sound Chip
        LD      A,03Eh          ; DATA    = 3Eh
        LD      (0E000h),A      ; Write Data to Sound Chip
        LD      A,008h          ; ADDRESS = Channel A Volume
        LD      (0E010h),A      ; Latch Address to Sound Chip
        LD      A,00Fh          ; DATA    = 0Fh
        LD      (0E000h),A      ; Write Data to Sound Chip
        LD      A,000h          ; ADDRESS = Channel A fine pitch
        LD      (0E010h),A      ; Latch Address to Sound Chip
        CALL    L0458           ; Sound Tone 1
;----------------------------------------------------
;               Setup Tone 2 - Channel B
;----------------------------------------------------                
        CALL    L048E           ; Clear Sound Chip registers        
        LD      A,007h          ; ADDRESS = Mixer
        LD      (0E010h),A      ; Latch Address to Sound Chip
        LD      A,03Dh          ; DATA    = 3Dh
        LD      (0E000h),A      ; Write Data to Sound Chip        
        LD      A,009h          ; ADDRESS = Channel B Volume
        LD      (0E010h),A      ; Latch Address to Sound Chip
        LD      A,00Fh          ; DATA    = 0Fh
        LD      (0E000h),A      ; Write Data to Sound Chip        
        LD      A,002h          ; ADDRESS = Channel B fine pitch
        LD      (0E010h),A      ; Latch Address to Sound Chip        
        CALL    L0458           ; Sound Tone 2
;----------------------------------------------------
;              Setup Tone 3 - Channel C
;----------------------------------------------------        
        CALL    L048E           ; Clear Sound Chip registers
        LD      A,007h          ; ADDRESS = Mixer
        LD      (0E010h),A      ; Latch Address to Sound Chip   
        LD      A,03Bh          ; DATA    = 3Bh
        LD      (0E000h),A      ; Write Data to Sound Chip
        LD      A,00Ah          ; ADDRESS = Channel C volume 
        LD      (0E010h),A      ; Latch Address to Sound Chip
        LD      A,00Fh          ; DATA    = 0Fh
        LD      (0E000h),A      ; Write Data to Sound Chip
        LD      A,004h          ; ADDRESS = Channel C fine pitch
        LD      (0E010h),A      ; Latch Address to Sound Chip
        CALL    L0458           ; Sound Tone 3

        CALL    L048E           ; Clear Sound Chip registers
        JP      L04A0           ; Finished, jump to Display Test



;----------------------------------------------------
;         Send various fine pitches with delays
;----------------------------------------------------
L0458:  LD      A,0FEh          ; DATA = FEh
        LD      (0E000h),A      ; Write Data to Sound Chip
        LD      A,0D6h          ; DATA = D6h
        LD      (0E000h),A      ; Write Data to Sound Chip
        CALL    L04E1           ; Delay
        LD      A,0BEh          ; DATA = BEh
        LD      (0E000h),A      ; Write Data to Sound Chip
        CALL    L04E1           ; Delay
        LD      A,0AAh          ; DATA = AAh
        LD      (0E000h),A      ; Write Data to Sound Chip
        CALL    L04E1           ; Delay
        LD      A,0A0h          ; DATA = A0h
        LD      (0E000h),A      ; Write Data to Sound Chip
        CALL    L04E1           ; Delay
        LD      A,08Fh          ; DATA = 8Fh
        LD      (0E000h),A      ; Write Data to Sound Chip
        CALL    L04E1           ; Delay
        LD      A,07Fh          ; DATA = 7Fh
        LD      (0E000h),A      ; Write Data to Sound Chip
        CALL    L04E1           ; Delay
        RET                     ;


   
;----------------------------------------------------
;           Clear Sound Chip Addresses 00h-0Fh
;----------------------------------------------------
L048E:  LD      A,000h          ; A = 00h, start address
        LD      C,000h          ; C = 00h
        LD      HL,0E000h       ; HL = E000
L0495:  LD      (0E010h),A      ; Latch Address A to Sound Chip
        INC     A               ; Increment Address
        CP      010h            ; Reach end address yet?
        RET     Z               ; Yes, so return
        LD      (HL),C          ; Write zero to Address A
        JP      L0495           ; Loop until all addresses cleared



;----------------------------------------------------
;                   Display Test
;----------------------------------------------------
L04A0:  LD      HL,000A4h       ; Get frame number
        LD      (0A00Bh),HL     ; Store frame number
        LD      A,000h          ; Get frame number     
        LD      (0A00Dh),A      ; Store frame number
        CALL    L012A           ; Send SEARCH to LDPlayer
        CALL    L04D7           ; Delay for x seconds
        LD      A,000h          ; Start first index at zero
L04B3:  LD      (0A027h),A      ; Store index
        LD      HL,L1038        ; Load start of digit table
        LD      A,(0A027h)      ; Load index
        ADD     A,L             ; Add index to table
        LD      L,A             ; Add index to table
        LD      A,(HL)          ; Get digit out of table
        LD      HL,0E030h       ; Start of scoreboad
        LD      B,010h          ; Loop B=0;B++;B<15
L04C4:  LD      (HL),A          ; Fill scoreboard (E030-E03F) with digit
        INC     HL              ; Increment scoreboard spot
        DJNZ    L04C4           ; Loop until all scoreboard spots filled
        CALL    L04D7           ; Delay for x seconds
        LD      A,(0A027h)      ; Get digit
        INC     A               ; Increment digit
        CP      00Ah            ; Have we gone 0 thru 9?
        JP      Z,L04EB         ; Yes, continue to Keyboard Test
        JP      L04B3           ; No, continue to next digit



;----------------------------------------------------
;                Delay1 (32.7ms)
;----------------------------------------------------
L04D7:  LD      DE,0FFFFh       ; 0FFFFh = -1
        LD      HL,0FFFFh       ; Load loop with delay value
L04DD:  ADD     HL,DE           ; Subtract 1 from loop
        JR      C,L04DD         ; Loop until delay expires  
        RET                     ; Return


   
;----------------------------------------------------
;                Delay2 (? seconds)
;----------------------------------------------------
L04E1:  LD      DE,0FFFFh       ; 0FFFFh = -1
        LD      HL,06000h       ; Load loop with delay value
L04E7:  ADD     HL,DE           ; Subtract 1 from loop
        JR      C,L04E7         ; Loop until delay expires  
        RET                     ; Return


   
;----------------------------------------------------
;                   Keyboard Test
;----------------------------------------------------
L04EB:  LD      HL,000A7h       ; Get frame number
        LD      (0A00Bh),HL     ; Store frame number
        LD      A,000h          ; Get frame number
        LD      (0A00Dh),A      ; Store frame number
        CALL    L012A           ; Send SEARCH to LDPlayer
;----------------------------------------------------
;              Blank out scoreboard 
;----------------------------------------------------
        LD      A,0FFh          ; $FF = Blank character
        LD      HL,0E030h       ; Load start of scoreboard
        LD      B,010h          ; B=0;B++;B<15
L0500:  LD      (HL),A          ; Store blank in scoreboard spot
        INC     HL              ; Increment to next spot
        DJNZ    L0500           ; Loop until all spots filled
;----------------------------------------------------
;              Setup Delay speed 
;----------------------------------------------------
        LD      HL,0FFFFh       ; Load a delay value
        LD      (0A025h),HL     ; Store value in Keyboard Delay
;----------------------------------------------------
;                   Joystick UP 
;----------------------------------------------------
L050A:  LD      A,(0C008h)      ; Read Joystick
        BIT     0,A             ; Test for UP pressed
        LD      HL,0E03Dh       ; Load correct scoreboard spot
        JP      Z,L058F         ; If pressed, jump ahead...
        LD      (HL),0FFh       ; ...else store blank in spot 
;----------------------------------------------------
;                 Joystick DOWN 
;----------------------------------------------------
L0517:  LD      A,(0C008h)      ; Read Joystick
        BIT     1,A             ; Test for DOWN pressed
        LD      HL,0E03Ch       ; Load correct scoreboard spot
        JP      Z,L0594         ; If pressed, jump ahead...
        LD      (HL),0FFh       ; ...else store blank in spot
;----------------------------------------------------
;                 Joystick LEFT
;----------------------------------------------------
L0524:  LD      A,(0C008h)      ; Read Joystick
        BIT     2,A             ; Test for LEFT pressed
        LD      HL,0E03Bh       ; Load correct scoreboard spot
        JP      Z,L0599         ; If pressed, jump ahead...
        LD      (HL),0FFh       ; ...else store blank in spot
;----------------------------------------------------
;                 Joystick RIGHT 
;----------------------------------------------------
L0531:  LD      A,(0C008h)      ; Read Joystick
        BIT     3,A             ; Test for RIGHT pressed
        LD      HL,0E03Ah       ; Load correct scoreboard spot
        JP      Z,L059E         ; If pressed, jump ahead...
        LD      (HL),0FFh       ; ...else store blank in spot
;----------------------------------------------------
;                 Joystick SWORD
;----------------------------------------------------
L053E:  LD      A,(0C008h)      ; Read Joystick
        BIT     4,A             ; Test for SWORD pressed
        LD      HL,0E039h       ; Load correct scoreboard spot
        JP      Z,L05A3         ; If pressed, jump ahead...
L0549:  LD      (HL),0FFh       ; ...else store blank in spot
;----------------------------------------------------
;                     Coin Slot 1
;---------------------------------------------------
L054B:  LD      A,(0C010h)      ; Load Inputs
        BIT     2,A             ; Test for COIN1
        LD      HL,0E032h       ; Load correct scoreboard spot
        JP      Z,L05A8         ; If pressed, jump ahead...
        LD      (HL),0FFh       ; ...else store blank in spot
;----------------------------------------------------
;                  1 Player Button
;----------------------------------------------------
L0558:  LD      A,(0C010h)      ; Load Inputs
        BIT     0,A             ; Test for 1PLAYER
        LD      HL,0E031h       ; Load correct scoreboard spot
        JP      Z,L05AD         ; If pressed, jump ahead...
        LD      (HL),0FFh       ; ...else store blank in spot
;----------------------------------------------------
;                  2 Player Button
;----------------------------------------------------
L0565:  LD      A,(0C010h)      ; Load Inputs
        BIT     1,A             ; Test for 2PLAYER
        LD      HL,0E030h       ; Load correct scoreboard spot
        JP      Z,L05B2         ; If pressed, jump ahead...
        LD      (HL),0FFh       ; ...else store blank in spot
;----------------------------------------------------
;                 Coin Slot 2 (PAUSE)
;----------------------------------------------------
L0572:  LD      A,(0C010h)      ; Load Inputs
        BIT     3,A             ; Test for COIN2
        LD      HL,0E033h       ; Load correct scoreboard spot
        JP      Z,L05B7         ; If pressed, jump ahead...
        LD      (HL),0FFh       ; ...else store blank in spot
;----------------------------------------------------
;                   Delay for x seconds
;----------------------------------------------------
L057F:  LD      HL,(0A025h)     ; Get timer
        LD      DE,0FFFFh       ; 0FFFFh = -1
        ADD     HL,DE           ; Subtract 1 from timer
        JP      NC,L05BC        ; If timer expired do Color Test
        LD      (0A025h),HL     ; Store new value back in timer
        JP      L050A           ; Loop back to Keyboard Test
;----------------------------------------------------
;                   Joystick UP 
;----------------------------------------------------
L058F:  LD      (HL),000h       ; Store "0" for press
        JP      L0517           ; Continue test
;----------------------------------------------------
;                 Joystick DOWN 
;----------------------------------------------------
L0594:  LD      (HL),000h       ; Store "0" for press
        JP      L0524           ; Continue test
;----------------------------------------------------
;                 Joystick LEFT
;----------------------------------------------------
L0599:  LD      (HL),000h       ; Store "0" for press
        JP      L0531           ; Continue test
;----------------------------------------------------
;                 Joystick RIGHT 
;----------------------------------------------------
L059E:  LD      (HL),000h       ; Store "0" for press
        JP      L053E           ; Continue test
;----------------------------------------------------
;                 Joystick SWORD
;----------------------------------------------------
L05A3:  LD      (HL),000h       ; Store "0" for press
        JP      L054B           ; Continue test
;----------------------------------------------------
;                  Coin Slot 1
;----------------------------------------------------
L05A8:  LD      (HL),000h       ; Store "0" for press
        JP      L0558           ; Continue test
;----------------------------------------------------
;                  2 Player Button
;----------------------------------------------------
L05AD:  LD      (HL),000h       ; Store "0" for press
        JP      L0565           ; Continue test
;----------------------------------------------------
;                  1 Player Button
;----------------------------------------------------
L05B2:  LD      (HL),000h       ; Store "0" for press
        JP      L057F           ; skip COIN2 test, continue
;----------------------------------------------------
;                 Coin Slot 2 (PAUSE)
;----------------------------------------------------
L05B7:  LD      (HL),000h       ; Store "0" for press
        JP      L0572           ; Loop until released



;----------------------------------------------------
;                   Color Test
;----------------------------------------------------
L05BC:  LD      HL,000AAh       ; Get frame number
        LD      (0A00Bh),HL     ; Store frame number
        LD      A,000h          ; Get frame number
        LD      (0A00Dh),A      ; Store frame number
        CALL    L012A           ; Send SEARCH to LDPlayer
        CALL    L04D7           ; Delay for x seconds
        LD      HL,0189Ah       ; Get frame number
        LD      (0A00Bh),HL     ; Store frame number
        LD      A,000h          ; Get frame number
        LD      (0A00Dh),A      ; Store frame number
        CALL    L012A           ; Send SEARCH to LDPlayer
L05DB:  CALL    L05E6           ; Read DIP Switch A
        AND     080h            ; Check A7 DIP
        JP      NZ,L05DB        ; Loop until A7 released
        JP      L0000           ; Exit and Reset



;----------------------------------------------------
;                 Fetch DIP Switch A
;                 ON = 0     OFF = 1
;----------------------------------------------------
L05E6:  LD      A,00Eh          ; Set Hardware select 0E
        LD      (0E010h),A      ; Write hardware select
        LD      A,(0C000h)      ; Get DIP Switch A data
        RET                     ; Return


   
;----------------------------------------------------
;                 Fetch DIP Switch B
;                 ON = 0     OFF = 1
;----------------------------------------------------
L05EF:  LD      A,00Fh          ; Set hardware select 0F
        LD      (0E010h),A      ; Write hardware select
        LD      A,(0C000h)      ; Get DIP Switch B data
        RET                     ; Return


   
;----------------------------------------------------
;jk data was removed
;----------------------------------------------------
        ADC     A,03Eh          ;
        NOP                     ;
        CP      (IX+00Ch)       ;
        JR      NZ,L05F9        ;
        CP      (IX+00Dh)       ;
        JR      NZ,L05F9        ;
        CP      (IX+00Eh)       ;
        JR      NZ,L05F9        ;
        CP      (IX+00Fh)       ;
        JR      NZ,L05F9        ;
        LD      HL,(0A000h)     ;
        LD      A,(HL)          ;
        RES     4,(IY+000h)     ;
        JP      L253D           ;
        PUSH    AF              ;
        PUSH    BC              ;
        PUSH    DE              ;
        PUSH    HL              ;
        EX      AF,AF'          ;
        PUSH    AF              ;
        
        
        LD      HL,0A00Ah       ;
        SET     6,(HL)          ;
        LD      A,(0A00Ah)      ;
        BIT     5,A             ;
        JP      NZ,L2711        ;
        LD      A,(0A020h)      ;
        SET     4,A             ;
        LD      (0A020h),A      ;
        LD      (0E008h),A      ;
        LD      HL,0A01Ah       ;
        LD      A,(0C010h)      ;
        BIT     2,A             ;
        JR      Z,L0646         ;
        BIT     3,A             ;
        JR      NZ,L068E        ;
L0646:  BIT     5,(HL)          ;
        JR      NZ,L0655        ;
        SET     5,(HL)          ;
        LD      L,019h          ;
        INC     (HL)            ;
        JR      NZ,L0653        ;
        LD      (HL),0FFh       ;
L0653:  LD      A,000h          ;
L0655:  LD      HL,0A008h       ;
        BIT     2,(HL)          ;
        JR      Z,L06A3         ;
        LD      BC,0A0E0h       ;
        CALL    L2826           ;
L0662:  BIT     7,(HL)          ;
        JR      Z,L0692         ;
        LD      A,00Ch          ;
        ADD     A,L             ;
        LD      L,A             ;
        LD      A,000h          ;
        CP      (HL)            ;
        JR      Z,L067C         ;
L066F:  DEC     (HL)            ;
        CALL    L2826           ;
        LD      BC,00010h       ;
        ADD     HL,BC           ;
        CALL    L2829           ;
        JR      L0662           ;
L067C:  INC     HL              ;
        LD      A,00Fh          ;
        AND     L               ;
        JR      Z,L0689         ;
        LD      A,000h          ;
        CP      (HL)            ;
        JR      NZ,L066F        ;
        JR      L067C           ;
L0689:  CALL    L2829           ;
        JR      L0662           ;
L068E:  RES     5,(HL)          ;
        JR      L0655           ;
L0692:  PUSH    IY              ;
        POP     HL              ;
        LD      A,00Eh          ;
        ADD     A,L             ;
        LD      L,A             ;
        CALL    L280A           ;
        JR      NC,L06A3        ;
        LD      (HL),000h       ;
        INC     HL              ;
        LD      (HL),000h       ;
L06A3:  LD      HL,0A01Fh       ;
        LD      A,000h          ;
        CP      (HL)            ;
        JR      Z,L06AC         ;
        DEC     (HL)            ;
L06AC:  LD      HL,0A010h       ;
        BIT     4,(HL)          ;
        JR      Z,L06BF         ;
        LD      A,000h          ;
        LD      (0E036h),A      ;
        LD      A,002h          ;
        LD      (0E037h),A      ;
        JR      L06EA           ;
L06BF:  LD      HL,0A010h       ;
        LD      A,003h          ;
        AND     (HL)            ;
        INC     A               ;
        LD      L,019h          ;
        CP      (HL)            ;
        JR      NC,L06E7        ;
        LD      L,009h          ;
        INC     (HL)            ;
        INC     A               ;
        LD      B,A             ;
        LD      L,019h          ;
        LD      A,(HL)          ;
        SUB     B               ;
        LD      (HL),A          ;
        LD      A,(0A020h)      ;
        RES     4,A             ;
        LD      (0A020h),A      ;
        LD      (0E008h),A      ;
        LD      A,000h          ;
        CALL    L27BE           ;
        JR      L06AC           ;
L06E7:  CALL    L289A           ;
L06EA:  LD      A,00Eh          ;
        LD      (0E010h),A      ;
        LD      A,(0C000h)      ;
        BIT     7,A             ;
        JR      Z,L06F9         ;
        JP      L023C           ;
L06F9:  LD      HL,0A05Eh       ;
        CALL    L280A           ;
        JR      NC,L0706        ;
        LD      (HL),000h       ;
        INC     HL              ;
        LD      (HL),000h       ;
L0706:  LD      HL,0A0DEh       ;
        CALL    L280A           ;
        JR      NC,L0711        ;
        JP      L2C2F           ;
L0711:  CALL    L271D           ;
L0714:  POP     AF              ;
        EX      AF,AF'          ;
        POP     HL              ;
        POP     DE              ;
        POP     BC              ;
        POP     AF              ;
        EI                      ;
        RETI                    ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      HL,0A01Ch       ;
        BIT     0,(HL)          ;
        RET     Z               ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      L,01Fh          ;
L0725:  LD      A,000h          ;
        CP      (HL)            ;
        RET     NZ              ;


   
;----------------------------------------------------
;           Service Sound Chip     (remnant code)
;----------------------------------------------------
        LD      L,01Dh          ;
        CALL    L27D9           ;
        LD      DE,0A01Dh       ;
        LD      B,(HL)          ;
        INC     HL              ;
        LD      A,003h          ;
        AND     B               ;
        LD      C,A             ;
        SLA     C               ;
        LD      A,0FFh          ;
        CALL    L27AC           ;
        BIT     5,B             ;
        JR      Z,L0749         ;
        LD      A,005h          ;
        LD      C,001h          ;
        CALL    L27AC           ;
L0749:  LD      A,00Ch          ;
        AND     B               ;
        LD      C,A             ;
        SRL     C               ;
        SRL     C               ;
        LD      A,007h          ;
        CALL    L27AC           ;
        BIT     4,B             ;
        JR      Z,L0766         ;
        LD      A,(HL)          ;
        INC     HL              ;
        EX      DE,HL           ;
        LD      L,01Bh          ;
        LD      (HL),A          ;
        LD      L,01Fh          ;
        LD      (HL),A          ;
        EX      DE,HL           ;
        JR      L076E           ;
L0766:  EX      DE,HL           ;
        LD      L,01Bh          ;
        LD      A,(HL)          ;
        LD      L,01Fh          ;
        LD      (HL),A          ;
        EX      DE,HL           ;
L076E:  BIT     6,B             ;
        JR      Z,L0779         ;
        LD      A,00Ah          ;
        LD      C,002h          ;
        CALL    L27AC           ;
L0779:  BIT     7,(HL)          ;
        JR      Z,L078A         ;
        LD      A,007h          ;
        LD      (0E010h),A      ;
        LD      A,(HL)          ;
        CPL                     ;
        AND     03Fh            ;
        LD      (0E000h),A      ;
        INC     HL              ;
L078A:  BIT     7,B             ;
        JR      Z,L0797         ;
        LD      A,00Dh          ;
        LD      (0E010h),A      ;
L0793:  LD      A,(HL)          ;
        LD      (0E000h),A      ;
L0797:  BIT     5,(HL)          ;
        JR      Z,L07A6         ;
        INC     HL              ;
        CALL    L2829           ;
        LD      HL,0A01Dh       ;
        LD      (HL),C          ;
        INC     HL              ;
        LD      (HL),B          ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
L07A6:  LD      HL,0A01Ch       ;
        RES     0,(HL)          ;
        RET                     ;


   
;----------------------------------------------------
;                   Make Sound  (remnant from L27AC)      
;----------------------------------------------------
;         A = # of ?????
;         C = # of ?????
;         HL = Pointer to Sound Data (Sound0,Sound1,Sound2,Sound3)
;----------------------------------------------------
L07AC:  DEC     C               ;
        JP      M,L27BD         ;
        INC     A               ;
        LD      (0E010h),A      ;
        EX      AF,AF'          ;
        LD      A,(HL)          ;
        INC     HL              ;
        LD      (0E000h),A      ;
        EX      AF,AF'          ;
        JR      L07AC           ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      HL,L38CF        ;
        LD      BC,L0000        ;
        LD      C,A             ;
        SLA     C               ;
        RL      B               ;
        ADD     HL,BC           ;
        LD      A,(HL)          ;
        LD      (0A01Dh),A      ;
        INC     HL              ;
        LD      A,(HL)          ;
        LD      (0A01Eh),A      ;
        LD      HL,0A01Ch       ;
        SET     0,(HL)          ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      E,(HL)          ;
        INC     HL              ;
        LD      D,(HL)          ;
        CALL    L2823           ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        PUSH    IY              ;
        POP     IX              ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        PUSH    IX              ;
        POP     IY              ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        EX      AF,AF'          ;
        PUSH    BC              ;
        LD      B,000h          ;
        PUSH    IX              ;
        ADD     IX,BC           ;
        LD      A,(HL)          ;
        LD      (IX+000h),A     ;
        POP     IX              ;
        POP     BC              ;
        EX      AF,AF'          ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        EX      AF,AF'          ;
        LD      B,000h          ;
        PUSH    IY              ;
        ADD     IY,BC           ;
        LD      A,(HL)          ;
        LD      (IY+000h),A     ;
        POP     IY              ;
        EX      AF,AF'          ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      C,(HL)          ;
        INC     HL              ;
        LD      B,(HL)          ;
        CALL    L282C           ;
        CALL    L2826           ;
        LD      BC,00001h       ;
        AND     A               ;
        SBC     HL,BC           ;
        CALL    L2829           ;
        CALL    L2823           ;
        LD      (HL),B          ;
        DEC     HL              ;
        LD      (HL),C          ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        PUSH    DE              ;
        POP     HL              ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        PUSH    BC              ;
        POP     HL              ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        PUSH    HL              ;
        POP     BC              ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        PUSH    HL              ;
        POP     DE              ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        EXX                     ;
        LD      HL,0A013h       ;
        PUSH    DE              ;
        CALL    L280A           ;
        POP     DE              ;
        JR      NC,L0842        ;
        LD      HL,L0000        ;
        LD      (0A013h),HL     ;
        JR      L0855           ;
L0842:  CALL    L2823           ;
        INC     L               ;
        INC     L               ;
        INC     (HL)            ;
        JR      NZ,L0850        ;
        INC     L               ;
        INC     (HL)            ;
        JR      NZ,L0850        ;
        INC     L               ;
        INC     (HL)            ;
L0850:  CALL    L292C           ;
        LD      A,003h          ;
L0855:  EXX                     ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      A,(0A013h)      ;
        CALL    L2823           ;
        INC     L               ;
        INC     L               ;
        ADD     A,(HL)          ;
        LD      (HL),A          ;
        LD      A,(0A014h)      ;
        INC     L               ;
        ADC     A,(HL)          ;
        LD      (HL),A          ;
        LD      A,000h          ;
        INC     L               ;
        ADC     A,(HL)          ;
        LD      (HL),A          ;
        LD      A,(0A013h)      ;
        CP      000h            ;
        RET     Z               ;
;----------------------------------------------------
;                       
;----------------------------------------------------
        CALL    L292C           ;
        LD      HL,L0000        ;
        LD      (0A013h),HL     ;
        LD      A,003h          ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      HL,0A010h       ;
        BIT     3,(HL)          ;
        JR      NZ,L088A        ;
        LD      L,011h          ;
        BIT     3,(HL)          ;
        RET     Z               ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
L088A:  CALL    L27BE           ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      (0A00Bh),BC     ;
        XOR     A               ;
L0893:  LD      (0A00Dh),A      ;
        CALL    L2910           ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      A,(0A009h)      ;
        LD      C,A             ;
        XOR     A               ;
        LD      B,009h          ;
L08A1:  ADC     A,A             ;
        DAA                     ;
        SLA     C               ;
        DJNZ    L08A1           ;
        LD      (0E037h),A      ;
        CALL    L28B1           ;
        LD      (0E036h),A      ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        SRL     A               ;
        SRL     A               ;
        SRL     A               ;
        SRL     A               ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      B,00Bh          ;
        LD      HL,0A040h       ;
L08BF:  RES     7,(HL)          ;
        INC     HL              ;
        DJNZ    L08BF           ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      HL,L0000        ;
        LD      L,A             ;
        ADD     HL,HL           ;
        LD      (0A05Eh),HL     ;
        JR      L08D2           ;
        LD      (0A05Eh),A      ;
L08D2:  LD      A,(0A05Fh)      ;
        CP      000h            ;
        JR      NZ,L08D2        ;
L08D9:  LD      A,(0A05Eh)      ;
        CP      000h            ;
        JR      NZ,L08D9        ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      HL,0A012h       ;
        LD      A,(HL)          ;
        BIT     7,A             ;
        JR      Z,L08F6         ;
        LD      L,00Eh          ;
        LD      (HL),A          ;
        LD      L,00Fh          ;
        LD      (HL),000h       ;
        LD      HL,0A008h       ;
        RES     0,(HL)          ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
L08F6:  LD      L,00Fh          ;
        LD      (HL),A          ;
        LD      L,00Eh          ;
        LD      A,(IY+002h)     ;
        LD      (HL),A          ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      HL,0A008h       ;
        SET     4,(HL)          ;
        RES     2,(HL)          ;
        CALL    L012A           ;
        LD      HL,0A008h       ;
        RES     4,(HL)          ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        EXX                     ;
        LD      HL,0A008h       ;
        SET     3,(HL)          ;
        RES     2,(HL)          ;
        CALL    L012A           ;
        LD      HL,0A008h       ;
        RES     3,(HL)          ;
        CALL    L2925           ;
        EXX                     ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      HL,008AAh       ;
        LD      (0A0DEh),HL     ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        CALL    L2823           ;
        LD      A,030h          ;
        CP      L               ;
        INC     HL              ;
        JR      NZ,L093F        ;
        LD      A,(HL)          ;
        LD      (0E03Eh),A      ;
        LD      BC,0E03Dh       ;
        PUSH    BC              ;
        JR      L0947           ;
L093F:  LD      A,(HL)          ;
        LD      (0E03Fh),A      ;
        LD      BC,0E035h       ;
        PUSH    BC              ;
L0947:  INC     HL              ;
        LD      A,(HL)          ;
        LD      (0A00Bh),A      ;
        INC     HL              ;
        LD      A,(HL)          ;
        LD      (0A00Ch),A      ;
        INC     HL              ;
        LD      A,(HL)          ;
        LD      (0A00Dh),A      ;
        CALL    L0100           ;
        EXX                     ;
        LD      B,003h          ;
        POP     DE              ;
        LD      HL,0A02Ch       ;
L0960:  LD      A,(HL)          ;
        LD      (DE),A          ;
        CALL    L28B1           ;
        DEC     DE              ;
        LD      (DE),A          ;
        DEC     DE              ;
        INC     HL              ;
        DJNZ    L0960           ;
        EXX                     ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      B,002h          ;
        OR      B               ;
        LD      (0E038h),A      ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        NOP                     ;
        LD      HL,0A040h       ;
        LD      A,(0C008h)      ;
        XOR     0FFh            ;
        BIT     4,A             ;
        JR      Z,L09A7         ;
        BIT     5,(HL)          ;
        JR      Z,L09B3         ;
        BIT     6,(HL)          ;
        JR      NZ,L098D        ;
        SET     6,(HL)          ;
        SET     7,(HL)          ;
L098D:  AND     00Fh            ;
        ADD     A,040h          ;
        INC     HL              ;
        LD      B,00Bh          ;
L0994:  CP      L               ;
        JR      NZ,L09AD        ;
        BIT     5,(HL)          ;
        JR      Z,L09B7         ;
        BIT     6,(HL)          ;
        JR      NZ,L09A3        ;
        SET     6,(HL)          ;
        SET     7,(HL)          ;
L09A3:  INC     HL              ;
        DJNZ    L0994           ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
L09A7:  RES     6,(HL)          ;
        RES     5,(HL)          ;
        JR      L098D           ;
L09AD:  RES     6,(HL)          ;
        RES     5,(HL)          ;
        JR      L09A3           ;
L09B3:  SET     5,(HL)          ;
        JR      L098D           ;
L09B7:  SET     5,(HL)          ;
        JR      L09A3           ;
        LD      A,(0A010h)      ;
        BIT     3,A             ;
        RET     NZ              ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      A,(0A012h)      ;
        BIT     7,A             ;
        RET     Z               ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      HL,00005h       ;
        ADD     HL,DE           ;
        BIT     5,(HL)          ;
        RET     NZ              ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        AND     07Fh            ;
        LD      (0A054h),A      ;
        LD      HL,00006h       ;
        ADD     HL,DE           ;
        LD      (HL),A          ;
        DEC     HL              ;
        BIT     7,(HL)          ;
        JR      Z,L09E2         ;
        BIT     6,(HL)          ;
        JR      NZ,L09E2        ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
L09E2:  EXX                     ;
        LD      HL,0384Fh       ;
        LD      A,(0A054h)      ;
        SLA     A               ;
        SLA     A               ;
        ADD     A,L             ;
        LD      L,A             ;
        XOR     A               ;
        ADC     A,H             ;
        LD      H,A             ;
        PUSH    IX              ;
        LD      IX,0A050h       ;
        LD      BC,00400h       ;
L09FB:  CALL    L27EA           ;
        INC     HL              ;
        INC     C               ;
        DJNZ    L09FB           ;
        POP     IX              ;
        LD      A,(0A052h)      ;
        AND     007h            ;
        CP      000h            ;
        JR      NZ,L0A3A        ;
        LD      HL,(0A050h)     ;
        LD      A,(HL)          ;
        LD      HL,0A010h       ;
        BIT     2,(HL)          ;
        JR      NZ,L0A22        ;
        EXX                     ;
        LD      HL,00005h       ;
        ADD     HL,DE           ;
        BIT     4,(HL)          ;
        EXX                     ;
        JR      Z,L0A24         ;
L0A22:  ADD     A,028h          ;
L0A24:  LD      (0A012h),A      ;
        CALL    L28E1           ;
        EXX                     ;
        LD      HL,00005h       ;
        ADD     HL,DE           ;
        BIT     6,(HL)          ;
        RES     6,(HL)          ;
        RET     Z               ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      A,001h          ;
        LD      (0A00Fh),A      ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
L0A3A:  EXX                     ;
        LD      A,030h          ;
        CP      E               ;
        EXX                     ;
        JR      NZ,L0A46        ;
        LD      HL,0A060h       ;
        JR      L0A49           ;
L0A46:  LD      HL,0A090h       ;
L0A49:  LD      A,(0A054h)      ;
        ADD     A,L             ;
        LD      L,A             ;
        LD      (0A055h),HL     ;
        LD      A,(0A053h)      ;
        CP      (HL)            ;
        JR      NZ,L0A59        ;
        LD      (HL),000h       ;
L0A59:  LD      A,(0A052h)      ;
        AND     007h            ;
        LD      B,A             ;
        LD      (0A057h),A      ;
        LD      A,(0A052h)      ;
        BIT     3,A             ;
        JR      NZ,L0A77        ;
        LD      BC,(0A050h)     ;
        LD      HL,(0A055h)     ;
        CALL    L2AAC           ;
        LD      A,(BC)          ;
        JP      L2A11           ;
L0A77:  INC     B               ;
        LD      A,001h          ;
L0A7A:  DEC     B               ;
        JR      Z,L0A81         ;
        SLA     A               ;
        JR      L0A7A           ;
L0A81:  LD      HL,(0A055h)     ;
        LD      (0A058h),A      ;
        AND     (HL)            ;
        JR      Z,L0A95         ;
        LD      HL,0A057h       ;
        DEC     (HL)            ;
        LD      A,(0A058h)      ;
        SRL     A               ;
        JR      L0A81           ;
L0A95:  LD      A,(0A058h)      ;
        LD      HL,(0A055h)     ;
        OR      (HL)            ;
        LD      (HL),A          ;
        LD      HL,(0A050h)     ;
        LD      A,(0A057h)      ;
        ADD     A,L             ;
        LD      L,A             ;
        XOR     A               ;
        ADC     A,H             ;
        LD      H,A             ;
        LD      A,(HL)          ;
        JP      L2A11           ;
        LD      A,(HL)          ;
        AND     007h            ;
        CP      000h            ;
        JR      Z,L0AD3         ;
        CP      001h            ;
        JR      Z,L0AE1         ;
        CP      002h            ;
        JR      Z,L0AEB         ;
        CP      004h            ;
        JR      Z,L0AF5         ;
        CP      003h            ;
        JR      Z,L0ACE         ;
        CP      005h            ;
        JR      Z,L0ACA         ;
L0AC7:  SET     0,(HL)          ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
L0ACA:  SET     1,(HL)          ;
        INC     BC              ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
L0ACE:  SET     2,(HL)          ;
        INC     BC              ;
        INC     BC              ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
L0AD3:  LD      A,R             ;
        AND     007h            ;
        BIT     0,A             ;
        JR      Z,L0AC7         ;
        CP      007h            ;
        JR      Z,L0ACE         ;
        JR      L0ACA           ;
L0AE1:  LD      A,R             ;
        AND     003h            ;
        CP      003h            ;
        JR      Z,L0ACE         ;
        JR      L0ACA           ;
L0AEB:  LD      A,R             ;
        AND     003h            ;
        CP      003h            ;
        JR      Z,L0ACE         ;
        JR      L0AC7           ;
L0AF5:  LD      A,R             ;
        BIT     0,A             ;
        JR      Z,L0AC7         ;
        JR      L0ACA           ;
        LD      HL,0A010h       ;
        BIT     6,(HL)          ;
        RET     Z               ;
;----------------------------------------------------
;    Setup the Continue Game Timer to 17sec (remnant)
;----------------------------------------------------
        CALL    L2857           ;
        LD      A,0FFh          ;
        LD      (0A05Eh),A      ;
        LD      A,001h          ;
        LD      (0A05Fh),A      ;
        CALL    L2B43           ;
L0B13:  LD      HL,0A009h       ;
        XOR     A               ;
        CP      (HL)            ;
        JR      Z,L0B1C         ;
        DEC     (HL)            ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
L0B1C:  LD      BC,(0A05Eh)     ;
        LD      HL,L0000        ;
        AND     A               ;
        SBC     HL,BC           ;
        JR      NZ,L0B32        ;
        CALL    L2823           ;
        INC     HL              ;
        LD      (HL),000h       ;
        POP     AF              ;
        JP      L2356           ;
L0B32:  LD      HL,00040h       ;
        AND     A               ;
        SBC     HL,BC           ;
        JR      C,L0B13         ;
        LD      BC,(03812h)     ;
        CALL    L288E           ;
        JR      L0B13           ;
        LD      A,000h          ;
        LD      HL,03837h       ;
        JR      L0B4D           ;
        LD      HL,0381Fh       ;
L0B4D:  ADD     A,L             ;
        LD      L,A             ;
        LD      A,000h          ;
        ADC     A,H             ;
        LD      H,A             ;
        LD      A,(IY+002h)     ;
        CP      094h            ;
        JR      Z,L0B70         ;
        CP      0BCh            ;
        JR      Z,L0B70         ;
        INC     HL              ;
        INC     HL              ;
        CP      09Eh            ;
        JR      Z,L0B70         ;
        CP      0C6h            ;
        JR      Z,L0B70         ;
        INC     HL              ;
        INC     HL              ;
        CP      0A4h            ;
        RET     NZ              ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        CP      0CCh            ;
        RET     NZ              ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
L0B70:  LD      C,(HL)          ;
        INC     HL              ;
        LD      B,(HL)          ;
        CALL    L288E           ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      A,(0A012h)      ;
        BIT     7,A             ;
        RET     Z               ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        BIT     1,(IY+005h)     ;
        RET     NZ              ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      HL,00006h       ;
        ADD     HL,DE           ;
        LD      A,(HL)          ;
        INC     A               ;
        OR      080h            ;
        LD      (0A012h),A      ;
        CALL    L28E1           ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      HL,00090h       ;
        ADD     HL,DE           ;
        LD      B,008h          ;
        LD      A,000h          ;
L0B99:  CP      (HL)            ;
        JR      NZ,L0BA1        ;
        LD      A,(IY+002h)     ;
        LD      (HL),A          ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
L0BA1:  INC     HL              ;
        DJNZ    L0B99           ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      A,(0A012h)      ;
        BIT     7,A             ;
        RET     Z               ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      HL,00005h       ;
        ADD     HL,DE           ;
        BIT     5,(HL)          ;
        JR      NZ,L0BCD        ;
        LD      A,(0A012h)      ;
        CP      0A4h            ;
        JR      Z,L0BBE         ;
        CP      0CCh            ;
        JR      NZ,L0BF4        ;
L0BBE:  SET     5,(HL)          ;
        LD      B,A             ;
        LD      HL,00006h       ;
        ADD     HL,DE           ;
        LD      C,(HL)          ;
        LD      HL,000A0h       ;
        ADD     HL,DE           ;
        LD      (HL),B          ;
        INC     HL              ;
        LD      (HL),C          ;
L0BCD:  LD      HL,00090h       ;
        ADD     HL,DE           ;
        LD      B,008h          ;
        XOR     A               ;
L0BD4:  CP      (HL)            ;
        JR      NZ,L0C0A        ;
        INC     HL              ;
        DJNZ    L0BD4           ;
        LD      HL,000A0h       ;
        ADD     HL,DE           ;
        LD      A,(HL)          ;
        LD      (0A012h),A      ;
        INC     HL              ;
        LD      A,(HL)          ;
        LD      HL,00030h       ;
        ADD     HL,DE           ;
        LD      (HL),A          ;
        LD      HL,00005h       ;
        ADD     HL,DE           ;
        RES     5,(HL)          ;
        RES     6,(HL)          ;
L0BF1:  CALL    L28E1           ;
L0BF4:  LD      HL,00005h       ;
        ADD     HL,DE           ;
        BIT     7,(HL)          ;
        RES     7,(HL)          ;
        RET     Z               ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      A,001h          ;
        LD      (0A00Fh),A      ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        BIT     7,(HL)          ;
        RES     7,(HL)          ;
        RET     NZ              ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        JR      L0BCD           ;
L0C0A:  LD      A,(HL)          ;
        LD      (0A012h),A      ;
        LD      (HL),000h       ;
        JR      L0BF1           ;
        LD      A,(0A012h)      ;
        BIT     7,A             ;
        RET     Z               ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      HL,00005h       ;
        ADD     HL,DE           ;
        BIT     4,(HL)          ;
        RET     NZ              ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      HL,00007h       ;
        ADD     HL,DE           ;
        INC     (HL)            ;
        LD      A,005h          ;
        CP      (HL)            ;
        RET     NZ              ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      HL,00005h       ;
        ADD     HL,DE           ;
        SET     4,(HL)          ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      SP,0A3FFh       ;
        LD      HL,0A030h       ;
        LD      DE,0A031h       ;
        LD      BC,003CFh       ;
        LD      (HL),000h       ;
        LDIR                    ;
        CALL    L2925           ;
        EI                      ;
        JP      L2093           ;
        LD      D,014h          ;
        ADD     A,C             ;
        LD      BC,00C09h       ;
        LD      E,007h          ;
        ADD     HL,BC           ;
        LD      HL,(L0000)      ;
        CCF                     ;
        JR      Z,L0C5A         ;
        ADD     A,E             ;
        ADD     A,A             ;
        NOP                     ;
        NOP                     ;
        LD      H,C             ;



;  jk removed data

L1FF0:  RLA                     ;
        JR      NZ,L1FF3        ;
L1FF3:  LD      E,(HL)          ;
        NOP                     ;
        NOP                     ;
        SCF                     ;
        JR      L2009           ;
        DEC     BC              ;
        INC     D               ;
L1FFB:  NOP                     ;
        NOP                     ;
        LD      A,A             ;
        RLA                     ;
        ADD     A,D             ;


;----------------------------------------------------
;                       
;----------------------------------------------------
        JP      L261A           ;



;----------------------------------------------------
;                        Main
;----------------------------------------------------
;                  Clear Stack area
;----------------------------------------------------
L2003:  LD      SP,0A3FFh       ; A000-A3FFh becomes stack
        LD      HL,0A000h       ; Load start of stack area
L2009:  LD      DE,0A001h       ; Set up loop
        LD      BC,003FFh       ; BC = size of stack
        LD      (HL),000h       ; Fill with $00
        LDIR                    ; Loop until stack cleared
;----------------------------------------------------
;             Reset the Watchdog Timer
;----------------------------------------------------
        CALL    L2925           ; Reset Watchdog
;----------------------------------------------------
;           Disable Coin Counter on startup
;----------------------------------------------------
        LD      A,(0A020h)      ; Get Hardware Register
        SET     4,A             ; Hold Play Counter
        LD      (0A020h),A      ; Store Hardware Register
        LD      (0E008h),A      ; Write Hardware Register
;----------------------------------------------------
;             Read DIP Switch Game Settings
;----------------------------------------------------
        CALL    L05EF           ; Fetch DIP Switch B
        LD      (0A011h),A      ; Store DIP B in RAM
        CALL    L05E6           ; Fetch DIP Switch A
        LD      (0A010h),A      ; Store DIP A in RAM
;----------------------------------------------------
;   Determine Engineering Use Scene using DIP A
;----------------------------------------------------
;  If Engineering Use is selected then DIP switch A
;  is used to select the scene to be play-tested.
;  The scene is replayed continuously
;  The coded scene number is determined using binary 
;  coded decimal (BCD).  Player1 plays Scene, Player2 
;  plays (Scene + 1).
;
;   For example:   Scene 10:  DIP = $10
;
;          A7  A6  A5  A4  A3  A2  A1  A0
;          ON  ON  ON  OFF ON  ON  ON  ON
;----------------------------------------------------
        BIT     3,A             ; Test DIP A3, Eningeering Use
        JR      Z,L2048         ; If ON then use default start      
        LD      A,(0A011h)      ; Load DIP Switch B
        LD      B,A             ; B = A
        AND     0F0h            ; A = A & F0h
        SRL     A               ; A -> 1
        LD      C,A             ; C = A
        SRL     A               ; A -> 1
        SRL     A               ; A -> 1
        ADD     A,C             ; A = A + C
        LD      C,A             ; C = A
        LD      A,B             ; A = B
        AND     00Fh            ; A = A & 0Fh
        ADD     A,C             ; A = A + C
        OR      080h            ; A = A | 80h
        JR      L204B           ; Put Calculated Starting Scene into location     
L2048:  LD      A,(03815h)      ; Get default Starting Scene ($80 End of Corridor)
L204B:  LD      (0A018h),A      ; Store New Game Starting Scene
;----------------------------------------------------
;     Check setting for Number of Dirks per credit
;----------------------------------------------------
        LD      HL,0A010h       ; Get DIP Switch A
        BIT     5,(HL)          ; Test A5 (Number of Dirks)
        JR      NZ,L205C        ; If set then do 5 Dirks   
        LD      A,0C3h          ; Set 3 Dirks
        LD      (0A015h),A      ; Store Number of Dirks
        JR      L2061           ; Skip ahead       
L205C:  LD      A,0C5h          ; Set 5 Dirks
        LD      (0A015h),A      ; Store Number of Dirks
;----------------------------------------------------
;             Set up Interrupts
;----------------------------------------------------
L2061:  IM      1               ; Set Interrupt Mode 1
        EI                      ; Enable interrupts
;----------------------------------------------------
;                Blank out scoreboard
;----------------------------------------------------
        LD      HL,0E030h       ; Load start of scoreboard
L2067:  LD      B,010h          ; B=0;B++;B<15
L2069:  LD      (HL),00Fh       ; Store blank in scoreboard spot
        INC     HL              ; Increment to next spot
        DJNZ    L2069           ; Loop until all spots filled
;----------------------------------------------------
;                  Sound 1st BEEP
;----------------------------------------------------
        LD      A,001h          ; Sound = 1
        CALL    L27BE           ; Play Sound 1 ("Dink")
        LD      A,0F0h          ; Load Delay value (2 * F0 = 15.8sec)
        CALL    L28C5           ; Call Double Delay
;----------------------------------------------------
;                  Send PLAY Command
;----------------------------------------------------
        CALL    L01F4           ; Send PLAY Command
        CALL    L01F4           ; Send PLAY Command
;----------------------------------------------------
;                  Sound 2nd BEEP
;----------------------------------------------------
        LD      A,001h          ; Sound = 1
        CALL    L27BE           ; Play Sound 1 ("Dink")
        LD      A,0F0h          ; Load Delay value (2 * F0 = 15.8sec)
        CALL    L28C5           ; Call Double Delay 
        CALL    L022A           ; Disable the Display
        CALL    L0218           ; Enable Audio
;----------------------------------------------------
;                  Sound 3rd BEEP
;----------------------------------------------------
        LD      A,000h          ; Sound = 0
        CALL    L27BE           ; Play Sound 0 ("tah-dah")
;----------------------------------------------------
;            Set up Scene for Attract Mode 
;----------------------------------------------------
L2093:  LD      HL,0A00Eh       ; HL = A00E
        LD      A,(03814h)      ; Get pointer to Attract Mode
        LD      (HL),A          ; Store it in Index 1
        LD      L,00Fh          ; HL = A00F
        LD      (HL),000h       ; Store Index 2
        LD      DE,0A030h       ; DE = A030 Player Variables
;----------------------------------------------------
;          Check DIP setting for Attract Mode
;----------------------------------------------------
L20A1:  LD      A,(0A011h)      ; Get DIP Switch B
        BIT     1,A             ; Test B1, Sound during Attract
        JR      NZ,L20BF        ; If OFF then jump to Disable Audio
        LD      A,(0A011h)      ; Get DIP Switch B
        BIT     0,A             ; Test B0, Every 8th has sound
        JR      Z,L20BA         ; If ON then skip ahead       
        LD      HL,0A006h       ; Get Attract Mode count
        INC     (HL)            ; Increment Attract Mode count
        LD      A,(HL)          ; Store Attract Mode count
        AND     007h            ; Check count 
        CP      000h            ; Is it the 8th time?
        JR      NZ,L20BF        ; No, so jump to Disable Audio
L20BA:  CALL    L0218           ; Enable Audio 
        JR      L20C2           ; Skip Disable Audio
L20BF:  CALL    L0221           ; Disable Audio 
;----------------------------------------------------
;               Start View Scene
;----------------------------------------------------
L20C2:  CALL    L23C4           ; Load data, Start scene
        CALL    L24BD           ; Scene Mechanics and Gameplay
        CALL    L022A           ; Disable Display
;----------------------------------------------------
;             Read DIP Switch Game Settings
;----------------------------------------------------
        CALL    L05EF           ; Fetch DIP Switch B
        LD      (0A011h),A      ; Store DIP B in RAM
        CALL    L05E6           ; Fetch DIP Switch A
        LD      (0A010h),A      ; Store DIP A in RAM
;----------------------------------------------------
;          Check number of Credits and Coins
;----------------------------------------------------
        LD      HL,0A009h       ; Get number of credits
        XOR     A               ; Set A=0
        CP      (HL)            ; Any credits left?
        JR      NZ,L212D        ; Yes, show "Insert Coins" (Message01)
        LD      HL,0A019h       ; Get number of coins
        CP      (HL)            ; Any coins left?
        JR      NZ,L211E        ; Yes, show "Insert Coins"
;----------------------------------------------------
;    Setup Coin Instructions based on number of Dirks
;----------------------------------------------------
        LD      A,(0A010h)      ; Get DIP Switch A
        BIT     6,A             ; Test A6, Pay-As-You-Go
        JR      NZ,L20F9        ; If OFF, Pay-As-You-Go Enabled
        BIT     5,A             ; Test A5, Number of Dirks
        JR      Z,L20F4         ; If ON, then 3 Dirk Screen  
;----------------------------------------------------
;              A5 = OFF, A6 = ON
;----------------------------------------------------
        LD      HL,03819h       ; Setup 5-Dirks Instructions
        JR      L20FC           ; Jump ahead             
;----------------------------------------------------
;              A5 = ON, A6 = ON
;----------------------------------------------------
L20F4:  LD      HL,03816h       ; Setup 3-Dirks Instructions
        JR      L20FC           ; Jump ahead
;----------------------------------------------------
;              A5 = X, A6 = ON
;----------------------------------------------------
L20F9:  LD      HL,0381Ch       ; Setup Castle Instructions
;----------------------------------------------------
;  Setup Coin Instructions based on number of credits
;----------------------------------------------------
L20FC:  AND     003h            ; Test A0 and A1
;----------------------------------------------------
;              A0 = ON, A1 = ON   2 Coins/Credit
;----------------------------------------------------
        CP      000h            ; A0 = ON and A1 = ON?
        JR      Z,L2111         ; Yes, jump ahead
;----------------------------------------------------
;              A0 = OFF, A1 = ON   3 Coins/Credit
;----------------------------------------------------        
        INC     HL              ; Increment to next scene
        CP      001h            ; A0 = OFF and A1 = ON?
        JR      Z,L2111         ; Yes, jump ahead
;----------------------------------------------------
;              A0 = ON, A1 = OFF   4 Coins/Credit
;----------------------------------------------------        
        INC     HL              ; Increment to next scene
        CP      002h            ; A0 = ON and A1 = OFF?
        JR      Z,L2111         ; Yes, jump ahead
;----------------------------------------------------
;            A0 = OFF, A1 = OFF   <unknown>
;----------------------------------------------------        
        INC     HL              ; Increment to next scene
        CP      003h            ; A0 = OFF and A1 = OFF?
        JR      NZ,L20A1        ; No, go to Attract Loop
        
L2111:  LD      A,(0A012h)      ; Get scene index
        CP      000h            ; Has an initial index been assigned?
        JR      NZ,L20A1        ; Yes, so go to Attract Loop
        LD      A,(HL)          ; Get the Instruction index from table
        LD      (0A00Fh),A      ; Store frame index
        JR      L20A1           ; Jump to Attract Loop



;----------------------------------------------------
;  Show "Insert Coins" and wait for a complete credit
;----------------------------------------------------
L211E:  LD      BC,(03800h)     ; Show "Insert Coins"
        CALL    L288E           ; SEARCH to frame
L2125:  LD      HL,0A009h       ; Get number of credits
        LD      A,000h          ; Set A=0
        CP      (HL)            ; Any credits left?
        JR      Z,L2125         ; No credits so just loop
;----------------------------------------------------
;               Show "Insert Coins" 
;----------------------------------------------------        
L212D:  LD      BC,(03800h)     ; Show "Insert Coins"
        CALL    L288E           ; SEARCH to frame
        LD      HL,0A008h       ; HL = StatusA Register
        RES     5,(HL)          ;
        CALL    L0218           ; Enable Audio
;----------------------------------------------------
;             Check Player2 Button 
;----------------------------------------------------        
L213C:  LD      HL,0A009h       ; Get number of credits
        LD      A,001h          ; A = 1
        CP      (HL)            ; Is there more than 1 credit?
        JP      NC,L21BF        ; No, so go to Player1 button
        LD      HL,0C010h       ; Load Inputs
        BIT     1,(HL)          ; Player2 button pressed?
        JR      NZ,L21BF        ; No, go to Player1 button
;----------------------------------------------------
;            Player2  Game Setup
;----------------------------------------------------        
L214C:  LD      HL,0A038h       ; HL = Player2 Position in Game
        LD      A,(0A018h)      ; Load New Game Starting Scene
        INC     A               ; Increment start position by 1
        LD      (HL),A          ; Store start position+1 for Player2
;----------------------------------------------------
;          Reset Player2 Lives (A039)
;----------------------------------------------------        
        LD      L,039h          ; HL = A039 (Player2 Lives)
        LD      A,(0A015h)      ; Load number of Dirks/credit
        LD      (HL),A          ; Store in Player2 Lives
        LD      (0E03Fh),A      ; Update scoreboard Player2 lives
;----------------------------------------------------
;          Reset Player2 Score (A03A)
;----------------------------------------------------        
        LD      L,03Ah          ; HL = A03A (Player2 Score)
        LD      (HL),000h       ; Store zero in score
        LD      B,006h          ; B = 6, number of places
L2163:  LD      (HL),000h       ; Store zero in score
        INC     HL              ; Increment to next score place
        DJNZ    L2163           ; Loop until all places are reset
;----------------------------------------------------
;   Reset Player2 Scenes that we died on (A0C8-A0CF)
;----------------------------------------------------        
        LD      HL,0A0C8h       ; Point to start of Registers
        LD      B,008h          ; B = 8
L216D:  LD      (HL),000h       ; Store zero in Register
        INC     HL              ; Increment to next Register
        DJNZ    L216D           ; Loop until all Register reset
    
;  Following commented lines appear in rev D, but not here (DL1)
;----------------------------------------------------
;       Clear out Player2 Variables (A090-A0BF)
;----------------------------------------------------                   
;        LD      BC,002Fh        ; B = 2Fh         
;        LD      HL,0A090h       ; Load start of Variables
;        LD      DE,0A091h       ; Set up loop
;        LD      (HL),00h        ; Fill Variables with zero
;        LDIR                    ; Loop until finished    
        
;----------------------------------------------------
;         Check for Free Play DIP Setting
;----------------------------------------------------        
        LD      L,010h          ; Get DIP Switch A (A010)
        BIT     4,(HL)          ; Test A4, Free Play
        JR      NZ,L217B        ; Free Play set, so skip ahead
        LD      L,009h          ; Get number of credits (A009)
        DEC     (HL)            ; Decrement number of credits
;----------------------------------------------------
;            Player1 Game Setup
;----------------------------------------------------        
L217B:  LD      HL,0A030h       ; HL = Player1 Position in Game
        LD      A,(0A018h)      ; Load New Game Starting Position
        LD      (HL),A          ; Store start position for Player1
;----------------------------------------------------
;          Reset Player1 Lives (A031)
;----------------------------------------------------        
        LD      L,031h          ; HL = A031 (Player1 Lives)
        LD      A,(0A015h)      ; Load number of Dirks/credit
        LD      (HL),A          ; Store in Player1 Lives
        LD      (0E03Eh),A      ; Update scoreboard Player1 lives
;----------------------------------------------------
;          Reset Player1 Score (A032)
;----------------------------------------------------        
        LD      L,032h          ; HL = A032 (Player1 Score)
        LD      (HL),000h       ; Store zero in score
        LD      B,006h          ; B = 6, number of places
L2191:  LD      (HL),000h       ; Store zero in score
        INC     HL              ; Increment to next score place
        DJNZ    L2191           ; Loop until all places are reset
;----------------------------------------------------
;    Reset Player1 Scenes that we died on (A0C0-A0C7)
;----------------------------------------------------        
        LD      HL,0A0C0h       ; Point to start of Registers
        LD      B,008h          ; B = 8
L219B:  LD      (HL),000h       ; Store zero in Register
        INC     HL              ; Increment to next Register
        DJNZ    L219B           ; Loop until all Register reset

;  Following commented lines appear in rev D, but not here (DL1)
;----------------------------------------------------
;           Clear out Player1 PlayList (A060-A08F)
;----------------------------------------------------
;        LD      BC,002Fh        ; B = 2F
;        LD      HL,0A060h       ; Load start of Variables
;        LD      DE,0A061h       ; Set up loop
;        LD      (HL),00h        ; Fill Variables with zero
;        LDIR                    ; Loop until finished


;----------------------------------------------------
;         Check for Free Play DIP Setting
;----------------------------------------------------        
        LD      L,010h          ; Get DIP Switch A (A010)
        BIT     4,(HL)          ; Test A4, Free Play
        JR      NZ,L21A9        ; Free Play set, so skip ahead
        LD      L,009h          ; Get number of credits (A009)
        DEC     (HL)            ; Decrement number of credits
;----------------------------------------------------
;          Set first player to Player1
;----------------------------------------------------        
L21A9:  LD      L,008h          ; HL = StatusA Register
        LD      A,05Fh          ; A = 5F
        AND     (HL)            ; 01011111
        LD      (HL),A          ; Set Player1
;----------------------------------------------------
;          Blank out whole Scoreboard
;----------------------------------------------------        
        LD      HL,0E030h       ; Point to scoreboard
        LD      B,00Eh          ; Loop, B = 15
L21B4:  LD      (HL),00Fh       ; Store blank into spot
        INC     HL              ; Increment scoreboards spot
        DJNZ    L21B4           ; Loop until all spots filled
        
        CALL    L0218           ; Enable Audio
        JP      L21ED           ; Start Game
        
        
        
;----------------------------------------------------
;             Check Player1 Button 
;----------------------------------------------------        
L21BF:  LD      HL,0C010h       ; Get Inputs
        BIT     0,(HL)          ; 1Player button pressed?
        JR      NZ,L21C8        ; No, skip ahead      
        JR      L217B           ; Jump Player1 Setup
L21C8:  LD      HL,0A009h       ; Get number of credits
        LD      A,001h          ; A = 1
        CP      (HL)            ; More than 1 credit?
        JR      NC,L21EA        ; No, goto Check Player2 button 
        LD      L,008h          ; HL = StatusA Register
        BIT     5,(HL)          ;
        JP      NZ,L21EA        ;
L21D7:  LD      BC,(03802h)     ; Load message "Insert Coins"
        LD      (0A00Bh),BC     ; Store frame in register
        XOR     A               ; Set A = 0
        LD      (0A00Dh),A      ; Store frame in register
        LD      L,008h          ; HL = StatusA Register
        SET     5,(HL)          ; Set bit 5 of A008h
        CALL    L2910           ; Search to frame     
L21EA:  JP      L213C           ; Check Player2 button



;----------------------------------------------------
;            Start game loop, check if game over
;----------------------------------------------------
; This is the main game loop that checks when players
; die and swaps players, etc.
;----------------------------------------------------
L21ED:  LD      HL,0A008h       ; HL = StatusA Register 
        BIT     7,(HL)          ; Test which player is playing
        JR      NZ,L2209        ; If Player2 then jump ahead  
L21F4:  LD      L,031h          ; HL = A031, Get Player1 Lives
        BIT     7,(HL)          ; Player1 Game Over?
        JR      NZ,L220F        ; No, do Player1      
        LD      L,039h          ; HL = A039, Get Player2 Lives
        BIT     7,(HL)          ; Player2 Game Over?
        JP      Z,L238F         ; Yes, goto end
;----------------------------------------------------
;                Swap to other Player 
;----------------------------------------------------        
L2201:  LD      L,008h          ; HL = StatusA Register, Which Player
        LD      A,080h          ; Is it Player1 or Player2
        XOR     (HL)            ; Switch player number
        LD      (HL),A          ; Store back in Which Player status
        JR      L21ED           ; Jump to Start Game          
L2209:  LD      L,039h          ; HL = A039, Get Player2 Lives
        BIT     7,(HL)          ; Player2 Game Over?
        JR      Z,L21F4         ; Yes, go check Player1 Game Over status
;----------------------------------------------------
;                  Begin player game
;----------------------------------------------------        
L220F:  DEC     L               ; HL = A030 (Player1)
        EX      DE,HL           ; DE = HL           
        CALL    L292C           ; Update Scoreboard
        LD      HL,0A039h       ; Get Player2 Lives
        BIT     7,(HL)          ; Player2 Game Over?
        JR      Z,L2251         ; Yes, skip to end   
        LD      HL,0A031h       ; Get Player1 Lives
        BIT     6,(HL)          ; Do we swap players?
        JR      NZ,L2251        ; No, so skip ahead  
        BIT     7,(HL)          ; Player1 Game Over?
        JR      Z,L2251         ; Yes, skip to end   
;----------------------------------------------------
;            Display Next Player Screen
;----------------------------------------------------        
        LD      BC,(0380Ch)     ; Show "Time for other player"
        CALL    L288E           ; SEARCH to frame
;----------------------------------------------------
;         Put Lives remaining on Scoreboard
;----------------------------------------------------        
        LD      B,008h          ; B = 8
        CALL    L2823           ; HL = DE
        LD      A,030h          ; A = 030h
        CP      L               ; HL = A030? Player1 or 2?
        INC     HL              ; HL = A031 Player Lives
        LD      C,(HL)          ; C = Number of Lives
        JR      NZ,L223E        ; Player2 so skip ahead   
        LD      HL,0E03Eh       ; Store Lives in Player1
        JR      L2241           ; Jump ahead      
L223E:  LD      HL,0E03Fh       ; Store Lives in Player2
;----------------------------------------------------
;         Flash Lives to indicate who's turn
;----------------------------------------------------
L2241:  LD      A,007h          ; Delay = 07h (.2sec)
        CALL    L28CF           ; Call SingleDelay
        BIT     0,B             ; Test if B is odd
        JR      NZ,L224E        ; Turn on every other time 
        LD      (HL),0FFh       ; Put blank in lives digit
        JR      L224F           ; Continue loop     
L224E:  LD      (HL),C          ; Put number in lives digit
L224F:  DJNZ    L2241           ; Loop until complete    
;----------------------------------------------------
;          Reset Consecutive Levels Survived 
;----------------------------------------------------
L2251:  LD      HL,00007h       ; Load HL with 07
        ADD     HL,DE           ; HL = A037 (Player1) Consecutive Levels Survived
        LD      (HL),000h       ; Reset # of consecutive levels survived (A037)
;----------------------------------------------------
;    Check whether we start the scene with or without
;    the resurrection scene
;----------------------------------------------------        
        CALL    L2823           ; HL = A030 (Player1)
        INC     L               ; HL = A031 (Player1)
        BIT     6,(HL)          ; Do we need a resurrection scene?
        RES     6,(HL)          ; Clear the resurrection flag
        JR      NZ,L227A        ; No, so load scene without it
;----------------------------------------------------
;     Check to see if we died on the previous scene
;----------------------------------------------------        
        LD      HL,00005h       ; HL = 05
        ADD     HL,DE           ; HL = A035 (Player1), Difficulty
        BIT     6,(HL)          ; Did player just die previously?
        JR      NZ,L227A        ; No, so skip resurrection scene
;----------------------------------------------------
;     Set pointer to Scene Data with Ressurection
;  scenes until he completes them
;----------------------------------------------------        
        CALL    L2823           ; HL = DE, A030 (Player1)
        LD      A,(HL)          ; Reload level in game (Player1 A030)
        LD      (0A012h),A      ; Save level in index
        CALL    L28E1           ; Load Scene Data Index
        LD      A,001h          ; A = 01 (Start on resurrection scene)
        LD      (0A00Fh),A      ; Store 01 in A00F
        JR      L2284           ; Restart scene 
        
;----------------------------------------------------
;   Set pointer to Scene Data without Ressurection
;----------------------------------------------------        
L227A:  CALL    L2823           ; HL = DE, A030 (Player1)
        LD      A,(HL)          ; A030 = Position in Game (Player1)
        LD      (0A012h),A      ; Reload same scene 
        CALL    L28E1           ; Load Scene Data Index
        
        
        
;----------------------------------------------------
;                   Start Scene
;----------------------------------------------------        
L2284:  CALL    L29BB           ; Start level (load next level)
;----------------------------------------------------
;                 Inner Game Play Loop
;----------------------------------------------------
L2287:  CALL    L2BA5           ; Do Level Check before starting
        CALL    L23C4           ; Load data, Start scene
        CALL    L24BD           ; Scene Mechanics and Gameplay
;----------------------------------------------------
;          Exited Scene Mechanics and Gameplay
;----------------------------------------------------
;      If Engineering Mode then do replay check
;----------------------------------------------------        
        LD      A,(0A010h)      ;
        BIT     3,A             ;
        JR      Z,L22AB         ;
        LD      A,(0C010h)      ;
        BIT     0,A             ;
        JR      NZ,L22AB        ;
        LD      A,(IY+002h)     ;
        LD      (0A00Eh),A      ;
        LD      A,000h          ;
        LD      (0A00Fh),A      ;
        JR      L2287           ;
L22AB:  BIT     5,(IY+000h)     ;
        JP      NZ,L23A1        ;
        PUSH    IY              ;
        POP     HL              ;
        LD      BC,00005h       ;
        ADD     HL,BC           ;
        BIT     5,(HL)          ;
        CALL    NZ,L2AFD        ;
        BIT     4,(IY+000h)     ;
        JR      NZ,L22CC        ;
        CALL    L2B77           ;
        CALL    L2C12           ;
        JR      L2284           ;
L22CC:  LD      HL,00005h       ;
        ADD     HL,DE           ;
        SET     7,(HL)          ;
        LD      A,(0A010h)      ;
        BIT     3,A             ;
        JR      NZ,L22FB        ;
        LD      HL,00005h       ;
        ADD     HL,DE           ;
        BIT     2,(IY+005h)     ;
        JR      NZ,L22FB        ;
        SET     6,(HL)          ;
        CALL    L2B91           ;
        LD      HL,00005h       ;
        ADD     HL,DE           ;
        BIT     5,(HL)          ;
        JR      NZ,L22FB        ;
        LD      HL,00006h       ;
        ADD     HL,DE           ;
        LD      A,(HL)          ;
        INC     A               ;
        OR      080h            ;
        LD      (IY+002h),A     ;
L22FB:  CALL    L2823           ;
        LD      A,(IY+002h)     ;
        LD      (HL),A          ;
        INC     L               ;
        LD      A,(0A011h)      ;
        BIT     2,A             ;
        JR      NZ,L2312        ;
        LD      A,(0A010h)      ;
        BIT     3,A             ;
        JR      NZ,L2312        ;
        DEC     (HL)            ;
L2312:  PUSH    HL              ;
        CALL    L292C           ;
        POP     HL              ;
        LD      A,03Fh          ;
        AND     (HL)            ;
        JP      NZ,L2201        ;
        PUSH    DE              ;
        LD      BC,0003Fh       ;
        LD      A,030h          ;
        CP      E               ;
        JR      NZ,L2333        ;
        LD      HL,0A060h       ;
        LD      DE,0A061h       ;
L232C:  LD      (HL),000h       ;
        LDIR                    ;
        POP     DE              ;
        JR      L233B           ;
L2333:  LD      HL,0A090h       ;
        LD      DE,0A091h       ;
        JR      L232C           ;
L233B:  LD      HL,0A031h       ;
        LD      A,03Fh          ;
        AND     (HL)            ;
        JR      NZ,L2356        ;
        LD      L,039h          ;
        LD      A,03Fh          ;
        AND     (HL)            ;
        JR      NZ,L2356        ;
L234A:  CALL    L23C4           ;
        CALL    L24BD           ;
        BIT     5,(IY+000h)     ;
        JR      Z,L234A         ;
L2356:  LD      HL,0A039h       ;
        BIT     7,(HL)          ;
        JR      Z,L2377         ;
        CALL    L2823           ;
        LD      A,030h          ;
        CP      E               ;
        JR      NZ,L236B        ;
        LD      BC,(0380Eh)     ;
        JR      L236F           ;
L236B:  LD      BC,(03810h)     ;
L236F:  CALL    L288E           ;
        LD      A,020h          ;
        CALL    L28CF           ;
L2377:  CALL    L2823           ;
        INC     L               ;
        RES     7,(HL)          ;
L237D:  LD      A,030h          ;
        CP      E               ;
        LD      A,00Fh          ;
        JR      NZ,L2389        ;
        LD      (0E03Eh),A      ;
        JR      L238C           ;
L2389:  LD      (0E03Fh),A      ;
L238C:  JP      L21ED           ;
L238F:  LD      HL,0A009h       ;
        LD      A,000h          ;
        CP      (HL)            ;
        JP      Z,L2093         ;
        LD      A,002h          ;
        CP      (HL)            ;
        JP      C,L21D7         ;
        JP      L212D           ;
L23A1:  CALL    L2823           ;
        INC     L               ;
        LD      (HL),000h       ;
        CALL    L2857           ;
        LD      BC,(03808h)     ;
        LD      (0A00Bh),BC     ;
        XOR     A               ;
        LD      (0A00Dh),A      ;
        LD      L,008h          ;
        SET     5,(HL)          ;
        CALL    L2910           ;
        LD      A,0FFh          ;
        CALL    L28CF           ;
        JR      L237D           ;
L23C4:  EXX                     ;
        LD      HL,0A008h       ;
        RES     2,(HL)          ;
        LD      L,00Ah          ;
        SET     7,(HL)          ;
        LD      HL,0A00Eh       ;
        LD      A,07Fh          ;
        AND     (HL)            ;
        LD      B,A             ;
        LD      L,00Fh          ;
        LD      A,07Fh          ;
        AND     (HL)            ;
        LD      C,A             ;
        LD      A,B             ;
        SLA     A               ;
        LD      E,A             ;
        LD      D,000h          ;
        LD      HL,0391Dh       ;
        ADD     HL,DE           ;
        CALL    L27D9           ;
        LD      A,C             ;
        SLA     A               ;
        LD      E,A             ;
        LD      D,000h          ;
        ADD     HL,DE           ;
        CALL    L27D9           ;
        LD      IX,0A0D0h       ;
L23F6:  LD      DE,00010h       ;
        ADD     IX,DE           ;
        BIT     7,(HL)          ;
        JR      Z,L243F         ;
        LD      C,000h          ;
        CALL    L27EA           ;
        INC     HL              ;
        INC     C               ;
        CALL    L27EA           ;
        INC     HL              ;
        INC     C               ;
        LD      A,060h          ;
        AND     (IX+000h)       ;
L2410:  CALL    L27EA           ;
        INC     HL              ;
        INC     C               ;
        SUB     020h            ;
        JR      NC,L2410        ;
        BIT     4,(IX+000h)     ;
        JR      Z,L2425         ;
        LD      C,007h          ;
        CALL    L27EA           ;
        INC     HL              ;
L2425:  LD      A,000h          ;
        LD      (IX+00Eh),A     ;
        LD      (IX+00Fh),A     ;
        LD      A,003h          ;
        AND     (IX+001h)       ;
        LD      C,00Ch          ;
L2434:  CALL    L27EA           ;
        INC     HL              ;
        INC     C               ;
        SUB     001h            ;
        JR      NC,L2434        ;
        JR      L23F6           ;
L243F:  CALL    L27E5           ;
        LD      C,000h          ;
        CALL    L27FB           ;
        INC     HL              ;
        INC     C               ;
        CALL    L27FB           ;
        INC     HL              ;
        LD      C,00Eh          ;
        CALL    L27FB           ;
        INC     HL              ;
        INC     C               ;
        CALL    L27FB           ;
        INC     HL              ;
        LD      C,005h          ;
        CALL    L27FB           ;
        INC     HL              ;
        LD      C,003h          ;
        CALL    L27FB           ;
        INC     HL              ;
        INC     C               ;
        CALL    L27FB           ;
        LD      A,(0A00Eh)      ;
        LD      (IY+002h),A     ;
        LD      A,(IY+003h)     ;
        LD      (0A00Bh),A      ;
        LD      A,(IY+004h)     ;
        LD      (0A00Ch),A      ;
        XOR     A               ;
        LD      (0A00Dh),A      ;
        LD      A,00Fh          ;
        AND     (IY+000h)       ;
        LD      HL,038AFh       ;
        SLA     A               ;
        LD      E,A             ;
        LD      D,000h          ;
        RL      D               ;
        ADD     HL,DE           ;
        CALL    L27D9           ;
        LD      (0A013h),HL     ;
        LD      HL,0A008h       ;
        BIT     1,(HL)          ;
        RES     1,(HL)          ;
        JR      NZ,L24AD        ;
        BIT     4,(IY+005h)     ;
        JR      Z,L24AA         ;
        EXX                     ;
        CALL    L2910           ;
        EXX                     ;
        JR      L24AD           ;
L24AA:  CALL    L2900           ;
L24AD:  LD      HL,0A008h       ;
        SET     2,(HL)          ;
        EXX                     ;
        CALL    L2857           ;
        CALL    L28BA           ;
        CALL    L2925           ;
        RET                     ;


   
;----------------------------------------------------
;            Scene Mechanics and Gameplay
;----------------------------------------------------
L24BD:  EXX                     ;   

;  Following commented lines appear in rev D, but not here (DL1)
;L250D:  BIT     0,(IY+05h)      ; Is Easter Egg available now?
;        JR      NZ,L24FC        ; Yes, so test Easter Egg

L24BE:  JP      L2546           ; 




L24C1:  BIT     6,(IY+000h)     ; Is scene a message screen?
        JR      NZ,L2500        ; Yes, so skip ahead to check for coins
        BIT     6,(IY+005h)     ;
        JP      Z,L2512         ;
        LD      HL,0A010h       ; Get DIP Switch A
        BIT     4,(HL)          ; Test A4, Free Play
        JR      NZ,L24E4        ; FreePlay set so skip ahead      
        LD      HL,0A009h       ; Get number of credits
        LD      A,000h          ; Test remaining credits
        CP      (HL)            ; Are credits at zero?
        JR      Z,L2512         ; Yes, so skip ahead        
        LD      L,009h          ; HL = Number of credits (A009)
        LD      A,001h          ; Test for 1 credit
        CP      (HL)            ; Is there 1 credit left?
        JR      Z,L24EC         ; Yes so only check 1Player Button
L24E4:  LD      HL,0C010h       ; Get Inputs 
        BIT     1,(HL)          ; 2Player Button pressed?
        JP      Z,L214C         ; Yes, so skip ahead
L24EC:  LD      HL,0C010h       ; Get Inputs
        BIT     0,(HL)          ; 1Player Button pressed?
        JR      NZ,L2512        ; No, so jump back
;----------------------------------------------------
;           One player only so clear Player2
;----------------------------------------------------        
        LD      A,000h          ; Set Player2 Lives to zero
        LD      (0A039h),A      ; Store in Player2 Lives
        LD      A,00Fh          ; Load Blank character
        LD      (0E03Fh),A      ; Blank out Player2 Lives scorboard
        JP      L217B           ; Setup Player1
;----------------------------------------------------
;        Were coins inserted during attract mode?
;----------------------------------------------------        
L2500:  LD      HL,0A019h       ; Get Number of Coins
        LD      A,000h          ; Check if there are any coins 
        CP      (HL)            ; Were there any coins inserted?
        RET     NZ              ; Yes, so leave attract mode
 
;----------------------------------------------------
;                 Check for Credits       
;----------------------------------------------------
        LD      HL,0A009h       ; Get number of credits
        CP      (HL)            ; Were there any credits awarded?
        RET     NZ              ; Yes, so leave attract mode
  
;----------------------------------------------------
;                       
;----------------------------------------------------
        LD      L,010h          ; Get DIP Switch A 
        BIT     4,(HL)          ; Test A4, Free Play
        JR      NZ,L24E4        ; Free Play set so jump back
L2512:  CALL    L28BA           ; Clear Joystick Input Buffer
;----------------------------------------------------
;          Loop if  LP Timer is still running
;----------------------------------------------------
        LD      A,000h          ;
        CP      (IY+00Fh)       ;
        JP      NZ,L24BE        ;
        CP      (IY+00Eh)       ;
        JP      NZ,L24BE        ;
;----------------------------------------------------
;                 LP Timer expired
;----------------------------------------------------        
        BIT     7,(IY+005h)     ; On platform?
        JR      Z,L253A         ;      
        LD      HL,0A008h       ; HL = StatusA Register
        SET     1,(HL)          ;
;----------------------------------------------------
;            Wait for LP Timer to expire
;----------------------------------------------------        
L252E:  LD      A,000h          ;
        CP      (IY+00Fh)       ;
        JR      NZ,L252E        ;
        CP      (IY+00Eh)       ;
        JR      NZ,L252E        ;
;----------------------------------------------------
;      When the LP timer expires it means no move
;      was entered, so we get the index from the 
;      second byte and go to that scene.
;----------------------------------------------------        
L253A:  LD      A,(IY+001h)     ; Get index for next scene
L253D:  LD      HL,0A012h       ; HL = A012, scene index 
        LD      (HL),A          ; Store new index
        CALL    L28E1           ; Load Scene Data Index
        EXX                     ;
        RET                     ; Leave Game Mechanics    


   
;----------------------------------------------------
;        Test Joystick when no move is required
;----------------------------------------------------
L2546:  BIT     6,(IY+000h)     ; Is scene a message screen?
        JR      NZ,L254F        ; Yes, so skip joystick read 
        CALL    L2975           ; Read Joystick input  
L254F:  LD      IX,0A0E0h       ;
L2553:  BIT     7,(IX+000h)     ; Does series have JoyData?
        JR      NZ,L256F        ; Yes, then skip ahead       
        LD      B,00Bh          ;
        LD      HL,0A040h       ;
L255E:  BIT     7,(HL)          ; Has a moved been found?
        JR      NZ,L2567        ; Yes, exit loop                  
        INC     HL              ;
        DJNZ    L255E           ; Loop to check all possible moves
        JR      L256C           ; No move requested skip sound    
;----------------------------------------------------
;             Play Joystick buzz sound
;----------------------------------------------------        
L2567:  LD      A,002h          ; Index = 2
        CALL    L287E           ; Play Sound 2 ("Buzz")
L256C:  JP      L24C1           ; Keep looping in Game Mechanics
L256F:  LD      A,(IX+001h)     ;
        AND     003h            ;
        LD      B,A             ;
        LD      A,(IX+001h)     ;
        SRL     A               ;
        SRL     A               ;
        LD      C,A             ;
;----------------------------------------------------
;         Check Joystick Timer (A0EC) for a zero
;----------------------------------------------------        
        PUSH    IX              ;
        POP     HL              ;
        LD      A,L             ;
        ADD     A,00Ch          ;
        LD      L,A             ;
        LD      A,000h          ;
        CP      (HL)            ;
        JR      Z,L2590         ;
L2589:  LD      DE,00010h       ;
        ADD     IX,DE           ;
        JR      L2553           ;
L2590:  INC     HL              ;
        CP      (HL)            ;
        JR      NZ,L259D        ;
        SRL     C               ;
        SRL     C               ;
        DEC     B               ;
        JR      NZ,L2590        ;
L259B:  JR      L2589           ;
;----------------------------------------------------
;            Valid Window, Test Joystick Move
;----------------------------------------------------
L259D:  LD      A,00Fh          ;
        AND     (IX+000h)       ;
        LD      HL,0A040h       ;
        ADD     A,L             ;
        LD      L,A             ;
        BIT     7,(HL)          ;
        JR      Z,L2589         ;
;----------------------------------------------------
;     Move was in list, now determine what scene to play
;----------------------------------------------------        
        LD      A,003h          ;
        AND     C               ;
        ADD     A,002h          ;
        PUSH    IX              ;
        POP     HL              ;
        ADD     A,L             ;
        LD      L,A             ;
        LD      A,(HL)          ;
        CP      0FFh            ;
        JR      Z,L259B         ;
        LD      (0A000h),HL     ;
;----------------------------------------------------
;            Play Joystick "Dink" Sound
;----------------------------------------------------        
        LD      A,001h          ; Index = 1
        CALL    L287E           ; Play Sound 1 ("Dink")
        CALL    L28BA           ; Clear Joystick Input Buffer
        BIT     4,(IX+000h)     ; Was the move the correct move?
        JR      Z,L260F         ; Yes, so skip ahead
;----------------------------------------------------
;   Incorrect move applied during valid move window
;----------------------------------------------------        
        LD      HL,(0A000h)     ;
        EX      DE,HL           ;
        LD      HL,0A008h       ; HL = StatusA Register
        LD      A,E             ;
        AND     00Fh            ;
        CP      002h            ; First timer for move?
        JR      Z,L25E7         ;       
        CP      003h            ; Second timer for move?
        JR      Z,L25F1         ;       
        BIT     5,(IX+007h)     ;
        JR      Z,L260F         ;       
        SET     1,(HL)          ; Set New Scene bit
        JR      L25F9           ;       
L25E7:  BIT     7,(IX+007h)     ; Was move correct?
        JR      Z,L260F         ; No, skip ahead           
        SET     1,(HL)          ; Set New Scene bit
        JR      L25F9           ;       
L25F1:  BIT     6,(IX+007h)     ;
        JR      Z,L260F         ;
        SET     1,(HL)          ;
;----------------------------------------------------
;  Incorrect move, so wait until all move timers expire
;----------------------------------------------------        
L25F9:  LD      A,000h          ;
        CP      (IX+00Ch)       ;
        JR      NZ,L25F9        ;
        CP      (IX+00Dh)       ;
        JR      NZ,L25F9        ;
        CP      (IX+00Eh)       ;
        JR      NZ,L25F9        ;
        CP      (IX+00Fh)       ;
        JR      NZ,L25F9        ;
        
;----------------------------------------------------
;    Get Index to next scene based on wrong move
;----------------------------------------------------        
L260F:  LD      HL,(0A000h)     ; HL = next scene pointer
        LD      A,(HL)          ; Get data out of pointer
        RES     4,(IY+000h)     ;
        JP      L253D           ; A = index, set up next scene
        
        
        
;----------------------------------------------------
;             Main Interrupt Service Routine
;----------------------------------------------------
;     Save Registers to the stack before beginning
;----------------------------------------------------        
L261A:  PUSH    AF              ; Save AF to stack
        PUSH    BC              ; Save BC to stack
        PUSH    DE              ; Save DE to stack
        PUSH    HL              ; Save HL to stack
        EX      AF,AF'          ;
        PUSH    AF              ; Save AF' to stack
        LD      HL,0A00Ah       ; HL = StatusB Register
        SET     6,(HL)          ; Mark that interrupt occured
        LD      A,(0A00Ah)      ; A = StatusB Register
        BIT     5,A             ; Skip Interrupt maintance?
        JP      NZ,L2711        ; Yes, so only service Sound Chip
;----------------------------------------------------
;               Check Coin Slot Input
;----------------------------------------------------        
        LD      A,(0A020h)      ; Get LDV register
        SET     4,A             ; Hold Play Counter
        LD      (0A020h),A      ; Store LDV register
        LD      (0E008h),A      ; Write LDV register
        LD      HL,0A01Ah       ; HL = A01A, Coin Slot Status
        LD      A,(0C010h)      ; Get Inputs
        BIT     2,A             ; Test Coin Slot 1
        JR      Z,L2646         ; No Coins so skip ahead             
        BIT     3,A             ; Test Coin Slot 2
        JR      NZ,L268E        ; Coins inserted so jump ahead      
L2646:  BIT     5,(HL)          ; Debounce high completed?
        JR      NZ,L2655        ; Yes, test debounce low        
        SET     5,(HL)          ; Set flag for debounce high complete
        LD      L,019h          ; HL = A019, Number of Coins
        INC     (HL)            ; Add 1 to number of coins
        JR      NZ,L2653        ; Less than 255 coins, so skip ahead 
        LD      (HL),0FFh       ; Set Coins to 255 max
L2653:  LD      A,000h          ;
L2655:  LD      HL,0A008h       ; HL = StatusA Register
        BIT     2,(HL)          ; Is LDPlayer searching?
        JR      Z,L26A3         ; Yes, so skip update timers
;----------------------------------------------------
;  If Move has Joystick Data then update the timers
;----------------------------------------------------        
        LD      BC,0A0E0h       ;BC = A0E0, Start of Move Joydata
        CALL    L2826           ;HL = BC, HL = A0E0, Point to first JoyData
L2662:  BIT     7,(HL)          ; Does Move have JoyData?
        JR      Z,L2692         ; No, so skip ahead
        LD      A,00Ch          ; A = 0C
        ADD     A,L             ; A = L + A
        LD      L,A             ; L = A, HL = A0EC (JoyData Edge1 Timer)
        LD      A,000h          ; A = 0
        CP      (HL)            ; Is Edge1 Timer expired?
        JR      Z,L267C         ; Yes, so skip        
L266F:  DEC     (HL)            ; Subtract 1 from Edge1 Timer 
        CALL    L2826           ; HL = BC, HL = A0E0
        LD      BC,00010h       ; BC = 10h
        ADD     HL,BC           ; HL = HL + 10h, Point to next JoyData
        CALL    L2829           ; BC = HL, BC = Next JoyData
        JR      L2662           ; Loop back with next JoyData        
;----------------------------------------------------
;   If Edge1 timer (A0EC) expired then decrement all timers
;----------------------------------------------------        
L267C:  INC     HL              ; HL = next timer
        LD      A,00Fh          ; A = 0F, last timer spot
        AND     L               ; Does HL = A0EF, Last timer?
        JR      Z,L2689         ; Yes, last timer so jump ahead    
        LD      A,000h          ; A = 0
        CP      (HL)            ; Edge2 Timer expired?
        JR      NZ,L266F        ; No, so jump back and decrement it
        JR      L267C           ; Loop back and get next timer     
L2689:  CALL    L2829           ; BC = HL
        JR      L2662           ; Loop back and get next JoyData
;----------------------------------------------------
;              Clear Coin Debounce Flag
;----------------------------------------------------        
L268E:  RES     5,(HL)          ; Clear debounce high flag
        JR      L2655           ; Jump back
;----------------------------------------------------
;                 Service LP Timer
;----------------------------------------------------        
L2692:  PUSH    IY              ; Push IY onto stack
        POP     HL              ; HL = IY, A0E0 first JoyData
        LD      A,00Eh          ; A = 0E
        ADD     A,L             ; A = L + A
        LD      L,A             ; HL = A0EE, LP Timer
        CALL    L280A           ; Call Subtraction
        JR      NC,L26A3        ; Skip ahead if LP Timer still running
        LD      (HL),000h       ; Set LP Timer to zero
        INC     HL              ; Next byte
        LD      (HL),000h       ; Set LP Timer to zero
;----------------------------------------------------
;          Decrement Sound Chip Timer:  A01F
;----------------------------------------------------        
L26A3:  LD      HL,0A01Fh       ; Load Sound Chip Timer 
        LD      A,000h          ; A = 0
        CP      (HL)            ; Is timer at zero?     
        JR      Z,L26AC         ; Yes, so skip ahead
        DEC     (HL)            ; No, so subtract one from timer
;----------------------------------------------------
;         Check for Free Play DIP Setting
;----------------------------------------------------        
L26AC:  LD      HL,0A010h       ; Get DIP Switch A
        BIT     4,(HL)          ; Test A4, Free Play
        JR      Z,L26BF         ; Free Play not set so skip        
        LD      A,000h          ; A=0
        LD      (0E036h),A      ; Store 0 in credit scoreboard, tens
        LD      A,002h          ; A=2
        LD      (0E037h),A      ; Store 2 in credit scoreboard, ones
        JR      L26EA           ; Jump to check Diagnostic DIP
;----------------------------------------------------
;            Award Credits for Coins
;----------------------------------------------------        
L26BF:  LD      HL,0A010h       ; Get DIP Switch A
        LD      A,003h          ; Test DIP A3, Engineering Use      
        AND     (HL)            ; Isolate A0,A1
        INC     A               ; A = 2, 3, or 4
        LD      L,019h          ; HL = A019, Number of Coins
        CP      (HL)            ; Enough coins for 1 credit?
        JR      NC,L26E7        ; No, so just skip ahead
        LD      L,009h          ; HL = A009, Number of Credits
        INC     (HL)            ; Add 1 credit
        INC     A               ; A = A + 1
        LD      B,A             ; B = 3, 4, or 5
        LD      L,019h          ; HL = A019, Number of Coins
        LD      A,(HL)          ; A = Number of coins
        SUB     B               ; Subtract coins needed for 1 credit
        LD      (HL),A          ; Store number of remaining coins
        LD      A,(0A020h)      ; Get Hardware register
        RES     4,A             ; Increment Play Counter            
        LD      (0A020h),A      ; Store Hardware register
        LD      (0E008h),A      ; Write Hardware register
        LD      A,000h          ; Sound = 0
        CALL    L27BE           ; Play Sound 0 ("tah-dah")
        JR      L26AC           ; Loop until all credits awarded    
;----------------------------------------------------
;               Update Scoreboard
;----------------------------------------------------        
L26E7:  CALL    L289A           ; Update Scoreboard
;----------------------------------------------------
;             Check Diagnostic Mode DIP
;----------------------------------------------------
L26EA:  LD      A,00Eh          ; Set Hardware select 0E
        LD      (0E010h),A      ; Write hardware select
        LD      A,(0C000h)      ; Get DIP Switch A data
        BIT     7,A             ; Test A7, Diagnostic Mode
        JR      Z,L26F9         ; Diagnostic Mode not select, skip ahead
        JP      L023C           ; Jump to Diagnostic routine
;----------------------------------------------------
;            Decrement Delay Timer: A05E-A05F
;----------------------------------------------------        
L26F9:  LD      HL,0A05Eh       ; Decrement A05E contents
        CALL    L280A           ; Call subtraction
        JR      NC,L2706        ; Timer still running so skip ahead
        LD      (HL),000h       ; Set timer to zero
        INC     HL              ; Next byte
        LD      (HL),000h       ; Set timer to zero
;----------------------------------------------------
;          Decrement Watchdog Timer: A0DE-A0DF
;----------------------------------------------------        
L2706:  LD      HL,0A0DEh       ; Decrement $A0DE contents
        CALL    L280A           ; Call Subtraction
        JR      NC,L2711        ; Watchdog fail?      
        JP      L2C2F           ; Yes, Clear Player Data (A030-A3FF)
;----------------------------------------------------
;            Call Service Sound Chip 
;----------------------------------------------------        
L2711:  CALL    L271D           ; Service Sound Chip
;----------------------------------------------------
;     Reset Variables and return from interrupt
;----------------------------------------------------
        POP     AF              ;  Get AF
        EX      AF,AF'          ;  Retrieve AF'
        POP     HL              ;  Retrieve HL
        POP     DE              ;  Retrieve DE
        POP     BC              ;  Retrieve BC
        POP     AF              ;  Retrieve AF
        EI                      ;  Enable Interrupts   
        RETI                    ;  Return from Interrupt


   
;----------------------------------------------------
;                  Service Sound Chip          
;----------------------------------------------------
L271D:  LD      HL,0A01Ch       ; Get Sound Register
        BIT     0,(HL)          ; Was sound requested?
        RET     Z               ; No, so return
        LD      L,01Fh          ; HL = A01F, Sound Timer
        LD      A,000h          ; Check if Sound Timer is zero
        CP      (HL)            ; Is Sound Timer zero?
        RET     NZ              ; No, a sound is already playing so return
        LD      L,01Dh          ; A01Dh = Pointer to Sound Data
        CALL    L27D9           ; HL = (HL), Sound Data
        LD      DE,0A01Dh       ; DE = pointer to Sound Data
        LD      B,(HL)          ; B = first Sound Data byte
        INC     HL              ; Point to next Sound Data byte
        LD      A,003h          ; A = 3
        AND     B               ; A = first byte & 03
        LD      C,A             ; C = A
        SLA     C               ; C = C * 2
        LD      A,0FFh          ; A = FF
        CALL    L27AC           ; Call Sound (A=FF,C=byte)
        BIT     5,B             ;
        JR      Z,L2749         ;      
        LD      A,005h          ; A = 5  
        LD      C,001h          ; C = 1
        CALL    L27AC           ; Write Sound Chip registers
L2749:  LD      A,00Ch          ;
        AND     B               ;
        LD      C,A             ;
        SRL     C               ;
        SRL     C               ;
        LD      A,007h          ; A = 7
        CALL    L27AC           ; Write Sound Chip registers
        BIT     4,B             ;
        JR      Z,L2766         ;      
        LD      A,(HL)          ;
        INC     HL              ;
        EX      DE,HL           ;
        LD      L,01Bh          ; HL = A01B
        LD      (HL),A          ; Get value for Sound Timer
        LD      L,01Fh          ; HL = A01F, Sound Timer
        LD      (HL),A          ; Store value in Sound Timer
        EX      DE,HL           ;
        JR      L276E           ;      
L2766:  EX      DE,HL           ;
        LD      L,01Bh          ; HL = A01B
        LD      A,(HL)          ; Get value for Sound Timer
        LD      L,01Fh          ; HL = A01F, Sound Timer
        LD      (HL),A          ; Store value in Sound Timer
        EX      DE,HL           ;
L276E:  BIT     6,B             ;
        JR      Z,L2779         ;      
        LD      A,00Ah          ; Sound Chip Address = 10
        LD      C,002h          ; C = 2
        CALL    L27AC           ; Write Sound Chip registers
L2779:  BIT     7,(HL)          ;
        JR      Z,L278A         ;      
        LD      A,007h          ;
        LD      (0E010h),A      ; Latch Address to Sound Chip
        LD      A,(HL)          ;
        CPL                     ;
        AND     03Fh            ;
        LD      (0E000h),A      ;
        INC     HL              ;
L278A:  BIT     7,B             ;
        JR      Z,L2797         ;
        LD      A,00Dh          ;
        LD      (0E010h),A      ; Latch Address to Sound Chip
        LD      A,(HL)          ;
        LD      (0E000h),A      ;
L2797:  BIT     5,(HL)          ;
        JR      Z,L27A6         ;
        INC     HL              ;
        CALL    L2829           ;
        LD      HL,0A01Dh       ;
        LD      (HL),C          ;
        INC     HL              ;
        LD      (HL),B          ;
        RET                     ;


   
;----------------------------------------------------
;                       
;----------------------------------------------------
L27A6:  LD      HL,0A01Ch       ; Get Sound Register
        RES     0,(HL)          ; Clear request for sound
        RET                     ;


   
;----------------------------------------------------
;                   Make Sound       
;----------------------------------------------------
;         A = # of ?????
;         C = # of ?????
;         HL = Pointer to Sound Data (Sound0,Sound1,Sound2,Sound3)
;----------------------------------------------------
L27AC:  DEC     C               
        JP      M,L27BD         
        INC     A               ; Increment register Address
        LD      (0E010h),A      ; Latch Address to Sound Chip
        EX      AF,AF'          
        LD      A,(HL)          ; Point to next Sound Data byte
        INC     HL              ; Get next Sound Data
        LD      (0E000h),A      ; Write Data to Sound Chip
        EX      AF,AF'          
        JR      L27AC           ; Loop back until C = 0       
L27BD:  RET                     


   
;----------------------------------------------------
;         Load Sound pointers from indexed table
;----------------------------------------------------
;             A = Which sound to play
;                      0 = "tah-dah"
;                      1 = "dink"
;                      2 = "buzz"
;                      3 = ?
;         A01Ch = Sound Registerstatus
;         A01Dh = Pointer to Sound 
;         A01Eh = Pointer to Sound
;----------------------------------------------------
L27BE:  LD      HL,L38CF        ; HL = Pointer to Sound Table
        LD      BC,L0000        ; BC = 0
        LD      C,A             ;
        SLA     C               ;
        RL      B               ; BC = A * 2
        ADD     HL,BC           ; Index into Sound Table using BC
        LD      A,(HL)          ; Get Sound Pointer from table
        LD      (0A01Dh),A      ; Store Sound Pointer
        INC     HL              ; Next byte
        LD      A,(HL)          ; Get Sound Pointer from table
        LD      (0A01Eh),A      ; Store Sound Pointer
        LD      HL,0A01Ch       ; Get Sound register
        SET     0,(HL)          ; Enable Sound Request
        RET                     ;


   
;----------------------------------------------------
;          Load HL with the contents of HL
;----------------------------------------------------
L27D9:  LD      E,(HL)          ;
        INC     HL              ;
        LD      D,(HL)          ;
        CALL    L2823           ;
        RET                     ;


   
;----------------------------------------------------
;                  Set IX = IY
;----------------------------------------------------
        PUSH    IY              ;
        POP     IX              ;
        RET                     ;


   
;----------------------------------------------------
;                  Set IY = IX
;----------------------------------------------------
L27E5:  PUSH    IX              ;
        POP     IY              ;
        RET                     ;


   
;----------------------------------------------------
;                (IX + C) = (HL)
;----------------------------------------------------
L27EA:  EX      AF,AF'          ;
        PUSH    BC              ;
        LD      B,000h          ;
        PUSH    IX              ;
        ADD     IX,BC           ;
        LD      A,(HL)          ;
        LD      (IX+000h),A     ;
        POP     IX              ;
        POP     BC              ;
        EX      AF,AF'          ;
        RET                     ;


   
;----------------------------------------------------
;              LD IY + C,(HL)    
;----------------------------------------------------
L27FB:  EX      AF,AF'          ;
        LD      B,000h          ;
        PUSH    IY              ;
        ADD     IY,BC           ;
        LD      A,(HL)          ;
        LD      (IY+000h),A     ;
        POP     IY              ;
        EX      AF,AF'          ;
        RET                     ;


   
;----------------------------------------------------
;      Subtract one from contents of HL
;----------------------------------------------------
L280A:  LD      C,(HL)          ;
        INC     HL              ;
        LD      B,(HL)          ;
        CALL    L282C           ;
        CALL    L2826           ;
        LD      BC,00001h       ;
        AND     A               ;
        SBC     HL,BC           ;
        CALL    L2829           ;
        CALL    L2823           ;
        LD      (HL),B          ;
        DEC     HL              ;
        LD      (HL),C          ;
        RET                     ;


   
;----------------------------------------------------
;                 HL = DE
;----------------------------------------------------
L2823:  PUSH    DE              ;
        POP     HL              ;
        RET                     ;


   
;----------------------------------------------------
;                 HL = BC
;----------------------------------------------------
L2826:  PUSH    BC              ;
        POP     HL              ;
        RET                     ;


   
;----------------------------------------------------
;                 BC = HL
;----------------------------------------------------
L2829:  PUSH    HL              ;
        POP     BC              ;
        RET                     ;


   
;----------------------------------------------------
;                 DE = HL
;----------------------------------------------------
L282C:  PUSH    HL              ;
        POP     DE              ;
        RET                     ;


   
;----------------------------------------------------
;    Decrement BONUS and increment score (DL1)
;----------------------------------------------------
;             Decrement BONUS until zero
;----------------------------------------------------
L282F:  EXX                     ; Swap registers
        LD      HL,0A013h       ; Point to scene BONUS 
        PUSH    DE              ; Save DE
        CALL    L280A           ; Subtract one from BONUS
        POP     DE              ; Recall DE
        JR      NC,L2842        ; BONUS not zero so jump ahead
        LD      HL,L0000        ; Set BONUS to zero
        LD      (0A013h),HL     ; Store BONUS
        JR      L2855           ; Skip to end
;----------------------------------------------------
;                 Add 1 to score
;----------------------------------------------------        
L2842:  CALL    L2823           ; HL = DE (Players score)
        INC     L               ; Go to low-byte of score
        INC     L               ; Go to low-byte of score
        INC     (HL)            ; Increment score by 1
        JR      NZ,L2850        ; Byte didn't roll over so skip ahead
        INC     L               ; Go to next score byte 
        INC     (HL)            ; Increment middle byte
        JR      NZ,L2850        ; Byte didn't roll over so skip ahead
        INC     L               ; Go to highest score byte 
        INC     (HL)            ; Increment high byte
L2850:  CALL    L292C           ; Update Scoreboard
        LD      A,003h          ; A = 3
L2855:  EXX                     ; Restore registers
        RET                     ; Return


   
;----------------------------------------------------
;            Add Bonus to Player Score
;----------------------------------------------------
;        A013h = BONUS LSB
;        A014h = BONUS MSB
;           DE = Player score location 
;       (A030h = Player1, A038h = Player2) 
;----------------------------------------------------
L2857:  LD      A,(0A013h)      ; A = BONUS LSB (DL1)
        CALL    L2823           ; HL = DE, A030 (Player1)
        INC     L               ; HL = HL + 2
        INC     L               ; HL = A032, Score byte 1(Player1)
        ADD     A,(HL)          ; Add BONUS byte 1 to Score byte 1
        LD      (HL),A          ; Store score byte 1
        LD      A,(0A014h)      ; A = BONUS byte 2
        INC     L               ; HL = Score byte 2, A033 (Player1)
        ADC     A,(HL)          ; Add BONUS byte 2 to Score byte 2 with carry
        LD      (HL),A          ; Save Score byte 2
        LD      A,000h          ; A = 00
        INC     L               ; HL = Score byte 3, A034 (Player1)
        ADC     A,(HL)          ; Add BONUS byte 3 to Score byte 3 with carry
        LD      (HL),A          ; Save Score byte 3
;----------------------------------------------------
;       In rev D this check came first (DL1)
;----------------------------------------------------        
        LD      A,(0A013h)      ; A = BONUS LSB
        CP      000h            ; Is BONUS zero?
        RET     Z               ; Yes, so just leave
;----------------------------------------------------
;                       
;----------------------------------------------------
        CALL    L292C           ; Update Scoreboard
        LD      HL,L0000        ; Set BONUS to zero
        LD      (0A013h),HL     ; Store zero in BONUS
        LD      A,003h          ; Return A = 3 (?)
        RET                     ;


   
;----------------------------------------------------
;   PlaySound called but check DIP settings first
;----------------------------------------------------
L287E:  LD      HL,0A010h       ; Get DIP Switch A
        BIT     3,(HL)          ; Test A3, Engineering Use 
        JR      NZ,L288A        ;       
        LD      L,011h          ; Get DIP Switch B
        BIT     3,(HL)          ; Test B3, LDPlayer Model 
        RET     Z               ; PR8210 selected so return 
;----------------------------------------------------
;                       
;----------------------------------------------------
L288A:  CALL    L27BE           ; Else call sound
        RET                     ;


   
;----------------------------------------------------
;               Search to Frame
;----------------------------------------------------
L288E:  LD      (0A00Bh),BC     ; Get frame number
        XOR     A               ; A = 0
        LD      (0A00Dh),A      ; Store frame number
        CALL    L2910           ; Search to frame   
        RET                     ;


   
;----------------------------------------------------
;                Update Scoreboard Credits
;----------------------------------------------------
L289A:  LD      A,(0A009h)      ; Get number of credits
        LD      C,A             ; C = number of credits
        XOR     A               ; Clear carry, A = 0
        LD      B,009h          ; B = 9, set Loop
L28A1:  ADC     A,A             ;
        DAA                     ;
        SLA     C               ;
        DJNZ    L28A1           ; Loop until all        
        LD      (0E037h),A      ; Display credit (ones)
        CALL    L28B1           ; Get tens digit
        LD      (0E036h),A      ; Display credit (tens)
        RET                     ;


   
;----------------------------------------------------
;                  Get upper nibble
;----------------------------------------------------
L28B1:  SRL     A               ; Shift A bits to the right
        SRL     A               ; Shift A bits to the right
        SRL     A               ; Shift A bits to the right
        SRL     A               ; Shift A bits to the right
        RET                     ;


   
;----------------------------------------------------
;    Clear bit 7 of A040-A04Ah Joystick Input Buffer
;----------------------------------------------------
L28BA:  LD      B,00Bh          ; B = 11         
        LD      HL,0A040h       ; HL = A040 (Joystick Input Buffer)
L28BF:  RES     7,(HL)          ; Clear Joystick Input flag for direction
        INC     HL              ; Next byte
        DJNZ    L28BF           ; Loop until all bytes cleared
        RET                     ;


   
;----------------------------------------------------
;              Double duration Delay Timer
;----------------------------------------------------
;            A = Timer Value which is doubled (66ms per digit)
;----------------------------------------------------
L28C5:  LD      HL,0000h        ; HL = 0
        LD      L,A             ; HL = Timer Value
        ADD     HL,HL           ; Multiply by 2
        LD      (0A05Eh),HL     ; Store Timer in A05E-A05F
        JR      L28D2           ; Jump ahead to delay routine
;----------------------------------------------------
;             Single duration Delay Timer
;----------------------------------------------------
;            A = Timer Value (33ms per digit)
;----------------------------------------------------        
L28CF:  LD      (0A05Eh),A      ; Store Timer value

;  Following commented lines appear in rev D, but not here (DL1)
;        XOR     A               ; A = 0
;        LD      (0A05Fh),A      ; Store Timer value

L28D2:  LD      A,(0A05Fh)      ; Get Timer byte
        CP      000h            ; Check if timer expired
        JR      NZ,L28D2        ; Timer not expired so keep looping
L28D9:  LD      A,(0A05Eh)      ; Get Timer byte
        CP      000h            ; Check if timer expired
        JR      NZ,L28D9        ; Timer not expired so keep looping
        RET                     ; Timer expired so return


   
;----------------------------------------------------
;           Load Scene Data Index
;----------------------------------------------------
;    A00Eh = Scene index
;    A00Fh = Move index
;----------------------------------------------------
L28E1:  LD      HL,0A012h       ;
        LD      A,(HL)          ;
        BIT     7,A             ;
        JR      Z,L28F6         ;
;----------------------------------------------------
;    if A012h = 128-256
;            (A00Eh) <== (A012h)   (A00Fh) = 0
;----------------------------------------------------        
        LD      L,00Eh          ;
        LD      (HL),A          ;
        LD      L,00Fh          ;
        LD      (HL),000h       ; Start at first move of scene
        LD      HL,0A008h       ; HL = StatusA Register
        RES     0,(HL)          ;
        RET                     ;


   
;----------------------------------------------------
;    if A012h = 0-127h 1st index
;            (A00E) <== (A0E2h)  (A00F) <== (A012h)
;----------------------------------------------------
L28F6:  LD      L,00Fh          ;
        LD      (HL),A          ;
        LD      L,00Eh          ;
        LD      A,(IY+002h)     ;
        LD      (HL),A          ;
        RET                     ;


   
;----------------------------------------------------
;      SEARCH and PLAY then re-enable freeze frame
;----------------------------------------------------
L2900:  LD      HL,0A008h       ; HL = StatusA Register
        SET     4,(HL)          ; Disable Freeze Frame
        RES     2,(HL)          ; Turn ON SEARCHing bit
        CALL    L012A           ; Send SEARCH to LDPlayer
        LD      HL,0A008h       ; HL = StatusA Register
        RES     4,(HL)          ; Enable Freeze Frame
        RET                     ;


   
;----------------------------------------------------
;               Call of SEARCH Routine
;----------------------------------------------------
L2910:  EXX                     ;
        LD      HL,0A008h       ; HL = StatusA Register
        SET     3,(HL)          ;
        RES     2,(HL)          ; Turn ON SEARCHing bit
        CALL    L012A           ; Send SEARCH to LDPlayer
        LD      HL,0A008h       ; HL = StatusA Register
        RES     3,(HL)          ;
        CALL    L2925           ; Reset Watchdog
        EXX                     ;
        RET                     ;


   
;----------------------------------------------------
;                   Reset Watchdog
;----------------------------------------------------
;  If this routine is not called every 1min 13sec 
;  then the micro will reset itself and start over
;----------------------------------------------------
L2925:  LD      HL,008AAh       ; Load Timer Value 08AAh
        LD      (0A0DEh),HL     ; Store value in Watchdog Timer
        RET                     ;


   
;----------------------------------------------------
;    Convert Score to BCD and place in scoreboard
;----------------------------------------------------
;           DE = Player score location 
;       (A030h = Player1, A038h = Player2)
;----------------------------------------------------
L292C:  CALL    L2823           ; HL = Player score
        LD      A,030h          ; A = 30
        CP      L               ; Is this Player1 score?
        INC     HL              ; HL = A031
        JR      NZ,L293F        ; No, so do Player2        
        LD      A,(HL)          ; Get Player1 Lives
        LD      (0E03Eh),A      ; Store lives in Player1 Scoreboard
        LD      BC,0E03Dh       ; BC = Player1 Scoreboard (100000) 
        PUSH    BC              ; Save Scoreboard location
        JR      L2947           ; Jump to scoreboard write        
L293F:  LD      A,(HL)          ; Get Player2 Lives
        LD      (0E03Fh),A      ; Store lives in Player2 Scoreboard
        LD      BC,0E035h       ; BC = Player2 Scoreboard (100000)
        PUSH    BC              ; Save Scoreboard location
;----------------------------------------------------
; Convert Player Score to BCD so it can be displayed
;----------------------------------------------------        
L2947:  INC     HL              ; Point to score byte 1 
        LD      A,(HL)          ; Get score byte 1
        LD      (0A00Bh),A      ; Store in BCD byte 1
        INC     HL              ; Point to score byte 2
        LD      A,(HL)          ; Get score byte 2
        LD      (0A00Ch),A      ; Store in BCD byte 2
        INC     HL              ; Point to score byte 3
        LD      A,(HL)          ; Get score byte 3
        LD      (0A00Dh),A      ; Store in BCD byte 3
        CALL    L0100           ; Convert number to BCD
;----------------------------------------------------
;            Put score BCD into scoreboard 
;----------------------------------------------------        
        EXX                     ;
        LD      B,003h          ; Set Loop, B = 3
        POP     DE              ; Pop Display location
        LD      HL,0A02Ch       ; Point HL to BCD value
L2960:  LD      A,(HL)          ; Get Score BCD
        LD      (DE),A          ; Store digit in place
        CALL    L28B1           ; Get upper nibble
        DEC     DE              ; Move to next place
        LD      (DE),A          ; Store next digit in place
        DEC     DE              ; Move to next place
        INC     HL              ; Increment value pointer
        DJNZ    L2960           ; Loop until all bytes placed
        EXX                     ;
        RET                     ;


   
;----------------------------------------------------
;                    Not Used
;----------------------------------------------------
        LD      B,002h          ;
        OR      B               ;
        LD      (0E038h),A      ;
        RET                     ;
        NOP                     ;
        
        
        
;----------------------------------------------------
;    Read Joystick Input into Joystick Input Buffer
;---------------------------------------------------- 
;    Locations A040 thru A04A store joystick inputs
;
;       A040      0000     Sword
;       A041      0001     Up
;       A042      0010     Down
;       A043      0011     <invalid>
;       A044      0100     Left
;       A045      0101     Up and Left
;       A046      0110     Up and Right
;       A047      0111     <invalid>
;       A048      1000     Right
;       A049      1001     Up and Right
;       A04A      1010     Down and Right
;----------------------------------------------------
;  Bit 5 = Valid Joystick Input for 1 cycle
;  Bit 6 = Valid Joystick Input for 2 cycles
;  Bit 7 = Valid Joystick Input Flag    
;----------------------------------------------------
;  Joystick input needs to be present for 2 cycles
;  and then the Valid Joystick Input Flag is set.
;----------------------------------------------------        
L2975:  LD      HL,0A040h       ; Point to Joystick Input Buffer
        LD      A,(0C008h)      ; Read Joystick Input
        XOR     0FFh            ; Toggle all bits in input
        BIT     4,A             ; Test Sword Button
        JR      Z,L29A7         ; Sword not pressed so skip
        BIT     5,(HL)          ; Sword already pressed for 1 cycle?
        JR      Z,L29B3         ; No, so set cycle count = 1
        BIT     6,(HL)          ; Sword already pressed for 2 cycles?
        JR      NZ,L298D        ; 
        SET     6,(HL)          ; Set bit 6 of Sword spot
        SET     7,(HL)          ; Set bit 7 of Sword spot
L298D:  AND     00Fh            ; Isolate Joystick Input
        ADD     A,040h          ; A = 40h + Joystick Input 
        INC     HL              ; HL = HL + 1 (A041,A042,...)
        LD      B,00Bh          ; Set Loop, B = 11
L2994:  CP      L               ; Does Input match Joystick spot
        JR      NZ,L29AD        ; If not then clear spot       
        BIT     5,(HL)          ; Joystick already pressed for 1 cycle?
        JR      Z,L29B7         ; No, so set cycle count = 1
        BIT     6,(HL)          ; Joystick already pressed for 2 cycles?
        JR      NZ,L29A3        ; Yes, so get next move
        SET     6,(HL)          ; No, so set cycle count = 2
        SET     7,(HL)          ; Set valid Joystick Input Flag for direction
L29A3:  INC     HL              ; HL = Next Joystick Spot
        DJNZ    L2994           ; Loop until all 11 moves checked
        RET                     ;


   
;----------------------------------------------------
;        Sword Button released so clear spot
;----------------------------------------------------
L29A7:  RES     6,(HL)          ; Clear bit cycle 2 of Sword spot
        RES     5,(HL)          ; Clear bit cycle 1 of Sword spot
        JR      L298D           ; Return and check Joystick
;----------------------------------------------------
;         Direction released so clear spot 
;----------------------------------------------------        
L29AD:  RES     6,(HL)          ; Clear bit cycle 2 of Joystick spot
        RES     5,(HL)          ; Clear bit cycle 1 of Joystick spot
        JR      L29A3           ; Return to loop  
;----------------------------------------------------
;              Sword press for 1 cycle
;----------------------------------------------------        
L29B3:  SET     5,(HL)          ; Set bit cycle 1 of Sword spot
        JR      L298D           ; Return and check Joystick    
;----------------------------------------------------
;            Joystick pressed for 1 cycle
;----------------------------------------------------        
L29B7:  SET     5,(HL)          ; Set bit 5 of Joystick spot
        JR      L29A3           ; Return to loop 
        
        
        
;----------------------------------------------------
;                 Start at new roadmap              
;----------------------------------------------------              
L29BB:  LD      A,(0A010h)      ; Get DIP Switch A
        BIT     3,A             ; Test DIP A3, Engineering Use
        RET     NZ              ; Return if A3 is OFF
        LD      A,(0A012h)      ; Get scene index
        BIT     7,A             ; Is this a level or scene?
        RET     Z               ; Scene, so return
        LD      HL,00005h       ; HL = 05h
        ADD     HL,DE           ; HL = A035 (Player1), Difficulty
        BIT     5,(HL)          ; Must we play scene until completion?
        RET     NZ              ; Yes, so just leave
        AND     07Fh            ; Get level number
        LD      (0A054h),A      ; Store Level Number
        LD      HL,00006h       ; HL = 06
        ADD     HL,DE           ; HL = DE(A030) + 06 (A036)
        LD      (HL),A          ; Save Level Number copy (A054) into (A036)
        DEC     HL              ; HL = A035 (Player1), Difficulty
        BIT     7,(HL)          ; Did we need a resurrection?
        JR      Z,L29E2         ; Yes, so retrieve next level       
        BIT     6,(HL)          ; Did player die on previous scene?
        JR      NZ,L29E2        ; Yes, so retrieve next level
        RET                     ; Return


   
;----------------------------------------------------
;       Point HL to Pointers/Data at LevelIndex
;    A054 = Row number of SceneMatrix pointer (0-13)
;----------------------------------------------------
L29E2:  EXX                     ;
        LD      HL,0384Fh       ; HL = LevelIndex
        LD      A,(0A054h)      ; A = Level Number (0-13)
        SLA     A               ; Multiply by 4 because...
        SLA     A               ; ...there are 4 bytes per row
        ADD     A,L             ;
        LD      L,A             ;
        XOR     A               ;
        ADC     A,H             ;
        LD      H,A             ; HL = LevelIndex + Level Number
;----------------------------------------------------
; Copy Data from LevelIndex table into RAM A050-A053h 
;----------------------------------------------------
;      A050-A051  = Pointer to Matrix Row (LEVEL00-LEVEL13)
;      A052       = Random Setting
;      A053       = Number of scenes in row                          
;----------------------------------------------------                
        PUSH    IX              ; Save IX
        LD      IX,0A050h       ; IX = A050
        LD      BC,00400h       ; B = 04, C = 00
L29FB:  CALL    L27EA           ; (IX+C) = (HL)
        INC     HL              ; Increment ROM location index
        INC     C               ; Increment RAM location index
        DJNZ    L29FB           ; Loop until all 4 bytes copied 
        POP     IX              ; Retrieve IX
;----------------------------------------------------
;     Test if any scenes in row have been played                           
;----------------------------------------------------        
        LD      A,(0A052h)      ; Get third byte
        AND     007h            ; Mask only first 3 bits (scene markers)
        CP      000h            ; Have any scenes been played yet?
        JR      NZ,L2A3A        ; Yes, so jump ahead
        
        LD      HL,(0A050h)     ; HL = Row Pointer
        LD      A,(HL)          ; Get First byte in Matrix Row
        
;----------------------------------------------------
;  Difficulty done different here (DL1)
;  Does not test DIP B7 Difficulty Level 
;----------------------------------------------------        
L2A11:  LD      HL,0A010h       ; Get DIP Switch A
        BIT     2,(HL)          ; Test A2, Game Begins Easy
        JR      NZ,L2A22        ; A2 OFF, skip ahead
        EXX                     ;
        LD      HL,00005h       ; HL = 05 
        ADD     HL,DE           ; HL = A035 (Player1), Difficulty
        BIT     4,(HL)          ; Has Difficulty been increased?
        EXX                     ;
        JR      Z,L2A24         ; No,so just use EasyIndex
;----------------------------------------------------
;  Difficult is selected to get scene from DiffIndex                           
;----------------------------------------------------        
L2A22:  ADD     A,028h          ; Add 28h to EasyIndex to get DiffIndex
L2A24:  LD      (0A012h),A      ; Store new scene into index
        CALL    L28E1           ; Load Scene Data Index
;----------------------------------------------------
;       Check if resurrection scene was requested                           
;----------------------------------------------------        
        EXX                     ; EXX
        LD      HL,00005h       ; HL = 05
        ADD     HL,DE           ; HL = A035 (Player1), Difficulty
        BIT     6,(HL)          ; Do we need a resurrection scene?
        RES     6,(HL)          ; Clear resurrection flag
        RET     Z               ; No scene required so start playing
        LD      A,001h          ; Start at resurrection scene
        LD      (0A00Fh),A      ; Save resurrection starting point
        RET                     ; Return



;----------------------------------------------------
;      Check SceneMatrix to see if scene has been
;      played yet.  Chose a scene accordingly
;----------------------------------------------------
L2A3A:  EXX                     ;
        LD      A,030h          ; Check if Player1
        CP      E               ; Is it Player1?
        EXX                     ;
        JR      NZ,L2A46        ; No, go load Player2 PlayList
        LD      HL,0A060h       ; Load Player1 PlayList
        JR      L2A49           ; Skip ahead       
L2A46:  LD      HL,0A090h       ; Load Player2 PlayList
L2A49:  LD      A,(0A054h)      ; A = Matrix Row Number
        ADD     A,L             ; Add Matrix Row Number to PlayList
        LD      L,A             ; HL = PlayList + Matrix Row (Player1)
        LD      (0A055h),HL     ; A055-A056 = PlayList Variable Pointer
        LD      A,(0A053h)      ; A = $07  (Byte 4)
        CP      (HL)            ; (HL) = All scenes already played?
        JR      NZ,L2A59        ; No, skip ahead 
        LD      (HL),000h       ; Reset all scenes for replay
L2A59:  LD      A,(0A052h)      ; Get Level Status Byte
        AND     007h            ; Check status
        LD      B,A             ; B = 2
        LD      (0A057h),A      ; Save 2
        LD      A,(0A052h)      ; Get Level Status Byte
        BIT     3,A             ; Do we choose a random scene for this level?
        JR      NZ,L2A77        ; No so skip random scene selection
        LD      BC,(0A050h)     ; BC = Matrix Pointer
        LD      HL,(0A055h)     ; HL = PlayList Variable Pointer
        CALL    L2AAC           ; Pick random scene that hasn't been played
        LD      A,(BC)          ; Get scene index from Matrix
        JP      L2A11           ; Continue with scene setup check
        
;----------------------------------------------------
;      Level does not choose scene randomly
;  (Yellow Crumbling Blocks, 3/9 Platforms, & Lair)
;----------------------------------------------------        
L2A77:  INC     B               ; Get number of scenes for level
        LD      A,001h          ; A = bit 1
L2A7A:  DEC     B               ; Loop--
        JR      Z,L2A81         ;
        SLA     A               ; A = 1,2,4 bits to set for marking scene
        JR      L2A7A           ; Multiply A by 2 until B=0, A=4        
L2A81:  LD      HL,(0A055h)     ;
        LD      (0A058h),A      ; HL point to scene in Playlist, HL=A06D
        AND     (HL)            ; Save scene marking bit
        JR      Z,L2A95         ; Have we played this scene yet?
        LD      HL,0A057h       ; No, so jump ahead and grab this scene  
        DEC     (HL)            ; Load level ending pointer
        LD      A,(0A058h)      ; Move to next scene 94h->9Eh->A4h 
        SRL     A               ;
        JR      L2A81           ;
;----------------------------------------------------
;       Scene not played so setup and play it
;----------------------------------------------------        
L2A95:  LD      A,(0A058h)      ; A = 4
        LD      HL,(0A055h)     ; HL point to scene in Playlist
        OR      (HL)            ; Mark this scene as played in the playlist
        LD      (HL),A          ; Save it into A058
        LD      HL,(0A050h)     ; Get Scene pointer
        LD      A,(0A057h)      ; A = 2
        ADD     A,L             ; 
        LD      L,A             ;
        XOR     A               ;
        ADC     A,H             ;
        LD      H,A             ;
        LD      A,(HL)          ; Get the scene (94h,9Eh,A4h)
        JP      L2A11           ; Continue with scene setup check
        
        
        
;----------------------------------------------------
; Determine which Scene in SceneMatrix to use                           
;----------------------------------------------------
;  Level is already chosen so choose a scene based
;  on a random number.  Make sure that scene has
;  not been played yet.
;----------------------------------------------------
;          BC = SceneMatrix Level Pointer
;          HL = PlayList Variable Pointer
;----------------------------------------------------        
L2AAC:  LD      A,(HL)          ; Load PlayList variable
        AND     007h            ; Mask off the first three bits
;----------------------------------------------------
;   Check PlayList to see which of the 3 scenes
;   have been played.  Each bit represents a scene.                           
;----------------------------------------------------        
        CP      000h            ; if (S1 = NO,  S2 = NO,  S3 = NO )
        JR      Z,L2AD3         ; then jump here
        CP      001h            ; if (S1 = YES, S2 = NO,  S3 = NO )
        JR      Z,L2AE1         ; then jump here
        CP      002h            ; if (S1 = NO,  S2 = YES, S3 = NO )
        JR      Z,L2AEB         ; then jump here
        CP      004h            ; if (S1 = NO,  S2 = NO,  S3 = YES)
        JR      Z,L2AF5         ; then jump here
        CP      003h            ; if (S1 = YES, S2 = YES, S3 = NO )
        JR      Z,L2ACE         ; then jump here
        CP      005h            ; if (S1 = YES, S2 = NO,  S3 = YES)
        JR      Z,L2ACA         ; then jump here
;----------------------------------------------------
;            Set up to play Scene 1 (S1)                            
;----------------------------------------------------        
L2AC7:  SET     0,(HL)          ; Mark Scene 1 as played
        RET                     ; Return


   
;----------------------------------------------------
;            Set up to play Scene 2 (S2)
;----------------------------------------------------
L2ACA:  SET     1,(HL)          ; Mark Scene 2 as played
        INC     BC              ; Set Matrix Pointer to Scene 2
        RET                     ; Return


   
;----------------------------------------------------
;    Set up to play Scene 3 (S3) based on difficulty
;----------------------------------------------------
;  Following commented line appears in rev D, but not here (DL1)
;L2B31:  JP      L3000           ; Jump to Difficulty check
L2ACE:  SET     2,(HL)          ; Mark Scene 3 as played
        INC     BC              ;
        INC     BC              ; Set Matrix pointer to Scene 3
        RET                     ; Return


   
;----------------------------------------------------
;          Random choice between S1, S2, S3                  
;     Probability S1 (50%), S2 (37.5%), S3 (12.5%)
;----------------------------------------------------
L2AD3:  LD      A,R             ; Pick a random number
        AND     007h            ; Create 3 choices
        BIT     0,A             ; Was S1 picked?
        JR      Z,L2AC7         ; Yes, so setup to play S1
        CP      007h            ; Was S3 picked?
        JR      Z,L2ACE         ; Yes, so setup to play S3
        JR      L2ACA           ; else Setup to play S2
;----------------------------------------------------
;          Random choice between S2, S3                  
;         Probability S2 (75%), S3 (25%)                             
;----------------------------------------------------        
L2AE1:  LD      A,R             ; Pick a random number
        AND     003h            ; Create 2 choices
        CP      003h            ; Was S3 picked?
        JR      Z,L2ACE         ; Yes, so setup to play S3
        JR      L2ACA           ; No, so setup to play S2
;----------------------------------------------------
;          Random choice between S1, S3                  
;         Probability S1 (75%), S3 (25%)                               
;----------------------------------------------------        
L2AEB:  LD      A,R             ; Pick a random number
        AND     003h            ; Create 2 choices
        CP      003h            ; Was S3 picked?
        JR      Z,L2ACE         ; Yes, so setup to play S3
        JR      L2AC7           ; No, so setup to play S1
;----------------------------------------------------
;          Random choice between S1, S2                  
;         Probability S1 (50%), S3 (50%)                               
;----------------------------------------------------        
L2AF5:  LD      A,R             ; Pick a random number
        BIT     0,A             ; Was S1 picked?
        JR      Z,L2AC7         ; Yes, so setup to play S1
        JR      L2ACA           ; No, so setup to play S2
        
        
        
;----------------------------------------------------
;         Pay-As-You-Go/Continue Game Routine                               
;----------------------------------------------------        
L2AFD:  
;  Following commented lines appear in rev D, but not here (DL1)
;        LD      A,(0A00Ah)      ; A = StatusB Register
;        BIT     0,A             ; Is Secret Move Bit set? 
;        RET     NZ              ; Yes, so just return

        LD      HL,0A010h       ; Get DIP Switch A
        BIT     6,(HL)          ; Test A6, Pay-As-You-Go
        RET     Z               ; Pay-As-You-Go disabled so return

;  Following commented lines appear in rev D, but not here (DL1)        
;----------------------------------------------------
;       Determine if extra life is awarded                               
;----------------------------------------------------
;        LD      HL,0005h        ; HL = 05
;        ADD     HL,DE           ; HL = A035 (Player1), Difficulty
;        BIT     2,(HL)          ; Test Difficutly
;        JR      NZ,L2B97        ; Set to difficult so no extra Dirks
;        LD      HL,0001h        ; HL = 01
;        ADD     HL,DE           ; HL = A031 (Player1), Player Lives
;        LD      A,(0A010h)      ; Get DIP Switch A
;        BIT     5,A             ; Test A5, Dirks per Credit
;        JR      NZ,L2B97        ; A5 is OFF, No extra life for 5 Dirks
;        LD      A,(0A011h)      ; Get DIP Switch B
;        BIT     5,A             ; Test B5, Continue
;        JR      Z,L2B95         ; B5 is OFF so award 3 lives
;        BIT     6,A             ; Test B6, Extra Dirks
;        JR      NZ,L2B97        ; B6 is off, so no extra Dirks
;        LD      A,83h           ; Check if 3 lives already
;        CP      (HL)            ; Is there 3 lives?
;        JR      Z,L2B97         ; Yes, so no extra life awarded
;----------------------------------------------------
;     Award extra live if all conditions are met                             
;----------------------------------------------------
;        INC     (HL)            ; Give an extra life
;        JR      L2B97           ; then Skip ahead
;L2B95:  LD      (HL),83h        ; else set lives to 3

;----------------------------------------------------
;        Setup the Continue Game Timer to 17sec
;----------------------------------------------------
        CALL    L2857           ; Add BONUS to player score
        LD      A,0FFh          ; Set Timer to $01FF (17sec)
        LD      (0A05Eh),A      ; Store in Delay Timer
        LD      A,001h          ; Set timer
        LD      (0A05Fh),A      ; Store in Delay Timer
;----------------------------------------------------
;  Display Continue Game instructions, check credits
;----------------------------------------------------        
        CALL    L2B43           ; Display Pay-As-You-Go Instructions
L2B13:  LD      HL,0A009h       ; Check remaiming credits
        XOR     A               ; A = 0
        CP      (HL)            ; Any credits left?
        JR      Z,L2B1C         ; No, skip ahead
        DEC     (HL)            ; Subtract one credits
        
;  Following commented lines appear in rev D, but not here (DL1)        
;        LD      A,5Ah           ; Load delay time (x sec)
;        CALL    SingleDelay     ; Call Single delay 
                
        RET                     ; Return to main loop


   
;  Following commented lines appear in rev D, but not here (DL1)
;----------------------------------------------------
;          Leave once a credit is inserted    
;----------------------------------------------------  
;L2BB5:  LD      HL,0A009h       ; Check remaining credits
;        XOR     A               ; Set A = 00
;        CP      (HL)            ; Any credits left?
;        JR      Z,L2BBE         ; No, skip ahead
;        DEC     (HL)            ; Subtract 1 credit
;        RET                     ; Return to main loop
;----------------------------------------------------
;             No credits, decrement timer 
;----------------------------------------------------        
L2B1C:  LD      BC,(0A05Eh)     ; BC = Read Delay Timer
        LD      HL,L0000        ; HL = 00
        AND     A               ; Clear carry
        SBC     HL,BC           ; HL = 00 - BC
        JR      NZ,L2B32        ; Timer not zero, skip ahead
;----------------------------------------------------
;                Sorry, time's up!!!
;----------------------------------------------------        
        CALL    L2823           ; HL = A030 (Player1)
        INC     HL              ; HL = A031 Player lives (Player1)
        LD      (HL),000h       ; Set lives to zero, game over
;----------------------------------------------------
;            Extra Routine not in rev D (DL1)
;----------------------------------------------------        
        POP     AF              ; Restore AF Register
        JP      L2356           ;
         
;----------------------------------------------------
;   Check Continue Game Timer, is time running out?
;----------------------------------------------------        
L2B32:  LD      HL,00040h       ; HL = 10 second
        AND     A               ; Clear carry
        SBC     HL,BC           ; Is timer less than 10 second?
        JR      C,L2B13         ; No, so keep looping
        LD      BC,(03812h)     ; Display Screen,"Time Expiring"
        CALL    L288E           ; SEARCH to frame
        JR      L2B13           ; Loop and wait for credit
        
        
        
;----------------------------------------------------
;      Display Pay-As-You-Go Instructions 
;      based on position in the game
;----------------------------------------------------
;   Controlled by (IY+02h) which is current Scene
;----------------------------------------------------        
L2B43:  LD      A,000h          ; A = index to proper instruction, always zero
        LD      HL,03837h       ; Point to 2-Coin Continue Instructions 
        JR      L2B4D           ; Skip over 1-Coin stuff
        LD      HL,0381Fh       ; Point to 1-Coin Continue Instructions (NOT USED)
L2B4D:  ADD     A,L             ; Add index A to get to correct instruction screen
        LD      L,A             ; L = A
        LD      A,000h          ; A = 0
        ADC     A,H             ; Add carry to the pointer
        LD      H,A             ; Store in pointer, HL points to Instructions
        LD      A,(IY+002h)     ; Get current scene, A = current scene
;----------------------------------------------------
;   "Congrats first section of Castle Adv, 2 coins"
;----------------------------------------------------        
        CP      094h            ; Is player on Falling Platform (easy)?
        JR      Z,L2B70         ; Yes, so jump ahead and display screen
        CP      0BCh            ; Is player on Falling Platform (difficult)?
        JR      Z,L2B70         ; Yes, so jump ahead and display screen
        INC     HL              ; Skip to next instruction screen
        INC     HL              ; Skip to next instruction screen
;----------------------------------------------------
;   "Congrats second section of Castle Adv, 2 coins"
;----------------------------------------------------        
        CP      09Eh            ; Is player on <MIRROR> Falling Platform (easy)?
        JR      Z,L2B70         ; Yes, so jump ahead and display screen
        CP      0C6h            ; Is player on <MIRROR> Falling Platform (difficult)?
        JR      Z,L2B70         ; Yes, so jump ahead and display screen
        INC     HL              ; Skip to next instruction screen
        INC     HL              ; Skip to next instruction screen
;----------------------------------------------------
;   "Congrats first Dragon's Lair Game, 2 coins"
;----------------------------------------------------        
        CP      0A4h            ; Is player on Singe's Lair (easy)?
        RET     NZ              ; No, so return (screen not displayed in DL1) 
        CP      0CCh            ; Is player on Singe's Lair (difficult)? 
        RET     NZ              ; No, so return (screen not displayed in DL1) 
;  Following commented lines appear in rev D, but not here (DL1)        
;----------------------------------------------------
;   "Again, complete game, deadlier challenge, 2 coins"
;----------------------------------------------------
;        CP      0FFh            ; Has player finished game twice?
;        RET     NZ              ; No, so just return        
;----------------------------------------------------
;         Search to Frame of Instructions        
;----------------------------------------------------
L2B70:  LD      C,(HL)          ; Get frame number for User Instructions
        INC     HL              ; Increment pointer
        LD      B,(HL)          ; Get frame number for User Instructions
        CALL    L288E           ; SEARCH to frame
        RET                     ; Return


   
;----------------------------------------------------
;            Increment Index to next level           
;----------------------------------------------------
L2B77:  LD      A,(0A012h)      ; Check current scene
        BIT     7,A             ; Are we in the middle of a scene?
        RET     Z               ; Yes, so just leave
        BIT     1,(IY+005h)     ; Does this scene force us to the next level?
        RET     NZ              ; No, so don't increment to the next level
        LD      HL,00006h       ; HL = 06
        ADD     HL,DE           ; HL = A036 (?)
        LD      A,(HL)          ; Get level
        INC     A               ; Go to next level
        OR      080h            ; Indicate that we're starting a new level
        LD      (0A012h),A      ; Update level number
        CALL    L28E1           ; Load Scene Data Index
        RET                     ; Return


   
;----------------------------------------------------
;  Save scene for replay later (A0C0-A0C7,A0C8-A0CF)
;----------------------------------------------------
;   Find next available RAM location to save scene #
;----------------------------------------------------
L2B91:  LD      HL,00090h       ; HL = DE(A030) + 90 (A0C0)
        ADD     HL,DE           ; HL = A0C0h
        LD      B,008h          ; Loop = 8
        LD      A,000h          ; Check for a blank spot
L2B99:  CP      (HL)            ; Is this spot blank?
        JR      NZ,L2BA1        ; No, so keep looping
        LD      A,(IY+002h)     ;
;  Following commented lines appear in rev D, but not here (DL1)        
;        PUSH    HL              ;
;        LD      HL,0005h        ;
;        ADD     HL,DE           ;
;        BIT     1,(HL)          ;
;        RES     1,(HL)          ;
;        JR      Z,L2C52         ;        
;        ADD     A,05h           ; 
;        POP     HL       
;----------------------------------------------------
;                Save scene in empty slot
;----------------------------------------------------        
        LD      (HL),A          ; Save scene which player died on
        RET                     ; Return 
;----------------------------------------------------
;    Continue looping until we find a blank spot
;----------------------------------------------------
L2BA1:  INC     HL              ; Go to next spot
        DJNZ    L2B99           ; Loop until all 8 spots checked     
        RET                     ; Return because all 8 spots are used


   
;----------------------------------------------------
;                  Level Check 
;----------------------------------------------------           
;    Jump here before starting each level to see if
;    Coins need to be inserted, difficulty increased,
;    Checks if resurrection scene is needed.
;----------------------------------------------------
L2BA5:  LD      A,(0A012h)      ; Get Scene index
        BIT     7,A             ; Is player at beginning of new level?
        RET     Z               ; No, so just return
        LD      HL,00005h       ; HL = 05
        ADD     HL,DE           ; HL = A035 (Difficulty)
;  Following commented lines appear in rev D, but not here (DL1)        
;        BIT     3,(HL)          ; Test for ???
;        JR      NZ,L2CE3        ; No, so check if Resurrection Scene is needed        
        BIT     5,(HL)          ; Must we complete scenes before entering lair?
        JR      NZ,L2BCD        ; Yes, so get scene that we died on previously
;----------------------------------------------------
;             Check if the Lair was reached
;----------------------------------------------------        
        LD      A,(0A012h)      ; Get current scene
        CP      0A4h            ; Is player on Singe's Lair (easy)?
        JR      Z,L2BBE         ; Yes, skip ahead
        CP      0CCh            ; Is player on Singe's Lair (difficult)?
        JR      NZ,L2BF4        ; No, so check if Resurrection Scene is needed
;----------------------------------------------------
;              We've reached the Lair!
;----------------------------------------------------        
L2BBE:  SET     5,(HL)          ; Scenes will now repeat until they are complete!
        LD      B,A             ;
        LD      HL,00006h       ;
        ADD     HL,DE           ;
        LD      C,(HL)          ;
        LD      HL,000A0h       ;
        ADD     HL,DE           ; DL1
        LD      (HL),B          ; DL1
        INC     HL              ; DL1!!!!!!!
        LD      (HL),C          ;
L2BCD:  LD      HL,00090h       ;
        ADD     HL,DE           ;
        LD      B,008h          ;
        XOR     A               ;
L2BD4:  CP      (HL)            ;
        JR      NZ,L2C0A        ;
        INC     HL              ;
        DJNZ    L2BD4           ;
        LD      HL,000A0h       ;
        ADD     HL,DE           ;
        LD      A,(HL)          ;
        LD      (0A012h),A      ;
        INC     HL              ;
        LD      A,(HL)          ;
        LD      HL,00030h       ;
        ADD     HL,DE           ;
        LD      (HL),A          ;
        LD      HL,00005h       ;
        ADD     HL,DE           ;
        RES     5,(HL)          ;
        RES     6,(HL)          ;
        
;  Following commented lines appear in rev D, but not here (DL1)        
;----------------------------------------------------
;  Clear out extra hard list? (A0A0-A0A4,A070-A074)
;----------------------------------------------------
;        LD      A,30h           ; Check which player
;        CP      E               ; Is it Player1?
;        JR      NZ,L2CD5        ; No so skip ahead
;        LD      HL,0A070h       ; Start at A070h Player1
;        JR      L2CD8           ; Jump ahead
;L2CD5:  LD      HL,0A0A0h       ; Start at A0A0h Player2
;L2CD8:  LD      B,05h           ; Loop =5
;        LD      A,00h           ; Clear with zero
;L2CDC:  LD      (HL),A          ; Erase location
;        INC     HL              ; Go to next location
;        DJNZ    L2CDC           ; Loop until all 5 locations erased
        
        
L2BF1:  CALL    L28E1           ; Load Scene Data Index
;----------------------------------------------------
;       Check if Resurrection Scene is needed
;----------------------------------------------------
L2BF4:  LD      HL,00005h       ; HL = 05
        ADD     HL,DE           ; HL = A035 (Difficulty)
        BIT     7,(HL)          ; Check if resurrection scene needs to be played
        RES     7,(HL)          ; Clear flag for resurrection scene
        RET     Z               ; Resurrection scene doesn't need to be played so return  
;----------------------------------------------------
;           Start at Resurrection Scene                   
;----------------------------------------------------
        LD      A,001h          ; Start at resurrection scene
        LD      (0A00Fh),A      ; Set first scene to resurrection scene
        RET                     ; Return


   
;----------------------------------------------------
;           -unused-
;----------------------------------------------------
        BIT     7,(HL)          ;
        RES     7,(HL)          ;
        RET     NZ              ;
        JR      L2BCD           ;
        
        
        
;----------------------------------------------------
;     Get scene that we died on and replay it.
;     Remove it from the list.
;----------------------------------------------------        
L2C0A:  LD      A,(HL)          ; Get assigned scene 
        LD      (0A012h),A      ; Save scene
        LD      (HL),000h       ; Clear out the scene from the list
        JR      L2BF1           ; Continue playing new scene
        
        
        
;----------------------------------------------------
;      Check Level Index, adjust player Difficulty
;----------------------------------------------------        
L2C12:  LD      A,(0A012h)      ;
        BIT     7,A             ;
        RET     Z               ;
        LD      HL,00005h       ;
        ADD     HL,DE           ;
        BIT     4,(HL)          ;
        RET     NZ              ;
        LD      HL,00007h       ;
        ADD     HL,DE           ;
        INC     (HL)            ;

;  Following commented lines appear in rev D, but not here (DL1)        
;        LD      A,(0A011h)      ; Get DIP Switch B
;        BIT     4,A             ; Test B4, Difficulty Increase
;        JR      Z,L2D1E         ; If B4 is ON, check for 5 levels
;        LD      A,09h           ; Survived 9 consecutive levels
;        JR      L2D20           ; Go to check
               
        LD      A,005h          ; Survived 5 consecutive levels
        CP      (HL)            ; Has player survived?
        RET     NZ              ; No, so return
;----------------------------------------------------
; Player survived required levels, increase Difficulty
;----------------------------------------------------        
        LD      HL,00005h       ; HL = 05
        ADD     HL,DE           ; HL = DE(A030)+05
        SET     4,(HL)          ; Set Bit 4 of A035
        RET                     ; Return


   
;----------------------------------------------------
;          Clear out Player Data A030-A3FF
;----------------------------------------------------
L2C2F:  LD      SP,0A3FFh       ; Set stack pointer
        LD      HL,0A030h       ;
        LD      DE,0A031h       ;
        LD      BC,003CFh       ;
        LD      (HL),000h       ;
        LDIR                    ;
        CALL    L2925           ;
        EI                      ;
        JP      L2093           ; Loop to Attract Mode
        
        
        
;----------------------------------------------------------------------
;                  (28) Magnetic Ball (continued) - NOT USED ?
;----------------------------------------------------------------------        
; jk data removed


        NOP                     ;
        NOP                     ;
        
        
;  Following commented lines appear in rev D, but not here (DL1)        
;----------------------------------------------------
;    Determine if Scene 3 in Level is to be played
;----------------------------------------------------
;L3000:  PUSH    HL
;        PUSH    BC
;        EXX     
;        LD      HL,0005h
;        ADD     HL,DE
;        PUSH    HL
;        EXX     
;        LD      A,(0A011h)      ; Check DIP Switch B
;        BIT     7,A             ; Test B7, Difficulty Level
;        JR      NZ,L3053        ; B7 OFF, so skip special scene       
;        LD      A,(0A010h)      ; Check DIP Switch A
;        BIT     2,A             ; Test A2, Game Begins Easy 
;        JR      NZ,L301D        ; A2 is OFF, pick a special scene       
;        POP     HL
;        PUSH    HL
;        BIT     4,(HL)
;        JR      Z,L3053         ; Skip special scene and return                 
;
;
;L301D:  LD      A,R             ; Pick a random number
;        AND     01h             ; Create 2 choices
;        CP      00h             ; Heads?
;        JR      NZ,L3053        ; No, it was tails so jump ahead      
;        EXX     
;        LD      A,30h           ; Check for Player1
;        CP      E               ; Is Player1 playing? (A030)
;        EXX     
;        JR      NZ,L3031        ; No, so jump to Player2
;        LD      HL,0A070h       ; Point to Player1 Extra Hard PlayList
;        JR      L3034           ; Skip ahead      
;L3031:  LD      HL,0A0A0h       ; Point to Player2 Extra Hard PlayList
;
;
;L3034:  LD      A,R             ; Pick a random number, (A)
;        AND     07h             ; Use only 3 bits of number
;L3038:  CP      05h             ; Is number greater than 5?
;        JR      C,L303F         ; No, so we can use it ahead      
;        DEC     A               ; A = A - 1, else decrement random number
;        JR      L3038           ; Loop back and see if number is usable
;              
;L303F:  LD      B,A             ; B = Random number, Extra Hard scene number
;        ADD     A,L             ; A = A + L
;        LD      L,A             ; L = A
;        XOR     A               ; A = 0
;        ADC     A,H
;        LD      H,A             ; HL = Special PlayList + Special Scene Number
;
;L3045:  LD      A,(HL)          ; Get Special PlayList byte
;        CP      00h             ; Has Special scene been played?
;        JR      Z,L3059         ; No, so skip ahead      
;        DEC     HL              ; Scene played, try to decrement Number 
;        LD      A,B
;        CP      00h             ; B = 0, All scenes played already?
;        JR      Z,L3053         ; Yes, so skip special scene      
;L3050:  DEC     B               ; B = B - 1
;        JR      L3045           ; Continue loop       
;
;
;----------------------------------------------------
;      Do not select special scene, just return
;----------------------------------------------------
;L3053:  POP     HL              ; Remove HL
;L3054:  POP     BC              ; Restore BC
;        POP     HL              ; Restore HL
;        JP      L2B34           ; Jump back to "normal" scene 3
;
;
;
;;----------------------------------------------------
;;   Mark special seen as played, get Scene Index from table
;;----------------------------------------------------
;L3059:  SET     7,(HL)          ; Mark Special scene as played
;        LD      A,B             ; A = Special Scene Number
;        POP     HL
;L305D:  SET     1,(HL)
;        POP     BC              ; Restore BC
;        POP     HL              ; Restore HL
;;----------------------------------------------------
;;   BC = Pointer to SPECIAL scene
;;   Special Scenes (D10INDEX - D14INDEX)
;;   Windy Hallway, Closing Wall, Room of Fire, Flying Horse, Black Knight
;;----------------------------------------------------
;        LD      BC,Special      ; Get "special" scene table 
;L3064:  ADD     A,C             ; A = A + C, Add Special Scene Number
;        LD      C,A             ; C = A
;        XOR     A               ; A = 0
;        ADC     A,B             ; A = A + B
;        LD      B,A             ; B = A, BC = BC + Special Scene Number
;L3069:  RET                     ; Return with BC pointer set
;
;
        


.END                                   