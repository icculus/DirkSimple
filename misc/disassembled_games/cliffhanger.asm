;
; (this file came from http://www.jeffsromhack.com/code/cliffhanger.htm   --ryan.)
;
;----------------------------------------------------
;      Disassembly of the file Cliffhanger ROMs
;        by Jeff Kulczycki and Robert Dinapoli
;                   Apr 12, 2000
;----------------------------------------------------
;                                                                     
;----------------------------------------------------
;    RAM VARIABLES
;----------------------------------------------------
;    Address      Description
;----------------------------------------------------
;   E000 - E007   High Score 1
;   E008 - E00F   High Score 2
;   E010 - E017   High Score 3
;   E018 - E01F   High Score 4 
;   E020 - E027   High Score 5
;   E028 - E02F   High Score 6
;   E030 - E037   High Score 7
;   E038 - E03F   High Score 8
;   E040 - E047   High Score 9
;   E048 - E04F   High Score 10
;   E050 - E052   High Score 1 Initials
;   E053 - E057   High Score 1
;   E058 - E05A   High Score 2 Initials
;   E05B - E05F   High Score 2
;   E060 - E062   High Score 3 Initials           
;   E063 - E067   High Score 3
;   E068 - E06A   High Score 4 Initials
;   E06B - E06F   High Score 4
;   E070 - E072   High Score 5 Initials
;   E073 - E077   High Score 5
;   E078 - E07A   High Score 6 Initials
;   E07B - E07F   High Score 6
;   E080 - E082   High Score 7 Initials
;   E083 - E087   High Score 7
;   E088 - E08A   High Score 8 Initials
;   E08B - E08F   High Score 8
;   E090 - E092   High Score 9 Initials
;   E093 - E097   High Score 9
;   E098 - E09A   High Score 10 Initials
;   E09B - E09F   High Score 10
;   E0A0 - E0A2   Total Plays
;   E0A3 - E0A4   Left Coin Slot Total
;   E0A5 - E0A6   Right Coin Slot Total
;   E0A7          Bookkeeping Counter (Coins)
;   E0A8 - E0AA   Total Play Time Seconds
;   E0AB - E0AD   Longest Game Seconds
;   E0AE          Shortest Game Seconds
;   E0AF          Highest Scene
;   E0B0          Bookkeeping Counter (Times)
;   E0B1 - E0B2   Range of Scores:    0 - 100K
;   E0B3 - E0B4   Range of Scores: 100K - 200K
;   E0B5 - E0B6   Range of Scores: 200K - 300K
;   E0B7 - E0B8   Range of Scores: 300K - 400K
;   E0B9 - E0BA   Range of Scores: 400K - 500K
;   E0BB - E0BC   Range of Scores: 500K - 600K
;   E0BD - E0BE   Range of Scores: 600K - 700K
;   E0BF - E0C0   Range of Scores: 700K - 800K
;   E0C1 - E0C2   Range of Scores: 800K - 900K
;   E0C3 - E0C4   Range of Scores: 900K - 1000K
;   E0C5 - E0C6   Range of Scores: 1000K - 1100K
;   E0C7 - E0C8   Range of Scores: 1100K - 1200K
;   E0C9 - E0CA   Range of Scores: 1200K - 1300K
;   E0CB - E0CC   Range of Scores: 1300K - 1400K
;   E0CD - E0CE   Range of Scores: 1400K+     
;   E0CF          Bookkeeping Counter (Range of Score)
;   E0D0 - E0D1   Times 0 - 1 minutes 
;   E0D2 - E0D3   Times 1 - 2 minutes
;   E0D4 - E0D5   Times 2 - 3 minutes 
;   E0D6 - E0D7   Times 3 - 4 minutes
;   E0D8 - E0D9   Times 4 - 5 minutes 
;   E0DA - E0DB   Times 5 - 6 minutes
;   E0DC - E0DD   Times 6 - 7 minutes 
;   E0DE - E0DF   Times 7 - 8 minutes
;   E0E0 - E0E1   Times 8 - 9 minutes 
;   E0E2 - E0E3   Times 9 - 10 minutes
;   E0E4 - E0E5   Times 10 - 11 minutes 
;   E0E6 - E0E7   Times 11 - 12 minutes
;   E0E8 - E0E9   Times 12 - 13 minutes 
;   E0EA - E0EB   Times 13 - 14 minutes
;   E0EC - E0ED   Times 14+ minutes
;   E0EE          Bookkeeping Counter (Range of Times)
;   E0EF - E0F0   Scene 1 Totals
;   E0F1 - E0F2   Scene 2 Totals
;   E0F3 - E0F4   Scene 3 Totals
;   E0F5 - E0F6   Scene 4 Totals
;   E0F7 - E0F8   Scene 5 Totals
;   E0F9 - E0FA   Scene 6 Totals
;   E0FB - E0FC   Scene 7 Totals
;   E0FD - E0FE   Scene 8 Totals
;   E0FF          Bookkeeping Counter (Scene Totals)
;   E100 - E10B   ? 
;   E10D          Bookkeeping Counter <--?
;   E112          LDPlayer Pulse, kick when frame count is received
;   E113          unknown
;   E114          unknown
;   E115          Graphics Status (00h = Available, 4Ch = Write Requested)
;   E116 - E118   Odd  Frame Count Target
;   E119 - E11B   Even Frame Count Target
;   E11C - E11E   Frame Count Even
;   E11F - E121   Frame Count Odd
;   E122          errors?
;   E123          errors?
;   E126  .0      unknown
;         .1      LDPlayer Status      0=Not BUSY, 1=BUSY
;         .2      unknown
;         .3      unknown
;         .4      PAUSE Status         0=Not PAUSED, 1=PAUSED
;         .5      Audio Channel Right  0=ON, 1=OFF
;         .6      Audio Channel Left   0=ON, 1=OFF
;   E127 - E12A   Temporary Aritmetic Location E127:MSB...E12A:LSB
;   E12F - E136   Graphics Chip Control Registers
;   E137          Graphics index
;   E138          Graphics index
;   E13B - E13C
;   E13E - E13F   Hardware Errors
;   E140 - E145   Timer?
;   E15A          unknown
;   E15B          unknown
;   E15E          unknown
;   E16E - E16F   LaserDisc Errors
;   E170 - E172   Frame Count Slop Error
;   E174          unknown
;   E17A          Seconds Timer
;   E180 - E182   Frame Number compare 
;   E183          BANK 0:  ZPU Switches  1,2
;   E184 - E185   BANK 0:  ZPU Switches  1,2   Debounce
;   E186          BANK 1:  DIP Switches 28-35
;   E187 - E188   BANK 1:  DIP Switches 28-35  Debounce
;   E189          BANK 2:  DIP Switches 20-27
;   E18A - E18B   BANK 2:  DIP Switches 20-27  Debounce
;   E18C          BANK 3:  DIP Switches 12-19
;   E18D - E18E   BANK 3:  DIP Switches 12-19  Debounce
;   E18F          BANK 4:  DIP Switches  4-11
;   E190 - E191   BANK 4:  DIP Switches  4-11  Debounce
;   E192          BANK 5:  Button Data 
;   E193 - E194   BANK 5:  Button Data Debounce Buffer
;   E195          BANK 6:  Joystick Data
;   E196 - E197   BANK 6:  Joystick Data Debounce Buffer
;   E198          BANK 7:  unknown
;   E199 - E19A   BANK 7:  unknown  Debounce
;   E19B          BANK 8:  unknown
;   E19C - E19D   BANK 8:  unknown  Debounce
;   E19E          BANK 9:  unknown 
;   E19F - E1A0   BANK 9:  unknown  Debounce
;   E1A1          Coins Inserted Left
;   E1A2          Coins Inserted Right
;   E1A3          Coins?
;   E1A6
;   E1A8          Number of Credits 
;   E1A9          Player Number
;   E1AA - E1AD   Score
;   E1AE          Lives remaining
;   E1B1          unknown - frame?
;   E1B6          Current Scene Number
;   E1BB - E1BC   Scene Pointer
;   E1C4 - E1C6   Minutes (BCD) Real-time Game Play Timer
;   E1C7 - E1E4   Swap with E1A7-E1C6
;   E1E5          ?
;   E1E6          Service Mode selection
;----------------------------------------------------
;   E000 - E800   Bookkeeping RAM ?
;   E800-         Scratch RAM ?
;----------------------------------------------------
;
;----------------------------------------------------
;               BEGIN FIRST ROM 0000-1FFF
;----------------------------------------------------
        org     0000h
        CPU     = Z180
        globals on

;----------------------------------------------------
;         Definitions
;----------------------------------------------------
;  Pixel Byte Colors
;     0h   TRANSPARENT  
;     1h   BLACK        
;     2h   MED GREEN
;     3h   LT GREEN
;     4h   BLUE         
;     5h   LT BLUE   
;     6h   DK RED
;     7h   CYAN
;     8h   MED RED
;     9h   PINK
;     Ah   DK YELLOW
;     Bh   LT YELLOW
;     Ch   DK GREEN
;     Dh   PURPLE
;     Eh   GRAY
;     Fh   WHITE




;----------------------------------------------------
;                   Reset
;----------------------------------------------------
L0000:  IN      A,(055h)        ; Read Graphics Byte
        LD      SP,0F000h       ; Set Stack Pointer
        DI                      ; Disable Interrupts
        IM      1               ; Interrupt Mode 1
        JP      L0300           ; Start Initialization
L000B:  JP      L0128           ; Begin Game


;----------------------------------------------------
;        ROM 0 - Copyright location
;----------------------------------------------------
L000E: TEXT "COPYRIGHT STERN ELECTRONICS, INC."

        DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        DB   0FFh, 0FFh, 0FFh, 0FFh






;----------------------------------------------------
;             IM 1 INTERRUPT JUMP POINT
;----------------------------------------------------
;    Read in Frame Counter from LDPlayer Interface
;       E11C-E11E = Even Frame Count
;       E11F-E121 = Odd Frame Count
;----------------------------------------------------
L0038:  OUT     (057h),A        ;
        PUSH    AF              ; Save AF Register
        PUSH    HL              ; Save HL Register
        LD      HL,0E112h       ; LDPlayer Pulse
        INC     (HL)            ; Kick the LDPlayer Pulse
        BIT     0,(HL)          ; Check if Pulse even or odd
        LD      HL,0E11Ch       ; Load Frame Count Spot for Even
        JP      Z,L004B         ; Skip Odd Count
        LD      HL,0E11Fh       ; Load Frame Count Spot for Odd
L004B:  IN      A,(052h)        ; Retrieve MSB Frame Count byte
        LD      (HL),A          ; Store in Frame Count Spot
        CPL                     ; Reverse all bits
        AND     0F8h            ; Is LDPlayer BUSY?
        JP      NZ,L005C        ; Yes, LDPlayer BUSY so skip
        INC     HL              ; Point to next location
        IN      A,(051h)        ; Retrieve next Frame Count byte
        LD      (HL),A          ; Store in Frame Count Spot
        INC     HL              ; Point to next location
        IN      A,(050h)        ; Retrieve LSB Frame Count byte
        LD      (HL),A          ; Store in Frame Count Spot
L005C:  EI                      ; Enable Interrupts
        IN      A,(053h)        ;
        EX      (SP),IX         ;
        EX      (SP),IX         ;
        POP     HL              ; Restore HL Register
L0064:  POP     AF              ; Restore AF Register
        RET                     ; Return







;----------------------------------------------------
;         NMI Non-Maskable Interrupt Routine
;      Occurs every 1 second
;----------------------------------------------------
L0066:  PUSH    AF              ; Save AF Register
        EX      AF,AF'          ; Get AF' Register
        PUSH    AF              ; Save AF' Register
        PUSH    BC              ; Save BC Register
        PUSH    DE              ; Save DE Register
        PUSH    HL              ; Save HL Register
L006C:  PUSH    IX              ; Save IX Reigster
        LD      A,I             ; Are interrupts disabled?
        JP      PO,L0076        ; Yes, so skip Frame Count Retrieval
        CALL    L6631           ; Retrieve Frame Count 
L0076:  CALL    L2465           ; Read Joystick and Button Data
        CALL    L1162           ; Check Coin Slots
        CALL    L0103           ; Update Real-time Game Play Tiemr

        LD      A,(0E125h)      ;
L0082:  OR      A               ;
        LD      A,(0E113h)      ;
        RES     1,A             ;
        LD      B,A             ;
        LD      A,(0E114h)      ;
        RES     0,A             ;
        JR      Z,L0098         ;        
        LD      HL,0E125h       ;
        DEC     (HL)            ;
        SET     0,A             ;
        SET     1,B
L0098:  OUT     (046h),A
        LD      (0E114h),A
        LD      A,B
        OUT     (064h),A
        LD      (0E113h),A
        LD      A,(0E110h)
        OR      A
        LD      A,(0E113h)
        RES     2,A
        LD      B,A
        LD      A,(0E114h)
        RES     1,A
        JR      Z,L00BC                 
        LD      HL,0E110h
        DEC     (HL)
        SET     1,A
        SET     2,B
L00BC:  OUT     (046h),A
        LD      (0E114h),A
        LD      A,B
        OUT     (064h),A
        LD      (0E113h),A
;----------------------------------------------------
;       Flash LED to show board is operational
;----------------------------------------------------
        LD      HL,0E111h
        INC     (HL)
        BIT     0,(HL)          ; Test odd/even
        JR      Z,L00D3         ; Even so skip ahead                   
        OUT     (06Fh),A        ; Turn LED on
        JR      L00D5           ; Skip ahead
L00D3:  OUT     (06Eh),A        ; Turn LED off
;----------------------------------------------------
;            Check for Game Tilted
;----------------------------------------------------
L00D5:  LD      A,(0E193h)      ; Get Button Data
        BIT     7,A             ; Is game Tilted?
        CALL    NZ,L2509        ; Yes, do Tilt scene
;----------------------------------------------------
;       Process Graphics Chip Write Requests
;----------------------------------------------------
        IN      A,(055h)        ; Read Graphics Byte
        LD      A,(0E115h)      ; Get Graphics Status
        CP      04Ch            ; Is there a Write Request?
        CALL    Z,L2316         ; Yes, so Write Graphics Registers

        LD      A,(0E126h)      ; Get Control Register
        BIT     0,A             ;
        JP      Z,L00F4         ;
        LD      A,I             ;
        CALL    PE,L1DFA        ;
L00F4:  POP     IX              ; Restore IX Register
        POP     HL              ; Restore HL Register
        POP     DE              ; Restore DE Register
        POP     BC              ; Restore BC Register
        POP     AF              ; Restore AF' Register
        EX      AF,AF'          ; Save AF'
        POP     AF              ; Restore AF Register
        RETN                    ; Return from NMI









;----------------------------------------------------
;            Get ?
;----------------------------------------------------
L00FE:  IN      A,(055h)        ; Read Graphics Byte
        POP     AF              ;
        RETN                    ; Return
                                






;----------------------------------------------------
;         Update Real-time Game Play Timer
;----------------------------------------------------
;         E17A       Seconds Counter
;         E1C4-E1C6  Minutes (BCD)
;---------------------------------------------------- 
L0103:  LD      A,(0E126h)      ; Get Control Register
        BIT     0,A             ; Check if game is playing
        RET     NZ              ; Game not playing so leave
        LD      HL,0E17Ah       ; Get Number of seconds
        DEC     (HL)            ; Count down seconds
        RET     NZ              ; Not zero so return
        LD      A,03Ch          ; A = 60 seconds
        LD      (HL),A          ; Reset second counter
        LD      HL,0E1C6h       ; Point to Timer
        LD      A,(HL)          ; Get minutes (ones)
        ADD     A,001h          ; Add one minute
        DAA                     ; Make BCD
        LD      (HL),A          ; Store minute (ones)
        RET     NZ              ; Return if not rolled
        DEC     HL              ; Point to minutes (tens)
        LD      A,(HL)          ; Get minutes (tens)
        ADD     A,001h          ; Increment tens spot
        DAA                     ; Make BCD
        LD      (HL),A          ; Store minutes (tens)
        RET     NZ              ; Return if not rolled
        DEC     HL              ; Point to minutes (hundreds)
        LD      A,(HL)          ; Get minutes (hundreds)
        ADD     A,001h          ; Increment hundreds spot
        DAA                     ; Make BCD
        LD      (HL),A          ; Store minutes (hundreds)
        RET                     ; Return







;----------------------------------------------------
;         Game Power up and Initialization 
;----------------------------------------------------
;  Set Stack Pointer, Clear out Scratch RAM E800-EFFF 
;---------------------------------------------------- 
L0128:  LD      SP,0F000h       ; Set Stack Pointer
;----------------------------------------------------
;              Clear out RAM E800-EFFF 
;---------------------------------------------------- 
        XOR     A               ; A = 0
        LD      BC,007FFh       ; RAM length 7FFh
        LD      DE,0E801h       ; Setup Loop
        LD      HL,0E800h       ; Start of RAM
        LD      (HL),A          ; Clear out RAM spot
        LDIR                    ; Loop until all RAM cleared
;----------------------------------------------------
;              Clear out RAM E10E-E7FF 
;----------------------------------------------------
        XOR     A               ; A = 0
        LD      BC,007FFh       ; RAM length 7FFh
        LD      DE,0E10Fh       ; Setup Loop
        LD      HL,0E10Eh       ; Start of RAM
        LD      (HL),A          ; Clear out RAM spot
        LDIR                    ; Loop until all RAM cleared
         
;----------------------------------------------------
;              Clear out variables 
;----------------------------------------------------
        LD      (0E1A8h),A      ; Zero out Number of Credits
        LD      (0E113h),A      ; 
        OUT     (06Eh),A        ; 
        LD      (0E12Eh),A      ; 
;----------------------------------------------------
;            Set Game Register settings
;----------------------------------------------------
        SET     5,A             ; Start with Audio Right Disabled  
        SET     6,A             ; Start with Audio Left Disabled
        SET     0,A             ; 
        SET     3,A             ; 
        LD      (0E126h),A      ; Save Control Register
        LD      A,014h          ; A = 20
        LD      (0E121h),A      ; 
        CALL    L24A7           ; Read DIP Switches
        CALL    L1F05           ; Clear out Player Data
        LD      A,(0E18Ch)      ; Get DIP Switches 12-19
        BIT     0,A             ; Check if Service Mode Enable
        JP      NZ,L40FE        ; Service Mode enabled, jump ahead
        EI                      ; Enable Interrupts
        JP      L053D           ; Goto PLEASE STAND BY startup





;----------------------------------------------------
;                 Garbage
;----------------------------------------------------
        DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh        
        DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh        
        DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh        
        DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh        
        DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh        
        DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh        
        DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh        
        DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh        
        DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh        
        DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
        .DB   0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh





;----------------------------------------------------
;         Start of initialization - Z80 Test
;----------------------------------------------------
L0300:  XOR     A               ; A = 0
        OUT     (06Eh),A        ; Turn LED off
        OUT     (046h),A        ; Turn BEEP off
;----------------------------------------------------
;            Verify Stack Register
;----------------------------------------------------
        LD      SP,055AAh       ; Set Stack = 55AAh
        LD      HL,0AA56h       ; HL = AA56h
        ADD     HL,SP           ; Add together to get zero
        LD      A,H             ; Get result
        OR      L               ; Check if zero
L030E:  JR      NZ,L030E        ; Not zero, so don't continue

;----------------------------------------------------
;    Set all Registers to the same value and 
;    check register accuracy (BC,DE,HL).
;----------------------------------------------------
;            Verify Register ODD bits
;----------------------------------------------------
        LD      A,055h          ; A = 55h  
        LD      BC,05555h       ; B = 55h, C = 55h
        LD      DE,05555h       ; D = 55h, E = 55h
        LD      HL,05555h       ; H = 55h, L = 55h

        CP      B               ; Is B Register correct?
L031C:  JR      NZ,L031C        ; No, so don't continue
        CP      C               ; Is C Register correct?
L031F:  JR      NZ,L031F        ; No, so don't continue       
        CP      D               ; Is D Register correct?
L0322:  JR      NZ,L0322        ; No, so don't continue
        CP      E               ; Is E Register correct?
L0325:  JR      NZ,L0325        ; No, so don't continue
        CP      H               ; Is H Register correct?
L0328:  JR      NZ,L0328        ; No, so don't continue
        CP      L               ; Is L Register correct?
L032B:  JR      NZ,L032B        ; No, so don't continue

;----------------------------------------------------
;            Verify Register EVEN bits
;----------------------------------------------------
        LD      A,0AAh          ; A = AAh  Check EVEN bits
        LD      BC,0AAAAh       ; B = AAh, C = AAh
        LD      DE,0AAAAh       ; D = AAh, E = AAh
        LD      HL,0AAAAh       ; H = AAh, L = AAh

        CP      B               ; Is B Register correct?
L0339:  JR      NZ,L0339        ; No, so don't continue      
        CP      C               ; Is C Register correct?
L033C:  JR      NZ,L033C        ; No, so don't continue      
        CP      D               ; Is D Register correct?
L033F:  JR      NZ,L033F        ; No, so don't continue      
        CP      E               ; Is E Register correct?
L0342:  JR      NZ,L0342        ; No, so don't continue      
        CP      H               ; Is H Register correct?
L0345:  JR      NZ,L0345        ; No, so don't continue      
        CP      L               ; Is L Register correct?
L0348:  JR      NZ,L0348        ; No, so don't continue       

;----------------------------------------------------
;        Verify Prime Register ODD bits
;----------------------------------------------------
        EX      AF,AF'          ; Exchange Registers
        EXX                     ; Exchange Register
        LD      A,055h          ; A = 55h
        LD      BC,05555h       ; B = 55h, C = 55h
        LD      DE,05555h       ; D = 55h, E = 55h
        LD      HL,05555h       ; H = 55h, L = 55h

        CP      B               ; Is B Register correct?
L0358:  JR      NZ,L0358        ; No, so don't continue       
        CP      C               ; Is C Register correct?
L035B:  JR      NZ,L035B        ; No, so don't continue
        CP      D               ; Is D Register correct?
L035E:  JR      NZ,L035E        ; No, so don't continue
        CP      E               ; Is E Register correct?
L0361:  JR      NZ,L0361        ; No, so don't continue
        CP      H               ; Is H Register correct?
L0364:  JR      NZ,L0364        ; No, so don't continue
        CP      L               ; Is L Register correct?
L0367:  JR      NZ,L0367        ; No, so don't continue

;----------------------------------------------------
;        Verify Prime Register EVEN bits
;----------------------------------------------------
        LD      A,0AAh          ; A = AAh  Check EVEN bits
        LD      BC,0AAAAh       ; B = AAh, C = AAh
        LD      DE,0AAAAh       ; D = AAh, E = AAh
        LD      HL,0AAAAh       ; H = AAh, L = AAh

        CP      B               ; Is B Register correct?
L0375:  JR      NZ,L0375        ; No, so don't continue      
        CP      C               ; Is C Register correct?
L0378:  JR      NZ,L0378        ; No, so don't continue       
        CP      D               ; Is D Register correct?
L037B:  JR      NZ,L037B        ; No, so don't continue       
        CP      E               ; Is E Register correct?
L037E:  JR      NZ,L037E        ; No, so don't continue       
        CP      H               ; Is H Register correct?
L0381:  JR      NZ,L0381        ; No, so don't continue       
        CP      L               ; Is L Register correct?
L0384:  JR      NZ,L0384        ; No, so don't continue

;----------------------------------------------------
;         Verify IX, IY Index ODD bits
;----------------------------------------------------              
        LD      BC,05555h       ; B = 55h, C = 55h
        LD      IX,05555h       ; IX = 5555h
        LD      IY,05555h       ; IY = 5555h
        LD      DE,00397h       ; DE = Address of next test (EVEN Bits)
        JP      L0483           ; Jump to Z80 Register Test





;----------------------------------------------------
;         Verify IX, IY Index EVEN bits
;----------------------------------------------------
L0397:  LD      BC,0AAAAh       ; B = AAh, C = AAh
        LD      IX,0AAAAh       ; IX = AAAAh
        LD      IY,0AAAAh       ; IY = AAAAh
        LD      DE,003A8h       ; DE = Address of next test (LED/BEEP Test)
        JP      L0483           ; Jump to Z80 Register Test





;----------------------------------------------------
;                Go to Next Test
;----------------------------------------------------
L03A8:  LD      IX,003AFh       ; IX = Address of next test (ROM Verify)
        JP      L045B           ; Flash LED and BEEP, do next test





;----------------------------------------------------
;       Perform Diagnostic ROM Check
;----------------------------------------------------
L03AF:  LD      BC,00400h       ; BC = Start of COPYRIGHT pointers
        EXX                     ; EXX (Prime)
        LD      HL,L0000        ; HL' = 0
L03B6:  EXX                     ; EXX (Norm)
        LD      A,(BC)          ; Get first byte in table
        INC     BC              ; Point to next byte
        LD      E,A             ; E = LSB address byte
        LD      A,(BC)          ; Get next byte
        INC     BC              ; Point to next byte
        LD      D,A             ; D = MSB address byte
        OR      E               ; All Copyrights read?
        JR      Z,L040C         ; Yes, so jump ahead next test (Scratch RAM)

;----------------------------------------------------
;       DE = Pointer to Copyright Message
;----------------------------------------------------
        EXX                     ; EXX (Prime)
        LD      BC,02000h       ; BC' = Length of ROM 2K
        LD      A,(HL)          ; A = ROM byte
        LD      D,A             ; Save ROM byte temporarily D'
;----------------------------------------------------
;            HL = HL' (ROM location pointer)
;----------------------------------------------------
        LD      A,H             ; A   = H
        EXX                     ; EXX (Norm)
        LD      H,A             ; H = A = H'
        EXX                     ; EXX (Prime)
        LD      A,L             ; A = L' 
        EXX                     ; EXX (Norm)
        LD      L,A             ; L = A = L'
;----------------------------------------------------
        OR      A               ; Clear carry
        SBC     HL,DE           ; Subtract Copyright Address
        EXX                     ; EXX (Prime)
        LD      A,D             ; A = CHECKSUM byte
        JR      NZ,L03E9        ; Copyright reached, skip remaining bytes
        INC     HL              ; Point to next ROM byte
        DEC     BC              ; Decrement byte count loop
        LD      A,(HL)          ; A = CHECKSUM (First Byte)
        JR      L03E9           ; Jump ahead       
;----------------------------------------------------
;                    HL = HL'
;----------------------------------------------------
L03D9:  LD      D,A             ; Save CHECKSUM byte temporarily D'
        LD      A,H             ; A = H'
        EXX                     ; EXX (Norm)
        LD      H,A             ; H = A = H'
        EXX                     ; EXX (Prime)
        LD      A,L             ; A = L'
        EXX                     ; EXX (Norm)
        LD      L,A             ; L = A = L'
;----------------------------------------------------
        OR      A               ; Clear carry
        SBC     HL,DE           ; Check if we've reached Copyright Address
        EXX                     ; EXX (Prime)
        LD      A,D             ; Retreive CHECKSUM byte from D'
        JR      Z,L03E9         ; Copyright reached, skip remaining bytes
        XOR     (HL)            ; Exclusive OR CHECKSUM 
L03E9:  INC     HL              ; Point to next ROM byte
        DEC     C               ; Decrement byte count loop, C
        JR      NZ,L03D9        ; Loop not done so continue looping
        DJNZ    L03D9           ; Continue loop until all 2K bytes checked

        EXX                     ; EXX (Norm)
        EX      DE,HL           ; HL = DE
L03F1:  XOR     05Ah            ; Toggle Bits 01011010
        LD      (HL),A          ;
        CP      (HL)            ;
        JR      NZ,L03F1        ; Checksum incorrect, just loop                
        EX      DE,HL           ;
        EXX                     ; EXX (Prime)
        LD      IX,003B6h       ; IX = Address of next test (Next ROM)
        JP      L045B           ; Flash LED and BEEP, do next test





;----------------------------------------------------
;   Message Pointers "COPYRIGHT: STERN ELECTRONICS, INC."
;----------------------------------------------------
L0400:  .DW   012CDh   ; ROM0 Copyright Message location
        .DW   036E1h   ; ROM1 Copyright Message location 
        .DW   0582Ch   ; ROM2 Copyright Message location
        .DW   0660Eh   ; ROM3 Copyright Message location
        .DW   08927h   ; ROM4 Copyright Message location
        .DW   00000h   ; end 
    





;----------------------------------------------------
;              Scratch RAM Test
;----------------------------------------------------
L040C:  LD      HL,0E800h       ; HL = Start of Scratch RAM
        LD      DE,00800h       ; DE = Number of RAM bytes to test
        LD      IX,00419h       ; IX = Address of next test (BEEP)
        JP      L049B           ; Jump to RAM Test



;----------------------------------------------------
;     Flash LED and BEEP Begin Bookkeeping RAM Test
;----------------------------------------------------
L0419:  LD      IX,00420h       ; IX = Address of next test (Bookkeeping RAM)
        JP      L045B           ; Flash LED and BEEP, do next test





;----------------------------------------------------
;               Bookkeeping RAM Test
;----------------------------------------------------
;  Temporarily save Bookkeeping data while the 
;  RAM locations are being tested.
;----------------------------------------------------
L0420:  LD      HL,0E000h       ; HL = Source
        LD      DE,0E800h       ; DE = Destination
        LD      BC,00800h       ; BC = Number of bytes to copy
        LDIR                    ; Copy RAM locations

        LD      HL,0E000h       ; HL = Start of RAM
        LD      DE,00800h       ; DE = Number of RAM bytes to test
        LD      IX,00438h       ; IX = Address of next test (Restore RAM)  
        JP      L049B           ; Jump to RAM Test




;----------------------------------------------------
;    Restore Bookkeeping RAM back into its place
;----------------------------------------------------
L0438:  LD      HL,0E800h       ; HL = Source
        LD      DE,0E000h       ; DE = Destination
        LD      BC,00800h       ; BC = Number of bytes to copy
        LDIR                    ; Copy RAM locations
        LD      IX,L044A        ; IX = Address of next test (Video RAM)
        JP      L045B           ; Flash LED and BEEP, do next test



;----------------------------------------------------
;            Start Video RAM Test
;----------------------------------------------------
L044A:  LD      IX,L0451        ; IX = Address of next test (below)
        JP      L04C2           ; Jump to Video RAM Test



;----------------------------------------------------
;         Flash LED and BEEP, go to end of test
;----------------------------------------------------
L0451:  LD      IX,L0458        ; IX = Address to end of test
        JP      L045B           ; Flash LED and BEEP, do next test



;----------------------------------------------------
;               Testing Complete
;----------------------------------------------------
L0458:  JP      L000B           ; Testing complete, now return








;----------------------------------------------------
;       Flash LED and BEEP
;       IX = Address of next diagnostic test
;----------------------------------------------------
L045B:  OUT     (06Eh),A        ; Turn LED off
        XOR     A               ; A = 0
        OUT     (046h),A        ; Turn BEEP off
;----------------------------------------------------
;          Perform Delay = FFFFh
;----------------------------------------------------
        LD      BC,L0000        ; Setup delay value = FFFFh
L0463:  DEC     BC              ; Decrement delay
        LD      A,B             ; Get delay value
        OR      C               ; Check if delay finished
        JR      NZ,L0463        ; Delay not finished so continue loop       
;----------------------------------------------------
;             Turn on LED
;----------------------------------------------------
        OUT     (06Fh),A        ; Turn LED on
        LD      A,003h          ; A = 3
        OUT     (046h),A        ; Enable BEEP
;----------------------------------------------------
;          Perform Delay = 4000h
;----------------------------------------------------
        LD      BC,04000h       ; Setup delay value BC = 4000h
L0471:  DEC     BC              ; Decrement delay
        LD      A,B             ; Get delay value
        OR      C               ; Check if delay finished
        JR      NZ,L0471        ; Delay not finished so continue loop        
;----------------------------------------------------
;            Turn off LED
;----------------------------------------------------
        XOR     A               ; A = 0
        OUT     (046h),A        ; Turn BEEP OFF
;----------------------------------------------------
;          Perform Delay = C000h
;----------------------------------------------------
        LD      BC,0C000h       ; Setup delay value BC = C000h
L047C:  DEC     BC              ; Decrement delay
        LD      A,B             ; Get delay value
        OR      C               ; Check if delay finished
        JR      NZ,L047C        ; Delay not finished so continue loop       
;----------------------------------------------------
;       Test complete, jump to next test
;----------------------------------------------------
        JP      (IX)            ; Jump to next test








;----------------------------------------------------
;       Z80 Register Verification Test
;        BC = IX = IY = Test Value
;        DE = Address of next test
;----------------------------------------------------
L0483:  LD      HL,L0000        ; Clear HL Register for use
        LD      SP,IX           ; SP = IX Register
        ADD     HL,SP           ; Add zero to SP
        OR      A               ; Clear carry
        SBC     HL,BC           ; Test if BC equal IX
L048C:  JR      NZ,L048C        ; Register fault, so don't continue      
        LD      HL,L0000        ; Clear HL Register for use
        LD      SP,IY           ; SP = IY Register
        ADD     HL,SP           ; Add zero to SP
        OR      A               ; Cleary carry
        SBC     HL,BC           ; Test if BC equal IY
L0497:  JR      NZ,L0497        ; Register fault, so don't continue
        EX      DE,HL           ; Get Address of next test
        JP      (HL)            ; Jump to the next test








;----------------------------------------------------
;    RAM Test - Write then Read all RAM locations
;          HL = Start of RAM test
;          DE = Number of RAM bytes
;----------------------------------------------------
L049B:  XOR     A               ; A = 0
        SCF                     ; Set Carry Flag
L049D:  EX      AF,AF'          ; Save Test pattern AF
;----------------------------------------------------
;      Write Test Bit to (BC) RAM bytes
;----------------------------------------------------
        LD      B,D             ; Move Number of bytes into BC
        LD      C,E             ; ...BC = DE
L04A0:  EX      AF,AF'          ; Get Test Bit AF
        LD      (HL),A          ; Write Test Bit to RAM location
        INC     HL              ; Point to next RAM location
        RLA                     ; Shift Test Bit Left every time
        EX      AF,AF'          ; Save Test Bit AF
        DEC     BC              ; Decrement byte count (loop)
        LD      A,B             ; Check loop value
        OR      C               ; Are all bytes checked? (BC=0?)
        JR      NZ,L04A0        ; No, continue until all bytes written
               
;----------------------------------------------------
;      Read Test Bit from (BC) RAM bytes
;----------------------------------------------------
        LD      B,D             ; Move Number of bytes into BC
        LD      C,E             ; ...BC = DE                        
L04AC:  DEC     HL              ; Point to previous RAM location
        EX      AF,AF'          ; Get Test Bit AF
        RRA                     ; Shift Test Bit Right every time
        CP      (HL)            ; Is RAM location read correctly?
L04B0:  JR      NZ,L04B0        ; No, RAM is bad so don't continue
        OR      A               ; Has Test Bit rolled?
        JR      NZ,L04B6        ; No, so skip ahead        
        SCF                     ; Set Carry flag (Test Bit)
L04B6:  EX      AF,AF'          ; Save Test Bit AF
        DEC     BC              ; Decrement byte count loop
        LD      A,B             ; Check Loop Value
        OR      C               ; Are all bytes checked?
        JR      NZ,L04AC        ; No, so continue looping
             
;----------------------------------------------------
;      Move to next bit and repeat RAM Test
;----------------------------------------------------               
        EX      AF,AF'          ; Get Test Bit
        RLA                     ; Shift Test Bit Left
        JR      NC,L049D        ; Loop back until all bits tested
        JP      (IX)            ; Jump to next test







;----------------------------------------------------
;               Video RAM Test 1K
;----------------------------------------------------
L04C2:  XOR     A               ; A = 0
        LD      (0E115h),A      ; Clear Graphics Chip Write Request
        LD      SP,0F000h       ; Setup Stack Pointer
        LD      A,046h          ; Text = DK_BLUE, Bkgnd = DK_RED
        CALL    L20CA           ; Setup Graphics Chip for Text
        LD      HL,000FFh       ;
        LD      DE,055AAh       ;
        LD      B,008h          ;
L04D6:  PUSH    BC              ; Save BC Register
        PUSH    HL              ; Save HL Register 
        PUSH    DE              ; Save DE Register
        LD      HL,00000h       ; Cursor Position (X=0,Y=0)
        CALL    L2334           ; Set Text Cursor Position
        POP     DE              ; Restore DE Register
        POP     HL              ; Restore HL Register           
        LD      BC,01000h       ; BC = Loop 1K of RAM
L04E4:  LD      A,H             ;
        OUT     (044h),A        ;
        PUSH    AF              ;
        POP     AF              ;
        LD      A,L             ;
        OUT     (044h),A        ;
        PUSH    AF              ; 
        POP     AF              ;
        LD      A,D             ;
        OUT     (044h),A        ;
        PUSH    AF              ;
        POP     AF              ;
        LD      A,E             ;
        OUT     (044h),A        ;
        PUSH    AF              ;
        POP     AF              ;
        DEC     BC              ;
        LD      A,B             ;
        OR      C               ;
        JR      NZ,L04E4        ;        

        PUSH    HL              ; Save HL Register
        PUSH    DE              ; Save DE Register
        LD      HL,L0000        ; Cursor Position (X=0,Y=0)
        CALL    L2343           ; Set Text Cursor Position
        POP     DE              ; Restore DE Register
        POP     HL              ; Restore HL Register  

        LD      BC,01000h       ; BC = Loop 1K RAM
L050A:  PUSH    AF              ;
        POP     AF              ;
        IN      A,(045h)        ;
        CP      H               ;
L050F:  JR      NZ,L050F        ;       
        PUSH    AF              ;
        POP     AF              ;
        IN      A,(045h)        ;
        CP      L               ;
L0516:  JR      NZ,L0516        ;       
        PUSH    AF
        POP     AF
        IN      A,(045h)
        CP      D
L051D:  JR      NZ,L051D               
        PUSH    AF
        POP     AF
        IN      A,(045h)
        CP      E
L0524:  JR      NZ,L0524               
        DEC     BC
        LD      A,B
        OR      C
        JR      NZ,L050A                
        LD      A,H             ;
        LD      H,L             ;
        LD      L,D             ;
        LD      D,E             ;
        LD      E,A             ;
        POP     BC              ;
        DJNZ    L04D6           ;        
        JP      (IX)            ;








;----------------------------------------------------
;               Power Up LDPlayer
;----------------------------------------------------
L0535:  LD      A,01Ah          ; Command = POWER_UP
        CALL    L2085           ; Issue Command to LDPlayer
        JP      L0604           ; Begin Game







;----------------------------------------------------
;             Copy 'Generic' High Scores
;----------------------------------------------------
L053D:  LD      HL,01112h       ; Pointer to Generic High Scores
        LD      DE,0E050h       ; Pointer to High Score locations
        LD      BC,00050h       ; BC = 80 (10 high scores * 8)
        LDIR                    ; Copy in Generic High Scores
;----------------------------------------------------
;            Setup Graphics Chip Registers
;----------------------------------------------------
        LD      SP,0F000h       ; Stack Pointer = F000h
        LD      IX,0E12Fh       ; Graphics Registers E12F -E136
        LD      (IX+000h),000h  ;
        LD      (IX+001h),0B0h  ; Mode 1
        LD      (IX+002h),000h  ;
        LD      (IX+003h),000h  ;
        LD      (IX+004h),000h  ;
        LD      (IX+005h),000h  ;
        LD      (IX+006h),000h  ;
        LD      (IX+007h),000h  ;
        CALL    L2316           ; Write Graphics Registers
        CALL    L2392           ;
        CALL    L22F5           ; Program Graphics Chip
        CALL    GoodBeep        ; Sound Good Beep
        LD      A,0F1h          ; Text = WHITE, Bkgnd = BLACK
        CALL    L20CA           ; Setup Graphics Chip for Text          
        CALL    L21FF           ; Clear Text Display
        PUSH    HL              ; Save HL Register
        LD      HL,001EDh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
        .TEXT   "PLEASE STANDBY"
        .DB   000h 
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        LD      A,(0E18Ch)      ; Get DIP Switches 12-19
        BIT     0,A             ; Check if Service Mode enabled
        JP      NZ,L40FE        ; Enabled so perform Service Mode
        BIT     1,A             ; Check for Switch Test 
        JP      NZ,L3720        ; Enabled so perform Switch Test
;----------------------------------------------------
;            Start up LDPlayer
;   Send Play Command 45 times, if no frames are
;   being detected after a set time then ERROR.
;----------------------------------------------------
L05A7:  LD      E,02Dh          ; E = Loop Retry 45 times

L05A9:  LD      A,005h          ; Command = PLAY (05h)
        CALL    L207F           ; Send Message to LDPlayer DI

        LD      A,(0E126h)      ; Get Control Register
        RES     4,A             ; Clear PAUSE bit
        LD      (0E126h),A      ; Save Control Register

        CALL    L242F           ; Delay 1,000

        LD      A,(0E126h)      ; Get Control Register
        SET     1,A             ; Set Frame Count Wait bit
        LD      (0E126h),A      ; Save Control Register

        LD      BC,0E000h       ; BC = Timeout Value for LDPlayer
        LD      HL,0E112h       ; Get FrameCount Pulse
L05C7:  LD      A,(HL)          ; Read FrameCount Pulse
        CP      (HL)            ; Check if Frame Count Input arrived
        JR      NZ,L05FE        ; Input has arrived so skip ahead        
        DEC     BC              ; Decrement Timeout Timer
        LD      A,B             ; Check Timeout Timer
        OR      C               ; Has Timeout expired?
        JR      NZ,L05C7        ; No so continue waiting
        DEC     E               ; Decrement retry count
        JR      NZ,L05A9        ; Retry 45 times so loop back        

        PUSH    HL              ; Save HL Register
        LD      HL,001E7h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L05DA:  .TEXT  "** DISC NOT UP TO SPEED **"
        .DB    000h
;----------------------------------------------------        
        POP     HL              ; Restore HL Register
        CALL    BadBeep         ; Sound Bad Beep
        CALL    Delay500000     ; Call Delay for 500,000
        JR      L05A7           ; Keep trying to play disc       


;----------------------------------------------------
;               LDPlayer Started
;----------------------------------------------------
L05FE:  CALL    GoodBeep        ; Sound Good Beep
        CALL    L21FF           ; Clear Text Display         

L0604:  LD      A,(0E126h)      ; Get Control Register
        BIT     1,A             ; Is LDPlayer Busy?
        JR      NZ,L0604        ; Yes, so wait here

        LD      A,(0E126h)      ; Get Control Register
        BIT     4,A             ; Check if LDPlayer is PAUSED
        JR      NZ,L061F        ; Already PAUSED so skip over next part  
;----------------------------------------------------
;             Send PAUSE Command
;----------------------------------------------------
        LD      A,00Ah          ; Command = PAUSE (0Ah)
        CALL    L207F           ; Send Message to LDPlayer DI
        LD      A,(0E126h)      ; Get Control Register
        SET     4,A             ; Set PAUSE Bit
        LD      (0E126h),A      ; Save Control Register

L061F:  CALL    L1627           ; Reset Bookkeeping Data
;----------------------------------------------------
;     Check DIP switches for:
;     Service Mode, Switch Test, and Disc Diagnostic
;----------------------------------------------------
        LD      A,(0E18Ch)      ; Get DIP Switches 12-19
        BIT     0,A             ; Check Service Mode
        JP      NZ,L40FE        ; Enabled, so perform Service Mode
        BIT     1,A             ; Check Switch Test
        JP      NZ,L3720        ; Enabled, so perform Switch Test
        BIT     4,A             ; Check Disc Test
L0631:  JP      NZ,L6770        ; Enabled, so perform LaserDisc Diagnostics
        LD      A,(0E18Ch)      ; Get DIP Switches 12-19
        BIT     5,A             ; Check Attract Mode Sound
        JR      Z,L067F         ; Disabled, so skip Audio Setup

;----------------------------------------------------
;                  Audio Setup
;----------------------------------------------------                
L063B:  LD      A,(0E126h)      ; Get Control Register
L063E:  BIT     1,A             ;
L0640:  JR      NZ,L063B        ; 
;----------------------------------------------------
;                Handle LEFT_AUDIO
;----------------------------------------------------      
L0642:  LD      A,(0E126h)      ; Get Control Register
        BIT     1,A             ;
        JR      NZ,L0642        ;        

        LD      A,(0E126h)      ; Get Control Register
        BIT     6,A             ; Is LEFT_AUDIO already ON?
        JR      Z,L065D         ; Yes, so skip to right audio       

        LD      A,00Eh          ; Command = LEFT_AUDIO (0Eh) 
        CALL    L207F           ; Send Message to LDPlayer DI

        LD      A,(0E126h)      ; Get Control Register
        RES     6,A             ; Set Audio Left ON
        LD      (0E126h),A      ; Save Control Register

L065D:  PUSH    AF              ; Save AF Register
        LD      A,000h          ; Command = <unknown> (00h)
        CALL    L2085           ; Issue Command to LDPlayer
        POP     AF              ; Restore AF Register
;----------------------------------------------------
;              Handle RIGHT_AUDIO
;----------------------------------------------------
L0664:  LD      A,(0E126h)      ; Get Control Register
        BIT     1,A             ;
        JR      NZ,L0664        ;        

        LD      A,(0E126h)      ; Get Control Register
        BIT     5,A             ;
        JR      Z,L067F         ;        
        LD      A,00Dh          ; Command = RIGHT_AUDIO (0Dh)
        CALL    L207F           ; Send Message to LDPlayer DI
        LD      A,(0E126h)      ; Get Control Register
        RES     5,A             ;
        LD      (0E126h),A      ; Save Control Register


L067F:  LD      A,(0E126h)      ; Get Control Register
        RES     3,A             ;
        LD      (0E126h),A      ; Save Control Register

L0687:  LD      A,(0E126h)      ; Get Control Register
        BIT     1,A             ;
        JR      NZ,L0687        ;        

        LD      A,(0E126h)      ; Get Control Register
        BIT     4,A             ; Check PAUSE bit
        JR      Z,L06A2         ; LDPlayer already paused so skip ahead       
;----------------------------------------------------
;               Send PAUSE Command
;----------------------------------------------------
        LD      A,00Ah          ; Command = PAUSE (0Ah)
        CALL    L207F           ; Send Message to LDPlayer DI
        LD      A,(0E126h)      ; Get Control Register
        RES     4,A
        LD      (0E126h),A      ; Save Control Register
;----------------------------------------------------
;              Show CLIFF HANGER Intro
;----------------------------------------------------
L06A2:  CALL    DoIntroScreen   ; Show "CLIFF HANGER" Graphics
        CALL    Delay500000     ; Call Delay 500,000
        LD      IX,03704h       ;
        LD      IY,03704h       ;
        JP      L088B           ;

L06B3:  LD      A,(0E126h)      ; Get Control Register
        BIT     1,A             ;
        JR      NZ,L06B3        ;        
        LD      A,(0E126h)      ; Get Control Register
        BIT     4,A             ;
        JR      NZ,L06CE        ;        
;----------------------------------------------------
;             Send PAUSE Command
;----------------------------------------------------
        LD      A,00Ah          ; Command = PAUSE (0Ah)
        CALL    L207F           ; Send Message to LDPlayer DI
        LD      A,(0E126h)      ; Get Control Register
        SET     4,A             ; Set PAUSE Bit
        LD      (0E126h),A      ; Save Control Register
L06CE:  LD      A,(0E126h)      ; Get Control Register
        SET     0,A             ; 
        LD      (0E126h),A      ; Save Control Register
L06D6:  LD      A,(0E126h)      ; Get Control Register
        BIT     1,A             ;
        JR      NZ,L06D6        ;        
        LD      A,(0E126h)      ; Get Control Register
        BIT     4,A             ;
        JR      NZ,L06F1        ;        
;----------------------------------------------------
;             Send PAUSE Command
;----------------------------------------------------
        LD      A,00Ah          ; Command = PAUSE (0Ah)
        CALL    L207F           ; Send Message to LDPlayer DI
        LD      A,(0E126h)      ; Get Control Register
        SET     4,A             ; Set PAUSE Bit
        LD      (0E126h),A      ; Save Control Register

L06F1:  CALL    L53BB           ; Show Score or Programmer's Names
        CALL    Delay500000     ; Call Delay 500,000
        CALL    L1CF8           ; Show High Scores
        CALL    Delay500000     ; Call Delay 500,000
        CALL    L168D           ; Check if user needs Instructions
        CALL    Delay500000     ; Call Delay 500,000
        CALL    Delay500000     ; Call Delay 500,000
        JP      L067F           ;








;----------------------------------------------------
;           Increment Scene Pointers
;----------------------------------------------------
L0709:  LD      HL,(0E1BBh)     ; Get Scene Pointer
        INC     HL              ; Increment Scene Pointer
        INC     HL              ; Increment Scene Pointer
        LD      A,(0E1B6h)      ; Get Current Scene
        INC     A               ; Go to next scene
        CP      009h            ; Have we played all 9 scenes?                  
        JR      C,L0760         ; No, so skip ahead        
;----------------------------------------------------
;            Final Scene has been completed
;----------------------------------------------------
        LD      A,000h          ; A = 0
        LD      (0E1AEh),A      ; Clear Lives Remaining
        LD      (0E1B6h),A      ; Reset Current Scene Number
        LD      (0E1BBh),A      ; Clear Scene Pointer
        LD      (0E1BCh),A      ; Clear Scene Pointer
        CALL    L3C3A           ; Do Congratulation Celebration
        JP      L1EA2           ; Swap players







;----------------------------------------------------
;
;----------------------------------------------------
L072A:  LD      A,(0E126h)      ; Get Control Register
        RES     0,A             ;
        LD      (0E126h),A      ; Save Control Register

        LD      A,(0E186h)      ; Get DIP Switches 28-35 
        BIT     3,A             ; Check ? (sw 30)
        JR      NZ,L074F        ; Don't Play, so skip ahead
               
        LD      A,(0E111h)      ;
        AND     007h            ;
        RLCA                    ;
        LD      (0E15Dh),A      ;
        LD      E,A             ;
        LD      D,000h          ;
        LD      HL,007CBh       ; HL = 
        ADD     HL,DE           ;
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        EX      DE,HL
        JR      L075E                   

L074F:  LD      A,(0E18Ch)      ; Get DIP Switches 12-19
        BIT     6,A             ; Check SHORT/LONG Scenes
        JR      NZ,L075B        ; Set so use LONG Scenes        
        LD      HL,007BBh       ; Initial Scene Pointer (SHORT)
        JR      L075E           ; Skip LONG
                           
L075B:  LD      HL,007ABh       ; Initial Scene Pointer (LONG)

L075E:  LD      A,001h          ; Set Current Scene to 1
L0760:  LD      (0E1B6h),A      ; Save Current Scene
        LD      (0E1BBh),HL     ; Save Scene Pointer
        LD      E,(HL)          ; DE = First Scene Location
        INC     HL              ; Next spot
        LD      D,(HL)          ; DE = First Scene Location
        PUSH    DE              ; Save First Scene Location
        POP     IX              ; IX = First Scene Location
        PUSH    DE              ; Save First Scene Location
        POP     IY              ; IY = First Scene Location
        JP      L085B           ; Game Mechanics





;----------------------------------------------------
;            Do Player Game
;----------------------------------------------------
L0772:  LD      A,(0E1B6h)      ;
        OR      A               ;
        JR      Z,L072A         ;        
        LD      IX,(0E1AFh)     ;
        LD      IY,(0E1B1h)     ;
        LD      BC,(0E1B3h)     ;
        LD      A,B             ;
        OR      A               ;
        JR      Z,L0709         ; Increment pointers to next scene        
        LD      DE,0000Fh       ;
        ADD     IY,DE           ;
        LD      B,(IY+000h)     ;
        LD      E,(IY+001h)     ;
        LD      D,(IY+002h)     ;
        PUSH    DE              ;
        POP     IY              ; IY = Next scene address
        INC     IY              ;
        INC     IY              ;
        INC     IY              ;
        CALL    L095A           ; Play Death Scene for Incorrect Move
        DEC     IY              ;
        DEC     IY              ;
        DEC     IY              ;
        JP      L0878           ;
                                


;----------------------------------------------------
;               Scene Data Pointers
;----------------------------------------------------
L07AB:      .DW   02629h     ; Scene 1 - longest scenes        
            .DW   0270Eh     ; Scene 2      
            .DW   02925h     ; Scene 3        
            .DW   02BBAh     ; Scene 4       
            .DW   02F5Dh     ; Scene 5        
            .DW   03030h     ; Scene 6    
            .DW   03115h     ; Scene 7        
            .DW   03350h     ; Scene 8        


L07BB:      .DW   05C4Fh     ; Scene 1 - longer scenes          
            .DW   05D34h     ; Scene 2        
            .DW   02925h     ; Scene 3          
            .DW   05F4Bh     ; Scene 4      
            .DW   02F5Dh     ; Scene 5        
            .DW   062EEh     ; Scene 6         
            .DB   063D3h     ; Scene 7         
            .DB   03350h     ; Scene 8
            
;----------------------------------------------------
;               Scene Data Indexes
;----------------------------------------------------
L07CB:      .DW   007DBh             
            .DW   007EBh              
            .DW   007FBh              
            .DW   0080Bh  
            .DW   0081Bh  
            .DW   0082Bh 
            .DW   0083Bh              
            .DW   0084Bh 
            

;----------------------------------------------------
;           Scene Data Pointers (cont)
;----------------------------------------------------
L07DB:      .DW   07DB8h     ; Scene 1 
            .DW   07E1Fh     ; Scene 2      
            .DW   08000h     ; Scene 3        
            .DW   0824Dh     ; Scene 4       
            .DW   02F5Dh     ; Scene 5        
            .DW   062EEh     ; Scene 6    
            .DW   063D3h     ; Scene 7        
            .DW   085DEh     ; Scene 8        
                        
L07EB:      .DW   05C4Fh     ; Scene 1         
            .DW   07E1Fh     ; Scene 2         
            .DW   08000h     ; Scene 3         
            .DW   0824Dh     ; Scene 4          
            .DW   02F5Dh     ; Scene 5         
            .DW   062EEh     ; Scene 6          
            .DW   063D3h     ; Scene 7          
            .DW   085DEh     ; Scene 8 
             
L07FB:      .DW   07DB8h     ; Scene 1          
            .DW   05D34h     ; Scene 2          
            .DW   08000h     ; Scene 3        
            .DW   0824Dh     ; Scene 4          
            .DW   02F5Dh     ; Scene 5         
            .DW   062EEh     ; Scene 6          
            .DW   063D3h     ; Scene 7          
            .DW   085DEh     ; Scene 8 
             
L080B:      .DW   07DB8h     ; Scene 1 - short scenes         
            .DW   07E1Fh     ; Scene 2 
            .DW   02925h     ; Scene 3 
            .DW   0824Dh     ; Scene 4          
            .DW   02F5Dh     ; Scene 5          
            .DW   062EEh     ; Scene 6          
            .DW   063D3h     ; Scene 7     
            .DW   085DEh     ; Scene 8 
             
L081B:      .DW   07DB8h     ; Scene 1          
            .DW   07E1Fh     ; Scene 2          
            .DW   08000h     ; Scene 3         
            .DW   05F4Bh     ; Scene 4         
            .DW   02F5Dh     ; Scene 5         
            .DW   062EEh     ; Scene 6          
            .DW   063D3h     ; Scene 7          
            .DW   085DEh     ; Scene 8          

L082B:      .DW   07DB8h              
            .DB  1Fh 
            .DB  7Eh 
            .DB    0 
            .DB  80h 
            .DB  4Dh 
            .DB  82h 
            .DB  5Dh 
            .DB  2Fh 
            .DB 0EEh 
            .DB  62h 
            .DB 0D3h 
            .DB  63h 
            .DB 0DEh 
            .DB  85h 
            .DB 0B8h 
            .DB  7Dh 
            .DB  1Fh 
            .DB  7Eh 
            .DB    0 
            .DB  80h 
            .DB  4Dh 
            .DB  82h 
            .DB  5Dh 
            .DB  2Fh 
            .DB 0EEh 
            .DB  62h 
            .DB 0D3h 
            .DB  63h 
            .DB 0DEh 
            .DB  85h 
            .DB 0B8h 
            .DB  7Dh 
            .DB  1Fh 
            .DB  7Eh 
            .DB    0 
            .DB  80h 
            .DB  4Dh 
            .DB  82h 
            .DB  5Dh 
            .DB  2Fh 
            .DB 0EEh 
            .DB  62h 
            .DB 0D3h 
            .DB  63h 
            .DB 0DEh 
            .DB  85h 








;----------------------------------------------------
;              Scene Mechanics
;----------------------------------------------------
;       IY = First Scene Location (example 2629h)
;       IX = First Scene Location
;----------------------------------------------------
L085B:  CALL    L095A           ; Play Death Scene for Incorrect Move
        CALL    L08F4           ;

        LD      A,(IX+00Ch)     ; A = Number of Joystick Moves
        CP      000h            ; Are there any moves?
        JR      Z,L088B         ; No, so skip ahead

        LD      B,A             ; Loop = Number of Moves
        DEC     IY              ;
        DEC     IY              ;
        DEC     IY              ;
        DEC     IY              ;
        DEC     IY              ;

L0873:  LD      DE,00012h       ; 18 bytes per move
        ADD     IY,DE           ; Index to next move
L0878:  LD      (0E1B3h),BC     ; Save Move Address (loop)
        CALL    L0AED           ;
        CALL    L0DEB           ; Show Stick and Action Hints
        CALL    L0B79           ;
        LD      BC,(0E1B3h)     ; Restore Loop
        DJNZ    L0873           ; Loop until finished       

L088B:  LD      A,000h          ; A = 0
        LD      (0E122h),A      ; Clear number of errors
        LD      DE,00003h       ; 
        ADD     IX,DE           ;
        CALL    L0DAF           ; Wait until frame number reached
        LD      A,(0E126h)      ; Get Control Register
        BIT     0,A             ;
        JP      NZ,L06B3        ;
;----------------------------------------------------
;      Scene Bonus:  Award 10,000 Points to Score
;----------------------------------------------------
        XOR     A               ; A = 0
        LD      (0E127h),A      ; Bonus 10000000/1000000 = 0
        LD      (0E129h),A      ; Bonus 1000/100 = 0
        LD      (0E12Ah),A      ; Bonus 10/1     = 0
        LD      A,001h          ; Set 10,000 Points
        LD      (0E128h),A      ; Bonus 100000/10000 = 01
        CALL    L0F8F           ; Award Points and Update Score Display
        JP      L0709           ; Increment pointers to next scene








;----------------------------------------------------
;            Search to Frame Number
;----------------------------------------------------
;      (IY+00) thru (IY+02) = Frame Number
;---------------------------------------------------- 
L08B5:  LD      A,(0E126h)      ; Get Control Register
        BIT     1,A             ;
        JR      NZ,L08B5        ; Wait until ?               
        DI                      ; Disable Interrupts
        LD      A,00Bh          ; Command = SEARCH (0Bh)
        CALL    L2085           ; Issue Command to LDPlayer

        LD      A,(0E126h)      ; Get Control Register
        RES     4,A             ; Clear PAUSE bit
        LD      (0E126h),A      ; Save Control Register

        CALL    L09CC           ; Send FRAME NUMBER to LDPlayer
        LD      A,00Bh          ; Command = SEARCH (0Bh)
        CALL    L2085           ; Issue Command to LDPlayer

        LD      A,(0E126h)      ; Get Control Register
        RES     4,A             ; Clear PAUSE bit
        LD      (0E126h),A      ; Save Control Register

        LD      A,(IY+000h)     ;
        LD      (0E119h),A      ;
        LD      A,(IY+001h)     ;
        LD      (0E11Ah),A      ;
        LD      A,(IY+002h)     ;
        LD      (0E11Bh),A      ;
        CALL    Delay100000     ; Call Delay 100,000
        CALL    L20B4           ;
        EI                      ; Enable Interrupts
        RET                     ; Return







;----------------------------------------------------
;                   Set Audio
;----------------------------------------------------
SetAudio:
L08F4:  LD      A,(0E126h)      ; Get Control Register 
        BIT     0,A             ;
        RET     NZ              ;
L08FA:  LD      A,(0E126h)      ; Get Control Register
        BIT     1,A             ;
        JR      NZ,L08FA        ;        
L0901:  LD      A,(0E126h)      ; Get Control Register
        BIT     1,A             ;
        JR      NZ,L0901        ;        
        LD      A,(0E126h)      ; Get Control Register
        BIT     4,A             ;
        JR      Z,L091C         ;        
        LD      A,00Ah          ; Command = PAUSE (0Ah)
        CALL    L207F           ; Send Message to LDPlayer DI
        LD      A,(0E126h)      ; Get Control Register
        RES     4,A
        LD      (0E126h),A      ; Save Control Register
;----------------------------------------------------
;                Handle LEFT_AUDIO
;----------------------------------------------------
L091C:  LD      A,(0E126h)      ; Get Control Register
        BIT     1,A             ;
        JR      NZ,L091C        ;        
        LD      A,(0E126h)      ; Get Control Register
        BIT     6,A             ; Is LEFT_AUDIO already ON?
        JR      NZ,L0937        ; Yes, so skip to right audio

        LD      A,00Eh          ; Command = LEFT_AUDIO (0Eh)
        CALL    L207F           ; Send Message to LDPlayer DI
        LD      A,(0E126h)      ; Get Control Register
        SET     6,A             ; Set LEFT_AUDIO ON
        LD      (0E126h),A      ; Save Control Register
;----------------------------------------------------
;                Handle RIGHT_AUDIO
;----------------------------------------------------
L0937:  LD      A,(0E126h)      ; Get Control Register
        BIT     1,A             ;
        JR      NZ,L0937        ;        
        LD      A,(0E126h)      ; Get Control Register
        BIT     5,A             ; Is RIGHT_AUDIO already ON?
        JR      NZ,L0952        ; Yes, so skip ahead

        LD      A,00Dh          ; Command = RIGHT_AUDIO (0Dh)
        CALL    L207F           ; Send Message to LDPlayer DI
        LD      A,(0E126h)      ; Get Control Register
        SET     5,A             ; Set RIGHT_AUDIO ON
        LD      (0E126h),A      ; Save Control Register

L0952:  PUSH    AF              ; Save AF Register
        LD      A,000h          ; Command = TOGGLE
        CALL    L2085           ; Issue Command to LDPlayer
        POP     AF              ; Restore AF Register
        RET                     ; Return









;----------------------------------------------------
;          Play Death Scene for Incorrect Move
;----------------------------------------------------
;       IY = Scene Location
;       IX = First Scene Location
;----------------------------------------------------
L095A:  PUSH    BC              ; Save BC Register
        CALL    L53BB           ; Show Score or Programmer's Name
        LD      A,(IY+001h)     ;
        OR      A               ;
        JR      NZ,L0978        ;        

        PUSH    DE              ; Save DE Register
        LD      DE,00012h       ; Index to next move (18 bytes)
        LD      IY,(0E1B1h)     ; Get frame Number
        ADD     IY,DE           ; Add Index
        LD      (0E1B1h),IY     ;
        LD      DE,00009h       ;
        ADD     IY,DE           ; IY = Frame Address
        POP     DE              ; Restore DE Register

L0978:  CALL    L08B5           ; Search to Frame Number
        XOR     A               ; A = 0
        LD      (0E15Bh),A      ; Reset 
        CALL    L0A8B           ; ChkSearch
        CALL    L53A9           ; Clear Overlay?
;----------------------------------------------------
;                 Send PLAY Command
;----------------------------------------------------
L0985:  LD      A,005h          ; Command = PLAY (05h)
        CALL    L207F           ; Send Message to LDPlayer DI

        LD      A,(0E126h)      ; Get Control Register
        RES     4,A             ; Clear PAUSE bit
        LD      (0E126h),A      ; Save Control Register

        LD      A,(0E118h)      ; Get Frame Count
        LD      B,A             ; Save Frame Count
        CALL    L2353           ; Wait for Comm Ready
        CALL    L2353           ; Wait for Comm Ready
        CALL    L2353           ; Wait for Comm Ready
        LD      A,(0E118h)      ; Get Frame Count
        CP      B               ; Compare to previous frame count
        JR      NZ,L09AE        ; Frame has changed so skip ahead
               
        LD      A,(0E15Eh)      ; Get Crazy Counter
        INC     A               ; Increment Crazy Counter
        LD      (0E15Eh),A      ; Save Crazy Counter
        JR      L0985           ; Go back and try again

L09AE:  CALL    L21FF           ; Clear Text Display
        LD      A,(0E126h)      ; Get Control Register
        BIT     2,A             ;
        JP      NZ,L09CA        ;

;----------------------------------------------------
;         Print Player1 or Player2 Score
;----------------------------------------------------
        LD      A,(0E1A9h)      ; Get Player Number
        CP      001h            ; Is it Player1?
        LD      A,060h          ; Player1, Text = DK RED, Bkgnd = TRANS
        JR      Z,L09C4         ; Skip ahead        
        LD      A,040h          ; Player2, Text = BLUE, Bkgnd = TRANS
L09C4:  CALL    L2111           ; Set Text Color
        CALL    L0EB9           ; Overlay Score

L09CA:  POP     BC              ; Restore BC Register
        RET                     ; Return









;----------------------------------------------------
;      Send Frame Number to LDPlayer
;      (IY+00) thru (IY+02) = Frame Number
;----------------------------------------------------
L09CC:  PUSH    IX              ; Save IX Register
        PUSH    IY              ; Save IY Register
        PUSH    BC              ; Save BC Register
        LD      IX,0E10Eh       ; IX = ?
        LD      (IX+000h),000h  ;
        LD      A,(IY+000h)     ; Get Ten Thousanths digit 
        AND     00Fh            ; Isolate digit
        CALL    L0A13           ; Send Digit to LDPlayer
        LD      A,(IY+001h)     ;
        SRL     A               ;
        SRL     A               ;
        SRL     A               ;
        SRL     A               ;
        CALL    L0A13           ; Send Digit to LDPlayer
        LD      A,(IY+001h)     ;
        AND     00Fh            ;
        CALL    L0A13           ; Send Digit to LDPlayer
        LD      A,(IY+002h)     ;
        SRL     A               ;
        SRL     A               ;
        SRL     A               ;
        SRL     A               ;
        CALL    L0A13           ; Send Digit to LDPlayer
        LD      A,(IY+002h)     ;
        AND     00Fh            ; Isolate Digit
        CALL    L0A13           ; Send Digit to LDPlayer
        POP     BC              ; Restore BC Register
        POP     IY              ; Restore IY Register
        POP     IX              ; Restore IX Register
        RET                     ; Return







;----------------------------------------------------
;   Get Command Byte from Table and send to LDPlayer
;        A  = Digit to Send
;        IX = ?
;----------------------------------------------------
L0A13:  LD      HL,L20AA        ; Load start of Command Table Digits
        LD      D,000h          ; D = 0
        LD      E,A             ; DE = Index
        ADD     HL,DE           ; Add index to start of Command Table Digits
        LD      A,(HL)          ; Get Command Byte (digit)
        CP      (IX+000h)       ;
        LD      (IX+000h),A     ;
        JR      NZ,L0A2A        ;        
        PUSH    AF              ; Save AF Register
        LD      A,000h          ; Command = blank (?)
        CALL    L2085           ; Issue Command to LDPlayer
        POP     AF              ; Restore AF Register
L0A2A:  CALL    L2085           ; Issue Command to LDPlayer
        RET                     ; Return







;----------------------------------------------------
;      Check if certain Frame Number was reached
;        IY = Address of Target frame
;----------------------------------------------------
L0A2E:  POP     HL              ; Restore HL Register
        POP     DE              ; Restore DE Register
        POP     BC              ; Restore BC Register
        POP     IY              ; Restore IY Register
L0A33:  PUSH    IY              ; Save IY Register
        PUSH    BC              ; Save BC Register
        PUSH    DE              ; Save DE Register
        PUSH    HL              ; Save HL Register
;----------------------------------------------------
;             Get Target Frame Number
;----------------------------------------------------
        XOR     A               ; A = 0  
        LD      (0E127h),A      ; Erase Temp Subtract locations
        LD      (0E17Fh),A      ; Erase Frame Subtract locations
        LD      A,(IY+000h)     ; Get Target frame number
        LD      (0E180h),A      ; Save Target frame number
        LD      A,(IY+001h)     ; Get Target frame number
        LD      (0E181h),A      ; Save Target frame number
        LD      A,(IY+002h)     ; Get Target frame number
        LD      (0E182h),A      ; Save Target frame number

;----------------------------------------------------
;        Wait for frame data from LDPlayer
;----------------------------------------------------
        PUSH    HL              ; Save HL Register
        LD      HL,0E112h       ; HL = LDPlayer Pulse
        LD      A,(HL)          ; Get LDPlayer Pulse
L0A56:  CP      (HL)            ; Check if any data received
        JR      Z,L0A56         ; Wait here for frame data

;----------------------------------------------------
;             Get Current Frame Number
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        LD      A,(0E116h)      ; Get Current Frame Number
        LD      (0E128h),A      ; Save Current Frame Number
        LD      A,(0E117h)      ; Get Current Frame Number
        LD      (0E129h),A      ; Save Current Frame Number
        LD      A,(0E118h)      ; Get Current Frame Number
        LD      (0E12Ah),A      ; Save Current Frame Number

;----------------------------------------------------
;       Compare frame data with target frame
;----------------------------------------------------
        LD      DE,0E182h       ; Setup Subtract pointer
        CALL    L0FCC           ; Call 3-Digit Subtraction
        JR      C,L0A80         ; Frame number reached so leave        
        LD      HL,(0E181h)     ;
        LD      A,(0E180h)      ;
        OR      H               ;
        OR      L               ;
        JR      Z,L0A80         ; Error abort search       
        JR      L0A2E           ; Loop until frame number is reached       

L0A80:  POP     HL              ; Restore HL Register
        POP     DE              ; Restore DE Register
        POP     BC              ; Restore BC Register
        POP     IY              ; Restore IY Register
        RET                     ; Return








;----------------------------------------------------
;             Frame Compare?
;----------------------------------------------------
L0A86:  POP     HL              ; Restore HL Register
        POP     DE              ; Restore DE Register
        POP     BC              ; Restore BC Register
        POP     IY              ; Restore IY Register

L0A8B:  LD      A,(0E15Bh)      ; Get Search Counter
        INC     A               ; Increment Search Counter
        LD      (0E15Bh),A      ; Save Search Counter
        JP      Z,L0AE8         ; Search Counter expired, leave routine

        PUSH    IY              ; Save IY Register
        PUSH    BC              ; Save BC Register
        PUSH    DE              ; Save DE Register
        PUSH    HL              ; Save HL Register

        XOR     A               ; A = 0
        LD      (0E127h),A      ;
        LD      (0E17Fh),A      ; Erase Frame Subtract locations
        LD      A,(IY+000h)     ;
        LD      (0E180h),A      ;
        LD      A,(IY+001h)     ;
        LD      (0E181h),A      ;
        LD      A,(IY+002h)     ;
        LD      (0E182h),A      ;

;----------------------------------------------------
;        Wait for frame data from LDPlayer
;----------------------------------------------------
        PUSH    HL              ; Save HL Register
        LD      HL,0E112h       ; HL = LDPlayer Pulse
        LD      A,(HL)          ; Get LDPlayer Pulse
L0AB8:  CP      (HL)            ; Check if any data received
        JR      Z,L0AB8         ; Wait here for frame data
        
        POP     HL              ; Restore HL Register
        LD      A,(0E116h)      ;
        LD      (0E128h),A      ;
        LD      A,(0E117h)      ;
        LD      (0E129h),A      ;
        LD      A,(0E118h)      ;
        LD      (0E12Ah),A      ;
        LD      DE,0E182h       ;
        CALL    L0FCC           ; Call 3-Digit Subtraction
        JR      C,L0AE2         ;        
        LD      HL,(0E181h)     ;
        LD      A,(0E180h)      ;
        OR      H               ;
        OR      L               ;
        JR      Z,L0AE2         ;        
        JR      L0A86           ;        
L0AE2:  POP     HL              ;
        POP     DE              ;
        POP     BC              ;
        POP     IY              ;
        RET                     ;


L0AE8:  INC     SP              ;
        INC     SP              ;
        JP      L0978           ;








;----------------------------------------------------
;
;----------------------------------------------------
L0AED:  PUSH    IY              ; 
        INC     IY              ;
        INC     IY              ;
        INC     IY              ;
        CALL    L0B03           ; Move-Time Validation
        CALL    L0E7A           ; Clear Button and Joystick Data
        POP     IY              ;
        RET                     ; Return






;----------------------------------------------------
;             Move Frame Validation Loop
;----------------------------------------------------
L0AFE:  POP     HL              ; Restore HL Regsiter
        POP     DE              ; Restore DE Register
        POP     BC              ; Restore BC Register
        POP     IY              ; Restore IY Register
;----------------------------------------------------
;               Move Frame Validation
;----------------------------------------------------
;      IY thru IY+2 = Scene Move Frame Address
;----------------------------------------------------
L0B03:  PUSH    IY              ; Save IY Register
        PUSH    BC              ; Save BC Register
        PUSH    DE              ; Save DE Register
        PUSH    HL              ; Save HL Register

;----------------------------------------------------
;               Get Scene Move Frame
;----------------------------------------------------
        LD      A,(IY+000h)     ;
        LD      (0E128h),A      ;
        LD      A,(IY+001h)     ;
        LD      (0E129h),A      ;
        LD      A,(IY+002h)     ;
        LD      (0E12Ah),A      ;
        LD      A,000h          ;
        LD      (0E180h),A      ;
        LD      (0E181h),A      ;

;----------------------------------------------------
;             Add Move Frame Difficulty
;----------------------------------------------------
        LD      D,A             ; D = 0
        LD      A,(0E18Fh)      ; Get DIP Switches 4-11
        AND     00Fh            ; Isolate Move Time (sw 4-8)
        LD      E,A             ; DE = Index (0-15)
        LD      HL,00B67h       ; HL = Difficulty Table
        ADD     HL,DE           ; Add Index to Table Address
        LD      A,(HL)          ; Get Move Frame Adder from table 
        LD      (0E182h),A      ; Save Move Frame Adder
        LD      DE,0E182h       ; Number = Move Frame Adder
        CALL    L0FA1           ; Call 3-Digit Addition
;----------------------------------------------------
;               Get Move Frame
;----------------------------------------------------
        DI                      ; Disable Interrupts (stop clock)
        LD      A,(0E116h)      ;
        LD      (0E128h),A      ;
        LD      A,(0E117h)      ;
        LD      (0E129h),A      ;
        LD      A,(0E118h)      ;
        LD      (0E12Ah),A      ;
        EI                      ; Enable Interrupts

;----------------------------------------------------
;         Compare Move Frame to current Frame
;---------------------------------------------------
        LD      DE,0E182h       ;
        CALL    L0FCC           ; Call 3-Digit Subtraction
        JR      C,L0B61         ;        
        LD      HL,0E181h       ;
        LD      A,(0E180h)      ;
        OR      (HL)            ;
        INC     HL              ;
        OR      (HL)            ;
        JR      Z,L0B61         ;        
        JP      L0AFE           ; Loop back to Move Frame Validation

L0B61:  POP     HL              ; Restore HL Register
        POP     DE              ; Restore DE Register
        POP     BC              ; Restore BC Register
        POP     IY              ; Restore IY Register
        RET                     ; Return




;----------------------------------------------------
;            Difficulty Adjustment Table
;----------------------------------------------------
L0B67:   .DB   000h ;    
         .DB   001h ;   
         .DB   002h ;   
         .DB   003h ;   
         .DB   004h ;   
         .DB   005h ;   
         .DB   006h ;   
         .DB   007h ;   
         .DB   008h ;   
         .DB   009h ;   
         .DB   010h ;   
         .DB   011h ;   
         .DB   012h ;   
         .DB   013h ;   
         .DB   014h ;   
         .DB   015h ;
         
         
         



            
;----------------------------------------------------
;
;----------------------------------------------------
L0B77:  POP     IY              ;

L0B79:  PUSH    IY              ;
        LD      A,(0E15Ah)      ;
        OR      A               ;
        JR      Z,L0BA2         ;        

L0B81:  LD      A,(0E126h)      ; Get Control Register
L0B84:  BIT     1,A             ;
        JR      NZ,L0B81        ;  
              
        LD      A,(0E126h)      ; Get Control Register
        BIT     4,A             ;
        JR      NZ,L0B9C        ;        
;----------------------------------------------------
;             Send PAUSE Command
;----------------------------------------------------
        LD      A,00Ah          ; Command = PAUSE (0Ah) 
        CALL    L207F           ; Send Message to LDPlayer DI
        LD      A,(0E126h)      ; Get Control Register
        SET     4,A             ; Set PAUSE Bit
        LD      (0E126h),A      ; Save Control Register
L0B9C:  CALL    Delay100000     ; Delay 100,000
        JP      L0C7E           ; Sound Bad beep


L0BA2:  LD      A,(0E18Ch)      ; Get DIP Switches 12-19
        BIT     3,A             ; Check Player Immortality (sw 15)
        JR      NZ,L0C1D        ; Immortality set, skip input comparison        


;----------------------------------------------------
;           Compare Joystick movement
;----------------------------------------------------
        LD      HL,0E195h       ; HL = Joystick Data 
        LD      A,(IY+001h)     ; Get Correct Move Data
        OR      A               ; Check if any move exists
        JR      Z,L0C1D         ; No move, so skip ahead
        AND     00Fh            ; Isolate correct joystick move
        JR      Z,L0BD4         ; No joystick move, check FEET and HAND
               
        LD      B,008h          ; B = Joystick Left
        CP      001h            ; Is LEFT the correct move?
        JR      Z,L0BCE         ; Yes, so compare to joystick input
               
        LD      B,004h          ; B = Joystick Down
        CP      002h            ; Is DOWN the correct move?
        JR      Z,L0BCE         ; Yes, so compare to joystick input        

        LD      B,002h          ; B = Joystick Right
        CP      004h            ; Is RIGHT the correct move?
        JR      Z,L0BCE         ; Yes, so compare to joystick input
                
        LD      B,001h          ; B = Joystick Up
        CP      008h            ; Is UP the correct move?
        JR      Z,L0BCE         ; Yes, so compare to joystick input         

L0BCE:  LD      A,(HL)          ; Get Joystick Data
        AND     00Fh            ; Isolate position
        AND     B               ; Compare it to correct move
        JR      NZ,L0C08        ; Move correct, so sound Good BEEP


;----------------------------------------------------
;           Compare FEET and HAND Input
;----------------------------------------------------
L0BD4:  LD      HL,0E192h       ; HL = Button Data
        LD      A,(IY+001h)     ; Get Correct Move Data
        AND     0F0h            ; Isolate Hand and Feet
        JR      Z,L0C26         ; No button, just joystick so do wrong move
              
        CP      0F0h            ; Allow FEET or HAND?
        JR      Z,L0BFA         ; Yes, so check both

        CP      090h            ; Allow FEET?
        JR      Z,L0BF0         ; Yes, go check FEET 

;----------------------------------------------------
;                Check HAND Button
;----------------------------------------------------              
        LD      B,030h          ; B = HAND Button
        LD      A,(HL)          ; Get Button Data
        AND     030h            ; Check HAND button
        AND     B               ; Compare button to correct move
        JR      NZ,L0C08        ; Button correct, so sound Good Beep       
        JR      L0C26           ; Wrong move, jump ahead       

;----------------------------------------------------
;                Check FEET Button
;----------------------------------------------------
L0BF0:  LD      B,00Ch          ; B = FEET Button
        LD      A,(HL)          ; Get Button Data
        AND     00Ch            ; Check FEET button
        AND     B               ; Compare button to correct move
        JR      NZ,L0C08        ; Move correct, sound Good Beep       
        JR      L0C26           ; Wrong move, jump ahead

;----------------------------------------------------
;             Check FEET or HAND Button
;----------------------------------------------------
L0BFA:  LD      B,03Ch          ; B = FEET and HAND buttons
        LD      A,(HL)          ; Get Button Data
        AND     030h            ; Check HAND Button
        AND     B               ; Compare button to correct move
        JR      NZ,L0C08        ; Move correct, sound Good Beep

        LD      A,(HL)          ; Get Button Data
        AND     00Ch            ; Check FEET Button
        AND     B               ; Compare button to correct move
        JR      Z,L0C26         ; Wrong move, jump ahead


;----------------------------------------------------
;  Correct Move:  Sound Beep and Award 5,000 Points
;----------------------------------------------------
L0C08:  CALL    GoodBeep        ; Sound Good Beep
        XOR     A               ; A = 0
        LD      (0E127h),A      ; Bonus 10000000/1000000 = 0
        LD      (0E128h),A      ; Bonus 100000/10000 = 0
        LD      (0E12Ah),A      ; Bonus 10/1 = 0
        LD      A,050h          ; Set 5,000 Points
        LD      (0E129h),A      ; Bonus 1000/100 = 50
        CALL    L0F8F           ; Award Points and Update Score Display

L0C1D:  CALL    L0E4C           ; Erase Hint
        CALL    L0E7A           ; Clear Button and Joystick Data
        POP     IY              ; Restore IY Register
        RET                     ; Return


;----------------------------------------------------
;         Check for Incorrect Joystick Move
;----------------------------------------------------
L0C26:  LD      HL,0E195h       ; HL = Joystick Data
        LD      A,(IY+002h)     ; Get Incorrect Move Data
        OR      A               ; Are there incorrect moves?
        JR      Z,L0C83         ; No, so jump ahead       

        LD      B,000h          ;
        AND     00Fh            ;
        JR      Z,L0C55         ;
              
        LD      B,00Fh          ;

        BIT     0,A             ;
        JR      NZ,L0C3D        ;        
        RES     3,B             ;

L0C3D:  BIT     1,A             ;
        JR      NZ,L0C43        ;        
        RES     2,B             ;

L0C43:  BIT     2,A
        JR      NZ,L0C49                
        RES     1,B

L0C49:  BIT     3,A             ;
        JR      NZ,L0C4F        ;        
        RES     0,B             ;

L0C4F:  LD      A,(HL)          ; Get Joystick Input
        AND     00Fh            ; Isolate Joystick data
        AND     B               ; Compare to incorrect move
        JR      NZ,L0C7E        ; Move is incorrect, sound bad beep       

;----------------------------------------------------
;         Check for Incorrect Button
;----------------------------------------------------
L0C55:  LD      HL,0E192h       ; HL = Button Data
        LD      A,(IY+002h)     ; Get Incorrect Move
        AND     0F0h            ; Isolate Button Data
        JR      Z,L0C83         ;        

        CP      090h            ;
        JR      Z,L0C6B         ;        

        LD      B,030h          ;
        LD      A,(HL)          ;
        AND     030h            ;
        AND     B               ;
        JR      NZ,L0C7E        ; Move incorrect, sound bad beep        

L0C6B:  LD      A,(IY+002h)     ;
        AND     0F0h            ;
        CP      090h            ;
        JR      NZ,L0C83        ;        
        LD      B,00Ch          ;
        LD      A,(HL)
        AND     00Ch
        AND     B
        JR      NZ,L0C7E        ; Move is incorrect, so sound bad beep        
        JR      L0C83                   

;----------------------------------------------------
;        Incorrect Move found, sound bad beep
;----------------------------------------------------
L0C7E:  CALL    BadBeep         ; Sound Bad Beep
        JR      L0CE1           ; Start Death Sequence        

;----------------------------------------------------
;       Check if Move Frame Window has expired
;----------------------------------------------------
L0C83:  LD      DE,00006h       ; Index to Move Frame
        ADD     IY,DE           ;
        LD      A,(IY+000h)     ;
        LD      (0E180h),A      ;
        LD      A,(IY+001h)     ;
        LD      (0E181h),A      ;
        LD      A,(IY+002h)     ;
        LD      (0E182h),A      ;
        LD      A,000h          ;
        LD      (0E128h),A      ;
        LD      (0E129h),A      ;
        LD      D,A             ;
        LD      A,(0E18Fh)      ;
        AND     00Fh            ;
        LD      E,A             ;
        LD      HL,00CE8h       ; HL = start of data
        ADD     HL,DE           ;
        LD      A,(HL)          ;
        LD      (0E12Ah),A      ;
        LD      DE,0E182h       ;
        CALL    L0FCC           ; Call 3-Digit Subtraction
        DI                      ; Disable Interrupts
        LD      A,(0E116h)      ;
        LD      (0E128h),A      ;
        LD      A,(0E117h)      ;
        LD      (0E129h),A      ;
        LD      A,(0E118h)      ;
        LD      (0E12Ah),A      ;
        EI                      ; Enable Interrupts
        LD      DE,0E182h       ;
        CALL    L0FCC           ; Call 3-Digit Subtraction
        JR      C,L0CE1         ; Move Window expired, jump ahead       

        LD      HL,0E181h       ;
        LD      A,(0E180h)      ;
        OR      (HL)            ;
        INC     HL              ;
        OR      (HL)            ;
        JR      Z,L0CE1         ;        
        JP      L0B77           ;

;----------------------------------------------------
;       Window expired with no move, start Death
;----------------------------------------------------
L0CE1:  POP     IY              ; Restore Move Address
        INC     SP              ;
        INC     SP              ;
        JP      L0CF8           ; Start Death Sequence 


;----------------------------------------------------
;               data bytes
;----------------------------------------------------
L0CE8:  .DB   000h, 000h, 000h, 000h
        .DB   000h, 000h, 000h, 000h
        .DB   002h, 004h, 006h, 008h    
        .DB   010h, 012h, 014h, 016h







;----------------------------------------------------
;               Start Death Sequence
;----------------------------------------------------
L0CF8:  CALL    EraseActionOrStick

        LD      A,(0E126h)      ; Get Control Register
        SET     2,A             ; Set ?
        LD      (0E126h),A      ; Save Control Register

        LD      (0E1AFh),IX     ;
        LD      (0E1B1h),IY     ;
        LD      A,(0E15Ah)      ;
        OR      A               ;
        JR      NZ,L0D30        ;        

        PUSH    IY              ;
        POP     DE              ;
        LD      HL,(0E1B8h)     ;
        XOR     A               ;
        SBC     HL,DE           ;
        LD      A,H             ;
        OR      L               ;
        JR      Z,L0D29         ;        

        LD      A,001h          ;
        LD      (0E1B7h),A      ;
        LD      (0E1B8h),IY     ;
        JR      L0D30           ;        

L0D29:  LD      A,(0E1B7h)      ;
        INC     A               ;
        LD      (0E1B7h),A      ;

L0D30:  LD      A,(0E1AEh)      ; Get Number of Lives Remaining
        OR      A               ; Check if any lives left
        JR      Z,L0DA3         ; No lives left so skip ahead
        ADD     A,099h          ; Add 99 Lives
        DAA                     ; Convert to decimal
        LD      (0E1AEh),A      ; Save Number of Lives Remaining

;----------------------------------------------------
;       Read Death Scene Starting Frame Number 
;----------------------------------------------------
        LD      DE,00009h       ; Index to death scene
        ADD     IY,DE           ; Add to move index
        CALL    L095A           ; Play Death Scene for Incorrect Move
        LD      A,(0E15Ah)      ;
        OR      A               ;
        JR      NZ,L0D9B        ;        
        LD      A,000h          ;
        LD      (0E122h),A      ;
        LD      IY,(0E1B1h)     ;
        PUSH    IY              ;
        POP     IX              ; IX = IY
        LD      DE,0000Ch       ; Index to End Frame of Death Address
        ADD     IX,DE           ; Index into move table

;----------------------------------------------------
;         Read Death Scene Ending Frame Number 
;----------------------------------------------------
        XOR     A               ; A = 0
        LD      (0E17Fh),A      ; Erase Frame Subtract locations
        LD      A,(IX+000h)     ; Get Frame Number Byte 1 from ROM
        LD      (0E180h),A      ; Store Frame Number Byte 1
        LD      A,(IX+001h)     ; Get Frame Number Byte 2 from ROM 
        LD      (0E181h),A      ; Store Frame Number Byte 2
        LD      A,(IX+002h)     ; Get Frame Number Byte 3 from ROM
        LD      (0E182h),A      ; Store Frame Number Byte 3

        LD      A,(0E186h)      ; Get DIP Switches 28-35
        BIT     2,A             ; Check Play Hanging Scene?
        JR      Z,L0D90         ; Don't play scene, so skip ahead        

;----------------------------------------------------
;         Set Frame Number for Hanging Scene
;       Hanging Scene = Ending Scene Frame - 272
;----------------------------------------------------
        XOR     A               ; A = 0
        LD      (0E127h),A      ; Store 0
        LD      (0E128h),A      ; Store 0
        LD      A,002h          ; A = 02
        LD      (0E129h),A      ; Store 2
        LD      A,072h          ; A = 72
        LD      (0E12Ah),A      ; Store 72

        LD      DE,0E182h       ; Subtract 272 from Starting Frame
        CALL    L0FCC           ; Call 3-Digit Subtraction

;----------------------------------------------------
;      Wait until Death Scene finished playing
;----------------------------------------------------
L0D90:  LD      IX,0E180h       ; Frame Number Address
        CALL    L0DAF           ; Wait until frame number reached
        LD      IX,(0E1AFh)     ;

L0D9B:  LD      A,(0E126h)      ; Get Control Register
        RES     2,A             ;
        LD      (0E126h),A      ;

L0DA3:  LD      A,(0E1AEh)      ; Get Number of Lives Remaining
        OR      A               ; Check if any lives left
        CALL    Z,L12F0         ; No lives left so check BUY-IN
        JP      L1EA2           ; Swap players






;----------------------------------------------------
;         Wait until frame number reached
;     IX = Address of Target frame
;----------------------------------------------------
L0DAD:  POP     IX              ; Get Frame Number Address
L0DAF:  PUSH    IX              ; Save Frame Number Address
        LD      HL,0E116h       ; HL = Odd Frame Count
        LD      B,003h          ; 3 bytes (6 digits) to compare
L0DB6:  LD      A,(HL)          ; Get Current Frame
        CP      (IX+000h)       ; Compare to Target Frame
        JR      Z,L0DDE         ; Frame bytes equal now check next byte        
        JR      NC,L0DC0        ; Target frame passed, so log error        
        JR      L0DAD           ; Loop back until target frame matches        

;----------------------------------------------------
;         Wait for next frame from LDPlayer
;----------------------------------------------------
L0DC0:  LD      A,(0E112h)      ; Get LDPlayer Pulse
        LD      B,A             ; B = Pulse
L0DC4:  LD      A,(0E112h)      ; Get LDPlayer Pulse
        CP      B               ; See if it has changed
        JR      Z,L0DC4         ; Wait until frame count arrives

        LD      A,(0E123h)      ;
        INC     A               ;
        LD      (0E123h),A      ;

        LD      A,(0E122h)      ; Get errors
        INC     A               ; Increment errors
        LD      (0E122h),A      ; Save errors

        CP      002h            ; Do we have more than 2 errors?
        JR      C,L0DAD         ; Not yet, so continue trying       
        JR      L0DE3           ; Too many errors, give up and just continue

L0DDE:  INC     HL              ; Next byte to compare
        INC     IX              ; Next byte to compare
        DJNZ    L0DB6           ; Loop until all digits compared       

L0DE3:  POP     IX              ; Restore Frame Number Address
        LD      A,000h          ; Clear out errors
        LD      (0E122h),A      ; Save errors
        RET                     ; Return







;----------------------------------------------------
;            Show Stick and Action Hints     
;----------------------------------------------------
L0DEB:  LD      A,(0E186h)      ; Get DIP Switches 28-35
        BIT     5,A             ; Check Show Hints (sw 33)
        RET     Z               ; No Hints, so just return

        PUSH    IX              ; Save IX Register
        PUSH    IY              ; Save IY Register
        PUSH    BC              ; Save BC Register

        LD      A,(IY+001h)     ; Get correct move
        AND     00Fh            ; Isolate joystick move
        JR      Z,L0E21         ; No Stick move, check Action
        CALL    L2353           ; Wait for Comm Ready
        PUSH    HL              ; Save HL Register
        LD      HL,003A4h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L0E07: .TEXT "   \ STICK ~   "
       .DB   000h              
;----------------------------------------------------
L0E17:  POP     HL              ; Restore HL Register
        CALL    L2381           ;
        POP     BC              ; Restore BC Register
        POP     IY              ; Restore IY Register
        POP     IX              ; Restore IX Register
        RET                     ; Return

;----------------------------------------------------
;              Check for Action Move Hint
;----------------------------------------------------
L0E21:  LD      A,(IY+001h)     ; Get correct move
        AND     0F0h            ; Isolate Action move
        JR      Z,L0E46         ; No Action move, so skip to end
        CALL    L2353           ; Wait for Comm Ready
        PUSH    HL              ; Save HL Register
        LD      HL,003A4h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L0E32:  .TEXT   "  \ ACTION ~   "
        .DB   000h      
;----------------------------------------------------
L0E42:  POP     HL              ; Restore HL Register
        CALL    L2381           ;
L0E46:  POP     BC              ; Restore BC Register
        POP     IY              ; Restore IY Register
        POP     IX              ; Restore IX Register
        RET                     ; Return





;----------------------------------------------------
;                  Erase Hint        
;----------------------------------------------------
L0E4C:  PUSH    IX              ; Save IX Register
        PUSH    IY              ; Save IY Register
        PUSH    BC              ; Save BC Register
        LD      A,(IY+001h)     ; Get correct move
L0E54:  OR      A               ; Was there a move
        JR      Z,L0E46         ; No move, so just return       
        CALL    L2353           ; Wait for Comm Ready
        PUSH    HL              ; Save HL Register
        LD      HL,003A3h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text      
;----------------------------------------------------
L0E61:  .TEXT   "                 "
        .DB   000h      
;----------------------------------------------------         
L0E73:  POP     HL              ; Restore HL Register
        POP     BC              ; Restore BC Register
        POP     IY              ; Restore IY Register
        POP     IX              ; Restore IX Register
        RET                     ; Return





;----------------------------------------------------
;            Clear Button Data
;----------------------------------------------------
L0E7A:  PUSH    AF              ; Save AF Register
        LD      A,(0E192h)      ; Get Button Data
        RES     2,A             ; Clear PLAYER1/FEET
        RES     3,A             ; Clear PLAYER2/FEET
        RES     5,A             ; Clear HAND-Left
        RES     4,A             ; Clear HAND-Right
        LD      (0E192h),A      ; Write Button Data
;----------------------------------------------------
;           Clear Joystick Data
;----------------------------------------------------
L0E89:  LD      A,(0E195h)      ; Get Joystick Data
        RES     0,A             ; Clear UP
        RES     1,A             ; Clear RIGHT
        RES     2,A             ; Clear DOWN
        RES     3,A             ; Clear LEFT
        LD      (0E195h),A      ; Write Joystick Data
        POP     AF              ; Restore AF Register
        RET                     ; Return



     


;----------------------------------------------------
;            Do GOOD Beep (BEEP)
;----------------------------------------------------
GoodBeep:
L0E99:  LD      A,(0E114h)      ;
        SET     0,A             ;
        LD      (0E114h),A      ;
        OUT     (046h),A        ; Beep
        LD      A,002h          ;
        LD      (0E125h),A      ;
        RET                     ; Return






;----------------------------------------------------
;           Do Bad BEEP (BOOP)
;----------------------------------------------------
BadBeep:
L0EA9:  LD      A,(0E114h)      ;
        SET     1,A             ;
        LD      (0E114h),A      ;
        OUT     (046h),A        ;
        LD      A,004h          ;
        LD      (0E110h),A      ;
        RET                     ; Return






;----------------------------------------------------
;                    Overlay Score
;----------------------------------------------------
OverlayScore:
L0EB9:  LD      A,(0E186h)      ; Get DIP Switches 28-35
L0EBC:  BIT     4,A             ; Check Display Overlay (sw 32)
        RET     Z               ; Overlay disabled, so just return

        CALL    L2353           ; Wait for Comm Ready

        LD      DE,00000h       ; Player1 Location X = 0, Y = 0
        LD      A,(0E1A9h)      ; Get Player Number
        CP      001h            ; Is it Player 1?
        JP      Z,L0ED0         ; Yes, so jump ahead
        LD      DE,01E00h       ; Player2 Location X = 30, Y = 0

L0ED0:  LD      HL,0E1AAh       ; HL = Score Address
        LD      B,004h          ; 4 Bytes in score 
        LD      C,000h          ;
        EX      AF,AF'          ;
        LD      A,000h          ;
        EX      AF,AF'          ;
                                  
L0EDB:  LD      A,(HL)          ; Get Score byte
        RRC     A               ;
        RRC     A               ;
        RRC     A               ;
        RRC     A               ;
        AND     00Fh            ;
        JR      NZ,L0EEE        ;        
        LD      A,C             ;
        OR      A               ;
        JR      Z,L0EF4         ;        
        LD      A,000h          ;

L0EEE:  OR      030h            ; Make digit into character
        LD      C,A             ; C = Character
        CALL    L0F1B           ; Send Character

L0EF4:  INC     D               ; Location X = X + 1
        LD      A,(HL)          ;
        AND     00Fh            ;
        JR      NZ,L0F08        ;        
        LD      A,B             ;
        CP      001h            ;
        LD      A,000h          ;
        JP      Z,L0F08         ;
        LD      A,C             ;
        OR      A               ;
        JR      Z,L0F0E         ;        
        LD      A,000h          ;
L0F08:  OR      030h            ; Make digit into character
        LD      C,A             ;
        CALL    L0F1B           ;
L0F0E:  INC     D               ;
        INC     HL              ;
        DJNZ    L0EDB           ;        

        LD      A,07Eh          ; A = Character Left Triangle
        CALL    L2233           ; Print one Character to Text Display
        CALL    L0F39           ; Print Little Man characters
        RET                     ; Return





;----------------------------------------------------
;              Send Character
;----------------------------------------------------
L0F1B:  PUSH    AF
        EX      AF,AF'
        PUSH    AF
        EX      AF,AF'
        POP     AF
        OR      A
        JR      NZ,L0F2D                
        LD      A,05Ch          ; A = Character
        CALL    L2233           ; Print one Character to Text Display
        EX      AF,AF'          ;
        LD      A,001h          ;
        EX      AF,AF'          ;
        INC     D               ;
L0F2D:  POP     AF              ;
        CALL    L2233           ; Print one Character to Text Display
        PUSH    AF              ; Save AF Register
        PUSH    BC              ; Save BC Register
        CALL    L2353           ; Wait for Comm Ready
        POP     BC              ; Restore BC Register
        POP     AF              ; Restore AF Register
        RET                     ; Return






;----------------------------------------------------
;     Print a Little Man for each life remaining
;----------------------------------------------------
L0F39:  LD      A,(0E1AEh)      ; Get Number of Lives Remaining
        OR      A               ; Test number of lives
        RET     Z               ; If no lives left then just return

        CALL    L2353           ; Wait for Comm Ready

        LD      B,006h          ; Loop = 6
        LD      A,(0E1AEh)      ; Get Number of Lives remaining
        CP      B               ; Are there more than 6 lives left?
        JR      C,L0F4A         ; Less than 6 lives so skip ahead        
        LD      A,B             ; Set number of lives to 6

L0F4A:  LD      B,A             ; B= Number of Lives remaining
        LD      A,(0E1A9h)      ; Get Player Number
        CP      001h            ; Check for Player1
        JP      Z,L0F6F         ; Jump ahead and show Player1 lives

        LD      DE,01400h       ; Location X = 20, Y = 0
        LD      A,05Ch          ; A = Character
        CALL    L2233           ; Print one Character to Text Display

;----------------------------------------------------
;        Print a little man for each life
;----------------------------------------------------
        LD      DE,01500h       ; Location X = 21, Y = 0
L0F5E:  LD      A,090h          ; A = Character Little Man
        CALL    L2233           ; Print one Character to Text Display
        CALL    L0F8B           ; Wait for Comm
        INC     D               ; Location X = X + 1
        DJNZ    L0F5E           ; Loop until all lives are shown      

        LD      A,07Eh          ; A = Character Left Triangle
        CALL    L2233           ; Print one Character to Text Display
        RET                     ; Return


L0F6F:  LD      DE,01400h       ; Location X = 20, Y = 0
        LD      A,07Eh          ; A = Character Left Triangle
        CALL    L2233           ; Print one Character to Text Display

        LD      DE,01300h       ; Location X = 19, Y = 0
L0F7A:  LD      A,090h          ; A = Character
        CALL    L2233           ; Print one Character to Text Display

        CALL    L0F8B           ; Wait for Comm
        DEC     D               ; Location X = X - 1
        DJNZ    L0F7A           ;        
        LD      A,05Ch          ; A = Character
        CALL    L2233           ; Print one Character to Text Display
        RET                     ; Return





;----------------------------------------------------
;              Wait for 1 Comm
;----------------------------------------------------
L0F8B:  CALL    L2353           ; Wait for Comm Ready
        RET                     ; Return





;----------------------------------------------------
;       Award Points and Update Score Display
;     E127-E12A  = Points to add to score
;----------------------------------------------------
L0F8F:  PUSH    BC               ; Save BC Register
        PUSH    DE               ; Save DE Register
        PUSH    HL               ; Save HL Register
        LD      B,004h           ; 4 digits to add
        LD      DE,0E1ADh        ; Load Score
        CALL    L0FBF            ; Call Addition
        CALL    L0EB9            ; Overlay Score
        POP     HL               ; Restore HL Register
        POP     DE               ; Restore DE Register
        POP     BC               ; Restore BC Register 
        RET                      ; Return





;----------------------------------------------------
;               3-Digit Addition
;----------------------------------------------------
;       DE = Last location which to add to (ones)
;----------------------------------------------------
L0FA1:  LD      B,003h          ; 3 digits to add
        CALL    L0FBFh          ; Call BCD Addition
        LD      HL,L0000        ; HL = 00000h
        LD      (0E127h),HL     ; Erase Temp Add/Subtract location
        LD      (0E129h),HL     ; Erase Temp Add/Subtract location
        RET                     ; Return






;----------------------------------------------------
;               2-Digit Addition
;----------------------------------------------------
;       DE = Last location which to add to (ones)
;----------------------------------------------------
L0FB0:  LD      B,002h          ; 2 digits to add
        CALL    L0FBF           ; Call BCD Addition
        LD      HL,L0000        ; HL = 00000h
        LD      (0E127h),HL     ; Erase Temp Add/Subtract location
        LD      (0E129h),HL     ; Erase Temp Add/Subtract location
        RET                     ; Return





;----------------------------------------------------
;                BCD Addition 
;----------------------------------------------------
;         DE = Last location which to add to (ones)
;          B = Number of digits to add
;  E127-E12A = Value which to add (temp)
;----------------------------------------------------
L0FBF:  LD      HL,0E12Ah       ; Pointer to temp add location
        OR      A               ; Clear Carry
L0FC3:  LD      A,(DE)          ; Get adder value
        ADC     A,(HL)          ; Add to DE
        DAA                     ; Convert to decimal
        LD      (DE),A          ; Store total
        DEC     DE              ; Point to next digit (total)
        DEC     HL              ; Point to next digit (adder)
        DJNZ    L0FC3           ; Loop until all digits added       
        RET                     ; Return






;----------------------------------------------------
;               3-Digit Subtraction
;----------------------------------------------------
;           DE = Location which to subtract from
;    E127-E12A = Value which to subtract (temp)
;----------------------------------------------------
L0FCC:  LD      B,003h          ; 3 digits to subtract
        CALL    L0FEA           ; Call BCD Subtraction
        LD      HL,00000h       ; HL = 00000h
        LD      (0E127h),HL     ; Erase Temp Add/Subtract location
        LD      (0E129h),HL     ; Erase Temp Add/Subtract location
        RET                     ; Return





;----------------------------------------------------
;               2-Digit Subtraction
;----------------------------------------------------
;           DE = Location which to subtract from
;    E127-E12A = Value which to subtract (temp)
;----------------------------------------------------
L0FDB:  LD      B,002h          ; 2 digits to subtract
        CALL    L0FEA           ; Call BCD Subtraction
        LD      HL,00000h       ; HL = 00000h
        LD      (0E127h),HL     ; Erase Temp Add/Subtract location
        LD      (0E129h),HL     ; Erase Temp Add/Subtract location
        RET                     ; Return






;----------------------------------------------------
;                BCD Subtraction 
;----------------------------------------------------
;           DE = Location which to subtract from
;           B  = Number of digits to subtract
;    E127-E12A = Value which to subtract (temp)
;----------------------------------------------------
L0FEA:  LD      HL,0E12Ah       ; Pointer to temp subtraction location
        OR      A               ; Clear carry
L0FEE:  LD      A,(DE)          ; Get subtraction value
        SBC     A,(HL)          ; Subtract value
        DAA                     ; Convert to decimal
        LD      (DE),A          ; Store result
        DEC     DE              ; Point to next digit
        DEC     HL              ; Point to next digit
        DJNZ    L0FEE           ; Loop until all digits subtracted        
        RET                     ; Return






;----------------------------------------------------
;                      Return
;----------------------------------------------------
        RET                     ; Return


;----------------------------------------------------
;                      Return
;----------------------------------------------------
        RET                     ; Return




;----------------------------------------------------
;        Compact High Score Tables and Reset Data
;----------------------------------------------------
L0FF9:  CALL    L1003           ; Compact All-Time High Score Table
        CALL    L1074           ; Compact Today's High Score Table
        CALL    L1627           ; Reset Bookkeeping Data
        RET                     ; Return





;----------------------------------------------------
;  Remove empty slots from All-Time High Score Table 
;----------------------------------------------------
L1003:  LD      HL,0E000h       ; HL = Start of All-Time High Scores
        LD      IY,0E000h       ; IY = Start of All-Time High Scores
        LD      DE,00008h       ; Number of bytes in High Score
        LD      C,00Ah          ; Loop = 10 scores
L100F:  LD      B,008h          ; 8 bytes to sum
        CALL    L110C           ; Calculate Sum of bytes
        CP      0FFh            ; Check if slot is blank
        JR      NZ,L101E        ; Blank slot found so remove it        
        ADD     IY,DE           ; Point to next score
        DEC     C               ; Decrement Loop
        JR      NZ,L100F        ; Loop until all scores checked
        RET                     ; Return
;----------------------------------------------------
;                 Remove empty slot 
;----------------------------------------------------
L101E:  CALL    L1023           ; Erase empty slot
        JR      L1003           ; Recheck all slots       








;----------------------------------------------------
;                 Initials
;----------------------------------------------------
;         IY  Pointer within High Score
;----------------------------------------------------
L1023:  PUSH    BC              ; Save BC Register
        PUSH    DE              ; Save DE Register
        PUSH    HL              ; Save HL Register
        PUSH    IY              ; Save IY Register
        PUSH    IY              ; Copy IY
        POP     DE              ; DE = High Score pointer
        LD      HL,0E050h       ; HL = Start of Initials
        AND     A               ; Clear carry
        SBC     HL,DE           ; 
        LD      DE,00008h       ;
        SBC     HL,DE           ;
        INC     HL              ;
        LD      B,H             ;
        LD      C,L             ;
        PUSH    IY              ;
        POP     HL              ; Restore HL Register
        ADD     HL,DE           ;
        PUSH    IY              ;
        POP     DE              ;
        LDIR                    ;
        LD      IY,0E048h       ; 10th High Score
        LD      A,055h          ; "U"
        LD      (IY+000h),A     ;
        LD      A,052h          ; "R"
        LD      (IY+001h),A     ;
        LD      A,04Ch          ; "L"
        LD      (IY+002h),A     ;
        XOR     A               ; A = 00
        LD      (IY+003h),A     ;
        LD      (IY+004h),A     ;
        LD      (IY+005h),A     ;
        LD      (IY+006h),A     ;
        LD      B,007h          ; 7 bytes to sum
        LD      HL,0E048h       ; Sum 10th High Score
        CALL    L110C           ; Calculate Sum of bytes
        CPL                     ;
        LD      (IY+007h),A     ;
        POP     IY              ; Restore IY Register
        POP     HL              ; Restore HL Register
        POP     DE              ; Restore DE Register
        POP     BC              ; Restore BC Register
        RET                     ; Return







;----------------------------------------------------
;  Remove empty slots from Today's High Score Table
;----------------------------------------------------
L1074:  LD      HL,0E050h       ; HL = Start of Today's High Scores
        LD      IY,0E050h       ; IY = Start of Today's High Scores;
        LD      DE,00008        ; Number of bytes in High Score
        LD      C,00Ah          ; 10 slots to check
L1080:  LD      B,008h          ; 8 bytes in each slot to sum
        CALL    L110C           ; Calculate Sum of bytes
        CP      0FFh            ; Check if slot is blank
        JR      NZ,L108F        ; Blank slot found so remove it
        ADD     IY,DE           ; Point to next score
        DEC     C               ; Decrement Loop
        JR      NZ,L1080        ; Loop until all scores checked       
        RET                     ; Return
;----------------------------------------------------
;                 Remove empty slot 
;----------------------------------------------------
L108F:  CALL    L1094           ; Remove empty slot
        JR      L1074           ; Continue checking scores





;----------------------------------------------------
;          Move all High Scores up one notch
;----------------------------------------------------
;       IY = High Score to change (E050,E058,...)
;----------------------------------------------------
L1094:  PUSH    BC              ; Save BC Register
        PUSH    DE              ; Save DE Register
        PUSH    HL              ; Save HL Register
        PUSH    IY              ; Save IY Register

        PUSH    IY              ; Move IY...
        POP     DE              ; ...into DE
        LD      HL,0E0A0h       ; Point to last high score
        AND     A               ; Clear carry
        SBC     HL,DE           ; Subtract back from last score
        LD      DE,00008h       ;
        SBC     HL,DE
        INC     HL
        LD      B,H
        LD      C,L
        PUSH    IY
        POP     HL              ; Restore HL Register
        ADD     HL,DE
        PUSH    IY
        POP     DE
        LDIR    
;----------------------------------------------------
;   Save "URL 00000" into last high score position
;----------------------------------------------------
        LD      IY,0E098h       ; Point to last position
        LD      A,055h          ; "U"
        LD      (IY+000h),A
        LD      A,052h          ; "R"
        LD      (IY+001h),A
        LD      A,04Ch          ; "L"
        LD      (IY+002h),A
        XOR     A               ; A = 00
        LD      (IY+003h),A
        LD      (IY+004h),A
        LD      (IY+005h),A
        LD      (IY+006h),A
        LD      B,007h          ; 7 bytes to sum
        LD      HL,0E098h
        CALL    L110C           ; Calculate Sum of bytes
        CPL     
        LD      (IY+007h),A

        POP     IY              ; Restore IY Register
        POP     HL              ; Restore HL Register
        POP     DE              ; Restore DE Register
        POP     BC              ; Restore BC Register
        RET                     ; Return







;----------------------------------------------------
;            Calculate Sum of Plays:
;----------------------------------------------------
;   E0A0 - E0A2   Total Plays
;   E0A3 - E0A4   Left Coin Slot Total
;   E0A5 - E0A6   Right Coin Slot Total
;----------------------------------------------------
L10E5:  LD      B,007h          ; 7 bytes to sum
        LD      HL,0E0A0h       ; Sum bytes E0A0 - E0A6
        JR      L1106           ; Calculate sum of bytes






;----------------------------------------------------
;       Calculate Sum of Play Times:
;----------------------------------------------------
;   E0A8 - E0AA   Total Play Time Seconds
;   E0AB - E0AD   Longest Game Seconds
;   E0AE          Shortest Game Seconds
;   E0AF          Highest Scene
;----------------------------------------------------
L10EC:  LD      B,008h          ; 8 bytes to sum
        LD      HL,0E0A8h       ; Sum bytes E0A8 thru E0AF
        JR      L1106           ; Calculate sum of bytes






;----------------------------------------------------
;          Calculate Sum of ----
;----------------------------------------------------
L10F3:  LD      B,01Eh          ; Sum 30 values
        LD      HL,0E0B1h       ; 
        JR      L1106           ;        

L10FA:  LD      B,01Eh          ; Sum 30 values
        LD      HL,0E0D0h       ;
        JR      L1106           ;        




L1101:  LD      B,01Eh
        LD      HL,0E0EFh
;----------------------------------------------------
;      Calculate Sum of HL + (HL+1) + ... + (HL+B)
;----------------------------------------------------
;         B = Number of bytes to sum
;        HL = Starting Location of byte
;----------------------------------------------------
L1106:  CALL    L110C           ; Call Calculate sum
        CPL                     ; Reverse all bits
        LD      (HL),A          ; Store sum (HL+B)
        RET                     ; Return





;----------------------------------------------------
;             Calculate Sum of Data Series
;----------------------------------------------------      
;       B = Number of bytes to sum
;      HL = Starting Location of byte
;       A = Return Total
;----------------------------------------------------
L110C:  XOR     A               ; Clear total
L110D:  ADD     A,(HL)          ; Add contents of HL
        INC     HL              ; Point to next location
        DJNZ    L110D           ; Loop until all bytes summed
        RET                     ; Return





;----------------------------------------------------
;     Top Ten High Scores and Initials at startup
;----------------------------------------------------   
L1112:  .TEXT  "JMH"
        .DB    0,1,0,0,0
L111A:  .TEXT  "PMR"
        .DB    0,0,9,0,0
L1122:  .TEXT  "EJM"
        .DB    0,0,8,0,0
L112A:  .TEXT  "APH"
        .DB    0,0,7,0,0
L1132:  .TEXT  "VAV"
        .DB    0,0,6,0,0
L113A:  .TEXT  "MAS"
        .DB    0,0,5,0,0
L1142:  .TEXT  "JON"
        .DB    0,0,4,0,0
L114A:  .TEXT  "WHO"
        .DB    0,0,3,0,0    
L1152:  .TEXT  "HP?"
        .DB    0,0,2,0,0
L115A:  .TEXT  "JIM"
        .DB    0,0,1,0,0



        




;----------------------------------------------------
;               Check Coin Slots
;----------------------------------------------------
L1162:  LD      HL,(0E127h)     ; Get temp Add/Subtract location
        PUSH    HL              ; Save it before entering this routine
        LD      DE,(0E129h)     ; Get temp Add/Subtract location
        PUSH    DE              ; Save it before entering this routine
        LD      DE,L0000        ; DE = 00000h
        LD      (0E127h),DE     ; Erase Temp Add/Subtract location
        LD      (0E129h),DE     ; Erase Temp Add/Subtract location
        LD      HL,0E1A1h       ; HL = Coins Inserted Left
        LD      A,(0E192h)      ; Get Button Data
;----------------------------------------------------
;           Check Left Coin Slot 
;----------------------------------------------------
        BIT     0,A             ; Test Left Coin Slot
        JR      Z,L1193         ; No Coins so skip ahead        
;----------------------------------------------------
;         Coin Inserted in Left Slot
;----------------------------------------------------
        RES     0,A             ; Clear Left Coin Slot
        EX      AF,AF'          ; Save Button Data
        INC     (HL)            ; Increment Coins Inserted Left
        LD      DE,0E0A4h       ; Get Left Coin Count (Ones)
        LD      A,001h          ; A = 1
        LD      (0E12Ah),A      ; Put 1 Coin
        CALL    L0FB0           ; Call 2-digit BCD Addition
        RET                     ; Return

        CALL    L10E5           ; Sum Total Coins
        EX      AF,AF'          ; Recall Button Data
L1193:  LD      HL,0E1A2h       ; HL = Get Coins Inserted Right
;----------------------------------------------------
;            Check Right Coin Slot 
;----------------------------------------------------
        BIT     1,A             ; Test Right Coin Slot
        JR      Z,L11AD         ; No Coins so skip ahead       
;----------------------------------------------------
;         Coin Inserted in Right Slot
;----------------------------------------------------
        RES     1,A             ; Clear Right Coin Slot
        EX      AF,AF'          ; Save Button Data
        INC     (HL)            ; Increment Coins Inserted Right
        LD      DE,0E0A6h       ; Get Right Coin Count (Ones)
        LD      A,001h          ; A = 1
        LD      (0E12Ah),A      ; Put 1 Coin
        CALL    L0FB0           ; Call 2-digit BCD Addition 
        CALL    L10E5           ; Sum Total Coins
        EX      AF,AF'          ; Recall Button Data

L11AD:  LD      (0E192h),A      ; Save Button Data
        CALL    L11C0           ; Award Credits for Coins
        CALL    L1254           ;
        POP     DE              ; Get temp Add/Subtract location
        LD      (0E129h),DE     ; Restore Add/Subtract location
        POP     HL              ; Get temp Add/Subtract location
        LD      (0E127h),HL     ; Restore Add/Subtract location
        RET                     ; Return







;----------------------------------------------------
;   Check DIP Settings and Award Credits for Coins
;----------------------------------------------------
;                 24   25   Right
;                 20   21   Left
;                 -------------------
;                 OFF  OFF    2 Coins
;                 ON   OFF    2 Coins
;                 OFF  ON     3 Coins
;                 ON   ON     4 Coins
;----------------------------------------------------
L11C0:  LD      DE,0E1A1h       ; DE = Coins Inserted Left
        LD      A,(0E1A3h)      ; Get x
        LD      C,A             ; C = x
        LD      A,(0E189h)      ; Get DIP Switches 20-27
        RRCA                    ; Get Coin Settings
        RRCA                    ; Get Coin Settings
        RRCA                    ; Get Coin Settings
        RRCA                    ; Get Coin Settings
        AND     003h            ; Isolate Right Coin/Credit Setting 24-25
        LD      B,A             ; B = Right Coins/Credit Setting
        LD      A,(0E189h)      ; Get DIP Switches 20-27
        AND     003h            ; Isolate Left Coin/Credit Settings 20-21
        CP      B               ; Compare Left settings to Right Settings
        JR      NZ,L11E6        ; Coin/Credit settings differ so jump ahead       
;----------------------------------------------------
;         Total both Coins into Left Coin 
;----------------------------------------------------
;  IF BOTH COIN CHUTES ARE ADJUSTED THE SAME FOR MULTIPLE
;  COINS, CREDITS WILL INCREASE AS IF DROPPED IN SAME CHUTE
;----------------------------------------------------
        EX      AF,AF'          ; Save Coin/Credit Setting
        EX      DE,HL           ; HL = Coins Inserted Left
        LD      A,(0E1A2h)      ; A = Coins Inserted Right
        ADD     A,(HL)          ; Add Right Coins to Left Coins
        LD      (HL),A          ; Store Total into Left Coins Inserted
        EX      DE,HL           ; Restore HL Register
        XOR     A               ; A = 0
        LD      (0E1A2h),A      ; Zero Coins Inserted Right
        EX      AF,AF'          ; Recall Coin/Credit Settings

L11E6:  CALL    L1205           ; ??
        LD      A,C             ; A = x
        LD      (0E1A3h),A      ; Save x
        LD      DE,0E1A2h       ; DE = Coins Inserted Right
        LD      A,(0E1A4h)      ;
        LD      C,A             ;
        LD      A,(0E189h)      ; Get DIP Switches 20-27
        RRCA                    ;
        RRCA                    ;
        RRCA                    ;
        RRCA                    ;
        AND     003h            ;
        CALL    L1205           ;
        LD      A,C             ;
        LD      (0E1A4h),A      ;
        RET                     ; Return







;----------------------------------------------------
;           Coins per Credit
;----------------------------------------------------
;        A = Coins/Settings (0,1,2,3)
;       DE = Coins Inserted Left
;----------------------------------------------------
L1205:  LD      HL,0129Dh       ; HL = Pointer to Bank12 table
        LD      B,A             ; B = Coin Setting (0,1,2,3)
        OR      A               ; Is Coin Setting 0?
        JR      Z,L1214         ; Yes, so use Award Cycle 1      
        PUSH    DE              ; Save DE Register
        LD      DE,0000Ch       ; DE = 12 Bytes per Award Cycle
L1210:  ADD     HL,DE           ; HL = Correct Award Cycle
        DJNZ    L1210           ; Loop until correct Award Cycle        
        POP     DE              ; Restore DE Register
L1214:  LD      A,(DE)          ; A = Coins Inserted Left
        OR      A               ; Are there any coins?
        RET     Z               ; No coins so return
        ADD     HL,BC           ; Add BC index into Award Cycle
        XOR     A               ; A = 0

;----------------------------------------------------
;    Award Credits while there are Coins in Left Slot
;----------------------------------------------------
L1219:  ADD     A,(HL)          ; Add Number of Coins in Table
        EX      AF,AF'          ; Save table total
        LD      A,C             ; A = x
        CP      00Bh            ; Is x = 11?
        JR      NZ,L122A        ; No, so skip ahead        
        PUSH    DE              ; Save DE Register
        LD      DE,0000Ch       ; BE = 12 bytes per Award Cycle
        XOR     A               ; Clear Carry
        SBC     HL,DE           ; Go to previous bank
        LD      C,0FFh          ; C = 255
        POP     DE              ; Recall DE Register
L122A:  INC     C
        INC     HL              ; Point to next spot in table
        PUSH    HL              ; Save table Pointer
        LD      HL,0E1A5h       ;
        INC     (HL)
        POP     HL              ; Recall table Pointer
        EX      AF,AF'
        EX      DE,HL           ; Get Coins Inserted Left
        DEC     (HL)            ; Subtract 1 coin
        EX      DE,HL           ; Restore Registers
        JR      NZ,L1219        ; More coins left so keep looping

        CALL    L123C           ; Award Credits and Beep
        RET                     ; Return     








;----------------------------------------------------
;             Award Credits and Beep
;----------------------------------------------------
;          A = Number of credits to award
;----------------------------------------------------
L123C:  LD      B,A             ; B = Number of Credits to award
        OR      A               ; Is it zero?
        RET     Z               ; Yes, no credits to award so return
        LD      A,(0E1A8h)      ; A = Number of Credits
        CP      099h            ; Are there 99 credits?
        RET     Z               ; Yes, so just return
        ADD     A,B             ; Add to Number of Credits
        DAA                     ; Make BCD
        JR      NC,L124B        ; Still less than 99 so skip ahead          
        LD      A,099h          ; Set Number of Credits = 99
L124B:  LD      (0E1A8h),A      ; Store Number of Credits
        LD      A,002h          ; ?
        CALL    GoodBeep        ; Sound GoodBeep
        RET                     ; Return





;----------------------------------------------------
;               Unknown
;----------------------------------------------------
L1254:  LD      A,(0E1A6h)
        BIT     0,A
        JR      Z,L1282                 
        LD      A,(0E1A7h)
        OR      A
        JR      Z,L1266                 
        DEC     A
        LD      (0E1A7h),A
        RET     


L1266:  LD      A,(0E1A6h)
        BIT     1,A
        JR      Z,L127C                 
        RES     1,A
        LD      (0E1A6h),A
        RES     6,A
        OUT     (068h),A
        LD      A,00Ch
        LD      (0E1A7h),A
        RET     


L127C:  RES     0,A
        LD      (0E1A6h),A
        RET     


L1282:  LD      A,(0E1A5h)
        OR      A
        RET     Z
        DEC     A
        LD      (0E1A5h),A
        XOR     A
        SET     0,A
        SET     1,A
        LD      (0E1A6h),A
        SET     6,A
        OUT     (068h),A
        LD      A,004h
        LD      (0E1A7h),A
        RET     


;----------------------------------------------------
;               Award Cycles  
;----------------------------------------------------
;            1 Coin per Credit
;----------------------------------------------------
L129D:  .DB   001h
        .DB   001h
        .DB   001h
        .DB   001h
        .DB   001h
        .DB   001h
        .DB   001h
        .DB   001h
        .DB   001h
        .DB   001h
        .DB   001h
        .DB   001h
;----------------------------------------------------
;            2 Coins per Credit
;----------------------------------------------------
        .DB   000h, 001h
        .DB   000h, 001h
        .DB   000h, 001h
        .DB   000h, 001h
        .DB   000h, 001h
        .DB   000h, 001h
;----------------------------------------------------
;            3 Coins per Credit
;----------------------------------------------------
        .DB   000h, 000h, 001h
        .DB   000h, 000h, 001h
        .DB   000h, 000h, 001h
        .DB   000h, 000h, 001h
;----------------------------------------------------
;            4 Coins per Credit
;----------------------------------------------------
        .DB   000h, 000h, 000h, 001h
        .DB   000h, 000h, 000h, 001h
        .DB   000h, 000h, 000h, 001h








;----------------------------------------------------
;                ROM0 Copyright 
;----------------------------------------------------
L12CD:   .DB   010h 
L12CE:   .TEXT "COPYRIGHT STERN ELECTRONICS, INC."






;----------------------------------------------------
;              Check Buy-In Feature
;----------------------------------------------------
L12F0:  LD      A,(0E18Ch)      ; Get DIP Switches 12-19
        BIT     7,A             ; Check BUY-IN feature
        RET     Z               ; No BUY-IN so just return
L12F6:  LD      A,(0E126h)      ; Get Control Register      ;
        BIT     1,A             ;
        JR      NZ,L12F6        ;        
        LD      A,(0E126h)      ; Get Control Register
        BIT     4,A             ;
        JR      NZ,L1311        ;        
;----------------------------------------------------
;             Send PAUSE Command
;----------------------------------------------------
        LD      A,00Ah          ; Command = PAUSE (0Ah)
        CALL    L207F           ; Send Message to LDPlayer DI
        LD      A,(0E126h)      ; Get Control Register
        SET     4,A             ; Set PAUSE Bit
        LD      (0E126h),A      ; Save Control Register
L1311:  PUSH    IY              ;
        PUSH    DE              ;
        PUSH    BC              ;
        CALL    L2392           ;
        CALL    L22F5           ; Program Graphics Chip
        LD      A,0FDh          ; Text = WHITE, Bkgnd = PURPLE
        CALL    L20CA           ; Setup Graphics Chip for Text
        CALL    L21FF           ; Clear Text Display

        LD      C,000h          ; Loop = 0
L1325:  LD      A,C             ; A = Rectangle #
        CALL    L575D           ; Draw programmed rectangle

        LD      B,005h          ; Loop = 5
L132B:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L132B           ; Loop for 5 Comm's

        INC     C               ; Increment loop
        LD      A,C             ; Check loop
        CP      005h            ; Is loop at 5 yet?
        JR      C,L1325         ; No, continue with loop
                         
L1336:  PUSH    HL              ; Save HL Register
        LD      HL,00127h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L133D:  .TEXT   "PLAYER #  "
        .DB   000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        LD      A,(0E1A9h)      ; Get Player Number
        AND     003h            ; Decode number
        OR      030h            ; Create printable character A
        CALL    L2256           ; Print A to Text Display  
        PUSH    HL              ; Save HL Register
        LD      HL,00170h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L135A:  .TEXT   "If you wish to continue"
        .DB   000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0019Bh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L137A:  .TEXT   "playing this level"
        .DB   000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        LD      A,(0E1A8h)      ; Get Number of Credits
        OR      A               ; Check if any credits left
        JR      NZ,L13B6        ; Credits left so skip ahead       
        PUSH    HL              ; Save HL Register
        LD      HL,001E7h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L139B:  .TEXT   "Insert required coins and"
        .DB     000h
;----------------------------------------------------        
        POP     HL              ; Restore HL Register
L13B6:  PUSH    HL              ; Save HL Register
        LD      HL,00239h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L13BD:  .TEXT   "Press Player 1 button"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,002B0h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L13DB:  .TEXT   "Time left to buy-in :  9"
        .DB     000h
;----------------------------------------------------
L13F4:  POP     HL              ; Restore HL Register
        CALL    Delay100000     ; Call Delay 100,000
        CALL    L1538           ;
        PUSH    HL              ; Save HL Register
L13FC:  LD      HL,002B0h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L1402:  .TEXT   "Time left to buy-in :  8"
        .DB     000h
;----------------------------------------------------            
L141B:  POP     HL              ; Restore HL Register
        CALL    Delay100000     ; Call Delay 100,000
        CALL    L1538           ;
        PUSH    HL              ; Save HL Register
        LD      HL,002B0h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L1429:  .TEXT   "Time left to buy-in :  7"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        CALL    Delay100000     ; Call Delay 100,000
        CALL    L1538           ;
        PUSH    HL              ; Save HL Register
        LD      HL,002B0h       ; Cursor Position
L144D:  CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L1450:  .TEXT   "Time left to buy-in :  6"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        CALL    Delay100000     ; Call Delay 100,000
        CALL    L1538           ;
        PUSH    HL              ; Save HL Register
        LD      HL,002B0h       ; Cursor Position
L1474:  CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L1476:  .TEXT   "Time left to buy-in :  5"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        CALL    Delay100000     ; Call Delay 100,000
        CALL    L1538
        PUSH    HL              ; Save HL Register
        LD      HL,002B0h       ; Cursor Position
L149B:  CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L149E:  .TEXT   "Time left to buy-in :  4"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        CALL    Delay100000     ; Call Delay 100,000
        CALL    L1538
        PUSH    HL              ; Save HL Register
        LD      HL,002B0h       ; Cursor Position
L14C2:  CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L14C5:  .TEXT   "Time left to buy-in :  3"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        CALL    Delay100000     ; Call Delay 100,000
        CALL    L1538           ;
        PUSH    HL              ; Save HL Register
        LD      HL,002B0h       ; Cursor Position
L14E9:  CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L14EC:  .TEXT   "Time left to buy-in :  2"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        CALL    Delay100000     ; Call Delay 100,000
        CALL    L1538           ;
        PUSH    HL              ; Save HL Register
        LD      HL,002B0h       ; Cursor Position
L1510:  CALL    L2212           ; Set Cursor and Print Text 
;----------------------------------------------------
L1513:  .TEXT   "Time left to buy-in :  1"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        CALL    Delay100000     ; Call Delay 100,000
        CALL    L1538           ;
L1533:  POP     BC              ; Restore BC Register
        POP     DE              ; Restore DE Register
L1535:  POP     IY              ; Restore IY Register
L1537:  RET                     ; Return






;----------------------------------------------------
;                Buy-In Timer
;----------------------------------------------------
L1538:  LD      A,(0E18Ch)      ; Get DIP Switches 12-19
L153B:  BIT     2,A             ; Check FREE PLAY (sw 14)
        JR      NZ,L1544        ; FREE PLAY set so skip credit check
;----------------------------------------------------
;            Check if there are any credits   
;----------------------------------------------------          
        LD      A,(0E1A8h)      ; Get Number of Credits
        OR      A               ; Check Number of Credits
        RET     Z               ; No credits so return
L1544:  LD      A,(0E192h)      ; Get Button Data
;----------------------------------------------------
;              Check for Player1 Button
;----------------------------------------------------
        BIT     2,A             ; Check PLAYER1 Button pressed
        RET     Z               ; Not pressed so return
L154A:  RES     2,A             ; Clear PLAYER1 Button press
        LD      (0E192h),A      ; Save modified Button Data

        LD      DE,00000h       ;
        LD      (0E127h),DE     ;
        LD      DE,0E0A2h       ;
        LD      A,001h          ;
        LD      (0E12Ah),A      ;
L155E:  CALL    L0FA1           ; Call 3-Digit Addition
        CALL    L10E5           ; Sum Total Coins
        CALL    L1F55           ;
        CALL    L1F70           ; Add Number of Lives per Credit
        INC     SP              ;
L156B:  INC     SP              ;
        JP      L1533           ;








;----------------------------------------------------
;             Update Bookkeeping Data  
;----------------------------------------------------
;         Add Game Timer to Total Play Time  
;----------------------------------------------------
L156F:  XOR     A               ; A = 0
        LD      (0E127h),A      ; Store zero in thousands
        LD      HL,(0E1C4h)     ; Get Game Play Timer
        LD      (0E128h),HL     ; Store in temp add location
        LD      A,(0E1C6h)      ; Get Game Play Timer
        LD      (0E12Ah),A      ; Store in temp add location
        LD      DE,0E0AAh       ; DE = Bookkeeping Total Play Time (ones)
        CALL    L0FA1           ; Call 3-Digit Addition
;----------------------------------------------------
;         Check for Longest Game Play Time  
;----------------------------------------------------
L1585:  LD      B,003h          ; 3 digits to check
        LD      DE,0E1C4h       ; DE = Game Play Time
        LD      HL,0E0ABh       ; HL = Longest Time
L158D:  LD      A,(DE)          ; Get Game Play Time digit
        CP      (HL)            ; Compare it to Longest
        JR      C,L15A7         ; Less than longest, so check shortest       
        JR      Z,L1596         ; Digits equal check next digit        
        JP      NC,L159C        ; Time is longest, so save it
L1596:  INC     DE              ; Compare next digit - Game Play Time
        INC     HL              ; Compare next digit - Longest Time
        DJNZ    L158D           ; Loop until all digits compared        
        JR      L15A7           ; Compare complete, check for shortest        
;----------------------------------------------------
;       Recored the new Longest Game Play Time
;----------------------------------------------------
L159C:  LD      BC,00003h       ; 3 bytes to copy
        LD      DE,0E0ABh       ; Destination = Longest Time
        LD      HL,0E1C4h       ; Source = Game Play Time
        LDIR                    ; Copy all bytes

;----------------------------------------------------
;        Check for Shortest Game Play Time  
;----------------------------------------------------
L15A7:  LD      DE,0E1C4h       ; DE = Game Play Time
        LD      HL,0E0AEh       ; DL = Shortest Time
        LD      A,(DE)          ; Get digit Game Play Time
        CP      000h            ; Is hundreds digit zero?
        JR      NZ,L15C4        ; No, so check scene       
        INC     DE              ; Next digit
        LD      A,(DE)          ; Get digit Game Play Time
        CP      000h            ; Is tens digit zero?
        JR      NZ,L15C4        ; No, so check scene       
        INC     DE              ; Next digit
        LD      A,(DE)          ; Get digit Game Play Time
        CP      000h            ; Is ones digit zero?
        JR      Z,L15C4         ; Yes so check scene
        CP      (HL)            ; Compare digit to shortest time
        JR      Z,L15C3         ; Equal times so save       
        JR      NC,L15C4        ; Time not shorter than shorts so check scene
L15C3:  LD      (HL),A          ; Save shortest time

;----------------------------------------------------
;          Check for Highest Scene Reached  
;----------------------------------------------------
L15C4:  LD      HL,0E0AFh       ; HL = Highest Scene
        LD      A,(0E1B6h)      ; Get current scene reached
        CP      (HL)            ; Compare to the highest
        JR      C,L15CE         ; Not greater than highest so jump ahead       
        LD      (HL),A          ; Save as new high scene

;----------------------------------------------------
;              Update Range of Times  
;----------------------------------------------------                                
L15CE:  CALL    L10EC           ; Calculate Sum of Play Times
        LD      B,00Eh          ; Loop = 14 ranges
        LD      HL,0E0D1h       ; First Range = 0 - 1 Minutes
L15D6:  LD      A,060h          ; A = 60 seconds (1 minute)
        LD      (0E12Ah),A      ; Store in temporary subtraction location
        LD      DE,0E1C6h       ; DE = Play Time Minutes
;----------------------------------------------------
;   Find range of time by subtracting 1 minute from
;   Game Timer until timer goes negative.  
;----------------------------------------------------
        PUSH    HL              ; Save HL Register
        PUSH    BC              ; Save BC Register
        CALL    L0FCC           ; Call 3-Digit Subtraction (1 minute)
        POP     BC              ; Restore BC Register
        POP     HL              ; Restore HL Register

        JR      C,L15EB         ; Time range found so skip ahead       
        INC     HL              ; Next range of times
        INC     HL              ; Next range of times
        DJNZ    L15D6           ; Loop until all 14 time ranges checked        

;----------------------------------------------------
;         Increment count for Time Range  
;----------------------------------------------------
L15EB:  LD      A,001h          ; Add 1
        LD      (0E12Ah),A      ; Put 1 in temporary addition location
        EX      DE,HL           ; 
        PUSH    DE              ;
        CALL    L0FB0           ; Call 2-digit BCD Addition
        POP     HL              ; Restore HL Register
        JR      NC,L15FD        ;        
        LD      (HL),099h       ;
        DEC     HL              ;
        LD      (HL),099h       ;

L15FD:  CALL    L10FA           ;
        LD      B,00Eh          ;
        LD      HL,0E0F0h       ;
        LD      A,(0E1B6h)      ;
L1608:  SUB     001h            ;
        DAA                     ;
        JR      Z,L1611         ;        
        INC     HL              ;
        INC     HL              ;
        DJNZ    L1608           ;        
L1611:  LD      A,001h          ;
        LD      (0E12Ah),A      ;
        EX      DE,HL           ;
        PUSH    DE              ;
        CALL    L0FB0           ; Call 2-digit BCD Addition
        POP     HL              ; Restore HL Register
        JR      NC,L1623        ;        
        LD      (HL),099h       ;
        DEC     HL              ;
        LD      (HL),099h       ;
L1623:  CALL    L1101           ;
        RET                     ; Return









;----------------------------------------------------
;             Reset Bookkeeping Data
;----------------------------------------------------
;         Reset Bookkeeping Game Play Totals
;----------------------------------------------------
L1627:  LD      B,008h          ; 8 bytest to sum
        LD      HL,0E0A0h       ; HL = Total Play Count
        CALL    L110C           ; Calculate Sum of bytes 
        INC     A               ; Check sum
        JR      Z,L163A         ; Bytes already zero so skip ahead  
        LD      B,008h          ; 8 bytes to erase
        LD      HL,0E0A0h       ; HL = Total Play Count
        CALL    L1687           ; Call Erase Bytes
;----------------------------------------------------
;             Reset Play Times Data
;----------------------------------------------------
L163A:  LD      B,009h          ; 9 bytes to sum
        LD      HL,0E0A8h       ; HL = Play Times
        CALL    L110C           ; Calculate Sum of bytes 
        INC     A               ; Check sum
        JR      Z,L1652         ; Bytes already zero so skip ahead       
        LD      B,009h          ; 9 bytes to erase
        LD      HL,0E0A8h       ; HL = Play Times
        CALL    L1687           ; Call Erase Bytes
        LD      HL,0E0AEh       ; Get Shortest Game Time
        LD      (HL),099h       ; Shortest Game Time = 99sec
;----------------------------------------------------
;            Reset Range of Scores Data
;----------------------------------------------------
L1652:  LD      B,01Fh          ; 31 bytes to sum
        LD      HL,0E0B1h       ; HL = Range of Scores
        CALL    L110C           ; Calculate Sum of bytes
        INC     A               ; Check the sum
        JR      Z,L1665         ; Bytes already zero so skip ahead
        LD      B,01Fh          ; 31 bytes to erase
        LD      HL,0E0B1h       ; HL = Range of Scores
        CALL    L1687           ; Call Erase Bytes
;----------------------------------------------------
;             Reset Range of Times Data
;----------------------------------------------------
L1665:  LD      B,01Fh          ; 31 bytes to sum
        LD      HL,0E0D0h       ; HL = Range of Times
        CALL    L110C           ; Calculate Sum of bytes
        INC     A               ; Check the sum
        JR      Z,L1678         ; Bytes already zero so skip ahead
        LD      B,01Fh          ; 31 bytes to erase
        LD      HL,0E0D0h       ; HL = Range of Times
        CALL    L1687           ; Call Erase Bytes
;----------------------------------------------------
;            Reset Range of Scenes Data
;----------------------------------------------------
L1678:  LD      B,01Fh          ; 30 bytes to sum
        LD      HL,0E0EFh       ; HL = Range of Scenes
        CALL    L110C           ; Calculate Sum of bytes      
        INC     A               ; Check the sum
        RET     Z               ; Bytes already zero so return
        LD      B,01Fh          ; 31 bytes to erase
        LD      HL,0E0EFh       ; HL = Range of Scenes
;----------------------------------------------------
;          Reset Bookkeeping bytes to zero
;----------------------------------------------------
L1687:  XOR     A               ; A = 0
L1688:  LD      (HL),A          ; Reset Bookkeeping byte
        INC     HL              ; Point to next Bookkeeping byte
        DJNZ    L1688           ; Loop until all bytes reset
        RET                     ; Return







;----------------------------------------------------
;                 unknown
;----------------------------------------------------
L168D:  PUSH    IY              ; Save IY Register
        PUSH    DE              ; Save DE Register
        PUSH    BC              ; Save BC Register
        CALL    L2392           ;
        CALL    L22F5           ; Program Graphics Chip
        LD      A,0F4h          ; Text = WHITE, Bkgnd = DK_BLUE
        CALL    L20CA           ; Setup Graphics Chip for Text
        CALL    L21FF           ; Clear Text Display
        LD      A,(0E126h)      ; Get Control Register
        BIT     0,A             ;
        CALL    NZ,L16BF        ; Yes, so show Gameplay Instructions
        LD      C,000h          ;
L16A9:  LD      A,C             ;
        CALL    L575D           ; Draw programmed rectangle

        LD      B,005h          ; Loop = 5
L16AF:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L16AF           ; Loop for 5 Comm's

        INC     C               ;
        LD      A,C             ;
        CP      002h            ;
        JR      C,L16A9         ;        
        POP     BC              ; Restore BC Register
        POP     DE              ; Restore DE Register
        POP     IY              ; Restore IY Register
        RET                     ; Return










;----------------------------------------------------
;             Show Gameplay Instructions
;----------------------------------------------------
L16BF:  CALL    L2353           ; Wait for Comm Ready
        PUSH    HL              ; Save HL Register
        LD      HL,00080h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L16C9:  .TEXT   "Move the joystick in the"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        CALL    L2353           ; Wait for Comm Ready
        PUSH    HL              ; Save HL Register
        LD      HL,000A7h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L16ED:  .TEXT   "direction Cliff or his car"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        CALL    L2353           ; Wait for Comm Ready
        PUSH    HL              ; Save HL Register
        LD      HL,000D2h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L1713:  .TEXT   "moves on the screen"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        CALL    Delay10000      ; Call Delay 10,000
        CALL    L2353           ; Wait for Comm Ready
        PUSH    HL              ; Save HL Register
        LD      HL,0016Eh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L1735:  .TEXT   "Stick right if object moves"
        .DB     000h
;----------------------------------------------------     
        POP     HL              ; Restore HL Register
        CALL    L2353           ; Wait for Comm Ready
        PUSH    HL              ; Save HL Register
        LD      HL,00196h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L175C:  .TEXT   "toward right edge of screen"
        .DB     000h
;----------------------------------------------------     
        POP     HL              ; Restore HL Register
        CALL    Delay10000      ; Call Delay 10,000
        CALL    Delay10000      ; Call Delay 10,000
        CALL    L2353           ; Wait for Comm Ready
        PUSH    HL              ; Save HL Register
        LD      HL,001E7h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L1789:  .TEXT   "Stick left if object moves"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        CALL    L2353           ; Wait for Comm Ready
        PUSH    HL              ; Save HL Register
        LD      HL,0020Fh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L17AF:  .TEXT   "toward left edge of screen"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        CALL    Delay10000      ; Call Delay 10,000
        CALL    Delay10000      ; Call Delay 10,000
        CALL    L2353           ; Wait for Comm Ready
        PUSH    HL              ; Save HL Register
        LD      HL,00260h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L17DB:  .TEXT   "Stick up if object moves"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        CALL    L2353           ; Wait for Comm Ready
        PUSH    HL              ; Save HL Register
        LD      HL,00286h       ; Cursor Position
L17FC:  CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L17FF:  .TEXT   "toward upper edge of screen"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        CALL    Delay10000      ; Call Delay 10,000
        CALL    Delay10000      ; Call Delay 10,000
        CALL    L2353           ; Wait for Comm Ready
        PUSH    HL              ; Save HL Register
        LD      HL,002D7h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L182C:  .TEXT   "Stick down if object moves"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        CALL    L2353           ; Wait for Comm Ready
        PUSH    HL              ; Save HL Register
        LD      HL,002FEh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L1852:  .TEXT   "toward bottom edge of screen"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        CALL    Delay10000      ; Call Delay 10,000
        CALL    Delay10000      ; Call Delay 10,000
        RET                     ; Return









;----------------------------------------------------
;             Check for High Score  
;----------------------------------------------------
L1877:  LD      IX,0E137h       ;
        LD      IY,0E050h       ; IY = Pointer to High Score Table
        LD      DE,00008h       ; DE = 8 digits to check in score
        LD      B,00Ah          ; B = 10 High scores to check
L1884:  LD      HL,0E1AAh       ; HL = Score

        LD      A,(HL)          ; Get Score digit
L1888:  INC     HL              ; Point to next score digit
        CP      (IY+003h)       ; Compare to High Score
        JR      C,L18B6                 
        JR      Z,L1893         ; Digits equal, check next digit        
        JP      NC,L18BD

L1893:  LD      A,(HL)
        INC     HL
        CP      (IY+004h)
        JR      C,L18B6         ;        
        JR      Z,L189F         ; Digits equal, check next digit        
        JP      NC,L18BD

L189F:  LD      A,(HL)
        INC     HL
L18A1:  CP      (IY+005h)
        JR      C,L18B6                 
        JR      Z,L18AB         ; Digits equal, check next digit                 
        JP      NC,L18BD

L18AB:  LD      A,(HL)
        CP      (IY+006h)
L18AF:  JR      C,L18B6         ; Score  , check next score       
        JR      Z,L18B6         ; Scores are equal, check next score       
        JP      NC,L18BD

L18B6:  ADD     IY,DE
        DJNZ    L1884                   
        JP      L1C00

L18BD:  LD      HL,0E192h       ; Get Button Data
        RES     4,(HL)          ; Clear HAND-Right press
        RES     5,(HL)          ; Clear HAND-Left press
        LD      HL,0E098h
        LD      A,020h
        LD      (HL),A
        INC     HL
        LD      (HL),A
        INC     HL
        LD      (HL),A
        LD      BC,00004h
        LD      DE,0E09Bh
        LD      HL,0E1AAh
        LDIR    
        CALL    L1BB0
L18DC:  JP      NZ,L1BC3
        CALL    L21FF           ; Clear Text Display
        LD      A,(0E1A9h)      ; Get Player Number
        CP      001h            ; Is it Player 1?
        LD      A,060h          ; Player1, Text = DK_RED, Bkgnd = TRANS
        JR      Z,L18ED         ; Skip ahead       
        LD      A,040h          ; Player2, Text = BLUE, Bkgnd = TRANS
L18ED:  CALL    L20CA           ; Setup Graphics Chip for Text
        PUSH    HL              ; Save HL Register    
        LD      HL,00030h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L18F7:  .TEXT   "CONGRATULATIONS PLAYER "
        .DB     000h
;----------------------------------------------------
L190F:  POP     HL              ; Restore HL Register
        LD      A,(0E1A9h)      ; Get Player Number
        AND     003h            ; Decode number
        OR      030h            ; Create printable character A
        CALL    L2256           ; Print A to Text Display
        PUSH    HL              ; Save HL Register
        LD      HL,00081h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L1921:  .TEXT   "YOUR SCORE "
        .DB     000h
;----------------------------------------------------                        
L192D:  POP     HL              ; Restore HL Register
        LD      BC,00400h       ;
        LD      DE,01403h       ; Location X = 20, Y = 3
        LD      HL,0E1AAh       ; Number = Score
        CALL    L2269           ; Print 8-digit number
        PUSH    HL              ; Save HL Register
        LD      HL,000D0h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L1941:  .TEXT   "IS IN THE TOP TEN SCORES"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00147h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L1962:  .TEXT   "PLEASE ENTER YOUR INITIALS"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        LD      HL,01B83h       ; HL = Pointer to alphabet
        PUSH    DE
        EX      DE,HL
        LD      HL,001BDh
        LD      A,01Eh
        CALL    L2224
        POP     DE
        LD      HL,01BA1h
        PUSH    DE
        EX      DE,HL
        LD      HL,0021Ah
        LD      A,005h
        CALL    L2224
        POP     DE
        LD      HL,01BA6h
        PUSH    DE
        EX      DE,HL
        LD      HL,00242h
        LD      A,005h
L19A4:  CALL    L2224
L19A7:  POP     DE
        LD      HL,01BABh
        PUSH    DE
        EX      DE,HL
        LD      HL,0026Ah
        LD      A,005h
        CALL    L2224
        POP     DE
        PUSH    HL              ; Save HL Register
        LD      HL,002B6h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L19BD:  .TEXT   "YOU CAN USE"
        .DB     000h
;----------------------------------------------------
L19C9:  POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,002FDh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L19D1:  .TEXT   "THE JOYSTICK TO SELECT LETTERS"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00354h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L19F8:  .TEXT   "BUT YOU MUST USE"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0039Fh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L1A11:  .TEXT   "YOUR HANDS TO ENTER THEM."
        .DB     000h
;----------------------------------------------------        
        POP     HL              ; Restore HL Register
        LD      (IX+001h),0FFh  ;
        LD      (IX+002h),001h  ;
        LD      (IX+000h),00Fh  ;

L1A38:  LD      B,00Ah          ; Loop = 10
L1A3A:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L1A3A           ; Loop for 10 Comm's

        CALL    L1BB0           ;
        JP      NZ,L1BC3        ;
        DEC     (IX+001h)       ;
        JP      Z,L1BC3         ;
        LD      A,(0E196h)      ; Get Joystick Input
L1A4E:  BIT     3,A             ; Is Joystick LEFT pressed?
        JP      NZ,L1A5B        ; Yes, so move left
        BIT     1,A             ; Is Joystick RIGHT pressed?
        JP      NZ,L1A7C        ; Yes, so move right
        JP      L1A9B

L1A5B:  LD      (IX+001),05Ah
L1A5F:  LD      A,(IX+000)
        OR      A
        JR      NZ,L1A71                
L1A65:  LD      A,020h
        CALL    L1B75
        LD      (IX+000),01Dh
        JP      L1A9B

L1A71:  LD      A,020
        CALL    L1B75
        DEC     (IX+000)
        JP      L1A9B

L1A7C:  LD      (IX+001),05A
        LD      A,(IX+000)
        CP      01D
        JR      C,L1A93                 
        LD      A,020
        CALL    L1B75
        LD      (IX+000),001
        JP      L1A9B

L1A93:  LD      A,020
        CALL    L1B75
        INC     (IX+000)

L1A9B:  LD      A,05Eh
        CALL    L1B75
        CALL    L1B30
;----------------------------------------------------
;          Check if HAND button is pressed
;----------------------------------------------------
        LD      HL,0E192h       ; Get Button Data
        BIT     4,(HL)          ; Is HAND-Right pressed?
        RES     4,(HL)          ; Clear HAND-Right press
        JP      NZ,L1AB4        ; Yes, pressed so skip ahead
        BIT     5,(HL)          ; Is HAND-Left pressed?
        RES     5,(HL)          ; Clear HAND-Left press
        JP      Z,L1A38         ; No, so loop back

L1AB4:  LD      HL,01B83h       ; HL = Pointer to alphabet
        LD      D,000h
        LD      E,(IX+000h)
        ADD     HL,DE
        LD      A,(HL)
        CP      05F
        JP      Z,L1ACD
        INC     (IX+002)
        LD      (IX+001),05A
        JP      L1A38

L1ACD:  LD      (IX+001),078
        LD      A,(IX+002)
        CP      001
        JP      Z,L1A38
        DEC     A
        LD      (IX+002),A
        LD      A,020
        CALL    L1B75
        LD      (IX+000),000
        LD      A,05E
        CALL    L1B75
        LD      A,(IX+002)
        CP      003
        JP      Z,L1B1E
        CP      002
        JP      Z,L1B0F
        CP      001
        JP      Z,L1B00
        JP      L1A38

L1B00:  PUSH    HL              ; Save HL Register
        LD      HL,00243h
        CALL    L2212           ; Set Cursor and Print Text
        JR      NZ,L1B09                
L1B09:  POP     HL
        LD      A,020h
        LD      (0E098h),A
L1B0F:  PUSH    HL              ; Save HL Register
        LD      HL,00244h
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
        .TEXT   " "
        .DB     000h
;----------------------------------------------------               
L1B18:  POP     HL
        LD      A,020
        LD      (0E099),A

L1B1E:  PUSH    HL              ; Save HL Register
        LD      HL,00245
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
        .TEXT   " "
        .DB     000h
;----------------------------------------------------            
L1B27:  POP     HL
        LD      A,020h
        LD      (0E09Ah),A
        JP      L1A38

L1B30:  LD      D,000h
        LD      E,(IX+000h)
        LD      HL,01B83h       ; HL = Pointer to alphabet
        ADD     HL,DE
        LD      B,(HL)
        LD      DE,0120Eh
        LD      A,(IX+002)
        ADD     A,D
        LD      D,A
        LD      A,(IX+002)
        CP      000h
        JP      Z,L1B5D
        CP      001h
        JP      Z,L1B61
        CP      002h
        JP      Z,L1B67
        CP      003h
        JP      Z,L1B6D
        POP     AF
        JP      L1BC3

L1B5D:  POP     AF
        JP      L1A38

L1B61:  LD      A,B
        LD      (0E098h),A
        JR      L1B71                   

L1B67:  LD      A,B
        LD      (0E099h),A
        JR      L1B71                   

L1B6D:  LD      A,B
        LD      (0E09Ah),A

L1B71:  CALL    L2233           ; Print one Character to Text Display
        RET                     ; Return


L1B75:  PUSH    AF              ;
        LD      DE,0050Ch       ;
        LD      A,(IX+000h)     ;
        ADD     A,D             ;
        LD      D,A             ;
        POP     AF              ;
        CALL    L2233           ; Print one Character to Text Display
        RET                     ; Return





;----------------------------------------------------
;                Alphabet text
;----------------------------------------------------
L1B83:  .TEXT   "abcdefghijklmnopqrstuvwxyz"

        .DB   020h, 02Ah, 03Fh, 05Fh
;----------------------------------------------------
;            Rectangle Characters
;            --------------------
;            |                  |
;            --------------------
;----------------------------------------------------
        .DB   083h, 080h, 080h, 080h, 082h
        .DB   081h, 020h, 020h, 020h, 081h
        .DB   085h, 080h, 080h, 080h, 084h 
  




;----------------------------------------------------
;                unknown
;----------------------------------------------------
L1BB0:  LD      A,(0E15Ah)      ;
        OR      A               ;
        LD      A,000h          ;
        LD      (0E15Ah),A      ;
        RET     NZ              ;
        LD      HL,0E193h       ; Get Button Data
        BIT     2,(HL)          ; Is PLAYER1/Feet pressed?
        RET     NZ              ; Yes, so return
        BIT     3,(HL)          ; Is PLAYER2/Feet pressed?
        RET                     ; Return





;----------------------------------------------------
;                unknown
;----------------------------------------------------
L1BC3:  LD      A,011h          ; Text = BLACK, Bkgnd = BLACK
        LD      (0E136h),A      ; Set Color
        CALL    L22F5           ; Program Graphics Chip
        CALL    L21FF           ; Clear Text Display
        LD      HL,0E098h
        LD      B,007h          ; 7 bytes to sum
        CALL    L110C           ; Calculate Sum of bytes
        CPL     
        LD      (HL),A
        LD      HL,0E09Bh
        LD      DE,0E04Bh
        LD      B,004h          ; Loop = 4
L1BE0:  LD      A,(DE)
        CP      (HL)
        JP      C,L1BEF
        JR      Z,L1BE9                 
        JR      NC,L1BFD                
L1BE9:  INC     HL
        INC     DE
        DJNZ    L1BE0                   
        JR      L1BFD                   

L1BEF:  LD      HL,0E098h       ;
        LD      DE,0E048h       ;
        LD      BC,00008h       ;
        LDIR                    ;
        CALL    L1C30           ;
L1BFD:  CALL    L1C94           ;
L1C00:  LD      B,00Eh          ; Loop = 14
        LD      HL,0E0B2h       ;
L1C05:  LD      A,010h          ; Bonus = 100,000?
        LD      (0E12Ah),A      ; S
        LD      DE,0E1ABh       ; Score
        PUSH    HL              ; Save HL Register
        PUSH    BC              ; Save BC Register
        CALL    L0FDB           ; Call 2-Digit Subtraction
        POP     BC              ; Restore BC Register
        POP     HL              ; Restore HL Register
        JR      C,L1C1A                 
        INC     HL
        INC     HL
        DJNZ    L1C05                   
L1C1A:  LD      A,001h
        LD      (0E12Ah),A
        EX      DE,HL
        PUSH    DE
        CALL    L0FB0           ; Call 2-digit BCD Addition
        POP     HL              ; Restore HL Register
        JR      NC,L1C2C        ;        
        LD      (HL),099h       ;
        DEC     HL              ;
        LD      (HL),099h       ;
L1C2C:  CALL    L10F3           ;
        RET                     ; Return


L1C30:  PUSH    IX
        LD      DE,00008
        LD      IX,0E000
        LD      B,009

L1C3B:  LD      C,B
        PUSH    IX
        POP     IY

L1C40:  ADD     IY,DE
        LD      A,(IX+003)
        CP      (IY+003)
        JR      C,L1C78                 
        JR      Z,L1C4E                 
        JR      NC,L1C6E              

L1C4E:  LD      A,(IX+004)
        CP      (IY+004)
        JR      C,L1C78                 
        JR      Z,L1C5A                 
        JR      NC,L1C6E                

L1C5A:  LD      A,(IX+005)
        CP      (IY+005)
        JR      C,L1C78                 
        JR      Z,L1C66                 
        JR      NC,L1C6E                

L1C66:  LD      A,(IX+006)
        CP      (IY+006)
        JR      C,L1C78                 

L1C6E:  DEC     C
        JR      NZ,L1C40                
        ADD     IX,DE
        DJNZ    L1C3B                   
        POP     IX
        RET     


L1C78:  PUSH    BC
        LD      B,008
        PUSH    IX
        POP     HL              ; Restore HL Register
        PUSH    IY
        EXX     
        POP     HL              ; Restore HL Register
        EXX     

L1C83:  LD      A,(HL)
        EX      AF,AF'
        EXX     
        LD      A,(HL)
        EX      AF,AF'
        LD      (HL),A
        INC     HL
        EXX     
        EX      AF,AF'
        LD      (HL),A
        INC     HL
        DJNZ    L1C83                   
        POP     BC
        JP      L1C6E

L1C94:  PUSH    IX
        LD      DE,00008
        LD      IX,0E050
        LD      B,009

L1C9F:  LD      C,B
        PUSH    IX
        POP     IY

L1CA4:  ADD     IY,DE
        LD      A,(IX+003)
        CP      (IY+003)
        JR      C,L1CDC                 
        JR      Z,L1CB2                 
        JR      NC,L1CD2              

L1CB2:  LD      A,(IX+004)
        CP      (IY+004)
        JR      C,L1CDC                 
        JR      Z,L1CBE                 
        JR      NC,L1CD2                

L1CBE:  LD      A,(IX+005)
        CP      (IY+005)
        JR      C,L1CDC                 
        JR      Z,L1CCA                 
        JR      NC,L1CD2                

L1CCA:  LD      A,(IX+006)
        CP      (IY+006)
        JR      C,L1CDC                 

L1CD2:  DEC     C
        JR      NZ,L1CA4                
        ADD     IX,DE
        DJNZ    L1C9F                   
        POP     IX
        RET     


L1CDC:  PUSH    BC
        LD      B,008
        PUSH    IX
        POP     HL              ; Restore HL Register
        PUSH    IY
        EXX     
        POP     HL              ; Restore HL Register
        EXX     

L1CE7:  LD      A,(HL)
        EX      AF,AF'
        EXX     
        LD      A,(HL)
        EX      AF,AF'
        LD      (HL),A
        INC     HL
        EXX     
        EX      AF,AF'
        LD      (HL),A
        INC     HL
        DJNZ    L1CE7                   
        POP     BC
        JP      L1CD2






;----------------------------------------------------
;               Show High Scores
;----------------------------------------------------
L1CF8:  CALL    L21FF           ; Clear Text Display
        CALL    L1D83
        LD      A,0FDh          ; Text = WHITE, Bkgnd = PURPLE
        CALL    L20CA           ; Setup Graphics Chip for Text
        CALL    L0FF9           ; Compact High Score Tables 
        PUSH    HL              ; Save HL Register
        LD      HL,0002Ah
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L1D0D:  .TEXT   "The Highest Scores"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        LD      B,00Ah          ; Loop = 10 scores
        LD      HL,0E000h       ;
        LD      D,002h          ;
        LD      E,004h          ;
        CALL    L1D57           ;
        PUSH    HL              ; Save HL Register  
        LD      HL,0003Eh       ;
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L1D34:  .TEXT   "High Scores Today"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        LD      B,00Ah          ; Loop = 10 Scores
        LD      HL,0E050h       ;
        LD      DE,01603h       ;
        LD      D,016h          ;
        LD      E,004h          ;
        CALL    L1D57           ;
        RET                     ; Return










L1D57:  PUSH    BC
        LD      A,(HL)
        INC     HL
L1D5A:  CALL    L2233           ; Print one Character to Text Display
        PUSH    DE
        INC     D
        LD      A,(HL)
        INC     HL
        CALL    L2256           ; Print A to Text Display
        INC     D               ;
        LD      A,(HL)          ;
        INC     HL              ;
        CALL    L2256           ; Print A to Text Display
        INC     D               ;
        INC     D               ;
        INC     D               ;
L1D6D:  INC     D               ;
        CALL    L2269           ; Print 8-digit number
        INC     HL              ;
        CALL    Delay10000      ; Call Delay 10,000
        LD      B,001h          ; Loop = 1
L1D77:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L1D77           ; Loop for 1 Comm
        POP     DE
        INC     E
        INC     E
        POP     BC
        DJNZ    L1D57                   
        RET     









;----------------------------------------------------
;           DE = Cursor Position
;----------------------------------------------------
L1D83:  LD      HL,023A0h       ; Setup Text Pointer
        PUSH    DE              ; Save pointer
        EX      DE,HL           ; DE = Pointer to Text
        LD      HL,00000h       ; HL = 0000
        LD      A,028h          ; A = 40 Characters to print
L1D8D:  CALL    L2224           ; Print text of length A
        POP     DE              ;
        LD      HL,023A0h       ;
        PUSH    DE              ;
L1D95:  EX      DE,HL           ;
        LD      HL,00398h       ;
        LD      A,028h          ;
        CALL    L2224           ; Print text of length A

        POP     DE              ;

        LD      B,001h          ; Loop = 1
L1DA1:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L1DA1           ; Loop for 1 Comm

        LD      D,000h          ; Verticle line at X = 0
        CALL    L1DED           ; Draw Verticle Line

        LD      D,014h          ; Verticle line at X = 20
        CALL    L1DED           ; Draw Verticle Line

        LD      B,001h          ; Loop = 1
L1DB2:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L1DB2           ; Loop for 1 Comm

        LD      D,027h          ; Verticle line at X = 39
        CALL    L1DED           ; Draw Verticle Line

        LD      DE,00000h       ; Location X = 0, Y = 0
        LD      A,083h          ; A = Character Upper Left Corner
        CALL    L2233           ; Print one Character to Text Display

        LD      DE,02700h       ; Location X = 39, Y = 0
        LD      A,082h          ; A = Character Upper Right Corner
        CALL    L2233           ; Print one Character to Text Display

        LD      DE,00017h       ; Location X = 0, Y = 23
        LD      A,085h          ; A = Character Lower Left Corner
        CALL    L2233           ; Print one Character to Text Display

        LD      DE,02717h       ; Location X = 39, Y = 23
        LD      A,084h          ; A = Character Lower Right Corner 
        CALL    L2233           ; Print one Character to Text Display

        LD      A,087h          ; A = Character 
        LD      DE,01400h       ; Location X = 0, Y = 0
        CALL    L2233           ; Print one Character to Text Display

        LD      A,088h          ; A = Character 
        LD      DE,01417h       ; Location X = 0, Y = 0
        CALL    L2233           ; Print one Character to Text Display

        RET                     ; Return









;----------------------------------------------------
;         Draw Verticle Line 24 characters long
;   D = X location of verticle line
;----------------------------------------------------
L1DED:  LD      E,000h          ; Y = 0
        LD      B,018h          ; Loop = 24
L1DF1:  LD      A,081h          ; A = Character Verticle Line
        CALL    L2233           ; Print one Character to Text Display
        INC     E               ; Y = Y + 1
        DJNZ    L1DF1           ; Print all 24 characters
        RET                     ; Return






;----------------------------------------------------
;                unknown
;----------------------------------------------------
L1DFA:  LD      A,(0E18Ch)      ; Get DIP Switches 12-19
        BIT     0,A             ; Check Service Mode Switch
        RET     NZ
        BIT     1,A             ; Check if Switch Test is enabled
        RET     NZ
        BIT     4,A             ; Check if Disc Test is enabled
        RET     NZ
        LD      A,(0E1A8h)      ; Get Number of Credits
        CP      001h            ; Is there one credit?
        CALL    NC,L1E5B
        LD      A,(0E1A8h)      ; Get Number of Credits
        CP      002h            ; Are there two credits?
        CALL    NC,L1E2B
        LD      A,(0E18Ch)      ; Get DIP Switches 12-19
        BIT     2,A             ; Check if FREE PLAY set
        JR      Z,L1E23                 
        CALL    L1E5B
        CALL    L1E2B

L1E23:  LD      HL,0E192h       ; HL = Button Data
        RES     2,(HL)          ; Clear PLAYER1/FEET
        RES     3,(HL)          ; Clear PLAYER2/FEET
        RET                     ; Return



L1E2B:  LD      HL,0E192h       ; HL = Button Data
        BIT     3,(HL)          ; Is PLAYER2/FEET pressed?
        RET     Z               ; Not pressed so return
        RES     3,(HL)          ; Clear PLAYER2/FEET press
        LD      A,(0E126h)      ; Get Control Register
        RES     0,A
        LD      (0E126h),A
        LD      DE,00000h
        LD      (0E127h),DE
        LD      DE,0E0A2h
        LD      A,002h
        LD      (0E12Ah),A
        CALL    L0FA1           ; Call 3-Digit Addition
        CALL    L10E5           ; Sum Total Coins
        CALL    L1F37           ; Exchange players
;----------------------------------------------------
;                 Set Player 2
;----------------------------------------------------
        LD      A,002h          ; Player Number 2
        LD      (0E1A9h),A      ; Save Player Number
        JP      L1E8A           ;



L1E5B:  LD      HL,0E192h       ; HL = Button Data
        BIT     2,(HL)          ; Is PLAYER1/FEET pressed?
        RET     Z               ; Not pressed, so return
        RES     2,(HL)          ; Clear PLAYER1/FEET press
        LD      A,(0E126h)      ; Get Control Register
        RES     0,A
        LD      (0E126h),A
        LD      DE,00000h
        LD      (0E127h),DE
        LD      DE,0E0A2h
        LD      A,001
        LD      (0E12Ah),A
        CALL    L0FA1           ; Call 3-Digit Addition
        CALL    L10E5           ; Sum Total Coins
;----------------------------------------------------
;        Clear Player Data, E1A9-E1C6
;----------------------------------------------------
        XOR     A               ; A = 0
        LD      HL,0E1A9h       ; HL = Start Clear Address
        LD      B,01Eh          ; Loop = 30
L1E86:  LD      (HL),A          ; Clear location 
        INC     HL              ; Point to next location
        DJNZ    L1E86           ; Loop until all locations cleared

L1E8A:  LD      HL,L0000
        LD      (0E1A1h),HL
        CALL    L1F37           ; Reset Player Variables?
        LD      A,001h          ; Player Number 1
        LD      (0E1A9h),A      ; Save Player Number
        LD      SP,0F000h       ; Set Stack Pointer
        LD      HL,L072A        ; HL = Address
        PUSH    HL              ; Save Address
        EI                      ; Enable Interrupts
        RETN                    ; Return from NMI





;----------------------------------------------------
;             Check for Next Player
;----------------------------------------------------
L1EA2:  CALL    L1F14           ; Swap player data
        LD      A,(0E1AEh)      ; Get Number of Lives Remaining
        OR      A               ; Check if any lives left
        JR      NZ,L1EB4        ; Yes, continue game        
        CALL    L1F14           ; Swap player data
        LD      A,(0E1AEh)      ; Get Number of Lives Remaining
        OR      A               ; Check if any lives left
        JR      Z,L1EB7         ; No lives left either, skip ahead
L1EB4:  JP      L0772           ; Continue game
;----------------------------------------------------
;              Both Players GAME OVER
;----------------------------------------------------
L1EB7:  LD      A,(0E126h)      ; Get Control Register
        BIT     1,A             ;
        JR      NZ,L1EB7        ;        
        LD      A,(0E126h)      ; Get Control Register
        BIT     4,A             ;
        JR      NZ,L1ED2        ;        
;----------------------------------------------------
;             Send PAUSE Command
;----------------------------------------------------
        LD      A,00Ah          ; Command = PAUSE (0Ah)
        CALL    L207F           ; Send Message to LDPlayer DI
        LD      A,(0E126h)      ; Get Control Register
        SET     4,A             ; Set PAUSE Bit
        LD      (0E126h),A      ; Save Control Register
;----------------------------------------------------
;    Check final statistics against Bookkeeping Data
;----------------------------------------------------
L1ED2:  LD      HL,0E192h       ; Get Button Data
        RES     2,(HL)          ; Clear PLAYER1/FEET 
        RES     3,(HL)          ; Clear PLAYER2/FEET
        CALL    L156F           ; Update Bookkeeping Data
        CALL    L1877           ; Check High Scores/Initials
        LD      A,(0E1C7h)      ; Check if Players2 was playing
        OR      A               ; Was it a 2 player game?
        JR      Z,L1EEE         ; No, so don't check player2 data       
        CALL    L1F14           ; Swap player data
        CALL    L156F           ; Update Bookkeeping Data
        CALL    L1877           ; Check High Scores/Initials

;----------------------------------------------------
;       Show GAME OVER and then go to beginning
;----------------------------------------------------
L1EEE:  CALL    L1F05           ; Clear out Player Data
        LD      A,(0E126h)      ; Get Control Register
        SET     0,A
        LD      (0E126h),A
        CALL    L3B39           ; Flash GAME OVER
        CALL    L1CF8           ; Show High Scores
        CALL    Delay500000     ; Call Delay 500,000
        JP      L0604           ; Begin game






;----------------------------------------------------
;      Clear out Player Data,  E1A9-E1E5h
;---------------------------------------------------- 
L1F05:  LD      HL,0E1A9h       ; Point to start of Player Data
        LD      BC,0003Ch       ; BC = Number of bytes
L1F0B:  LD      (HL),000h       ; Clear Data location
        INC     HL              ; Point to next Data location
        DEC     BC              ; Decrement loop couter
        LD      A,B             ; Get loop counter
        OR      C               ; Check if loop counter is zero
        JR      NZ,L1F0B        ; Loop until all Data locations cleared
        RET                     ; Return






;----------------------------------------------------
;     Swap locations E1A9-E1C6 and E1C7-E1E4
;----------------------------------------------------
L1F14:  PUSH    AF              ; Save AF Register
        PUSH    BC              ; Save BC Register
        PUSH    DE              ; Save DE Register
        PUSH    HL              ; Save HL Register
        XOR     A               ; A = 0
        LD      (0E17Ah),A      ; Clear Seconds Counter
        LD      HL,0E1A9h       ; HL = Player Number
L1F1F:  LD      DE,0E1C7h       ; DE = Player Data
        LD      BC,0001Eh       ; Loop = 30
L1F25:  LD      A,(DE)          ; Get player data
        EX      AF,AF'          ; save it
        LD      A,(HL)          ; Get Player 1 number
        LD      (DE),A          ; put ??
        EX      AF,AF'          ;
        LD      (HL),A          ;
        INC     HL              ;
        INC     DE              ;
        DEC     BC              ; Decrement Loop
        LD      A,B             ; Get Loop
        OR      C               ; Check loop
        JR      NZ,L1F25        ; Loop back until zero
               
        POP     HL              ; Restore HL Register
        POP     DE              ; Restore DE Register
        POP     BC              ; Restore BC Register
        POP     AF              ; Restore AF Register
        RET                     ; Return






;----------------------------------------------------
;                     unknown
;----------------------------------------------------
L1F37:  CALL    L1F14           ; Swap player data
        CALL    L1F55           ;
        CALL    L1F70           ; Add number of lives per credit
        LD      HL,00000h       ; HL = 00000h
        LD      (0E1AAh),HL     ; Clear score
        LD      (0E1ACh),HL     ; Clear score
        LD      (0E1C4h),HL     ; Clear Game Timer
        LD      (0E1C5h),HL     ; Clear Game Timer
        LD      A,01Eh          ; A = 30 seconds
        LD      (0E1C3h),A      ; Store 30 counter?
        RET                     ; Return






;----------------------------------------------------
;             Check for FREE PLAY
;----------------------------------------------------
L1F55:  LD      A,(0E18Dh)      ; Get DIP Switches 12-19
        BIT     2,A             ; Check FREE PLAY setting
        RET     NZ              ; FREE PLAY not set so return
        LD      A,(0E126h)      ; Get Control Register
        BIT     0,A             ;
        RET     NZ              ;
        DI                      ; Disable Interrupts
        LD      A,(0E1A8h)      ; Get Number of Credits
        OR      A               ; Check if any credits left
        JR      Z,L1F6E         ; No credits left so skip ahead       
        ADD     A,099h          ; Add 99 Credits
        DAA                     ; Convert to decimal
        LD      (0E1A8h),A      ; Save Number of Credits
L1F6E:  EI                      ; Enable Interrupts
        RET                     ; Return







;----------------------------------------------------
;            Add Number of Lives per Credit
;----------------------------------------------------
L1F70:  LD      A,(0E186h)      ; Get DIP Switches 28-35
        AND     003h            ; Get Number of lives per game (0,1,2,3)
        ADD     A,003h          ; Add 3 Lives (3,4,5,6)
        LD      (0E1AEh),A      ; Save Number of Lives
        LD      (0E157h),A      ; Save Number of Lives
        RET                     ; Return

        RET     






;----------------------------------------------------
;  Transmit Comm Data Burst with Double Delay
;----------------------------------------------------
L1F7F:  CALL    L1F86           ; Comm Data Burst with Delay 3Ch 
        CALL    L241D           ; Call Delay for 64h
        RET                     ; Return


;----------------------------------------------------
;  Transmit Comm Data Burst with Delay = 3Ch
;----------------------------------------------------
L1F86:  PUSH    AF              ; Save AF Register
        CALL    L1F8F           ; Write Comm Data Burst
        CALL    L240B           ; Delay for 3Ch
        POP     AF              ; Restore AF Register
        RET                     ; Return





;----------------------------------------------------
;    Write ten HIGH/LOW transitions to LDPlayer Comm
;---------------------------------------------------- 
L1F8F:  PUSH    AF              ; Save AF Register
        PUSH    BC              ; Save BC Register
        PUSH    DE              ; Save DE Register
        PUSH    HL              ; Save HL Register
        LD      C,06Ah          ; C = LDPlayer Port
        LD      D,030h          ;
        LD      E,000h          ;
        LD      A,(0E113h)      ; Get LDPlayer Register
        OR      001h            ; Set Comm bit HIGH
        LD      H,A             ; H = A High
        AND     0FEh            ; Set Comm bit LOW
        LD      L,A             ; L = A Low

        LD      A,H             ; A = High
        OUT     (066h),A        ; Output HIGH signal

;----------------------------------------------------
;   (1) Write HIGH/LOW transition to LDPlayer Comm
;----------------------------------------------------
        LD      A,H             ; A = High
        OUT     (064h),A        ; Output HIGH signal
        OUT     (064h),A        ; Output HIGH signal
        OUT     (C),D
        NOP                     ; Pause        
        LD      A,L             ; A = LOW
        OUT     (064),A         ; Output LOW signal
        OUT     (064),A         ; Output LOW signal
        OUT     (C),E      
        NOP                     ; Pause

;----------------------------------------------------
;   (2) Write HIGH/LOW transition to LDPlayer Comm
;----------------------------------------------------
        LD      A,H             ;
        OUT     (064),A         ;
        OUT     (064),A         ;
        OUT     (C),D           ;
        NOP                     ;
        LD      A,L             ;
        OUT     (064),A         ;
        OUT     (064),A         ;
        OUT     (C),E           ;
        NOP                     ;

;----------------------------------------------------
;   (3) Write HIGH/LOW transition to LDPlayer Comm
;----------------------------------------------------
        LD      A,H
        OUT     (064),A
        OUT     (064),A
        OUT     (C),D
        NOP     
        LD      A,L
        OUT     (064),A
        OUT     (064),A
        OUT     (C),E
        NOP     

;----------------------------------------------------
;   (4) Write HIGH/LOW transition to LDPlayer Comm
;----------------------------------------------------
        LD      A,H
        OUT     (064),A
        OUT     (064),A
        OUT     (C),D
        NOP     
        LD      A,L
        OUT     (064),A
        OUT     (064),A
        OUT     (C),E
        NOP     

;----------------------------------------------------
;   (5) Write HIGH/LOW transition to LDPlayer Comm
;----------------------------------------------------
        LD      A,H
        OUT     (064),A
        OUT     (064),A
        OUT     (C),D
        NOP     
        LD      A,L
        OUT     (064),A
        OUT     (064),A
        OUT     (C),E
        NOP     

;----------------------------------------------------
;   (6) Write HIGH/LOW transition to LDPlayer Comm
;----------------------------------------------------
        LD      A,H
        OUT     (064),A
        OUT     (064),A
        OUT     (C),D
        NOP     
        LD      A,L
        OUT     (064),A
        OUT     (064),A
        OUT     (C),E
        NOP     

;----------------------------------------------------
;   (7) Write HIGH/LOW transition to LDPlayer Comm
;----------------------------------------------------
        LD      A,H
        OUT     (064),A
        OUT     (064),A
        OUT     (C),D
        NOP     
        LD      A,L
        OUT     (064),A
        OUT     (064),A
        OUT     (C),E
        NOP     

;----------------------------------------------------
;   (8) Write HIGH/LOW transition to LDPlayer Comm
;----------------------------------------------------
        LD      A,H
        OUT     (064),A
        OUT     (064),A
        OUT     (C),D
        NOP     
        LD      A,L
        OUT     (064),A
        OUT     (064),A
        OUT     (C),E
        NOP     

;----------------------------------------------------
;   (9) Write HIGH/LOW transition to LDPlayer Comm
;----------------------------------------------------
        LD      A,H
        OUT     (064),A
        OUT     (064),A
        OUT     (C),D
        NOP     
        LD      A,L
        OUT     (064),A
        OUT     (064),A
        OUT     (C),E
        NOP     

;----------------------------------------------------
;   (10) Write HIGH/LOW transition to LDPlayer Comm
;----------------------------------------------------
        LD      A,H
        OUT     (064),A
        OUT     (064),A
        OUT     (C),D
        NOP     
        LD      A,L
        OUT     (064),A
        OUT     (064),A
        OUT     (C),E
        NOP     

        LD      A,L
        OUT     (066),A
        POP     HL              ; Restore HL Regiser
        POP     DE              ; Restore DE Register
        POP     BC              ; Restore BC Register
        POP     AF              ; Restore AF Register
        RET                     ; Return







;----------------------------------------------------
;   Send Command out on LDPlayer Comm
;   Command is 5 bits long
;----------------------------------------------------
;        A = Command 
;----------------------------------------------------
#define     FORWARD_3X    001h 
#define     SCAN_FWD      002h
#define     SLOW_FWD      003h
#define     STEP_FWD      004h
#define     PLAY          005h
#define     REVERSE_3X    006h
#define     SCAN_REV      007h 
#define     SLOW_REV      008h
#define     STEP_REV      009h
#define     PAUSE         00Ah
#define     SEARCH        00Bh
#define     CHAPTER       00Ch
#define     AUDIO_RIGHT   00Dh
#define     AUDIO_LEFT    00Eh
#define     REJECT        00Fh
#define     NUM_0         010h
#define     NUM_1         011h
#define     NUM_2         012h
#define     NUM_3         013h
#define     NUM_4         014h
#define     NUM_5         015h
#define     NUM_6         016h
#define     NUM_7         017h
#define     NUM_8         018h
#define     NUM_9         019h
#define     POWER_UP      01Ah
;----------------------------------------------------
L204D:  PUSH    AF              ; Save AF Register
        PUSH    BC              ; Save BC Register
        LD      B,005h          ; Bit to send = 5
L2051:  RRA                     ; Rotate bit
        JR      NC,L2059        ; Bit is zero, so send "0"        
        CALL    L1F7F           ; Comm Data = 1
        JR      L205C           ; Check loop        
L2059:  CALL    L1F86           ; Comm Data = 0
L205C:  DJNZ    L2051           ; Loop until all bits are sent
        POP     BC              ; Restore BC Register
        POP     AF              ; Restore AF Register
        RET                     ; Return




;----------------------------------------------------
;   Write HEADER to LDPlayer Comm, HEADER = 001
;----------------------------------------------------
L2061:  CALL    L1F86           ; Comm Data = 0
        CALL    L1F86           ; Comm Data = 0
        CALL    L1F7F           ; Comm Data = 1
        RET                     ; Return




;----------------------------------------------------
;   Write FOOTER to LDPlayer Comm, FOOTER = 001
;----------------------------------------------------
L206B:  CALL    L1F86           ; Comm Data = 0
        CALL    L1F86           ; Comm Data = 0
        CALL    L1F8F           ; Comm Data = End 1
        RET                     ; Return





;----------------------------------------------------
;  Write entire Message:  HEADER + COMMAND + FOOTER
;----------------------------------------------------
L2075:  CALL    L2061           ; Write HEADER to Comm
        CALL    L204D           ; Write COMMAND to Comm
        CALL    L206B           ; Write FOOTER to Comm
        RET                     ; Return




;----------------------------------------------------
;        Disable Interrupt then send Message
;----------------------------------------------------
L207F:  DI                      ; Disable Interrupts
        CALL    L2085           ; Issue Command to LDPlayer
        EI                      ; Enable Interrupts
        RET                     ; Return



;----------------------------------------------------
;     Repeat Message to LDPlayer Comm 3x times
;            A = Command
;----------------------------------------------------
L2085:  PUSH    AF              ; Save AF Register
        PUSH    BC              ; Save BC Register
        CALL    L2353           ; Wait for Comm Ready
        CALL    L2075           ; Send Message to Comm
        CALL    L2353           ; Wait for Comm Ready
        CALL    L2353           ; Wait for Comm Ready
        CALL    L2075           ; Send Message to Comm
        CALL    L2353           ; Wait for Comm Ready
        CALL    L2353           ; Wait for Comm Ready
        CALL    L2075           ; Send Message to Comm
        CALL    L2353           ; Wait for Comm Ready
        POP     BC              ; Restore BC Register
        LD      (0E15Ch),A
        IN      A,(039h)
        POP     AF              ; Restore AF Register
        RET                     ; Return






;----------------------------------------------------
;     LDPlayer Command Table Lookup (Digits)
;----------------------------------------------------
L20AA: 
        .DB   010h    ; Zero  
        .DB   011h    ; One
        .DB   012h    ; Two
        .DB   013h    ; Three
        .DB   014h    ; Four
        .DB   015h    ; Five
        .DB   016h    ; Six
        .DB   017h    ; Seven
        .DB   018h    ; Eight
        .DB   019h    ; Nine




;----------------------------------------------------
;        Clear Frame Number area and
;        set Frame Count Wait bit
;----------------------------------------------------
L20B4:  PUSH    AF              ; Save AF Register
        LD      A,000h          ; A = 0
        LD      (0E116h),A      ; Clear Frame Count area
        LD      (0E117h),A      ; Clear Frame Count area
L20BD:  LD      (0E118h),A      ; Clear Frame Count area
        LD      A,(0E126h)      ; Get Control Register
        SET     1,A             ; Set Frame Count Wait bit
        LD      (0E126h),A      ; Save Control Register
        POP     AF              ; Restore AF Register
        RET                     ; Return









;----------------------------------------------------
;          Setup Graphics Chip for Text
;----------------------------------------------------
;        A = Text/Background Color 
;----------------------------------------------------
L20CA:  PUSH    IX              ; Save IX Register
        PUSH    AF              ; Save AF Register

L20CD:  LD      IX,0E12Fh       ; Start of Registers
        LD      (IX+000h),000h  ;
        LD      (IX+001h),0F0h  ; 8x8 sprites Mode 1
        LD      (IX+002h),000h  ;
        LD      (IX+003h),010h  ; Color Table = 2000h
        LD      (IX+004h),007h  ; Char Pattern Table = 3800h
        LD      (IX+005h),004h  ; SA = 200h  
        LD      (IX+006h),007h  ; 
        LD      (IX+007h),000h  ; Text = TRANS, Bkgnd = TRANS
        CALL    L22F5           ; Program Graphics Chip 
;----------------------------------------------------
;        Display transparent while being drawn
;----------------------------------------------------
;         Load in Text Character Patterns
;----------------------------------------------------
        LD      HL,0584Fh       ; HL = Text Character Patterns
        LD      DE,03800h       ; Copy Character Patterns to 3800h
        LD      BC,00400h       ; BC = 128 character x 8 bytes
        CALL    L22D9           ; Write Data Block to Graphics Address
        POP     AF              ; Restore color assignment
;----------------------------------------------------
;   Restore original colors after display is drawn 
;----------------------------------------------------
        LD      IX,0E12Fh       ; Color Register
        LD      (IX+007h),A     ; Write color
L2108:  CALL    L2392           ;
        CALL    L22F5           ; Program Graphics Chip
        POP     IX              ; Restore IX Register
        RET                     ; Return










;----------------------------------------------------
;            Setup Graphics Chip
;----------------------------------------------------
;        A = Text/Background Color 
;----------------------------------------------------
L2111:  PUSH    IX              ; Save IX Register
        PUSH    AF              ; Save Color Code

        LD      IX,0E12Fh       ; Start of Graphics Registers
        LD      (IX+000h),001h  ;
        LD      (IX+001h),0F0h  ; Mode 1, Black & White Mode
        LD      (IX+002h),000h  ;
        LD      (IX+003h),010h  ; Color Table = 2000h
        LD      (IX+004h),007h  ; Char Pattern Table = 3800h
        LD      (IX+005h),004h  ;
        LD      (IX+006h),007h  ;
        LD      (IX+007h),000h  ;
        CALL    L22F5           ; Program Graphics Chip
;----------------------------------------------------
;    Make display transparent while being drawn
;----------------------------------------------------
        LD      HL,0584Fh       ; HL = Text Character Patterns
        LD      DE,03800h       ; Copy Character Patterns to 3800h
        LD      BC,00400h       ; BC = 128 character x 8 bytes
        CALL    L22D9           ; Write Data Block to Graphics Address
        POP     AF              ; Get Color Code
;----------------------------------------------------
;   Restore original colors after display is drawn 
;----------------------------------------------------
        LD      IX,0E12Fh       ; Point to Color Register
        LD      (IX+007h),A     ; Set Color
        CALL    L22F5           ; Program Graphics Chip
        POP     IX              ; Restore IX Register
        RET                     ; Return








;----------------------------------------------------
;  Clear Graphics Areas, Fill Screen with Characters
;----------------------------------------------------
L2155:  PUSH    AF              ; Save AF Register
        PUSH    BC              ; Save BC Register
        PUSH    DE              ; Save DE Register
        PUSH    HL              ; Save HL Register
        PUSH    IX              ; Save IX Register
        LD      HL,0E130h       ;
        RES     6,(HL)          ;
        CALL    L22F5           ; Program Graphics Chip
        LD      A,000h          ; First Character = 00h
        CALL    L21E9           ; Fill Screen with incremental character
;----------------------------------------------------
;        Clear Graphics Area 00000h-017FFh
;----------------------------------------------------
        LD      HL,00000h       ; Graphics Address 00000h 
        CALL    L2334           ; Set Graphic Address
        LD      BC,01800h       ; Setup loop BC = 1800h
L2171:  XOR     A               ; A = 00
        OUT     (044h),A        ; Write to graphics address
        DEC     BC              ; Decrement loop
        LD      A,B             ; Get loop
        OR      C               ; Check if loop is finished
        JR      NZ,L2171        ; Loop until all locations cleared
;----------------------------------------------------
;        Clear Graphics Area 01800h-1BFFh
;----------------------------------------------------          
        LD      HL,01800h       ; Graphics Address 01800h
        CALL    L2334           ; Set Graphics Address
        LD      BC,00400h       ; Setup loop BC = 0400h
L2182:  XOR     A               ; A = 00
        OUT     (044h),A        ; Write to Graphics address
        DEC     BC              ; Decrement loop
        LD      A,B             ; Get loop
        OR      C               ; Check if loop is finished
        JR      NZ,L2182        ; Loop until all locations cleared
;----------------------------------------------------
;        Reset Graphics Area 02000h-037FFh
;----------------------------------------------------
        LD      HL,02000h       ; Graphics Address 02000h
        CALL    L2334           ; Set Graphics Address
        LD      BC,01800h       ; Setup loop BC = 1800h
L2193:  LD      A,041h          ; A = 41h
        OUT     (044h),A        ; Write to Graphics address
        DEC     BC              ; Decrement loop
        LD      A,B             ; Get loop
        OR      C               ; Check if loop is complete
        JR      NZ,L2193        ; Loop until all locations reset
;----------------------------------------------------
;         Program Text Character Patterns
;----------------------------------------------------
        LD      HL,0584Fh       ; HL = Text Character Patterns
        LD      DE,01000h       ; Copy Character Patterns to 1000h
        LD      BC,00400h       ; BC = 128 character x 8 bytes
        CALL    L22D9           ; Write Data Block to Graphics Address

        LD      HL,03E00h       ; Graphics Addres = 3E00h
        CALL    L2334           ; Set Graphics Address
        LD      B,000h          ;
L21B0:  LD      A,000h          ;
        OUT     (044h),A        ;
        PUSH    AF              ;
        POP     AF              ;
        DJNZ    L21B0           ;
                                
        LD      IX,0E12Fh       ;
        LD      (IX+000h),002h  ; Mode 3 Graphics Mode
        LD      (IX+001h),0A0h  ;
        LD      (IX+002h),00Fh  ;
        LD      (IX+003h),0FFh  ;
        LD      (IX+004h),003h  ; Pattern Generator 0000h
        LD      (IX+005h),070h  ;
        LD      (IX+006h),003h  ;
        LD      (IX+007h),000h  ;
        CALL    L2392           ;
        CALL    L22F5           ; Program Graphics Chip
        POP     IX              ; Restore IX Register
        POP     HL              ; Restore HL Register
        POP     DE              ; Restore DE Register
        POP     BC              ; Restore BC Register
        POP     AF              ; Restore AF Register
        RET                     ; Return





;----------------------------------------------------
;       Fill Screen with Incremental Character
;----------------------------------------------------
;       A = Starting Character
;       3C00-3DFF filled with A, A + 1, A + 2,...
;---------------------------------------------------- 
L21E9:  PUSH    AF              ; Save AF Register
        LD      HL,3C00h        ; Graphics Location = 3C00h
        CALL    L2334           ; Set Graphics Location
        POP     AF              ; Restore AF Register
        LD      L,A             ; L = Starting character
        LD      BC,00200h       ; BC = number of characters
L21F5:  LD      A,L             ; A = Character to print
        OUT     (044h),A        ; Print character
        INC     L               ; Next character (L=L+1)
        DEC     BC              ; Decrement loop
        LD      A,B             ; Get loop
        OR      C               ; Check loop
        JR      NZ,L21F5        ; Loop not zero so continue fill
        RET                     ; Return






;----------------------------------------------------
;         Clear Text Display 0-960 (0000-03C0h)
;---------------------------------------------------- 
L21FF:  LD      HL,00000h       ; Cursor Position (X=0,Y=0)
        CALL    L2334           ; Set Text Cursor Position
        LD      BC,003C0h       ; Loop = Number of Text Locations 
L2208:  LD      A,000h          ; A = Blank (00h)
        OUT     (044h),A        ; Send blank to Text Display
        DEC     BC              ; Decrement Loop
        LD      A,B             ; Check Loop
        OR      C               ; Is Loop at zero?
        JR      NZ,L2208        ; No, so continue        
        RET                     ; Finished so return







;----------------------------------------------------
;           Print to Text Display
;----------------------------------------------------
;       HL = Cursor Position 0 - 960 (0000-03C0h)
;       PC = Text Location (on stack)
;---------------------------------------------------- 
L2212:  CALL    L2334           ; Set Text Cursor Position
        POP     HL              ; Grab Text Pointer from stack
L2216:  LD      A,(HL)          ; Get character
        INC     HL              ; Point to next character
        SUB     020h            ; Make into printable character
        JP      M,L2223         ; Last character, so leave
        OUT     (044h),A        ; Output character to display
        PUSH    AF              ; Quick pause
        POP     AF              ; Quick pause
        JR      L2216           ; Continue until all characters are printed        
L2223:  JP      (HL)            ; Jump back to address after text








;----------------------------------------------------
;           Print to Text Display
;----------------------------------------------------
;       A  = Number of characters to print
;       DE = Pointer to start of text  
;----------------------------------------------------
L2224:  LD      B,A             ; B = Number of characters
        CALL    L2334           ; Set Text Cursor Position
L2228:  LD      A,(DE)          ; Get character
        SUB     020h            ; Make into printable character
        INC     DE              ; Point to next character
        OUT     (044h),A        ; Output character to display
        PUSH    AF              ; Quick pause
        POP     AF              ; Quick pause
        DJNZ    L2228           ; Loop until all characters printed        
        RET                     ; Return






;----------------------------------------------------
;       Print one Character to Text Display
;----------------------------------------------------
;        A = Character to print
;        D = X Cursor Position
;        E = Y Cursor Position
;----------------------------------------------------
L2233:  PUSH    AF              ; Save AF Register         
        PUSH    HL              ; Save HL Register
        PUSH    DE              ; Save DE Register
        PUSH    AF              ; Save character
;----------------------------------------------------
;          Cursor Position = 40 * E + D
;----------------------------------------------------
        LD      A,E             ; A = E
        ADD     A,A             ; A = A * 2
        LD      L,A             ; L = A
        ADD     A,A             ; A = A * 2
        ADD     A,A             ; A = A * 2
        ADD     A,L             ; A = A + L
        LD      L,A             ; L = A
        LD      H,000h          ; HL = L
        ADD     HL,HL           ; HL = HL * 2
        ADD     HL,HL           ; HL = HL * 2
        LD      E,D             ; E = D
        LD      D,000h          ; DE = E
        ADD     HL,DE           ; HL = HL + DE
        LD      DE,0000h        ; Zero offset
        ADD     HL,DE           ; Add offset
        CALL    L2334           ; Set Text Cursor Position
        POP     AF              ; Recall saved character
        SUB     020h            ; Make into printable character
        OUT     (044),A         ; Output character to display
        POP     DE              ; Restore DE Register
        POP     HL              ; Restore HL Register
        POP     AF              ; Restore AF Register
        RET                     ; Return







;----------------------------------------------------
;           Print to Text Display
;----------------------------------------------------
;        A = Character to print
;----------------------------------------------------
L2256:  PUSH    AF              ; Save AF Register
        SUB     020h            ; Make into printable character
        OUT     (044h),A        ; Output character to display
        POP     AF              ; Restore AF Register
        RET                     ; Return







;----------------------------------------------------
;        Print 2-Digit Number (1 byte)
;----------------------------------------------------  
;       HL  = Number Location
;----------------------------------------------------
L225D:  LD      A,001h          ; 1 byte in number
        JR      L226B           ; Print Number       





;----------------------------------------------------
;        Print 4-Digit Number (2 bytes) 
;----------------------------------------------------
;       HL  = Number Location
;----------------------------------------------------
L2261:  LD      A,002h          ; 2 bytes in number
        JR      L226B           ; Print Number       





;----------------------------------------------------
;        Print 6-Digit Number (3 bytes) 
;----------------------------------------------------
;       HL  = Number Location
;----------------------------------------------------
L2265:  LD      A,003h          ; 3 bytes in number
        JR      L226B           ; Print Number







;----------------------------------------------------
;          Convert Number to String and Print
;----------------------------------------------------
;       HL  = Number Location
;        A  = Number of Character Bytes (L226B)
;             Two digits per byte
;----------------------------------------------------
L2269:  LD      A,004h          ; 8-Digit number (4 bytes)
L226B:  PUSH    BC              ; Save BC Register
        PUSH    DE              ; Save X,Y Location
        LD      B,A             ; B = Number of characters to print
        LD      C,000h          ; C = Leading Zeros

L2270:  LD      A,(HL)          ; Get character byte
        RRC     A               ; Shift bits right
        RRC     A               ; Shift bits right
        RRC     A               ; Shift bits right
        RRC     A               ; Shift bits right
        AND     00Fh            ; Isolate upper nibble
        JR      NZ,L2283        ; Number not zero, so print it       
;----------------------------------------------------
;              Don't print leading zeros
;----------------------------------------------------
        LD      A,C             ; Check for Leading Zero
        OR      A               ; Is this a leading zero?
        JR      Z,L2289         ; Yes, so don't print it       
        LD      A,000h          ; Number = 0
L2283:  OR      030h            ; Make digit into character
        LD      C,A             ; Finished with leading zeros 
        CALL    L2233           ; Print one Character to Text Display

L2289:  INC     D               ; X = X + 1
        LD      A,(HL)          ; Get character
        AND     00Fh            ; Isolate lower nibble
        JR      NZ,L229D        ; Number not zero, so print it       
;----------------------------------------------------
;   Only print leading zero if it's the last digit
;----------------------------------------------------
        LD      A,B             ; Get loop number
        CP      001h            ; Is this the last character?
        LD      A,000h          ; Number  = 0
        JP      Z,L229D         ; Last character so print final zero
        LD      A,C             ; Check for Leading Zero
        OR      A               ; Is this a leading zero?
        JR      Z,L22A3         ; Yes, so don't print it       
        LD      A,000h          ; Number = 0
L229D:  OR      030h            ; Make digit into character
        LD      C,A             ; Finished with leading zeros
        CALL    L2233           ; Print one Character to Text Display           ;
L22A3:  INC     D               ; Increment Cursor Position
        INC     HL              ; Next character spot
        DJNZ    L2270           ; Loop until all characters printed              

        POP     DE              ; Restore X,Y Location
        POP     BC              ; Restore BC Register
        RET                     ; Return








;----------------------------------------------------
;       Convert Window Move Time into decimal
;----------------------------------------------------
;       Input  A:   Hex      00 = Easy, 0F = Hard
;       Return A:   Decimal  00 = Easy, 15 = Hard  
;----------------------------------------------------
L22AA:  PUSH    BC              ; Save BC Register
        LD      B,0FFh          ; Initialize B (Quotient)
L22AD:  INC     B               ; Add 1 to B every time we subtract 10 from A 
        SUB     00Ah            ; Subtract 10 from A
        JR      NC,L22AD        ; Result positive so keep subtracting       
        ADD     A,00Ah          ; Put 10 back onto A
        LD      C,A             ; C = Remainder after division
        LD      A,B             ; A = Quotient 
        RLC     A               ; Move Quotient to upper nibble
        RLC     A               ; Move Quotient to upper nibble
        RLC     A               ; Move Quotient to upper nibble
        RLC     A               ; Move Quotient to upper nibble
        AND     0F0h            ; Isolate upper nibble
        OR      C               ; Add Remainder to lower nibble

        POP     BC              ; Restore BC Register
        RET                     ; Return






;----------------------------------------------------
;        Jump to Set Cursor and Print Text
;----------------------------------------------------
L22C3:  JP      L2212           ; Set Cursor and Print Text






;----------------------------------------------------
;                    unknown
;----------------------------------------------------
        EX      DE,HL           ;
        CALL    L2334           ; Set Text Cursor Position
        EX      DE,HL           ;
L22CB:  PUSH    HL              ; Save HL Register          
        LD      C,008h          ; Loop = 8
L22CE:  LD      A,(HL)          ;
        INC     HL              ;
        OUT     (044h),A        ;
        DEC     C               ;
        JR      NZ,L22CE        ;        
        POP     HL              ; Restore HL Register
        DJNZ    L22CB           ;        
        RET                     ; Return 







;----------------------------------------------------
;     Write Block of Data to Graphics Address 
;----------------------------------------------------
;      HL = Data Location
;      DE = Graphics Address
;      BC = Number of bytes to output
;----------------------------------------------------
L22D9:  EX      DE,HL           ; Graphics Address
        CALL    L2334           ; Set Graphics Address
        EX      DE,HL           ; Restore variables
L22DE:  LD      A,(HL)          ; Get Data byte
        OUT     (044h),A        ; Write data byte
        INC     HL              ; Point to next data byte
        DEC     BC              ; Decrement counter
        LD      A,B             ; Get counter
        OR      C               ; Check if counter at zero
        JR      NZ,L22DE        ; Continue until all bytes written
        RET                     ; Return








;----------------------------------------------------
;                Copy Graphics Memory
;       HL = Memory Position 0 - 960 (0000-03C0h)
;       DE = Destination to copy to
;       BC = Number of Bytes
;----------------------------------------------------
L22E8:  CALL    L2343           ; Setup Memory Position
L22EB:  IN      A,(045h)        ;
        LD      (DE),A          ;
        INC     DE              ;
        DEC     BC              ;
        LD      A,B             ;
        OR      C               ;
        JR      NZ,L22EB        ;        
        RET                     ; Return








;----------------------------------------------------
;             Program Graphics Chip 
;----------------------------------------------------
L22F5:  PUSH    HL              ; Save HL Register
        PUSH    BC              ; Save BC Register
        LD      HL,0E115h       ; HL = Graphics Chip Status
L22FA:  LD      A,(HL)          ; Check Graphics Chip Status
        OR      A               ; Is Graphics Chip available?
        JR      NZ,L22FA        ; No, so loop here and wait       
        LD      (HL),04Ch       ; Request Graphics Chip write
        LD      BC,00700h       ; Set timeout = 700h
L2303:  DEC     BC              ; Decrement timeout
        LD      A,B             ; Get timeout
        OR      C               ; Check timeout
        JR      Z,L230F         ; Timeout expired, now write to Chip        
        LD      A,(HL)          ; Get Graphics Chip Status
        OR      A               ; Is Graphics Chip available?
        JR      NZ,L2303        ; Not available so continue waiting        

L230C:  POP     BC              ; Restore BC Register
        POP     HL              ; Restore HL Register
        RET                     ; Return

L230F:  PUSH    DE              ; Save DE Register
        CALL    L2316           ; Write Graphics Registers  
        POP     DE              ; Restore DE Register
        JR      L230C           ; Jump back and return      








;---------------------------------------------------- 
;            Write Graphics Registers
;----------------------------------------------------
;   Write the following address to the graphics chip
;   Reg   RAM      Description
;   00    E12F  .0    External video input (0=input disable, 1=enable)
;               .1    Mode M3
;               .2    Mode M4 
;               .3    Mode M5 (Always 0)
;               .4    Horizontal Retrace Interrupt Enable
;               .5    Vertical Retrace Interrupt Enable
;               .6    Digitize mode
;               .7    (Always 0)Mode?
;   01    E130
;   02    E131
;   03    E132
;   04    E133
;   05    E134
;   06    E135
;   07    E136
;---------------------------------------------------- 
L2316:  IN      A,(055h)        ; Read Graphics Byte
        LD      DE,0E12Fh       ; Pointer to Graphics Registers
        LD      C,080h          ; C = Register Location + WRITE_BIT
        LD      B,008h          ; 8 Registers to write
L231F:  LD      A,(DE)          ; Get register byte
        INC     DE              ; Point to next byte
        OUT     (054h),A        ; Write Data Byte FIRST
        PUSH    AF              ; Small pause
        POP     AF              ; Small pause
        LD      A,C             ; Get Register Address
        OUT     (054h),A        ; Write Register SECOND
        PUSH    AF              ; Small pause
        POP     AF              ; Small pause
        IN      A,(055h)        ; Read Graphics Byte
        INC     C               ; Point to next Register Address
        DJNZ    L231F           ; Loop until all registers are writen               
        XOR     A               ; A = 0
        LD      (0E115h),A      ; Clear Write Request
        RET                     ; Return








;----------------------------------------------------
;     Set Text Cursor Position (with Display Bit)
;----------------------------------------------------
;       HL = Cursor Position 0 - 960 (0000-03C0h)
;----------------------------------------------------
;    DISPLAY MATRIX SETUP 24 ROWS, 40 COLUMNS
;            Row 1      0 - 39
;            Row 2     40 - 79
;            Row 3     80 - 119
;                  ...
;            Row 24   920 - 959
;---------------------------------------------------- 
L2334:  IN      A,(055h)        ; Read Graphics Byte
        LD      A,L             ; A = LSB Cursor Position
        OUT     (054h),A        ; Set LSB Cursor Position
        LD      A,H             ; A = MSB Cursor Position
        AND     03Fh            ;
        OR      040h            ; Set Display Bit
        OUT     (054h),A        ; Set MSB Cursor Position
        JP      L234D           ; Goto Delay
;----------------------------------------------------
;    Set Text Cursor Position (without Display Bit)
;----------------------------------------------------
L2343:  IN      A,(055h)        ; Read Graphics Byte
        LD      A,L             ; A = LSB Cursor Position
        OUT     (054h),A        ; Set LSB Cursor Position
        LD      A,H             ; A = MSB Cursor Position
        AND     03Fh            ;
        OUT     (054h),A        ; Set MSB Cursor Position
;---------------------------------------------------- 
;                   Short Delay 
;---------------------------------------------------- 
L234D:  LD      A,008h          ; Delay = 8
L234F:  DEC     A               ; Decrement Delay
        JR      NZ,L234F        ; Loop until Delay is zero        
        RET                     ; Return







;----------------------------------------------------
;    Wait for Comm to be ready, Timeout = 700h
;----------------------------------------------------
L2353:  PUSH    HL              ; Save HL Register
        PUSH    BC              ; Save BC Register
        PUSH    DE              ; Save DE Register
        PUSH    AF              ; Save AF Register
        LD      HL,0E111h       ; Point to Comm
        LD      BC,00700h       ; Set timeout = 700h
        LD      E,(HL)          ; Save Comm previous state
L235E:  DEC     BC              ; Decrement timeout
        LD      A,B             ; Check timeout
        OR      C               ; Compare timeout
        JR      Z,L2367         ; Timeout expired, so leave        
        LD      A,E             ; Get Comm previous state
        CP      (HL)            ; Compare to Comm current state
        JR      Z,L235E         ; Comm not clear so wait       
L2367:  POP     AF              ; Restore AF Register
        POP     DE              ; Restore DE Register
        POP     BC              ; Restore BC Register
        POP     HL              ; Restore HL Register
        RET                     ; Return







;----------------------------------------------------
;      graphics, program hardware, unknown?
;----------------------------------------------------
L236C:  LD      HL,0E12Fh       ; Get Graphics Registers
        SET     0,(HL)          ; Enable External Video Input 
        XOR     A               ; Text = TRANSPARENT, Bkgnd = TRANSPARENT
        LD      (0E136h),A      ; Set Color
        CALL    L22F5           ; Program Graphics Chip
        LD      HL,0E114h       ;
        SET     4,(HL)          ;
        LD      A,(HL)          ;
        OUT     (046h),A        ;
        RET                     ; Return





;----------------------------------------------------
;                  Unknown 
;----------------------------------------------------
L2381:  LD      HL,0E12Fh       ;
        SET     0,(HL)          ;
        CALL    L22F5           ; Program Graphics Chip    
        LD      HL,0E114h       ;
        SET     4,(HL)          ;
        LD      A,(HL)          ;
        OUT     (046h),A        ;
        RET                     ; Return




;----------------------------------------------------
;               Graphics Chip?? 
;----------------------------------------------------
L2392:  LD      HL,0E12Fh       ; Get Graphics Registers
        RES     0,(HL)          ; Disable External Video Input
        LD      HL,0E114h       ; 
        RES     4,(HL)          ;
        LD      A,(HL)          ;
        OUT     (046h),A        ;
        RET                     ; Return



;----------------------------------------------------
L23A0:   .DB   080h, 080h, 080h, 080h, 080h, 080h, 080h, 080h, 080h, 080h, 080h, 080h, 080h, 080h
         .DB   080h, 080h, 080h, 080h, 080h, 080h, 080h, 080h, 080h, 080h, 080h, 080h, 080h, 080h
         .DB   080h, 080h, 080h, 080h, 080h, 080h, 080h, 080h, 080h, 080h, 080h, 080h, 020h, 020h
         .DB   020h, 020h, 020h, 020h, 020h, 020h, 020h, 020h, 020h, 020h, 020h, 020h, 020h, 020h
         .DB   020h, 020h, 020h, 020h, 020h, 020h, 020h, 020h, 020h, 020h, 020h, 020h, 020h, 020h
         .DB   020h, 020h, 020h, 020h, 020h, 020h, 020h, 020h, 020h, 020h
;----------------------------------------------------
        





;----------------------------------------------------
;                 Loop BC = 1
;----------------------------------------------------
L23F0:  PUSH    BC              ; Save BC Register
        LD      BC,00001h       ; Loop = 1
L23F4:  PUSH    AF              ; Save AF Register
L23F5:  LD      A,000h          ; A = 0
        DEC     BC              ; Decrement loop
L23F8:  LD      A,B             ; Get loop
        OR      C               ; Check if loop is zero
L23FA:  JR      NZ,L23F5        ; Loop until delay complete                    
L23FC:  POP     AF              ; Restore AF Regisrer
        POP     BC              ; Restore BC Register
L23FE:  RET                     ; Return




;----------------------------------------------------
;             Time Delay Routine = 14h
;----------------------------------------------------
        PUSH    BC              ; Save BC Register
L2400:  LD      BC,00014h       ; Load Time Delay = 14h
        JR      L23F4           ; Jump to Delay Routine         


;----------------------------------------------------
;             Time Delay Routine = 19h
;----------------------------------------------------
        PUSH    BC              ; Save BC Register
L2406:  LD      BC,00019h       ; Load Time Delay = 19h
        JR      L23F4           ; Jump to Delay Routine               


;----------------------------------------------------
;             Time Delay Routine = 3Ch
;---------------------------------------------------- 
L240B:  PUSH    BC              ; Save BC Register
L240C:  LD      BC,0003Ch       ; Load Time Delay = 3Ch
        JR      L23F4           ; Jump to Delay Routine

                
;----------------------------------------------------
;             Time Delay Routine = 41h
;---------------------------------------------------- 
        PUSH    BC              ; Save BC Register
        LD      BC,00041h       ; Load Time Delay = 41h
        JR      L23F4           ; Jump to Delay Routine


;----------------------------------------------------
;             Time Delay Routine = 4Bh
;---------------------------------------------------- 
        PUSH    BC              ; Save BC Register
        LD      BC,0004Bh       ; Load Time Delay = 4Bh
        JR      L23F4           ; Jump to Delay Routine


;----------------------------------------------------
;             Time Delay Routine = 64h
;---------------------------------------------------- 
L241D:  PUSH    BC              ; Save BC Register
        LD      BC,00064h       ; Load Time Delay = 64h
        JR      L23F4           ; Jump to Delay Routine


;----------------------------------------------------
;             Time Delay Routine = C8h
;----------------------------------------------------
        PUSH    BC              ; Save BC Register
        LD      BC,000C8h       ; Load Time Delay = C8h
        JR      L23F4           ; Jump to Delay Routine
        

;----------------------------------------------------
;             Time Delay Routine = 320h
;----------------------------------------------------          
        PUSH    BC              ; Save BC Register
        LD      BC,00320h       ; Load Time Delay = 320h
        JR      L23F4           ; Jump to Delay Routine


;----------------------------------------------------
;             Time Delay Routine = 1000
;----------------------------------------------------   
L242F:  PUSH    BC              ; Save BC Register
        LD      BC,003E8h       ; Load Time Delay = 3E8h
        JR      L23F4           ; Jump to Delay Routine


;----------------------------------------------------
;             Time Delay Routine = 10000
;----------------------------------------------------   
Delay10000:
L2435:  PUSH    BC              ; Save BC Register
        LD      BC,02710h       ; Load Time Delay = 10000
        JR      L23F4           ; Jump to Delay Routine


;----------------------------------------------------
;             Time Delay Routine = C350h
;----------------------------------------------------   
        PUSH    BC              ; Save BC Register
        LD      BC,0C350h       ; Load Time Delay
        JR      L23F4           ; Jump to Delay Routine





;----------------------------------------------------
;        Time Delay Routine = (10 * 10000)
;----------------------------------------------------   
Delay100000:
L2441:  PUSH    AF              ; Save AF Register
        LD      A,00Ah          ; Loop = 10
L2444:  CALL    Delay10000      ; Call Delay 10,000
        DEC     A               ; Decrement Loop
        JR      NZ,L2444        ; Jump back until all delays complete
        POP     AF              ; Restore AF Register
        RET                     ; Return



;----------------------------------------------------
;        Time Delay Routine = (20 * 10000)
;---------------------------------------------------- 
L244C:  PUSH    AF              ; Save AF Register
        LD      A,014h          ; Loop = 20
        JR      L2444           ; Go to Delay Loop        



;----------------------------------------------------
;        Time Delay Routine = (50 * 10000)
;---------------------------------------------------- 
Delay500000:
L2451:  PUSH    AF              ; Save AF Register
        LD      A,032h          ; Loop = 50
        JR      L2444           ; Go to Delay Loop
        
      
      
;----------------------------------------------------
;        Time Delay Routine = (100 * 10000)
;----------------------------------------------------                            
        PUSH    AF              ; Save AF Register
        LD      A,064h          ; Loop = 100
        JR      L2444           ; Go to Delay Loop        









;----------------------------------------------------
;                  Get ALL Input Data
;----------------------------------------------------
L245B:  LD      HL,0E1A0h       ; Input Data Buffer
        LD      B,00Ah          ; Read all 10 BANKs
        LD      D,009h          ; Read BANKs 0-9
        JP      L247E           ; Debounce Input


;----------------------------------------------------
;            Get Joystick and Button Data
;----------------------------------------------------
L2465:  LD      A,I             ; Get Interrupt Page Register
        JP      PO,L2474        ; If set then only read Buttons
        LD      HL,0E197h       ; Joystick Data Buffer
        LD      B,002h          ; Read 2 BANKs
        LD      D,006h          ; Read BANK 5,6
        JP      L247E           ; Debounce Input


;----------------------------------------------------
;                   Get Button Data
;----------------------------------------------------
L2474:  LD      HL,0E194h       ; Button Data Buffer
        LD      B,001h          ; Read 1 BANK
        LD      D,005h          ; Read BANK 5
        JP      L247E           ; Debounce Input Data










;----------------------------------------------------
;              Debounce Input Data
;----------------------------------------------------
;        HL = End of Debounce Data Buffer
;        B  = Number of BANKs to read
;        D  = Ending Input BANK where
;
;               Bank 0  DIP Switches  1,2
;               Bank 1  DIP Switches 28-35
;               Bank 2  DIP Switches 20-27
;               Bank 3  DIP Switches 12-19
;               Bank 4  DIP Switches  4-11 
;               Bank 5  Button Data
;               Bank 6  Joystick Data
;               Bank 7  unknown
;               Bank 8  unknown
;               Bank 9  unknown
;
;----------------------------------------------------
L247E:  LD      A,00Fh          ; Turn off all Input BANKs
        OUT     (060h),A        ; Select Input BANK
        CALL    L23F0           ; Call Delay1

L2485:  LD      A,D             ; Get BANK Number
        OUT     (060h),A        ; Select Input BANK 
        CALL    L23F0           ; Call Delay1

        IN      A,(062h)        ; Read Input Data 
        CPL                     ; Reverse all bits
        EX      AF,AF'          ; Save Input Data
        LD      A,00Fh          ; Turn off all Input BANKs
        OUT     (060),A         ; Select Input BANK
;----------------------------------------------------
;     Each time we enter this routine we save the
;     Data into a debounce buffer.  The new value
;     is shifted into the buffer and the oldest 
;     value is discarded.
;      New Data -> State1 -> State2 -> (discard)
;----------------------------------------------------
        LD      A,(HL)          ; A = Input State2 (HL)
        DEC     HL              ; Point to State1
        LD      C,(HL)          ; C = Input State1 (HL-1)
        INC     HL              ; Point to State2
        LD      (HL),C          ; Move State1 (HL-1) into State2 (HL)
        DEC     HL              ; Point to State1
        XOR     C               ; Note bits that changed state
        AND     C               ; Check state
        LD      C,A             ; Save changed bits
        EX      AF,AF'          ; Recall current Input Data
        LD      (HL),A          ; Put Input Data into State1 (HL-1)
        DEC     HL              ; Point to Debounced Data
;----------------------------------------------------
; Examine debounce buffer to determine state of input
;----------------------------------------------------
        AND     C               ; AND New data with Changed bits
        OR      (HL)            ; Update any new bits
        LD      (HL),A          ; Store the debounced Data in its place
        DEC     HL              ; Point to next buffer
        DEC     D               ; Read another BANK
        DJNZ    L2485           ; Loop until all BANKs read
        RET                     ; Return









;----------------------------------------------------
;        Get DIP Switch Inputs from BANKs 0-4
;----------------------------------------------------
;  Start by clearing Switch Input Data  E183-E19Eh
;----------------------------------------------------
L24A7:  DI                      ; Disable Interrupts
        XOR     A               ; A = 0
        LD      B,00Ah          ; B = 10
        LD      DE,0E19Eh       ; Set Addresses to clear out
L24AE:  LD      (DE),A          ; Clear location
        DEC     DE              ; Decrement location pointer
        LD      (DE),A          ; Clear location
        DEC     DE              ; Decrement location pointer
        LD      (DE),A          ; Clear location
        DEC     DE              ; Decrement location pointer
        DJNZ    L24AE           ; Loop until all Input cleared out
                
;----------------------------------------------------
;    Loop through BANKs 0-4 and read in variables
;----------------------------------------------------
        LD      B,004h          ; Read BANKs 0-4
        LD      HL,0E18Fh       ; HL = Variable location
L24BB:  LD      A,00Fh          ; Turn off all BANKs
        OUT     (060h),A        ; Select Input BANK
        CALL    L23F0           ; Call Delay1
        CALL    L23F0           ; Call Delay1
        LD      A,B             ; Get BANK Number
        OUT     (060h),A        ; Select Input BANK
        CALL    L23F0           ; Call Delay1
        CALL    L23F0           ; Call Delay1
        IN      A,(062h)        ; Read Input Data
        CPL                     ; Reverse all bits 
        LD      (HL),A          ; Save DIP Switch Data
        DEC     HL              ; Skip debounce
        DEC     HL              ; Skip debounce
        DEC     HL              ; Skip debounce
        DJNZ    L24BB           ; Loop until all BANKs checked       
        EI                      ; Enable Interrupts
        RET                     ; Return







        EXX     
        PUSH    AF
        LD      HL,0E12Eh
        LD      A,(HL)
        DEC     HL
        ADD     A,(HL)
        LD      (HL),A
        DEC     HL
        ADC     A,(HL)
        LD      (HL),A
        DEC     HL
        ADC     A,(HL)
        LD      (HL),A
        LD      HL,0E12Eh
        INC     (HL)
        JR      NZ,L24F8                
        DEC     HL
        INC     (HL)
        JR      NZ,L24F8                
        DEC     HL
        INC     (HL)
        JR      NZ,L24F8                
        DEC     HL
        INC     (HL)

L24F8:  LD      L,A
        LD      H,000
        POP     DE
        LD      B,008

L24FE:  ADD     HL,HL
        LD      A,H
        SUB     D
        JR      C,L2504                 
        LD      H,A

L2504:  DJNZ    L24FE                  
        LD      A,H
        EXX     
        RET     







;----------------------------------------------------
;                   Tilt Routine
;----------------------------------------------------
L2509:  LD      A,(0E15Ah)      ; Get Tilted latch
        OR      A               ; Has game been tilted before?
        RET     NZ              ; Yes, so return
        LD      A,(0E126h)      ; Get Control Register
        BIT     0,A             ;
        JR      Z,L2521         ;        
        LD      SP,0F000h       ; Stack Pointer = F000h
        LD      HL,L0604        ; HL = Start of Begin game
        PUSH    HL              ; Push address onto stack
        IN      A,(055h)        ; Read Graphics Byte
        EI                      ; Enable Interrupts
        RETN                    ; Exit NMI Routine


L2521:  LD      A,001h          ; A = 1
        LD      (0E15Ah),A      ; Set Tilted Latch
        LD      A,(0E126h)      ; Get Control Register
        SET     2,A             ;
        LD      (0E126h),A      ; Save Control Register
        CALL    L2532           ; Display "TILT"
        RET                     ; Return






;----------------------------------------------------
;                 Display "TILT"
;----------------------------------------------------
L2532:  CALL    L21FF           ; Clear Text Display
        LD      A,041h          ; Text = BLUE, Bgnd = BLACK
        CALL    L20CA           ; Setup Graphics Chip for Text
        PUSH    HL              ; Save HL Register
        LD      HL,000CFh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
        .DB   07Fh, 07Fh, 07Fh, 07Fh, 07Fh, 07Fh, 07Fh, 020h
        .DB   020h, 07Fh, 020h, 020h, 020h, 07Fh, 020h, 020h
        .DB   020h, 020h, 07Fh, 07Fh, 07Fh, 07Fh, 07Fh, 07Fh, 07Fh         
        .DB   000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,000F7h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
        JR      NZ,L2585              
        JR      NZ,L25E6                
        JR      NZ,L2589              
        JR      NZ,L258B              
        JR      NZ,L25EC                

L256D:  JR      NZ,L258F             
        JR      NZ,L25F0                

L2571:  JR      NZ,L2593             

L2573:  JR      NZ,L2595             
        JR      NZ,L2597              
        JR      NZ,L25F8                
        JR      NZ,L259B              
        JR      NZ,L257D                
        .DB     000h
;----------------------------------------------------
L257D:  POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0011Fh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L2585:  JR      NZ,L25A7             
        JR      NZ,L2608                
L2589:  JR      NZ,L25AB             
L258B:  JR      NZ,L25AD             
        JR      NZ,L260E                
L258F:  JR      NZ,L25B1             
        JR      NZ,L2612                
L2593:  JR      NZ,L25B5             
L2595:  JR      NZ,L25B7             
L2597:  JR      NZ,L25B9             
        JR      NZ,L261A                
L259B:  JR      NZ,L25BD             
        JR      NZ,L259F                
;----------------------------------------------------
L259F:  POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00147h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L25A7:  JR      NZ,L25C9             
        JR      NZ,L262A                
L25AB:  JR      NZ,L25CD             
L25AD:  JR      NZ,L25CF             
        JR      NZ,L2630                
L25B1:  JR      NZ,L25D3             
        JR      NZ,L2634                
L25B5:  JR      NZ,L25D7             
L25B7:  JR      NZ,L25D9             
L25B9:  JR      NZ,L25DB             
        JR      NZ,L263C                
L25BD:  JR      NZ,L25DF             
        JR      NZ,L25C1                
;----------------------------------------------------
L25C1:  POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0016Fh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L25C9:  JR      NZ,L25EB             
        JR      NZ,L264C                
L25CD:  JR      NZ,L25EF             
L25CF:  JR      NZ,L25F1             
        JR      NZ,L2652                
L25D3:  JR      NZ,L25F5             
        JR      NZ,L2656                
L25D7:  JR      NZ,L25F9             
L25D9:  JR      NZ,L25FB             
L25DB:  JR      NZ,L25FD             
        JR      NZ,L265E                
L25DF:  JR      NZ,L2601             
        JR      NZ,L25E3                
;----------------------------------------------------
L25E3:  POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00197h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L25EB:  JR      NZ,L260D             
        JR      NZ,L266E                
L25EF:  JR      NZ,L2611             
L25F1:  JR      NZ,L2613             
        JR      NZ,L2674                
L25F5:  JR      NZ,L2617             
        JR      NZ,L2678                
L25F9:  JR      NZ,L261B             
L25FB:  JR      NZ,L261D             
L25FD:  JR      NZ,L261F             
        JR      NZ,L2680                
L2601:  JR      NZ,L2623             
        JR      NZ,L2605                
;----------------------------------------------------
L2605:  POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,001BFh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L260D:  JR      NZ,L262F             
        JR      NZ,L2690                
L2611:  JR      NZ,L2633             
L2613:  JR      NZ,L2635             
        JR      NZ,L2696                
L2617:  JR      NZ,L2639             
        JR      NZ,L269A                
L261B:  LD      A,A
        LD      A,A
L261D:  LD      A,A
        LD      A,A
L261F:  JR      NZ,L2641             
        JR      NZ,L26A2                
L2623:  JR      NZ,L2645             
        JR      NZ,L2627                
;----------------------------------------------------
L2627:  POP     HL              ; Restore HL Register
        RET                     ; Return









;----------------------------------------------------
;                 Begin Scene Data
;----------------------------------------------------
;              Scene One - Bank Heist
;----------------------------------------------------
L2629:   .DB  000h, 015h, 047h ; Frame 001547
L262C:   .DB  000h, 031h, 060h ; Frame 003160  
L262F:   .DB  000h, 000h, 000h ; Frame 000000
L2632:   .DB  000h, 000h, 000h ; Frame 000000
L2635:   .DB  00Ch             ; 12 Moves in scene

;----------------------------------------------------
;   Difficulty 1:Scene 1:Move 1
;----------------------------------------------------
L2636:   .DB  000h             ;
L2637:   .DB  000h             ; Correct Move   = NONE
L2638:   .DB  000h             ; Incorrect Move = NONE
L2639:   .DB  000h, 018h, 000h ; Move Start Frame:  001800
L263C:   .DB  000h, 000h, 000h ; Move End Frame:    000000 
L263F:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L2642:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L2645:   .DB  000h             ; Restart 
L2646:   .DB  00000h           ; Restart

;----------------------------------------------------
;   Difficulty 1:Scene 1:Move 2
;----------------------------------------------------
L2648:   .DB  000h             ;
L2649:   .DB  090h             ; Correct Move   = FEET
L264A:   .DB  060h             ; Incorrect Move = HANDS
L264B:   .DB  000h, 019h, 028h ; Move Start Frame:  001928  
L264E:   .DB  000h, 019h, 087h ; Move End Frame:    001987
L2651:   .DB  000h, 039h, 030h ; Death Start Frame: 003930  
L2654:   .DB  000h, 042h, 034h ; Death End Frame:   004234  
L2657:   .DB  00Ch             ; Restart 12 moves
L2658:   .DW  02636h           ; Restart:  Move 1


;----------------------------------------------------
;   Difficulty 1:Scene 1:Move 3
;----------------------------------------------------
L265A:   .DB  000h             ;
L265B:   .DB  090h             ; Correct Move   = FEET
L265C:   .DB  060h             ; Incorrect Move = HANDS
L265D:   .DB  000h, 019h, 090h ; Move Start Frame:  001990 
L2660:   .DB  000h, 020h, 040h ; Move End Frame:    002040 
L2663:   .DB  000h, 039h, 030h ; Death Start Frame: 003930 
L2666:   .DB  000h, 042h, 034h ; Death End Frame:   004234  
L2669:   .DB  00Ch             ; Restart 12 moves
L266A:   .DW  02636h           ; Restart: Move 1
 

;----------------------------------------------------
;   Difficulty 1:Scene 1:Move 4
;----------------------------------------------------
L266C:   .DB  000h             ;
L266D:   .DB  060h             ; Correct Move   = HANDS
L266E:   .DB  090h             ; Incorrect Move = FEET
L266F:   .DB  000h, 021h, 020h ; Move Start Frame:  002120 
L2672:   .DB  000h, 021h, 060h ; Move End Frame:    002160
L2675:   .DB  000h, 039h, 030h ; Death Start Frame: 003930 
L2678:   .DB  000h, 042h, 034h ; Death End Frame:   004234 
L267B:   .DB  00Ch             ; Restart 12 moves 
L267C:   .DW  02636h           ; Restart: Move 1


;----------------------------------------------------
;   Difficulty 1:Scene 1:Move 5
;---------------------------------------------------- 
L267E:   .DB  000h             ;
L267F:   .DB  008h             ; Correct Move   = UP
L2680:   .DB  062h             ; Incorrect Move = HANDS,DOWN
L2681:   .DB  000h, 021h, 086h ; Move Start Frame:  002186
L2684:   .DB  000h, 022h, 026h ; Move End Frame:    002226 
L2687:   .DB  000h, 039h, 030h ; Death Start Frame: 003930
L268A:   .DB  000h, 042h, 034h ; Death End Frame:   004234
L268D:   .DB  00Ch             ; Restart 12 moves
L268E:   .DW  02636h           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 1:Move 6
;---------------------------------------------------- 
L2690:   .DB  000h             ;
L2691:   .DB  000h             ; Correct Move   = NONE
L2692:   .DB  000h             ; Incorrect Move = NONE
L2693:   .DB  000h, 022h, 076h ; Move Start Frame:  002276 
L2696:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L2699:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L269C:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L269F:   .DB  007h             ; Restart 7 moves
L26A0:   .DW  02690h           ; Restart: Move 6

;----------------------------------------------------
;   Difficulty 1:Scene 1:Move 7
;----------------------------------------------------
L26A2:   .DB  000h             ;
L26A3:   .DB  001h             ; Correct Move   = LEFT
L26A4:   .DB  0F4h             ; Incorrect Move = HANDS,FEET,RIGHT
L26A5:   .DB  000h, 024h, 019h ; Move Start Frame:  002419
L26A8:   .DB  000h, 024h, 059h ; Move End Frame:    002459
L26AB:   .DB  000h, 032h, 014h ; Death Start Frame: 003214
L26AE:   .DB  000h, 035h, 000h ; Death End Frame:   003500
L26B1:   .DB  007h             ; Restart 7 moves
L26B2:   .DW  02690h           ; Restart: Move 6

;----------------------------------------------------
;   Difficulty 1:Scene 1:Move 8
;----------------------------------------------------
L26B4:   .DB  000h             ;
L26B5:   .DB  004h             ; Correct Move   = RIGHT
L26B6:   .DB  0F1h             ; Incorrect Move = HANDS,FEET,LEFT
L26B7:   .DB  000h, 024h, 047h ; Move Start Frame:  002447 
L26BA:   .DB  000h, 024h, 087h ; Move End Frame:    002487
L26BD:   .DB  000h, 032h, 014h ; Death Start Frame: 003214 
L26C0:   .DB  000h, 035h, 000h ; Death End Frame:   003500 
L26C3:   .DB  007h             ; Restart 7 moves
L26C4:   .DW  02690h           ; Restart: Move 6

;----------------------------------------------------
;   Difficulty 1:Scene 1:Move 9
;----------------------------------------------------
L26C6:   .DB  000h             ;
L26C7:   .DB  002h             ; Correct Move   = DOWN
L26C8:   .DB  0F8h             ; Incorrect Move = HANDS,FEET,UP
L26C9:   .DB  000h, 024h, 064h ; Move Start Frame:  002464 
L26CC:   .DB  000h, 025h, 004h ; Move End Frame:    002504
L26CF:   .DB  000h, 032h, 014h ; Death Start Frame: 003214 
L26D2:   .DB  000h, 035h, 000h ; Death End Frame:   003500 
L26D5:   .DB  007h             ; Restart 7 moves
L26D6:   .DW  02690h           ; Restart: Move 6

;----------------------------------------------------
;   Difficulty 1:Scene 1:Move 10
;----------------------------------------------------
L26D8:   .DB  000h             ;
L26D9:   .DB  001h             ; Correct Move   = LEFT
L26DA:   .DB  0FEh             ; Incorrect Move = HANDS,FEET,UP,DOWN,RIGHT
L26DB:   .DB  000h, 025h, 013h ; Move Start Frame:  002513 
L26DE:   .DB  000h, 025h, 053h ; Move End Frame:    002553 
L26E1:   .DB  000h, 032h, 014h ; Death Start Frame: 003214 
L26E4:   .DB  000h, 035h, 000h ; Death End Frame:   003500 
L26E7:   .DB  007h             ; Restart 7 moves
L26E8:   .DW  02690h           ; Restart: Move 6

;----------------------------------------------------
;   Difficulty 1:Scene 1:Move 11
;----------------------------------------------------
L26EA:   .DB  000h             ;
L26EB:   .DB  004h             ; Correct Move   = RIGHT
L26EC:   .DB  0F1h             ; Incorrect Move = HANDS,FEET,LEFT
L26ED:   .DB  000h, 025h, 049h ; Move Start Frame:  002549 
L26F0:   .DB  000h, 025h, 089h ; Move End Frame:    002589 
L26F3:   .DB  000h, 032h, 014h ; Death Start Frame: 003214 
L26F6:   .DB  000h, 035h, 000h ; Death End Frame:   003500 
L26F9:   .DB  007h             ; Restart 7 moves
L26FA:   .DW  02690h           ; Restart: Move 6

;----------------------------------------------------
;   Difficulty 1:Scene 1:Move 12
;----------------------------------------------------
L26FC:   .DB  000h             ;
L26FD:   .DB  060h             ; Correct Move   = HANDS
L26FE:   .DB  095h             ; Incorrect Move = FEET,LEFT,RIGHT
L26FF:   .DB  000h, 026h, 040h ; Move Start Frame:  002640 
L2702:   .DB  000h, 026h, 080h ; Move End Frame:    002680 
L2705:   .DB  000h, 032h, 014h ; Death Start Frame: 003214 
L2708:   .DB  000h, 035h, 000h ; Death End Frame:   003500 
L270B:   .DB  007h             ; Restart 7 moves
L270C:   .DW  02690h           ; Restart: Move 6

 







;----------------------------------------------------
;                Scene Two - The Getaway
;----------------------------------------------------
L270E:   .DB  000h, 047h, 076h ; Frame 004776 
L2711:   .DB  000h, 080h, 074h ; Frame 008074
L2714:   .DB  000h, 045h, 092h ; Frame 004592
L2717:   .DB  000h, 000h, 000h ; Frame 000000
L271A:   .DB  01Dh             ; 29 Moves in scene

;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 1
;----------------------------------------------------
L271B:   .DB  000h             ;
L271C:   .DB  000h             ; Correct Move   = NONE
L271D:   .DB  000h             ; Incorrect Move = NONE
L271E:   .DB  000h, 051h, 086h ; Move Start Frame:  005186
L2721:   .DB  000h, 000h, 000h ; Move End Frame:    000000 
L2724:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L2727:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L272A:   .DB  000h             ; Restart 
L272B:   .DW  00000h           ; Restart
 
;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 2
;----------------------------------------------------
L272D:   .DB  000h             ;         
L272E:   .DB  002h             ; Correct Move   = DOWN         
L272F:   .DB  0F0h             ; Incorrect Move = FEET,HANDS         
L2730:   .DB  000h, 053h, 088h ; Move Start Frame:  005388          
L2733:   .DB  000h, 054h, 028h ; Move End Frame:    005428          
L2736:   .DB  000h, 081h, 020h ; Death Start Frame: 008120          
L2739:   .DB  000h, 084h, 009h ; Death End Frame:   008409          
L273C:   .DB  01Dh             ; Restart 29 moves         
L273D:   .DW  0271Bh           ; Restart: Move 1         
 
;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 3
;----------------------------------------------------
L273F:   .DB  000h             ;         
L2740:   .DB  060h             ; Correct Move   = HANDS       
L2741:   .DB  00Eh             ; Incorrect Move = RIGHT,DOWN,UP
L2742:   .DB  000h, 054h, 018h ; Move Start Frame:  005418   
L2745:   .DB  000h, 054h, 058h ; Move End Frame:    005458   
L2748:   .DB  000h, 081h, 020h ; Death Start Frame: 008120   
L274B:   .DB  000h, 084h, 009h ; Death End Frame:   008409   
L274E:   .DB  01Dh             ; Restart 29 moves         
L274F:   .DW  0271Bh           ; Restart: Move 1         
 
;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 4
;----------------------------------------------------
L2751:   .DB  000h             ;         
L2752:   .DB  000h             ; Correct Move   = NONE       
L2753:   .DB  000h             ; Incorrect Move = NONE 
L2754:   .DB  000h, 054h, 084h ; Move Start Frame:  005484   
L2757:   .DB  000h, 055h, 024h ; Move End Frame:    005524   
L275A:   .DB  000h, 081h, 020h ; Death Start Frame: 008120   
L275D:   .DB  000h, 084h, 009h ; Death End Frame:   008409   
L2760:   .DB  01Dh             ; Restart 29 moves         
L2761:   .DW  0271Bh           ; Restart: Move 1         

;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 5
;----------------------------------------------------
L2763:   .DB  000h             ;         
L2764:   .DB  001h             ; Correct Move   = LEFT       
L2765:   .DB  0F0h             ; Incorrect Move = FEET,HANDS 
L2766:   .DB  000h, 055h, 016h ; Move Start Frame:  005516   
L2769:   .DB  000h, 055h, 056h ; Move End Frame:    005556   
L276C:   .DB  000h, 081h, 020h ; Death Start Frame: 008120   
L276F:   .DB  000h, 084h, 009h ; Death End Frame:   008409   
L2772:   .DB  01Dh             ; Restart 29 moves         
L2773:   .DW  0271Bh           ; Restart: Move 1         
 
;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 6
;----------------------------------------------------
L2775:   .DB  000h             ;         
L2776:   .DB  000h             ; Correct Move   = NONE
L2777:   .DB  000h             ; Incorrect Move = NONE
L2778:   .DB  000h, 055h, 060h ; Move Start Frame:  005560  
L277B:   .DB  000h, 000h, 000h ; Move End Frame:    000000  
L277E:   .DB  000h, 000h, 000h ; Death Start Frame: 000000  
L2781:   .DB  000h, 000h, 000h ; Death End Frame:   000000  
L2784:   .DB  000h             ; Restart         
L2785:   .DW  00000h           ; Restart         

;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 7
;----------------------------------------------------
L2787:   .DB  000h             ;         
L2788:   .DB  004h             ; Correct Move   = RIGHT
L2789:   .DB  0F0h             ; Incorrect Move = FEET,HANDS
L278A:   .DB  000h, 056h, 000h ; Move Start Frame:  005600  
L278D:   .DB  000h, 056h, 040h ; Move End Frame:    005640  
L2790:   .DB  000h, 081h, 020h ; Death Start Frame: 008120  
L2793:   .DB  000h, 084h, 009h ; Death End Frame:   008409  
L2796:   .DB  018h             ; Restart 24 moves         
L2797:   .DW  02775h           ; Restart: Move 6         

;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 8
;----------------------------------------------------
L2799:   .DB  000h             ;         
L279A:   .DB  004h             ; Correct Move   = RIGHT
L279B:   .DB  0F0h             ; Incorrect Move = FEET,HANDS
L279C:   .DB  000h, 056h, 080h ; Move Start Frame:  005680  
L279F:   .DB  000h, 057h, 020h ; Move End Frame:    005720  
L27A2:   .DB  000h, 084h, 039h ; Death Start Frame: 008439  
L27A5:   .DB  000h, 087h, 032h ; Death End Frame:   008732  
L27A8:   .DB  018h             ; Restart 24 moves         
L27A9:   .DW  02775h           ; Restart: Move 6         

;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 9
;----------------------------------------------------
L27AB:   .DB  000h             ;         
L27AC:   .DB  001h             ; Correct Move   = LEFT
L27AD:   .DB  0F0h             ; Incorrect Move = FEET,HANDS
L27AE:   .DB  000h, 057h, 010h ; Move Start Frame:  005710  
L27B1:   .DB  000h, 057h, 050h ; Move End Frame:    005750  
L27B4:   .DB  000h, 084h, 039h ; Death Start Frame: 008439  
L27B7:   .DB  000h, 087h, 032h ; Death End Frame:   008732  
L27BA:   .DB  018h             ; Restart 24 moves         
L27BB:   .DW  02775h           ; Restart: Move 6         

;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 10
;----------------------------------------------------
L27BD:   .DB  000h             ;         
L27BE:   .DB  001h             ; Correct Move   = LEFT
L27BF:   .DB  0F0h             ; Incorrect Move = FEET,HANDS
L27C0:   .DB  000h, 057h, 052h ; Move Start Frame:  005752  
L27C3:   .DB  000h, 057h, 092h ; Move End Frame:    005792  
L27C6:   .DB  000h, 084h, 039h ; Death Start Frame: 008439  
L27C9:   .DB  000h, 087h, 032h ; Death End Frame:   008732  
L27CC:   .DB  018h             ; Restart 24 moves         
L27CD:   .DW  02775h           ; Restart: Move 6         

;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 11
;----------------------------------------------------
L27CF:   .DB  000h             ;         
L27D0:   .DB  004h             ; Correct Move   = RIGHT
L27D1:   .DB  0FBh             ; Incorrect Move = FEET,HANDS,LEFT,UP,DOWN
L27D2:   .DB  000h, 058h, 002h ; Move Start Frame:  005802  
L27D5:   .DB  000h, 058h, 042h ; Move End Frame:    005842  
L27D8:   .DB  000h, 084h, 039h ; Death Start Frame: 008439  
L27DB:   .DB  000h, 087h, 032h ; Death End Frame:   008732  
L27DE:   .DB  018h             ; Restart 24 moves         
L27DF:   .DW  02775h           ; Restart: Move 6         

;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 12
;----------------------------------------------------
L27E1:   .DB  000h             ;         
L27E2:   .DB  002h             ; Correct Move   = DOWN
L27E3:   .DB  0F0h             ; Incorrect Move = FEET,HANDS
L27E4:   .DB  000h, 058h, 074h ; Move Start Frame:  005874  
L27E7:   .DB  000h, 059h, 014h ; Move End Frame:    005914  
L27EA:   .DB  000h, 084h, 039h ; Death Start Frame: 008439  
L27ED:   .DB  000h, 087h, 032h ; Death End Frame:   008732  
L27F0:   .DB  018h             ; Restart 24 moves         
L27F1:   .DW  02775h           ; Restart: Move 6         

;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 13
;----------------------------------------------------
L27F3:   .DB  000h             ;         
L27F4:   .DB  000h             ; Correct Move   = NONE
L27F5:   .DB  000h             ; Incorrect Move = NONE
L27F6:   .DB  000h, 059h, 020h ; Move Start Frame:  005920
L27F9:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L27FC:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L27FF:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L2802:   .DB  000h             ; Restart        
L2803:   .DW  00000h           ; Restart        

;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 14
;----------------------------------------------------
L2805:   .DB  000h             ;         
L2806:   .DB  001h             ; Correct Move   = LEFT
L2807:   .DB  0FEh             ; Incorrect Move = HANDS,FEET,RIGHT,UP,DOWN
L2808:   .DB  000h, 060h, 000h ; Move Start Frame:  006000
L280B:   .DB  000h, 060h, 040h ; Move End Frame:    006040
L280E:   .DB  000h, 097h, 094h ; Death Start Frame: 009794
L2811:   .DB  001h, 000h, 081h ; Death End Frame:   010081
L2814:   .DB  011h             ; Restart 17 moves        
L2815:   .DW  027F3h           ; Restart: Move 13        

;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 15
;----------------------------------------------------
L2817:   .DB  000h             ;         
L2818:   .DB  001h             ; Correct Move   = LEFT
L2819:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L281A:   .DB  000h, 061h, 008h ; Move Start Frame:  006108
L281D:   .DB  000h, 061h, 048h ; Move End Frame:    006148
L2820:   .DB  000h, 097h, 094h ; Death Start Frame: 009794
L2823:   .DB  001h, 000h, 081h ; Death End Frame:   010081
L2826:   .DB  011h             ; Restart 17 moves        
L2827:   .DW  027F3h           ; Restart: Move 13        

;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 16
;----------------------------------------------------
L2829:   .DB  000h             ;         
L282A:   .DB  001h             ; Correct Move   = LEFT
L282B:   .DB  0FEh             ; Incorrect Move = HANDS,FEET,RIGHT,UP,DOWN
L282C:   .DB  000h, 062h, 078h ; Move Start Frame:  006278
L282F:   .DB  000h, 063h, 018h ; Move End Frame:    006318
L2832:   .DB  000h, 097h, 094h ; Death Start Frame: 009794
L2835:   .DB  001h, 000h, 081h ; Death End Frame:   010081
L2838:   .DB  011h             ; Restart 17 moves        
L2839:   .DW  027F3h           ; Restart: Move 13        

;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 17
;----------------------------------------------------
L283B:   .DB  000h             ;         
L283C:   .DB  060h             ; Correct Move   = HANDS
L283D:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L283E:   .DB  000h, 063h, 042h ; Move Start Frame:  006342
L2841:   .DB  000h, 063h, 082h ; Move End Frame:    006382
L2844:   .DB  000h, 084h, 039h ; Death Start Frame: 008439
L2847:   .DB  000h, 087h, 032h ; Death End Frame:   008732
L284A:   .DB  011h             ; Restart 17 moves        
L284B:   .DW  027F3h           ; Restart: Move 13        

;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 18
;----------------------------------------------------
L284D:   .DB  000h             ;         
L284E:   .DB  008h             ; Correct Move   = UP
L284F:   .DB  0F7h             ; Incorrect Move = HANDS,FEET,LEFT,DOWN
L2850:   .DB  000h, 064h, 096h ; Move Start Frame:  006496
L2853:   .DB  000h, 065h, 036h ; Move End Frame:    006536
L2856:   .DB  000h, 084h, 039h ; Death Start Frame: 008439
L2859:   .DB  000h, 087h, 032h ; Death End Frame:   008732
L285C:   .DB  011h             ; Restart 17 moves        
L285D:   .DW  027F3h           ; Restart: Move 13        

;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 19
;----------------------------------------------------
L285F:   .DB  000h             ;         
L2860:   .DB  004h             ; Correct Move   = RIGHT
L2861:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L2862:   .DB  000h, 066h, 094h ; Move Start Frame:  006694
L2865:   .DB  000h, 067h, 034h ; Move End Frame:    006734
L2868:   .DB  001h, 001h, 005h ; Death Start Frame: 010105
L286B:   .DB  001h, 004h, 027h ; Death End Frame:   010427
L286E:   .DB  011h             ; Restart 17 moves        
L286F:   .DW  027F3h           ; Restart: Move 13        

;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 20
;----------------------------------------------------
L2871:   .DB  000h             ;         
L2872:   .DB  001h             ; Correct Move   = LEFT
L2873:   .DB  0FEh             ; Incorrect Move = HANDS,FEET,RIGHT,UP,DOWN
L2874:   .DB  000h, 069h, 004h ; Move Start Frame:  006904
L2877:   .DB  000h, 069h, 044h ; Move End Frame:    006944
L287A:   .DB  001h, 001h, 005h ; Death Start Frame: 010105
L287D:   .DB  001h, 004h, 027h ; Death End Frame:   010427
L2880:   .DB  011h             ; Restart 17 moves        
L2881:   .DW  027F3h           ; Restart: Move 13        

;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 21
;----------------------------------------------------
L2883:   .DB  000h             ;         
L2884:   .DB  000h             ; Correct Move   = NONE
L2885:   .DB  000h             ; Incorrect Move = NONE
L2886:   .DB  000h, 069h, 074h ; Move Start Frame:  006974
L2889:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L288C:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L288F:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L2892:   .DB  000h             ; Restart        
L2893:   .DW  00000h           ; Restart        

;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 22
;----------------------------------------------------
L2895:   .DB  000h             ;         
L2896:   .DB  002h             ; Correct Move   = DOWN
L2897:   .DB  0FDh             ; Incorrect Move = HANDS,FEET,LEFT,RIGHT,UP
L2898:   .DB  000h, 070h, 015h ; Move Start Frame:  007015
L289B:   .DB  000h, 070h, 055h ; Move End Frame:    007055
L289E:   .DB  001h, 001h, 005h ; Death Start Frame: 010105
L28A1:   .DB  001h, 004h, 027h ; Death End Frame:   010427
L28A4:   .DB  009h             ; Restart 9 moves        
L28A5:   .DW  02883h           ; Restart: Move 21        

;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 23
;----------------------------------------------------
L28A7:   .DB  000h             ;         
L28A8:   .DB  001h             ; Correct Move   = LEFT
L28A9:   .DB  0FEh             ; Incorrect Move = HANDS,FEET,RIGHT,UP,DOWN
L28AA:   .DB  000h, 071h, 014h ; Move Start Frame:  007114
L28AD:   .DB  000h, 071h, 054h ; Move End Frame:    007154
L28B0:   .DB  001h, 001h, 005h ; Death Start Frame: 010105
L28B3:   .DB  001h, 004h, 027h ; Death End Frame:   010427
L28B6:   .DB  009h             ; Restart 9 moves        
L28B7:   .DW  02883h           ; Restart: Move 21        

;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 24
;----------------------------------------------------
L28B9:   .DB  000h             ;         
L28BA:   .DB  060h             ; Correct Move   = HANDS
L28BB:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L28BC:   .DB  000h, 072h, 002h ; Move Start Frame:  007202
L28BF:   .DB  000h, 072h, 042h ; Move End Frame:    007242
L28C2:   .DB  000h, 081h, 020h ; Death Start Frame: 008120
L28C5:   .DB  000h, 084h, 009h ; Death End Frame:   008409
L28C8:   .DB  009h             ; Restart 9 moves        
L28C9:   .DW  02883h           ; Restart: Move 21        

;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 25
;----------------------------------------------------
L28CB:   .DB  000h             ;         
L28CC:   .DB  090h             ; Correct Move   = FEET
L28CD:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L28CE:   .DB  000h, 072h, 039h ; Move Start Frame:  007239
L28D1:   .DB  000h, 072h, 079h ; Move End Frame:    007279
L28D4:   .DB  000h, 081h, 020h ; Death Start Frame: 008120
L28D7:   .DB  000h, 084h, 009h ; Death End Frame:   008409
L28DA:   .DB  009h             ; Restart 9 moves        
L28DB:   .DW  02883h           ; Restart: Move 21        

;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 26
;----------------------------------------------------
L28DD:   .DB  000h             ;         
L28DE:   .DB  090h             ; Correct Move   = FEET
L28DF:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L28E0:   .DB  000h, 072h, 084h ; Move Start Frame:  007284
L28E3:   .DB  000h, 073h, 024h ; Move End Frame:    007324
L28E6:   .DB  000h, 081h, 020h ; Death Start Frame: 008120
L28E9:   .DB  000h, 084h, 009h ; Death End Frame:   008409
L28EC:   .DB  009h             ; Restart 9 moves        
L28ED:   .DW  02883h           ; Restart: Move 21        

;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 27
;----------------------------------------------------
L28EF:   .DB  000h             ;         
L28F0:   .DB  090h             ; Correct Move   = FEET
L28F1:   .DB  06Fh             ; Incorrect Move = HANDS,LEFT,RIGHT,UP,DOWN
L28F2:   .DB  000h, 074h, 003h ; Move Start Frame:  007403
L28F5:   .DB  000h, 074h, 043h ; Move End Frame:    007443
L28F8:   .DB  000h, 084h, 039h ; Death Start Frame: 008439
L28FB:   .DB  000h, 087h, 032h ; Death End Frame:   008732
L28FE:   .DB  009h             ; Restart 9 moves        
L28FF:   .DW  02883h           ; Restart: Move 21        

;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 28
;----------------------------------------------------
L2901:   .DB  000h             ;         
L2902:   .DB  004h             ; Correct Move   = RIGHT
L2903:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L2904:   .DB  000h, 074h, 070h ; Move Start Frame:  007470
L2907:   .DB  000h, 075h, 010h ; Move End Frame:    007510
L290A:   .DB  000h, 084h, 039h ; Death Start Frame: 008439
L290D:   .DB  000h, 087h, 032h ; Death End Frame:   008732
L2910:   .DB  009h             ; Restart 9 moves        
L2911:   .DW  02883h           ; Restart: Move 21        

;----------------------------------------------------
;   Difficulty 1:Scene 2:Move 29
;----------------------------------------------------
L2913:   .DB  000h             ;         
L2914:   .DB  060h             ; Correct Move   = HANDS
L2915:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2916:   .DB  000h, 079h, 058h ; Move Start Frame:  007958
L2919:   .DB  000h, 079h, 098h ; Move End Frame:    007998
L291C:   .DB  001h, 017h, 053h ; Death Start Frame: 011753
L291F:   .DB  001h, 022h, 015h ; Death End Frame:   012215
L2922:   .DB  009h             ; Restart 9 moves        
L2923:   .DW  02883h           ; Restart: Move 21        
 









;----------------------------------------------------
;             Scene Three - Rooftops
;----------------------------------------------------
L2925:   .DB  001h, 023h, 097h ; Frame 012397
L2928:   .DB  001h, 072h, 048h ; Frame 017248
L292B:   .DB  001h, 022h, 047h ; Frame 012247
L292E:   .DB  000h, 000h, 000h ; Frame 000000
L2931:   .DB  024h             ; 36 moves in scene
 
;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 1
;----------------------------------------------------
L2932:   .DB  000h             ;         
L2933:   .DB  000h             ; Correct Move   = NONE
L2934:   .DB  000h             ; Incorrect Move = NONE
L2935:   .DB  001h, 024h, 060h ; Move Start Frame:  012460
L2938:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L293B:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L293E:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L2941:   .DB  000h             ; Restart
L2942:   .DW  00000h           ; Restart        

;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 2
;---------------------------------------------------- 
L2944:   .DB  000h             ;         
L2945:   .DB  060h             ; Correct Move   = HANDS
L2946:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2947:   .DB  001h, 027h, 002h ; Move Start Frame:  012702
L294A:   .DB  001h, 027h, 042h ; Move End Frame:    012742
L294D:   .DB  001h, 072h, 051h ; Death Start Frame: 017251
L2950:   .DB  001h, 078h, 020h ; Death End Frame:   017820
L2953:   .DB  024h             ; Restart 36 moves        
L2954:   .DW  02932h           ; Restart: Move 1        
 
;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 3
;----------------------------------------------------
L2956:   .DB  000h             ;         
L2957:   .DB  060h             ; Correct Move   = HANDS
L2958:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2959:   .DB  001h, 027h, 025h ; Move Start Frame:  012725
L295C:   .DB  001h, 027h, 065h ; Move End Frame:    012765
L295F:   .DB  001h, 072h, 051h ; Death Start Frame: 017251
L2962:   .DB  001h, 078h, 020h ; Death End Frame:   017820
L2965:   .DB  024h             ; Restart 36 moves        
L2966:   .DW  02932h           ; Restart: Move 1        
 
;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 4
;----------------------------------------------------
L2968:   .DB  000h             ;         
L2969:   .DB  000h             ; Correct Move   = NONE
L296A:   .DB  000h             ; Incorrect Move = NONE
L296B:   .DB  001h, 036h, 001h ; Move Start Frame:  013601
L296E:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L2971:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L2974:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L2977:   .DB  000h             ; Restart
L2978:   .DW  00000h           ; Restart        

;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 5
;---------------------------------------------------- 
L297A:   .DB  000h             ;         
L297B:   .DB  000h             ; Correct Move   = NONE
L297C:   .DB  000h             ; Incorrect Move = NONE
L297D:   .DB  001h, 038h, 066h ; Move Start Frame:  013866
L2980:   .DB  001h, 039h, 006h ; Move End Frame:    013906
L2983:   .DB  001h, 082h, 035h ; Death Start Frame: 018235
L2986:   .DB  001h, 085h, 077h ; Death End Frame:   018577
L2989:   .DB  021h             ; Restart 33 moves
L298A:   .DW  02968h           ; Restart: Move 4        

;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 6
;---------------------------------------------------- 
L298C:   .DB  000h             ;         
L298D:   .DB  001h             ; Correct Move   = LEFT
L298E:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L298F:   .DB  001h, 038h, 088h ; Move Start Frame:  013888
L2992:   .DB  001h, 039h, 018h ; Move End Frame:    013918
L2995:   .DB  001h, 082h, 035h ; Death Start Frame: 018235
L2998:   .DB  001h, 085h, 077h ; Death End Frame:   018577
L299B:   .DB  021h             ; Restart 33 moves
L299C:   .DW  02968h           ; Restart: Move 4        

;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 7
;----------------------------------------------------
L299E:   .DB  000h             ;         
L299F:   .DB  090h             ; Correct Move   = FEET
L29A0:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L29A1:   .DB  001h, 038h, 098h ; Move Start Frame:  013898
L29A4:   .DB  001h, 039h, 028h ; Move End Frame:    013928
L29A7:   .DB  001h, 082h, 035h ; Death Start Frame: 018235
L29AA:   .DB  001h, 085h, 077h ; Death End Frame:   018577
L29AD:   .DB  021h             ; Restart 33 moves
L29AE:   .DW  02968h           ; Restart: Move 4        

;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 8
;----------------------------------------------------
L29B0:   .DB  000h             ;         
L29B1:   .DB  008h             ; Correct Move   = UP
L29B2:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L29B3:   .DB  001h, 039h, 044h ; Move Start Frame:  013944
L29B6:   .DB  001h, 039h, 084h ; Move End Frame:    013984
L29B9:   .DB  001h, 082h, 035h ; Death Start Frame: 018235
L29BC:   .DB  001h, 085h, 077h ; Death End Frame:   018577
L29BF:   .DB  021h             ; Restart 33 moves
L29C0:   .DW  02968h           ; Restart: Move 4        

;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 9
;----------------------------------------------------
L29C2:   .DB  000h             ;         
L29C3:   .DB  004h             ; Correct Move   = RIGHT
L29C4:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L29C5:   .DB  001h, 040h, 044h ; Move Start Frame:  014044
L29C8:   .DB  001h, 040h, 084h ; Move End Frame:    014084
L29CB:   .DB  001h, 082h, 035h ; Death Start Frame: 018235
L29CE:   .DB  001h, 085h, 077h ; Death End Frame:   018577
L29D1:   .DB  021h             ; Restart 33 moves
L29D2:   .DW  02968h           ; Restart: Move 4        

;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 10
;----------------------------------------------------
L29D4:   .DB  000h             ;         
L29D5:   .DB  001h             ; Correct Move   = LEFT
L29D6:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L29D7:   .DB  001h, 042h, 056h ; Move Start Frame:  014256
L29DA:   .DB  001h, 042h, 096h ; Move End Frame:    014296
L29DD:   .DB  001h, 082h, 035h ; Death Start Frame: 018235
L29E0:   .DB  001h, 085h, 077h ; Death End Frame:   018577
L29E3:   .DB  021h             ; Restart 33 moves
L29E4:   .DW  02968h           ; Restart: Move 4        

;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 11
;----------------------------------------------------
L29E6:   .DB  000h             ;         
L29E7:   .DB  001h             ; Correct Move   = LEFT
L29E8:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L29E9:   .DB  001h, 043h, 043h ; Move Start Frame:  014343
L29EC:   .DB  001h, 043h, 083h ; Move End Frame:    014383
L29EF:   .DB  001h, 082h, 035h ; Death Start Frame: 018235
L29F2:   .DB  001h, 085h, 077h ; Death End Frame:   018577
L29F5:   .DB  021h             ; Restart 33 moves
L29F6:   .DW  02968h           ; Restart: Move 4        

;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 12
;----------------------------------------------------
L29F8:   .DB  000h             ;         
L29F9:   .DB  000h             ; Correct Move   = NONE
L29FA:   .DB  000h             ; Incorrect Move = NONE
L29FB:   .DB  001h, 045h, 069h ; Move Start Frame:  014569
L29FE:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L2A01:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L2A04:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L2A07:   .DB  000h             ; Restart
L2A08:   .DW  00000h           ; Restart        

;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 13
;----------------------------------------------------
L2A0A:   .DB  000h             ;         
L2A0B:   .DB  060h             ; Correct Move   = HANDS
L2A0C:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2A0D:   .DB  001h, 046h, 068h ; Move Start Frame:  014668
L2A10:   .DB  001h, 047h, 008h ; Move End Frame:    014708
L2A13:   .DB  001h, 082h, 035h ; Death Start Frame: 018235
L2A16:   .DB  001h, 085h, 077h ; Death End Frame:   018577
L2A19:   .DB  019h             ; Restart 25 moves
L2A1A:   .DW  029F8h           ; Restart: Move 12        

;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 14
;----------------------------------------------------
L2A1C:   .DB  000h             ;         
L2A1D:   .DB  002h             ; Correct Move   = DOWN
L2A1E:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L2A1F:   .DB  001h, 046h, 094h ; Move Start Frame:  014694
L2A22:   .DB  001h, 047h, 034h ; Move End Frame:    014734
L2A25:   .DB  001h, 082h, 035h ; Death Start Frame: 018235
L2A28:   .DB  001h, 085h, 077h ; Death End Frame:   018577
L2A2B:   .DB  019h             ; Restart 25 moves
L2A2C:   .DW  029F8h           ; Restart: Move 12        

;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 15
;----------------------------------------------------
L2A2E:   .DB  000h             ;         
L2A2F:   .DB  004h             ; Correct Move   = RIGHT
L2A30:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L2A31:   .DB  001h, 047h, 088h ; Move Start Frame:  014788
L2A34:   .DB  001h, 048h, 018h ; Move End Frame:    014818
L2A37:   .DB  001h, 095h, 096h ; Death Start Frame: 019596
L2A3A:   .DB  001h, 098h, 089h ; Death End Frame:   019889
L2A3D:   .DB  019h             ; Restart 25 moves
L2A3E:   .DW  029F8h           ; Restart: Move 12        
 
;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 16
;----------------------------------------------------
L2A40:   .DB  000h             ;         
L2A41:   .DB  001h             ; Correct Move   = LEFT
L2A42:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L2A43:   .DB  001h, 048h, 018h ; Move Start Frame:  014818
L2A46:   .DB  001h, 048h, 058h ; Move End Frame:    014858
L2A49:   .DB  001h, 095h, 096h ; Death Start Frame: 019596
L2A4C:   .DB  001h, 098h, 089h ; Death End Frame:   019889
L2A4F:   .DB  019h             ; Restart 25 moves
L2A50:   .DW  029F8h           ; Restart: Move 12        

;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 17
;----------------------------------------------------
L2A52:   .DB  000h             ;         
L2A53:   .DB  000h             ; Correct Move   = NONE
L2A54:   .DB  000h             ; Incorrect Move = NONE
L2A55:   .DB  001h, 050h, 014h ; Move Start Frame:  015014
L2A58:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L2A5B:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L2A5E:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L2A61:   .DB  000h             ; Restart
L2A62:   .DW  00000h           ; Restart        

;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 18
;----------------------------------------------------
L2A64:   .DB  000h             ;         
L2A65:   .DB  008h             ; Correct Move   = UP
L2A66:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L2A67:   .DB  001h, 051h, 043h ; Move Start Frame:  015143
L2A6A:   .DB  001h, 051h, 083h ; Move End Frame:    015183
L2A6D:   .DB  001h, 095h, 096h ; Death Start Frame: 018596
L2A70:   .DB  001h, 098h, 089h ; Death End Frame:   019889
L2A73:   .DB  014h             ; Restart 20 moves
L2A74:   .DW  02A52h           ; Restart: Move 17        

;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 19
;----------------------------------------------------
L2A76:   .DB  000h             ;         
L2A77:   .DB  002h             ; Correct Move   = RIGHT
L2A78:   .DB  0F8h             ; Incorrect Move = HANDS,FEET,UP
L2A79:   .DB  001h, 052h, 021h ; Move Start Frame:  015221
L2A7C:   .DB  001h, 052h, 061h ; Move End Frame:    015261
L2A7F:   .DB  001h, 095h, 096h ; Death Start Frame: 019596
L2A82:   .DB  001h, 098h, 089h ; Death End Frame:   019889
L2A85:   .DB  014h             ; Restart 20 moves
L2A86:   .DB  02A52h           ; Restart: Move 17        

;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 20
;----------------------------------------------------
L2A88:   .DB  000h             ;         
L2A89:   .DB  001h             ; Correct Move   = LEFT
L2A8A:   .DB  0F4h             ; Incorrect Move = HANDS,FEET,RIGHT
L2A8B:   .DB  001h, 052h, 032h ; Move Start Frame:  015232
L2A8E:   .DB  001h, 052h, 072h ; Move End Frame:    015272
L2A91:   .DB  001h, 095h, 096h ; Death Start Frame: 019596
L2A94:   .DB  001h, 098h, 089h ; Death End Frame:   019889
L2A97:   .DB  014h             ; Restart 20 moves
L2A98:   .DW  02A52h           ; Restart: Move 17        

;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 21
;----------------------------------------------------
L2A9A:   .DB  000h             ;         
L2A9B:   .DB  002h             ; Correct Move   = DOWN
L2A9C:   .DB  0F8h             ; Incorrect Move = HANDS,FEET,RIGHT
L2A9D:   .DB  001h, 052h, 053h ; Move Start Frame:  015253
L2AA0:   .DB  001h, 052h, 093h ; Move End Frame:    015293
L2AA3:   .DB  001h, 095h, 096h ; Death Start Frame: 019596
L2AA6:   .DB  001h, 098h, 089h ; Death End Frame:   019889
L2AA9:   .DB  014h             ; Restart 20 moves
L2AAA:   .DW  02A52h           ; Restart: Move 17        

;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 22
;----------------------------------------------------
L2AAC:   .DB  000h             ;         
L2AAD:   .DB  004h             ; Correct Move   = RIGHT
L2AAE:   .DB  0F1h             ; Incorrect Move = HANDS,FEET,LEFT
L2AAF:   .DB  001h, 052h, 070h ; Move Start Frame:  015270
L2AB2:   .DB  001h, 053h, 010h ; Move End Frame:    015310
L2AB5:   .DB  001h, 095h, 096h ; Death Start Frame: 019596
L2AB8:   .DB  001h, 098h, 089h ; Death End Frame:   019889
L2ABB:   .DB  014h             ; Restart 20 moves
L2ABC:   .DW  02A52h           ; Restart: Move 17        

;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 23
;----------------------------------------------------
L2ABE:   .DB  000h             ;         
L2ABF:   .DB  008h             ; Correct Move   = UP
L2AC0:   .DB  0F2h             ; Incorrect Move = HANDS,FEET,DOWN
L2AC1:   .DB  001h, 052h, 096h ; Move Start Frame:  015296
L2AC4:   .DB  001h, 053h, 036h ; Move End Frame:    015336
L2AC7:   .DB  001h, 095h, 096h ; Death Start Frame: 019596
L2ACA:   .DB  001h, 098h, 089h ; Death End Frame:   019889
L2ACD:   .DB  014h             ; Restart 20 moves
L2ACE:   .DW  02A52h           ; Restart: Move 17        

;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 24
;----------------------------------------------------
L2AD0:   .DB  000h             ;         
L2AD1:   .DB  000h             ; Correct Move   = NONE
L2AD2:   .DB  000h             ; Incorrect Move = NONE
L2AD3:   .DB  001h, 057h, 050h ; Move Start Frame:  015750
L2AD6:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L2AD9:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L2ADC:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L2ADF:   .DB  000h             ; Restart
L2AE0:   .DB  00000h           ; Restart        
 
;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 25
;----------------------------------------------------
L2AE2:   .DB  000h             ;         
L2AE3:   .DB  008h             ; Correct Move   = UP
L2AE4:   .DB  0F2h             ; Incorrect Move = HANDS,FEET,DOWN
L2AE5:   .DB  001h, 058h, 084h ; Move Start Frame:  015884
L2AE8:   .DB  001h, 059h, 014h ; Move End Frame:    015914
L2AEB:   .DB  001h, 082h, 035h ; Death Start Frame: 018235
L2AEE:   .DB  001h, 085h, 077h ; Death End Frame:   018577
L2AF1:   .DB  00Dh             ; Restart 13 moves
L2AF2:   .DW  02AD0h           ; Restart: Move 24        
 
;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 26
;---------------------------------------------------- 
L2AF4:   .DB  000h             ;         
L2AF5:   .DB  001h             ; Correct Move   = LEFT
L2AF6:   .DB  0F4h             ; Incorrect Move = HANDS,FEET,RIGHT
L2AF7:   .DB  001h, 060h, 054h ; Move Start Frame:  016054
L2AFA:   .DB  001h, 060h, 094h ; Move End Frame:    016094
L2AFD:   .DB  001h, 082h, 035h ; Death Start Frame: 018235
L2B00:   .DB  001h, 085h, 077h ; Death End Frame:   018577
L2B03:   .DB  00Dh             ; Restart 13 moves
L2B04:   .DW  02AD0h           ; Restart: Move 24        
 
;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 27
;----------------------------------------------------
L2B06:   .DB  000h             ;         
L2B07:   .DB  004h             ; Correct Move   = RIGHT
L2B08:   .DB  0F1h             ; Incorrect Move = HANDS,FEET,LEFT
L2B09:   .DB  001h, 060h, 094h ; Move Start Frame:  016094
L2B0C:   .DB  001h, 061h, 034h ; Move End Frame:    016134
L2B0F:   .DB  001h, 082h, 035h ; Death Start Frame: 018235
L2B12:   .DB  001h, 085h, 077h ; Death End Frame:   018577
L2B15:   .DB  00Dh             ; Restart 13 moves
L2B16:   .DW  02AD0h           ; Restart: Move 24        
 
;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 28
;----------------------------------------------------
L2B18:   .DB  000h             ;         
L2B19:   .DB  001h             ; Correct Move   = LEFT
L2B1A:   .DB  0F4h             ; Incorrect Move = HANDS,FEET,RIGHT
L2B1B:   .DB  001h, 061h, 037h ; Move Start Frame:  016137
L2B1E:   .DB  001h, 061h, 077h ; Move End Frame:    016177
L2B21:   .DB  001h, 082h, 035h ; Death Start Frame: 018235
L2B24:   .DB  001h, 085h, 077h ; Death End Frame:   018577
L2B27:   .DB  00Dh             ; Restart 13 moves
L2B28:   .DW  02AD0h           ; Restart: Move 24        
 
;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 29
;----------------------------------------------------
L2B2A:   .DB  000h             ;         
L2B2B:   .DB  004h             ; Correct Move   = RIGHT
L2B2C:   .DB  0F1h             ; Incorrect Move = HANDS,FEET,LEFT
L2B2D:   .DB  001h, 061h, 070h ; Move Start Frame:  016170
L2B30:   .DB  001h, 062h, 010h ; Move End Frame:    016210
L2B33:   .DB  001h, 082h, 035h ; Death Start Frame: 018235
L2B36:   .DB  001h, 085h, 077h ; Death End Frame:   018577
L2B39:   .DB  00Dh             ; Restart 13 moves
L2B3A:   .DW  02AD0h           ; Restart: Move 24        
 
;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 30
;----------------------------------------------------
L2B3C:   .DB  000h             ;         
L2B3D:   .DB  001h             ; Correct Move   = LEFT
L2B3E:   .DB  0F4h             ; Incorrect Move = HANDS,FEET,RIGHT
L2B3F:   .DB  001h, 062h, 022h ; Move Start Frame:  016222
L2B42:   .DB  001h, 062h, 062h ; Move End Frame:    016262
L2B45:   .DB  001h, 082h, 035h ; Death Start Frame: 018235
L2B48:   .DB  001h, 085h, 077h ; Death End Frame:   018577
L2B4B:   .DB  00Dh             ; Restart 13 moves
L2B4C:   .DW  02AD0h           ; Restart: Move 24        
 
;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 31
;----------------------------------------------------
L2B4E:   .DB  000h             ;         
L2B4F:   .DB  004h             ; Correct Move   = RIGHT
L2B50:   .DB  0F1h             ; Incorrect Move = HANDS,FEET,LEFT
L2B51:   .DB  001h, 062h, 054h ; Move Start Frame:  016254
L2B54:   .DB  001h, 062h, 094h ; Move End Frame:    016294
L2B57:   .DB  001h, 082h, 035h ; Death Start Frame: 018235
L2B5A:   .DB  001h, 085h, 077h ; Death End Frame:   018577
L2B5D:   .DB  00Dh             ; Restart 13 moves
L2B5E:   .DW  02AD0h           ; Restart: Move 24        
 
;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 32
;----------------------------------------------------
L2B60:   .DB  000h             ;         
L2B61:   .DB  001h             ; Correct Move   = LEFT
L2B62:   .DB  0F4h             ; Incorrect Move = HANDS,FEET,RIGHT
L2B63:   .DB  001h, 063h, 007h ; Move Start Frame:  016307
L2B66:   .DB  001h, 063h, 047h ; Move End Frame:    016347
L2B69:   .DB  001h, 082h, 035h ; Death Start Frame: 018235
L2B6C:   .DB  001h, 085h, 077h ; Death End Frame:   018577
L2B6F:   .DB  00Dh             ; Restart 13 moves
L2B70:   .DW  02AD0h           ; Restart: Move 24        
 
;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 33
;----------------------------------------------------
L2B72:   .DB  000h             ;         
L2B73:   .DB  004h             ; Correct Move   = RIGHT
L2B74:   .DB  0F1h             ; Incorrect Move = HANDS,FEET,LEFT
L2B75:   .DB  001h, 063h, 039h ; Move Start Frame:  016339
L2B78:   .DB  001h, 063h, 079h ; Move End Frame:    016379
L2B7B:   .DB  001h, 082h, 035h ; Death Start Frame: 018235
L2B7E:   .DB  001h, 085h, 077h ; Death End Frame:   018577
L2B81:   .DB  00Dh             ; Restart 13 moves
L2B82:   .DW  02AD0h           ; Restart: Move 24        
 
;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 34
;----------------------------------------------------
L2B84:   .DB  000h             ;         
L2B85:   .DB  001h             ; Correct Move   = LEFT
L2B86:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L2B87:   .DB  001h, 063h, 092h ; Move Start Frame:  016392
L2B8A:   .DB  001h, 064h, 032h ; Move End Frame:    016432
L2B8D:   .DB  001h, 082h, 035h ; Death Start Frame: 018235
L2B90:   .DB  001h, 085h, 077h ; Death End Frame:   018577
L2B93:   .DB  00Dh             ; Restart 13 moves
L2B94:   .DW  02AD0h           ; Restart: Move 24        
 
;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 35
;----------------------------------------------------
L2B96:   .DB  000h             ;         
L2B97:   .DB  004h             ; Correct Move   = RIGHT
L2B98:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L2B99:   .DB  001h, 064h, 024h ; Move Start Frame:  016424
L2B9C:   .DB  001h, 064h, 064h ; Move End Frame:    016464
L2B9F:   .DB  001h, 082h, 035h ; Death Start Frame: 018235
L2BA2:   .DB  001h, 085h, 077h ; Death End Frame:   018577
L2BA5:   .DB  00Dh             ; Restart 13 moves
L2BA6:   .DW  02AD0h           ; Restart: Move 24        
 
;----------------------------------------------------
;   Difficulty 1:Scene 3:Move 36
;----------------------------------------------------
L2BA8:   .DB  000h             ;         
L2BA9:   .DB  004h             ; Correct Move   = RIGHT
L2BAA:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L2BAB:   .DB  001h, 069h, 098h ; Move Start Frame:  016998
L2BAE:   .DB  001h, 070h, 038h ; Move End Frame:    017038
L2BB1:   .DB  001h, 095h, 096h ; Death Start Frame: 018235
L2BB4:   .DB  001h, 098h, 089h ; Death End Frame:   018577
L2BB7:   .DB  00Dh             ; Restart 13 moves
L2BB8:   .DW  02AD0h           ; Restart: Move 24        











;----------------------------------------------------
;             Scene Four - Highway
;----------------------------------------------------
L2BBA:   .DB  002h, 008h, 091h ; Frame 020891
L2BBD:   .DB  002h, 033h, 021h ; Frame 023321
L2BC0:   .DB  002h, 007h, 041h ; Frame 020741
L2BC3:   .DB  000h, 000h, 000h ; Frame 000000
L2BC6:   .DB  033h             ; 51 moves in scene

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 1
;----------------------------------------------------
L2BC7:   .DB  000h             ;         
L2BC8:   .DB  000h             ; Correct Move   = NONE
L2BC9:   .DB  000h             ; Incorrect Move = NONE
L2BCA:   .DB  002h, 012h, 040h ; Move Start Frame:  021240
L2BCD:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L2BD0:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L2BD3:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L2BD6:   .DB  000h             ; Restart
L2BD7:   .DW  00000h           ; Restart       

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 2
;----------------------------------------------------
L2BD9:   .DB  000h             ;         
L2BDA:   .DB  060h             ; Correct Move   = HANDS
L2BDB:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2BDC:   .DB  002h, 015h, 053h ; Move Start Frame:  021553
L2BDF:   .DB  002h, 015h, 083h ; Move End Frame:    021583
L2BE2:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2BE5:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2BE8:   .DB  033h             ; Restart 51 moves
L2BE9:   .DW  02BC7h           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 3
;----------------------------------------------------
L2BEB:   .DB  000h             ;         
L2BEC:   .DB  000h             ; Correct Move   = NONE
L2BED:   .DB  000h             ; Incorrect Move = NONE
L2BEE:   .DB  002h, 015h, 070h ; Move Start Frame:  021570
L2BF1:   .DB  002h, 016h, 000h ; Move End Frame:    021600
L2BF4:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2BF7:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2BFA:   .DB  033h             ; Restart 51 moves
L2BFB:   .DW  02BC7h           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 4
;---------------------------------------------------- 
L2BFD:   .DB  000h             ;         
L2BFE:   .DB  060h             ; Correct Move   = HANDS
L2BFF:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2C00:   .DB  002h, 015h, 094h ; Move Start Frame:  021594
L2C03:   .DB  002h, 016h, 014h ; Move End Frame:    021614
L2C06:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2C09:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2C0C:   .DB  033h             ; Restart 51 moves
L2C0D:   .DW  02BC7h           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 5
;----------------------------------------------------
L2C0F:   .DB  000h             ;         
L2C10:   .DB  004h             ; Correct Move   = RIGHT
L2C11:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L2C12:   .DB  002h, 016h, 040h ; Move Start Frame:  021640
L2C15:   .DB  002h, 016h, 070h ; Move End Frame:    021670
L2C18:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2C1B:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2C1E:   .DB  033h             ; Restart 51 moves
L2C1F:   .DW  02BC7h           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 6
;----------------------------------------------------
L2C21:   .DB  000h             ;         
L2C22:   .DB  004h             ; Correct Move   = RIGHT
L2C23:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L2C24:   .DB  002h, 016h, 069h ; Move Start Frame:  021669
L2C27:   .DB  002h, 016h, 099h ; Move End Frame:    021699
L2C2A:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2C2D:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2C30:   .DB  033h             ; Restart 51 moves
L2C31:   .DW  02BC7h           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 7
;----------------------------------------------------
L2C33:   .DB  000h             ;         
L2C34:   .DB  004h             ; Correct Move   = RIGHT
L2C35:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L2C36:   .DB  002h, 016h, 098h ; Move Start Frame:  021698
L2C39:   .DB  002h, 017h, 028h ; Move End Frame:    021728
L2C3C:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2C3F:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2C42:   .DB  033h             ; Restart 51 moves
L2C43:   .DW  02BC7h           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 8
;----------------------------------------------------
L2C45:   .DB  000h             ;         
L2C46:   .DB  004h             ; Correct Move   = RIGHT
L2C47:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L2C48:   .DB  002h, 017h, 027h ; Move Start Frame:  021727
L2C4B:   .DB  002h, 017h, 057h ; Move End Frame:    021757
L2C4E:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2C51:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2C54:   .DB  033h             ; Restart 51 moves
L2C55:   .DW  02BC7h           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 9
;----------------------------------------------------
L2C57:   .DB  000h             ;         
L2C58:   .DB  060h             ; Correct Move   = HANDS
L2C59:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2C5A:   .DB  002h, 018h, 026h ; Move Start Frame:  021826
L2C5D:   .DB  002h, 018h, 056h ; Move End Frame:    021856
L2C60:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2C63:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2C66:   .DB  033h             ; Restart 51 moves
L2C67:   .DW  02BC7h           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 10
;----------------------------------------------------
L2C69:   .DB  000h             ;         
L2C6A:   .DB  000h             ; Correct Move   = NONE
L2C6B:   .DB  000h             ; Incorrect Move = NONE
L2C6C:   .DB  002h, 018h, 097h ; Move Start Frame:  021897
L2C6F:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L2C72:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L2C75:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L2C78:   .DB  000h             ; Restart
L2C79:   .DW  00000h           ; Restart

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 11
;----------------------------------------------------
L2C7B:   .DB  000h             ;         
L2C7C:   .DB  060h             ; Correct Move   = HANDS
L2C7D:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2C7E:   .DB  002h, 020h, 004h ; Move Start Frame:  022004
L2C81:   .DB  002h, 020h, 034h ; Move End Frame:    022034
L2C84:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2C87:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2C8A:   .DB  02Ah             ; Restart 42 moves
L2C8B:   .DB  02C69h           ; Restart: Move 10

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 12
;----------------------------------------------------
L2C8D:   .DB  000h             ;         
L2C8E:   .DB  004h             ; Correct Move   = RIGHT
L2C8F:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L2C90:   .DB  002h, 020h, 050h ; Move Start Frame:  022050
L2C93:   .DB  002h, 020h, 080h ; Move End Frame:    022080
L2C96:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2C99:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2C9C:   .DB  02Ah             ; Restart 42 moves
L2C9D:   .DW  02C69h           ; Restart: Move 10

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 13
;----------------------------------------------------
L2C9F:   .DB  000h             ;         
L2CA0:   .DB  000h             ; Correct Move   = NONE
L2CA1:   .DB  000h             ; Incorrect Move = NONE
L2CA2:   .DB  002h, 020h, 065h ; Move Start Frame:  022065
L2CA5:   .DB  002h, 020h, 095h ; Move End Frame:    022095
L2CA8:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2CAB:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2CAE:   .DB  02Ah             ; Restart 42 moves
L2CAF:   .DB  02C69h           ; Restart: Move 10

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 14
;----------------------------------------------------
L2CB1:   .DB  000h             ;         
L2CB2:   .DB  060h             ; Correct Move   = HANDS
L2CB3:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2CB4:   .DB  002h, 020h, 097h ; Move Start Frame:  022097
L2CB7:   .DB  002h, 021h, 017h ; Move End Frame:    022117
L2CBA:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2CBD:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2CC0:   .DB  02Ah             ; Restart 42 moves
L2CC1:   .DW  02C69h           ; Restart: Move 10

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 15
;----------------------------------------------------
L2CC3:   .DB  000h             ;         
L2CC4:   .DB  060h             ; Correct Move   = HANDS
L2CC5:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2CC6:   .DB  002h, 021h, 002h ; Move Start Frame:  022102
L2CC9:   .DB  002h, 021h, 032h ; Move End Frame:    022132
L2CCC:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2CCF:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2CD2:   .DB  02Ah             ; Restart 42 moves
L2CD3:   .DW  02C69h           ; Restart: Move 10

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 16
;----------------------------------------------------
L2CD5:   .DB  000h             ;         
L2CD6:   .DB  060h             ; Correct Move   = HANDS
L2CD7:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2CD8:   .DB  002h, 021h, 046h ; Move Start Frame:  022146
L2CDB:   .DB  002h, 021h, 076h ; Move End Frame:    022176
L2CDE:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2CE1:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2CE4:   .DB  02Ah             ; Restart 42 moves
L2CE5:   .DW  02C69h           ; Restart: Move 10

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 17
;----------------------------------------------------
L2CE7:   .DB  000h             ;         
L2CE8:   .DB  060h             ; Correct Move   = HANDS
L2CE9:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2CEA:   .DB  002h, 021h, 060h ; Move Start Frame:  022160
L2CED:   .DB  002h, 021h, 090h ; Move End Frame:    022190
L2CF0:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2CF3:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2CF6:   .DB  02Ah             ; Restart 42 moves
L2CF7:   .DW  02C69h           ; Restart: Move 10

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 18
;----------------------------------------------------
L2CF9:   .DB  000h             ;         
L2CFA:   .DB  000h             ; Correct Move   = NONE
L2CFB:   .DB  000h             ; Incorrect Move = NONE
L2CFC:   .DB  002h, 022h, 024h ; Move Start Frame:  022224
L2CFF:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L2D02:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L2D05:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L2D08:   .DB  000h             ; Restart
L2D09:   .DW  00000h           ; Restart

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 19
;---------------------------------------------------- 
L2D0B:   .DB  000h             ;         
L2D0C:   .DB  060h             ; Correct Move   = HANDS
L2D0D:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2D0E:   .DB  002h, 022h, 037h ; Move Start Frame:  022237
L2D11:   .DB  002h, 022h, 067h ; Move End Frame:    022267
L2D14:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2D17:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2D1A:   .DB  022h             ; Restart 34 moves
L2D1B:   .DW  02CF9h           ; Restart: Move 18

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 20
;---------------------------------------------------- 
L2D1D:   .DB  000h             ;         
L2D1E:   .DB  000h             ; Correct Move   = NONE
L2D1F:   .DB  000h             ; Incorrect Move = NONE
L2D20:   .DB  002h, 022h, 050h ; Move Start Frame:  022250
L2D23:   .DB  002h, 022h, 080h ; Move End Frame:    022280
L2D26:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2D29:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2D2C:   .DB  022h             ; Restart 34 moves
L2D2D:   .DW  02CF9h           ; Restart: Move 18

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 21
;----------------------------------------------------
L2D2F:   .DB  000h             ;         
L2D30:   .DB  060h             ; Correct Move   = HANDS
L2D31:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2D32:   .DB  002h, 022h, 064h ; Move Start Frame:  022264
L2D35:   .DB  002h, 022h, 094h ; Move End Frame:    022294
L2D38:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2D3B:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2D3E:   .DB  022h             ; Restart 34 moves
L2D3F:   .DB  02CF9h           ; Restart: Move 18

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 22
;----------------------------------------------------
L2D41:   .DB  000h             ;         
L2D42:   .DB  004h             ; Correct Move   = RIGHT
L2D43:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L2D44:   .DB  002h, 023h, 026h ; Move Start Frame:  022326
L2D47:   .DB  002h, 023h, 056h ; Move End Frame:    022356
L2D4A:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2D4D:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2D50:   .DB  022h             ; Restart 34 moves
L2D51:   .DW  02CF9h           ; Restart: Move 18

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 23
;----------------------------------------------------
L2D53:   .DB  000h             ;         
L2D54:   .DB  004h             ; Correct Move   = RIGHT
L2D55:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L2D56:   .DB  002h, 023h, 045h ; Move Start Frame:  022345
L2D59:   .DB  002h, 023h, 075h ; Move End Frame:    022375
L2D5C:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2D5F:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2D62:   .DB  022h             ; Restart 34 moves
L2D63:   .DW  02CF9h           ; Restart: Move 18

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 24
;----------------------------------------------------
L2D65:   .DB  000h             ;         
L2D66:   .DB  004h             ; Correct Move   = RIGHT
L2D67:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L2D68:   .DB  002h, 023h, 084h ; Move Start Frame:  022384
L2D6B:   .DB  002h, 024h, 004h ; Move End Frame:    022404
L2D6E:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2D71:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2D74:   .DB  022h             ; Restart 34 moves
L2D75:   .DW  02CF9h           ; Restart: Move 18

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 25
;----------------------------------------------------
L2D77:   .DB  000h             ;         
L2D78:   .DB  004h             ; Correct Move   = RIGHT
L2D79:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L2D7A:   .DB  002h, 024h, 003h ; Move Start Frame:  022403
L2D7D:   .DB  002h, 024h, 033h ; Move End Frame:    022433
L2D80:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2D83:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2D86:   .DB  022h             ; Restart 34 moves
L2D87:   .DW  02CF9h           ; Restart: Move 18

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 26
;----------------------------------------------------
L2D89:   .DB  000h             ;         
L2D8A:   .DB  060h             ; Correct Move   = HANDS
L2D8B:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2D8C:   .DB  002h, 024h, 024h ; Move Start Frame:  022424
L2D8F:   .DB  002h, 024h, 054h ; Move End Frame:    022454
L2D92:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2D95:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2D98:   .DB  022h             ; Restart 34 moves
L2D99:   .DB  02CF9h           ; Restart: Move 18

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 27
;----------------------------------------------------
L2D9B:   .DB  000h             ;         
L2D9C:   .DB  000h             ; Correct Move   = NONE
L2D9D:   .DB  000h             ; Incorrect Move = NONE
L2D9E:   .DB  002h, 024h, 092h ; Move Start Frame:  022492
L2DA1:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L2DA4:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L2DA7:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L2DAA:   .DB  000h             ; Restart
L2DAB:   .DW  00000h           ; Restart

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 28
;----------------------------------------------------
L2DAD:   .DB  000h             ;         
L2DAE:   .DB  008h             ; Correct Move   = UP
L2DAF:   .DB  0F7h             ; Incorrect Move = HANDS,FEET,LEFT,RIGHT,DOWN
L2DB0:   .DB  002h, 024h, 094h ; Move Start Frame:  022494
L2DB3:   .DB  002h, 025h, 024h ; Move End Frame:    022524
L2DB6:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2DB9:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2DBC:   .DB  019h             ; Restart 25 moves
L2DBD:   .DW  02D9Bh           ; Restart: Move 27

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 29
;----------------------------------------------------
L2DBF:   .DB  000h             ;         
L2DC0:   .DB  060h             ; Correct Move   = HANDS
L2DC1:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2DC2:   .DB  002h, 025h, 000h ; Move Start Frame:  022500
L2DC5:   .DB  002h, 025h, 030h ; Move End Frame:    022530
L2DC8:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2DCB:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2DCE:   .DB  019h             ; Restart 25 moves
L2DCF:   .DW  02D9Bh           ; Restart: Move 27

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 30
;----------------------------------------------------
L2DD1:   .DB  000h             ;         
L2DD2:   .DB  004h             ; Correct Move   = RIGHT
L2DD3:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L2DD4:   .DB  002h, 025h, 038h ; Move Start Frame:  022538
L2DD7:   .DB  002h, 025h, 068h ; Move End Frame:    022568
L2DDA:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2DDD:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2DE0:   .DB  019h             ; Restart 25 moves
L2DE1:   .DW  02D9Bh           ; Restart: Move 27

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 31
;----------------------------------------------------
L2DE3:   .DB  000h             ;         
L2DE4:   .DB  000h             ; Correct Move   = NONE
L2DE5:   .DB  000h             ; Incorrect Move = NONE
L2DE6:   .DB  002h, 025h, 056h ; Move Start Frame:  022556
L2DE9:   .DB  002h, 025h, 086h ; Move End Frame:    022586
L2DEC:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2DEF:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2DF2:   .DB  019h             ; Restart 25 moves
L2DF3:   .DW  02D9Bh           ; Restart: Move 27

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 32
;----------------------------------------------------
L2DF5:   .DB  000h             ;         
L2DF6:   .DB  060h             ; Correct Move   = HANDS
L2DF7:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2DF8:   .DB  002h, 025h, 080h ; Move Start Frame:  022580
L2DFB:   .DB  002h, 026h, 010h ; Move End Frame:    022610
L2DFE:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2E01:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2E04:   .DB  019h             ; Restart 25 moves
L2E05:   .DW  02D9Bh           ; Restart: Move 27

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 33
;----------------------------------------------------
L2E07:   .DB  000h             ;         
L2E08:   .DB  060h             ; Correct Move   = HANDS
L2E09:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2E0A:   .DB  002h, 025h, 092h ; Move Start Frame:  022592
L2E0D:   .DB  002h, 026h, 022h ; Move End Frame:    022622
L2E10:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2E13:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2E16:   .DB  019h             ; Restart 25 moves
L2E17:   .DW  02D9Bh           ; Restart: Move 27

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 34
;----------------------------------------------------
L2E19:   .DB  000h             ;         
L2E1A:   .DB  060h             ; Correct Move   = HANDS
L2E1B:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2E1C:   .DB  002h, 026h, 010h ; Move Start Frame:  022610
L2E1F:   .DB  002h, 026h, 040h ; Move End Frame:    022640
L2E22:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2E25:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2E28:   .DB  019h             ; Restart 25 moves
L2E29:   .DW  02D9Bh           ; Restart: Move 27

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 35
;----------------------------------------------------
L2E2B:   .DB  000h             ;         
L2E2C:   .DB  000h             ; Correct Move   = NONE
L2E2D:   .DB  000h             ; Incorrect Move = NONE
L2E2E:   .DB  002h, 026h, 083h ; Move Start Frame:  022683
L2E31:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L2E34:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L2E37:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L2E3A:   .DB  000h             ; Restart
L2E3B:   .DW  00000h           ; Restart

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 36
;----------------------------------------------------
L2E3D:   .DB  000h             ;         
L2E3E:   .DB  000h             ; Correct Move   = NONE
L2E3F:   .DB  000h             ; Incorrect Move = NONE
L2E40:   .DB  002h, 026h, 089h ; Move Start Frame:  022689
L2E43:   .DB  002h, 027h, 019h ; Move End Frame:    022719
L2E46:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2E49:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2E4C:   .DB  011h             ; Restart 16 moves
L2E4D:   .DW  02E2Bh           ; Restart: Move 35

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 37
;----------------------------------------------------
L2E4F:   .DB  000h             ;         
L2E50:   .DB  060h             ; Correct Move   = HANDS
L2E51:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2E52:   .DB  002h, 027h, 002h ; Move Start Frame:  022702
L2E55:   .DB  002h, 027h, 032h ; Move End Frame:    022732
L2E58:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2E5B:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2E5E:   .DB  011h             ; Restart 16 moves
L2E5F:   .DW  02E2Bh           ; Restart: Move 35

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 38
;----------------------------------------------------
L2E61:   .DB  000h             ;         
L2E62:   .DB  060h             ; Correct Move   = HANDS
L2E63:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2E64:   .DB  002h, 027h, 030h ; Move Start Frame:  022730
L2E67:   .DB  002h, 027h, 060h ; Move End Frame:    022760
L2E6A:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2E6D:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2E70:   .DB  011h             ; Restart 16 moves
L2E71:   .DB  02E2Bh           ; Restart: Move 35

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 39
;---------------------------------------------------- 
L2E73:   .DB  000h             ;         
L2E74:   .DB  004h             ; Correct Move   = RIGHT
L2E75:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L2E76:   .DB  002h, 027h, 050h ; Move Start Frame:  022750
L2E79:   .DB  002h, 027h, 080h ; Move End Frame:    022780
L2E7C:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2E7F:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2E82:   .DB  011h             ; Restart 16 moves
L2E83:   .DW  02E2Bh           ; Restart: Move 35

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 40
;----------------------------------------------------
L2E85:   .DB  000h             ;         
L2E86:   .DB  004h             ; Correct Move   = RIGHT
L2E87:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L2E88:   .DB  002h, 027h, 084h ; Move Start Frame:  022784
L2E8B:   .DB  002h, 028h, 014h ; Move End Frame:    022814
L2E8E:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2E91:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2E94:   .DB  011h             ; Restart 16 moves
L2E95:   .DW  02E2Bh           ; Restart: Move 35

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 41
;----------------------------------------------------
L2E97:   .DB  000h             ;         
L2E98:   .DB  060h             ; Correct Move   = HANDS
L2E99:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2E9A:   .DB  002h, 027h, 094h ; Move Start Frame:  022794
L2E9D:   .DB  002h, 028h, 024h ; Move End Frame:    022824
L2EA0:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2EA3:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2EA6:   .DB  011h             ; Restart 16 moves
L2EA7:   .DW  02E2Bh           ; Restart: Move 35

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 42
;----------------------------------------------------
L2EA9:   .DB  000h             ;         
L2EAA:   .DB  060h             ; Correct Move   = HANDS
L2EAB:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2EAC:   .DB  002h, 028h, 045h ; Move Start Frame:  022845
L2EAF:   .DB  002h, 028h, 075h ; Move End Frame:    022875
L2EB2:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2EB5:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2EB8:   .DB  011h             ; Restart 16 moves
L2EB9:   .DW  02E2Bh           ; Restart: Move 35

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 43
;----------------------------------------------------
L2EBB:   .DB  000h             ;         
L2EBC:   .DB  000h             ; Correct Move   = NONE
L2EBD:   .DB  000h             ; Incorrect Move = NONE
L2EBE:   .DB  002h, 029h, 025h ; Move Start Frame:  022925
L2EC1:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L2EC4:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L2EC7:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L2ECA:   .DB  000h             ; Restart
L2ECB:   .DW  00000h           ; Restart

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 44
;----------------------------------------------------
L2ECD:   .DB  000h             ;         
L2ECE:   .DB  008h             ; Correct Move   = UP
L2ECF:   .DB  0F7h             ; Incorrect Move = HANDS,FEET,LEFT,RIGHT,DOWN
L2ED0:   .DB  002h, 029h, 041h ; Move Start Frame:  022941
L2ED3:   .DB  002h, 029h, 071h ; Move End Frame:    022971
L2ED6:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2ED9:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2EDC:   .DB  009h             ; Restart 9 moves
L2EDD:   .DW  02EBBh           ; Restart: Move 43

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 45
;----------------------------------------------------
L2EDF:   .DB  000h             ;         
L2EE0:   .DB  060h             ; Correct Move   = HANDS
L2EE1:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2EE2:   .DB  002h, 029h, 055h ; Move Start Frame:  022955
L2EE5:   .DB  002h, 029h, 085h ; Move End Frame:    022985
L2EE8:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2EEB:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2EEE:   .DB  009h             ; Restart 9 moves
L2EEF:   .DW  02EBBh           ; Restart: Move 43

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 46
;----------------------------------------------------
L2EF1:   .DB  000h             ;         
L2EF2:   .DB  004h             ; Correct Move   = RIGHT
L2EF3:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L2EF4:   .DB  002h, 029h, 095h ; Move Start Frame:  022995
L2EF7:   .DB  002h, 030h, 025h ; Move End Frame:    023025
L2EFA:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2EFD:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2F00:   .DB  009h             ; Restart 9 moves
L2F01:   .DW  02EBBh           ; Restart: Move 43

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 47
;----------------------------------------------------
L2F03:   .DB  000h             ;         
L2F04:   .DB  060h             ; Correct Move   = HANDS
L2F05:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2F06:   .DB  002h, 030h, 010h ; Move Start Frame:  023010
L2F09:   .DB  002h, 030h, 040h ; Move End Frame:    023040
L2F0C:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2F0F:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2F12:   .DB  009h             ; Restart 9 moves
L2F13:   .DW  02EBBh           ; Restart: Move 43

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 48
;----------------------------------------------------
L2F15:   .DB  000h             ;         
L2F16:   .DB  060h             ; Correct Move   = HANDS
L2F17:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2F18:   .DB  002h, 030h, 035h ; Move Start Frame:  023035
L2F1B:   .DB  002h, 030h, 065h ; Move End Frame:    023065
L2F1E:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2F21:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2F24:   .DB  009h             ; Restart 9 moves
L2F25:   .DW  02EBBh           ; Restart: Move 43

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 49
;----------------------------------------------------
L2F27:   .DB  000h             ;         
L2F28:   .DB  060h             ; Correct Move   = HANDS
L2F29:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2F2A:   .DB  002h, 030h, 046h ; Move Start Frame:  023046
L2F2D:   .DB  002h, 030h, 076h ; Move End Frame:    023076
L2F30:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2F33:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2F36:   .DB  009h             ; Restart 9 moves
L2F37:   .DW  02EBBh           ; Restart: Move 43

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 50
;----------------------------------------------------
L2F39:   .DB  000h             ;         
L2F3A:   .DB  060h             ; Correct Move   = HANDS
L2F3B:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2F3C:   .DB  002h, 030h, 058h ; Move Start Frame:  023058
L2F3F:   .DB  002h, 030h, 088h ; Move End Frame:    023088
L2F42:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2F45:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2F48:   .DB  009h             ; Restart 9 moves
L2F49:   .DW  02EBBh           ; Restart: Move 43

;----------------------------------------------------
;   Difficulty 1:Scene 4:Move 51
;----------------------------------------------------
L2F4B:   .DB  000h             ;         
L2F4C:   .DB  060h             ; Correct Move   = HANDS
L2F4D:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2F4E:   .DB  002h, 031h, 048h ; Move Start Frame:  023148
L2F51:   .DB  002h, 031h, 078h ; Move End Frame:    023178
L2F54:   .DB  002h, 033h, 058h ; Death Start Frame: 023358
L2F57:   .DB  002h, 036h, 040h ; Death End Frame:   023640
L2F5A:   .DB  009h             ; Restart 9 moves
L2F5B:   .DW  02EBBh           ; Restart: Move 43
 










;----------------------------------------------------
;           Scene Five - The Castle Battle 
;----------------------------------------------------
L2F5D:   .DB  002h, 057h, 028h ; Frame 025728
L2F60:   .DB  002h, 063h, 087h ; Frame 026387
L2F63:   .DB  002h, 055h, 079h ; Frame 025579
L2F66:   .DB  002h, 057h, 027h ; Frame 025727
L2F69:   .DB  00Bh             ; 11 moves in scene

;----------------------------------------------------
;   Difficulty 1:Scene 5:Move 1
;----------------------------------------------------
L2F6A:   .DB  000h             ;         
L2F6B:   .DB  000h             ; Correct Move   = NONE
L2F6C:   .DB  000h             ; Incorrect Move = NONE
L2F6D:   .DB  002h, 057h, 029h ; Move Start Frame:  025729
L2F70:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L2F73:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L2F76:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L2F79:   .DB  000h             ; Restart
L2F7A:   .DB  00000h           ; Restart

;----------------------------------------------------
;   Difficulty 1:Scene 5:Move 2
;----------------------------------------------------
L2F7C:   .DB  000h             ;         
L2F7D:   .DB  090h             ; Correct Move   = FEET
L2F7E:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2F7F:   .DB  002h, 057h, 015h ; Move Start Frame:  025715
L2F82:   .DB  002h, 057h, 045h ; Move End Frame:    025745
L2F85:   .DB  002h, 064h, 023h ; Death Start Frame: 026423
L2F88:   .DB  002h, 067h, 005h ; Death End Frame:   026705
L2F8B:   .DB  00Bh             ; Restart 11 moves
L2F8C:   .DW  02F6Ah           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 5:Move 3
;----------------------------------------------------
L2F8E:   .DB  000h             ;         
L2F8F:   .DB  090h             ; Correct Move   = FEET
L2F90:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2F91:   .DB  002h, 057h, 065h ; Move Start Frame:  025765
L2F94:   .DB  002h, 057h, 095h ; Move End Frame:    025795
L2F97:   .DB  002h, 064h, 023h ; Death Start Frame: 026423
L2F9A:   .DB  002h, 067h, 005h ; Death End Frame:   026705
L2F9D:   .DB  00Bh             ; Restart 11 moves
L2F9E:   .DW  02F6Ah           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 5:Move 4
;----------------------------------------------------
L2FA0:   .DB  000h             ;         
L2FA1:   .DB  090h             ; Correct Move   = FEET
L2FA2:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2FA3:   .DB  002h, 057h, 095h ; Move Start Frame:  025795
L2FA6:   .DB  002h, 058h, 025h ; Move End Frame:    025825
L2FA9:   .DB  002h, 064h, 023h ; Death Start Frame: 026423
L2FAC:   .DB  002h, 067h, 005h ; Death End Frame:   026705
L2FAF:   .DB  00Bh             ; Restart 11 moves
L2FB0:   .DW  02F6Ah           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 5:Move 5
;----------------------------------------------------
L2FB2:   .DB  000h             ;         
L2FB3:   .DB  060h             ; Correct Move   = HANDS
L2FB4:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2FB5:   .DB  002h, 058h, 000h ; Move Start Frame:  025800
L2FB8:   .DB  002h, 058h, 030h ; Move End Frame:    025830
L2FBB:   .DB  002h, 064h, 023h ; Death Start Frame: 026423
L2FBE:   .DB  002h, 067h, 005h ; Death End Frame:   026705
L2FC1:   .DB  00Bh             ; Restart 11 moves
L2FC2:   .DW  02F6Ah           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 5:Move 6
;----------------------------------------------------
L2FC4:   .DB  000h             ;         
L2FC5:   .DB  090h             ; Correct Move   = FEET
L2FC6:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2FC7:   .DB  002h, 058h, 008h ; Move Start Frame:  025808
L2FCA:   .DB  002h, 058h, 038h ; Move End Frame:    025838
L2FCD:   .DB  002h, 064h, 023h ; Death Start Frame: 026423
L2FD0:   .DB  002h, 067h, 005h ; Death End Frame:   026705
L2FD3:   .DB  00Bh             ; Restart 11 moves
L2FD4:   .DW  02F6Ah           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 5:Move 7
;----------------------------------------------------
L2FD6:   .DB  000h             ;         
L2FD7:   .DB  090h             ; Correct Move   = HANDS
L2FD8:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L2FD9:   .DB  002h, 058h, 024h ; Move Start Frame:  025824
L2FDC:   .DB  002h, 058h, 054h ; Move End Frame:    025854
L2FDF:   .DB  002h, 064h, 023h ; Death Start Frame: 026423
L2FE2:   .DB  002h, 067h, 005h ; Death End Frame:   026705
L2FE5:   .DB  00Bh             ; Restart 11 moves
L2FE6:   .DW  02F6Ah           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 5:Move 8
;----------------------------------------------------
L2FE8:   .DB  000h             ;         
L2FE9:   .DB  000h             ; Correct Move   = NONE
L2FEA:   .DB  000h             ; Incorrect Move = NONE
L2FEB:   .DB  002h, 059h, 031h ; Move Start Frame:  025931
L2FEE:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L2FF1:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L2FF4:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L2FF7:   .DB  000h             ; Restart
L2FF8:   .DB  00000h           ; Restart

;----------------------------------------------------
;   Difficulty 1:Scene 5:Move 9
;----------------------------------------------------
L2FFA:   .DB  000h             ;         
L2FFB:   .DB  001h             ; Correct Move   = LEFT
L2FFC:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L2FFD:   .DB  002h, 059h, 044h ; Move Start Frame:  025944
L3000:   .DB  002h, 059h, 074h ; Move End Frame:    025974
L3003:   .DB  002h, 077h, 025h ; Death Start Frame: 027725
L3006:   .DB  002h, 080h, 014h ; Death End Frame:   028014
L3009:   .DB  004h             ; Restart 4 moves
L300A:   .DW  02FE8h           ; Restart: Move 8

;----------------------------------------------------
;   Difficulty 1:Scene 5:Move 10
;----------------------------------------------------
L300C:   .DB  000h             ;         
L300D:   .DB  004h             ; Correct Move   = RIGHT
L300E:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L300F:   .DB  002h, 059h, 096h ; Move Start Frame:  025996
L3012:   .DB  002h, 060h, 026h ; Move End Frame:    025626
L3015:   .DB  002h, 077h, 025h ; Death Start Frame: 027725
L3018:   .DB  002h, 080h, 014h ; Death End Frame:   028014
L301B:   .DB  004h             ; Restart 4 moves
L301C:   .DW  02FE8h           ; Restart: Move 8

;----------------------------------------------------
;   Difficulty 1:Scene 5:Move 11
;----------------------------------------------------
L301E:   .DB  000h             ;         
L301F:   .DB  004h             ; Correct Move   = RIGHT
L3020:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L3021:   .DB  002h, 061h, 046h ; Move Start Frame:  026146
L3024:   .DB  002h, 061h, 076h ; Move End Frame:    026176
L3027:   .DB  002h, 077h, 025h ; Death Start Frame: 027725
L302A:   .DB  002h, 080h, 014h ; Death End Frame:   028014
L302D:   .DB  004h             ; Restart 4 moves
L302E:   .DW  02FE8h           ; Restart: Move 8










;----------------------------------------------------
;           Scene SIX - Finale 
;----------------------------------------------------
L3030:   .DB  002h, 085h, 014h ; Frame 028514
L3033:   .DB  003h, 012h, 012h ; Frame 031212
L3036:   .DB  002h, 083h, 063h ; Frame 028363
L3039:   .DB  002h, 085h, 010h ; Frame 028510
L303C:   .DB  00Ch             ; 12 moves in scene

;----------------------------------------------------
;   Difficulty 1:Scene 6:Move 1
;----------------------------------------------------
L303D:   .DB  000h             ;         
L303E:   .DB  000h             ; Correct Move   = NONE
L303F:   .DB  000h             ; Incorrect Move = NONE
L3040:   .DB  002h, 088h, 036h ; Move Start Frame:  028836
L3043:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L3046:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L3049:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L304C:   .DB  000h             ; Restart
L304D:   .DW  00000h           ; Restart

;----------------------------------------------------
;   Difficulty 1:Scene 6:Move 2
;----------------------------------------------------
L304F:   .DB  000h             ;         
L3050:   .DB  060h             ; Correct Move   = HANDS
L3051:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L3052:   .DB  002h, 089h, 000h ; Move Start Frame:  028900
L3055:   .DB  002h, 089h, 030h ; Move End Frame:    028930
L3058:   .DB  003h, 012h, 075h ; Death Start Frame: 031275
L305B:   .DB  003h, 016h, 019h ; Death End Frame:   031619
L305E:   .DB  00Ch             ; Restart 12 moves
L305F:   .DW  0303Dh           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 6:Move 3
;----------------------------------------------------
L3061:   .DB  000h             ;         
L3062:   .DB  060h             ; Correct Move   = HANDS
L3063:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L3064:   .DB  002h, 094h, 022h ; Move Start Frame:  029422
L3067:   .DB  002h, 094h, 052h ; Move End Frame:    029452
L306A:   .DB  003h, 012h, 075h ; Death Start Frame: 031275
L306D:   .DB  003h, 016h, 019h ; Death End Frame:   031619
L3070:   .DB  00Ch             ; Restart 12 moves
L3071:   .DW  0303Dh           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 6:Move 4
;----------------------------------------------------
L3073:   .DB  000h             ;         
L3074:   .DB  001h             ; Correct Move   = LEFT
L3075:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L3076:   .DB  002h, 096h, 022h ; Move Start Frame:  029622
L3079:   .DB  002h, 096h, 052h ; Move End Frame:    029652
L307C:   .DB  003h, 012h, 075h ; Death Start Frame: 031275
L307F:   .DB  003h, 016h, 019h ; Death End Frame:   031619
L3082:   .DB  00Ch             ; Restart 12 moves
L3083:   .DW  0303Dh           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 6:Move 5
;----------------------------------------------------
L3085:   .DB  000h             ;         
L3086:   .DB  0F0h             ; Correct Move   = HANDS,FEET
L3087:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L3088:   .DB  003h, 000h, 098h ; Move Start Frame:  030098
L308B:   .DB  003h, 001h, 028h ; Move End Frame:    030128
L308E:   .DB  003h, 019h, 099h ; Death Start Frame: 031999
L3091:   .DB  003h, 023h, 079h ; Death End Frame:   032379
L3094:   .DB  00Ch             ; Restart 12 moves
L3095:   .DW  0303Dh           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 6:Move 6
;----------------------------------------------------
L3097:   .DB  000h             ;         
L3098:   .DB  000h             ; Correct Move   = NONE
L3099:   .DB  000h             ; Incorrect Move = NONE
L309A:   .DB  003h, 004h, 060h ; Move Start Frame:  030460
L309D:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L30A0:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L30A3:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L30A6:   .DB  000h             ; Restart
L30A7:   .DW  00000h           ; Restart

;----------------------------------------------------
;   Difficulty 1:Scene 6:Move 7
;----------------------------------------------------
L30A9:   .DB  000h             ;         
L30AA:   .DB  004h             ; Correct Move   = RIGHT
L30AB:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L30AC:   .DB  003h, 007h, 094h ; Move Start Frame:  030794
L30AF:   .DB  003h, 008h, 014h ; Move End Frame:    030814
L30B2:   .DB  003h, 019h, 099h ; Death Start Frame: 031999
L30B5:   .DB  003h, 023h, 079h ; Death End Frame:   032379
L30B8:   .DB  007h             ; Restart 7 moves
L30B9:   .DW  03097h           ; Restart: Move 6

;----------------------------------------------------
;   Difficulty 1:Scene 6:Move 8
;----------------------------------------------------
L30BB:   .DB  000h             ;         
L30BC:   .DB  002h             ; Correct Move   = UP
L30BD:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L30BE:   .DB  003h, 008h, 004h ; Move Start Frame:  030804
L30C1:   .DB  003h, 008h, 034h ; Move End Frame:    030834
L30C4:   .DB  003h, 019h, 099h ; Death Start Frame: 031999
L30C7:   .DB  003h, 023h, 079h ; Death End Frame:   032379
L30CA:   .DB  007h             ; Restart 7 moves
L30CB:   .DW  03097h           ; Restart: Move 6

;----------------------------------------------------
;   Difficulty 1:Scene 6:Move 9
;----------------------------------------------------
L30CD:   .DB  000h             ;         
L30CE:   .DB  001h             ; Correct Move   = LEFT
L30CF:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L30D0:   .DB  003h, 008h, 034h ; Move Start Frame:  030834
L30D3:   .DB  003h, 008h, 064h ; Move End Frame:    030864
L30D6:   .DB  003h, 019h, 099h ; Death Start Frame: 031999
L30D9:   .DB  003h, 023h, 079h ; Death End Frame:   032379
L30DC:   .DB  007h             ; Restart 7 moves
L30DD:   .DW  03097h           ; Restart: Move 6

;----------------------------------------------------
;   Difficulty 1:Scene 6:Move 10
;----------------------------------------------------
L30DF:   .DB  000h             ;         
L30E0:   .DB  060h             ; Correct Move   = HANDS
L30E1:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L30E2:   .DB  003h, 008h, 090h ; Move Start Frame:  030890
L30E5:   .DB  003h, 009h, 020h ; Move End Frame:    030920
L30E8:   .DB  003h, 023h, 099h ; Death Start Frame: 032399
L30EB:   .DB  003h, 026h, 092h ; Death End Frame:   032692
L30EE:   .DB  007h             ; Restart 7 moves
L30EF:   .DW  03097h           ; Restart: Move 6

;----------------------------------------------------
;   Difficulty 1:Scene 6:Move 11
;----------------------------------------------------
L30F1:   .DB  000h             ;         
L30F2:   .DB  000h             ; Correct Move   = NONE
L30F3:   .DB  000h             ; Incorrect Move = NONE
L30F4:   .DB  003h, 009h, 054h ; Move Start Frame:  030954
L30F7:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L30FA:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L30FD:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L3100:   .DB  000h             ; Restart
L3101:   .DW  00000h           ; Restart

;----------------------------------------------------
;   Difficulty 1:Scene 6:Move 12
;----------------------------------------------------
L3103:   .DB  000h             ;         
L3104:   .DB  008h             ; Correct Move   = UP
L3105:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L3106:   .DB  003h, 010h, 063h ; Move Start Frame:  031063
L3109:   .DB  003h, 010h, 093h ; Move End Frame:    031093
L310C:   .DB  003h, 027h, 097h ; Death Start Frame: 032797
L310F:   .DB  003h, 031h, 002h ; Death End Frame:   033102
L3112:   .DB  002h             ; Restart 2 moves
L3113:   .DW  030F1h           ; Restart: Move 11









;----------------------------------------------------
;           Scene SEVEN - Finale II
;----------------------------------------------------
L3115:   .DB  003h, 032h, 055h ; Frame 033255
L3118:   .DB  003h, 071h, 038h ; Frame 037138
L311B:   .DB  003h, 031h, 005h ; Frame 033105
L311E:   .DB  003h, 032h, 052h ; Frame 033252
L3120:   .DB  01Fh             ; 31 moves in scene

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 1
;----------------------------------------------------
L3122:   .DB  000h             ;         
L3123:   .DB  000h             ; Correct Move   = NONE
L3124:   .DB  000h             ; Incorrect Move = NONE
L3125:   .DB  003h, 035h, 025h ; Move Start Frame:  031063
L3128:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L312B:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L312E:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L3131:   .DB  000h             ; Restart
L3132:   .DW  00000h           ; Restart

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 2
;---------------------------------------------------- 
L3134:   .DB  000h             ;         
L3135:   .DB  060h             ; Correct Move   = HANDS
L3136:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L3137:   .DB  003h, 036h, 068h ; Move Start Frame:  033668
L313A:   .DB  003h, 036h, 098h ; Move End Frame:    033698
L313D:   .DB  003h, 071h, 092h ; Death Start Frame: 037192
L3140:   .DB  003h, 075h, 011h ; Death End Frame:   037511
L3143:   .DB  01Fh             ; Restart 31 moves
L3144:   .DW  03122h           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 3
;----------------------------------------------------
L3146:   .DB  000h             ;         
L3147:   .DB  090h             ; Correct Move   = FEET
L3148:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L3149:   .DB  003h, 037h, 004h ; Move Start Frame:  033704
L314C:   .DB  003h, 037h, 034h ; Move End Frame:    033734
L314F:   .DB  003h, 071h, 092h ; Death Start Frame: 037192
L3152:   .DB  003h, 075h, 011h ; Death End Frame:   037511
L3155:   .DB  01Fh             ; Restart 31 moves
L3156:   .DW  03122h           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 4
;----------------------------------------------------
L3158:   .DB  000h             ;         
L3159:   .DB  000h             ; Correct Move   = NONE
L315A:   .DB  000h             ; Incorrect Move = NONE
L315B:   .DB  003h, 037h, 010h ; Move Start Frame:  033710
L315E:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L3161:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L3164:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L3167:   .DB  01Fh             ; Restart 31 moves
L3168:   .DW  03122h           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 5
;----------------------------------------------------
L316A:   .DB  000h             ;         
L316B:   .DB  090h             ; Correct Move   = FEET
L316C:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L316D:   .DB  003h, 037h, 020h ; Move Start Frame:  033720
L3170:   .DB  003h, 037h, 050h ; Move End Frame:    033750
L3173:   .DB  003h, 071h, 092h ; Death Start Frame: 037192
L3176:   .DB  003h, 075h, 011h ; Death End Frame:   037511
L3179:   .DB  01Fh             ; Restart 31 moves
L317A:   .DW  03122h           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 6
;----------------------------------------------------
L317C:   .DB  000h             ;         
L317D:   .DB  060h             ; Correct Move   = HANDS
L317E:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L317F:   .DB  003h, 037h, 033h ; Move Start Frame:  033733
L3182:   .DB  003h, 037h, 063h ; Move End Frame:    033763
L3185:   .DB  003h, 071h, 092h ; Death Start Frame: 037192
L3188:   .DB  003h, 075h, 011h ; Death End Frame:   037511             
L318B:   .DB  01Fh             ; Restart 31 moves
L318C:   .DW  03122h           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 7
;----------------------------------------------------
L318E:   .DB  000h             ;         
L318F:   .DB  001h             ; Correct Move   = LEFT
L3190:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L3191:   .DB  003h, 037h, 060h ; Move Start Frame:  033760
L3194:   .DB  003h, 037h, 090h ; Move End Frame:    033790
L3197:   .DB  003h, 071h, 092h ; Death Start Frame: 037192
L319A:   .DB  003h, 075h, 011h ; Death End Frame:   037511          
L319D:   .DB  01Fh             ; Restart 31 moves
L319E:   .DW  03122h           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 8
;----------------------------------------------------
L31A0:   .DB  000h             ;         
L31A1:   .DB  060h             ; Correct Move   = HANDS
L31A2:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L31A3:   .DB  003h, 038h, 024h ; Move Start Frame:  033824
L31A6:   .DB  003h, 038h, 054h ; Move End Frame:    033854
L31A9:   .DB  003h, 071h, 092h ; Death Start Frame: 037192
L31AC:   .DB  003h, 075h, 011h ; Death End Frame:   037511          
L31AF:   .DB  01Fh             ; Restart 31 moves
L31B0:   .DW  03122h           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 9
;----------------------------------------------------
L31B2:   .DB  000h             ;         
L31B3:   .DB  090h             ; Correct Move   = FEET
L31B4:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L31B5:   .DB  003h, 038h, 030h ; Move Start Frame:  033830
L31B8:   .DB  003h, 038h, 060h ; Move End Frame:    033860
L31BB:   .DB  003h, 071h, 092h ; Death Start Frame: 037192
L31BE:   .DB  003h, 075h, 011h ; Death End Frame:   037511          
L31C1:   .DB  01Fh             ; Restart 31 moves
L31C2:   .DW  03122h           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 10
;----------------------------------------------------
L31C4:   .DB  000h             ;         
L31C5:   .DB  008h             ; Correct Move   = UP
L31C6:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L31C7:   .DB  003h, 038h, 040h ; Move Start Frame:  033840
L31CA:   .DB  003h, 038h, 070h ; Move End Frame:    033870
L31CD:   .DB  003h, 071h, 092h ; Death Start Frame: 037192
L31D0:   .DB  003h, 075h, 011h ; Death End Frame:   037511          
L31D3:   .DB  01Fh             ; Restart 31 moves
L31D4:   .DW  03122h           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 11
;----------------------------------------------------
L31D6:   .DB  000h             ;         
L31D7:   .DB  090h             ; Correct Move   = FEET
L31D8:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L31D9:   .DB  003h, 039h, 022h ; Move Start Frame:  033922
L31DC:   .DB  003h, 039h, 052h ; Move End Frame:    033952
L31DF:   .DB  003h, 071h, 092h ; Death Start Frame: 037192
L31E2:   .DB  003h, 075h, 011h ; Death End Frame:   037511          
L31E5:   .DB  01Fh             ; Restart 31 moves
L31E6:   .DW  03122h           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 12
;----------------------------------------------------
L31E8:   .DB  000h             ;         
L31E9:   .DB  001h             ; Correct Move   = LEFT
L31EA:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L31EB:   .DB  003h, 039h, 038h ; Move Start Frame:  033938
L31EE:   .DB  003h, 039h, 068h ; Move End Frame:    033968
L31F1:   .DB  003h, 071h, 092h ; Death Start Frame: 037192
L31F4:   .DB  003h, 075h, 011h ; Death End Frame:   037511          
L31F7:   .DB  01Fh             ; Restart 31 moves
L31F8:   .DW  03122h           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 13
;----------------------------------------------------
L31FA:   .DB  000h             ;         
L31FB:   .DB  000h             ; Correct Move   = NONE
L31FC:   .DB  000h             ; Incorrect Move = NONE
L31FD:   .DB  003h, 039h, 090h ; Move Start Frame:  033990
L3200:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L3203:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L3206:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L3209:   .DB  000h             ; Restart
L320A:   .DW  00000h           ; Restart

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 14
;----------------------------------------------------
L320C:   .DB  000h             ;         
L320D:   .DB  001h             ; Correct Move   = LEFT
L320E:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L320F:   .DB  003h, 040h, 030h ; Move Start Frame:  034030
L3212:   .DB  003h, 040h, 060h ; Move End Frame:    034060
L3215:   .DB  003h, 071h, 092h ; Death Start Frame: 037192
L3218:   .DB  003h, 075h, 011h ; Death End Frame:   037511          
L321B:   .DB  013h             ; Restart 19 moves
L321C:   .DW  031FAh           ; Restart: Move 13

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 15
;----------------------------------------------------
L321E:   .DB  000h             ;         
L321F:   .DB  090h             ; Correct Move   = FEET
L3220:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L3221:   .DB  003h, 041h, 000h ; Move Start Frame:  034100
L3224:   .DB  003h, 041h, 030h ; Move End Frame:    034130
L3227:   .DB  003h, 071h, 092h ; Death Start Frame: 037192
L322A:   .DB  003h, 075h, 011h ; Death End Frame:   037511  
L322D:   .DB  013h             ; Restart 19 moves
L322E:   .DW  031FAh           ; Restart: Move 13

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 16
;----------------------------------------------------
L3230:   .DB  000h             ;         
L3231:   .DB  008h             ; Correct Move   = UP
L3232:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L3233:   .DB  003h, 041h, 030h ; Move Start Frame:  034130
L3236:   .DB  003h, 041h, 060h ; Move End Frame:    034160
L3239:   .DB  003h, 071h, 092h ; Death Start Frame: 037192
L323C:   .DB  003h, 075h, 011h ; Death End Frame:   037511  
L323F:   .DB  013h             ; Restart 19 moves
L3240:   .DW  031FAh           ; Restart: Move 13

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 17
;----------------------------------------------------
L3242:   .DB  000h             ;         
L3243:   .DB  060h             ; Correct Move   = HANDS
L3244:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L3245:   .DB  003h, 042h, 086h ; Move Start Frame:  034286
L3248:   .DB  003h, 043h, 016h ; Move End Frame:    034316
L324B:   .DB  003h, 071h, 092h ; Death Start Frame: 037192
L324E:   .DB  003h, 075h, 011h ; Death End Frame:   037511  
L3251:   .DB  013h             ; Restart 19 moves
L3252:   .DW  031FAh           ; Restart: Move 13

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 18
;----------------------------------------------------
L3254:   .DB  000h             ;         
L3255:   .DB  008h             ; Correct Move   = UP
L3256:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L3257:   .DB  003h, 044h, 002h ; Move Start Frame:  034402
L325A:   .DB  003h, 044h, 032h ; Move End Frame:    034432
L325D:   .DB  003h, 071h, 092h ; Death Start Frame: 037192
L3260:   .DB  003h, 075h, 011h ; Death End Frame:   037511  
L3263:   .DB  013h             ; Restart 19 moves
L3264:   .DW  031FAh           ; Restart: Move 13

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 19
;----------------------------------------------------
L3266:   .DB  000h             ;         
L3267:   .DB  000h             ; Correct Move   = NONE
L3268:   .DB  000h             ; Incorrect Move = NONE
L3269:   .DB  003h, 046h, 020h ; Move Start Frame:  034620
L326C:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L326F:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L3272:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L3275:   .DB  000h             ; Restart
L3276:   .DW  00000h           ; Restart

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 20
;----------------------------------------------------
L3278:   .DB  000h             ;         
L3279:   .DB  060h             ; Correct Move   = HANDS
L327A:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L327B:   .DB  003h, 050h, 012h ; Move Start Frame:  035012
L327E:   .DB  003h, 050h, 042h ; Move End Frame:    035042
L3281:   .DB  003h, 071h, 092h ; Death Start Frame: 037192
L3284:   .DB  003h, 075h, 011h ; Death End Frame:   037511  
L3287:   .DB  00Dh             ; Restart 13 moves
L3288:   .DW  03266h           ; Restart: Move 19

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 21
;----------------------------------------------------
L328A:   .DB  000h             ;         
L328B:   .DB  002h             ; Correct Move   = DOWN
L328C:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L328D:   .DB  003h, 051h, 070h ; Move Start Frame:  035170
L3290:   .DB  003h, 052h, 000h ; Move End Frame:    035200
L3293:   .DB  003h, 071h, 092h ; Death Start Frame: 037192
L3296:   .DB  003h, 075h, 011h ; Death End Frame:   037511  
L3299:   .DB  00Dh             ; Restart 13 moves
L329A:   .DW  03266h           ; Restart: Move 19

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 22
;----------------------------------------------------
L329C:   .DB  000h             ;         
L329D:   .DB  060h             ; Correct Move   = HANDS
L329E:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L329F:   .DB  003h, 053h, 074h ; Move Start Frame:  035374
L32A2:   .DB  003h, 054h, 004h ; Move End Frame:    035404
L32A5:   .DB  003h, 071h, 092h ; Death Start Frame: 037192
L32A8:   .DB  003h, 075h, 011h ; Death End Frame:   037511  
L32AB:   .DB  00Dh             ; Restart 13 moves
L32AC:   .DW  03266h           ; Restart: Move 19

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 23
;----------------------------------------------------
L32AE:   .DB  000h             ;         
L32AF:   .DB  090h             ; Correct Move   = FEET
L32B0:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L32B1:   .DB  003h, 057h, 085h ; Move Start Frame:  035785
L32B4:   .DB  003h, 058h, 015h ; Move End Frame:    035815
L32B7:   .DB  003h, 071h, 092h ; Death Start Frame: 037192
L32BA:   .DB  003h, 075h, 011h ; Death End Frame:   037511  
L32BD:   .DB  00Dh             ; Restart 13 moves
L32BE:   .DW  03266h           ; Restart: Move 19

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 24
;----------------------------------------------------
L32C0:   .DB  000h             ;         
L32C1:   .DB  090h             ; Correct Move   = FEET
L32C2:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L32C3:   .DB  003h, 058h, 073h ; Move Start Frame:  035873
L32C6:   .DB  003h, 059h, 003h ; Move End Frame:    035903
L32C9:   .DB  003h, 071h, 092h ; Death Start Frame: 037192
L32CC:   .DB  003h, 075h, 011h ; Death End Frame:   037511  
L32CF:   .DB  00Dh             ; Restart 13 moves
L32D0:   .DW  03266h           ; Restart: Move 19

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 25
;----------------------------------------------------
L32D2:   .DB  000h             ;         
L32D3:   .DB  090h             ; Correct Move   = FEET
L32D4:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L32D5:   .DB  003h, 058h, 089h ; Move Start Frame:  035889
L32D8:   .DB  003h, 059h, 019h ; Move End Frame:    035919
L32DB:   .DB  003h, 071h, 092h ; Death Start Frame: 037192
L32DE:   .DB  003h, 075h, 011h ; Death End Frame:   037511  
L32E1:   .DB  00Dh             ; Restart 13 moves
L32E2:   .DW  03266h           ; Restart: Move 19

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 26
;----------------------------------------------------
L32E4:   .DB  000h             ;         
L32E5:   .DB  060h             ; Correct Move   = HANDS
L32E6:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L32E7:   .DB  003h, 059h, 055h ; Move Start Frame:  035955
L32EA:   .DB  003h, 059h, 085h ; Move End Frame:    035985
L32ED:   .DB  003h, 097h, 027h ; Death Start Frame: 039727
L32F0:   .DB  004h, 001h, 084h ; Death End Frame:   040184  
L32F3:   .DB  00Dh             ; Restart 13 moves
L32F4:   .DW  03266h           ; Restart: Move 19

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 27
;----------------------------------------------------
L32F6:   .DB  000h             ;         
L32F7:   .DB  000h             ; Correct Move   = NONE
L32F8:   .DB  000h             ; Incorrect Move = NONE
L32F9:   .DB  003h, 060h, 020h ; Move Start Frame:  036020
L32FC:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L32FF:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L3302:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L3305:   .DB  000h             ; Restart
L3306:   .DW  00000h           ; Restart

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 28
;----------------------------------------------------
L3308:   .DB  000h             ;         
L3309:   .DB  060h             ; Correct Move   = HANDS
L330A:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L330B:   .DB  003h, 061h, 064h ; Move Start Frame:  036164
L330E:   .DB  003h, 061h, 094h ; Move End Frame:    036194
L3311:   .DB  003h, 071h, 092h ; Death Start Frame: 037192
L3314:   .DB  003h, 075h, 011h ; Death End Frame:   037511  
L3317:   .DB  005h             ; Restart 5 moves
L3318:   .DW  032F6h           ; Restart: Move 27

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 29
;----------------------------------------------------
L331A:   .DB  000h             ;         
L331B:   .DB  008h             ; Correct Move   = UP
L331C:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L331D:   .DB  003h, 063h, 027h ; Move Start Frame:  036327
L3320:   .DB  003h, 063h, 057h ; Move End Frame:    036357
L3323:   .DB  003h, 071h, 092h ; Death Start Frame: 037192
L3326:   .DB  003h, 075h, 011h ; Death End Frame:   037511  
L3329:   .DB  005h             ; Restart 5 moves
L332A:   .DW  032F6h           ; Restart: Move 27

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 30
;----------------------------------------------------
L332C:   .DB  000h             ;         
L332D:   .DB  060h             ; Correct Move   = HANDS
L332E:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L332F:   .DB  003h, 064h, 077h ; Move Start Frame:  036477
L3333:   .DB  003h, 065h, 007h ; Move End Frame:    036507
L3335:   .DB  003h, 071h, 092h ; Death Start Frame: 037192
L3338:   .DB  003h, 075h, 011h ; Death End Frame:   037511  
L333B:   .DB  005h             ; Restart 5 moves
L333C:   .DW  032F6h           ; Restart: Move 27

;----------------------------------------------------
;   Difficulty 1:Scene 7:Move 31
;----------------------------------------------------
L333E:   .DB  000h             ;         
L333F:   .DB  008h             ; Correct Move   = UP
L3340:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L3341:   .DB  003h, 065h, 093h ; Move Start Frame:  036593
L3344:   .DB  003h, 066h, 023h ; Move End Frame:    036623
L3347:   .DB  003h, 071h, 092h ; Death Start Frame: 037192
L334A:   .DB  003h, 075h, 011h ; Death End Frame:   037511  
L334D:   .DB  005h             ; Restart 5 moves
L334E:   .DW  032F6h           ; Restart: Move 27












;----------------------------------------------------
;           Scene EIGHT - Ending
;----------------------------------------------------
L3350:   .DB  004h, 015h, 087h ; Frame 041587
L3353:   .DB  004h, 068h, 080h ; Frame 046880
L3356:   .DB  004h, 014h, 036h ; Frame 041436
L3359:   .DB  004h, 015h, 084h ; Frame 041584
L335C:   .DB  032h             ; 50 moves in scene

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 1
;----------------------------------------------------
L335D:   .DB  000h             ;         
L335E:   .DB  000h             ; Correct Move   = NONE
L335F:   .DB  000h             ; Incorrect Move = NONE
L3360:   .DB  004h, 015h, 087h ; Move Start Frame:  041587
L3363:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L3366:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L3369:   .DB  000h, 000h, 000h ; Death End Frame:   000000  
L336C:   .DB  000h             ; Restart
L336D:   .DW  00000h           ; Restart

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 2
;---------------------------------------------------- 
L336F:   .DB  000h             ;         
L3370:   .DB  090h             ; Correct Move   = FEET
L3371:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L3372:   .DB  004h, 015h, 074h ; Move Start Frame:  041574
L3375:   .DB  004h, 016h, 004h ; Move End Frame:    041604
L3378:   .DB  004h, 069h, 060h ; Death Start Frame: 046960
L337B:   .DB  004h, 072h, 056h ; Death End Frame:   047256  
L337E:   .DB  032h             ; Restart 50 moves
L337F:   .DW  0335Dh           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 3
;---------------------------------------------------- 
L3381:   .DB  000h             ;         
L3382:   .DB  060h             ; Correct Move   = HANDS
L3383:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L3384:   .DB  004h, 016h, 062h ; Move Start Frame:  041662
L3387:   .DB  004h, 016h, 092h ; Move End Frame:    041692
L338A:   .DB  004h, 069h, 060h ; Death Start Frame: 046960
L338D:   .DB  004h, 072h, 056h ; Death End Frame:   047256  
L3390:   .DB  032h             ; Restart 50 moves
L3391:   .DW  0335Dh           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 4
;----------------------------------------------------
L3393:   .DB  000h             ;         
L3394:   .DB  060h             ; Correct Move   = HANDS
L3395:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L3396:   .DB  004h, 017h, 013h ; Move Start Frame:  041713
L3399:   .DB  004h, 017h, 043h ; Move End Frame:    041743
L339C:   .DB  004h, 069h, 060h ; Death Start Frame: 046960
L339F:   .DB  004h, 072h, 056h ; Death End Frame:   047256  
L33A2:   .DB  032h             ; Restart 50 moves
L33A3:   .DW  0335Dh           ; Restart: Move 1

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 5
;----------------------------------------------------
L33A5:   .DB  000h             ;         
L33A6:   .DB  000h             ; Correct Move   = NONE
L33A7:   .DB  000h             ; Incorrect Move = NONE
L33A8:   .DB  004h, 025h, 050h ; Move Start Frame:  042550
L33AB:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L33AE:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L33B1:   .DB  000h, 000h, 000h ; Death End Frame:   000000  
L33B4:   .DB  000h             ; Restart
L33B5:   .DW  00000h           ; Restart

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 6
;----------------------------------------------------
L33B7:   .DB  000h             ;         
L33B8:   .DB  008h             ; Correct Move   = UP
L33B9:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L33BA:   .DB  004h, 026h, 076h ; Move Start Frame:  042676
L33BD:   .DB  004h, 027h, 006h ; Move End Frame:    042706
L33C0:   .DB  004h, 072h, 089h ; Death Start Frame: 047289
L33C3:   .DB  004h, 075h, 078h ; Death End Frame:   047578  
L33C6:   .DB  02Eh             ; Restart 46 moves
L33C7:   .DW  033A5h           ; Restart: Move 5

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 7
;----------------------------------------------------
L33C9:   .DB  000h             ;         
L33CA:   .DB  008h             ; Correct Move   = UP
L33CB:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L33CC:   .DB  004h, 028h, 027h ; Move Start Frame:  042827
L33CF:   .DB  004h, 028h, 057h ; Move End Frame:    042857
L33D2:   .DB  004h, 072h, 089h ; Death Start Frame: 047289
L33D5:   .DB  004h, 075h, 078h ; Death End Frame:   047578  
L33D8:   .DB  02Eh             ; Restart 46 moves
L33D9:   .DW  033A5h           ; Restart: Move 5

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 8
;---------------------------------------------------- 
L33DB:   .DB  000h             ;         
L33DC:   .DB  090h             ; Correct Move   = FEET
L33DD:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L33DE:   .DB  004h, 028h, 060h ; Move Start Frame:  042860
L33E1:   .DB  004h, 028h, 090h ; Move End Frame:    042890
L33E4:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L33E7:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L33EA:   .DB  02Eh             ; Restart 46 moves
L33EB:   .DW  033A5h           ; Restart: Move 5

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 9
;----------------------------------------------------
L33ED:   .DB  000h             ;         
L33EE:   .DB  090h             ; Correct Move   = FEET
L33EF:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L33F0:   .DB  004h, 029h, 002h ; Move Start Frame:  042902
L33F3:   .DB  004h, 029h, 032h ; Move End Frame:    042932
L33F6:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L33F9:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L33FC:   .DB  02Eh             ; Restart 46 moves
L33FD:   .DW  033A5h           ; Restart: Move 5

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 10
;----------------------------------------------------
L33FF:   .DB  000h             ;         
L3400:   .DB  090h             ; Correct Move   = FEET
L3401:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L3402:   .DB  004h, 030h, 068h ; Move Start Frame:  043068
L3405:   .DB  004h, 030h, 098h ; Move End Frame:    043098
L3408:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L340B:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L340E:   .DB  02Eh             ; Restart 46 moves
L340F:   .DW  033A5h           ; Restart: Move 5

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 11
;----------------------------------------------------
L3411:   .DB  000h             ;         
L3412:   .DB  004h             ; Correct Move   = RIGHT
L3413:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L3414:   .DB  004h, 030h, 092h ; Move Start Frame:  043092
L3417:   .DB  004h, 031h, 002h ; Move End Frame:    043102
L341A:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L341D:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L3420:   .DB  02Eh             ; Restart 46 moves
L3421:   .DW  033A5h           ; Restart: Move 5

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 12
;----------------------------------------------------
L3423:   .DB  000h             ;         
L3424:   .DB  000h             ; Correct Move   = NONE
L3425:   .DB  000h             ; Incorrect Move = NONE
L3426:   .DB  004h, 031h, 063h ; Move Start Frame:  043163
L3429:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L342C:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L342F:   .DB  000h, 000h, 000h ; Death End Frame:   000000  
L3432:   .DB  000h             ; Restart
L3433:   .DW  00000h           ; Restart

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 13
;----------------------------------------------------
L3435:   .DB  000h             ;         
L3436:   .DB  090h             ; Correct Move   = FEET
L3437:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L3438:   .DB  004h, 032h, 061h ; Move Start Frame:  043261
L343B:   .DB  004h, 032h, 091h ; Move End Frame:    043291
L343E:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L3441:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L3444:   .DB  027h             ; Restart 39 moves
L3445:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 14
;----------------------------------------------------
L3447:   .DB  000h             ;         
L3448:   .DB  060h             ; Correct Move   = HANDS
L3449:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L344A:   .DB  004h, 032h, 086h ; Move Start Frame:  043286
L344D:   .DB  004h, 033h, 006h ; Move End Frame:    043306
L3450:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L3453:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L3456:   .DB  027h             ; Restart 39 moves
L3457:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 15
;----------------------------------------------------
L3459:   .DB  000h             ;         
L345A:   .DB  060h             ; Correct Move   = HANDS
L345B:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L345C:   .DB  004h, 032h, 095h ; Move Start Frame:  043295
L345F:   .DB  004h, 033h, 025h ; Move End Frame:    043325
L3462:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L3465:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L3468:   .DB  027h             ; Restart 39 moves
L3469:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 16
;---------------------------------------------------- 
L346B:   .DB  000h             ;         
L346C:   .DB  060h             ; Correct Move   = HANDS
L346D:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L346E:   .DB  004h, 033h, 007h ; Move Start Frame:  043307
L3471:   .DB  004h, 033h, 037h ; Move End Frame:    043337
L3474:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L3477:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L347A:   .DB  027h             ; Restart 39 moves
L347B:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 17
;----------------------------------------------------
L347D:   .DB  000h             ;         
L347E:   .DB  060h             ; Correct Move   = HANDS
L347F:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L3480:   .DB  004h, 033h, 020h ; Move Start Frame:  043320
L3483:   .DB  004h, 033h, 050h ; Move End Frame:    043350
L3486:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L3489:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L348C:   .DB  027h             ; Restart 39 moves
L348D:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 18
;----------------------------------------------------
L348F:   .DB  000h             ;         
L3490:   .DB  060h             ; Correct Move   = HANDS
L3491:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L3492:   .DB  004h, 033h, 045h ; Move Start Frame:  043345
L3495:   .DB  004h, 033h, 075h ; Move End Frame:    043375
L3498:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L349B:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L349E:   .DB  027h             ; Restart 39 moves
L349F:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 19
;----------------------------------------------------
L34A1:   .DB  000h             ;         
L34A2:   .DB  060h             ; Correct Move   = HANDS
L34A3:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L34A4:   .DB  004h, 033h, 067h ; Move Start Frame:  043367
L34A7:   .DB  004h, 033h, 097h ; Move End Frame:    043397
L34AA:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L34AD:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L34B0:   .DB  027h             ; Restart 39 moves
L34B1:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 20
;----------------------------------------------------
L34B3:   .DB  000h             ;         
L34B4:   .DB  060h             ; Correct Move   = HANDS
L34B5:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L34B6:   .DB  004h, 034h, 034h ; Move Start Frame:  043434
L34B9:   .DB  004h, 034h, 064h ; Move End Frame:    043464
L34BC:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L34BF:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L34C2:   .DB  027h             ; Restart 39 moves
L34C3:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 21
;----------------------------------------------------
L34C5:   .DB  000h             ;         
L34C6:   .DB  060h             ; Correct Move   = HANDS
L34C7:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L34C8:   .DB  004h, 034h, 049h ; Move Start Frame:  043449
L34CB:   .DB  004h, 034h, 079h ; Move End Frame:    043479
L34CE:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L34D1:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L34D4:   .DB  027h             ; Restart 39 moves
L34D5:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 22
;----------------------------------------------------
L34D7:   .DB  000h             ;         
L34D8:   .DB  060h             ; Correct Move   = HANDS
L34D9:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L34DA:   .DB  004h, 034h, 076h ; Move Start Frame:  043476
L34DD:   .DB  004h, 035h, 006h ; Move End Frame:    043506
L34E0:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L34E3:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L34E6:   .DB  027h             ; Restart 39 moves
L34E7:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 23
;----------------------------------------------------
L34E9:   .DB  000h             ;         
L34EA:   .DB  060h             ; Correct Move   = HANDS
L34EB:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L34EC:   .DB  004h, 035h, 015h ; Move Start Frame:  043515
L34EF:   .DB  004h, 035h, 045h ; Move End Frame:    043545
L34F2:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L34F5:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L34F8:   .DB  027h             ; Restart 39 moves
L34F9:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 24
;---------------------------------------------------- 
L34FB:   .DB  000h             ;         
L34FC:   .DB  060h             ; Correct Move   = HANDS
L34FD:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L34FE:   .DB  004h, 035h, 031h ; Move Start Frame:  043531
L3501:   .DB  004h, 035h, 061h ; Move End Frame:    043561
L3504:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L3507:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L350A:   .DB  027h             ; Restart 39 moves
L350B:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 25
;----------------------------------------------------
L350D:   .DB  000h             ;         
L350E:   .DB  060h             ; Correct Move   = HANDS
L350F:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L3510:   .DB  004h, 035h, 041h ; Move Start Frame:  043541
L3513:   .DB  004h, 035h, 071h ; Move End Frame:    043571
L3516:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L3519:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L351C:   .DB  027h             ; Restart 39 moves
L351D:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 26
;----------------------------------------------------
L351F:   .DB  000h             ;         
L3520:   .DB  060h             ; Correct Move   = HANDS
L3521:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L3522:   .DB  004h, 035h, 056h ; Move Start Frame:  043556
L3525:   .DB  004h, 035h, 086h ; Move End Frame:    043586
L3528:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L352B:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L352E:   .DB  027h             ; Restart 39 moves
L352F:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 27
;----------------------------------------------------
L3531:   .DB  000h             ;         
L3532:   .DB  060h             ; Correct Move   = HANDS
L3533:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L3534:   .DB  004h, 035h, 080h ; Move Start Frame:  043580
L3537:   .DB  004h, 036h, 010h ; Move End Frame:    043610
L353A:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L353D:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L3540:   .DB  027h             ; Restart 39 moves
L3541:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 28
;----------------------------------------------------
L3543:   .DB  000h             ;         
L3544:   .DB  060h             ; Correct Move   = HANDS
L3545:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L3546:   .DB  004h, 036h, 003h ; Move Start Frame:  043603
L3549:   .DB  004h, 036h, 033h ; Move End Frame:    043633
L354C:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L354F:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L3552:   .DB  027h             ; Restart 39 moves
L3553:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 29
;----------------------------------------------------
L3555:   .DB  000h             ;         
L3556:   .DB  060h             ; Correct Move   = HANDS
L3557:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L3558:   .DB  004h, 036h, 070h ; Move Start Frame:  043670
L355B:   .DB  004h, 037h, 000h ; Move End Frame:    043700
L355E:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L3561:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L3564:   .DB  027h             ; Restart 39 moves
L3565:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 30
;----------------------------------------------------
L3567:   .DB  000h             ;         
L3568:   .DB  060h             ; Correct Move   = HANDS
L3569:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L356A:   .DB  004h, 036h, 085h ; Move Start Frame:  043685
L356D:   .DB  004h, 037h, 015h ; Move End Frame:    043715
L3570:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L3573:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L3576:   .DB  027h             ; Restart 39 moves
L3577:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 31
;----------------------------------------------------
L3579:   .DB  000h             ;         
L357A:   .DB  060h             ; Correct Move   = HANDS
L357B:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L357C:   .DB  004h, 037h, 012h ; Move Start Frame:  043712
L357F:   .DB  004h, 037h, 042h ; Move End Frame:    043742
L3582:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L3585:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L3588:   .DB  027h             ; Restart 39 moves
L3589:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 32
;----------------------------------------------------
L358B:   .DB  000h             ;         
L358C:   .DB  060h             ; Correct Move   = HANDS
L358D:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L358E:   .DB  004h, 037h, 056h ; Move Start Frame:  043756
L3591:   .DB  004h, 037h, 086h ; Move End Frame:    043786
L3594:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L3597:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L359A:   .DB  027h             ; Restart 39 moves
L359B:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 33
;----------------------------------------------------
L359D:   .DB  000h             ;         
L359E:   .DB  060h             ; Correct Move   = HANDS
L359F:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L35A0:   .DB  004h, 037h, 071h ; Move Start Frame:  043771
L35A3:   .DB  004h, 038h, 001h ; Move End Frame:    043801
L35A6:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L35A9:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L35AC:   .DB  027h             ; Restart 39 moves
L35AD:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 34
;----------------------------------------------------
L35AF:   .DB  000h             ;         
L35B0:   .DB  060h             ; Correct Move   = HANDS
L35B1:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L35B2:   .DB  004h, 037h, 089h ; Move Start Frame:  043789
L35B5:   .DB  004h, 038h, 019h ; Move End Frame:    043819
L35B8:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L35BB:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L35BE:   .DB  027h             ; Restart 39 moves
L35BF:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 35
;----------------------------------------------------
L35C1:   .DB  000h             ;         
L35C2:   .DB  060h             ; Correct Move   = HANDS
L35C3:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L35C4:   .DB  004h, 038h, 016h ; Move Start Frame:  043816
L35C7:   .DB  004h, 038h, 046h ; Move End Frame:    043846
L35CA:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L35CD:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L35D0:   .DB  027h             ; Restart 39 moves
L35D1:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 36
;----------------------------------------------------
L35D3:   .DB  000h             ;         
L35D4:   .DB  060h             ; Correct Move   = HANDS
L35D5:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L35D6:   .DB  004h, 038h, 063h ; Move Start Frame:  043863
L35D9:   .DB  004h, 038h, 093h ; Move End Frame:    043893
L35DC:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L35DF:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L35E2:   .DB  027h             ; Restart 39 moves
L35E3:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 37
;----------------------------------------------------
L35E5:   .DB  000h             ;         
L35E6:   .DB  060h             ; Correct Move   = HANDS
L35E7:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L35E8:   .DB  004h, 038h, 088h ; Move Start Frame:  043888
L35EB:   .DB  004h, 039h, 008h ; Move End Frame:    043908
L35EE:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L35F1:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L35F4:   .DB  027h             ; Restart 39 moves
L35F5:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 38
;----------------------------------------------------
L35F7:   .DB  000h             ;         
L35F8:   .DB  060h             ; Correct Move   = HANDS
L35F9:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L35FA:   .DB  004h, 038h, 099h ; Move Start Frame:  043899
L35FD:   .DB  004h, 039h, 029h ; Move End Frame:    043929
L3600:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L3603:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L3606:   .DB  027h             ; Restart 39 moves
L3607:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 39
;----------------------------------------------------
L3609:   .DB  000h             ;         
L360A:   .DB  060h             ; Correct Move   = HANDS
L360B:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L360C:   .DB  004h, 039h, 026h ; Move Start Frame:  043926
L360F:   .DB  004h, 039h, 056h ; Move End Frame:    043956
L3612:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L3615:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L3618:   .DB  027h             ; Restart 39 moves
L3619:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 40
;----------------------------------------------------
L361B:   .DB  000h             ;         
L361C:   .DB  060h             ; Correct Move   = HANDS
L361D:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L361E:   .DB  004h, 041h, 051h ; Move Start Frame:  044151
L3621:   .DB  004h, 041h, 081h ; Move End Frame:    044181
L3624:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L3627:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L362A:   .DB  027h             ; Restart 39 moves
L362B:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 41
;----------------------------------------------------
L362D:   .DB  000h             ;         
L362E:   .DB  060h             ; Correct Move   = HANDS
L362F:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L3630:   .DB  004h, 043h, 004h ; Move Start Frame:  044304
L3633:   .DB  004h, 043h, 034h ; Move End Frame:    044334
L3636:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L3639:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L363C:   .DB  027h             ; Restart 39 moves
L363D:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 42
;----------------------------------------------------
L363F:   .DB  000h             ;         
L3640:   .DB  060h             ; Correct Move   = HANDS
L3641:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L3642:   .DB  004h, 044h, 037h ; Move Start Frame:  044437
L3645:   .DB  004h, 044h, 067h ; Move End Frame:    044467
L3648:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L364B:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L364E:   .DB  027h             ; Restart 39 moves
L364F:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 43
;----------------------------------------------------
L3651:   .DB  000h             ;         
L3652:   .DB  060h             ; Correct Move   = HANDS
L3653:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L3654:   .DB  004h, 045h, 030h ; Move Start Frame:  044530
L3657:   .DB  004h, 045h, 060h ; Move End Frame:    044560
L365A:   .DB  004h, 076h, 007h ; Death Start Frame: 047607
L365D:   .DB  004h, 079h, 069h ; Death End Frame:   047969  
L3660:   .DB  027h             ; Restart 39 moves
L3661:   .DW  03423h           ; Restart: Move 12

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 44
;----------------------------------------------------
L3663:   .DB  000h             ;         
L3664:   .DB  000h             ; Correct Move   = NONE
L3665:   .DB  000h             ; Incorrect Move = NONE
L3666:   .DB  004h, 050h, 030h ; Move Start Frame:  045030
L3669:   .DB  000h, 000h, 000h ; Move End Frame:    000000
L366C:   .DB  000h, 000h, 000h ; Death Start Frame: 000000
L366F:   .DB  000h, 000h, 000h ; Death End Frame:   000000  
L3672:   .DB  000h             ; Restart
L3673:   .DW  00000h           ; Restart

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 45
;----------------------------------------------------
L3675:   .DB  000h             ;         
L3676:   .DB  001h             ; Correct Move   = LEFT
L3677:   .DB  0F0h             ; Incorrect Move = HANDS,FEET
L3678:   .DB  004h, 052h, 098h ; Move Start Frame:  045298
L367B:   .DB  004h, 053h, 028h ; Move End Frame:    045328
L367E:   .DB  004h, 087h, 068h ; Death Start Frame: 048768
L3681:   .DB  004h, 090h, 050h ; Death End Frame:   049050  
L3684:   .DB  007h             ; Restart 7 moves
L3685:   .DW  03663h           ; Restart: Move 44

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 46
;----------------------------------------------------
L3687:   .DB  000h             ;         
L3688:   .DB  090h             ; Correct Move   = FEET
L3689:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L368A:   .DB  004h, 053h, 094h ; Move Start Frame:  045394
L368D:   .DB  004h, 054h, 014h ; Move End Frame:    045414
L3690:   .DB  004h, 069h, 060h ; Death Start Frame: 046960
L3693:   .DB  004h, 072h, 056h ; Death End Frame:   047256  
L3696:   .DB  007h             ; Restart 7 moves
L3697:   .DW  03663h           ; Restart: Move 44

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 47
;----------------------------------------------------
L3699:   .DB  000h             ;         
L369A:   .DB  090h             ; Correct Move   = FEET
L369B:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L369C:   .DB  004h, 055h, 025h ; Move Start Frame:  045525
L369F:   .DB  004h, 055h, 055h ; Move End Frame:    045555
L36A2:   .DB  004h, 069h, 060h ; Death Start Frame: 046960
L36A5:   .DB  004h, 072h, 056h ; Death End Frame:   047256  
L36A8:   .DB  007h             ; Restart 7 moves
L36A9:   .DW  03663h           ; Restart: Move 44

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 48
;----------------------------------------------------
L36AB:   .DB  000h             ;         
L36AC:   .DB  090h             ; Correct Move   = FEET
L36AD:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L36AE:   .DB  004h, 055h, 091h ; Move Start Frame:  045591
L36B1:   .DB  004h, 056h, 021h ; Move End Frame:    045621
L36B4:   .DB  004h, 092h, 025h ; Death Start Frame: 049225
L36B7:   .DB  004h, 096h, 034h ; Death End Frame:   049634  
L36BA:   .DB  007h             ; Restart 7 moves
L36BB:   .DW  03663h           ; Restart: Move 44

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 49
;----------------------------------------------------
L36BD:   .DB  000h             ;         
L36BE:   .DB  0F0h             ; Correct Move   = HANDS,FEET
L36BF:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L36C0:   .DB  004h, 056h, 018h ; Move Start Frame:  045618
L36C3:   .DB  004h, 056h, 048h ; Move End Frame:    045648
L36C6:   .DB  004h, 092h, 025h ; Death Start Frame: 049225
L36C9:   .DB  004h, 096h, 034h ; Death End Frame:   049634  
L36CC:   .DB  007h             ; Restart 7 moves
L36CD:   .DW  03663h           ; Restart: Move 44

;----------------------------------------------------
;   Difficulty 1:Scene 8:Move 50
;----------------------------------------------------
L36CF:   .DB  000h             ;         
L36D0:   .DB  060h             ; Correct Move   = HANDS
L36D1:   .DB  00Fh             ; Incorrect Move = LEFT,RIGHT,UP,DOWN
L36D2:   .DB  004h, 056h, 085h ; Move Start Frame:  045685
L36D5:   .DB  004h, 057h, 015h ; Move End Frame:    045715
L36D8:   .DB  004h, 092h, 025h ; Death Start Frame: 049225
L36DB:   .DB  004h, 096h, 034h ; Death End Frame:   049634  
L36DE:   .DB  007h             ; Restart 7 moves
L36DF:   .DW  03663h           ; Restart: Move 44











;----------------------------------------------------
;                    unknown
;---------------------------------------------------- 
L36C8:  DEC     H
        INC     B
        SUB     (HL)
        INC     (HL)
        RLCA    
        LD      H,E
        LD      (HL),000
        LD      H,B
        RRCA    
        INC     B
        LD      D,(HL)
        ADD     A,L
        INC     B
        LD      D,A
        DEC     D
        INC     B
        SUB     D
        DEC     H
        INC     B
        SUB     (HL)
        INC     (HL)
        RLCA    
        LD      H,E
        LD      (HL),029
        LD      B,E
        LD      C,A
        LD      D,B
        LD      E,C
        LD      D,D
        LD      C,C
        LD      B,A
        LD      C,B
        LD      D,H
        LD      A,(05320)
        LD      D,H
        LD      B,L
        LD      D,D
        LD      C,(HL)
        JR      NZ,L3739                
        LD      C,H
        LD      B,L
        LD      B,E
        LD      D,H
        LD      D,D
        LD      C,A
        LD      C,(HL)
        LD      C,C
        LD      B,E
        LD      D,E
        INC     L
        JR      NZ,L374A                
        LD      C,(HL)
        LD      B,E
        LD      L,000
        NOP     
        LD      BC,01500
        LD      B,E
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     








;----------------------------------------------------
;            Perform Switch Test
;----------------------------------------------------
L3720:  CALL    L21FF           ; Clear Text Display
        LD      A,050h          ; Text = LT BLUE, Bkgnd = TRANS
        CALL    L20CA           ; Setup Graphics Chip for Text
        CALL    L2353           ; Wait for Comm Ready
        PUSH    HL              ; Save HL Register
        LD      HL,00007h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text 
;----------------------------------------------------
L3732:  .TEXT   "SWITCH TEST & DISPLAY"
        .DB     000h 
;----------------------------------------------------     
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
L374A:  LD      HL,00055h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L3750:  .TEXT   "BITS = 7 6 5 4 3 2 1 0"
        .DB     000h 
;----------------------------------------------------     
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,000A1h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text 
;----------------------------------------------------
L376F:  .TEXT   "STROBE 0" 
        .DB     000h 
;----------------------------------------------------           
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,000F1h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text 
;----------------------------------------------------
L3780:  .TEXT   "STROBE 1" 
        .DB     000h 
;----------------------------------------------------            
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00141h       ; Cursor Position
L378E:  CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L3791:  .TEXT   "STROBE 2"     
        .DB     000h 
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00191h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text 
;----------------------------------------------------
L37A2:  .TEXT   "STROBE 3" 
        .DB     000h 
;----------------------------------------------------            
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,001E1h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text 
;----------------------------------------------------
L37B3:  .TEXT   "STROBE 4" 
        .DB     000h 
;----------------------------------------------------            
        POP     HL              ; Restore HL Register
        CALL    L2353           ; Wait for Comm Ready
        PUSH    HL              ; Save HL Register 
        LD      HL,00231h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text 
;----------------------------------------------------
L37C7:  .TEXT   "STROBE 5"     
        .DB     000h 
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00281h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text 
;----------------------------------------------------
L37D8:  .TEXT   "STROBE 6"     
        .DB     000h 
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,002D1h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text 
;----------------------------------------------------
L37E9:  .TEXT   "STROBE 7"     
        .DB     000h 
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00321h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text 
;----------------------------------------------------
L37FA:  .TEXT   "STROBE 8"     
        .DB     000h 
;----------------------------------------------------
        POP     HL              ; Restore HL Register
L3804:  PUSH    HL              ; Save HL Register
        LD      HL,00371h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text 
;----------------------------------------------------
L380B:  .TEXT   "STROBE 9" 
        .DB     000h 
;----------------------------------------------------            
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
L3816:  LD      HL,00251h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text 
;----------------------------------------------------
L381C:  .TEXT   "0 = OFF"     
        .DB     000h 
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00279h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text 
;----------------------------------------------------
L382C:  .TEXT   "1 = ON "                
        .DB     000h 
;----------------------------------------------------
L3834:  POP     HL              ; Restore HL Register
L3835:  LD      B,001h          ; Loop = 1
L3837:  CALL    L2353           ; Wait for Comm Ready
L383A:  DJNZ    L3837           ; Loop for 1 Comm

        LD      A,00Fh
L383E:  OUT     (060h),A
        CALL    L23F0           ; Call Delay1
        LD      E,004h
        LD      B,000h
L3847:  LD      D,00Ch
        LD      A,B
        OUT     (060h),A
L384C:  CALL    L23F0
        IN      A,(062h)
        CPL     
        LD      H,A
        LD      A,00Fh
        OUT     (060h),A
        LD      A,H
        CALL    L3867
        INC     E
        INC     E
        INC     B
        LD      A,B
        CP      00Ah
        JP      C,L3847
        JP      L3835

L3867:  PUSH    AF
        PUSH    BC
        LD      B,008

L386B:  RLC     A
        PUSH    AF
        CALL    L3879
        INC     D
        INC     D
        POP     AF
        DJNZ    L386B                   
        POP     BC
        POP     AF
        RET     







L3879:  LD      A,030h
        JR      NC,L3888                
        LD      A,(0E111h)
L3880:  AND     008h
        LD      A,031h
        JR      Z,L3888                 
        LD      A,020h
L3888:  CALL    L2233           ; Print one Character to Text Display
        RET     




L388C:  .DB   0, 0, 6



DoIntroScreen:             
L388F:  CALL    SetAudio        ;
        LD      HL,0E174h       ;
        INC     (HL)            ;
        CALL    L2155           ; Clear Graphics Areas, Fill Screen with Characters

        LD      HL,06EB8h       ; HL = "CLIFF HANGER" Patterns
        LD      DE,00000h       ; Copy Patterns to 0000h
        LD      BC,00B00h       ; BC = 352 character x 8 bytes
        CALL    L22D9           ; Write Data Block to Graphics Address

        LD      A,01Fh          ; Column = 31
        CALL    L3960           ; Position Image at column 31
        LD      HL,0E130h       ; 
        SET     6,(HL)          ;
        CALL    L22F5           ; Program Graphics Chip
;----------------------------------------------------
;        Scroll Graphics across screen 
;----------------------------------------------------
        LD      A,01Fh          ; Loop = 31 Columns
L38B4:  PUSH    AF              ; Save Loop 
        CALL    L3960           ; Do Image Positioning
        LD      B,003h          ; Loop = 3
L38BA:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L38BA           ; Loop for 3 Comm's
        POP     AF              ; Recall Loop
        DEC     A               ; Decrement Loop
        JP      NZ,L38B4        ; Loop until all columns scrolled


        LD      IY,0388Ch       ; Frame Number = 006 (Rainy Storm)
        CALL    L08B5           ; Search to Frame Number
        LD      A,065h          ; Text = LT_BLUE, Bkgnd = DK_RED
        CALL    L399E           ; Fill Pixel Color Table

        LD      B,002h          ; Loop = 2
L38D2:  CALL    L2353           ; Wait for Comm Ready           
        DJNZ    L38D2           ; Loop for 2 Comm's

        LD      A,0F5h          ; Text = WHITE, Bkgnd = DK_RED
        CALL    L399E           ; Fill Pixel Color Table

        LD      B,001h          ; Loop = 1
L38DE:  CALL    L2353           ; Wait for Comm Ready           
        DJNZ    L38DE           ; Loop for 1 Comm       

        LD      A,015h          ; Text = BLACK, Bkgnd = DK_RED
        CALL    L399E           ; Fill Pixel Color Table

        CALL    L3A7B           ; Display STERN Title Screen
        CALL    Delay100000     ; Call Delay 100000

        LD      B,014h          ; Loop = 20
L38F0:  CALL    L3AC2           ; Show Number of Credits
        CALL    Delay10000      ; Call Delay 10,000
        DJNZ    L38F0           ; Looping on delay 20 times
                           
        LD      E,007h          ; E = 7 Colors
        LD      HL,03959h       ; Point to color codes
L38FD:  LD      A,(HL)          ; Get color code
        CALL    L399E           ; Fill Pixel Color Table

        LD      B,003h          ; Loop = 3
L3903:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L3903           ; Loop for 3 Comm's                         

        CALL    L3AC2           ; Show Number of Credits
        INC     HL              ; Point to next color code
        DEC     E               ; Decrement color count
        JR      NZ,L38FD        ; Loop until all colors used

        CALL    L236C           ;
        CALL    L22F5           ; Program Graphics Chip
        LD      IX,0388Ch       ; Target Frame Pointer 006
        LD      IY,0388Ch       ; Search Frame Pointer 006
        CALL    L0A33           ; Play until frame number is reached
        CALL    L39B8

L3923:  LD      B,001h          ; Loop = 1
L3925:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L3925           ; Loop for 1 Comm        

        CALL    L3A35
        LD      IX,0E137h
        LD      A,(IX+000h)
        OR      A
        JR      NZ,L3923                
        LD      B,001h          ; Loop = 1
L3939:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L3939           ; Loop for 1 Comm        
        LD      A,005h          ; Command = PLAY (05h)
        CALL    L207F           ; Send Message to LDPlayer DI
        LD      A,(0E126h)      ; Get Control Register
        RES     4,A
        LD      (0E126h),A
        LD      A,000h          ; Text = TRANSPARENT, Bkgnd = TRANSPARENT
        LD      (0E136h),A      ; Set Color
        LD      HL,0E130h
        RES     6,(HL)
        CALL    L22F5           ; Program Graphics Chip
        RET                     ; Return





;----------------------------------------------------
;              Colors
;----------------------------------------------------
    .DB   0F5h, 0B5h, 085h, 0A5h, 045h, 0C5h, 031h 

     





;----------------------------------------------------
;           Position Graphic Image
;----------------------------------------------------
;       A = Horizontal Position for Image (0-31)
;----------------------------------------------------
L3960:  PUSH    BC              ; Save BC Register
        PUSH    DE              ; Save DE Register
        PUSH    HL              ; Save HL Register
        AND     01Fh            ; Location must be < 31
        LD      D,A             ; D = X Location for Graphic
        CALL    L2353           ; Wait for Comm Ready
        LD      HL,3C00h        ; Graphics Addres 3C00h
        CALL    L2334           ; Set Graphics Address
        LD      B,00Bh          ; Loop = 11 Rows
        LD      H,000h          ;
L3973:  PUSH    BC              ; Save Row Counter
        LD      E,D             ;
        LD      A,E             ;
        OR      A               ;
        JP      Z,L398A         ;
        LD      B,020h          ; Loop = 32 Columns
L397C:  LD      A,000h          ; A = Blank space 
        OUT     (044h),A        ; Print leading spaces
        PUSH    AF              ; Small delay
        POP     AF              ; Small delay
        PUSH    AF              ; Small delay
        POP     AF              ; Small delay
        PUSH    AF              ; Small delay
        POP     AF              ; Small delay
        DEC     B               ; Subtract 1 Column
        DEC     E               ; Subtract Leading space
        JR      NZ,L397C        ; Leading spaces remain so loop back       
L398A:  LD      L,H             ;
L398B:  LD      A,L             ;
        OUT     (044h),A        ; Draw Character
        PUSH    AF              ; Small delay
        POP     AF              ; Small delay
        INC     L               ; Next character
        DJNZ    L398B           ; Loop for remaining number of columns       
        POP     BC              ; Get Row Counter
        LD      A,H             ;
        ADD     A,020h          ; Go to next row (add 32 characters)
        LD      H,A             ; Store in 
        DJNZ    L3973           ; Loop until all 11 Rows used        
        POP     HL              ; Restore HL Register
        POP     DE              ; Restore DE Register
        POP     BC              ; Restore BC Register
        RET                     ; Return








;----------------------------------------------------
;      Fill Graphics Area 2000h-37FFh with value
;         2000h-37FFh  Pixel Byte Color Table
;----------------------------------------------------
;        A = Text Color/Background Color
;----------------------------------------------------
L399E:  LD      BC,01800h       ; Setup loop BC = 1800h
        PUSH    HL              ; Save HL Register
        PUSH    DE              ; Save DE Register
        LD      E,A             ; Store Character temporarily
        CALL    L2353           ; Wait for Comm Ready
        LD      HL,02000h       ; Graphics Address = 2000h
        CALL    L2334           ; Set Graphics Address
L39AD:  LD      A,E             ; A = Character
        OUT     (044h),A        ; Write A to Graphics Address
        DEC     BC              ; Decrement loop
        LD      A,B             ; Get loop
        OR      C               ; Check if loop finished
        JR      NZ,L39AD        ; Loop until all finished
        POP     DE              ; Restore DE Register
        POP     HL              ; Restore HL Register
        RET                     ; Return








;----------------------------------------------------
;         Write Data Blocks to Graphics Address
;  Clear:  07F8h, 0FF8h, 17F8h, 27F8h, 2FF8h, 37F8h
;----------------------------------------------------
L39B8:  LD      IX,0E137h       ;
        LD      A,00Fh          ;
        LD      (IX+000h),A     ;
        LD      A,010h          ;
        LD      (IX+001h),A     ;

        LD      B,001h          ; Loop = 1
L39C8:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L39C8           ; Loop for 1 Comm       

        LD      HL,03A2Dh       ;
        LD      DE,027F8h       ;
        LD      BC,00008h       ; 8 bytes to write
        CALL    L22D9           ; Write Data Block to Graphics Address

        LD      HL,03A24h       ;
        LD      DE,007F8h       ;
        LD      BC,00008h       ; 8 bytes to write
        CALL    L22D9           ; Write Data Block to Graphics Address

        LD      B,001h          ; Loop = 1
L39E7:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L39E7           ; Loop for 1 Comm

        LD      HL,03A2Dh       ;
        LD      DE,02FF8h       ;
        LD      BC,00008h       ; 8 bytes to write
        CALL    L22D9           ; Write Data Block to Graphics Address

        LD      HL,03A24h       ;
        LD      DE,00FF8h       ;
        LD      BC,00008h       ; 8 bytes to write
        CALL    L22D9           ; Write Data Block to Graphics Address

        LD      B,001h          ; Loop = 1
L3A06:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L3A06           ; Loop for 1 Comm

        LD      HL,03A2Dh       ;
        LD      DE,037F8h       ;
        LD      BC,00008h       ; 8 bytes to write
        CALL    L22D9           ; Write Data Block to Graphics Address

        LD      HL,03A24h       ;
        LD      DE,017F8h       ;
        LD      BC,00008h       ; 8 bytes to write
        CALL    L22D9           ; Write Data Block to Graphics Address

        RET                     ; Return



;----------------------------------------------------
;            Data to Write to Graphics Chip
;----------------------------------------------------
L3A24:  .DB   000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
L3A2C:  .DB   000h 
L3A2D:  .DB   000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h     






;----------------------------------------------------
;                unknown
;----------------------------------------------------
L3A35:  LD      IX,0E137h       ; IX = Index
        LD      E,(IX+000h)     ;
        LD      D,000h          ;
        LD      HL,03C00h       ; 
        ADD     HL,DE           ;
        CALL    L3A5C           ;
        LD      HL,03C00h       ;
        LD      E,(IX+001h)     ;
        LD      D,000h          ;
        ADD     HL,DE           ;
        CALL    L3A5C           ;
        LD      IX,0E137h       ;
        DEC     (IX+000h)       ;
        INC     (IX+001h)       ;
        RET                     ; Return




;----------------------------------------------------
;                unknown
;      HL = Graphics Address      (24x32?)
;----------------------------------------------------
L3A5C:  LD      B,018h          ; Loop = 24
L3A5E:  LD      C,001h          ;
        CALL    L2334           ; Set Text Cursor Position 
L3A63:  PUSH    AF              ;
        POP     AF              ;
        LD      A,0FFh          ;
        OUT     (044h),A        ;
        PUSH    AF              ;
        POP     AF              ;
        PUSH    AF              ;
        POP     AF              ;
        PUSH    AF              ;
        POP     AF              ;
        PUSH    AF              ;
        POP     AF              ;
        DEC     C               ;
        JR      NZ,L3A63        ;        
        LD      DE,00020h       ; Add 32
        ADD     HL,DE           ;
        DJNZ    L3A5E           ;        
        RET                     ; Return








;----------------------------------------------------
;         Display STERN Title Screen
;----------------------------------------------------
L3A7B:  PUSH    HL              ; Save HL Register
        LD      HL,03E04h       ; Cursor Position (Bold)
        CALL    L22C3           ; Set Cursor and Print Text 
;----------------------------------------------------
L3A82:  .TEXT   "A Laser Disc Video Game"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        CALL    Delay100000     ; Call Delay 100,000
        PUSH    HL              ; Save HL Register
        LD      HL,03E43h       ; Cursor Position
        CALL    L22C3           ; Set Cursor and Print Text
;----------------------------------------------------
L3AA5:  .TEXT   "BY STERN ELECTRONICS, INC."
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        RET                     ; Return








;----------------------------------------------------
;            Show Number of Credits
;----------------------------------------------------
L3AC2:  PUSH    BC              ; Save BC Register
        PUSH    DE              ; Save DE Register
        PUSH    HL              ; Save HL Register
        LD      A,(0E18Ch)      ; Get DIP Switches 12-19
        BIT     2,A             ; Check FREE PLAY (sw 14)
        JP      NZ,L3B23        ; Set so print FREE PLAY
        LD      A,(0E1A8h)      ;
        CP      001h            ;
        JP      Z,L3B0E         ; Set so print 1 CREDIT
        LD      HL,0E137h       ;
        LD      (HL),A          ;
        RRC     A               ;
        RRC     A               ;
L3ADD:  RRC     A               ;
        RRC     A               ;
        AND     00Fh            ;
        JR      Z,L3AE7         ;        
        OR      010h            ;
L3AE7:  PUSH    AF              ;
        LD      HL,03EE9h       ;
        CALL    L2334           ;
        POP     AF              ;
        OUT     (044h),A        ;
        LD      HL,0E137h       ;
L3AF4:  LD      A,(HL)          ;
        AND     00Fh            ;
        OR      010h            ;
        OUT     (044h),A        ;
        PUSH    HL              ; Save HL Register 
L3AFC:  LD      HL,03EECh       ; Cursor Location
        CALL    L22C3           ; Set Cursor and Print Text
;----------------------------------------------------
L3B02:  .TEXT   "CREDITS"
        .DB     000h     
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        JP      L3B35           ; Goto end





;----------------------------------------------------
;             Print 1 CREDIT
;----------------------------------------------------
L3B0E:  PUSH    HL              ; Save HL Register
        LD      HL,03EE9h       ; Cursor Location
        CALL    L22C3           ; Set Cursor and Print Text
;----------------------------------------------------
L3B15: .TEXT   " 1 CREDIT"     
       .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        JP      L3B35           ; Goto end





;----------------------------------------------------
;               Print FREE PLAY
;----------------------------------------------------
L3B23:  PUSH    HL              ; Save HL Register
        LD      HL,03EEBh       ; Cursor Location
        CALL    L22C3           ; Set Cursor and Print Text
;----------------------------------------------------
L3B2A:  .TEXT   "FREE PLAY"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
L3B35:  POP     HL              ; Restore HL Register
        POP     DE              ; Restore DE Register
        POP     BC              ; Restore BC Register
        RET                     ; Return









;----------------------------------------------------
;               Flash GAME OVER
;----------------------------------------------------
L3B39:  CALL    L21FF           ; Clear Text Display
        LD      A,041h          ; Text = BLUE, Bkgnd = BLACK
        CALL    L20CA           ; Setup Graphics Chip for Text
        PUSH    HL              ; Save HL Register
        LD      HL,00174h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L3B48:  .TEXT   "******************"
        .DB     000h     
;----------------------------------------------------
        POP     HL              ; Restore HL Register
L3B5C:  PUSH    HL              ; Save HL Register
        LD      HL,0019Ch       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L3B63:  .TEXT   "*                *"
        .DB     000h     
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,001C4h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L3B7E:  .TEXT   "*  YOUR  GAME    *"
        .DB     000h     
;----------------------------------------------------
        POP     HL              ; Restore HL Register
L3B92:  PUSH    HL              ; Save HL Register
        LD      HL,001ECh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
 ;----------------------------------------------------
L3B99:  .TEXT   "*                *"
        .DB     000h     
;----------------------------------------------------
        POP     HL              ; Restore HL Register
L3BAD:  PUSH    HL              ; Save HL Register
        LD      HL,00214h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text     
;----------------------------------------------------
L3BB4:  .TEXT   "* IS  NOW  OVER  *"              
        .DB     000h     
;----------------------------------------------------
        POP     HL              ; Restore HL Register
L3BC8:  PUSH    HL              ; Save HL Register
        LD      HL,0023Ch       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L3BCF:  .TEXT   "*                *"
        .DB     000h     
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00264h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L3BEA:  .TEXT   "******************"
        .DB     000h
;----------------------------------------------------     
        POP     HL              ; Restore HL Register
L3BFE:  LD      B,012h          ; Loop = 18 colors
L3C00:  LD      HL,03C28h       ; Point to GAME OVER Color Table
L3C03:  LD      A,(HL)          ; Get Color from table
        INC     HL              ; Point to next color in table
        LD      (0E136h),A      ; Set Color 
        PUSH    HL              ; Save HL Register
        CALL    L22F5           ; Program Graphics Chip
        CALL    L2353           ; Wait for Comm Ready
        CALL    L2353           ; Wait for Comm Ready
        CALL    L2353           ; Wait for Comm Ready
        CALL    L2353           ; Wait for Comm Ready
        CALL    L2353           ; Wait for Comm Ready
        POP     HL              ; Restore HL Register
        DJNZ    L3C03           ; Loop until all colors used
        CALL    Delay100000     ; Delay 100,000
        CALL    Delay100000     ; Delay 100,000
        CALL    L21FF           ; Clear Text Display
        RET                     ; Return








;---------------------------------------------------- 
;         Color Table for GAME OVER
;---------------------------------------------------- 
L3C28:   .DB   011h  ; Text = BLACK,     Bkgnd = BLACK
L3C29:   .DB   021h  ; Text = MED GREEN, Bkgnd = BLACK
L3C2A:   .DB   031h  ; Text = LT GREEN,  Bkgnd = BLACK
L3C2B:   .DB   041h  ; Text = BLUE,      Bkgnd = BLACK
L3C2C:   .DB   051h  ; Text = LT BLUE,   Bkgnd = BLACK
L3C2D:   .DB   061h  ; Text = DK RED,    Bkgnd = BLACK
L3C2E:   .DB   071h  ; Text = CYAN,      Bkgnd = BLACK
L3C2F:   .DB   081h  ; Text = MED RED,   Bkgnd = BLACK
L3C30:   .DB   091h  ; Text = PINK,      Bkgnd = BLACK
L3C31:   .DB   0A4h  ; Text = DK YELLOW, Bkgnd = BLUE
L3C32:   .DB   0B6h  ; Text = LT YELLOW, Bkgnd = DK RED
L3C33:   .DB   0C4h  ; Text = DK GREEN,  Bkgnd = BLUE
L3C34:   .DB   0D6h  ; Text = PURPLE,    Bkgnd = DK RED
L3C35:   .DB   0E4h  ; Text = GRAY,      Bkgnd = BLUE
L3C36:   .DB   0F6h  ; Text = WHITE,     Bkgnd = DK RED
L3C37:   .DB   0F4h  ; Text = WHITE,     Bkgnd = BLUE
L3C38:   .DB   0F1h  ; Text = WHITE,     Bkgnd = BLACK
L3C39:   .DB   0F1h  ; Text = WHITE,     Bkgnd = BLACK








;---------------------------------------------------- 
;            Congratulation Celebration
;---------------------------------------------------- 
L3C3A:  LD      A,(0E126h)      ; Get Control Register      ;
        BIT     1,A             ;
        JR      NZ,L3C3A        ; Wait until LDPlayer not busy?
               
        LD      A,(0E126h)      ; Get Control Register
        BIT     4,A             ;
        JR      NZ,L3C55        ;        
;----------------------------------------------------
;             Send PAUSE Command
;----------------------------------------------------
        LD      A,00Ah          ; Command = PAUSE (0Ah)
        CALL    L207F           ; Send Message to LDPlayer DI
        LD      A,(0E126h)      ; Get Control Register
        SET     4,A             ; Set PAUSE Bit
        LD      (0E126h),A      ; Save Control Register
L3C55:  CALL    L21FF           ; Clear Text Display
        LD      A,059h          ; Text = LT BLUE, Bkgnd = PINK
        CALL    L20CA           ; Setup Graphics Chip for Text
;---------------------------------------------------- 
;       Print Congratulations and rotate asterisks
;----------------------------------------------------
        LD      B,040h          ; Loop = 64
L3C5F:  PUSH    BC              ; Save Rotate Loop Counter

        LD      B,003h          ; Loop = 3
L3C62:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L3C62           ; Loop for 3 Comm's

        CALL    L3CBA           ; Print "CONGRATULATIONS" (1)

        LD      B,003h          ; Loop = 3
L3C6C:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L3C6C           ; Loop for 3 Comm's

        CALL    L3DCB           ; Print "CONGRATULATIONS" (2)

        LD      B,003h          ; Loop = 3
L3C76:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L3C76           ; Loop for 3 Comm's

        CALL    L3EDC           ; Print "CONGRATULATIONS" (3)
        POP     BC              ; Restore Rotate Loop Counter
        DJNZ    L3C5F           ; Continue Rotate Asterisk Loop

        CALL    L3FED           ; Print "CONGRATULATIONS" (4) final

;---------------------------------------------------- 
;          Flash background/text colors
;----------------------------------------------------
        LD      B,01Eh          ; Loop = 30 (should be 15?)
L3C86:  LD      HL,03CABh       ; Point to color data
        LD      E,B             ; Set index
        LD      D,000h          ; Set index
        ADD     HL,DE           ; Add index to color data table
        LD      A,(HL)          ; Get color 
        RLC     A               ; Swap text and background color
        RLC     A               ; Swap text and background color
        RLC     A               ; Swap text and background color
        RLC     A               ; Swap text and background color
        LD      (0E136h),A      ; Set Color
        CALL    L22F5           ; Program Graphics Chip
        CALL    L2353           ; Wait for Comm Ready
        DJNZ    L3C86           ; Loop until all 30 colors displayed
                
        CALL    L3FED           ; Print "CONGRATULATIONS" (4) final
        CALL    L244C           ; Delay 200,000
        CALL    L21FF           ; Clear Text Display
        RET                     ; Return






;----------------------------------------------------
;          Congratulations Color Flash Data
;----------------------------------------------------
L3CAB:   .DB   0F4h  ; Text = WHITE, Bkgnd = BLUE
L3CAC:   .DB   0F6h  ; Text = WHITE, Bkgnd = DK_RED
L3CAD:   .DB   0F4h  ; Text = WHITE, Bkgnd = BLUE
L3CAE:   .DB   0F6h  ; Text = WHITE, Bkgnd = DK_RED
L3CAF:   .DB   0F4h  ; Text = WHITE, Bkgnd = BLUE
L3CB0:   .DB   0F6h  ; Text = WHITE, Bkgnd = DK_RED
L3CB1:   .DB   0F4h  ; Text = WHITE, Bkgnd = BLUE
L3CB2:   .DB   0F6h  ; Text = WHITE, Bkgnd = DK_RED
L3CB3:   .DB   0F4h  ; Text = WHITE, Bkgnd = BLUE
L3CB4:   .DB   0F6h  ; Text = WHITE, Bkgnd = DK_RED
L3CB5:   .DB   0F4h  ; Text = WHITE, Bkgnd = BLUE
L3CB6:   .DB   0F6h  ; Text = WHITE, Bkgnd = DK_RED
L3CB7:   .DB   0F4h  ; Text = WHITE, Bkgnd = BLUE
L3CB8:   .DB   0F6h  ; Text = WHITE, Bkgnd = DK_RED
L3CB9:   .DB   0F4h  ; Text = WHITE, Bkgnd = BLUE






;----------------------------------------------------
;             Print "CONGRATULATIONS" (1)
;              Alternate asterisks
;----------------------------------------------------
L3CBA:  PUSH    HL              ; Save HL Register
        LD      HL,0016Fh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
        .TEXT   "*  *  *  *  *  *  *  *  *"
        .DB     000h
;----------------------------------------------------
        PUSH    HL              ; Save HL Register
        LD      HL,00197h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L3CE3:  .TEXT   "                         "                
        .DB     000h
;----------------------------------------------------
L3CFD:  POP     HL
        PUSH    HL              ; Save HL Register
        LD      HL,001BFh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L3D05:  .TEXT   "*    CONGRATULATIONS     "                
        .DB     000h
;----------------------------------------------------
L3D1F:  POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,001E7h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L3D27:  .TEXT   "                        *"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0020Fh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L3D49:  .TEXT   "    YOU HAVE COMPLETED   "                
        .DB     000h
;----------------------------------------------------
L3D63:  POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00237h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L3D6B:  .TEXT   "*     THIS CHALLENGE     "                
        .DB     000h
;----------------------------------------------------
L3D85:  POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0025Fh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L3D8D:  .TEXT   "                        *"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00287h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L3DAF:  .TEXT   "  *  *  *  *  *  *  *  "     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        RET                     ; Return







     
;----------------------------------------------------
;             Print "CONGRATULATIONS" (2)
;              Alternate asterisks
;----------------------------------------------------
L3DCB:  PUSH    HL              ; Save HL Register
        LD      HL,0016Fh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text     
;----------------------------------------------------
L3DD2:  .TEXT   " *  *  *  *  *  *  *  *  "     
        .DB     000h     
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00197h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text     
;----------------------------------------------------
L3DF4:  .TEXT   "*                       *"     
        .DB     000h     
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,001BFh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text     
;----------------------------------------------------
L3E16:  .TEXT   "     CONGRATULATIONS     "                
        .DB     000h     
;----------------------------------------------------
L3E30:  POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,001E7h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text     
;----------------------------------------------------
L3E38:  .TEXT   "                         "                
        .DB     000h     
;----------------------------------------------------
L3E52:  POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0020Fh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L3E5A:  .TEXT   "*   YOU HAVE COMPLETED  *"
        .DB     000h     
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00237h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text     
;----------------------------------------------------
L3E7C:  .TEXT   "      THIS CHALLENGE     "                
        .DB     000h     
;----------------------------------------------------
L3E96:  POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0025Fh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text    
;----------------------------------------------------
L3E9E:  .TEXT   "                         "                
        .DB     000h     
;----------------------------------------------------
L3EB8:  POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00287h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text     
;----------------------------------------------------
L3EC0:  .TEXT   "*  *  *  *  *  *  *  *  *"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        RET                     ; Return










;----------------------------------------------------
;             Print "CONGRATULATIONS" (3)
;              Alternate asterisks
;----------------------------------------------------

L3EDC:  PUSH    HL              ; Save HL Register
        LD      HL,0016Fh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L3EE3:  .TEXT   "  *  *  *  *  *  *  *  * "
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00197h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L3F05:  .TEXT   "                         "                
        .DB     000h
;----------------------------------------------------
L3F1F:  POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,001BFh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L3F27:  .TEXT   "     CONGRATULATIONS    *"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,001E7h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L3F49:  .TEXT   "*                        "     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0020Fh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L3F6B:  .TEXT   "    YOU HAVE COMPLETED   "                
        .DB     000h
;----------------------------------------------------
L3F85:  POP     HL
        PUSH    HL              ; Save HL Register
        LD      HL,00237h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L3F8D:  .TEXT   "      THIS CHALLENGE    *"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0025Fh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L3FAF:  .TEXT   "*                        "     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00287h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L3FD3:  .TEXT   "*  *  *  *  *  *  *  * "
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        RET                     ; Return   









;----------------------------------------------------
;             Print "CONGRATULATIONS" (4)
;                 Full asterisks
;----------------------------------------------------
L3FED:  PUSH    HL              ; Save HL Register
        LD      HL,0016Fh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L3FF4:  .TEXT   "*************************"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00197h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4016:  .TEXT   "*                       *"P
        .DB     000h
;----------------------------------------------------             
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,001BFh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4038:  .TEXT   "*    CONGRATULATIONS    *"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,001E7h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L405A:  .TEXT   "*                       *"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0020Fh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L407C:  .TEXT   "*   YOU HAVE COMPLETED  *"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00237h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L409E:  .TEXT   "*     THIS CHALLENGE    *"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0025Fh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L40C0:  .TEXT   "*                       *"     
        .DB     000h
;----------------------------------------------------
L40DA:  POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00287h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L40E2:  .TEXT   "*************************"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        RET                     ; Return








;----------------------------------------------------
;          Start of SERVICE MODE
;----------------------------------------------------
L40FE:  CALL    L1627           ; Reset Bookkeeping Data
        CALL    L245B           ; Get ALL Input Data
        LD      SP,0F000h       ; Set Stack Pointer
L4107:  LD      A,(0E126h)      ; Get Control Register
        BIT     1,A
        JR      NZ,L4107                
        LD      A,(0E126h)      ; Get Control Register
        BIT     4,A
        JR      NZ,L4122                
;----------------------------------------------------
;             Send PAUSE Command
;----------------------------------------------------
        LD      A,00Ah          ; Command = PAUSE (0Ah)
        CALL    L207F           ; Send Message to LDPlayer DI
        LD      A,(0E126h)      ; Get Control Register
        SET     4,A             ; Set PAUSE Bit
        LD      (0E126h),A      ; Save Control Register

L4122:  CALL    L21FF           ; Clear Text Display
        LD      A,0E1h          ; Text = GRAY, Bkgnd = BLACK
        CALL    L20CA           ; Setup Graphics Chip for Text
L412A:  LD      A,005h          ; A = Rectangle starting row 
        LD      (0E1E6h),A      ; Save starting row
        CALL    L4389           ; Draw Rectangle
        LD      A,002h          ;
        LD      (0E1E5h),A      ;
        LD      A,(0E193h)      ; Get Button Data
        BIT     2,A             ; Is PLAYER1/FEET pressed?
        JP      NZ,L412A        ; No, loop until button pressed
        PUSH    HL              ; Save HL Register
        LD      HL,00031h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text 
;----------------------------------------------------
L4146:  .TEXT   "SERVICE MODE MAIN MENU"
        .DB   000h 
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,000CDh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text 
;----------------------------------------------------
L4165:  .TEXT   "1. BOOKKEEPING"
        .DB   000h 
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0011Dh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L417C:  .TEXT   "2. GAME ADJUSTMENTS"     
        .DB   000h 
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0016Dh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4198:  .TEXT   "3. CREDIT/COIN SETTINGS"     
        .DB   000h 
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,001BDh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L41B8:  .TEXT   "4. MONITOR TESTS"     
        .DB   000h 
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0020Dh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L41D1:  .TEXT   "5. SOUND TESTS"  
        .DB   000h 
;----------------------------------------------------   
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0025Dh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text 
;----------------------------------------------------
L41E8:  .TEXT   "6. GAME PLAY STATISTICS"
        .DB   000h 
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        CALL    L4214           ; Print Control Instructions
L4204:  CALL    L4386           ; Draw Rectangle at Row (E1E6)
        CALL    L42B9           ; Process Service Mode User Input
        LD      B,004h          ; Loop = 4
L420C:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L420C           ; Loop for 4 Comm's
        JP      L4204           ; Continue Mode









;----------------------------------------------------
;           Print Control Instructions
;----------------------------------------------------
L4214:  PUSH    HL              ; Save HL Register
        LD      HL,002ACh       ; Cursor Location
L4218:  CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L421B:  .TEXT   "--------- controls: ------------"     
        .DB   000h 
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,002FCh       ; Cursor Location
L4241:  CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4244:  .TEXT   "joystick up/down to move cursor "   
        .DB   000h 
;----------------------------------------------------             
L4265:  POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0034Ch       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L426D:  .TEXT   "    player 1 = select option    "   
        .DB   000h 
;----------------------------------------------------  
        POP     HL              ; Restore HL Register
L428F:  PUSH    HL              ; Save HL Register
        LD      HL,0039Ch       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4296:  .TEXT   "    player 2 = exit back to here"   
        .DB   000h 
;----------------------------------------------------  
        POP     HL              ; Restore HL Register
L42B8:  RET                     ; Return










;----------------------------------------------------
;         Process Service Mode User Input
;----------------------------------------------------
L42B9:  LD      B,001h          ; Loop = 1
L42BB:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L42BB           ; Loop for 1 Comm

        CALL    L245B           ; Get ALL Input Data
L42C3:  LD      A,(0E18Dh)      ; Get DIP Switches 12-19
L42C6:  BIT     0,A             ; Check Service Mode
        JP      Z,L000B         ; Leave Service Mode and start game

        LD      A,(0E196h)      ; Get Joystick Input
        BIT     0,A             ; Is Joystick UP pressed?
        JR      NZ,L42F6        ; Yes, so move up       
        BIT     2,A             ; Is Joystick DOWN pressed?
L42D4:  JR      NZ,L4311        ; Yes, so move down
        LD      A,(0E1E5h)      ;
        CP      002h            ;
        JR      NZ,L42E5        ;        
        LD      A,(0E193h)      ; Get Button Data
        BIT     2,A             ; Is PLAYER1/FEET pressed?
        JP      NZ,L43C3        ; Yes, so select category
L42E5:  LD      A,(0E193h)      ; Get Button Data
        BIT     3,A             ; Is PLAYER2/FEET pressed?
        RET     Z               ; No so return
;----------------------------------------------------
;       Player 2 Button pressed so Exit Category
;----------------------------------------------------
        LD      A,(0E192h)      ; Get Button Data
        RES     3,A             ; Clear out Player2 Button presses
L42F0:  LD      (0E192h),A      ; Save modified Button Data
L42F3:  JP      L40FE           ; Go to Service Mode

;----------------------------------------------------
;           Move UP one menu choice
;----------------------------------------------------
L42F6:  LD      A,(0E1E6h)      ; Get User Selection
        DEC     A               ; Decrement selection
        DEC     A               ; Decrement selection
        CALL    L4330           ; Is selection still valid?
        RET     Z               ; No, so stay put
        CALL    L4353           ; Erase old rectangle
        LD      A,(0E1E6h)      ; Get User Selection
        DEC     A               ; Decrement selection
        DEC     A               ; Decrement selection
        LD      (0E1E6h),A      ; Save new selection
        CALL    L4389           ; Draw new rectangle           
L430D:  CALL    L4328           ; Loop for 5 Comm's
        RET                     ; Return

;----------------------------------------------------
;           Move DOWN one menu choice
;----------------------------------------------------
L4311:  LD      A,(0E1E6h)      ; Get User Selection
        INC     A               ; Increment selection
        INC     A               ; Increment selection
        CALL    L4330           ; Is selection still valid?
        RET     Z               ; No, so stay put
        CALL    L4353           ; Erase old rectangle
        LD      A,(0E1E6h)      ; Get User Selection
        INC     A               ; Increment selection
        INC     A               ; Increment selection
        LD      (0E1E6h),A      ; Save new selection
        CALL    L4389           ; Draw new rectangle           

L4328:  LD      B,005h          ; Loop = 5
L432A:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L432A           ; Loop for 5 Comm's
        RET                     ; Return








;----------------------------------------------------
;        A = Number to Compare
;----------------------------------------------------
L4330:  PUSH    AF              ; Save AF Register
        LD      A,(0E1E5h)      ; 
        LD      B,003h          ; B = 3
        LD      C,011h          ; C = 17
        BIT     1,A             ;
        JR      NZ,L4347        ;        
        LD      B,003h          ; B = 3
        LD      C,009h          ; C = 9
        BIT     6,A             ;
        JR      NZ,L4347        ;        
        POP     AF              ;
        JR      L4351           ;        
L4347:  POP     AF              ;
        CP      B               ;
        JR      C,L4351         ;        
        JR      Z,L4351         ;        
        CP      C               ;
        JR      NC,L4351        ;        
        RET                     ; Return

L4351:  XOR     A               ; 
        RET                     ; Return







;----------------------------------------------------
;         Erase Rectangle from Display
;----------------------------------------------------
;      E1E6     Row to start rectangle
;
;        20h, 20h, 20h, 20h, 20h, 20h
;        20h                      20h
;        20h, 20h, 20h, 20h, 20h, 20h
;----------------------------------------------------
L4353:  LD      A,(0E1E6h)      ; Get Row Number
        LD      D,000h          ; Location X = 0
        LD      E,A             ; Location Y = Row Number
        LD      A,020h          ; A = Character space
        CALL    L2233           ; Print one Character to Text Display
        LD      D,027h          ; Location X = 39
        CALL    L2233           ; Print one Character to Text Display
        LD      D,000h          ; Location X = 0
        PUSH    DE              ; Save X,Y location
        DEC     E               ; Y = Y - 1
        LD      A,020h          ; A = Character space
        CALL    L2233           ; Print one Character to Text Display

        LD      B,027h          ; Loop = 39 Columns
L436E:  LD      A,020h          ; A = Character space
        CALL    L2256           ; Print A to Text Display
        DJNZ    L436E           ; Loop until line printed     

        POP     DE              ; Get row number
        INC     E               ; Y = Y + 1
        LD      A,020h          ; A = Character space
        CALL    L2233           ; Print one Character to Text Display

        LD      B,027h          ; Loop = 39 Columns
L437E:  LD      A,020h          ; A = Character space
        CALL    L2256           ; Print A to Text Display
        DJNZ    L437E           ; Loop until line printed       
        RET                     ; Return








;----------------------------------------------------
;            Draw Rectangle to Display
;----------------------------------------------------
;      E1E6     Row to start rectangle
;
;        83h, 80h, 80h, 80h, 80h, 82h
;        81h                      81h
;        85h, 80h, 80h, 80h, 80h, 84h
;----------------------------------------------------
L4386:  LD      A,(0E1E6h)      ; Get Row location
L4389:  LD      D,000h          ; Cursor X = 0
        LD      E,A             ; Cursor Y = Row
        LD      A,081h          ; A = Character Verticle Line
        CALL    L2233           ; Print one Character to Text Display
        LD      D,027h          ; Cursor X = 39  (upper right corner)
        CALL    L2233           ; Print one Character to Text Display

        LD      D,000h          ; Cursor X = 0   
        PUSH    DE              ; Save Cursor Position
;----------------------------------------------------
;              Print top line
;----------------------------------------------------
        DEC     E               ; Move up one row
        LD      A,083h          ; A = Character Upper Left Corner 
        CALL    L2233           ; Print one Character to Text Display
        LD      B,026h          ; Loop = 38 Columns
L43A1:  LD      A,080h          ; A = Character Horizontal Line
        CALL    L2256           ; Print A to Text Display
        DJNZ    L43A1           ; Loop until whole line is printed                          
        LD      A,082h          ; A = Character Upper Right Corner
        CALL    L2256           ; Print A to Text Display
        POP     DE              ; Save Cursor Position
;----------------------------------------------------
;            Print bottom line
;----------------------------------------------------
        INC     E               ; Jump down one row
        LD      A,085h          ; A = Character Lower Left Corner
        CALL    L2233           ; Print one Character to Text Display
        LD      B,026h          ; Loop = 38 Columns
L43B6:  LD      A,080h          ; A = Character Horizontal Line
        CALL    L2256           ; Print A to Text Display
        DJNZ    L43B6           ; Loop until whole line is printed              
        LD      A,084h          ; A = Character Lower Right Corner 
        CALL    L2256           ; Print A to Text Display
        RET                     ; Return






;----------------------------------------------------
;      Player1 Button pressed so select category
;----------------------------------------------------
L43C3:  CALL    L21FF           ; Clear Text Display
        LD      A,0E1h          ; Text = GRAY, Bkgnd = BLACK
        CALL    L20CA           ; Setup Graphics Chip for Text
        LD      A,(0E1E5h)
        CP      002h
        JP      NZ,L40FE        ; Go to Service Mode
        LD      A,(0E1E6h)      ; Get User Selection
        CP      010h            ; Is selection > 16?
        JP      NC,L40FE        ; Yes, so return to Service Mode
        SUB     005h            ;
        LD      E,A             ;
        LD      D,000h          ;
        LD      HL,043E9h       ;
        ADD     HL,DE           ;
        LD      A,(HL)          ;
        INC     HL              ;
        LD      H,(HL)          ;
        LD      L,A             ;
        JP      (HL)            ;



;----------------------------------------------------
;         Service Mode Routine Addresses
;----------------------------------------------------
L43E9:  .DW   049E2h    ; BOOKKEEPING
L43EB:  .DW   0465Bh    ; GAME ADJUSTMENTS
L43ED:  .DW   04CD2h    ; CREDIT/COIN SETTINGS          
L43EF:  .DW   043F5h    ; MONITOR TEST          
L43F1:  .DW   04BF0h    ; SOUND TEST  
L43F3:  .DW   04DEBh    ; GAME PLAY STATISTICS
;----------------------------------------------------








;----------------------------------------------------
;            Service Mode:  MONITOR TEST
;----------------------------------------------------
L43F5:  XOR     A               ; User Selection = 0
        LD      (0E1E6h),A      ; Reset User Selection 
        LD      A,020h          ;
        LD      (0E1E5h),A      ;

L43FE:  LD      B,001h          ; Loop = 1
L4400:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L4400           ; Loop for 1 Comm        

        CALL    L245B           ; Get ALL Input Data

        LD      B,001h          ; Loop = 1
L440A:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L440A           ; Loop for 1 Comm

        CALL    L21FF           ; Clear Text Display
        PUSH    HL              ; Save HL Register
        LD      HL,00057h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text 
;----------------------------------------------------
L4419:  .TEXT   "SERVICE MODE 04: CRT TESTS"     
        .DB   000h 
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        LD      A,016h          ; Text = BLACK, Bkgnd = DK RED
        CALL    L20CA           ; Setup Graphics Chip for Text

L443A:  CALL    L4635
        JR      Z,L443A                 
        LD      A,013h          ; Text = BLACK, Bkgnd = LT_GREEN
        CALL    L20CA           ; Setup Graphics Chip for Text

L4444:  CALL    L4635
        JR      Z,L4444                 
        LD      A,015h          ; Text = BLACK, Bkgnd = LT_BLUE
        CALL    L20CA           ; Setup Graphics Chip for Text

L444E:  CALL    L4635
        JR      Z,L444E                 
        CALL    L21FF           ; Clear Text Display
        LD      A,0F1h          ; Text = WHITE, Bkgnd = BLACK
        CALL    L20CA           ; Setup Graphics Chip for Text
        LD      HL,045C9h       ; HL = Table Pointer (below)
        PUSH    DE              ;
        EX      DE,HL           ;
        LD      HL,L0000        ;
        LD      A,028h          ; 40 character to print
        CALL    L2224           ; Print to Text Display
        POP     DE              ;
        LD      HL,045FFh       ;
        PUSH    DE              ;
        EX      DE,HL           ;
        LD      HL,00028h       ;
        LD      A,028h          ;
        CALL    L2224           ; Print to Text Display

        POP     DE              ;
        LD      HL,045C9h       ;
        PUSH    DE              ;
        EX      DE,HL           ;
        LD      HL,00050h       ;
        LD      A,028h          ;
        CALL    L2224           ; Print to Text Display

        POP     DE              ;
        LD      HL,045FFh       ;
        PUSH    DE              ;
        EX      DE,HL           ;
        LD      HL,00078h       ;
        LD      A,028h          ;
        CALL    L2224           ; Print to Text Display

        POP     DE              ;
        LD      HL,045C9h       ;
        PUSH    DE              ;
        EX      DE,HL           ;
        LD      HL,000A0h       ;
        LD      A,028h          ;
        CALL    L2224           ; Print to Text Display

        POP     DE              ;
        LD      HL,045FFh       ;
        PUSH    DE              ;
        EX      DE,HL           ;
        LD      HL,000C8h       ;
        LD      A,028h          ; 40 Characters to print
        CALL    L2224           ; Print to Text Display

        POP     DE

        LD      B,001h          ; Loop = 1
L44B1:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L44B1           ; Loop for 1 Comm
                 
        LD      HL,045C9h       ;
        PUSH    DE              ;
        EX      DE,HL           ;
        LD      HL,000F0h       ;
        LD      A,028h          ; 40 Characters to print
        CALL    L2224           ; Print to Text Display

        POP     DE              ;
        LD      HL,045FFh       ;
        PUSH    DE              ;
        EX      DE,HL           ;
        LD      HL,00118h       ;
        LD      A,028h          ; 40 Characters to print
        CALL    L2224           ; Print to Text Display

        POP     DE              ;
        LD      HL,045C9h       ;
        PUSH    DE              ;
        EX      DE,HL           ;
        LD      HL,00140h       ;
        LD      A,028h          ; 40 Characters to print
        CALL    L2224           ; Print to Text Display

        POP     DE              ;
        LD      HL,045FFh       ;
        PUSH    DE              ;
        EX      DE,HL           ;
        LD      HL,00168h       ;
        LD      A,028h          ; 40 Characters to print
        CALL    L2224           ;

        POP     DE              ;
        LD      HL,045C9h       ;
        PUSH    DE              ;
        EX      DE,HL           ;
        LD      HL,00190h       ;
        LD      A,028h          ; 40 characters to print
        CALL    L2224           ; Print to Text Display

        POP     DE              ;
        LD      HL,045FFh
        PUSH    DE
        EX      DE,HL
        LD      HL,001B8h
        LD      A,028h          ; 40 Characters to print
        CALL    L2224

        POP     DE

        LD      B,001h          ; Loop = 1
L450C:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L450C           ; Loop for 1 Comm                 

        LD      HL,045C9h       ;
        PUSH    DE              ;
        EX      DE,HL           ;
        LD      HL,001E0h       ;
        LD      A,028h          ; 40 Characters to print
        CALL    L2224           ;

        POP     DE
        LD      HL,045FFh
        PUSH    DE
        EX      DE,HL
        LD      HL,00208h
        LD      A,028h          ; 40 Characters to print
        CALL    L2224
        POP     DE
        LD      HL,045C9h
        PUSH    DE
        EX      DE,HL
        LD      HL,00230h
        LD      A,028h
        CALL    L2224
        POP     DE
        LD      HL,045FFh
        PUSH    DE
        EX      DE,HL
        LD      HL,00258h
        LD      A,028h          ; 40 Characters to print
        CALL    L2224
        POP     DE
        LD      HL,045C9h
        PUSH    DE
        EX      DE,HL
        LD      HL,00280h
        LD      A,028h          ; 40 Characters to print
        CALL    L2224           ;

        POP     DE              ;
        LD      HL,045FFh       ;
        PUSH    DE              ;
        EX      DE,HL           ;
        LD      HL,002A8h       ;
        LD      A,028h          ; 40 Characters to print
        CALL    L2224           ;

        POP     DE              ;
        LD      HL,045C9h       ;
        PUSH    DE              ;
        EX      DE,HL           ;
        LD      HL,002D0h       ;
        LD      A,028h          ;
        CALL    L2224           ; Print to Text Display

        POP     DE              ;

        LD      B,001h          ; Loop = 1
L4575:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L4575           ; Loop for 1 Comm

        LD      HL,045FFh       ;
        PUSH    DE              ;
        EX      DE,HL           ;
        LD      HL,002F8h       ;
        LD      A,028h          ; 40 characters to print
        CALL    L2224           ; Print to Text Display

        POP     DE              ;
        LD      HL,045C9h       ;
        PUSH    DE              ;
        EX      DE,HL           ;
        LD      HL,00320h       ;
        LD      A,028h          ; 40 characters to print
        CALL    L2224           ; Print to Text Display

        POP     DE              ;
        LD      HL,045FFh       ;
        PUSH    DE              ;
        EX      DE,HL           ;
        LD      HL,L0348        ;
        LD      A,028h          ; 40 characters to print
        CALL    L2224           ; Print to Text Display

        POP     DE              ;
        LD      HL,045C9h       ;
        PUSH    DE              ;
        EX      DE,HL           ;
        LD      HL,00370h       ;
        LD      A,028h          ; 40 characters to print
        CALL    L2224           ; Print to Text Display

        POP     DE              ;
        LD      HL,045FFh       ;
        PUSH    DE              ;
        EX      DE,HL           ;
        LD      HL,00398h       ;
        LD      A,028h          ; 40 characters to print
        CALL    L2224           ; Print to Text Display

        POP     DE              ;
L45C0:  CALL    L4635           ;
        JP      Z,L45C0         ;
        JP      L43FE           ; Loop back to Monitor Test





;----------------------------------------------------
;       Data unknown
;----------------------------------------------------
L45C9:   .DB  080h, 080h, 086h, 080h, 080h, 086h, 080h, 080h, 086h, 080h, 080h, 086h, 080h, 080h
         .DB  086h, 080h, 080h, 086h, 080h, 080h, 086h, 080h, 080h, 086h, 080h, 080h, 086h, 080h
         .DB  080h, 086h, 080h, 080h, 086h, 080h, 080h, 086h, 080h, 080h, 086h, 080h, 080h, 086h
         .DB  080h, 080h, 086h, 080h, 080h, 086h, 080h, 080h, 086h, 080h, 080h, 086h, 020h, 020h
         .DB  081h, 020h, 020h, 081h, 020h, 020h, 081h, 020h, 020h, 081h, 020h, 020h, 081h, 020h
         .DB  020h, 081h, 020h, 020h, 081h, 020h, 020h, 081h, 020h, 020h, 081h, 020h, 020h, 081h
         .DB  020h, 020h, 081h, 020h, 020h, 081h, 020h, 020h, 081h, 020h, 020h, 081h, 020h, 020h
         .DB  081h, 020h, 020h, 081h, 020h, 020h, 081h, 020h, 020h, 081h
 







;----------------------------------------------------
;
;----------------------------------------------------
L4635:  LD      A,(0E18Dh)      ; Get DIP Switches 12-19
        BIT     0,A             ; Check Service Index (sw 12)?
        JP      Z,L0604         ;

        LD      B,002h          ; Loop = 2
L463F:  CALL    L2353           ; Wait for Comm Ready
L4642:  DJNZ    L463F           ; Loop for 2 Comm's

        LD      A,(0E193h)      ; Get Button Data
        BIT     3,A             ; Is PLAYER2/FEET pressed?
        JP      NZ,L40FE        ; Yes, exit and return to Service Mode
        LD      A,(0E192h)      ; Get Button Data
        BIT     2,A             ; Is PLAYER1/FEET pressed?
L4651:  RET     Z               ; No, so return
        LD      A,(0E192h)      ; Get Button Data
        RES     2,A             ; Clear PLAYER1/FEET button
        LD      (0E192h),A      ; Save Button Data
        RET                     ; Return








;----------------------------------------------------
;                 Game Adjustments
;----------------------------------------------------
L465B:  LD      B,001h          ; Loop = 1
L465D:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L465D           ; Loop for 1 Comm
                
        XOR     A               ; A = 0
        LD      (0E1E6h),A      ;
        LD      A,008h          ;
        LD      (0E1E5h),A      ;

L466B:  LD      B,001h          ; Loop = 1
L466D:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L466D           ; Loop for 1 Comm
                
        CALL    L245B           ; Get ALL Input Data

        LD      B,001h          ; Loop = 1
L4677:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L4677           ; Loop for 1 Comm
                
        PUSH    HL              ; Save HL Register
        LD      HL,0002Eh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4683:  .TEXT   "SERVICE MODE 02: GAME ADJUST"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00079h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L46A8:  .TEXT   "LIVES PER 1 CREDIT ="     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,000A2h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L46C5:  .TEXT   "DIP SWITCH 28,29"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        LD      B,001h          ; Loop = 1
L46D9:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L46D9           ; Loop for 1 Comm
        PUSH    HL              ; Save HL Register
        LD      HL,000CAh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;---------------------------------------------------- 
L46E5:  .TEXT   "BITS 1, 2 =   "                
        .DB     000h
;----------------------------------------------------
L46F4:  POP     HL              ; Restore HL Register
        LD      A,(0E187h)      ; Get DIP Switches 28-35
L46F8:  AND     003h            ; A = DIP 28 and 29 (# lives)
        ADD     A,003h          ; Add 3 to get total lives (3,4,5,6)
        OR      030h            ; Make number into character
        LD      DE,01603h       ; Location X = 22, Y = 3
        CALL    L2233           ; Print Lives to Text Display
        LD      A,(0E187h)      ; Get DIP Switches 28-35
        RRC     A               ; Shift A Right Circular
        AND     001h            ; Turn on bit 1
        LD      DE,00E05h       ; Location X = 14, Y = 5 
        OR      030h            ; Make number into character
        CALL    L2233           ; Print one Character to Text Display
        LD      A,(0E187h)      ; Get DIP Switches 28-35
        AND     001h            ; Turn on bit 1
        OR      030h            ; Make number into character
        CALL    L2256           ; Print A to Text Display

L471D:  LD      B,001h          ; Loop = 1
L471F:  CALL    L2353           ; Wait for Comm Ready 
        DJNZ    L471F           ; Loop for 1 Comm

        PUSH    HL              ; Save HL Register
        LD      HL,00169h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L472B:  .TEXT   "DIP SW. 4,5,6,7"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00191h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4743:  .TEXT   "BITS 1234 ="
        .DB     000h
;----------------------------------------------------     
        POP     HL              ; Restore HL Register

        LD      B,001h          ; Loop = 1
L4752:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L4752           ; Loop for 1 Comm        

        PUSH    HL              ; Save HL Register
        LD      HL,00140h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;---------------------------------------------------- 
L475E:  .TEXT   "DIFFICULTY =   "                
        .DB     000h
;---------------------------------------------------- 
L476E:  POP     HL              ; Restore HL Register
        LD      A,(0E190h)      ; Get DIP Switches 4-11
        AND     00Fh            ; Get Window Move Time
        CALL    L22AA           ; Convert Window Move Time into decimal
        LD      (HL),A          ; Save Window Move Byte
        LD      DE,00D08h       ; Cursor Position (X=13,Y=8)
        CALL    L225D           ; Print 2-Digit Number

        LD      B,001h          ; Loop = 1
L4780:  CALL    L2353           ; Wait for Comm Ready
L4783:  DJNZ    L4780           ; Loop for 1 Comm       

        LD      A,(0E190h)      ; Get DIP Switches 4-11
        RRC     A               ; Get Switch 7
        RRC     A               ; Get Switch 7
L478C:  RRC     A               ; Get Switch 7
        AND     001h            ; Isolate Switch 7
        OR      030h            ; Make number into character
        LD      DE,00D0Ah       ; Cursor Position (X=13,Y=10)
        CALL    L2233           ; Print one Character to Text Display

        LD      A,(0E190h)      ; Get DIP Switches 4-11
        RRC     A               ; Get Switch 6
        RRC     A               ; Get Switch 6
        AND     001h            ; Isolate Switch 6
        OR      030h            ; Make number into character A
        CALL    L2256           ; Print A to Text Display

        LD      A,(0E190h)      ; Get DIP Switches 4-11
        RRC     A               ; Get Switch 5
        AND     001h            ; Isolate Switch 5
        OR      030h            ; Make number into character A
        CALL    L2256           ; Print A to Text Display

        LD      A,(0E190h)      ; Get DIP Switches 4-11
        AND     001h            ; Get Switch 4
        OR      030h            ; Make number into character A
        CALL    L2256           ; Print A to Text Display

        LD      B,001h          ; Loop = 1
L47BE:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L47BE           ; Loop for 1 Comm

        PUSH    HL              ; Save HL Register
        LD      HL,0017Ch       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L47CA:  .TEXT   "DIP SW. 8,9,10,11"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register

        PUSH    HL              ; Save HL Register
        LD      HL,001A4h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L47E4:  .TEXT   "BITS 1234 ="
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register

        LD      B,001h          ; Loop = 1
L47F3:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L47F3           ; Loop for 1 Comm

        PUSH    HL              ; Save HL Register
        LD      HL,00153h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L47FF:  .TEXT   "HINTS =     "                
        .DB     000h
;----------------------------------------------------
L480C:  POP     HL              ; Restore HL Register
        LD      A,(0E190h)      ; Get DIP Switches 4-11
        RRC     A               ; Get Switches 8-11
        RRC     A               ; Get Switches 8-11
        RRC     A               ; Get Switches 8-11
        RRC     A               ; Get Switches 8-11
        AND     00Fh            ; Isolate Switches 8-11
        CALL    L22AA           ; Convert hex byte into decimal byte
        LD      (HL),A          ; Number = switches
        LD      DE,01B08h       ; Cursor Position (X=27,Y=8) 
        CALL    L225D           ; Print 2-Digit Number

        LD      B,001h          ; Loop = 1
L4826:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L4826           ; Loop for 1 Comm

        LD      A,(0E190h)      ; Get DIP Switches 4-11
        RRC     A               ;
        RRC     A               ;
        RRC     A               ;
        RRC     A               ;
        RRC     A               ;
        RRC     A               ;
        RRC     A               ;
        AND     001h            ;
        OR      030             ;
        LD      DE,0200Ah       ;
L4843:  CALL    L2233           ; Print one Character to Text Display

        LD      A,(0E190h)      ; Get DIP Switches 4-11
        RRC     A               ;
        RRC     A               ;
        RRC     A               ;
        RRC     A               ;
        RRC     A               ;
        RRC     A               ;
        AND     001h            ;
        OR      030h            ;
        CALL    L2256           ; Print A to Text Display

        LD      A,(0E190h)      ; Get DIP Switches 4-11
        RRC     A               ;
        RRC     A               ;
        RRC     A               ;
        RRC     A               ;
        RRC     A               ;
        AND     001h            ;
        OR      030h            ;
        CALL    L2256           ;
        LD      A,(0E190h)      ; Get DIP Switches 4-11
        RRC     A
        RRC     A
        RRC     A
        RRC     A
        AND     001h
        OR      030h
        CALL    L2256

        LD      B,001h          ; Loop = 1
L4884:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L4884           ; Loop for 1 Comm

        PUSH    HL              ; Save HL Register
        LD      HL,00209h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
        LD      D,E
        LD      B,L
        LD      D,D
        LD      D,(HL)
        LD      C,C
        LD      B,E
        LD      B,L
        JR      NZ,L48EC                
        LD      D,A
        LD      C,C
        LD      D,H
        LD      B,E
        LD      C,B
        LD      B,L
        LD      D,E
        .DB     000h     
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00232h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
        LD      (HL),E
        LD      H,L
        LD      (HL),D
        HALT    
        LD      L,C
        LD      H,E
        LD      H,L
        JR      NZ,L491B               
        LD      L,(HL)
        LD      H,H
        LD      H,L
        LD      A,B
        JR      NZ,L48F5                
        JR      NZ,L48BA                
        .DB     000h
;----------------------------------------------------
L48BA:  POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0025A        ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
        LD      (HL),E
        LD      (HL),A
        LD      L,C
        LD      (HL),H
        LD      H,E
        LD      L,B
        JR      NZ,L493E                
        LD      H,L
        LD      (HL),E
        LD      (HL),H
        JR      NZ,L48EF              
        JR      NZ,L490E                
        JR      NZ,L48D3                
        .DB     000h
;----------------------------------------------------
L48D3:  POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00282        ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
        LD      H,(HL)
        LD      (HL),D
        LD      H,L
        LD      H,L
        JR      NZ,L4951                
        LD      L,H
        LD      H,C
        LD      A,C
        JR      NZ,L4906              
        JR      NZ,L4908              
        JR      NZ,L4927                
        JR      NZ,L48EC                
        .DB     000h
;----------------------------------------------------
L48EC:  POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,002AAh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
        LD      L,C

L48F5:  LD      L,L
        LD      L,L
        LD      L,A
        LD      (HL),D
        LD      (HL),H
        LD      H,C
        LD      L,H
        LD      L,C
        LD      (HL),H
        LD      A,C
        JR      NZ,L4921              
        JR      NZ,L4940                
        JR      NZ,L4905                
        .DB     000h
;----------------------------------------------------
L4905:  POP     HL              ; Restore HL Register
L4906:  PUSH    HL              ; Save HL Register
        LD      HL,002D2h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
        LD      H,H
L490E:  LD      L,C
        LD      (HL),E
        LD      H,E
        JR      NZ,L4987                
        LD      H,L
        LD      (HL),E
        LD      (HL),H
        JR      NZ,L4938              
        JR      NZ,L493A              
        JR      NZ,L4959                
        JR      NZ,L491E                
        .DB     000h
;----------------------------------------------------
L491E:  POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,002FAh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
        LD      H,C

L4927:  LD      (HL),H
        LD      (HL),H
        LD      (HL),D
        LD      H,C
        LD      H,E
        LD      (HL),H
        JR      NZ,L49A2                
        LD      L,A
        LD      (HL),L
        LD      L,(HL)
        LD      H,H
        JR      NZ,L4972                
        JR      NZ,L4937                
        .DB     000h
;----------------------------------------------------
L4937:  POP     HL              ; Restore HL Register
L4938:  PUSH    HL              ; Save HL Register
        LD      HL,00322h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
        LD      (HL),B

L4940:  LD      L,H
        LD      H,C
        LD      A,C
        JR      NZ,L49B7                
        LD      H,C
        LD      L,(HL)
        LD      H,H
        LD      L,A
        LD      L,L
        JR      NZ,L496C              
        JR      NZ,L498B                
        JR      NZ,L4950                
        .DB     000h
;----------------------------------------------------
L4950:  POP     HL              ; Restore HL Register

L4951:  LD      B,001h          ; Loop = 1
L4953:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L4953           ; Loop for 1 Comm

        LD      DE,0120Eh
        LD      A,(0E18Dh)      ; Get DIP Switches 12-19
        AND     001h
        CALL    L49A9
        INC     E
        LD      A,(0E18Dh)      ; Get DIP Switches 12-19
        AND     002h
        CALL    L49A9

L496C:  INC     E
        LD      A,(0E18Dh)      ; Get DIP Switches 12-19
        AND     004h

L4972:  CALL    L49A9
        INC     E
        LD      A,(0E18Dh)      ; Get DIP Switches 12-19
        AND     008h
        CALL    L49A9
        INC     E
        LD      A,(0E18Dh)      ; Get DIP Switches 12-19
        AND     010h
        CALL    L49A9

L4987:  INC     E
        LD      A,(0E18Dh)      ; Get DIP Switches 12-19

L498B:  AND     020h
        CALL    L49A9
        INC     E
        LD      A,(0E18Dh)      ; Get DIP Switches 12-19
        AND     040h
        CALL    L49A9

        LD      B,001h          ; Loop =1
L499B:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L499B           ; Loop for 1 Comm

        CALL    L49C9           ; Print "Player2 = Exit"
        CALL    L42B9           ; Process Service Mode User Input
        JP      L466B           ;



;----------------------------------------------------
;               Printing Subroutine
;----------------------------------------------------
L49A9:  JR      Z,L49BB         ;       
        LD      A,020h          ; A = Character space
        CALL    L2233           ; Print one Character to Text Display
        LD      A,04Fh          ;
        CALL    L2256           ; Print A to Text Display
        LD      A,04Eh          ;
L49B7:  CALL    L2256           ;
        RET                     ; Return






;----------------------------------------------------
;
;----------------------------------------------------
L49BB:  LD      A,04Fh
        CALL    L2233           ; Print one Character to Text Display
        LD      A,046h
        CALL    L2256           ; Print A to Text Display
        CALL    L2256           ; Print A to Text Display
        RET     







;----------------------------------------------------
;            Print "Player2 = Exit"
;----------------------------------------------------
L49C9:  PUSH    HL              ; Save HL Register
        LD      HL,003A4h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L49D0: .TEXT   "player 2 = exit"
        .DB   000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        RET                     ; Return




 



;----------------------------------------------------
;            Report Bookkeeping Data
;----------------------------------------------------
L49E2:  LD      A,004h          ; A = 4
        LD      (0E1E5h),A      ;

L49E7:  LD      B,001h          ; Loop = 1
L49E9:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L49E9           ; Loop for 1 Comm

        CALL    L245B           ; Get ALL Input Data

        LD      B,001h          ; Loop = 1
L49F3:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L49F3           ; Loop for 1 Comm

        PUSH    HL              ; Save HL Register
        LD      HL,0002Eh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L49FF: .TEXT   "SERVICE MODE 01: BOOKKEEPING"
        .DB   000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,000C9h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4A24:  .TEXT   "TOTAL PLAYS"
        .DB   000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        LD      DE,01905h       ; Location X = 25, Y = 5
        LD      HL,0E0A0h       ; Number = Total Plays
        CALL    L2265           ; Print 6-digit number
        PUSH    HL              ; Save HL Register
        LD      HL,00119h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4A41:  .TEXT   "LEFT CHUTE"
        .DB   000h
;---------------------------------------------------- 
        POP     HL              ; Restore HL Register
        LD      DE,01B07h       ; Location X = 27, Y = 7
        LD      HL,0E0A3h       ; Number = Left Slot Coin Total
        CALL    L2261           ; Print 4-digit number
        PUSH    HL              ; Save HL Register
        LD      HL,00169h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4A5D:  .TEXT   "RIGHT CHUTE"
        .DB   000h
;----------------------------------------------------     
        POP     HL              ; Restore HL Register
        LD      DE,01B09h       ; Location X = 27,Y = 9
        LD      HL,0E0A5h       ; Number = Right Slot Coin Total
        CALL    L2261           ; Print 4-digit number
        LD      B,001h          ; Loop = 1
L4A75:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L4A75           ; Loop for 1 Comm
        PUSH    HL              ; Save HL Register
L4A7B:  LD      HL,001B9h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4A81:  .TEXT   "TOTAL SECONDS PLAYED"
        .DB   000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        LD      DE,0190Bh       ; Location X = 25,Y = 11
        LD      HL,0E0A8h       ; Number = Total Seconds Played
        CALL    L2265           ; Print 6-digit number
        PUSH    HL              ; Save HL Register
        LD      HL,00209h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4AA7:  .TEXT   "LONG GAME SECONDS"
        .DB   000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        LD      DE,0190Dh       ; Location X = 25, Y = 13
        LD      HL,0E0ABh       ; Number = Long Game Seconds
        CALL    L2265           ; Print 6-digit number
        PUSH    HL              ; Save HL Register
        LD      HL,00259h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4ACA:  .TEXT   "SHORT GAME SECONDS"
        .DB   000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register

        LD      DE,01D0Fh       ; Location X = 29, Y = 15
        LD      HL,0E0AEh       ; Number = Short Game Seconds
        CALL    L225D           ; Print 2-digit number

        LD      B,001h          ; Loop = 1
L4AE9:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L4AE9           ; Loop for 1 Comm

        PUSH    HL              ; Save HL Register
        LD      HL,002A9h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4AF5:  .TEXT   "HIGHEST GAME SCORE"
        .DB   000h
;----------------------------------------------------   
        POP     HL              ; Restore HL Register

        LD      DE,01711h       ; Location X = 23, Y = 17
        LD      HL,0E003h       ; Number = Highest Score 
        CALL    L2269           ; Print 8-digit number

        PUSH    HL              ; Save HL Register
        LD      HL,002F9h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4B19:  .TEXT   "HIGHEST SCENE"
        .DB   000h
;----------------------------------------------------  
        POP     HL              ; Restore HL Register

        LD      DE,01D13h       ; Location X = 29, Y = 19
        LD      HL,0E0AFh       ; Number = Highest Scene
        CALL    L225D           ; Print 2-digit number

        CALL    L4B8A           ; Print Bookkeeping Instructions
        CALL    L42B9           ; Process Service Mode User Input
        LD      HL,0E184h       ; Get ZPU Switches 1 & 2
        BIT     7,(HL)          ; Check switch 2
        JR      Z,L4B4C         ; Not pressed so skip ahead
               
;----------------------------------------------------
;        ZPU Switch 2 pressed so reset data
;----------------------------------------------------
        LD      HL,0E0A7h       ;
        INC     (HL)            ;
        LD      HL,0E0B0h       ;
        INC     (HL)            ;
        CALL    L1627           ; Reset Bookkeeping Data
        CALL    L21FF           ; Clear Text Display

L4B4C:  LD      HL,0E184h       ; Get ZPU Switches 1 & 2
        BIT     6,(HL)          ; Check switch 1
        JR      Z,L4B80         ; Not pressed so skip ahead

;----------------------------------------------------
;     ZPU Switch 1 pressed so erase highest score
;----------------------------------------------------
        LD      BC,00048h       ; 9 High scores to copy (72 bytes)
L4B56:  LD      DE,0E000h       ; Destination = Highest score
        LD      HL,0E008h       ; Source = 2nd High score 
        LDIR                    ; Move all scores up one spot

        EX      DE,HL           ; HL = Lowest Score
        LD      (HL),055h
        INC     HL
        LD      (HL),052h
        INC     HL
        LD      (HL),04Ch
        INC     HL
        LD      (HL),000h
        INC     HL
        LD      (HL),000h
        INC     HL
        LD      (HL),000h
        INC     HL
        LD      (HL),000h
        LD      HL,0E048h       ; Sum bytes
        LD      B,007h          ; 7 bytes to sum
        CALL    L110C           ; Call sum all bytes
        CPL                     ; Reverse all bits
        LD      (HL),A          ; Store sum
        CALL    L21FF           ; Clear Text Display

L4B80:  LD      B,001h          ; Loop = 1
L4B82:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L4B82           ; Loop for 1 Comm        

        JP      L49E7           ; Loop back to Bookkeeping Data





 
;----------------------------------------------------
;           Print Bookkeeping Instructions
;----------------------------------------------------
L4B8A:  PUSH    HL              ; Save HL Register
        LD      HL,00350h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4B91:  .TEXT   "Player 2 = Exit.        "
        .DB   000h
;----------------------------------------------------
L4BAA:  POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00377h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4BB2:  .TEXT   "Switch #1 Clears Hiscores"
        .DB   000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0039Fh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4BD4:  .TEXT   "Switch #2 Clears All Else"
        .DB   000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        RET                     ; Return








;----------------------------------------------------
;                 Sound Test
;----------------------------------------------------
L4BF0:  LD      B,001h          ; Loop = 1
L4BF2:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L4BF2           ; Loop for 1 Comm       
        LD      A,005h          ; Starting Row = 5
        LD      (0E1E6h),A      ; Save Rectangle starting row
        CALL    L4389           ; Draw Rectangle
L4BFF:  LD      A,040h
        LD      (0E1E5h),A

L4C04:  PUSH    HL              ; Save HL Register
        LD      HL,00056h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4C0B:  .TEXT   "SERVICE MODE 05: SOUND TESTS"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,000CCh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4C30:  .TEXT   "GOOD ACTION SOUND        (beep)"
        .DB     000h
;----------------------------------------------------     
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0011Ch       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4C58:  .TEXT   "ANY or BAD  ACTION SOUND (boop)"
        .DB     000h
;----------------------------------------------------     
        POP     HL              ; Restore HL Register
        LD      B,001h          ; Loop = 1
L4C7B:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L4C7B           ; Loop for 1 Comm
        PUSH    HL              ; Save HL Register
        LD      HL,0039Bh       ; Cursor Location
L4C84:  CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4C87:  .TEXT   "Press Player 1 start to make sound"
        .DB     000h
;----------------------------------------------------     
        POP     HL              ; Restore HL Register
        CALL    L42B9           ; Process Service Mode User Input
        CALL    L4CBB           ; Check Button and Sound Correct Beep

        LD      B,00Ah          ; Loop = 10
L4CB3:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L4CB3           ; Loop for 10 Comm's      
          
        JP      L4C04           ; Continue Sound Test




;----------------------------------------------------
;       Check Button and Sound Correct Beep
;----------------------------------------------------
L4CBB:  LD      A,(0E193h)      ; Get Button Data
        BIT     2,A             ; Is PLAYER1/FEET pressed?
        RET     Z               ; Not pressed so leave
        LD      A,(0E1E6h)      ; Get Rectangle location
        CP      005h            ; Is good beep selected?
L4CC6:  CALL    Z,GoodBeep      ; Yes, so sound Good Beep
        LD      A,(0E1E6h)      ; Get Rectangle location
L4CCC:  CP      007h            ; Is bad beep selected?
        CALL    Z,BadBeep       ; Yes, so sound Bad Beep
        RET                     ; Return








;----------------------------------------------------
;         Service Mode 3:  CREDIT ADJUST
;----------------------------------------------------
L4CD2:  XOR     A               ; A = 0
        LD      (0E1E6h),A      ;
        LD      A,010h          ;
        LD      (0E1E5h),A      ;

L4CDB:  CALL    L245B           ; Get ALL Input Data
L4CDE:  PUSH    HL              ; Save HL Register
        LD      HL,0002Dh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4CE5:  .TEXT   "SERVICE MODE 03: CREDIT ADJUST"
        .DB     000h
;----------------------------------------------------     
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00169h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4D0C:  .TEXT   "LEFT CHUTE"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
L4D18:  PUSH    HL              ; Save HL Register
        LD      HL,001BAh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4D1F:  .TEXT   "SWITCH 20, 21"
        .DB     000h
;----------------------------------------------------     
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0020Ah       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4D35:  .TEXT   "COINS:"
        .DB     000h
;----------------------------------------------------     
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0025Ah       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4D44:  .TEXT   "CREDITS:"
        .DB     000h
;----------------------------------------------------     
        POP     HL              ; Restore HL Register
        CALL    L4DD2           ;
        LD      DE,00C0Dh       ;
        OR      030h            ;
        CALL    L2233           ; Print one Character to Text Display
L4D59:  INC     E               ; Move down one row
        INC     E               ; Move down one row
        LD      A,B             ;
        OR      030h            ;
        CALL    L2233           ; Print one Character to Text Display
        PUSH    HL              ; Save HL Register
        LD      HL,0017Dh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4D68:  .TEXT   "RIGHT CHUTE"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,001CEh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4D7C:  .TEXT   "SWITCH 24, 25"
        .DB     000h
;----------------------------------------------------     
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0021Eh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4D92:  .TEXT   "COINS:"
        .DB     000h
;----------------------------------------------------
        PUSH    HL              ; Save HL Register
        LD      HL,0026Eh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4DA1:  .TEXT   "CREDITS:"
        .DB     000h
;----------------------------------------------------
        POP     HL              ;
        LD      A,(0E18Ah)      ; Get DIP Switches 20-27
        RRCA                    ;
        RRCA                    ;
        RRCA                    ;
        RRCA                    ;
L4DB2:  CALL    L4DD5           ;
        LD      DE,0200Dh       ;
        OR      030h            ;
L4DBA:  CALL    L2233           ; Print one Character to Text Display
        INC     E               ; Location Y = Y + 1
        INC     E               ; Location Y = Y + 1
        LD      A,B             ;
        OR      030h            ;
        CALL    L2233           ; Print one Character to Text Display
        CALL    L42B9           ; Process Service Mode User Input

        LD      B,001h          ; Loop = 1
L4DCA:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L4DCA           ; Loop for 1 Comm

        JP      L4CDB           ; Loop back to Credit Adjust






;----------------------------------------------------
;                    Credits?
;      Return A = 
;      Return B = 
;----------------------------------------------------
L4DD2:  LD      A,(0E18Ah)      ; Get DIP Switches 20-27
L4DD5:  AND     003h            ; Get Slot 1 Credits per Coins
        ADD     A,A             ;
        LD      D,000h          ;
        LD      E,A             ;
        LD      HL,04DE3h       ; HL = Credit Table (below)
        ADD     HL,DE           ;
        LD      A,(HL)          ;
        INC     HL              ;
        LD      B,(HL)          ;
        RET                     ; Return



;----------------------------------------------------
;                  Credit Table
;----------------------------------------------------
L4DE3:  .DB   002h, 001h
        .DB   002h, 001h
        .DB   003h, 001h
        .DB   004h, 001h    






;----------------------------------------------------
;          STATISTICS:  Range of Scores
;----------------------------------------------------
L4DEB:
GameStatEntry:
        XOR     A               ; A = 0
        LD      (0E1E6h),A
        LD      A,020h
        LD      (0E1E5h),A
        LD      B,001h          ; Loop = 1
L4DF6:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L4DF6           ; Loop for 1 Comm        

        CALL    L21FF           ; Clear Text Display
        LD      A,0E1h          ; Text = GRAY, Bkgnd = BLACK
        CALL    L20CA           ; Setup Graphics Chip for Text

L4E03:  CALL    L21FF           ; Clear Text Display
        LD      A,0E1h          ; Text = GRAY, Bkgnd = BLACK
        CALL    L20CA           ; Setup Graphics Chip for Text
        PUSH    HL              ; Save HL Register
        LD      HL,00056h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4E12:  .TEXT   "SERVICE MODE 06: STATISTICS"
        .DB   000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
L4E2F:  PUSH    HL              ; Save HL Register
        LD      HL,000ACh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4E36:  .TEXT   "RANGE OF SCORES"
        .DB   000h
;----------------------------------------------------     
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,000F7h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4E4E:  .TEXT   "   0  -  100K"     
        .DB   000h
;---------------------------------------------------- 
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0011Fh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4E64:  .TEXT   " 100K -  200K"
        .DB   000h
;----------------------------------------------------      
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
L4E74:  LD      HL,00147h       ; Cursor Position
L4E77:  CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4E7A:  .TEXT   " 200K -  300K"     
        .DB   000h
;---------------------------------------------------- 
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0016Fh       ; Cursor Position
L4E8D:  CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4E90:  .TEXT   " 300K -  400K"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00197h       ; Cursor Position
L4EA3:  CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4EA6:  .TEXT   " 400K -  500K"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        LD      B,001h          ; Loop = 1
L4EB7:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L4EB7           ; Loop for 1 Comm
        PUSH    HL              ; Save HL Register
        LD      HL,001BFh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4EC3:  .TEXT   " 500K -  600K"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,001E7h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4ED9:  .TEXT   " 600K -  700K"
        .DB     000h
;----------------------------------------------------             
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0020Fh       ; Cursor Position
L4EEC:  CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4EEF:  .TEXT   " 700K -  800K"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00237h       ; Cursor Position
L4F02:  CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4F05:  .TEXT   " 800K -  900K"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register                                           
L4F15:  LD      HL,0025Fh       ; Cursor Position
L4F18:  CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4F1B:  .TEXT   " 900K - 1000K"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
L4F2A:  LD      B,001h          ; Loop = 1
L4F2C:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L4F2C           ; Loop for 1 Comm
        PUSH    HL              ; Save HL Register
        LD      HL,00287h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4F38:  .TEXT   "1000K - 1100K"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
L4F47:  PUSH    HL              ; Save HL Register
        LD      HL,002AFh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4F4E:  .TEXT   "1100K - 1200K"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,002D7h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4F64:  .TEXT   "1200K - 1300K"     
        .DB     000h
;----------------------------------------------------
L4F72:  POP     HL              ; Restore HL Register
L4F73:  PUSH    HL              ; Save HL Register
        LD      HL,002FFh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4F7A:  .TEXT   "1300K - 1400K"     
        .DB     000h
;----------------------------------------------------
L4F88:  POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00327h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4F90:  .TEXT   "1400K + "                
        .DB     000h
;----------------------------------------------------
L4F99:  POP     HL              ; Restore HL Register
        LD      B,001h          ; Loop = 1
L4F9C:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L4F9C           ; Loop for 1 Comm
        CALL    L533E           ; Print Service Mode Instructions

        LD      DE,01606h       ; Location X = 22, Y = 6
        LD      HL,0E0B1h       ; Start of Number = Score Ranges
        LD      B,00Fh          ; Loop = 15 Score Ranges to print
L4FAC:  CALL    L2261           ; Print 4-digit number
        INC     E               ; Move down one row
        DJNZ    L4FAC           ; Print all 15 Score Ranges
               
        CALL    L52DF           ; Is PLAYER1 button pressed?
        JR      NZ,L4FCA        ; Pressed, so show Range of Times

        CALL    L5305           ; Check ZPU Switch 2
        LD      HL,0E0CFh       ; HL = Bookkeeping Counter
        CALL    NZ,L5312        ; Pressed, so Print Blank Statistics screen

        LD      B,001h          ; Loop = 1
L4FC2:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L4FC2           ; Loop for 1 Comm

        JP      L4E2F           ; Loop back and show Range of Scores







;----------------------------------------------------
;          STATISTICS:  Range of Times
;----------------------------------------------------
L4FCA:  CALL    L21FF           ; Clear Text Display
        PUSH    HL              ; Save HL Register
        LD      HL,00056h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4FD4:  .TEXT   "SERVICE MODE 06: STATISTICS"
        .DB     000h
;----------------------------------------------------     
        POP     HL              ; Restore HL Register
L4FF1:  PUSH    HL              ; Save HL Register
        LD      HL,000ACh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L4FF8:  .TEXT   "RANGE OF TIMES "
        .DB     000h
;----------------------------------------------------                
L5008:  POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,000F7h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L5010:  .TEXT   " 0     -  1 MIN"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0011Fh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L5028:  .TEXT   " 1 MIN -  2 MIN"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
L5039:  PUSH    HL              ; Save HL Register
L503A:  LD      HL,00147        ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L5040:  .TEXT   " 2 MIN -  3 MIN"
        .DB     000h
;----------------------------------------------------     
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
L5052:  LD      HL,0016Fh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L5058:  .TEXT   " 3 MIN -  4 MIN"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
L506A:  LD      HL,00197h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L5070:  .TEXT   " 4 MIN -  5 MIN"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        LD      B,001h          ; Loop = 1
L5083:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L5083           ; Loop for 1 Comm
        PUSH    HL              ; Save HL Register
        LD      HL,001BFh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L508F:  .TEXT   " 5 MIN -  6 MIN"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,001E7h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L50A7:  .TEXT   " 6 MIN -  7 MIN"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
L50B9:  LD      HL,0020Fh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L50BF:  .TEXT   " 7 MIN -  8 MIN"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
L50D1:  LD      HL,00237h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L50D7:  .TEXT   " 8 MIN -  9 MIN"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
L50E9:  LD      HL,0025Fh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L50EF:  .TEXT   " 9 MIN - 10 MIN"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        LD      B,001h          ; Loop  = 1
L5102:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L5102           ; Loop for 1 Comm
        PUSH    HL              ; Save HL Register
        LD      HL,00287h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L510E:  .TEXT   "10 MIN - 11 MIN"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,002AFh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L5126:  .TEXT   "11 MIN - 12 MIN"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,002D7h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L513E:  .TEXT   "12 MIN - 13 MIN"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,002FFh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L5156:  .TEXT   "13 MIN - 14 MIN"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00327h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L516E:  .TEXT   "14 MIN ++"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
L5179:  LD      B,001h          ; Loop = 1
L517B:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L517B           ; Loop for 1 Comm        
        CALL    L533E           ; Print Service Mode Instructions

        LD      HL,0E0D0h       ; Start Number = Range of Times
        LD      B,00Fh          ; Loop = 15 Time Ranges
        LD      DE,01606h       ; Location X = 22, Y = 6
L518B:  CALL    L2261           ; Print 4-digit number
        INC     E               ; Move down one row
        DJNZ    L518B           ; Loop until all Time Ranges printed

L5191:  CALL    L52DF           ; Is PLAYER1 Button Pressed?
        JR      NZ,L51A9        ; Yes, so goto Range of Scenes        

        CALL    L5305           ; Check ZPU Switch 2
        LD      HL,0E0EEh       ; HL = Bookkeeping Counter (Range of Times)
        CALL    NZ,L5312        ; Pressed, so Print Blank statistics screen

        LD      B,001h          ; Loop = 1
L51A1:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L51A1           ; Loop for 1 Comm        
        JP      L4FF1           ; Continue Loop on Range of Times







;----------------------------------------------------
;          STATISTICS:  Range of Scenes
;----------------------------------------------------
L51A9:  CALL    L21FF           ; Clear Text Display
        LD      B,001h          ; Loop = 1
L51AE:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L51AE           ; Loop for 1 Comm        
        PUSH    HL              ; Save HL Register
        LD      HL,00056h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L51BA:  .TEXT   "SERVICE MODE 06: STATISTICS"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
L51D7:  PUSH    HL              ; Save HL Register
        LD      HL,000ACh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L51DE: .text "RANGE OF SCENES"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,000F7h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L51F6:  .TEXT   "   1ST   SCENE"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,0011Fh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L520D:  .TEXT   "   2ND   SCENE"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
L521E:  LD      HL,00147h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L5224:  .TEXT   "   3RD   SCENE"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
L5234:  PUSH    HL              ; Save HL Register
L5235:  LD      HL,0016Fh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L523B:  .TEXT   "   4TH   SCENE"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        LD      B,001h          ; Loop = 1                     
L524D:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L524D           ; Loop for 1 Comm        
        PUSH    HL              ; Save HL Register
L5253:  LD      HL,00197h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L5259:  .TEXT   "   5TH   SCENE"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
L526A:  LD      HL,001BFh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L5270:  .TEXT   "   6TH   SCENE"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
L5281:  LD      HL,001E7h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L5287:  .TEXT   "   7TH   SCENE"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
L5298:  LD      HL,0020Fh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L529E:  .TEXT   "   8TH   SCENE"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        LD      B,001h          ; Loop = 1
L52B0:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L52B0           ; Loop for 1 Comm        
        CALL    L533E           ; Print Service Mode Instructions

        LD      HL,0E0EFh       ; HL = Start of Scene Totals
        LD      B,008h          ; 8 Scene Totals
        LD      DE,01606h       ; Location X = 32, Y = 6
L52C0:  CALL    L2261           ; Print 4-digit number
        INC     E               ; Move down one row
        DJNZ    L52C0           ; Loop until all 8 Scene Totals are printed
                
L52C6:  CALL    L52DF           ; Is PLAYER1 Button pressed?
        JP      NZ,L4E03        ; Yes, so show Range of Scores

        CALL    L5305           ; Check ZPU Switch 2
        LD      HL,0E10Dh       ; HL = Bookkeeping Counter
        CALL    NZ,L5312        ; Pressed, so Print Blank statistics screen

        LD      B,001h          ; Loop = 1 
L52D7:  CALL    L2353           ; Wait for Comm Ready
L52DA:  DJNZ    L52D7           ; Loop for 1 Comm

        JP      L51D7           ; Loop back to print Range of Scenes







;----------------------------------------------------
;            Check PLAYER1 button
;        Return  Z = PLAYER1 not pressed  
;               NZ = PLAYER1 pressed
;----------------------------------------------------
L52DF:  CALL    L245B           ; Get ALL Input Data
        LD      A,(0E18Ch)      ; Get DIP Switches 12-19
        BIT     0,A             ; Check Service Mode
        JP      Z,L0604         ; Disabled, so begin game

        LD      B,002h          ; Loop = 2
L52EC:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L52EC           ; Loop for 2 Comm's
            
        LD      A,(0E193h)      ; Get Button Data
        BIT     3,A             ; Is PLAYER2/FEET pressed?
        JP      NZ,L40FE        ; Yes, so go to Service Mode

        LD      A,(0E192h)      ; Get Button Data
        BIT     2,A             ; Is PLAYER1/FEET pressed?
        RET     Z               ; No, so return
        RES     2,A             ; Clear PLAYER1/FEET button
        LD      (0E192h),A      ; Save Button Data
        RET                     ; Return







;----------------------------------------------------
;              Check ZPU Switch 2
;       Return Z = Not pressed, NZ = Pressed
;----------------------------------------------------
L5305:  LD      B,001h          ; Loop = 1
L5307:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L5307           ; Loop for 1 Comm        
        LD      A,(0E184h)      ; Get ZPU Switches 1 & 2
        BIT     7,A             ; Check ZPU Switch 2
        RET                     ; Return







;---------------------------------------------------- 
;           Print Statistics Blank Screen
;        HL = Bookkeeping Counter
;---------------------------------------------------- 
L5312:  INC     (HL)            ; Increment Bookkeeping Counter
        CALL    L1627           ; Reset Bookkeeping Data
        CALL    L21FF           ; Clear Text Display
        PUSH    HL              ; Save HL Register
        LD      HL,00056h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;---------------------------------------------------- 
L5320:  .TEXT   "SERVICE MODE 06: STATISTICS"
        .DB   000h
;---------------------------------------------------- 
        POP     HL              ; Restore HL Register
        RET                     ; Return







;---------------------------------------------------- 
;          Print Service Mode Instructions
;----------------------------------------------------
L533E:  LD      B,001h          ; Loop = 1
L5340:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L5340           ; Loop for 1 Comm
        PUSH    HL              ; Save HL Register
        LD      HL,00350h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L534C:  .TEXT   "Player 1 = More Info.   "
        .DB   000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        PUSH    HL              ; Save HL Register
        LD      HL,00378h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L536D:  .TEXT   "Player 2 = Exit.        "
        .DB   000h
;----------------------------------------------------            
L5386:  POP     HL              ; Save HL Register
        PUSH    HL              ; Restore HL Register
        LD      HL,003A0h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------   
L538E:  .TEXT   "Switch #2 on ZPU = CLEAR"
        .DB   000h
;----------------------------------------------------    
L53A7:  POP     HL              ; Restore HL Register
        RET                     ; Return








;----------------------------------------------------
;                unknown
;----------------------------------------------------
L53A9:  PUSH    IY              ; Save IY Register
        PUSH    DE              ; Save DE Register
        PUSH    BC              ; Save BC Register
        CALL    L236C           ;
        CALL    L22F5           ; Program Graphics Chip 
        CALL    L21FF           ; Clear Text Display
        POP     BC              ; Restore BC Register
        POP     DE              ; Restore DE Register
        POP     IY              ; Restore IY Register
        RET                     ; Return






;----------------------------------------------------
;          Show Score or Programmer's Names
;----------------------------------------------------
L53BB:  PUSH    IY              ; Save IY Register
        PUSH    DE              ; Save DE Register
L53BE:  PUSH    BC              ; Save BC Register
        CALL    L2392           ;
        CALL    L22F5           ; Program Graphics Chip
        LD      A,0F4h          ; Text = WHITE, Bkgnd = DK_BLUE
        CALL    L20CA           ; Setup Graphics Chip for Text
        CALL    L21FF           ; Clear Text Display
        LD      A,(0E126h)      ; Get Control Register
        BIT     0,A             ;

        PUSH    AF              ; Save AF Register
        CALL    Z,L55FA         ; Game on so, Print Player Score and Lives
        POP     AF              ; Restore AF Register

        CALL    NZ,L56C0        ; Game over, so show Programmer Names
        LD      A,(0E126h)      ; Get Control Register
L53DD:  BIT     2,A             ;
        JP      NZ,L53F5        ; So skip rectangles
;----------------------------------------------------
;            Draw 5 Programmed Rectangles
;----------------------------------------------------
        LD      C,000h          ; Start loop at 0
L53E4:  LD      A,C             ; A = Rectangle # C
L53E5:  CALL    L575D           ; Draw programmed rectangle

        LD      B,005h          ; Loop = 5
L53EA:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L53EA           ; Loop for 5 Comm's        

        INC     C               ; Next Rectangle #
        LD      A,C             ; A = Rectangle #
        CP      005h            ; Is this the fifth rectangle?
        JR      C,L53E4         ; No, so loop back and draw rectangle
                
L53F5:  POP     BC              ; Restore BC Register
L53F6:  POP     DE              ; Restore DE Register
        POP     IY              ; Restore IY Register
        RET                     ; Return






;----------------------------------------------------
;                   Tilt Check
;----------------------------------------------------
L53FA:  LD      A,(0E15Ah)      ; Get Tilted Latch
        OR      A               ; Check if machine has been tilted
        JR      Z,L5430         ; Machine not tilted, do next check         

        PUSH    HL              ; Save HL Register
        LD      HL,0020Ch       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L5407   .TEXT   "Y O U ' V E   T I L T E D   M E!"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        XOR     A               ; A = 0
        LD      (0E15Ah),A      ; Reset Tilted Latch
        JP      L5591           ; Continue Hint Routine





;----------------------------------------------------
;            Check for Correct Move Hint
;----------------------------------------------------
L5430:  LD      A,(0E186h)      ; Get DIP Switches 28-35
        RLCA                    ; Get Switches 34-35
L5434:  RLCA                    ; Get Switches 34-35
L5435:  AND     003h            ; Isolate Switches 34-35
        JR      Z,L5440         ;        
        LD      B,A             ;
        LD      A,(0E1B7h)      ;
        CP      B               ;
        JR      NC,L546C        ;        

L5440:  PUSH    HL              ; Save HL Register
        LD      HL,0020Ch       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L5447   .TEXT   "Y O U ' V E   B L O W N   I T  !"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        JP      L5591           ; Continue Hint Routine
 






;----------------------------------------------------
;           Reveal Hint of correct move
;----------------------------------------------------
L546C:  LD      IY,(0E1B1h)     ;   
L5470:  LD      A,(IY+001h)     ; A = Hint for Move
        BIT     0,A             ; Test for LEFT move 
L5475:  JP      NZ,L553C        ; Print "Should have gone LEFT!"
        BIT     1,A             ; Test for DOWN move
        JP      NZ,L5510        ; Print "Should have gone DOWN!"
        BIT     2,A             ; Test for RIGHT move 
        JP      NZ,L5568        ; Print "Should have gone RIGHT!"
        BIT     3,A             ; Test for UP move
        JP      NZ,L54E4        ; Print "Should have gone UP!"
        BIT     4,A             ; Test for FEET move
        JP      NZ,L54B8        ; Print "Should have used your FEET!"



;----------------------------------------------------
;    Print Hint:  "Should have used your HAND!"
;----------------------------------------------------
        PUSH    HL              ; Save HL Register
        LD      HL,0020Ch       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L5493:  .TEXT   "   SHOULD HAVE USED YOUR HAND  !"
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
L54B5:  JP      L5591           ; Continue Hint Routine






;----------------------------------------------------
;     Print Hint:  "Should have used your FEET!"
;----------------------------------------------------
L54B8:  PUSH    HL              ; Save HL Register
        LD      HL,0020Ch       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L54BF:  .TEXT   "   SHOULD HAVE USED YOUR FEET  !"
        .DB     000h
;----------------------------------------------------
L54E1:  JP      L5591           ; Continue Hint Routine






;----------------------------------------------------
;        Print Hint:  "Should have gone UP!"
;----------------------------------------------------
L54E4:  PUSH    HL              ; Save HL Register
        LD      HL,0020Ch       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L54EB:  .TEXT   "      SHOULD HAVE GONE UP  !    "   
        .DB     000h
;----------------------------------------------------  
        POP     HL              ; Restore HL Register
L550D:  JP      L5591           ; Continue Hint Routine






;----------------------------------------------------
;       Print Hint:  "Should have gone DOWN!"
;----------------------------------------------------
L5510:  PUSH    HL              ; Save HL Register
L5511:  LD      HL,0020Ch       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L5517:  .TEXT   "      SHOULD HAVE GONE DOWN  !  "     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
L5539:  JP      L5591           ; Continue Hint Routine
  




;----------------------------------------------------
;        Print Hint:  "Should have gone LEFT!"
;----------------------------------------------------
L553C:  PUSH    HL              ; Save HL Register
L553D:  LD      HL,0020Ch       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L5543:  .TEXT   "      SHOULD HAVE GONE LEFT  !  "     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
L5565:  JP      L5591           ; Continue Hint Routine





;----------------------------------------------------
;      Print Hint:  "Should have gone RIGHT!"
;----------------------------------------------------
L5568:  PUSH    HL              ; Save HL Register
L5569:  LD      HL,0020Ch       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L556F:  .TEXT   "      SHOULD HAVE GONE RIGHT  ! "
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register



;----------------------------------------------------
;             Continue Hint Routine
;----------------------------------------------------
L5591:  LD      HL,L55D2        ; HL = Start
        PUSH    DE              ;
L5595:  EX      DE,HL           ; DE = String
        LD      HL,000F0h       ;
L5599:  LD      A,028h          ; A = 40 characters to print
        CALL    L2224           ; Print text of length A
        POP     DE              ;
        LD      HL,055D2h       ;
        PUSH    DE              ;
        EX      DE,HL           ; DE = String
        LD      HL,00280h       ;
L55A7:  LD      A,028h          ; A = 40 characters to print
        CALL    L2224           ; Print text of length A
        POP     DE              ;
L55AD:  LD      HL,L55C9        ; Point to Color Table
L55B0:  LD      A,(HL)          ;
        OR      A               ;
        JR      Z,L55C6         ;        
        LD      (0E136h),A      ; Set Color
        PUSH    HL              ; Save HL Register
        CALL    L22F5           ; Program Graphics Chip
        LD      B,003h          ; Loop = 3
L55BD:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L55BD           ; Loop for 3 Comm's        
        POP     HL              ; Restore HL Register
        INC     HL              ;
        JR      L55B0           ;        
L55C6:  JP      L569D           ;




;----------------------------------------------------
;          Color Flash Data
;----------------------------------------------------
L55C9:  .DB   0F4h
        .DB   0F6h
        .DB   04Fh
        .DB   06Fh
        .DB   0F4h
        .DB   0F6h
        .DB   0F4h
        .DB   0F6h
        .DB   000h  ; end  





;----------------------------------------------------
;
;----------------------------------------------------
L55D2:  .DB   080h, 080h, 080h, 080h, 080h, 080h, 080h, 080h 
        .DB   080h, 080h, 080h, 080h, 080h, 080h, 080h, 080h 
        .DB   080h, 080h, 080h, 080h, 080h, 080h, 080h, 080h 
        .DB   080h, 080h, 080h, 080h, 080h, 080h, 080h, 080h 
        .DB   080h, 080h, 080h, 080h, 080h, 080h, 080h, 080h  







;----------------------------------------------------
;            Print Player Score and Lives
;----------------------------------------------------
L55FA:  PUSH    HL              ; Save HL Register
        LD      HL,00177h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L5601:  .TEXT   "PLAYER #  "     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        LD      A,(0E1A9h)      ; Get Player Number
        AND     003h            ; Isolate first 2 bits
        OR      030h            ; Create printable number
        CALL    L2256           ; Print A to Text Display

        LD      A,(0E126h)      ; Get Control Register 
        BIT     2,A             ;
        JP      NZ,L53FA        ; Do Tilt Check

        LD      A,(0E1AEh)      ; Get Lives Remaining
        LD      B,A             ; B = Lives Remaining
        LD      A,(0E157h)      ; Get Starting # of Lives
        CP      B               ; Is this the first lift?
        JP      Z,L569E         ; Yes, so print "GOOD LUCK!"

        PUSH    HL              ; Save HL Register
L562B:  LD      HL,001E7h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L5631: .TEXT   "YOUR SCORE IS "                
       .DB     000h
;----------------------------------------------------
L5640:  POP     HL              ; Restore HL Register
        LD      HL,0E1AAh       ; Number = Score
        LD      DE,0150Ch       ; Location X = 21, Y = 12
        CALL    L2269           ; Print 8-digit number
        PUSH    HL              ; Save HL Register
        LD      HL,00237h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text            
;----------------------------------------------------
L5651:  .TEXT   "You have   "                
        .DB     000h
;----------------------------------------------------
L565D:  POP     HL              ; Restore HL Register
        LD      DE,0100Eh       ; Location X = 16, Y = 14
        LD      A,(0E1AEh)      ; A = Lives Remaining
        LD      HL,0E137h       ; Number = ?
        CALL    L225D           ; Print 2-digit number
        LD      A,(0E1AEh)      ; Get Lives Remaining
        CP      001h            ; Is there just one life left?
        JP      Z,L5689         ; Yes so print singular 'life'
        PUSH    HL              ; Save HL Register
        LD      HL,00245h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L567A:  .TEXT   "lives left"
        .DB     000h
;----------------------------------------------------             
        POP     HL              ; Restore HL Register
L5686:  JP      L569D           ; Jump to Return




;----------------------------------------------------
;              Print "life left"
;----------------------------------------------------
L5689:  PUSH    HL              ; Save HL Register
L568A:  LD      HL,00244h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L5690:  .TEXT   " life left."
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
L569D:  RET                     ; Return






;----------------------------------------------------
;                Print "GOOD LUCK!"
;----------------------------------------------------
L569E:  PUSH    HL              ; Save HL Register
        LD      HL,00210h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L56A5:  .TEXT   "G O O D   L U C K  ! ! !"     
        .DB     000h
;----------------------------------------------------
L56BE:  POP     HL              ; Restore HL Register
        RET                     ; Return








        
;----------------------------------------------------
;            Show Programmer Names
;----------------------------------------------------
L56C0:  PUSH    HL              ; Save HL Register
        LD      HL,00120h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L56C7:   .TEXT   "Designed & Programmed By"
         .DB     000h
;----------------------------------------------------     
        POP     HL              ; Restore HL Register
        CALL    Delay100000     ; Call Delay 100,000
        PUSH    HL              ; Save HL Register
        LD      HL,0019Bh       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L56EB:  .TEXT   "PAUL M. RUBENSTEIN"
         .DB     000h
;----------------------------------------------------
L56FE:  POP     HL              ; Restore HL Register
        CALL    Delay10000      ; Delay 10,000
        PUSH    HL              ; Save HL Register
L5703:  LD      HL,001EAh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L5709:   .TEXT   "   BOB KOWALSKI    "              
         .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        CALL    Delay10000      ; Delay 10,000
        PUSH    HL              ; Save HL Register
        LD      HL,0023Ah       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L5728:  .TEXT   " JON MICHAEL HOGAN "               
        .DB     000h
;----------------------------------------------------
L573C:  POP     HL              ; Restore HL Register
        CALL    Delay10000      ; Delay 10,000
        PUSH    HL              ; Save HL Register
        LD      HL,0028Ah       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L5747:  .TEXT   "EDWARD J. MARCH JR."
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
L575C:  RET                     ; Return










;----------------------------------------------------
;           Draw Programmed Rectangle
;      A = Rectangle # to draw from table below
;----------------------------------------------------
L575D:  CP      00Bh            ; Is rectangle # > 11?
        JP      NC,L57CD        ; No, so print "READY"
        AND     00Fh            ; Mask data
        ADD     A,A             ; A = A * 2
        ADD     A,A             ; A = A * 2
        LD      E,A             ; E = Rectangle # * 4 bytes
        LD      D,000h          ; DE = Index
        LD      IY,057E8h       ; Point to start of data 
        ADD     IY,DE           ; Index into data
        LD      D,(IY+000h)     ; Get X Location
        LD      E,(IY+001h)     ; Get Y Location
        LD      B,(IY+002h)     ; Get Rectangle Width

;----------------------------------------------------
;              Draw top edge of rectangle
;----------------------------------------------------
        LD      A,083h          ; A = Character Upper Left Corner
        CALL    L2233           ; Print one Character to Text Display

L577D:  LD      A,080h          ; A = Character Horizontal Line
        CALL    L2256           ; Print A to Text Display
        PUSH    AF              ; Small delay
        POP     AF              ; Small delay
        DJNZ    L577D           ; Loop until width of horizontal line complete

        LD      A,082h          ; A = Character Upper Right Corner
        CALL    L2256           ; Print A to Text Display

;----------------------------------------------------
;              Draw left edge of rectangle
;----------------------------------------------------
        LD      B,(IY+003h)     ; Loop = Rectangle Height 
L578E:  LD      A,081h          ; A = Character Verticle Line
        INC     E               ; Location Y = Y + 1
        CALL    L2233           ; Print one Character to Text Display
        PUSH    AF              ; Small delay 
        POP     AF              ; Small delay
        PUSH    AF              ; Small delay
        POP     AF              ; Small delay
        DJNZ    L578E           ; Loop until heigth of rectangle complete
                
        LD      A,085h          ; A = Character Lower Left Corner
        INC     E               ; Location Y = Y + 1
        CALL    L2233           ; Print one Character to Text Display

;----------------------------------------------------
;              Draw bottom edge of rectangle
;----------------------------------------------------
        LD      B,(IY+002h)     ; Get rectangle width
L57A3:  LD      A,080h          ; A = Character Horizontal Line
        CALL    L2256           ; Print A to Text Display
        PUSH    AF              ; Small delay
        POP     AF              ; Small delay
        DJNZ    L57A3           ; Loop until width of rectangle complete
                
        LD      A,084h          ; A = Character Lower Right Corner
        CALL    L2256           ; Print A to Text Display

;----------------------------------------------------
;              Draw right edge of rectangle
;----------------------------------------------------
        LD      D,(IY+000h)     ; Get X Location
        LD      E,(IY+001h)     ; Get Y Location
        LD      A,(IY+002h)     ; Get Rectangle Width
        ADD     A,D             ; Add Width to X
        LD      D,A             ; D = Right edge X
        INC     D               ; Location X = X + 1
        LD      B,(IY+003h)     ; Loop = Rectangle Height
L57C0:  LD      A,081h          ; A = Character Verticle Line
        INC     E               ; Location Y = Y + 1
        CALL    L2233           ; Print one Character to Text Display
        PUSH    AF              ; Small delay
        POP     AF              ; Small delay
        PUSH    AF              ; Small delay
        POP     AF              ; Small delay
        DJNZ    L57C0           ; Loop until rectangle heigth complete
        RET                     ; Return




;----------------------------------------------------
;            Print "READY"
;----------------------------------------------------
L57CD:  PUSH    HL              ; Save HL Register
        LD      HL,001C3h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L57D4:  .TEXT   "    R E A D Y    "     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        RET                     ; Return







;----------------------------------------------------
;    Rectangle  Data:
;               X,    Y, Width  Heigth
;----------------------------------------------------
L57E8:  .DB     0,    0,   38,   21  ; Rectangle #0
        .DB     1,    1,   36,   19  ; Rectangle #1 
        .DB     2,    2,   34,   17  ; Rectangle #2
        .DB     3,    3,   32,   15  ; Rectangle #3
        .DB     4,    4,   30,   13  ; Rectangle #4
        .DB     5,    5,   28,   11  ; Rectangle #5
        .DB     6,    6,   26,    9  ; Rectangle #6
        .DB     7,    7,   24,    7  ; Rectangle #7
        .DB     8,    8,   22,    5  ; Rectangle #8
        .DB     9,    9,   20,    3  ; Rectangle #9
        .DB    10,   10,   18,    1  ; Rectangle #10
        .DB    11,   11,   16,    1  ; Rectangle #11
        .DB    12,   12,   14,    1  ; Rectangle #12
        .DB    13,   13,   12,    1  ; Rectangle #13
        .DB    13,   13,   12,    1  ; Rectangle #14
        .DB    13,   13,   12,    1  ; Rectangle #15
        .DB    13,   13,   12,    1  ; Rectangle #16
        
        .DB  0E0h




;----------------------------------------------------
;          Copyright Location
;----------------------------------------------------
L582D:  .TEXT   "COPYRIGHT: STERN ELECTRONICS, INC."
;----------------------------------------------------







;----------------------------------------------------
;       Character Pattern Definitions
;       128 characters, 8 bytes each
;----------------------------------------------------
L584F:  chdef[        ]  ; 20h
L5850:  chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[  X     ]  ; 21h
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[        ] 
        chdef[  X     ] 
;----------------------------------------------------
        chdef[ X X    ]  ; 22h
        chdef[ X X    ] 
        chdef[ X X    ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[ X X    ]  ; 23h
        chdef[ X X    ] 
        chdef[XXXXX   ] 
        chdef[ X X    ] 
        chdef[XXXXX   ] 
        chdef[ X X    ] 
        chdef[ X X    ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[  X     ]  ; 24h
        chdef[ XXXX   ] 
        chdef[X X     ] 
        chdef[ XXX    ] 
        chdef[  X X   ] 
        chdef[XXXX    ] 
        chdef[  X     ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[XX      ]  ; 25h
        chdef[XX  X   ] 
        chdef[   X    ] 
        chdef[  X     ] 
        chdef[ X      ] 
        chdef[X  XX   ] 
        chdef[   XX   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[ X      ]  ; 26h
        chdef[X X     ] 
        chdef[X X     ] 
        chdef[ X      ] 
        chdef[X X X   ] 
        chdef[X  X    ] 
        chdef[ XX X   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[  X     ]  ; 027h 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[  X     ]  ; 28h
        chdef[ X      ] 
        chdef[X       ] 
        chdef[X       ] 
        chdef[X       ] 
        chdef[ X      ] 
        chdef[  X     ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[  X     ]  ; 029h
        chdef[   X    ] 
        chdef[    X   ] 
        chdef[    X   ] 
        chdef[    X   ] 
        chdef[   X    ] 
        chdef[  X     ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[  X     ]  ; 2Ah
        chdef[X X X   ] 
        chdef[ XXX    ] 
        chdef[  X     ] 
        chdef[ XXX    ] 
        chdef[X X X   ] 
        chdef[  X     ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[  X     ]  ; 2Bh
        chdef[  X     ] 
        chdef[XXXXX   ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ]  ; 2Ch
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[  X     ] 
        chdef[ X      ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ]  ; 2Dh
        chdef[        ] 
        chdef[        ] 
        chdef[XXXXX   ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ]  ; 2Eh
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[  X     ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ]  ; 2Fh
        chdef[    X   ] 
        chdef[   X    ] 
        chdef[  X     ] 
        chdef[ X      ] 
        chdef[X       ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[ XXX    ]  ; 030h
        chdef[X   X   ] 
        chdef[X  XX   ] 
        chdef[X X X   ] 
        chdef[XX  X   ] 
        chdef[X   X   ] 
        chdef[ XXX    ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[  X     ]  ; 031h
        chdef[ XX     ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[ XXX    ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[ XXX    ]  ; 32h
        chdef[X   X   ] 
        chdef[    X   ] 
        chdef[  XX    ] 
        chdef[ X      ] 
        chdef[X       ] 
        chdef[XXXXX   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[XXXXX   ]  ; 33h
        chdef[    X   ] 
        chdef[   X    ] 
        chdef[  XX    ] 
        chdef[    X   ] 
        chdef[X   X   ] 
        chdef[ XXX    ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[   X    ]  ; 34h
        chdef[  XX    ] 
        chdef[ X X    ] 
        chdef[X  X    ] 
        chdef[XXXXX   ] 
        chdef[   X    ] 
        chdef[   X    ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[XXXXX   ]  ; 35h
        chdef[X       ] 
        chdef[XXXX    ] 
        chdef[    X   ] 
        chdef[    X   ] 
        chdef[X   X   ] 
        chdef[ XXX    ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[  XXX   ]  ; 36h
        chdef[ X      ] 
        chdef[X       ] 
        chdef[XXXX    ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[ XXX    ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[XXXXX   ]  ; 37h
        chdef[    X   ] 
        chdef[   X    ] 
        chdef[  X     ] 
        chdef[ X      ] 
        chdef[ X      ] 
        chdef[ X      ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[ XXX    ]  ; 038h
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[ XXX    ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[ XXX    ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[ XXX    ]  ; 039h
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[ XXXX   ] 
        chdef[    X   ] 
        chdef[   X    ] 
        chdef[XXX     ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ]  ; 03Ah
        chdef[        ] 
        chdef[  X     ] 
        chdef[        ] 
        chdef[  X     ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ]  ; 3Bh
        chdef[        ] 
        chdef[  X     ] 
        chdef[        ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[ X      ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[   X    ]  ; 3Ch
        chdef[  X     ] 
        chdef[ X      ] 
        chdef[X       ] 
        chdef[ X      ] 
        chdef[  X     ] 
        chdef[   X    ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ]  ; 3Dh
        chdef[XXXXX   ] 
        chdef[        ] 
        chdef[XXXXX   ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[ X      ]  ; 3Eh
        chdef[  X     ] 
        chdef[   X    ] 
        chdef[    X   ] 
        chdef[   X    ] 
        chdef[  X     ] 
        chdef[ X      ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[ XXX    ]  ; 03Fh
        chdef[X   X   ] 
        chdef[   X    ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[        ] 
        chdef[  X     ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[ XXX    ]  ; 40h
        chdef[X   X   ] 
        chdef[X X X   ] 
        chdef[X XXX   ] 
        chdef[X XX    ] 
        chdef[X       ] 
        chdef[ XXXX   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[  X     ]  ; 041h
        chdef[ X X    ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[XXXXX   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[XXXX    ]  ; 42h
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[XXXX    ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[XXXX    ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[ XXX    ] 
        chdef[X   X   ] 
        chdef[X       ] 
        chdef[X       ] 
        chdef[X       ] 
        chdef[X   X   ] 
        chdef[ XXX    ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[XXXX    ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[XXXX    ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[XXXXX   ] 
        chdef[X       ] 
        chdef[X       ] 
        chdef[XXXX    ] 
        chdef[X       ] 
        chdef[X       ] 
        chdef[XXXXX   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[XXXXX   ] 
        chdef[X       ] 
        chdef[X       ] 
        chdef[XXXX    ] 
        chdef[X       ] 
        chdef[X       ] 
        chdef[X       ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[ XXXX   ] 
        chdef[X       ] 
        chdef[X       ] 
        chdef[X       ] 
        chdef[X  XX   ] 
        chdef[X   X   ] 
        chdef[ XXXX   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[XXXXX   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[ XXX    ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[ XXX    ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[    X   ] 
        chdef[    X   ] 
        chdef[    X   ] 
        chdef[    X   ] 
        chdef[    X   ] 
        chdef[X   X   ] 
        chdef[ XXX    ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[X   X   ] 
        chdef[X  X    ] 
        chdef[X X     ] 
        chdef[XX      ] 
        chdef[X X     ] 
        chdef[X  X    ] 
        chdef[X   X   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[X       ] 
        chdef[X       ] 
        chdef[X       ] 
        chdef[X       ] 
        chdef[X       ] 
        chdef[X       ] 
        chdef[XXXXX   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[X   X   ] 
        chdef[XX XX   ] 
        chdef[X X X   ] 
        chdef[X X X   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[XX  X   ] 
        chdef[X X X   ] 
        chdef[X  XX   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[ XXX    ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[ XXX    ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[XXXX    ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[XXXX    ] 
        chdef[X       ] 
        chdef[X       ] 
        chdef[X       ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[ XXX    ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[X X X   ] 
        chdef[X  X    ] 
        chdef[ XX X   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[XXXX    ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[XXXX    ] 
        chdef[X X     ] 
        chdef[X  X    ] 
        chdef[X   X   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[ XXX    ] 
        chdef[X   X   ] 
        chdef[X       ] 
        chdef[ XXX    ] 
        chdef[    X   ] 
        chdef[X   X   ] 
        chdef[ XXX    ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[XXXXX   ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[X   X   ]  ;
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[ XXX    ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[ X X    ] 
        chdef[  X     ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[X X X   ] 
        chdef[X X X   ] 
        chdef[XX XX   ] 
        chdef[X   X   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[ X X    ] 
        chdef[  X     ] 
        chdef[ X X    ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[ X X    ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[XXXXX   ] 
        chdef[    X   ] 
        chdef[   X    ] 
        chdef[  X     ] 
        chdef[ X      ] 
        chdef[X       ] 
        chdef[XXXXX   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[XXXXX   ] 
        chdef[XX      ] 
        chdef[XX      ] 
        chdef[XX      ] 
        chdef[XX      ] 
        chdef[XX      ] 
        chdef[XXXXX   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[XXX     ] 
        chdef[XXXX    ] 
        chdef[XXXXX   ] 
        chdef[XXXXXX  ] 
        chdef[XXXXX   ] 
        chdef[XXXX    ] 
        chdef[XXX     ] 
        chdef[XX      ] 
;----------------------------------------------------
        chdef[XXXXX   ] 
        chdef[   XX   ] 
        chdef[   XX   ] 
        chdef[   XX   ] 
        chdef[   XX   ] 
        chdef[   XX   ] 
        chdef[XXXXX   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[  X     ] 
        chdef[ X X    ] 
        chdef[X   X   ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[   X    ] 
        chdef[  X     ] 
        chdef[ X      ] 
        chdef[XXXXX   ] 
        chdef[ X      ] 
        chdef[  X     ] 
        chdef[   X    ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[ X      ] 
        chdef[  X     ] 
        chdef[   X    ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[ XXX    ] 
        chdef[X   X   ] 
        chdef[XXXXX   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[XXXX    ] 
        chdef[ X  X   ] 
        chdef[ XXX    ] 
        chdef[ X  X   ] 
        chdef[XXXX    ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[ XXXX   ] 
        chdef[X       ] 
        chdef[X       ] 
        chdef[X       ] 
        chdef[ XXXX   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[XXXX    ] 
        chdef[ X  X   ] 
        chdef[ X  X   ] 
        chdef[ X  X   ] 
        chdef[XXXX    ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[XXXXX   ] 
        chdef[X       ] 
        chdef[XXXX    ] 
        chdef[X       ] 
        chdef[XXXXX   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[XXXX    ] 
        chdef[X       ] 
        chdef[XXX     ] 
        chdef[X       ] 
        chdef[X       ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ]  ;
        chdef[        ] 
        chdef[ XXXX   ] 
        chdef[X       ] 
        chdef[X XXX   ] 
        chdef[X   X   ] 
        chdef[ XXX    ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[XXXXX   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[XXXXX   ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[XXXXX   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[ XXX    ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[X X     ] 
        chdef[XXX     ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[X  X    ] 
        chdef[X X     ] 
        chdef[XX      ] 
        chdef[X X     ] 
        chdef[X  X    ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[X       ] 
        chdef[X       ] 
        chdef[X       ] 
        chdef[X       ] 
        chdef[XXXXX   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ]  ;
        chdef[        ] 
        chdef[X   X   ] 
        chdef[XX XX   ] 
        chdef[X X X   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[X   X   ] 
        chdef[XX  X   ] 
        chdef[X X X   ] 
        chdef[X  XX   ] 
        chdef[X   X   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[ XXX    ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[ XXX    ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[XXXX    ] 
        chdef[X   X   ] 
        chdef[XXXX    ] 
        chdef[X       ] 
        chdef[X       ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[XXXXX   ] 
        chdef[X   X   ] 
        chdef[X X X   ] 
        chdef[X  X    ] 
        chdef[XXX     ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[XXXXX   ] 
        chdef[X   X   ] 
        chdef[XXXXX   ] 
        chdef[X X     ] 
        chdef[X  X    ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[ XXXX   ] 
        chdef[X       ] 
        chdef[ XXX    ] 
        chdef[    X   ] 
        chdef[XXXX    ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[XXXXX   ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[ XXX    ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[X  X    ] 
        chdef[X X     ] 
        chdef[ X      ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[X   X   ] 
        chdef[X   X   ] 
        chdef[X X X   ] 
        chdef[XX XX   ] 
        chdef[X   X   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[X   X   ] 
        chdef[ XXX    ] 
        chdef[  X     ] 
        chdef[ XXX    ] 
        chdef[X   X   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[X   X   ] 
        chdef[ X X    ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[  X     ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[XXXXX   ] 
        chdef[   X    ] 
        chdef[  X     ] 
        chdef[ X      ] 
        chdef[XXXXX   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[  XXX   ] 
        chdef[ X      ] 
        chdef[  X     ] 
        chdef[XX      ] 
        chdef[  X     ] 
        chdef[ X      ] 
        chdef[  XXX   ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[   XX   ] 
        chdef[   XX   ] 
        chdef[   XX   ] 
        chdef[   XX   ] 
        chdef[   XX   ] 
        chdef[   XX   ] 
        chdef[   XX   ] 
        chdef[   XX   ] 
;----------------------------------------------------
        chdef[XXX     ] 
        chdef[   X    ] 
        chdef[  X     ] 
        chdef[   XX   ] 
        chdef[  X     ] 
        chdef[   X    ] 
        chdef[XXX     ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[   XXX  ]  ; 07Eh
        chdef[  XXXX  ] 
        chdef[ XXXXX  ] 
        chdef[XXXXXX  ] 
        chdef[ XXXXX  ] 
        chdef[  XXXX  ] 
        chdef[   XXX  ] 
        chdef[    XX  ] 
;----------------------------------------------------
        chdef[XXXXXXXX]  ; 07Fh
        chdef[XXXXXXXX] 
        chdef[XXXXXXXX] 
        chdef[XXXXXXXX] 
        chdef[XXXXXXXX] 
        chdef[XXXXXXXX] 
        chdef[XXXXXXXX] 
        chdef[XXXXXXXX] 
;----------------------------------------------------
        chdef[        ]  ; 080h 
        chdef[        ] 
        chdef[        ] 
        chdef[XXXXXXXX] 
        chdef[XXXXXXXX] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[   XX   ]  ; 081h
        chdef[   XX   ] 
        chdef[   XX   ] 
        chdef[   XX   ] 
        chdef[   XX   ] 
        chdef[   XX   ] 
        chdef[   XX   ] 
        chdef[   XX   ] 
;----------------------------------------------------
        chdef[        ]  ; 082h
        chdef[        ] 
        chdef[        ] 
        chdef[XXXXX   ] 
        chdef[XXXXX   ] 
        chdef[   XX   ] 
        chdef[   XX   ] 
        chdef[   XX   ] 
;----------------------------------------------------
        chdef[        ]  ; 083h
        chdef[        ] 
        chdef[        ] 
        chdef[   XXXXX] 
        chdef[   XXXXX] 
        chdef[   XX   ] 
        chdef[   XX   ] 
        chdef[   XX   ] 
;----------------------------------------------------
        chdef[   XX   ]  ; 084h
        chdef[   XX   ] 
        chdef[   XX   ] 
        chdef[XXXXX   ] 
        chdef[XXXXX   ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[   XX   ]  ; 085h
        chdef[   XX   ] 
        chdef[   XX   ] 
        chdef[   XXXXX] 
        chdef[   XXXXX] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[   XX   ]  ; 086h
        chdef[   XX   ] 
        chdef[   XX   ] 
        chdef[XXXXXXXX] 
        chdef[XXXXXXXX] 
        chdef[   XX   ] 
        chdef[   XX   ] 
        chdef[   XX   ] 
;----------------------------------------------------
        chdef[        ]  ; 087h
        chdef[        ] 
        chdef[        ] 
        chdef[XXXXXXXX] 
        chdef[XXXXXXXX] 
        chdef[   XX   ] 
        chdef[   XX   ] 
        chdef[   XX   ] 
;----------------------------------------------------
        chdef[   XX   ]  ; 088h
        chdef[   XX   ] 
        chdef[   XX   ] 
        chdef[XXXXXXXX] 
        chdef[XXXXXXXX] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[   XX   ]  ; 089h
        chdef[   XX   ] 
        chdef[   XX   ] 
        chdef[XXXXX   ] 
        chdef[XXXXX   ] 
        chdef[   XX   ] 
        chdef[   XX   ] 
        chdef[   XX   ] 
;----------------------------------------------------
        chdef[        ]  ; 08Ah
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ]  ; 08Bh
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[   X    ]  ; 090h
        chdef[  X X   ] 
        chdef[   X    ] 
        chdef[  XXX   ] 
        chdef[ X X X  ] 
        chdef[   X    ] 
        chdef[  X X   ] 
        chdef[ XX XX  ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
        chdef[        ] 
;----------------------------------------------------









;----------------------------------------------------
;             Scene One - Getaway
;----------------------------------------------------   
L5C4F:   .DB  000h, 018h, 000h ; Frame 001800
L5C52    .DB  000h, 029h, 007h ; Frame 002907
L5C55    .DB  000h, 000h, 000h ; Frame 000000
L5C58    .DB  000h, 000h, 000h ; Frame 000000
L5C5B    .DB  00Ch             ; 12 moves in scene

;----------------------------------------------------
;   Difficulty 2:Scene 1:Move 1
;----------------------------------------------------
L5C5C:   .DB  000h             ;
L5C5D    .DB  000h             ; Correct Move   = NONE
L5C5E    .DB  000h             ; Incorrect Move = NONE
L5C5F    .DB  000h, 018h, 000h ; Move Start Frame:  001800
L5C62    .DB  000h, 000h, 000h ; Move End Frame:    000000
L5C65    .DB  000h, 000h, 000h ; Death Start Frame: 000000
L5C68    .DB  000h, 000h, 000h ; Death End Frame:   000000
L5C6B    .DB  000h             ; Restart
L5C6C    .DW  00000h           ; Restart

;----------------------------------------------------
;   Difficulty 2:Scene 1:Move 2
;----------------------------------------------------
L5C6E:   .DB  000h             ;
L566F:   .DB  090h             ; Correct Move   = FEET
L5670:   .DB  060h             ; Incorrect Move = HANDS  
L5671:   .DB  000h, 019h, 028h ; Move Start Frame:  001928 
L5674:   .DB  000h, 019h, 087h ; Move End Frame:    001987  
L5677:   .DB  000h, 039h, 030h ; Death Start Frame: 003930 
L567A:   .DB  000h, 042h, 034h ; Death End Frame:   004234
L567D:   .DB  00Ch             ; Restart 12 moves    
L567E:   .DW  05C5Ch           ; Restart: Move 1 

;----------------------------------------------------
;   Difficulty 2:Scene 1:Move 3
;----------------------------------------------------
L5C80:   .DB  000h             ;
L5C81:   .DB  090h             ; Correct Move   = FEET
L5C82:   .DB  060h             ; Incorrect Move = HANDS  
L5C83:   .DB  000h, 019h, 090h ; Move Start Frame:  001990 
L5C86:   .DB  000h, 020h, 040h ; Move End Frame:    002040 
L5C89:   .DB  000h, 039h, 030h ; Death Start Frame: 003930 
L5C8C:   .DB  000h, 042h, 034h ; Death End Frame:   004234
L5C8F:   .DB  00Ch             ; Restart 12 moves    
L5C90:   .DW  05C5Ch           ; Restart: Move 1 

;----------------------------------------------------
;   Difficulty 2:Scene 1:Move 4
;----------------------------------------------------
L5C92:   .DB  000h             ;
L5C93:   .DB  060h             ; Correct Move   = HANDS
L5C94:   .DB  090h             ; Incorrect Move = FEET  
L5C95:   .DB  000h, 021h, 020h ; Move Start Frame:  002120
L5C98:   .DB  000h, 021h, 060h ; Move End Frame:    002160 
L5C9B:   .DB  000h, 039h, 030h ; Death Start Frame: 003930 
L5C9E:   .DB  000h, 042h, 034h ; Death End Frame:   004234
L5CA1:   .DB  00Ch             ; Restart 12 moves    
L5CA2:   .DW  05C5Ch           ; Restart: Move 1 

;----------------------------------------------------
;   Difficulty 2:Scene 1:Move 5
;----------------------------------------------------
L5CA4:   .DB  000h             ;
L5CA5:   .DB  008h             ; Correct Move   = UP
L5CA6:   .DB  062h             ; Incorrect Move = HANDS,DOWN  
L5CA7:   .DB  000h, 021h, 086h ; Move Start Frame:  002186 
L5CAA:   .DB  000h, 022h, 026h ; Move End Frame:    002226 
L5CAD:   .DB  000h, 039h, 030h ; Death Start Frame: 003930 
L5CB0:   .DB  000h, 042h, 034h ; Death End Frame:   004234
L5CB3:   .DB  00Ch             ; Restart 12 moves    
L5CB4:   .DW  05C5Ch           ; Restart: Move 1 

;----------------------------------------------------
;   Difficulty 2:Scene 1:Move 6
;----------------------------------------------------
L5CB6:   .DB  000h             ;
L5CB7:   .DB  000h             ; Correct Move   = NONE
L5CB8:   .DB  000h             ; Incorrect Move = NONE  
L5CB9:   .DB  000h, 022h, 076h ; Move Start Frame:  002276 
L5CBC:   .DB  000h, 000h, 000h ; Move End Frame:    000000 
L5CBF:   .DB  000h, 000h, 000h ; Death Start Frame: 000000 
L5CC2:   .DB  000h, 000h, 000h ; Death End Frame:   000000
L5CC5:   .DB  007h             ; Restart
L5CC6:   .DW  05CB6h           ; Restart

;----------------------------------------------------
;   Difficulty 2:Scene 1:Move 7
;----------------------------------------------------
L5CC8:   .DB  000h             ;
L5CC9:   .DB  001h             ; Correct Move   = LEFT
L5CCA:   .DB  0F4h             ; Incorrect Move = HANDS,FEET,RIGHT  
L5CCB:   .DB  000h, 024h, 019h ; Move Start Frame:  002419
L5CCE:   .DB  000h, 024h, 059h ; Move End Frame:    002459 
L5CD1:   .DB  000h, 032h, 014h ; Death Start Frame: 003214 
L5CD4:   .DB  000h, 035h, 000h ; Death End Frame:   003500
L5CD7:   .DB  007h             ; Restart 7 moves    
L5CD8:   .DW  05CB6h           ; Restart: Move 6 

;----------------------------------------------------
;   Difficulty 2:Scene 1:Move 8
;----------------------------------------------------
L5CDA:   .DB  000h             ;
L5CDB:   .DB  004h             ; Correct Move   = RIGHT
L5CDC:   .DB  0F1h             ; Incorrect Move = HANDS,FEET,LEFT  
L5CDD:   .DB  000h, 024h, 047h ; Move Start Frame:  002447 
L5CE0:   .DB  000h, 024h, 087h ; Move End Frame:    002487 
L5CE3:   .DB  000h, 032h, 014h ; Death Start Frame: 003214 
L5CE6:   .DB  000h, 035h, 000h ; Death End Frame:   003500
L5CE9:   .DB  007h             ; Restart 7 moves    
L5CEA:   .DW  05CB6h           ; Restart: Move 6 

;----------------------------------------------------
;   Difficulty 2:Scene 1:Move 9
;----------------------------------------------------
L5CEC:   .DB  000h             ;
L5CED:   .DB  002h             ; Correct Move   = DOWN
L5CEE:   .DB  0F8h             ; Incorrect Move = HANDS,FEET,UP  
L5CEF:   .DB  000h, 024h, 064h ; Move Start Frame:  002464 
L5CF2:   .DB  000h, 025h, 004h ; Move End Frame:    002504 
L5CF5:   .DB  000h, 032h, 014h ; Death Start Frame: 003214 
L5CF8:   .DB  000h, 035h, 000h ; Death End Frame:   003500
L5CFB:   .DB  007h             ; Restart 7 moves    
L5CFC:   .DW  05CB6h           ; Restart: Move 6 

;----------------------------------------------------
;   Difficulty 2:Scene 1:Move 10
;----------------------------------------------------
L5CFE:   .DB  000h             ;
L5CFF:   .DB  001h             ; Correct Move   = LEFT
L5D00:   .DB  0FEh             ; Incorrect Move = HANDS,FEET,RIGHT,UP,DOWN
L5D01:   .DB  000h, 025h, 013h ; Move Start Frame:  002513 
L5D04:   .DB  000h, 025h, 053h ; Move End Frame:    002553 
L5D07:   .DB  000h, 032h, 014h ; Death Start Frame: 003214 
L5D0A:   .DB  000h, 035h, 000h ; Death End Frame:   003500
L5D0D:   .DB  007h             ; Restart 7 moves    
L5D0E:   .DW  05CB6h           ; Restart: Move 6 

;----------------------------------------------------
;   Difficulty 2:Scene 1:Move 11
;----------------------------------------------------
L5D10:   .DB  000h             ;
L5D11:   .DB  004h             ; Correct Move   = RIGHT
L5D12:   .DB  0F1h             ; Incorrect Move = HANDS,FEET,LEFT  
L5D13:   .DB  000h, 025h, 049h ; Move Start Frame:  002549 
L5D16:   .DB  000h, 025h, 089h ; Move End Frame:    002589 
L5D19:   .DB  000h, 032h, 014h ; Death Start Frame: 003214 
L5D1C:   .DB  000h, 035h, 000h ; Death End Frame:   003500
L5D1F:   .DB  007h             ; Restart 7 moves    
L5D20:   .DW  05CB6h           ; Restart: Move 6 

;----------------------------------------------------
;   Difficulty 2:Scene 1:Move 12
;----------------------------------------------------
L5D22:   .DB  000h             ;
L5D23:   .DB  060h             ; Correct Move   = HANDS
L5D24:   .DB  095h             ; Incorrect Move = FEET,LEFT,RIGHT  
L5D25:   .DB  000h, 026h, 040h ; Move Start Frame:  002640 
L5D28:   .DB  000h, 026h, 080h ; Move End Frame:    002680 
L5D2B:   .DB  000h, 032h, 014h ; Death Start Frame: 003214 
L5D2E:   .DB  000h, 035h, 000h ; Death End Frame:   003500
L5D31:   .DB  007h             ; Restart 7 moves    
L5D32:   .DW  05CB6h           ; Restart: Move 6 












;----------------------------------------------------
;             Scene Two - Getaway
;----------------------------------------------------   
L5D34:   .DB  000h, 051h, 086h ; Frame 001800            
L5D37:   .DB  000h, 080h, 074h ; Frame 002907
L5D3A:   .DB  000h, 045h, 092h ; Frame 000000
L5D3D:   .DB  000h, 000h, 000h ; Frame 000000
L5D40:   .DB  01Dh             ; 29 moves in scene

;----------------------------------------------------
;   Difficulty 2:Scene 2:Move 1
;----------------------------------------------------
L5D41:   .DB  000h
L5D42:   .DB  000h 
L5D43:   .DB  000h             
L5D44:   .DB  000h         
L5D45:   .DB  051h
L5D46:   .DB  086h 
L5D47:   .DB  000h 
L5D48:   .DB  000h 
L5D49:   .DB  000h 
L5D4A:   .DB  000h 
L5D4B:   .DB  000h 
L5D4C:   .DB  000h 
L5D4D:   .DB  000h 
L5D4E:   .DB  000h 
L5D4F:   .DB  000h 
L5D50:   .DB  000h 
L5D51:   .DB  000h 
L5D52:   .DB  000h 
L5D53:   .DB  000h 
L5D54:   .DB  002h 
L5D55:   .DB  0F0h 
L5D56:   .DB  000h 
L5D57:   .DB  053h 
L5D58:   .DB  088h
L5D50:   .DB  000h
L5D51:   .DB  000h
L5D52:   .DB  000h
L5D53:   .DB  000h
L5D54:   .DB  002h
L5D55:   .DB  0F0h
L5D56:   .DB  000h
L5D57:   .DB  053h
L5D58:   .DB  088h
L5D59:   .DB  000h
L5D5A:   .DB  054h
L5D5B:   .DB  028h
L5D5C:   .DB  000h
L5D5D:   .DB  081h
L5D5E:   .DB  020h
L5D5F:   .DB  000h
L5D60:   .DB  084h
L5D61:   .DB  009h
L5D62:   .DB  01Dh
L5D63:   .DB  041h
L5D64:   .DB  05Dh
L5D65:   .DB  000h
L5D66:   .DB  060h
L5D67:   .DB  00Eh
L5D68:   .DB  000h
L5D69:   .DB  054h
L5D6A:   .DB  018h
L5D6B:   .DB  000h
L5D6C:   .DB  054h
L5D6D:   .DB  058h
L5D6E:   .DB  000h
L5D6F:   .DB  081h
L5D70:   .DB  020h
L5D71:   .DB  000h
L5D72:   .DB  084h
L5D73:   .DB  009h
L5D74:   .DB  01Dh
L5D75:   .DB  041h
L5D76:   .DB  05Dh
L5D77:   .DB  000h
L5D78:   .DB  000h
L5D79:   .DB  000h
L5D7A:   .DB  000h
L5D7B:   .DB  054h
L5D7C:   .DB  084h
L5D7D:   .DB  000h
L5D7E:   .DB  055h
L5D7F:   .DB  024h
L5D80:   .DB  000h
L5D81:   .DB  081h
L5D82:   .DB  020h
L5D83:   .DB  000h
L5D84:   .DB  084h
L5D85:   .DB  009h
L5D86:   .DB  01Dh
L5D87:   .DB  041h
L5D88:   .DB  05Dh
L5D89:   .DB  000h
L5D8A:   .DB  001h
L5D8B:   .DB  0F0h
L5D8C:   .DB  000h
L5D8D:   .DB  055h
L5D8E:   .DB  016h
L5D8F:   .DB  000h  
L5D90:   .DB  055h
L5D91:   .DB  056h
L5D92:   .DB  000h
L5D93:   .DB  081h
L5D94:   .DB  020h
L5D95:   .DB  000h
L5D96:   .DB  084h
L5D97:   .DB  009h
L5D98:   .DB  01Dh
L5D99:   .DB  041h
L5D9A:   .DB  05Dh
L5D9B:   .DB  000h
L5D9C:   .DB  000h
L5D9D:   .DB  000h
L5D9E:   .DB  000h
L5D9F:   .DB  055h
L5DA0:   .DB  060h
L5DA1:   .DB  000h
L5DA2:   .DB  000h
L5DA3:   .DB  000h
L5DA4:   .DB  000h
L5DA5:   .DB  000h
L5DA6:   .DB  000h
L5DA7:   .DB  000h
L5DA8:   .DB  000h
L5DA9:   .DB  000h
L5DAA:   .DB  000h
L5DAB:   .DB  000h
L5DAC:   .DB  000h
L5DAD:   .DB  000h
L5DAE:   .DB  004h
L5DAF:   .DB  0F0h
L5DB0:   .DB  000h
L5DB1:   .DB  056h
L5DB2:   .DB  000h
L5DB3:   .DB  000h
L5DB4:   .DB  056h
L5DB5:   .DB  040h
L5DB6:   .DB  000h
L5DB7:   .DB  081h
L5DB8:   .DB  020h
L5DB9:   .DB  000h
L5DBA:   .DB  084h
L5DBB:   .DB  009h
L5DBC:   .DB  018h
L5DBD:   .DB  09Bh
L5DBE:   .DB  05Dh 
L5DBF:   .DB  000h 
L5DC0:   .DB  004h 
L5DC1:   .DB  0F0h 
L5DC2:   .DB  000h 
L5DC3:   .DB  056h 
L5DC4:   .DB  080h 
L5DC5:   .DB  000h 
L5DC6:   .DB  057h 
L5DC7:   .DB  020h 
L5DC8:   .DB  000h 
L5DC9:   .DB  084h 
L5DCA:   .DB  039h 
L5DCB:   .DB  000h 
L5DCC:   .DB  087h 
L5DCD:   .DB  032h 
L5DCE:   .DB  018h 
L5DCF:   .DB  09Bh 
L5DD0:   .DB  05Dh 
L5DD1:   .DB  000h 
L5DD2:   .DB  001h 
L5DD3:   .DB  0F0h 
L5DD4:   .DB  000h 
L5DD5:   .DB  057h 
L5DD6:   .DB  010h 
L5DD7:   .DB  000h 
L5DD8:   .DB  057h 
L5DD9:   .DB  050h 
L5DDA:   .DB  000h 
L5DDB:   .DB  084h 
L5DDC:   .DB  039h 
L5DDD:   .DB  000h 
L5DDE:   .DB  087h 
L5DDF:   .DB  032h 
L5DE0:   .DB  018h 
L5DE1:   .DB  09Bh 
L5DE2:   .DB  05Dh 
L5DE3:   .DB  000h 
L5DE4:   .DB  001h 
L5DE5:   .DB  0F0h 
L5DE6:   .DB  000h 
L5DE7:   .DB  057h 
L5DE8:   .DB  052h 
L5DE9:   .DB  000h 
L5DEA:   .DB  057h 
L5DEB:   .DB  092h 
L5DEC:   .DB  000h 
L5DED:   .DB  084h 
L5DEE:   .DB  039h 
L5DEF:   .DB  000h 
L5DF0:   .DB  087h 
L5DF1:   .DB  032h 
L5DF2:   .DB  018h 
L5DF3:   .DB  09Bh 
L5DF4:   .DB  05Dh 
L5DF5:   .DB  000h 
L5DF6:   .DB  004h 
L5DF7:   .DB  0FBh 
L5DF8:   .DB  000h 
L5DF9:   .DB  058h 
L5DFA:   .DB  002h 
L5DFB:   .DB  000h 
L5DFC:   .DB  058h 
L5DFD:   .DB  042h 
L5DFE:   .DB  000h 
L5DFF:   .DB  084h 
L5E00:   .DB  039h 
L5E01:   .DB  000h 
L5E02:   .DB  087h 
L5E03:   .DB  032h 
L5E04:   .DB  018h 
L5E05:   .DB  09Bh 
L5E06:   .DB  05Dh 
L5E07:   .DB  000h 
L5E08:   .DB  002h 
L5E09:   .DB  0F0h 
L5E0A:   .DB  000h 
L5E0B:   .DB  058h 
L5E0C:   .DB  074h 
L5E0D:   .DB  000h 
L5E0E:   .DB  059h 
L5E0F:   .DB  014h 
L5E10:   .DB  000h 
L5E11:   .DB  084h 
L5E12:   .DB  039h 
L5E13:   .DB  000h 
L5E14:   .DB  087h 
L5E15:   .DB  032h 
L5E16:   .DB  018h 
L5E17:   .DB  09Bh 
L5E18:   .DB  05Dh 
L5E19:   .DB  000h 
L5E1A:   .DB  000h 
L5E1B:   .DB  000h 
L5E1C:   .DB  000h 
L5E1D:   .DB  059h 
L5E1E:   .DB  020h 
L5E1F:   .DB  000h 
L5E20:   .DB  000h 
L5E21:   .DB  000h 
L5E22:   .DB  000h 
L5E23:   .DB  000h 
L5E24:   .DB  000h 
L5E25:   .DB  000h 
L5E26:   .DB  000h 
L5E27:   .DB  000h 
L5E28:   .DB  000h 
L5E29:   .DB  000h 
L5E2A:   .DB  000h 
L5E2B:   .DB  000h 
L5E2C:   .DB  001h 
L5E2D:   .DB  0FEh 
L5E2E:   .DB  000h 
L5E2F:   .DB  060h 
L5E30:   .DB  000h 
L5E31:   .DB  000h 
L5E32:   .DB  060h 
L5E33:   .DB  040h 
L5E34:   .DB  000h 
L5E35:   .DB  097h 
L5E36:   .DB  094h 
L5E37:   .DB  001h 
L5E38:   .DB  000h 
L5E39:   .DB  081h 
L5E3A:   .DB  011h 
L5E3B:   .DB  019h 
L5E3C:   .DB  05Eh 
L5E3D:   .DB  000h 
L5E3E:   .DB  001h 
L5E3F:   .DB  0F0h 
L5E40:   .DB  000h 
L5E41:   .DB  061h 
L5E42:   .DB  008h 
L5E43:   .DB  000h 
L5E44:   .DB  061h 
L5E45:   .DB  048h 
L5E46:   .DB  000h 
L5E47:   .DB  097h 
L5E48:   .DB  094h 
L5E49:   .DB  001h 
L5E4A:   .DB  000h 
L5E4B:   .DB  081h 
L5E4C:   .DB  011h 
L5E4D:   .DB  019h 
L5E4E:   .DB  05Eh 
L5E4F:   .DB  000h 
L5E50:   .DB  001h 
L5E51:   .DB  0FEh 
L5E52:   .DB  000h 
L5E53:   .DB  062h 
L5E54:   .DB  078h 
L5E55:   .DB  000h 
L5E56:   .DB  063h 
L5E57:   .DB  018h 
L5E58:   .DB  000h 
L5E59:   .DB  097h 
L5E5A:   .DB  094h 
L5E5B:   .DB  001h 
L5E5C:   .DB  000h 
L5E5D:   .DB  081h 
L5E5E:   .DB  011h 
L5E5F:   .DB  019h 
L5E60:   .DB  05Eh 
L5E61:   .DB  000h 
L5E62:   .DB  060h 
L5E63:   .DB  00Fh 
L5E64:   .DB  000h 
L5E65:   .DB  063h 
L5E66:   .DB  042h 
L5E67:   .DB  000h 
L5E68:   .DB  063h 
L5E69:   .DB  082h 
L5E6A:   .DB  000h 
L5E6B:   .DB  084h 
L5E6C:   .DB  039h 
L5E6D:   .DB  000h 
L5E6E:   .DB  087h 
L5E6F:   .DB  032h 
L5E70:   .DB  011h 
L5E71:   .DB  019h 
L5E72:   .DB  05Eh 
L5E73:   .DB  000h 
L5E74:   .DB  008h 
L5E75:   .DB  0F7h 
L5E76:   .DB  000h 
L5E77:   .DB  064h 
L5E78:   .DB  096h 
L5E79:   .DB  000h 
L5E7A:   .DB  065h 
L5E7B:   .DB  036h 
L5E7C:   .DB  000h 
L5E7D:   .DB  084h 
L5E7E:   .DB  039h 
L5E7F:   .DB  000h 
L5E80:   .DB  087h 
L5E81:   .DB  032h 
L5E82:   .DB  011h 
L5E83:   .DB  019h 
L5E84:   .DB  05Eh 
L5E85:   .DB  000h 
L5E86:   .DB  004h 
L5E87:   .DB  0F0h 
L5E88:   .DB  000h 
L5E89:   .DB  066h 
L5E8A:   .DB  094h 
L5E8B:   .DB  000h 
L5E8C:   .DB  067h 
L5E8D:   .DB  034h 
L5E8E:   .DB  001h 
L5E8F:   .DB  001h 
L5E90:   .DB  005h 
L5E91:   .DB  001h 
L5E92:   .DB  004h 
L5E93:   .DB  027h 
L5E94:   .DB  011h 
L5E95:   .DB  019h 
L5E96:   .DB  05Eh 
L5E97:   .DB  000h 
L5E98:   .DB  001h 
L5E99:   .DB  0F0h 
L5E9A:   .DB  000h 
L5E9B:   .DB  069h 
L5E9C:   .DB  004h 
L5E9D:   .DB  000h 
L5E9E:   .DB  069h 
L5E9F:   .DB  044h 
L5EA0:   .DB  001h 
L5EA1:   .DB  001h 
L5EA2:   .DB  005h 
L5EA3:   .DB  001h 
L5EA4:   .DB  004h 
L5EA5:   .DB  027h 
L5EA6:   .DB  011h 
L5EA7:   .DB  019h 
L5EA8:   .DB  05Eh 
L5EA9:   .DB  000h 
L5EAA:   .DB  000h 
L5EAB:   .DB  000h 
L5EAC:   .DB  000h 
L5EAD:   .DB  069h 
L5EAE:   .DB  074h 
L5EAF:   .DB  000h 
L5EB0:   .DB  000h 
L5EB1:   .DB  000h 
L5EB2:   .DB  000h 
L5EB3:   .DB  000h 
L5EB4:   .DB  000h 
L5EB5:   .DB  000h 
L5EB6:   .DB  000h 
L5EB7:   .DB  000h 
L5EB8:   .DB  000h 
L5EB9:   .DB  000h 
L5EBA:   .DB  000h 
L5EBB:   .DB  000h 
L5EBC:   .DB  002h 
L5EBD:   .DB  0FDh 
L5EBE:   .DB  000h 
L5EBF:   .DB  070h 
L5EC0:   .DB  015h 
L5EC1:   .DB  000h 
L5EC2:   .DB  070h 
L5EC3:   .DB  055h 
L5EC4:   .DB  001h 
L5EC5:   .DB  001h 
L5EC6:   .DB  005h 
L5EC7:   .DB  001h 
L5EC8:   .DB  004h 
L5EC9:   .DB  027h 
L5ECA:   .DB  009h 
L5ECB:   .DB  0A9h 
L5ECC:   .DB  05Eh 
L5ECD:   .DB  000h 
L5ECE:   .DB  001h 
L5ECF:   .DB  0F0h 
L5ED0:   .DB  000h 
L5ED1:   .DB  071h 
L5ED2:   .DB  014h 
L5ED3:   .DB  000h 
L5ED4:   .DB  071h 
L5ED5:   .DB  054h 
L5ED6:   .DB  001h 
L5ED7:   .DB  001h 
L5ED8:   .DB  005h 
L5ED9:   .DB  001h 
L5EDA:   .DB  004h 
L5EDB:   .DB  027h 
L5EDC:   .DB  009h 
L5EDD:   .DB  0A9h 
L5EDE:   .DB  05Eh 
L5EDF:   .DB  000h 
L5EE0:   .DB  060h 
L5EE1:   .DB  00Fh 
L5EE2:   .DB  000h 
L5EE3:   .DB  072h 
L5EE4:   .DB  002h 
L5EE5:   .DB  000h 
L5EE6:   .DB  072h 
L5EE7:   .DB  042h 
L5EE8:   .DB  000h 
L5EE9:   .DB  081h 
L5EEA:   .DB  020h 
L5EEB:   .DB  000h 
L5EEC:   .DB  084h 
L5EED:   .DB  009h 
L5EEE:   .DB  009h 
L5EEF:   .DB  0A9h 
L5EF0:   .DB  05Eh 
L5EF1:   .DB  000h 
L5EF2:   .DB  090h 
L5EF3:   .DB  00Fh 
L5EF4:   .DB  000h 
L5EF5:   .DB  072h 
L5EF6:   .DB  039h 
L5EF7:   .DB  000h 
L5EF8:   .DB  072h 
L5EF9:   .DB  079h 
L5EFA:   .DB  000h 
L5EFB:   .DB  081h 
L5EFC:   .DB  020h 
L5EFD:   .DB  000h 
L5EFE:   .DB  084h 
L5EFF:   .DB  009h 
L5F00:   .DB  009h 
L5F01:   .DB  0A9h 
L5F02:   .DB  05Eh 
L5F03:   .DB  000h 
L5F04:   .DB  090h 
L5F05:   .DB  00Fh 
L5F06:   .DB  000h 
L5F07:   .DB  072h 
L5F08:   .DB  084h 
L5F09:   .DB  000h 
L5F0A:   .DB  073h 
L5F0B:   .DB  024h 
L5F0C:   .DB  000h 
L5F0D:   .DB  081h 
L5F0E:   .DB  020h 
L5F0F:   .DB  000h 
L5F10:   .DB  084h 
L5F11:   .DB  009h 
L5F12:   .DB  009h 
L5F13:   .DB  0A9h 
L5F14:   .DB  05Eh 
L5F15:   .DB  000h 
L5F16:   .DB  090h 
L5F17:   .DB  06Fh 
L5F18:   .DB  000h 
L5F19:   .DB  074h 
L5F1A:   .DB  003h 
L5F1B:   .DB  000h 
L5F1C:   .DB  074h 
L5F1D:   .DB  043h 
L5F1E:   .DB  000h 
L5F1F:   .DB  084h 
L5F20:   .DB  039h 
L5F21:   .DB  000h 
L5F22:   .DB  087h 
L5F23:   .DB  032h 
L5F24:   .DB  009h 
L5F25:   .DB  0A9h 
L5F26:   .DB  05Eh 
L5F27:   .DB  000h 
L5F28:   .DB  004h 
L5F29:   .DB  0F0h 
L5F2A:   .DB  000h 
L5F2B:   .DB  074h 
L5F2C:   .DB  070h 
L5F2D:   .DB  000h 
L5F2E:   .DB  075h 
L5F2F:   .DB  010h 
L5F30:   .DB  000h 
L5F31:   .DB  084h 
L5F32:   .DB  039h 
L5F33:   .DB  000h 
L5F34:   .DB  087h 
L5F35:   .DB  032h 
L5F36:   .DB  009h 
L5F37:   .DB  0A9h 
L5F38:   .DB  05Eh 
L5F39:   .DB  000h 
L5F3A:   .DB  060h 
L5F3B:   .DB  00Fh 
L5F3C:   .DB  000h 
L5F3D:   .DB  079h 
L5F3E:   .DB  058h 
L5F3F:   .DB  000h 
L5F40:   .DB  079h 
L5F41:   .DB  098h 
L5F42:   .DB  001h 
L5F43:   .DB  017h 
L5F44:   .DB  053h 
L5F45:   .DB  001h 
L5F46:   .DB  022h 
L5F47:   .DB  015h 
L5F48:   .DB  009h 
L5F49:   .DB  0A9h 
L5F4A:   .DB  05Eh 
L5F4B:   .DB  002h 
L5F4C:   .DB  013h 
L5F4D:   .DB  031h 
L5F4E:   .DB  002h 
L5F4F:   .DB  033h 
L5F50:   .DB  021h 
L5F51:   .DB  002h 
L5F52:   .DB  007h 
L5F53:   .DB  041h 
L5F54:   .DB  000h 
L5F55:   .DB  000h 
L5F56:   .DB  000h 
L5F57:   .DB  033h 
L5F58:   .DB  000h 
L5F59:   .DB  000h 
L5F5A:   .DB  000h 
L5F5B:   .DB  002h 
L5F5C:   .DB  012h 
L5F5D:   .DB  040h 
L5F5E:   .DB  000h 
L5F5F:   .DB  000h 
L5F60:   .DB  000h 
L5F61:   .DB  000h 
L5F62:   .DB  000h 
L5F63:   .DB  000h 
L5F64:   .DB  000h 
L5F65:   .DB  000h 
L5F66:   .DB  000h 
L5F67:   .DB  000h 
L5F68:   .DB  000h 
L5F69:   .DB  000h 
L5F6A:   .DB  000h 
L5F6B:   .DB  060h 
L5F6C:   .DB  00Fh 
L5F6D:   .DB  002h 
L5F6E:   .DB  015h 
L5F6F:   .DB  053h 
L5F70:   .DB  002h 
L5F71:   .DB  015h 
L5F72:   .DB  083h 
L5F73:   .DB  002h 
L5F74:   .DB  033h 
L5F75:   .DB  058h 
L5F76:   .DB  002h 
L5F77:   .DB  036h 
L5F78:   .DB  040h 
L5F79:   .DB  033h 
L5F7A:   .DB  058h 
L5F7B:   .DB  05Fh 
L5F7C:   .DB  000h 
L5F7D:   .DB  000h 
L5F7E:   .DB  000h 
L5F7F:   .DB  002h 
L5F80:   .DB  015h 
L5F81:   .DB  070h 
L5F82:   .DB  002h 
L5F83:   .DB  016h 
L5F84:   .DB  000h 
L5F85:   .DB  002h 
L5F86:   .DB  033h 
L5F87:   .DB  058h 
L5F88:   .DB  002h 
L5F89:   .DB  036h 
L5F8A:   .DB  040h 
L5F8B:   .DB  033h 
L5F8C:   .DB  058h 
L5F8D:   .DB  05Fh 
L5F8E:   .DB  000h 
L5F8F:   .DB  060h 
L5F90:   .DB  00Fh 
L5F91:   .DB  002h 
L5F92:   .DB  015h 
L5F93:   .DB  094h 
L5F94:   .DB  002h 
L5F95:   .DB  016h 
L5F96:   .DB  014h 
L5F97:   .DB  002h 
L5F98:   .DB  033h 
L5F99:   .DB  058h 
L5F9A:   .DB  002h 
L5F9B:   .DB  036h 
L5F9C:   .DB  040h 
L5F9D:   .DB  033h 
L5F9E:   .DB  058h 
L5F9F:   .DB  05Fh 
L5FA0:   .DB  000h 
L5FA1:   .DB  004h 
L5FA2:   .DB  0F0h 
L5FA3:   .DB  002h 
L5FA4:   .DB  016h 
L5FA5:   .DB  040h 
L5FA6:   .DB  002h 
L5FA7:   .DB  016h 
L5FA8:   .DB  070h 
L5FA9:   .DB  002h 
L5FAA:   .DB  033h 
L5FAB:   .DB  058h 
L5FAC:   .DB  002h 
L5FAD:   .DB  036h 
L5FAE:   .DB  040h 
L5FAF:   .DB  033h 
L5FB0:   .DB  058h 
L5FB1:   .DB  05Fh 
L5FB2:   .DB  000h 
L5FB3:   .DB  004h 
L5FB4:   .DB  0F0h 
L5FB5:   .DB  002h 
L5FB6:   .DB  016h 
L5FB7:   .DB  069h 
L5FB8:   .DB  002h 
L5FB9:   .DB  016h 
L5FBA:   .DB  099h 
L5FBB:   .DB  002h 
L5FBC:   .DB  033h 
L5FBD:   .DB  058h 
L5FBE:   .DB  002h 
L5FBF:   .DB  036h 
L5FC0:   .DB  040h 
L5FC1:   .DB  033h 
L5FC2:   .DB  058h 
L5FC3:   .DB  05Fh 
L5FC4:   .DB  000h 
L5FC5:   .DB  004h 
L5FC6:   .DB  0F0h 
L5FC7:   .DB  002h 
L5FC8:   .DB  016h 
L5FC9:   .DB  098h 
L5FCA:   .DB  002h 
L5FCB:   .DB  017h 
L5FCC:   .DB  028h 
L5FCD:   .DB  002h 
L5FCE:   .DB  033h 
L5FCF:   .DB  058h 
L5FD0:   .DB  002h 
L5FD1:   .DB  036h 
L5FD2:   .DB  040h 
L5FD3:   .DB  033h 
L5FD4:   .DB  058h 
L5FD5:   .DB  05Fh 
L5FD6:   .DB  000h 
L5FD7:   .DB  004h 
L5FD8:   .DB  0F0h 
L5FD9:   .DB  002h 
L5FDA:   .DB  017h 
L5FDB:   .DB  027h 
L5FDC:   .DB  002h 
L5FDD:   .DB  017h 
L5FDE:   .DB  057h 
L5FDF:   .DB  002h 
L5FE0:   .DB  033h 
L5FE1:   .DB  058h 
L5FE2:   .DB  002h 
L5FE3:   .DB  036h 
L5FE4:   .DB  040h 
L5FE5:   .DB  033h 
L5FE6:   .DB  058h 
L5FE7:   .DB  05Fh 
L5FE8:   .DB  000h 
L5FE9:   .DB  060h 
L5FEA:   .DB  00Fh 
L5FEB:   .DB  002h 
L5FEC:   .DB  018h 
L5FED:   .DB  026h 
L5FEE:   .DB  002h 
L5FEF:   .DB  018h 
L5FF0:   .DB  056h 
L5FF1:   .DB  002h 
L5FF2:   .DB  033h 
L5FF3:   .DB  058h 
L5FF4:   .DB  002h 
L5FF5:   .DB  036h 
L5FF6:   .DB  040h 
L5FF7:   .DB  033h 
L5FF8:   .DB  058h 
L5FF9:   .DB  05Fh 
L5FFA:   .DB  000h 
L5FFB:   .DB  000h 
L5FFC:   .DB  000h 
L5FFD:   .DB  002h 
L5FFE:   .DB  018h 
L5FFF:   .DB  097h 
L6000:   .DB  000h 
L6001:   .DB  000h 
L6002:   .DB  000h 
L6003:   .DB  000h 
L6004:   .DB  000h 
L6005:   .DB  000h 
L6006:   .DB  000h 
L6007:   .DB  000h 
L6008:   .DB  000h 
L6009:   .DB  000h 
L600A:   .DB  000h 
L600B:   .DB  000h 
L600C:   .DB  000h 
L600D:   .DB  060h 
L600E:   .DB  00Fh 
L600F:   .DB  002h 
L6010:   .DB  020h 
L6011:   .DB  004h 
L6012:   .DB  002h 
L6013:   .DB  020h 
L6014:   .DB  034h 
L6015:   .DB  002h 
L6016:   .DB  033h 
L6017:   .DB  058h 
L6018:   .DB  002h 
L6019:   .DB  036h 
L601A:   .DB  040h 
L601B:   .DB  02Ah 
L601C:   .DB  0FAh 
L601D:   .DB  05Fh 
L601E:   .DB  000h 
L601F:   .DB  004h 
L6020:   .DB  0F0h 
L6021:   .DB  002h 
L6022:   .DB  020h 
L6023:   .DB  050h 
L6024:   .DB  002h 
L6025:   .DB  020h 
L6026:   .DB  080h 
L6027:   .DB  002h 
L6028:   .DB  033h 
L6029:   .DB  058h 
L602A:   .DB  002h 
L602B:   .DB  036h 
L602C:   .DB  040h 
L602D:   .DB  02Ah 
L602E:   .DB  0FAh 
L602F:   .DB  05Fh 
L6030:   .DB  000h 
L6031:   .DB  000h 
L6032:   .DB  000h 
L6033:   .DB  002h 
L6034:   .DB  020h 
L6035:   .DB  065h 
L6036:   .DB  002h 
L6037:   .DB  020h 
L6038:   .DB  095h 
L6039:   .DB  002h 
L603A:   .DB  033h 
L603B:   .DB  058h 
L603C:   .DB  002h 
L603D:   .DB  036h 
L603E:   .DB  040h 
L603F:   .DB  02Ah 
L6040:   .DB  0FAh 
L6041:   .DB  05Fh 
L6042:   .DB  000h 
L6043:   .DB  060h 
L6044:   .DB  00Fh 
L6045:   .DB  002h 
L6046:   .DB  020h 
L6047:   .DB  097h 
L6048:   .DB  002h 
L6049:   .DB  021h 
L604A:   .DB  017h 
L604B:   .DB  002h 
L604C:   .DB  033h 
L604D:   .DB  058h 
L604E:   .DB  002h 
L604F:   .DB  036h 
L6050:   .DB  040h 
L6051:   .DB  02Ah 
L6052:   .DB  0FAh 
L6053:   .DB  05Fh 
L6054:   .DB  000h 
L6055:   .DB  060h 
L6056:   .DB  00Fh 
L6057:   .DB  002h 
L6058:   .DB  021h 
L6059:   .DB  002h 
L605A:   .DB  002h 
L605B:   .DB  021h 
L605C:   .DB  032h 
L605D:   .DB  002h 
L605E:   .DB  033h 
L605F:   .DB  058h 
L6060:   .DB  002h 
L6061:   .DB  036h 
L6062:   .DB  040h 
L6063:   .DB  02Ah 
L6064:   .DB  0FAh 
L6065:   .DB  05Fh 
L6066:   .DB  000h 
L6067:   .DB  060h 
L6068:   .DB  00Fh 
L6069:   .DB  002h 
L606A:   .DB  021h 
L606B:   .DB  046h 
L606C:   .DB  002h 
L606D:   .DB  021h 
L606E:   .DB  076h 
L606F:   .DB  002h 
L6070:   .DB  033h 
L6071:   .DB  058h 
L6072:   .DB  002h 
L6073:   .DB  036h 
L6074:   .DB  040h 
L6075:   .DB  02Ah 
L6076:   .DB  0FAh 
L6077:   .DB  05Fh 
L6078:   .DB  000h 
L6079:   .DB  060h 
L607A:   .DB  00Fh 
L607B:   .DB  002h 
L607C:   .DB  021h 
L607D:   .DB  060h 
L607E:   .DB  002h 
L607F:   .DB  021h 
L6080:   .DB  090h 
L6081:   .DB  002h 
L6082:   .DB  033h 
L6083:   .DB  058h 
L6084:   .DB  002h 
L6085:   .DB  036h 
L6086:   .DB  040h 
L6087:   .DB  02Ah 
L6088:   .DB  0FAh 
L6089:   .DB  05Fh 
L608A:   .DB  000h 
L608B:   .DB  000h 
L608C:   .DB  000h 
L608D:   .DB  002h 
L608E:   .DB  022h 
L608F:   .DB  024h 
L6090:   .DB  000h 
L6091:   .DB  000h 
L6092:   .DB  000h 
L6093:   .DB  000h 
L6094:   .DB  000h 
L6095:   .DB  000h 
L6096:   .DB  000h 
L6097:   .DB  000h 
L6098:   .DB  000h 
L6099:   .DB  000h 
L609A:   .DB  000h 
L609B:   .DB  000h 
L609C:   .DB  000h 
L609D:   .DB  060h 
L609E:   .DB  00Fh 
L609F:   .DB  002h 
L60A0:   .DB  022h 
L60A1:   .DB  037h 
L60A2:   .DB  002h 
L60A3:   .DB  022h 
L60A4:   .DB  067h 
L60A5:   .DB  002h 
L60A6:   .DB  033h 
L60A7:   .DB  058h 
L60A8:   .DB  002h 
L60A9:   .DB  036h 
L60AA:   .DB  040h 
L60AB:   .DB  022h 
L60AC:   .DB  08Ah 
L60AD:   .DB  060h 
L60AE:   .DB  000h 
L60AF:   .DB  000h 
L60B0:   .DB  000h 
L60B1:   .DB  002h 
L60B2:   .DB  022h 
L60B3:   .DB  050h 
L60B4:   .DB  002h 
L60B5:   .DB  022h 
L60B6:   .DB  080h 
L60B7:   .DB  002h 
L60B8:   .DB  033h 
L60B9:   .DB  058h 
L60BA:   .DB  002h 
L60BB:   .DB  036h 
L60BC:   .DB  040h 
L60BD:   .DB  022h 
L60BE:   .DB  08Ah 
L60BF:   .DB  060h 
L60C0:   .DB  000h 
L60C1:   .DB  060h 
L60C2:   .DB  00Fh 
L60C3:   .DB  002h 
L60C4:   .DB  022h 
L60C5:   .DB  064h 
L60C6:   .DB  002h 
L60C7:   .DB  022h 
L60C8:   .DB  094h 
L60C9:   .DB  002h 
L60CA:   .DB  033h 
L60CB:   .DB  058h 
L60CC:   .DB  002h 
L60CD:   .DB  036h 
L60CE:   .DB  040h 
L60CF:   .DB  022h 
L60D0:   .DB  08Ah 
L60D1:   .DB  060h 
L60D2:   .DB  000h 
L60D3:   .DB  004h 
L60D4:   .DB  0F0h 
L60D5:   .DB  002h 
L60D6:   .DB  023h 
L60D7:   .DB  026h 
L60D8:   .DB  002h 
L60D9:   .DB  023h 
L60DA:   .DB  056h 
L60DB:   .DB  002h 
L60DC:   .DB  033h 
L60DD:   .DB  058h 
L60DE:   .DB  002h 
L60DF:   .DB  036h 
L60E0:   .DB  040h 
L60E1:   .DB  022h 
L60E2:   .DB  08Ah 
L60E3:   .DB  060h 
L60E4:   .DB  000h 
L60E5:   .DB  004h 
L60E6:   .DB  0F0h 
L60E7:   .DB  002h 
L60E8:   .DB  023h 
L60E9:   .DB  045h 
L60EA:   .DB  002h 
L60EB:   .DB  023h 
L60EC:   .DB  075h 
L60ED:   .DB  002h 
L60EE:   .DB  033h 
L60EF:   .DB  058h 
L60F0:   .DB  002h 
L60F1:   .DB  036h 
L60F2:   .DB  040h 
L60F3:   .DB  022h 
L60F4:   .DB  08Ah 
L60F5:   .DB  060h 
L60F6:   .DB  000h 
L60F7:   .DB  004h 
L60F8:   .DB  0F0h 
L60F9:   .DB  002h 
L60FA:   .DB  023h 
L60FB:   .DB  084h 
L60FC:   .DB  002h 
L60FD:   .DB  024h 
L60FE:   .DB  004h 
L60FF:   .DB  002h 
L6100:   .DB  033h 
L6101:   .DB  058h 
L6102:   .DB  002h 
L6103:   .DB  036h 
L6104:   .DB  040h 
L6105:   .DB  022h 
L6106:   .DB  08Ah 
L6107:   .DB  060h 
L6108:   .DB  000h 
L6109:   .DB  004h 
L610A:   .DB  0F0h 
L610B:   .DB  002h 
L610C:   .DB  024h 
L610D:   .DB  003h 
L610E:   .DB  002h 
L610F:   .DB  024h 
L6110:   .DB  033h 
L6111:   .DB  002h 
L6112:   .DB  033h 
L6113:   .DB  058h 
L6114:   .DB  002h 
L6115:   .DB  036h 
L6116:   .DB  040h 
L6117:   .DB  022h 
L6118:   .DB  08Ah 
L6119:   .DB  060h 
L611A:   .DB  000h 
L611B:   .DB  060h 
L611C:   .DB  00Fh 
L611D:   .DB  002h 
L611E:   .DB  024h 
L611F:   .DB  024h 
L6120:   .DB  002h 
L6121:   .DB  024h 
L6122:   .DB  054h 
L6123:   .DB  002h 
L6124:   .DB  033h 
L6125:   .DB  058h 
L6126:   .DB  002h 
L6127:   .DB  036h 
L6128:   .DB  040h 
L6129:   .DB  022h 
L612A:   .DB  08Ah 
L612B:   .DB  060h 
L612C:   .DB  000h 
L612D:   .DB  000h 
L612E:   .DB  000h 
L612F:   .DB  002h 
L6130:   .DB  024h 
L6131:   .DB  092h 
L6132:   .DB  000h 
L6133:   .DB  000h 
L6134:   .DB  000h 
L6135:   .DB  000h 
L6136:   .DB  000h 
L6137:   .DB  000h 
L6138:   .DB  000h 
L6139:   .DB  000h 
L613A:   .DB  000h 
L613B:   .DB  000h 
L613C:   .DB  000h 
L613D:   .DB  000h 
L613E:   .DB  000h 
L613F:   .DB  008h 
L6140:   .DB  0F7h 
L6141:   .DB  002h 
L6142:   .DB  024h 
L6143:   .DB  094h 
L6144:   .DB  002h 
L6145:   .DB  025h 
L6146:   .DB  024h 
L6147:   .DB  002h 
L6148:   .DB  033h 
L6149:   .DB  058h 
L614A:   .DB  002h 
L614B:   .DB  036h 
L614C:   .DB  040h 
L614D:   .DB  019h 
L614E:   .DB  02Ch 
L614F:   .DB  061h 
L6150:   .DB  000h 
L6151:   .DB  060h 
L6152:   .DB  00Fh 
L6153:   .DB  002h 
L6154:   .DB  025h 
L6155:   .DB  000h 
L6156:   .DB  002h 
L6157:   .DB  025h 
L6158:   .DB  030h 
L6159:   .DB  002h 
L615A:   .DB  033h 
L615B:   .DB  058h 
L615C:   .DB  002h 
L615D:   .DB  036h 
L615E:   .DB  040h 
L615F:   .DB  019h 
L6160:   .DB  02Ch 
L6161:   .DB  061h 
L6162:   .DB  000h 
L6163:   .DB  004h 
L6164:   .DB  0F0h 
L6165:   .DB  002h 
L6166:   .DB  025h 
L6167:   .DB  038h 
L6168:   .DB  002h 
L6169:   .DB  025h 
L616A:   .DB  068h 
L616B:   .DB  002h 
L616C:   .DB  033h 
L616D:   .DB  058h 
L616E:   .DB  002h 
L616F:   .DB  036h 
L6170:   .DB  040h 
L6171:   .DB  019h 
L6172:   .DB  02Ch 
L6173:   .DB  061h 
L6174:   .DB  000h 
L6175:   .DB  000h 
L6176:   .DB  000h 
L6177:   .DB  002h 
L6178:   .DB  025h 
L6179:   .DB  056h 
L617A:   .DB  002h 
L617B:   .DB  025h 
L617C:   .DB  086h 
L617D:   .DB  002h 
L617E:   .DB  033h 
L617F:   .DB  058h 
L6180:   .DB  002h 
L6181:   .DB  036h 
L6182:   .DB  040h 
L6183:   .DB  019h 
L6184:   .DB  02Ch 
L6185:   .DB  061h 
L6186:   .DB  000h 
L6187:   .DB  060h 
L6188:   .DB  00Fh 
L6189:   .DB  002h 
L618A:   .DB  025h 
L618B:   .DB  080h 
L618C:   .DB  002h 
L618D:   .DB  026h 
L618E:   .DB  010h 
L618F:   .DB  002h 
L6190:   .DB  033h 
L6191:   .DB  058h 
L6192:   .DB  002h 
L6193:   .DB  036h 
L6194:   .DB  040h 
L6195:   .DB  019h 
L6196:   .DB  02Ch 
L6197:   .DB  061h 
L6198:   .DB  000h 
L6199:   .DB  060h 
L619A:   .DB  00Fh 
L619B:   .DB  002h 
L619C:   .DB  025h 
L619D:   .DB  092h 
L619E:   .DB  002h 
L619F:   .DB  026h 
L61A0:   .DB  022h 
L61A1:   .DB  002h 
L61A2:   .DB  033h 
L61A3:   .DB  058h 
L61A4:   .DB  002h 
L61A5:   .DB  036h 
L61A6:   .DB  040h 
L61A7:   .DB  019h 
L61A8:   .DB  02Ch 
L61A9:   .DB  061h 
L61AA:   .DB  000h 
L61AB:   .DB  060h 
L61AC:   .DB  00Fh 
L61AD:   .DB  002h 
L61AE:   .DB  026h 
L61AF:   .DB  010h 
L61B0:   .DB  002h 
L61B1:   .DB  026h 
L61B2:   .DB  040h 
L61B3:   .DB  002h 
L61B4:   .DB  033h 
L61B5:   .DB  058h 
L61B6:   .DB  002h 
L61B7:   .DB  036h 
L61B8:   .DB  040h 
L61B9:   .DB  019h 
L61BA:   .DB  02Ch 
L61BB:   .DB  061h 
L61BC:   .DB  000h 
L61BD:   .DB  000h 
L61BE:   .DB  000h 
L61BF:   .DB  002h 
L61C0:   .DB  026h 
L61C1:   .DB  083h 
L61C2:   .DB  000h 
L61C3:   .DB  000h 
L61C4:   .DB  000h 
L61C5:   .DB  000h 
L61C6:   .DB  000h 
L61C7:   .DB  000h 
L61C8:   .DB  000h 
L61C9:   .DB  000h 
L61CA:   .DB  000h 
L61CB:   .DB  000h 
L61CC:   .DB  000h 
L61CD:   .DB  000h 
L61CE:   .DB  000h 
L61CF:   .DB  000h 
L61D0:   .DB  000h 
L61D1:   .DB  002h 
L61D2:   .DB  026h 
L61D3:   .DB  089h 
L61D4:   .DB  002h 
L61D5:   .DB  027h 
L61D6:   .DB  019h 
L61D7:   .DB  002h 
L61D8:   .DB  033h 
L61D9:   .DB  058h 
L61DA:   .DB  002h 
L61DB:   .DB  036h 
L61DC:   .DB  040h 
L61DD:   .DB  011h 
L61DE:   .DB  0BCh 
L61DF:   .DB  061h 
L61E0:   .DB  000h 
L61E1:   .DB  060h 
L61E2:   .DB  00Fh 
L61E3:   .DB  002h 
L61E4:   .DB  027h 
L61E5:   .DB  002h 
L61E6:   .DB  002h 
L61E7:   .DB  027h 
L61E8:   .DB  032h 
L61E9:   .DB  002h 
L61EA:   .DB  033h 
L61EB:   .DB  058h 
L61EC:   .DB  002h 
L61ED:   .DB  036h 
L61EE:   .DB  040h 
L61EF:   .DB  011h 
L61F0:   .DB  0BCh 
L61F1:   .DB  061h 
L61F2:   .DB  000h 
L61F3:   .DB  060h 
L61F4:   .DB  00Fh 
L61F5:   .DB  002h 
L61F6:   .DB  027h 
L61F7:   .DB  030h 
L61F8:   .DB  002h 
L61F9:   .DB  027h 
L61FA:   .DB  060h 
L61FB:   .DB  002h 
L61FC:   .DB  033h 
L61FD:   .DB  058h 
L61FE:   .DB  002h 
L61FF:   .DB  036h 
L6200:   .DB  040h 
L6201:   .DB  011h 
L6202:   .DB  0BCh 
L6203:   .DB  061h 
L6204:   .DB  000h 
L6205:   .DB  004h 
L6206:   .DB  0F0h 
L6207:   .DB  002h 
L6208:   .DB  027h 
L6209:   .DB  050h 
L620A:   .DB  002h 
L620B:   .DB  027h 
L620C:   .DB  080h 
L620D:   .DB  002h 
L620E:   .DB  033h 
L620F:   .DB  058h 
L6210:   .DB  002h 
L6211:   .DB  036h 
L6212:   .DB  040h 
L6213:   .DB  011h 
L6214:   .DB  0BCh 
L6215:   .DB  061h 
L6216:   .DB  000h 
L6217:   .DB  004h 
L6218:   .DB  0F0h 
L6219:   .DB  002h 
L621A:   .DB  027h 
L621B:   .DB  084h 
L621C:   .DB  002h 
L621D:   .DB  028h 
L621E:   .DB  014h 
L621F:   .DB  002h 
L6220:   .DB  033h 
L6221:   .DB  058h 
L6222:   .DB  002h 
L6223:   .DB  036h 
L6224:   .DB  040h 
L6225:   .DB  011h 
L6226:   .DB  0BCh 
L6227:   .DB  061h 
L6228:   .DB  000h 
L6229:   .DB  060h 
L622A:   .DB  00Fh 
L622B:   .DB  002h 
L622C:   .DB  027h 
L622D:   .DB  094h 
L622E:   .DB  002h 
L622F:   .DB  028h 
L6230:   .DB  024h 
L6231:   .DB  002h 
L6232:   .DB  033h 
L6233:   .DB  058h 
L6234:   .DB  002h 
L6235:   .DB  036h 
L6236:   .DB  040h 
L6237:   .DB  011h 
L6238:   .DB  0BCh 
L6239:   .DB  061h 
L623A:   .DB  000h 
L623B:   .DB  060h 
L623C:   .DB  00Fh 
L623D:   .DB  002h 
L623E:   .DB  028h 
L623F:   .DB  045h 
L6240:   .DB  002h 
L6241:   .DB  028h 
L6242:   .DB  075h 
L6243:   .DB  002h 
L6244:   .DB  033h 
L6245:   .DB  058h 
L6246:   .DB  002h 
L6247:   .DB  036h 
L6248:   .DB  040h 
L6249:   .DB  011h 
L624A:   .DB  0BCh 
L624B:   .DB  061h 
L624C:   .DB  000h 
L624D:   .DB  000h 
L624E:   .DB  000h 
L624F:   .DB  002h 
L6250:   .DB  029h 
L6251:   .DB  025h 
L6252:   .DB  000h 
L6253:   .DB  000h 
L6254:   .DB  000h 
L6255:   .DB  000h 
L6256:   .DB  000h 
L6257:   .DB  000h 
L6258:   .DB  000h 
L6259:   .DB  000h 
L625A:   .DB  000h 
L625B:   .DB  000h 
L625C:   .DB  000h 
L625D:   .DB  000h 
L625E:   .DB  000h 
L625F:   .DB  008h 
L6260:   .DB  0F7h 
L6261:   .DB  002h 
L6262:   .DB  029h 
L6263:   .DB  041h 
L6264:   .DB  002h 
L6265:   .DB  029h 
L6266:   .DB  071h 
L6267:   .DB  002h 
L6268:   .DB  033h 
L6269:   .DB  058h 
L626A:   .DB  002h 
L626B:   .DB  036h 
L626C:   .DB  040h 
L626D:   .DB  009h 
L626E:   .DB  04Ch 
L626F:   .DB  062h 
L6270:   .DB  000h 
L6271:   .DB  060h 
L6272:   .DB  00Fh 
L6273:   .DB  002h 
L6274:   .DB  029h 
L6275:   .DB  055h 
L6276:   .DB  002h 
L6277:   .DB  029h 
L6278:   .DB  085h 
L6279:   .DB  002h 
L627A:   .DB  033h 
L627B:   .DB  058h 
L627C:   .DB  002h 
L627D:   .DB  036h 
L627E:   .DB  040h 
L627F:   .DB  009h 
L6280:   .DB  04Ch 
L6281:   .DB  062h 
L6282:   .DB  000h 
L6283:   .DB  004h 
L6284:   .DB  0F0h 
L6285:   .DB  002h 
L6286:   .DB  029h 
L6287:   .DB  095h 
L6288:   .DB  002h 
L6289:   .DB  030h 
L628A:   .DB  025h 
L628B:   .DB  002h 
L628C:   .DB  033h 
L628D:   .DB  058h 
L628E:   .DB  002h 
L628F:   .DB  036h 
L6290:   .DB  040h 
L6291:   .DB  009h 
L6292:   .DB  04Ch 
L6293:   .DB  062h 
L6294:   .DB  000h 
L6295:   .DB  060h 
L6296:   .DB  00Fh 
L6297:   .DB  002h 
L6298:   .DB  030h 
L6299:   .DB  010h 
L629A:   .DB  002h 
L629B:   .DB  030h 
L629C:   .DB  040h 
L629D:   .DB  002h 
L629E:   .DB  033h 
L629F:   .DB  058h 
L62A0:   .DB  002h 
L62A1:   .DB  036h 
L62A2:   .DB  040h 
L62A3:   .DB  009h 
L62A4:   .DB  04Ch 
L62A5:   .DB  062h 
L62A6:   .DB  000h 
L62A7:   .DB  060h 
L62A8:   .DB  00Fh 
L62A9:   .DB  002h 
L62AA:   .DB  030h 
L62AB:   .DB  035h 
L62AC:   .DB  002h 
L62AD:   .DB  030h 
L62AE:   .DB  065h 
L62AF:   .DB  002h 
L62B0:   .DB  033h 
L62B1:   .DB  058h 
L62B2:   .DB  002h 
L62B3:   .DB  036h 
L62B4:   .DB  040h 
L62B5:   .DB  009h 
L62B6:   .DB  04Ch 
L62B7:   .DB  062h 
L62B8:   .DB  000h 
L62B9:   .DB  060h 
L62BA:   .DB  00Fh 
L62BB:   .DB  002h 
L62BC:   .DB  030h 
L62BD:   .DB  046h 
L62BE:   .DB  002h 
L62BF:   .DB  030h 
L62C0:   .DB  076h 
L62C1:   .DB  002h 
L62C2:   .DB  033h 
L62C3:   .DB  058h 
L62C4:   .DB  002h 
L62C5:   .DB  036h 
L62C6:   .DB  040h 
L62C7:   .DB  009h 
L62C8:   .DB  04Ch 
L62C9:   .DB  062h 
L62CA:   .DB  000h 
L62CB:   .DB  060h 
L62CC:   .DB  00Fh 
L62CD:   .DB  002h 
L62CE:   .DB  030h 
L62CF:   .DB  058h 
L62D0:   .DB  002h 
L62D1:   .DB  030h 
L62D2:   .DB  088h 
L62D3:   .DB  002h 
L62D4:   .DB  033h 
L62D5:   .DB  058h 
L62D6:   .DB  002h 
L62D7:   .DB  036h 
L62D8:   .DB  040h 
L62D9:   .DB  009h 
L62DA:   .DB  04Ch 
L62DB:   .DB  062h 
L62DC:   .DB  000h 
L62DD:   .DB  060h 
L62DE:   .DB  00Fh 
L62DF:   .DB  002h 
L62E0:   .DB  031h 
L62E1:   .DB  048h 
L62E2:   .DB  002h 
L62E3:   .DB  031h 
L62E4:   .DB  078h 
L62E5:   .DB  002h 
L62E6:   .DB  033h 
L62E7:   .DB  058h 
L62E8:   .DB  002h 
L62E9:   .DB  036h 
L62EA:   .DB  040h 
L62EB:   .DB  009h 
L62EC:   .DB  04Ch 
L62ED:   .DB  062h 
L62EE:   .DB  002h 
L62EF:   .DB  088h 
L62F0:   .DB  036h 
L62F1:   .DB  003h 
L62F2:   .DB  012h 
L62F3:   .DB  012h 
L62F4:   .DB  002h 
L62F5:   .DB  083h 
L62F6:   .DB  063h 
L62F7:   .DB  002h 
L62F8:   .DB  085h 
L62F9:   .DB  010h 
L62FA:   .DB  00Ch 
L62FB:   .DB  000h 
L62FC:   .DB  000h 
L62FD:   .DB  000h 
L62FE:   .DB  002h 
L62FF:   .DB  088h 
L6300:   .DB  036h 
L6301:   .DB  000h 
L6302:   .DB  000h 
L6303:   .DB  000h 
L6304:   .DB  000h 
L6305:   .DB  000h 
L6306:   .DB  000h 
L6307:   .DB  000h 
L6308:   .DB  000h 
L6309:   .DB  000h 
L630A:   .DB  000h 
L630B:   .DB  000h 
L630C:   .DB  000h 
L630D:   .DB  000h 
L630E:   .DB  060h 
L630F:   .DB  00Fh 
L6310:   .DB  002h 
L6311:   .DB  089h 
L6312:   .DB  000h 
L6313:   .DB  002h 
L6314:   .DB  089h 
L6315:   .DB  030h 
L6316:   .DB  003h 
L6317:   .DB  012h 
L6318:   .DB  075h 
L6319:   .DB  003h 
L631A:   .DB  016h 
L631B:   .DB  019h 
L631C:   .DB  00Ch 
L631D:   .DB  0FBh 
L631E:   .DB  062h 
L631F:   .DB  000h 
L6320:   .DB  060h 
L6321:   .DB  00Fh 
L6322:   .DB  002h 
L6323:   .DB  094h 
L6324:   .DB  022h 
L6325:   .DB  002h 
L6326:   .DB  094h 
L6327:   .DB  052h 
L6328:   .DB  003h 
L6329:   .DB  012h 
L632A:   .DB  075h 
L632B:   .DB  003h 
L632C:   .DB  016h 
L632D:   .DB  019h 
L632E:   .DB  00Ch 
L632F:   .DB  0FBh 
L6330:   .DB  062h 
L6331:   .DB  000h 
L6332:   .DB  001h 
L6333:   .DB  0F0h 
L6334:   .DB  002h 
L6335:   .DB  096h 
L6336:   .DB  022h 
L6337:   .DB  002h 
L6338:   .DB  096h 
L6339:   .DB  052h 
L633A:   .DB  003h 
L633B:   .DB  012h 
L633C:   .DB  075h 
L633D:   .DB  003h 
L633E:   .DB  016h 
L633F:   .DB  019h 
L6340:   .DB  00Ch 
L6341:   .DB  0FBh 
L6342:   .DB  062h 
L6343:   .DB  000h 
L6344:   .DB  0F0h 
L6345:   .DB  00Fh 
L6346:   .DB  003h 
L6347:   .DB  000h 
L6348:   .DB  098h 
L6349:   .DB  003h 
L634A:   .DB  001h 
L634B:   .DB  028h 
L634C:   .DB  003h 
L634D:   .DB  019h 
L634E:   .DB  099h 
L634F:   .DB  003h 
L6350:   .DB  023h 
L6351:   .DB  079h 
L6352:   .DB  00Ch 
L6353:   .DB  0FBh 
L6354:   .DB  062h 
L6355:   .DB  000h 
L6356:   .DB  000h 
L6357:   .DB  000h 
L6358:   .DB  003h 
L6359:   .DB  004h 
L635A:   .DB  060h 
L635B:   .DB  000h 
L635C:   .DB  000h 
L635D:   .DB  000h 
L635E:   .DB  000h 
L635F:   .DB  000h 
L6360:   .DB  000h 
L6361:   .DB  000h 
L6362:   .DB  000h 
L6363:   .DB  000h 
L6364:   .DB  000h 
L6365:   .DB  000h 
L6366:   .DB  000h 
L6367:   .DB  000h 
L6368:   .DB  004h 
L6369:   .DB  0F0h 
L636A:   .DB  003h 
L636B:   .DB  007h 
L636C:   .DB  094h 
L636D:   .DB  003h 
L636E:   .DB  008h 
L636F:   .DB  014h 
L6370:   .DB  003h 
L6371:   .DB  019h 
L6372:   .DB  099h 
L6373:   .DB  003h 
L6374:   .DB  023h 
L6375:   .DB  079h 
L6376:   .DB  007h 
L6377:   .DB  055h 
L6378:   .DB  063h 
L6379:   .DB  000h 
L637A:   .DB  002h 
L637B:   .DB  0F0h 
L637C:   .DB  003h 
L637D:   .DB  008h 
L637E:   .DB  004h 
L637F:   .DB  003h 
L6380:   .DB  008h 
L6381:   .DB  034h 
L6382:   .DB  003h 
L6383:   .DB  019h 
L6384:   .DB  099h 
L6385:   .DB  003h 
L6386:   .DB  023h 
L6387:   .DB  079h 
L6388:   .DB  007h 
L6389:   .DB  055h 
L638A:   .DB  063h 
L638B:   .DB  000h 
L638C:   .DB  001h 
L638D:   .DB  0F0h 
L638E:   .DB  003h 
L638F:   .DB  008h 
L6390:   .DB  034h 
L6391:   .DB  003h 
L6392:   .DB  008h 
L6393:   .DB  064h 
L6394:   .DB  003h 
L6395:   .DB  019h 
L6396:   .DB  099h 
L6397:   .DB  003h 
L6398:   .DB  023h 
L6399:   .DB  079h 
L639A:   .DB  007h 
L639B:   .DB  055h 
L639C:   .DB  063h 
L639D:   .DB  000h 
L639E:   .DB  060h 
L639F:   .DB  00Fh 
L63A0:   .DB  003h 
L63A1:   .DB  008h 
L63A2:   .DB  090h 
L63A3:   .DB  003h 
L63A4:   .DB  009h 
L63A5:   .DB  020h 
L63A6:   .DB  003h 
L63A7:   .DB  023h 
L63A8:   .DB  099h 
L63A9:   .DB  003h 
L63AA:   .DB  026h 
L63AB:   .DB  092h 
L63AC:   .DB  007h 
L63AD:   .DB  055h 
L63AE:   .DB  063h 
L63AF:   .DB  000h 
L63B0:   .DB  000h 
L63B1:   .DB  000h 
L63B2:   .DB  003h 
L63B3:   .DB  009h 
L63B4:   .DB  054h 
L63B5:   .DB  000h 
L63B6:   .DB  000h 
L63B7:   .DB  000h 
L63B8:   .DB  000h 
L63B9:   .DB  000h 
L63BA:   .DB  000h 
L63BB:   .DB  000h 
L63BC:   .DB  000h 
L63BD:   .DB  000h 
L63BE:   .DB  000h 
L63BF:   .DB  000h 
L63C0:   .DB  000h 
L63C1:   .DB  000h 
L63C2:   .DB  008h 
L63C3:   .DB  0F0h 
L63C4:   .DB  003h 
L63C5:   .DB  010h 
L63C6:   .DB  063h 
L63C7:   .DB  003h 
L63C8:   .DB  010h 
L63C9:   .DB  093h 
L63CA:   .DB  003h 
L63CB:   .DB  027h 
L63CC:   .DB  097h 
L63CD:   .DB  003h 
L63CE:   .DB  031h 
L63CF:   .DB  002h 
L63D0:   .DB  002h 
L63D1:   .DB  0AFh 
L63D2:   .DB  063h 
L63D3:   .DB  003h 
L63D4:   .DB  035h 
L63D5:   .DB  050h 
L63D6:   .DB  003h 
L63D7:   .DB  071h 
L63D8:   .DB  038h 
L63D9:   .DB  003h 
L63DA:   .DB  031h 
L63DB:   .DB  005h 
L63DC:   .DB  003h 
L63DD:   .DB  032h 
L63DE:   .DB  052h 
L63DF:   .DB  01Fh 
L63E0:   .DB  000h 
L63E1:   .DB  000h 
L63E2:   .DB  000h 
L63E3:   .DB  003h 
L63E4:   .DB  035h 
L63E5:   .DB  025h 
L63E6:   .DB  000h 
L63E7:   .DB  000h 
L63E8:   .DB  000h 
L63E9:   .DB  000h 
L63EA:   .DB  000h 
L63EB:   .DB  000h 
L63EC:   .DB  000h 
L63ED:   .DB  000h 
L63EE:   .DB  000h 
L63EF:   .DB  000h 
L63F0:   .DB  000h 
L63F1:   .DB  000h 
L63F2:   .DB  000h 
L63F3:   .DB  060h 
L63F4:   .DB  00Fh 
L63F5:   .DB  003h 
L63F6:   .DB  036h 
L63F7:   .DB  068h 
L63F8:   .DB  003h 
L63F9:   .DB  036h 
L63FA:   .DB  098h 
L63FB:   .DB  003h 
L63FC:   .DB  071h 
L63FD:   .DB  092h 
L63FE:   .DB  003h 
L63FF:   .DB  075h 
L6400:   .DB  011h 
L6401:   .DB  01Fh 
L6402:   .DB  0E0h 
L6403:   .DB  063h 
L6404:   .DB  000h 
L6405:   .DB  090h 
L6406:   .DB  00Fh 
L6407:   .DB  003h 
L6408:   .DB  037h 
L6409:   .DB  004h 
L640A:   .DB  003h 
L640B:   .DB  037h 
L640C:   .DB  034h 
L640D:   .DB  003h 
L640E:   .DB  071h 
L640F:   .DB  092h 
L6410:   .DB  003h 
L6411:   .DB  075h 
L6412:   .DB  011h 
L6413:   .DB  01Fh 
L6414:   .DB  0E0h 
L6415:   .DB  063h 
L6416:   .DB  000h 
L6417:   .DB  000h 
L6418:   .DB  000h 
L6419:   .DB  003h 
L641A:   .DB  037h 
L641B:   .DB  010h 
L641C:   .DB  000h 
L641D:   .DB  000h 
L641E:   .DB  000h 
L641F:   .DB  000h 
L6420:   .DB  000h 
L6421:   .DB  000h 
L6422:   .DB  000h 
L6423:   .DB  000h 
L6424:   .DB  000h 
L6425:   .DB  01Fh 
L6426:   .DB  0E0h 
L6427:   .DB  063h 
L6428:   .DB  000h 
L6429:   .DB  090h 
L642A:   .DB  00Fh 
L642B:   .DB  003h 
L642C:   .DB  037h 
L642D:   .DB  020h 
L642E:   .DB  003h 
L642F:   .DB  037h 
L6430:   .DB  050h 
L6431:   .DB  003h 
L6432:   .DB  071h 
L6433:   .DB  092h 
L6434:   .DB  003h 
L6435:   .DB  075h 
L6436:   .DB  011h 
L6437:   .DB  01Fh 
L6438:   .DB  0E0h 
L6439:   .DB  063h 
L643A:   .DB  000h 
L643B:   .DB  060h 
L643C:   .DB  00Fh 
L643D:   .DB  003h 
L643E:   .DB  037h 
L643F:   .DB  033h 
L6440:   .DB  003h 
L6441:   .DB  037h 
L6442:   .DB  063h 
L6443:   .DB  003h 
L6444:   .DB  071h 
L6445:   .DB  092h 
L6446:   .DB  003h 
L6447:   .DB  075h 
L6448:   .DB  011h 
L6449:   .DB  01Fh 
L644A:   .DB  0E0h 
L644B:   .DB  063h 
L644C:   .DB  000h 
L644D:   .DB  001h 
L644E:   .DB  0F0h 
L644F:   .DB  003h 
L6450:   .DB  037h 
L6451:   .DB  060h 
L6452:   .DB  003h 
L6453:   .DB  037h 
L6454:   .DB  090h 
L6455:   .DB  003h 
L6456:   .DB  071h 
L6457:   .DB  092h 
L6458:   .DB  003h 
L6459:   .DB  075h 
L645A:   .DB  011h 
L645B:   .DB  01Fh 
L645C:   .DB  0E0h 
L645D:   .DB  063h 
L645E:   .DB  000h 
L645F:   .DB  060h 
L6460:   .DB  00Fh 
L6461:   .DB  003h 
L6462:   .DB  038h 
L6463:   .DB  024h 
L6464:   .DB  003h 
L6465:   .DB  038h 
L6466:   .DB  054h 
L6467:   .DB  003h 
L6468:   .DB  071h 
L6469:   .DB  092h 
L646A:   .DB  003h 
L646B:   .DB  075h 
L646C:   .DB  011h 
L646D:   .DB  01Fh 
L646E:   .DB  0E0h 
L646F:   .DB  063h 
L6470:   .DB  000h 
L6471:   .DB  090h 
L6472:   .DB  00Fh 
L6473:   .DB  003h 
L6474:   .DB  038h 
L6475:   .DB  030h 
L6476:   .DB  003h 
L6477:   .DB  038h 
L6478:   .DB  060h 
L6479:   .DB  003h 
L647A:   .DB  071h 
L647B:   .DB  092h 
L647C:   .DB  003h 
L647D:   .DB  075h 
L647E:   .DB  011h 
L647F:   .DB  01Fh 
L6480:   .DB  0E0h 
L6481:   .DB  063h 
L6482:   .DB  000h 
L6483:   .DB  008h 
L6484:   .DB  0F0h 
L6485:   .DB  003h 
L6486:   .DB  038h 
L6487:   .DB  040h 
L6488:   .DB  003h 
L6489:   .DB  038h 
L648A:   .DB  070h 
L648B:   .DB  003h 
L648C:   .DB  071h 
L648D:   .DB  092h 
L648E:   .DB  003h 
L648F:   .DB  075h 
L6490:   .DB  011h 
L6491:   .DB  01Fh 
L6492:   .DB  0E0h 
L6493:   .DB  063h 
L6494:   .DB  000h 
L6495:   .DB  090h 
L6496:   .DB  00Fh 
L6497:   .DB  003h 
L6498:   .DB  039h 
L6499:   .DB  022h 
L649A:   .DB  003h 
L649B:   .DB  039h 
L649C:   .DB  052h 
L649D:   .DB  003h 
L649E:   .DB  071h 
L649F:   .DB  092h 
L64A0:   .DB  003h 
L64A1:   .DB  075h 
L64A2:   .DB  011h 
L64A3:   .DB  01Fh 
L64A4:   .DB  0E0h 
L64A5:   .DB  063h 
L64A6:   .DB  000h 
L64A7:   .DB  001h 
L64A8:   .DB  0F0h 
L64A9:   .DB  003h 
L64AA:   .DB  039h 
L64AB:   .DB  038h 
L64AC:   .DB  003h 
L64AD:   .DB  039h 
L64AE:   .DB  068h 
L64AF:   .DB  003h 
L64B0:   .DB  071h 
L64B1:   .DB  092h 
L64B2:   .DB  003h 
L64B3:   .DB  075h 
L64B4:   .DB  011h 
L64B5:   .DB  01Fh 
L64B6:   .DB  0E0h 
L64B7:   .DB  063h 
L64B8:   .DB  000h 
L64B9:   .DB  000h 
L64BA:   .DB  000h 
L64BB:   .DB  003h 
L64BC:   .DB  039h 
L64BD:   .DB  090h 
L64BE:   .DB  000h 
L64BF:   .DB  000h 
L64C0:   .DB  000h 
L64C1:   .DB  000h 
L64C2:   .DB  000h 
L64C3:   .DB  000h 
L64C4:   .DB  000h 
L64C5:   .DB  000h 
L64C6:   .DB  000h 
L64C7:   .DB  000h 
L64C8:   .DB  000h 
L64C9:   .DB  000h 
L64CA:   .DB  000h 
L64CB:   .DB  001h 
L64CC:   .DB  0F0h 
L64CD:   .DB  003h 
L64CE:   .DB  040h 
L64CF:   .DB  030h 
L64D0:   .DB  003h 
L64D1:   .DB  040h 
L64D2:   .DB  060h 
L64D3:   .DB  003h 
L64D4:   .DB  071h 
L64D5:   .DB  092h 
L64D6:   .DB  003h 
L64D7:   .DB  075h 
L64D8:   .DB  011h 
L64D9:   .DB  013h 
L64DA:   .DB  0B8h 
L64DB:   .DB  064h 
L64DC:   .DB  000h 
L64DD:   .DB  090h 
L64DE:   .DB  00Fh 
L64DF:   .DB  003h 
L64E0:   .DB  041h 
L64E1:   .DB  000h 
L64E2:   .DB  003h 
L64E3:   .DB  041h 
L64E4:   .DB  030h 
L64E5:   .DB  003h 
L64E6:   .DB  071h 
L64E7:   .DB  092h 
L64E8:   .DB  003h 
L64E9:   .DB  075h 
L64EA:   .DB  011h 
L64EB:   .DB  013h 
L64EC:   .DB  0B8h 
L64ED:   .DB  064h 
L64EE:   .DB  000h 
L64EF:   .DB  008h 
L64F0:   .DB  0F0h 
L64F1:   .DB  003h 
L64F2:   .DB  041h 
L64F3:   .DB  030h 
L64F4:   .DB  003h 
L64F5:   .DB  041h 
L64F6:   .DB  060h 
L64F7:   .DB  003h 
L64F8:   .DB  071h 
L64F9:   .DB  092h 
L64FA:   .DB  003h 
L64FB:   .DB  075h 
L64FC:   .DB  011h 
L64FD:   .DB  013h 
L64FE:   .DB  0B8h 
L64FF:   .DB  064h 
L6500:   .DB  000h 
L6501:   .DB  060h 
L6502:   .DB  00Fh 
L6503:   .DB  003h 
L6504:   .DB  042h 
L6505:   .DB  086h 
L6506:   .DB  003h 
L6507:   .DB  043h 
L6508:   .DB  016h 
L6509:   .DB  003h 
L650A:   .DB  071h 
L650B:   .DB  092h 
L650C:   .DB  003h 
L650D:   .DB  075h 
L650E:   .DB  011h 
L650F:   .DB  013h 
L6510:   .DB  0B8h 
L6511:   .DB  064h 
L6512:   .DB  000h 
L6513:   .DB  008h 
L6514:   .DB  0F0h 
L6515:   .DB  003h 
L6516:   .DB  044h 
L6517:   .DB  002h 
L6518:   .DB  003h 
L6519:   .DB  044h 
L651A:   .DB  032h 
L651B:   .DB  003h 
L651C:   .DB  071h 
L651D:   .DB  092h 
L651E:   .DB  003h 
L651F:   .DB  075h 
L6520:   .DB  011h 
L6521:   .DB  013h 
L6522:   .DB  0B8h 
L6523:   .DB  064h 
L6524:   .DB  000h 
L6525:   .DB  000h 
L6526:   .DB  000h 
L6527:   .DB  003h 
L6528:   .DB  046h 
L6529:   .DB  020h 
L652A:   .DB  000h 
L652B:   .DB  000h 
L652C:   .DB  000h 
L652D:   .DB  000h 
L652E:   .DB  000h 
L652F:   .DB  000h 
L6530:   .DB  000h 
L6531:   .DB  000h 
L6532:   .DB  000h 
L6533:   .DB  000h 
L6534:   .DB  000h 
L6535:   .DB  000h 
L6536:   .DB  000h 
L6537:   .DB  060h 
L6538:   .DB  00Fh 
L6539:   .DB  003h 
L653A:   .DB  050h 
L653B:   .DB  012h 
L653C:   .DB  003h 
L653D:   .DB  050h 
L653E:   .DB  042h 
L653F:   .DB  003h 
L6540:   .DB  071h 
L6541:   .DB  092h 
L6542:   .DB  003h 
L6543:   .DB  075h 
L6544:   .DB  011h 
L6545:   .DB  00Dh 
L6546:   .DB  024h 
L6547:   .DB  065h 
L6548:   .DB  000h 
L6549:   .DB  002h 
L654A:   .DB  0F0h 
L654B:   .DB  003h 
L654C:   .DB  051h 
L654D:   .DB  070h 
L654E:   .DB  003h 
L654F:   .DB  052h 
L6550:   .DB  000h 
L6551:   .DB  003h 
L6552:   .DB  071h 
L6553:   .DB  092h 
L6554:   .DB  003h 
L6555:   .DB  075h 
L6556:   .DB  011h 
L6557:   .DB  00Dh 
L6558:   .DB  024h 
L6559:   .DB  065h 
L655A:   .DB  000h 
L655B:   .DB  060h 
L655C:   .DB  00Fh 
L655D:   .DB  003h 
L655E:   .DB  053h 
L655F:   .DB  074h 
L6560:   .DB  003h 
L6561:   .DB  054h 
L6562:   .DB  004h 
L6563:   .DB  003h 
L6564:   .DB  071h 
L6565:   .DB  092h 
L6566:   .DB  003h 
L6567:   .DB  075h 
L6568:   .DB  011h 
L6569:   .DB  00Dh 
L656A:   .DB  024h 
L656B:   .DB  065h 
L656C:   .DB  000h 
L656D:   .DB  090h 
L656E:   .DB  00Fh 
L656F:   .DB  003h 
L6570:   .DB  057h 
L6571:   .DB  085h 
L6572:   .DB  003h 
L6573:   .DB  058h 
L6574:   .DB  015h 
L6575:   .DB  003h 
L6576:   .DB  071h 
L6577:   .DB  092h 
L6578:   .DB  003h 
L6579:   .DB  075h 
L657A:   .DB  011h 
L657B:   .DB  00Dh 
L657C:   .DB  024h 
L657D:   .DB  065h 
L657E:   .DB  000h 
L657F:   .DB  090h 
L6580:   .DB  00Fh 
L6581:   .DB  003h 
L6582:   .DB  058h 
L6583:   .DB  073h 
L6584:   .DB  003h 
L6585:   .DB  059h 
L6586:   .DB  003h 
L6587:   .DB  003h 
L6588:   .DB  071h 
L6589:   .DB  092h 
L658A:   .DB  003h 
L658B:   .DB  075h 
L658C:   .DB  011h 
L658D:   .DB  00Dh 
L658E:   .DB  024h 
L658F:   .DB  065h 
L6590:   .DB  000h 
L6591:   .DB  090h 
L6592:   .DB  00Fh 
L6593:   .DB  003h 
L6594:   .DB  058h 
L6595:   .DB  089h 
L6596:   .DB  003h 
L6597:   .DB  059h 
L6598:   .DB  019h 
L6599:   .DB  003h 
L659A:   .DB  071h 
L659B:   .DB  092h 
L659C:   .DB  003h 
L659D:   .DB  075h 
L659E:   .DB  011h 
L659F:   .DB  00Dh 
L65A0:   .DB  024h 
L65A1:   .DB  065h 
L65A2:   .DB  000h 
L65A3:   .DB  060h 
L65A4:   .DB  00Fh 
L65A5:   .DB  003h 
L65A6:   .DB  059h 
L65A7:   .DB  055h 
L65A8:   .DB  003h 
L65A9:   .DB  059h 
L65AA:   .DB  085h 
L65AB:   .DB  003h 
L65AC:   .DB  097h 
L65AD:   .DB  027h 
L65AE:   .DB  004h 
L65AF:   .DB  001h 
L65B0:   .DB  084h 
L65B1:   .DB  00Dh 
L65B2:   .DB  024h 
L65B3:   .DB  065h 
L65B4:   .DB  000h 
L65B5:   .DB  000h 
L65B6:   .DB  000h 
L65B7:   .DB  003h 
L65B8:   .DB  060h 
L65B9:   .DB  020h 
L65BA:   .DB  000h 
L65BB:   .DB  000h 
L65BC:   .DB  000h 
L65BD:   .DB  000h 
L65BE:   .DB  000h 
L65BF:   .DB  000h 
L65C0:   .DB  000h 
L65C1:   .DB  000h 
L65C2:   .DB  000h 
L65C3:   .DB  000h 
L65C4:   .DB  000h 
L65C5:   .DB  000h 
L65C6:   .DB  000h 
L65C7:   .DB  060h 
L65C8:   .DB  00Fh 
L65C9:   .DB  003h 
L65CA:   .DB  061h 
L65CB:   .DB  064h 
L65CC:   .DB  003h 
L65CD:   .DB  061h 
L65CE:   .DB  094h 
L65CF:   .DB  003h 
L65D0:   .DB  071h 
L65D1:   .DB  092h 
L65D2:   .DB  003h 
L65D3:   .DB  075h 
L65D4:   .DB  011h 
L65D5:   .DB  005h 
L65D6:   .DB  0B4h 
L65D7:   .DB  065h 
L65D8:   .DB  000h 
L65D9:   .DB  008h 
L65DA:   .DB  0F0h 
L65DB:   .DB  003h 
L65DC:   .DB  063h 
L65DD:   .DB  027h 
L65DE:   .DB  003h 
L65DF:   .DB  063h 
L65E0:   .DB  057h 
L65E1:   .DB  003h 
L65E2:   .DB  071h 
L65E3:   .DB  092h 
L65E4:   .DB  003h 
L65E5:   .DB  075h 
L65E6:   .DB  011h 
L65E7:   .DB  005h 
L65E8:   .DB  0B4h 
L65E9:   .DB  065h 
L65EA:   .DB  000h 
L65EB:   .DB  060h 
L65EC:   .DB  00Fh 
L65ED:   .DB  003h 
L65EE:   .DB  064h 
L65EF:   .DB  077h 
L65F0:   .DB  003h 
L65F1:   .DB  065h 
L65F2:   .DB  007h 
L65F3:   .DB  003h 
L65F4:   .DB  071h 
L65F5:   .DB  092h 
L65F6:   .DB  003h 
L65F7:   .DB  075h 
L65F8:   .DB  011h 
L65F9:   .DB  005h 
L65FA:   .DB  0B4h 
L65FB:   .DB  065h 
L65FC:   .DB  000h 
L65FD:   .DB  008h 
L65FE:   .DB  0F0h 
L65FF:   .DB  003h 
L6600:   .DB  065h 
L6601:   .DB  093h 
L6602:   .DB  003h 
L6603:   .DB  066h 
L6604:   .DB  023h 
L6605:   .DB  003h 
L6606:   .DB  071h 
L6607:   .DB  092h 
L6608:   .DB  003h 
L6609:   .DB  075h 
L660A:   .DB  011h 
L660B:   .DB  005h 
L660C:   .DB  0B4h 
L660D:   .DB  065h 
L660E:   .DB  04Dh








;----------------------------------------------------
;        ROM 4 - Copyright location
;----------------------------------------------------
L660F:  .TEXT   "COPYRIGHT: STERN ELECTRONICS, INC."







;----------------------------------------------------
;            Frame Count Handler
;----------------------------------------------------
L6631:  XOR     A               ; A = 0
        LD      IX,0E158h       ; IX = E158?
        LD      (IX+000h),A     ; Clear E158?

;----------------------------------------------------
;         Do Digit Check on Even Frame Count
;----------------------------------------------------
        LD      HL,0E11Ch       ; Get Even Frame Count
        CALL    L6716           ; Call Frame Count Digit Check
        JP      C,L664E         ; Digits ok, so skip ahead
        SET     0,(IX+000h)     ; Set ERROR Flag Even
        LD      HL,0E11Ch       ; Point to Even Frame Count
        LD      A,0FEh          ; A = Filler erase byte
        CALL    L673B           ; Erase Frame Count

;----------------------------------------------------
;         Do Digit Check on Odd Frame Count
;----------------------------------------------------
L664E:  LD      HL,0E11Fh       ; Get Odd Frame Count
        CALL    L6716           ; Call Frame Count Digit Check
        JP      C,L6663         ; Digits ok, so skip ahead
        SET     1,(IX+000h)     ; Set ERROR Flag Odd
        LD      HL,0E11Fh       ; Point to Odd Frame Count
        LD      A,0EFh          ; A = Filler erase byte
        CALL    L673B           ; Erase Frame Count


L6663:  LD      A,(IX+000h)     ; Get ERROR Flags
L6666:  OR      A               ; Any Digit Errors detected?
        JP      NZ,L669F        ; Yes, so check target

;----------------------------------------------------
;            Are Frame Counts equal?  
;----------------------------------------------------
        LD      HL,0E11Ch       ; HL = Even Frame Count
        LD      DE,0E11Fh       ; DE = Odd Frame Count
        LD      B,003h          ; 3 Bytes to compare
L6672:  LD      A,(DE)          ; Get Odd Frame Count byte
        INC     DE              ; Point to next Odd Frame Count byte
        CP      (HL)            ; Compare Odd byte to Even Frame Count byte
        INC     HL              ; Point to next Even Frame Count byte
        JP      NZ,L669F        ; Bytes are different, so jump ahead
        DJNZ    L6672           ; Continuing comparing all bytes

;----------------------------------------------------
;        Even Frame Count = Odd Frame Count
;----------------------------------------------------
        LD      A,(0E159h)      ; Get Number of Frame Count Errors
        CP      00Ah            ; Have we had more than 10 errors?
        JR      NC,L668A        ; Yes, so skip ahead       
        LD      A,(0E126h)      ; Check Control Register
        BIT     1,A             ; Are timers enabled?
        JP      Z,L669F         ; No, so skip ahead

;----------------------------------------------------
;       Copy Even/Odd Frame Count into Frame Info
;----------------------------------------------------
L668A:  LD      HL,0E11Ch       ; HL = Even Frame Count
L668D:  LD      DE,0E116h       ; DE = Frame Count Location
        LD      BC,00003h       ; 3 Bytes to copy
        LDIR                    ; Perform loop copy

        LD      HL,0E126h       ; Get Control Register
        RES     1,(HL)          ; Clear Frame Count Wait

        XOR     A               ; A = 0
        LD      (0E159h),A      ; Clear Frame Count Errors

        RET                     ; Return







;----------------------------------------------------
;     Frame Counts not equal so use closest one
;----------------------------------------------------
L669F:  LD      A,(IX+000h)     ; Get ERROR Flags
        BIT     0,A             ; Digit error on Even Frame Count?
        JP      Z,L66AF         ; No, check Even proximity
        BIT     1,A             ; Digit error on Odd Frame Count
        JP      Z,L66C2         ; No, check Odd proximity
        JP      L66FC           ; Erase Frame Counts and Log Error

;----------------------------------------------------
;        Is Frame Count near target (E116h)?
;----------------------------------------------------
L66AF:  LD      HL,0E11Ch       ; Get Even Frame Count
        CALL    L6742           ; Check Proximity to Target Frame (E116)
        LD      HL,0E11Ch       ; Get Even Frame Count
        JP      C,L668D         ; Frame at Target, use Even Frame Count

        BIT     1,(IX+000h)     ; Is Odd Frame Count ok?
        JP      NZ,L66CE        ;
L66C2:  LD      HL,0E11Fh       ; Get Odd Frame Count
        CALL    L6742           ; Check Proximity to Target Frame (E116)
        LD      HL,0E11Fh       ; Get Odd Frame Count
        JP      C,L668D         ; Frame at Target, use Odd Frame Count


L66CE:  LD      A,(0E126h)      ; Get Control Register
        BIT     1,A             ;
        JP      Z,L66FC         ;

;----------------------------------------------------
;        Is Frame Count near target (E119h)?
;----------------------------------------------------
        LD      HL,0E11Ch       ; HL = Even Frame Count
        BIT     0,(IX+000h)     ; Is Even Frame Count ok?
        JP      NZ,L66E9        ; No, skip to Odd Frame Count
        CALL    L6747           ; Check Proximity to Target Frame (E119) 
        LD      HL,0E11Ch       ; HL = Even Frame Count
        JP      C,L668D         ; Frame at Target, use Even Frame Count

L66E9:  LD      HL,0E11Fh       ; HL = Odd Frame Count
        BIT     1,(IX+000h)     ; Is Odd Frame Count ok?
        JP      NZ,L66FC        ; No, skip ahead and erase all
        CALL    L6747           ; Check Proximity to Target Frame (E119) 
        LD      HL,0E11Fh       ; HL = Odd Frame Count
        JP      C,L668D         ; Frame at Target, use Odd Frame Count

;----------------------------------------------------
;        Erase All Frame Counts and Log Error
;----------------------------------------------------
L66FC:  LD      HL,0E11Ch       ; HL = Even Frame Count
        LD      A,0FEh          ; A = Dummy Erase Value (even)
        CALL    L673B           ; Erase Frame Count 
        LD      HL,0E11Fh       ; HL = Odd Frame Count
        LD      A,0EFh          ; A = Dummy Erase Value (odd)
        CALL    L673Bh          ; Erase Frame Count
        LD      A,(0E159h)      ; Get Number of Frame Errors
        INC     A               ; Add 1 to Frame Errors
        JR      Z,L6715         ; We've reached 255 Errors       
        LD      (0E159h),A      ; Save Frame Errors
L6715:  RET                     ; Return







;----------------------------------------------------
;            Frame Count Digit Check
;----------------------------------------------------
;  Check that all 5 digits are valid decimal numbers
;         HL = Pointer to Frame Count
;         Return:   Carry Set   = No Error
;                   Carry Clear = Error
;----------------------------------------------------
L6716:  LD      A,(HL)          ; Get Ones place
        CP      0F8h            ; Is Value Overflown?
        JP      C,L6739         ; Yes, jump ahead and return ERROR
        AND     007h            ; Isolate lower bits
        LD      (HL),A          ; Save Frame Value 10000's
        INC     HL              ; Go check next byte
        LD      A,(HL)          ; Get Frame byte
        AND     00Fh            ; Get lower nibble 100's
        CP      00Ah            ; Is digit < 10?
        RET     NC              ; No, so return ERROR
        LD      A,(HL)          ; Get Frame byte
        AND     0F0h            ; Get upper nibble 1000's
        CP      0A0h            ; Is digit < 10?
        RET     NC              ; No, so return ERROR
        INC     HL              ; Go check next byte
        LD      A,(HL)          ; Get Frame byte
        AND     00Fh            ; Get lower nibble 1's
        CP      00Ah            ; Is digit < 10?
        RET     NC              ; No, so return ERROR
        LD      A,(HL)          ; Get Frame byte
        AND     0F0h            ; Get upper nibble 10's
        CP      0A0h            ; Is digit < 10?
        RET                     ; Return Carry

;----------------------------------------------------
;         Error Found:  Clear Carry Flag
;----------------------------------------------------
L6739:  CCF                     ; Clear Carry Flag
        RET                     ; Return







;----------------------------------------------------
;               Erase Frame Count
;----------------------------------------------------
;         A = Filler erase byte (0FEh or 0EFh)
;        HL = Frame Count to erase
;----------------------------------------------------
L673B:  NOP                     ; Do nothing
        LD      (HL),A          ; Erase location
        INC     HL              ; Next location
        LD      (HL),A          ; Erase location
        INC     HL              ; Next locaiton
        LD      (HL),A          ; Erase location
        RET                     ; Return



;----------------------------------------------------
;        Check Proximity to Target Frame (E116) 
;        Frame Count - (E116) <= 10 ?
;----------------------------------------------------
;        HL    = Frame Count (E11C or E11F)
;        Return: Carry Set   = Less than 10
;                Carry Clear = Greater than 10
;----------------------------------------------------
L6742:  LD      DE,0E118h       ; Target = E116-E118
        JR      L674A           ; Do tolerance check





;----------------------------------------------------
;        Check Proximity to Target Frame (E119) 
;        Frame Count - (E119) <= 10 ?
;----------------------------------------------------
;        HL    = Frame Count (E11C or E11F)
;        Return: Carry Set   = Less than 10
;                Carry Clear = Greater than 10
;----------------------------------------------------
L6747:  LD      DE,0E11Bh       ; Target = E119-E11B
L674A:  INC     HL              ; Point to next byte
        INC     HL              ; Point to last byte
        EX      DE,HL           ; Swap registers
        LD      IX,0E172h       ; IX holds subtraction results
        LD      B,003h          ; 3 Bytes to subtract
        OR      A               ; A = 0
L6754:  LD      A,(DE)          ; A = Target byte
        SBC     A,(HL)          ; Subtract Frame Count byte
        DAA                     ; Convert to Decimal
        LD      (IX+000h),A     ; Save Result (E170-E172)
        DEC     DE              ; Next byte in Target
        DEC     HL              ; Next byte in Frame Count
        DEC     IX              ; Next byte in Result
        DJNZ    L6754           ; Loop until all bytes subtracted

;----------------------------------------------------
;     Is Frame Count within 10 frames of target?
;----------------------------------------------------                
        LD      HL,(0E170h)     ; Get results E170-E171
        LD      A,H             ; Check Hundreds digit
        OR      L               ; Check Tens digit
        JP      NZ,L676E        ; They are not zero so skip ahead
        LD      A,(0E172h)      ; Get Ones digit
        CP      011h            ; Set Carry if less than 10
        RET                     ; Return
L676E:  OR      A               ; Set Error (Clear Carry)
        RET                     ; Return









;----------------------------------------------------
;              LaserDisc Diagnostics 
;----------------------------------------------------
;    Setup Text Display and Print User Instructions 
;----------------------------------------------------
L6770:  LD      A,0F6h          ; Text = WHITE, Bkgnd = DK_RED
        CALL    L20CA           ; Setup Graphics Chip for Text
        CALL    L21FF           ; Clear Text Display 
        CALL    L2353           ; Wait for Comm Ready
        CALL    L6D85           ; Show LaserDisc Error Display
        PUSH    HL              ; Save HL Register
        LD      HL,00000h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text        
;----------------------------------------------------
L6785:  .TEXT "THIS IS THE DISC-CHECKER"
L6785:  .DB   000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        LD      B,001h          ; Loop = 1 
L67A1:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L67A1           ; Loop for 1 Comm
        PUSH    HL              ; Save HL Register
        LD      HL,00028h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text        
;----------------------------------------------------
L67AD  .TEXT   "IT TAKES ABOUT 35 MINUTES"
       .DB   000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        LD      B,001h          ; Loop = 1
L67CA:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L67CA           ; Loop for 1 Comm       
        PUSH    HL              ; Restore HL Register
        LD      HL,00078h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L67D6:  .TEXT   "You Will See Disc Video"
        .DB   000h
;----------------------------------------------------    
        POP     HL              ; Restore HL Register
        LD      B,001h          ; Loop = 1
L67F1:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L67F1           ; Loop for 1 Comm
        PUSH    HL              ; Save HL Register
        LD      HL,000C8h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;---------------------------------------------------- 
L67FD:  .TEXT   "During Errors & Bad Frames"
        .DB   000h
;----------------------------------------------------  
        POP     HL              ; Restore HL Register
        LD      B,001h          ; Loop = 1
L681B:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L681B           ; Loop for 1 Comm
        PUSH    HL              ; Save HL Register
        LD      HL,00118h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L6827:  .TEXT "ERRORS WILL BE SHOWN IN"
        .DB   000h   
;----------------------------------------------------
L683F:  POP     HL              ; Save HL Register
        LD      B,001h          ; Loop = 1
L6842:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L6842           ; Loop for 1 Comm
        PUSH    HL              ; Restore HL Register
        LD      HL,00140h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L684E: .TEXT   "THE UPPER RIGHT CORNER."
       .DB   000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        CALL    L2381           ;
        LD      A,0F6h          ; Text = WHITE, Bkgnd = DK_RED
        LD      (0E136h),A      ; Set Color
        CALL    L22F5           ; Program Graphics Chip           
        LD      A,001h          ;
        LD      (0E13Ah),A      ;
;----------------------------------------------------
;           Clear all test variables
;----------------------------------------------------
        LD      HL,00000h       ; HL = 0000
        LD      (0E144h),HL     ; Clear E144-E145
        LD      (0E13Eh),HL     ; Clear Hardware Errors
        LD      (0E140h),HL     ; Clear E140-E141
        LD      (0E16Eh),HL     ; Clear LaserDisc Errors
L6886:  LD      (0E13Bh),HL     ; Clear E13B-E13C
        XOR     A               ; A = 0
L688A:  LD      (0E13Dh),A
        LD      (0E141h),A
        LD      (0E142h),A
        LD      A,03Ch          ; Set 60 seconds
        LD      (0E143h),A      ; Set seconds timer
        LD      HL,00000h       ; Frame Number =0000
        LD      (0E119h),HL     ; Save start frame number
        LD      A,031h
        LD      (0E11Bh),A      ;
L68A3:  LD      IY,0E119h       ; Frame Number = 0000 (start of disc)
        CALL    L08B5           ; Search to Frame Number
        CALL    L6D85           ; Show LaserDisc Error Display
        CALL    L6C8F           ; Sound Alternating Beeps
        JP      Z,L68BE
        LD      HL,0E126h
        RES     1,(HL)
        CALL    L6CDB           ; Increment Target Frame Number
        JP      L68A3           ; Continue search to all frames

L68BE:  CALL    L2392
        LD      A,0F6h          ; Text = WHITE, Bkgnd = DK_RED
        LD      (0E136h),A      ; Set Color
        CALL    L22F5           ; Program Graphics Chip
        LD      A,005h          ; Command = PLAY (05h)
        CALL    L207F           ; Send Message to LDPlayer DI
        LD      A,(0E126h)      ; Get Control Register
        RES     4,A
        LD      (0E126h),A
        CALL    Delay10000      ; Delay 10,000
        PUSH    HL              ; Save HL Register
        LD      HL,0E112h
        LD      A,(HL)
L68DE:  CP      (HL)
        JP      Z,L68DE
        POP     HL              ; Restore HL Register

        LD      B,002h          ; Loop = 2
L68E5:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L68E5           ; Loop for 2 Comm's        

        LD      HL,0E116h
        LD      DE,0E119h
        LD      BC,00003h
        LDIR    

L68F5:  LD      B,002h          ; Loop = 2
L68F7:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L68F7           ; Loop for 2 Comm's        

        CALL    L6CDB           ; Increment Target Frame Number
        CALL    L6C0B           ; Compare Target frame with Actual frame
        PUSH    AF
        CALL    L6CAE
        CALL    L6D10
        POP     AF
        JP      NZ,L6918

L690D:  LD      A,(0E119h)
        CP      005h
        JP      C,L68F5
        JP      L6999

L6918:  LD      HL,0E13Bh
        LD      DE,0E119h
        LD      B,003h

L6920:  LD      A,(DE)
        CP      (HL)
        JR      NZ,L6928                
        INC     DE
        INC     HL
        DJNZ    L6920                   

L6928:  JP      C,L690D
        PUSH    AF
        CALL    NZ,L6971
        POP     AF
        JP      NZ,L693D
        LD      HL,0E141
        INC     (HL)
        LD      A,(HL)
        CP      007h
        JP      NC,L6976

L693D:  CALL    L236C
        CALL    L22F5           ; Program Graphics Chip
        CALL    L6CF2           ; Increment Number of Hardware Errors
        CALL    L6D35           ; Display Number of Hardware Errors
        LD      HL,0E119h
        LD      DE,0E13Bh
        LD      BC,00003h
        LDIR    
        LD      HL,L0000h
        LD      (0E127h),HL
        LD      (0E129h),HL
        LD      A,030h
        LD      (0E12Ah),A
        LD      DE,0E11Bh
        CALL    L0FCC           ; Call 3-Digit Subtraction
        CALL    GoodBeep        ; Sound Good Beep
        CALL    L6D7B           ; 
        JP      L68A3

L6971:  XOR     A
        LD      (0E141h),A
        RET     


L6976:  XOR     A
        LD      (0E141h),A
        LD      HL,L0000
        LD      (0E13Bh),HL
        XOR     A
        LD      (0E13Dh),A
        CALL    L6C1B           ; Display Bad LaserDisc Frames
        CALL    L6D58           ; Display Number of LaserDisc Errors
        LD      C,007h

L698C:  CALL    L6D01
        DEC     C
        JP      NZ,L698C        ;
        CALL    L6D35           ; Display Number of Hardware Errors
        JP      L690D           ;





;----------------------------------------------------
;
;----------------------------------------------------
L6999:  LD      B,001h          ; Loop = 1
L699B:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L699B           ; Loop for 1 Comm
        CALL    L2392
        LD      A,0F6h          ; Text = WHITE, Bkgnd = DK_RED
        LD      (0E136h),A      ; Set Color
        CALL    L22F5           ; Program Graphics Chip
        LD      B,001h          ; Loop = 1
L69AD:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L69AD           ; Loop for 1 Comm        
        PUSH    HL              ; Save HL Register
        LD      HL,00028h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L69B9:  .TEXT   "                          "
        .DB   000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        LD      B,001h          ; Loop = 1
L69D7:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L69D7           ; Loop for 1 Comm        
        PUSH    HL              ; Save HL Register
L69DD:  LD      HL,00078h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L69E3:  .TEXT   "                          "
        .DB   000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        LD      B,001h          ; Loop  = 1
L6A01:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L6A01           ; Loop for 1 Comm        
        PUSH    HL              ; Save HL Register
L6A07:  LD      HL,000C8h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;---------------------------------------------------- 
L6A0D:  .TEXT   "                          "
        .DB   000h
;----------------------------------------------------  
        POP     HL              ; Restore HL Register
        LD      B,001h          ; Loop = 1
L6A2B:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L6A2B           ; Loop for 1 Comm        
        PUSH    HL              ; Save HL Register
L6A31:  LD      HL,00118h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L6A37:  .TEXT   "                          "
        .DB   000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        LD      IY,06C08h       ; Point to Frame Number (001 attract)
        CALL    L08B5           ; Search to Frame Number

L6A5A:  LD      B,001h          ; Loop = 1
L6A5C:  CALL    L2353           ; Wait for Comm Ready
L6A5F:  DJNZ    L6A5C           ; Loop for 1 Comm       

L6A61:  PUSH    HL              ; Save HL Register
        LD      HL,00050h       ; Cursor Position
L6A65:  CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L6A68:  .TEXT   "  DISC  TEST COMPLETE     "
        .DB   000h
;----------------------------------------------------         
L6A83:  POP     HL              ; Restore HL Register
        LD      B,001h          ; Loop = 1
L6A86:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L6A86           ; Loop for 1 Comm               
        PUSH    HL              ; Save HL Register
        LD      HL,000A0h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L6A92:  .TEXT   " TURN OFF SWITCH  SW16    "
        .DB     000h
;----------------------------------------------------               
L6AAD:  POP     HL              ; Restore HL Register
        LD      B,001h          ; Loop = 1
L6AB0:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L6AB0           ; Loop for 1 Comm
        PUSH    HL              ; Save HL Register
        LD      HL,000F0h       ; Cursor Position
L6AB9:  CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L6ABC:  .TEXT   "    AND TURN OFF GAME     "                
        .DB     000h
;----------------------------------------------------
L6AD7:  POP     HL              ; Restore HL Register

        LD      B,001h          ; Loop = 1
L6ADA:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L6ADA           ; Loop for 1 Comm

        PUSH    HL              ; Save HL Register
L6AE0:  LD      HL,00140h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L6AE6:  .TEXT   "       THEN POWERUP       "         
        .DB     000h
;----------------------------------------------------       
L6B01:  POP     HL              ; Restore HL Register

        LD      B,001h          ; Loop = 1
L6B04:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L6B04           ; Loop for 1 Comm

        PUSH    HL              ; Save HL Register
L6B0A:  LD      HL,00348h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
        LD      A,A
        JR      NZ,L6B92                
        JR      NZ,L6B94                

L6B15:  JR      NZ,L6B96               
        JR      NZ,L6B98                

L6B19:  JR      NZ,L6B9A               

L6B1B:  JR      NZ,L6B9C               

L6B1D:  JR      NZ,L6B9E               

L6B1F:  JR      NZ,L6BA0               
        JR      NZ,L6BA2                
        JR      NZ,L6BA4                
        JR      NZ,L6BA6                
        JR      NZ,L6BA8                
        JR      NZ,L6B2B                
;----------------------------------------------------
L6B2B:  POP     HL              ; Restore HL Register
        CALL    Delay100000     ; Delay 100,000

        LD      B,001h          ; Loop = 1
L6B31:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L6B31           ; Loop for 1 Comm

        PUSH    HL              ; Save HL Register
        LD      HL,00050h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
        JR      NZ,L6B5F              
        JR      NZ,L6B61              
        JR      NZ,L6B63              

L6B43:  JR      NZ,L6B65             
        JR      NZ,L6B67              
        JR      NZ,L6B69              
        JR      NZ,L6B6B              
        JR      NZ,L6B6D              
        JR      NZ,L6B6F              
        JR      NZ,L6B71              
        JR      NZ,L6B73              
        JR      NZ,L6B75              
        JR      NZ,L6B57                
;----------------------------------------------------
L6B57:  POP     HL              ; Restore HL Register

        LD      B,001h          ; Loop = 1
L6B5A:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L6B5A           ; Loop for 1 Comm                  

L6B5F:  PUSH    HL              ; Save HL Register
        LD      HL,000A0h       ; Cursor Location
L6B63:  CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
        JR      NZ,L6B88              
        JR      NZ,L6B8A              
        JR      NZ,L6B8C              
        JR      NZ,L6B8E              
        JR      NZ,L6B90              
        JR      NZ,L6B92              
        JR      NZ,L6B94              
        JR      NZ,L6B96              
        JR      NZ,L6B98              
        JR      NZ,L6B9A              
        JR      NZ,L6B9C              
        JR      NZ,L6B9E              
        JR      NZ,L6B80                
;----------------------------------------------------
L6B80:  POP     HL              ; Restore HL Register

        LD      B,001h          ; Loop = 1
L6B83:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L6B83           ; Loop for 1 Comm

L6B88:  PUSH    HL              ; Save HL Register
        LD      HL,000F0h       ; Cursor Location
L6B8C:  CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
        JR      NZ,L6BB1              
        JR      NZ,L6BB3              
        JR      NZ,L6BB5              
        JR      NZ,L6BB7              
        JR      NZ,L6BB9              
        JR      NZ,L6BBB              
        JR      NZ,L6BBD              
        JR      NZ,L6BBF              
        JR      NZ,L6BC1              
        JR      NZ,L6BC3              
        JR      NZ,L6BC5              
        JR      NZ,L6BC7              
        JR      NZ,L6BA9                
;----------------------------------------------------
L6BA9:  POP     HL              ; Restore HL Register

        LD      B,001h          ; Loop = 1
L6BAC:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L6BAC           ; Loop for 1 Comm

L6BB1:  PUSH    HL              ; Save HL Register
        LD      HL,00140h       ; Cursor Location
L6BB5:  CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
        JR      NZ,L6BDA              
        JR      NZ,L6BDC              
        JR      NZ,L6BDE              
        JR      NZ,L6BE0              
        JR      NZ,L6BE2              
        JR      NZ,L6BE4              
        JR      NZ,L6BE6              
        JR      NZ,L6BE8              
        JR      NZ,L6BEA              
        JR      NZ,L6BEC              
        JR      NZ,L6BEE              
        JR      NZ,L6BF0              
        JR      NZ,L6BD2                
;----------------------------------------------------
L6BD2:  POP     HL              ; Restore HL Register

        LD      B,001h          ; Loop = 1
L6BD5:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L6BD5           ; Loop for 1 Comm
               
L6BDA:  PUSH    HL              ; Save HL Register   
        LD      HL,00348h       ; Cursor Location
L6BDE:  CALL    L2212           ; Set Cursor and Print Text 
;----------------------------------------------------
L6BE1:  .TEXT   "    FINAL  RESULTS   "
        .DB   000h
;----------------------------------------------------              
L6BFB:  POP     HL              ; Restore HL Register
        CALL    Delay10000      ; Delay 10,000
        CALL    Delay10000      ; Delay 10,000
        CALL    GoodBeep        ; Sound Good Beep
        JP      L6A5A           ; Jump to ?








;----------------------------------------------------
;     Attract Mode Frame Number
;----------------------------------------------------
L6C08:  .DB   000h, 000h, 001h




;----------------------------------------------------
;      Compare Target frame with Actual frame
;       Z = 0       E116-E118  =  E119-E11B
;       Z = 1       E116-E118 <>  E119-E11B
;----------------------------------------------------
L6C0B:  LD      HL,0E119h       ;
L6C0E:  LD      DE,0E116h       ;
        LD      B,003h          ; 3 bytes to compare
L6C13:  LD      A,(DE)          ;
        CP      (HL)            ;
        RET     NZ              ;
        INC     DE              ;
        INC     HL              ;
        DJNZ    L6C13           ;        
        RET                     ;






;----------------------------------------------------
;            Display Bad LaserDisc Frames
;----------------------------------------------------
L6C1B:  PUSH    HL              ; Save HL Register
        LD      HL,0001Bh       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L6C22:  .TEXT   " Right:Wrong "
        .DB     000h                
;----------------------------------------------------
L6C30:  POP     HL              ; Restore HL Register
        CALL    L6CCB           ; Increment Number of LaserDisc Errors
        CALL    BadBeep         ; Sound Bad Beep
;----------------------------------------------------
;         Print the Target Frame Number...
;----------------------------------------------------
        LD      DE,00B11h       ; Location X = 12, Y = 17
        LD      HL,0E119h       ; Number = Target Frame Number
        CALL    L2265           ; Print 6-digit number
        LD      A,03Ah          ; A = Character ":"
        CALL    L2256           ; Print A to Text Display
;----------------------------------------------------
;        ...then print the Actual Frame Number
;----------------------------------------------------
        LD      DE,01211h       ; Location X = 18, Y = 17
        LD      HL,0E116h       ; Number = Actual Frame Number
        CALL    L2265           ; Print 6-digit number
        LD      D,01Bh          ; Location X = 27
        LD      A,(0E13Ah)      ;
        LD      E,A             ; Location Y =
        LD      HL,0E119h       ; Number = 
        CALL    L2265           ; Print 6-digit number
        LD      A,03Ah          ; A = Character ":"
        CALL    L2256           ; Print A to Text Display
        LD      D,022h          ; Location X = 34
        LD      HL,0E116h       ; Number = 
L6C64:  CALL    L2265           ; Print 6-digit number
        INC     E               ; Location Y = Y + 1
        LD      A,E             ; Save Y location
        PUSH    AF              ;
        CP      017h            ;
        CALL    NZ,L6C7C        ;
        POP     AF              ;
        LD      (0E13Ah),A      ;
        CP      018h            ; Is it 24?
        RET     C               ;
L6C76:  LD      A,001h          ;
L6C78:  LD      (0E13Ah),A      ;
        RET                     ; Return


L6C7C:  PUSH    DE              ;
        PUSH    HL              ; Save HL Register
        LD      D,01Bh          ;
        LD      B,00Dh          ;
        LD      A,020h          ;
L6C84:  CALL    L2233           ;
        INC     D               ;
        PUSH    AF              ;
        POP     AF              ;
        DJNZ    L6C84           ;        
        POP     DE              ;
        POP     HL              ; Restore HL Register
        RET                     ; Return








;----------------------------------------------------
;            Sound Alternating Beeps
;----------------------------------------------------
L6C8F:  LD      B,014h          ; Loop = 20
L6C91:  CALL    Delay100000     ; Call Delay 100,000
        LD      A,(0E126h)      ; Get Control Register
        BIT     1,A             ;
        RET     Z               ;
        DJNZ    L6C91           ;        

        LD      B,005h          ; Loop = 5
L6C9E:  CALL    GoodBeep        ; Sound Good Beep
        CALL    Delay10000      ; Call Delay 10,000
        CALL    BadBeep         ; Sound Bad Beep
        CALL    Delay10000      ; Call Delay 10,000
        DJNZ    L6C9E           ; Loop on beeps 5 times
        DEC     B               ; B = 0FFh
        RET                     ; Return







;----------------------------------------------------
;
;----------------------------------------------------
L6CAE:  LD      HL,0E142h       ;
        DEC     (HL)            ;
        RET     NZ              ;
        LD      (HL),01Eh       ;
        LD      HL,0E143h       ;
        DEC     (HL)            ;
        RET     NZ              ;
        LD      (HL),03Ch       ; Set 60 seconds
        LD      HL,0E145h       ;
        LD      A,(HL)          ;
        ADD     A,001h          ;
        DAA                     ;
        LD      (HL),A          ;
        RET     NZ              ;
        DEC     HL              ;
        LD      A,(HL)          ;
        ADD     A,001h          ;
        LD      (HL),A          ;
        RET                     ; Return






;----------------------------------------------------
;       Increment Number of LaserDisc Errors
;----------------------------------------------------
L6CCB:  LD      HL,0E16Fh       ; HL = LaserDisc Errors
        LD      A,(HL)          ; Get Number of LaserDisc Errors
        ADD     A,001h          ; Add 1 error
        DAA                     ; Convert to decimal
        LD      (HL),A          ; Store Number of LaserDisc Errors
        RET     NZ              ; Return if no overflow
        DEC     HL              ; Get 1000/100 of number
        LD      A,(HL)          ; Get Number of LaserDisc Errors
        ADD     A,001h          ; Add overflow
        DAA                     ; Convert to decimal
        LD      (HL),A          ; Store number of LaserDisc Errors
        RET                     ; Return







;----------------------------------------------------
;       Increment Target Frame Number
;----------------------------------------------------
L6CDB:  LD      HL,0E11Bh       ;
        LD      A,(HL)          ;
        ADD     A,001h          ;
        DAA                     ;
        LD      (HL),A          ;
        RET     NZ              ;
        DEC     HL              ;
        LD      A,(HL)          ;
        ADD     A,001h          ;
        DAA                     ;
        LD      (HL),A          ;
        RET     NZ              ;
        DEC     HL              ;
        LD      A,(HL)          ;
        ADD     A,001h          ; Add 
        DAA                     ; Convert to decimal
        LD      (HL),A          ;
        RET                     ; Return







;----------------------------------------------------
;     Increment Number of Hardware Errors (E13E-E140)
;----------------------------------------------------
L6CF2:  LD      HL,0E140h       ; HL = Hardware Errors
        LD      B,003h          ; 3 bytes to update
L6CF7:  LD      A,(HL)          ; Get Hardware Error
        ADD     A,001h          ; Add 1
        DAA                     ; Covert to decimal
        LD      (HL),A          ; Save Hardware Error
        RET     NZ              ; Return if not overflown
        DEC     HL              ; Goto next digit
        DJNZ    L6CF7           ; Loop until all digits handled       
        RET                     ; Return







;----------------------------------------------------
;       Increment Number of 
;----------------------------------------------------
L6D01:  LD      HL,0E140h
        LD      B,003h
L6D06:  LD      A,(HL)
        SUB     001h
        DAA     
        LD      (HL),A
        RET     NC
        DEC     HL
        DJNZ    L6D06                   
        RET     







;----------------------------------------------------
;              Display Number?
;----------------------------------------------------
L6D10:  LD      DE,0120Ah       ; Location X = 18, Y = 10
        LD      HL,0E116h       ; Number =
        CALL    L2265           ; Print 6-digit number
        LD      DE,0120Bh       ; Location X = 18, Y = 12
        LD      HL,0E119h       ; Number = 
        CALL    L2265           ; Print 6-digit number
        LD      DE,0110Fh       ; Location X = 17, Y = 15
        LD      HL,0E141h       ; Number = 
        CALL    L225D           ; Print 2-digit number
        LD      DE,01113h       ; Location X = 17, Y = 19
        LD      HL,0E144h       ; Number =
        CALL    L2261           ; Print 4-digit number
        RET                     ; Return









;----------------------------------------------------
;            Display Number of Hardware Errors 
;----------------------------------------------------
L6D35:  PUSH    HL              ; Save HL Register              
        LD      HL,00370h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L6D3C   .TEXT   "HARDWARE ERRORS:"
        .DB   000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        LD      DE,01416h       ; Location X = 20, Y = 22
        LD      HL,0E13Eh       ; Number = Hardware Errors
        CALL    L2265           ; Print 6-digit number
        RET                     ; Return









;----------------------------------------------------
;          Display Number of LaserDisc Errors 
;----------------------------------------------------
L6D58:  PUSH    HL              ; Save HL Register
        LD      HL,00398h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L6D5F:  .TEXT   "DISC     ERRORS:"
        .DB   000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        LD      DE,01617h       ; Location X = 22, Y = 23 
        LD      HL,0E16Eh       ; Number = LaserDisc Errors
        CALL    L2261           ; Print 4-digit number
        RET                     ; Return









;----------------------------------------------------
;            Display Frame Count Number? 
;----------------------------------------------------
L6D7B:  LD      DE,00D0Eh       ; Location X = 13, Y = 14
        LD      HL,0E119h       ; Number = 
        CALL    L2265           ; Print 6-digit number
        RET                     ; Return









;----------------------------------------------------
;          Show LaserDisc Error Display                   
;----------------------------------------------------
L6D85:  LD      B,001h          ; Loop = 1
L6D87:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L6D87           ; Loop for 1 Comm              
;----------------------------------------------------
;               Draw screen dividers 
;----------------------------------------------------
        LD      DE,01A00h       ; Location X = 26, Y = 0
        LD      B,018h          ; Loop = 24 Rows
L6D91:  LD      A,081h          ; A = Character Verticle Line
        CALL    L2233           ; Print one Character to Text Display
        PUSH    AF              ; Quick pause
        POP     AF              ; Quick pause
        INC     E               ; Move down one line Y=Y+1
        DJNZ    L6D91           ; Loop until all rows drawn
                           
        LD      DE,00009h       ; Location X = 0, Y = 9
        CALL    L6EA2           ; Print horizontal line with cap

        LD      B,001h          ; Loop = 1
L6DA3:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L6DA3           ; Loop for 1 Comm

        LD      DE,00014h       ; Location X = 0, Y = 20
        CALL    L6EA2           ; Print horizontal line with cap

L6DAE:  LD      B,001h          ; Loop = 1
L6DB0:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L6DB0           ; Loop for 1 Comm

        PUSH    HL              ; Save HL Register
        LD      HL,00190h       ; Cursor Location
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L6DBC:  .TEXT "Now Playing Frame"
        .DB   000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register
        LD      B,001h          ; Loop = 1
L6DD1:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L6DD1           ; Loop for 1 Comm        
        PUSH    HL              ; Save HL Register
        LD      HL,001B8h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L6DDD:  .TEXT   "Target Frame # Is"     
        .DB   000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register

        LD      B,001h          ; Loop = 1
L6DF2:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L6DF2           ; Loop for 1 Comm        

        PUSH    HL              ; Save HL Register
        LD      HL,00230h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L6DFE:  .TEXT   "Last Search:"
        .DB   000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register

        LD      B,001h          ; Loop = 1
L6E0E:  CALL    L2353           ; Wait for Comm Ready
L6E11:  DJNZ    L6E0E           ; Loop for 1 Comm
       
        PUSH    HL              ; Save HL Register
        LD      HL,00258h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L6E1A:  .TEXT   "RETRY Counter:"
        .DB   000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register

        LD      B, 001h         ; Loop = 1
L6E2C:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L6E2C           ; Loop for 1 Comm

        PUSH    HL              ; Save HL Register
        LD      HL,002F8h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L6E38:  .TEXT   "MINUTES RUNNING"
        .DB   000h
;----------------------------------------------------     
        POP     HL              ; Restore HL Register

        LD      B,001h          ; Loop = 1
L6E4B:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L6E4B           ; Loop for 1 Comm
                
        PUSH    HL              ; Save HL Register
        LD      HL,002A8h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L6E57:  .TEXT   "Last Error"     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register

        LD      B,001h          ; Loop = 1
L6E65:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L6E65           ; Loop for 1 Comm

        PUSH    HL              ; Save HL Register
        LD      HL,00348h       ; Cursor Position
        CALL    L2212           ; Set Cursor and Print Text
;----------------------------------------------------
L6E71:  .TEXT   "    TOTAL ERRORS    "     
        .DB     000h
;----------------------------------------------------
        POP     HL              ; Restore HL Register

        LD      B,001h          ; Loop = 1
L6E8F:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L6E8F           ; Loop for 1 Comm
                
        CALL    L6D35           ; Display Number of Hardware Errors

        LD      B,001h          ; Loop = 1
L6E99:  CALL    L2353           ; Wait for Comm Ready
        DJNZ    L6E99           ; Loop for 1 Comm
                
        CALL    L6D58           ; Display Number of LaserDisc Errors
        RET                     ; Return










;----------------------------------------------------
;           Print horizontal line with cap
;----------------------------------------------------
;      D = X Cursor Location
;      E = Y Cursor Location
;----------------------------------------------------
L6EA2:  LD      A,080h          ; A = Character Horizontal Line
        CALL    L2233           ; Print one Character to Text Display
        LD      B,019h          ; Loop = 25 width
L6EA9:  LD      A,080h          ; A = Character Horizontal Line
        CALL    L2256           ; Print A to Text Display
        PUSH    AF              ; Quick pause
        POP     AF              ; Quick pause
        DJNZ    L6EA9           ; Loop until line is printed       
        LD      A,089h          ; A =Character Line cap
        CALL    L2256           ; Print A to Text Display
        RET                     ; Return     









;----------------------------------------------------
;          CLIFF HANGER Graphics Character Data
;----------------------------------------------------
;          CLIFF        Each character is 8 bytes
;         HANGER        Below is a sample graphic
;----------------------------------------------------
;[        ][        ][        ][        ][        ][        ][        ][        ][        ][        ]
;[        ][        ][        ][        ][        ][        ][        ][        ][        ][        ]
;[        ][        ][        ][        ][        ][        ][        ][        ][        ][        ]
;[        ][        ][        ][        ][        ][        ][        ][        ][        ][        ]
;[        ][        ][        ][        ][        ][        ][        ][        ][        ][        ]
;[        ][        ][        ][        ][        ][        ][        ][        ][        ][        ]
;[        ][        ][        ][        ][        ][        ][        ][        ][        ][        ]
;[        ][        ][XXXXXX  ][    XXXX][XXX     ][        ][        ][        ][        ][XXXXXXXX]
;[        ][      XX][XXXXXXX ][    XXXX][XXX     ][        ][        ][        ][     XXX][XXXXXXXX]
;[        ][     XXX][XXXXXXXX][    XXXX][XXX     ][     XXX][XX      ][XXXXXXXX][XXX  XXX][XXXXXXXX]
;[        ][    XXXX][XXXXXXXX][    XXXX][XXX     ][     XXX][X      X][XXXXXXXX][XXX  XXX][XXXXXXXX]
;[        ][   XXXXX][XXXXXXXX][    XXXX][XXX     ][    XXXX][X      X][XXXXXXXX][XXX  XXX][XXXXXXXX]
;[        ][   XXXXX][XXXXXXXX][    XXXX][XXX     ][    XXXX][X      X][XXXXXXXX][XXX  XXX][XXXXXXXX]
;[        ][  XXXXXX][XXXXXXXX][    XXXX][XXX     ][    XXXX][X      X][XXXXXXXX][XX  XXXX][XXXXXXXX]
;[        ][  XXXXXX][XXXXXXXX][    XXXX][XXX     ][    XXXX][X     XX][XXXXX   ][XX  XXXX][XXX     ]
;[        ][ XXXXXXX][XXXXXXXX][    XXXX][XXX     ][    XXXX][X     XX][XXXXX   ][    XXXX][XX      ]
;[        ][ XXXXXXX][XXXXXXXX][    XXXX][XX      ][    XXXX][X     XX][XXXXX   ][    XXXX][XX      ]
;[        ][XXXXXXXX][  XXXXXX][    XXXX][XX      ][    XXXX][X     XX][XXXXX   ][    XXXX][XX      ]
;[        ][XXXXXXX ][   XXXXX][   XXXXX][XX      ][    XXXX][      XX][XXXXX   ][    XXXX][XX      ]
;[       X][XXXXXX  ][    XXXX][   XXXXX][XX      ][    XXXX][      XX][XXXX    ][    XXXX][XX      ]
;[       X][XXXXXX  ][    XXXX][   XXXXX][XX      ][    XXXX][     XXX][XXXX    ][    XXXX][XXXXXXX ]
;[       X][XXXXX   ][        ][   XXXXX][XX      ][   XXXXX][     XXX][XXXXXX  ][    XXXX][XXXXXXX ]
;[       X][XXXXX   ][        ][   XXXXX][XX      ][   XXXXX][     XXX][XXXXXXXX][X   XXXX][XXXXXXX ]
;[       X][XXXXX   ][        ][   XXXXX][XX      ][   XXXXX][     XXX][XXXXXXXX][    XXXX][XXXXXXX ]
;[       X][XXXXX   ][        ][   XXXXX][XX      ][   XXXXX][    XXXX][XXXXXXXX][   XXXXX][XXXXXXX ]
;[       X][XXXXX   ][        ][   XXXXX][XX      ][   XXXXX][    XXXX][XXXXXXXX][   XXXXX][XXXXXXX ]
;[       X][XXXXX   ][        ][   XXXXX][X       ][   XXXXX][    XXXX][XXXXXXXX][   XXXXX][XX      ]
;[       X][XXXXX   ][  X     ][   XXXXX][X       ][   XXXXX][    XXXX][XXX     ][   XXXXX][XX      ]
;[       X][XXXXXX  ][ XXXXX  ][   XXXXX][X       ][   XXXX ][    XXXX][XX      ][   XXXXX][X       ]
;[       X][XXXXXXXX][XXXXXXX ][   XXXXX][X       ][  XXXXX ][    XXXX][XX      ][   XXXXX][X       ]
;[       X][XXXXXXXX][XXXXXX  ][   XXXXX][X   XXX ][  XXXXX ][   XXXXX][XX      ][   XXXXX][X       ]
;[       X][XXXXXXXX][XXXXXX  ][  XXXXXX][XXXXXXX ][  XXXXX ][   XXXXX][XX      ][   XXXXX][X       ]
;[        ][XXXXXXXX][XXXXX   ][  XXXXXX][XXXXXXX ][  XXXXX ][   XXXXX][XX      ][   XXXXX][X       ]
;[        ][XXXXXXXX][XXXXX   ][  XXXXXX][XXXXXX  ][  XXXXX ][   XXXXX][X       ][   XXXXX][X       ]
;[        ][ XXXXXXX][XXXX    ][  XXXXXX][XXXXXX  ][  XXXXX ][  XXXXXX][X       ][   XXXXX][X       ]
;[        ][  XXXXXX][XXX     ][  XXXXXX][XXXXXX  ][  XXXXX ][  XXXXXX][X       ][   XXXXX][X       ]
;[        ][    XXXX][X       ][  XXXXXX][XXXXXX  ][  XXXXX ][  XXXXXX][X       ][   XXXXX][X       ]
;[        ][        ][        ][  XXXXXX][XXXXX   ][  XXXXX ][ XXXXXXX][X       ][   XXXXX][        ]
;[        ][        ][        ][  XXXXXX][        ][  XXXX  ][ XXXXXX ][        ][        ][        ]
;[        ][        ][        ][        ][        ][        ][        ][        ][        ][        ]

;[        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ]
;[        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ]
;[        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ]
;[        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ]
;[        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][XXXXXXXX][        ]
;[        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][   XX   ][    XXXX][XXXXXXXX][XX      ]
;[        ][ XXXX   ][   XXXXX][        ][        ][        ][        ][        ][        ][        ][        ][   XXXXX][XXXXX   ][   XXXXX][XXXXXXXX][XX      ]
;[        ][ XXXXX  ][   XXXXX][        ][        ][        ][        ][        ][        ][     XXX][XX      ][ XXXXXXX][XXXXX   ][   XXXXX][XXXXXXXX][XX      ]
;[        ][ XXXXX  ][   XXXXX][        ][   XXXXX][X      X][XXXXX   ][     XXX][XXX     ][    XXXX][XXXX    ][ XXXXXXX][XXXXX   ][   XXXXX][XXXXXXXX][XXXX    ]
;[        ][ XXXXX  ][   XXXXX][        ][   XXXXX][X      X][XXXXX   ][     XXX][XXX     ][   XXXXX][XXXX    ][ XXXXXXX][XXXXX   ][   XXXXX][X   XXXX][XXXX    ]
;[        ][XXXXX   ][   XXXXX][        ][  XXXXXX][X      X][XXXXXX  ][     XXX][XXX     ][   XXXXX][XXXXXX  ][ XXXXXXX][XXXXX   ][   XXXXX][     XXX][XXXX    ]
;[        ][XXXXX   ][  XXXXXX][        ][  XXXXXX][X      X][XXXXXX  ][     XXX][XXX     ][  XXXXXX][XXXXXX  ][ XXXXXXX][XXXXX   ][   XXXXX][     XXX][XXXX    ]
;[        ][XXXXX   ][  XXXXXX][        ][  XXXXXX][X     XX][XXXXXX  ][    XXXX][XXX     ][  XXXXXX][XXXXXX  ][ XXXXXX ][        ][   XXXXX][     XXX][XXXX    ]
;[        ][XXXXX   ][  XXXXXX][        ][ XXXXXXX][X     XX][XXXXXXX ][    XXXX][XXX    X][XXXXXXXX][XXXXXXX ][ XXXXXX ][        ][  XXXXXX][    XXXX][XXX     ]
;[        ][XXXXX   ][  XXXXXX][        ][ XXXXXXX][X     XX][XXXXXXX ][    XXXX][XXX    X][XXXXXXXX][XXXXXXX ][ XXXXXX ][        ][  XXXXXX][   XXXXX][XXX     ]
;[        ][XXXXX   ][  XXXXXX][        ][ XXXXXXX][X     XX][XXXXXXXX][    XXXX][XXX   XX][XXXXXXXX][XXXXXXX ][ XXXXXX ][        ][  XXXXXX][  XXXXXX][XXX     ]
;[        ][XXXXX   ][  XXXXX ][        ][XXXX XXX][XX    XX][XXXXXXXX][    XXXX][XXX   XX][XXXXXXXX][XXXXXXX ][ XXXXXXX][        ][  XXXXXX][ XXXXXXX][X       ]
;[        ][XXXXX   ][  XXXXX ][        ][XXXX XXX][XX    XX][XXXXXXXX][    XXXX][XXX   XX][XXXXXXXX][XXXXXXX ][ XXXXXXX][XXXX    ][  XXXXXX][XXXXXXX ][        ]
;[        ][XXXXX   ][  XXXXX ][       X][XXX  XXX][XX    XX][XXXXXXXX][X   XXXX][XXX  XXX][XXXXXX  ][ XXXXXX ][XXXXXXXX][XXXX    ][  XXXXXX][XXXXXXX ][        ]
;[        ][XXXXX   ][  XXXXX ][       X][XXX  XXX][XX    XX][XXXXXXXX][X   XXXX][XX   XXX][XXXXX   ][ X      ][XXXXXXXX][XXXX    ][  XXXXXX][XXXXXX  ][        ]
;[        ][XXXXXXXX][XXXXXXX ][       X][XXX  XXX][XX    XX][XXXXXXXX][XX  XXXX][XX   XXX][XXXX    ][        ][XXXXXXXX][XXXX    ][  XXXXXX][XXXXX   ][        ]
;[        ][XXXXXXXX][XXXXXXX ][      XX][XX   XXX][XX    XX][XXXX XXX][XX  XXXX][XX  XXXX][XXXX    ][        ][XXXXXXXX][XXXX    ][  XXXXXX][XXXX    ][        ]
;[        ][XXXXXXXX][XXXXXXX ][      XX][XX   XXX][XX    XX][XXXX XXX][XXX XXXX][XX  XXXX][XXX     ][        ][XXXXXXXX][XXX     ][  XXXXXX][XXXXX   ][        ]
;[        ][XXXXXXXX][XXXXXXX ][     XXX][XX    XX][XX   XXX][XXXX XXX][XXXXXXXX][XX  XXXX][XX      ][        ][XXXXXXXX][XXX     ][  XXXXXX][XXXXX   ][        ]
;[       X][XXXXXXXX][XXXXXXX ][     XXX][XX    XX][XX   XXX][XXXX  XX][XXXXXXXX][XX  XXXX][XX    XX][XXX     ][XXXXXXX ][        ][ XXXXXXX][XXXXXX  ][        ]
;[       X][XXXXXXXX][XXXXXXX ][    XXXX][XX    XX][XXX  XXX][XXXX  XX][XXXXXXXX][XX  XXXX][XX    XX][XXXXX   ][XXXXXXX ][        ][ XXXXX  ][XXXXXX  ][        ]
;[       X][XXXXXXXX][XXXXXXX ][    XXXX][      XX][XXX  XXX][XXXX  XX][XXXXXXXX][XX  XXXX][XX      ][XXXXXX  ][XXXXXXX ][        ][ XXXXX  ][XXXXXXX ][        ]
;[       X][XXXX XXX][XXXXXXX ][    XXXX][XXXXXXXX][XXX  XXX][XXX    X][XXXXXXXX][XX  XXXX][XX     X][XXXXXX  ][XXXXXXX ][        ][ XXXXX  ][ XXXXXX ][        ]
;[       X][XXXX    ][XXXXXX  ][   XXXXX][XXXXXXXX][XXX  XXX][XXX    X][XXXXXXXX][XX  XXXX][XX     X][XXXXX   ][XXXXXX  ][        ][ XXXXX  ][ XXXXXXX][        ]
;[      XX][XXXX    ][XXXXXX  ][   XXXXX][XXXXXXXX][XXX  XXX][XXX     ][XXXXXXXX][XX  XXXX][XXX   XX][XXXXX   ][XXXXXX  ][        ][ XXXXX  ][  XXXXXX][        ]
;[      XX][XXXX    ][XXXXXX  ][   XXXXX][XXXXXXXX][XXX  XXX][XXX     ][XXXXXXXX][XX  XXXX][XXXX XXX][XXXX    ][XXXXXX  ][        ][ XXXXX  ][  XXXXXX][X       ]
;[      XX][XXXX    ][XXXXXX  ][  XXXXXX][XXXXXXXX][XXXX XXX][XXX     ][XXXXXXXX][XX   XXX][XXXXXXXX][XXXX    ][XXXXXXXX][XXXXXXX ][ XXXXX  ][   XXXXX][        ]
;[      XX][XXX     ][ XXXXX  ][  XXXXX ][      XX][XXXX XXX][XXX     ][ XXXXXXX][XX   XXX][XXXXXXXX][XXX     ][XXXXXXXX][XXXXXXX ][XXXXXX  ][    XXX ][           ]
;[      XX][XXX     ][ XXXXX  ][  XXXX  ][      XX][XXXX XXX][XXX     ][ XXXXXXX][XX   XXX][XXXXXXXX][XXX    X][XXXXXXXX][XXXXXX  ][XXXXXX  ][    X   ][           ]
;[      XX][XXX     ][ XXXXX  ][ XXXX   ][      XX][XXXX XXX][XXX     ][  XXXXXX][XX    XX][XXXXXXXX][XX     X][XXXXXXXX][XXXXXX  ][XXXXXX  ][        ][           ]
;[      XX][XXX     ][ XXXXX  ][XXXXX   ][      XX][XXXX XXX][XXX     ][  XXXXXX][XX    XX][XXXXXXXX][X      X][XXXXXXXX][XXX     ][XXXX    ][        ][           ]
;[      XX][XXX     ][ XXXXX  ][        ][      XX][XXXX XXX][XXX     ][    XXXX][XX     X][XXXXXXXX][       X][XXXXX   ][        ][        ][        ][           ]
;[      XX][XXX     ][ XXXXX  ][        ][        ][     XXX][XXX     ][    XXXX][XX      ][XXXXXXX ][        ][        ][        ][        ][        ][           ]
;[        ][        ][        ][        ][        ][        ][        ][        ][        ][  XXX   ][        ][        ][        ][        ][        ][           ]
;[        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][        ][           ]
;----------------------------------------------------
L6EB8:  NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     

L6EC4:  NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        CALL    M,L0000
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        RRCA    
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        RET     PO

        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     

L6EF3:  NOP     
        NOP     

L6EF5:  NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        0FFh,

L6F08:  NOP     
        NOP     

L6F0A:  NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        INC     BC
        RLCA    
        RRCA    
        RRA     
        RRA     
        CCF     
        CCF     
        LD      A,A
        CP      0FF
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        RRCA    
        RRCA    
        RRCA    
        RRCA    
        RRCA    
        RRCA    
        RRCA    
        RRCA    
        RET     PO

        RET     PO

        RET     PO

        RET     PO

        RET     PO

        RET     PO

        RET     PO

        RET     PO

        NOP     
        RLCA    
        RLCA    
        RRCA    
        RRCA    
        RRCA    
        RRCA    
        RRCA    
        NOP     
        RET     NZ

        ADD     A,C
        ADD     A,C
        ADD     A,C
        ADD     A,C
        ADD     A,E
        ADD     A,E
        NOP     
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        RET     M

        RET     M

        RLCA    
        RST     020
        RST     020
        RST     020
        RST     020
        RST     08
        RST     08
        RRCA    
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        RET     PO

        RET     NZ

        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        LD      BC,00101
        LD      BC,07F01
        0FFh,
        CP      0FC
        CALL    M,LF8F8
        RET     M

        0FFh,
        CCF     
        RRA     
        RRCA    
        RRCA    
        NOP     
        NOP     
        NOP     
        RRCA    
        RRCA    
        RRA     
        RRA     
        RRA     
        RRA     
        RRA     
        RRA     
        RET     NZ

        RET     NZ

        RET     NZ

        RET     NZ

        RET     NZ

        RET     NZ

        RET     NZ

        RET     NZ

        RRCA    
        RRCA    
        RRCA    
        RRCA    
        RRCA    
        RRA     
        RRA     
        RRA     
        ADD     A,E
        ADD     A,E
        INC     BC
        INC     BC
        RLCA    
        RLCA    
        RLCA    
        RLCA    
        RET     M

        RET     M

        RET     M

        RET     P

        RET     P

        CALL    M,LFFFF
        RRCA    
        RRCA    
        RRCA    
        RRCA    
        RRCA    
        RRCA    
        ADC     A,A
        RRCA    
        RET     NZ

        RET     NZ

        RET     NZ

        RET     NZ

        CP      0FE
        CP      0FE
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        LD      BC,00101
        LD      BC,00101
        LD      BC,0F801
        RET     M

        RET     M

        RET     M

        CALL    M,LFFFF
        0FFh,
        NOP     
        NOP     
        NOP     
        JR      NZ,L7249                
        CP      0FC
        CALL    M,L1F1F
        RRA     
        RRA     
        RRA     
        RRA     
        RRA     
        CCF     
        RET     NZ

        RET     NZ

        ADD     A,B
        ADD     A,B
        ADD     A,B
        ADD     A,B
        ADC     A,(HL)
        CP      01F
        RRA     
        RRA     
        RRA     
        LD      E,03E
        LD      A,03E
        RRCA    
        RRCA    
        RRCA    
        RRCA    
        RRCA    
        RRCA    
        RRA     
        RRA     
        0FFh,
        0FFh,
        0FFh,
        RET     PO

        RET     NZ

        RET     NZ

        RET     NZ

        RET     NZ

        RRA     
        RRA     
        RRA     
        RRA     
        RRA     
        RRA     
        RRA     
        RRA     
        CP      0FE
        RET     NZ

        RET     NZ

        ADD     A,B
        ADD     A,B
        ADD     A,B
        ADD     A,B
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     

L7249:  NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        0FFh,
        0FFh,
        LD      A,A
        CCF     
        RRCA    
        NOP     
        NOP     
        NOP     
        RET     M

        RET     M

        RET     P

        RET     PO

        ADD     A,B
        NOP     
        NOP     
        NOP     
        CCF     
        CCF     
        CCF     
        CCF     
        CCF     
        CCF     
        CCF     
        NOP     
        CP      0FC
        CALL    M,LFCFC
        RET     M

        NOP     
        NOP     
        LD      A,03E
        LD      A,03E
        LD      A,03E
        INC     A
        NOP     
        RRA     
        RRA     
        CCF     
        CCF     
        CCF     
        LD      A,A
        LD      A,(HL)
        NOP     
        RET     NZ

        ADD     A,B
        ADD     A,B
        ADD     A,B
        ADD     A,B
        ADD     A,B
        NOP     
        NOP     
        RRA     
        RRA     
        RRA     
        RRA     
        RRA     
        RRA     
        NOP     
        NOP     
        ADD     A,B
        ADD     A,B
        ADD     A,B
        ADD     A,B
        ADD     A,B
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        LD      A,B
        LD      A,H
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        RRA     
        RRA     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        RLCA    
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        RET     NZ

        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        RRA     

L7427:  LD      A,A
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        JR      L7427                   
        RET     M

        NOP     
        NOP     
        NOP     
        NOP     
        RRCA    
        RRA     
        RRA     
        RRA     
        NOP     
        NOP     
        NOP     
        NOP     
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        RET     NZ

        RET     NZ

        RET     NZ

        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        LD      A,H
        LD      A,H
        RET     M

        RET     M

        RET     M

        RET     M

        RET     M

        RET     M

        RRA     
        RRA     
        RRA     
        CCF     
        CCF     
        CCF     
        CCF     
        CCF     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        RRA     
        RRA     
        RRA     
        CCF     
        CCF     
        LD      A,A
        LD      A,A
        LD      A,A
        ADD     A,C
        ADD     A,C
        ADD     A,C
        ADD     A,C
        ADD     A,E
        ADD     A,E
        ADD     A,E
        ADD     A,E
        RET     M

        RET     M

        CALL    M,LFCFC
        CP      0FE
        0FFh,
        RLCA    
        RLCA    
        RLCA    
        RLCA    
        RRCA    
        RRCA    
        RRCA    
        RRCA    
        RET     PO

        RET     PO

        RET     PO

        RET     PO

        RET     PO

        POP     HL              ; Restore HL Register
        POP     HL              ; Restore HL Register
        EX      (SP),HL
        RRCA    
        RRA     
        RRA     
        CCF     
        CCF     
        0FFh,
        0FFh,
        0FFh,
        RET     P

        RET     P

        CALL    M,LFCFC
        CP      0FE
        CP      07F
        LD      A,A
        LD      A,A
        LD      A,A
        LD      A,(HL)
        LD      A,(HL)
        LD      A,(HL)
        LD      A,(HL)
        RET     M

        RET     M

        RET     M

        RET     M

        NOP     
        NOP     
        NOP     
        NOP     
        RRA     
        RRA     
        RRA     
        RRA     
        RRA     
        CCF     
        CCF     
        CCF     
        0FFh,
        ADC     A,A
        RLCA    
        RLCA    
        RLCA    
        RRCA    
        RRA     
        CCF     
        RET     P

        RET     P

        RET     P

        RET     P

        RET     P

        RET     NZ

        RET     NZ

        RET     NZ

        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        RET     M

        RET     M

        RET     M

        RET     M

        0FFh,
        0FFh,
        0FFh,
        0FFh,
        LD      A,03E
        LD      A,03E
        CP      0FE
        CP      0FE
        NOP     
        NOP     
        LD      BC,00101
        INC     BC
        INC     BC
        RLCA    
        RST     030
        RST     030
        RST     020
        RST     020
        RST     020
        RST     00
        RST     00
        JP      LC3C3
        JP      LC3C3
        JP      LC7C3
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        RST     030
        RST     030
        RST     030
        RRCA    
        RRCA    
        ADC     A,A
        ADC     A,A
        RST     08
        RST     08
        RST     028
        0FFh,
        EX      (SP),HL
        EX      (SP),HL
        RST     020
        RST     00
        RST     00
        RST     08
        RST     08
        RST     08
        0FFh,
        0FFh,
        CALL    M,LF0F8
        RET     P

        RET     PO

        RET     NZ

        CP      0FE
        LD      A,(HL)
        LD      B,B
        NOP     
        NOP     
        NOP     
        NOP     
        LD      A,A
        LD      A,A
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        NOP     
        RET     P

        RET     P

        RET     P

        RET     P

        RET     P

        RET     PO

        RET     PO

        CCF     
        CCF     
        CCF     
        CCF     
        CCF     
        CCF     
        CCF     
        CCF     
        LD      A,A
        CP      0FE
        CALL    M,LF0F8
        RET     M

        RET     M

        ADD     A,B
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        LD      BC,00101
        LD      BC,00301
        INC     BC
        INC     BC
        0FFh,
        0FFh,
        0FFh,
        RST     030
        RET     P

        RET     P

        RET     P

        RET     P

        CP      0FE
        CP      0FE
        CALL    M,LFCFC
        CALL    M,L0F07
        RRCA    
        RRCA    
        RRA     
        RRA     
        RRA     
        CCF     
        JP      L03C3
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        RST     00
        RST     020
        RST     020
        RST     020
        RST     020
        RST     020
        RST     020
        RST     030
        DI      
        DI      
        DI      
        POP     HL              ; Restore HL Register
        POP     HL              ; Restore HL Register
        RET     PO

        RET     PO

        RET     PO

        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        RST     08
        RST     08
        RST     08
        RST     08
        RST     08
        RST     08
        RST     08
        RST     00
        JP      LC0C3
        POP     BC
        POP     BC
        EX      (SP),HL
        RST     030
        0FFh,
        RET     PO

        RET     M

        CALL    M,LF8FC
        RET     M

        RET     P

        RET     P

        CP      0FE
        CP      0FE
        CALL    M,LFCFC
        0FFh,
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        CP      07F
        LD      A,H
        LD      A,H
        LD      A,H
        LD      A,H
        LD      A,H
        LD      A,H
        LD      A,H
        CALL    M,LFEFC
        LD      A,(HL)
        LD      A,A
        CCF     
        CCF     
        RRA     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        ADD     A,B
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        INC     BC
        INC     BC
        INC     BC
        INC     BC
        INC     BC
        INC     BC
        NOP     
        NOP     
        RET     PO

        RET     PO

        RET     PO

        RET     PO

        RET     PO

        RET     PO

        NOP     
        NOP     
        LD      A,H
        LD      A,H
        LD      A,H
        LD      A,H
        LD      A,H
        LD      A,H
        NOP     
        NOP     
        LD      A,03C
        LD      A,B
        RET     M

        NOP     
        NOP     
        NOP     
        NOP     
        INC     BC
        INC     BC
        INC     BC
        INC     BC
        INC     BC
        NOP     
        NOP     
        NOP     
        RST     030
        RST     030
        RST     030
        RST     030
        RST     030
        RLCA    
        NOP     
        NOP     
        RET     PO

        RET     PO

        RET     PO

        RET     PO

        RET     PO

        RET     PO

        NOP     
        NOP     
        LD      A,A
        LD      A,A
        CCF     
        CCF     
        RRCA    
        RRCA    
        NOP     
        NOP     
        RST     00
        RST     00
        JP      LC1C3
        RET     NZ

        NOP     
        NOP     
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        CP      038
        NOP     
        RET     PO

        POP     HL              ; Restore HL Register
        POP     BC
        ADD     A,C
        LD      BC,L0000
        NOP     
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        RET     M

        NOP     
        NOP     
        NOP     
        CP      0FC
        CALL    M,L00E0
        NOP     
        NOP     
        NOP     
        CALL    M,LFCFC
        RET     P

        NOP     
        NOP     
        NOP     
        NOP     
        LD      C,008
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     

        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        JR      L7DBB                   

L7DBB:  NOP     
        LD      (00052),HL
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        DEC     B
        NOP     
        NOP     
        NOP     
        NOP     
        JR      L7DCB                   

L7DCB:  NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        SUB     B
        LD      H,B
        NOP     
        ADD     HL,DE
        JR      Z,L7DDE                 

L7DDE:  ADD     HL,DE
        ADD     A,A
        NOP     
        ADD     HL,SP
        JR      NC,L7DE4                

L7DE4:  LD      B,D
        INC     (HL)
        DEC     B
        PUSH    BC
        LD      A,L
        NOP     
        SUB     B
        LD      H,B
        NOP     
        ADD     HL,DE
        SUB     B
        NOP     
        JR      NZ,L7E32                
        NOP     
        ADD     HL,SP
        JR      NC,L7DF6                

L7DF6:  LD      B,D
        INC     (HL)
        DEC     B
        PUSH    BC
        LD      A,L
        NOP     
        LD      H,B
        SUB     B
        NOP     
        LD      HL,00020
        LD      HL,00060
        ADD     HL,SP
        JR      NC,L7E08                

L7E08:  LD      B,D
        INC     (HL)
        DEC     B
        PUSH    BC
        LD      A,L
        NOP     
        EX      AF,AF'
        LD      H,D
        NOP     
        LD      HL,00086
        LD      (00026),HL
        ADD     HL,SP
        JR      NC,L7E1A                

L7E1A:  LD      B,D
        INC     (HL)
        DEC     B
        PUSH    BC
        LD      A,L
        NOP     
        LD      D,C
        ADD     A,(HL)
        NOP     
        LD      (HL),E
        ADD     A,H
        NOP     
        LD      B,L
        SUB     D
        NOP     
        NOP     
        NOP     
        LD      A,(DE)
        NOP     
        NOP     
        NOP     
        NOP     
        LD      D,C
        ADD     A,(HL)

L7E32:  NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        LD      (BC),A
        RET     P

        NOP     
        LD      D,E
        ADC     A,B
        NOP     
        LD      D,H
        JR      Z,L7E48                 

L7E48:  ADD     A,C
        JR      NZ,L7E4B                

L7E4B:  ADD     A,H
        ADD     HL,BC
        LD      A,(DE)
        INC     L
        LD      A,(HL)
        NOP     
        LD      H,B
        LD      C,000
        LD      D,H
        JR      L7E57                   

L7E57:  LD      D,H
        LD      E,B
        NOP     
        ADD     A,C
        JR      NZ,L7E5D                

L7E5D:  ADD     A,H
        ADD     HL,BC
        LD      A,(DE)
        INC     L
        LD      A,(HL)
        NOP     
        NOP     
        NOP     
        NOP     
        LD      D,H
        ADD     A,H
        NOP     
        LD      D,L
        INC     H
        NOP     
        ADD     A,C
        JR      NZ,L7E6F                

L7E6F:  ADD     A,H
        ADD     HL,BC
        LD      A,(DE)
        INC     L
        LD      A,(HL)
        NOP     
        LD      BC,000F0
        LD      D,L
        LD      D,000
        LD      D,L
        LD      D,(HL)
        NOP     
        ADD     A,C
        JR      NZ,L7E81                

L7E81:  ADD     A,H
        ADD     HL,BC
        LD      A,(DE)
        INC     L
        LD      A,(HL)
        NOP     
        NOP     

        NOP     
        NOP     
        LD      D,L
        LD      H,B
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        INC     B
        RET     P

        NOP     
        LD      D,(HL)
        NOP     
        NOP     
        LD      D,(HL)
        LD      B,B
        NOP     
        ADD     A,C
        JR      NZ,L7EA5                

L7EA5:  ADD     A,H
        ADD     HL,BC
        DEC     D
        ADD     A,(HL)
        LD      A,(HL)
        NOP     
        INC     B
        RET     P

        NOP     
        LD      D,(HL)
        ADD     A,B
        NOP     
        LD      D,A
        JR      NZ,L7EB4                

L7EB4:  ADD     A,H
        ADD     HL,SP
        NOP     
        ADD     A,A
        LD      (08615),A
        LD      A,(HL)
        NOP     
        LD      BC,000F0
        LD      D,A
        DJNZ    L7EC3                   

L7EC3:  LD      D,A
        LD      D,B
        NOP     
        ADD     A,H
        ADD     HL,SP
        NOP     
        ADD     A,A
        LD      (08615),A
        LD      A,(HL)
        NOP     
        LD      BC,000F0
        LD      D,A
        LD      D,D
        NOP     
        LD      D,A
        SUB     D
        NOP     
        ADD     A,H
        ADD     HL,SP
        NOP     
        ADD     A,A
        LD      (08615),A
        LD      A,(HL)
        NOP     
        INC     B
        EI      
        NOP     
        LD      E,B
        LD      (BC),A
        NOP     
        LD      E,B
        LD      B,D
        NOP     
        ADD     A,H
        ADD     HL,SP
        NOP     
        ADD     A,A
        LD      (08615),A
        LD      A,(HL)
        NOP     
        LD      (BC),A
        RET     P

        NOP     
        LD      E,B
        LD      (HL),H
        NOP     
        LD      E,C
        INC     D
        NOP     
        ADD     A,H
        ADD     HL,SP
        NOP     
        ADD     A,A
        LD      (08615),A
        LD      A,(HL)
        NOP     
        NOP     
        NOP     
        NOP     
        LD      E,C
        JR      NZ,L7F0B                

L7F0B:  NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        LD      BC,000FE
        LD      H,B
        NOP     
        NOP     
        LD      H,B
        LD      B,B
        NOP     
        SUB     A
        SUB     H
        LD      BC,08100
        LD      C,004
        LD      A,A
        NOP     
        LD      BC,000F0
        LD      H,C
        EX      AF,AF'
        NOP     
        LD      H,C
        LD      C,B
        NOP     
        SUB     A
        SUB     H
        LD      BC,08100
        LD      C,004
        LD      A,A
        NOP     
        LD      BC,000FE
        LD      H,D
        LD      A,B
        NOP     
        LD      H,E
        JR      L7F44                   

L7F44:  SUB     A
        SUB     H
        LD      BC,08100
        LD      C,004
        LD      A,A
        NOP     
        LD      H,B
        RRCA    
        NOP     
        LD      H,E
        LD      B,D
        NOP     
        LD      H,E
        ADD     A,D
        NOP     
        ADD     A,H
        ADD     HL,SP
        NOP     
        ADD     A,A
        LD      (0040E),A
        LD      A,A
        NOP     
        EX      AF,AF'
        RST     030
        NOP     
        LD      H,H
        SUB     (HL)
        NOP     
        LD      H,L
        LD      (HL),000
        ADD     A,H
        ADD     HL,SP
        NOP     
        ADD     A,A
        LD      (0040E),A
        LD      A,A
        NOP     
        INC     B
        RET     P

        NOP     
        LD      H,(HL)
        SUB     H
        NOP     
        LD      H,A
        INC     (HL)
        LD      BC,00501
        LD      BC,02704
        LD      C,004
        LD      A,A
        NOP     
        LD      BC,000F0
        LD      L,C
        INC     B
        NOP     
        LD      L,C
        LD      B,H
        LD      BC,00501
        LD      BC,02704
        LD      C,004
        LD      A,A
        NOP     
        NOP     
        NOP     
        NOP     
        LD      L,C
        LD      (HL),H
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        LD      (BC),A
        NOP     
        LD      (HL),B
        DEC     D
        NOP     
        LD      (HL),B
        LD      D,L
        LD      BC,00501
        LD      BC,02704
        LD      B,094
        LD      A,A
        NOP     
        LD      BC,000F0
        LD      (HL),C
        INC     D
        NOP     

L7FBF:  LD      (HL),C
        LD      D,H
        LD      BC,00501
        LD      BC,02704
        LD      B,094
        LD      A,A
        NOP     
        LD      H,B
        RRCA    
        NOP     
        LD      (HL),D
        LD      (BC),A
        NOP     
        LD      (HL),D
        LD      B,D
        NOP     
        ADD     A,C
        JR      NZ,L7FD7                

L7FD7:  ADD     A,H
        ADD     HL,BC
        LD      B,094
        LD      A,A
        NOP     
        SUB     B
        RRCA    
        NOP     
        LD      (HL),D
        ADD     HL,SP
        NOP     
        LD      (HL),D
        LD      A,C
        NOP     
        ADD     A,C
        JR      NZ,L7FE9                

L7FE9:  ADD     A,H
        ADD     HL,BC
        LD      B,094
        LD      A,A
        NOP     
        SUB     B
        RRCA    
        NOP     
        LD      (HL),D
        ADD     A,H
        NOP     
        LD      (HL),E
        INC     H
        NOP     
        ADD     A,C
        JR      NZ,L7FFB                

L7FFB:  ADD     A,H
        ADD     HL,BC
        LD      B,094
        LD      A,A
        LD      BC,00136
        LD      BC,00570
        LD      BC,04722
        NOP     
        NOP     
        NOP     
        JR      NZ,L800E                

L800E:  NOP     
        NOP     
        LD      BC,00136
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        LD      BC,06638
        LD      BC,00639
        LD      BC,03582
        LD      BC,07785
        JR      NZ,L803D                
        ADD     A,B
        NOP     
        LD      BC,001F0
        JR      C,L7FBF                 
        LD      BC,01839
        LD      BC,03582

L803D:  LD      BC,07785
        JR      NZ,L804F                
        ADD     A,B
        NOP     
        SUB     B
        RRCA    
        LD      BC,09838
        LD      BC,02839
        LD      BC,03582

L804F:  LD      BC,07785
        JR      NZ,L8061                
        ADD     A,B
        NOP     
        EX      AF,AF'
        RET     P

        LD      BC,04439
        LD      BC,08439
        LD      BC,03582

L8061:  LD      BC,07785
        JR      NZ,L8073                
        ADD     A,B
        NOP     
        INC     B
        RET     P

        LD      BC,04440
        LD      BC,08440
        LD      BC,03582

L8073:  LD      BC,07785
        JR      NZ,L8085                
        ADD     A,B
        NOP     
        LD      BC,001F0
        LD      B,D
        LD      D,(HL)
        LD      BC,09642
        LD      BC,03582

L8085:  LD      BC,07785
        JR      NZ,L8097                
        ADD     A,B
        NOP     
        LD      BC,001F0
        LD      B,E
        LD      B,E
        LD      BC,08343
        LD      BC,03582

L8097:  LD      BC,07785
        JR      NZ,L80A9                
        ADD     A,B
        NOP     
        NOP     
        NOP     
        LD      BC,06945
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     

L80A9:  NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        LD      H,B
        RRCA    
        LD      BC,06846
        LD      BC,00847
        LD      BC,03582
        LD      BC,07785
        JR      L805D                   
        ADD     A,B
        NOP     
        LD      (BC),A
        RET     P

        LD      BC,09446
        LD      BC,03447
        LD      BC,03582
        LD      BC,07785
        JR      L806F                   
        ADD     A,B
        NOP     
        INC     B
        RET     P

        LD      BC,08847
        LD      BC,01848
        LD      BC,09695
        LD      BC,08998
        JR      L8081                   
        ADD     A,B
        NOP     
        LD      BC,001F0
        LD      C,B
        JR      L80ED                   
        LD      C,B

L80ED:  LD      E,B
        LD      BC,09695
        LD      BC,08998
        JR      L8093                   
        ADD     A,B
        NOP     
        NOP     
        NOP     
        LD      BC,01450
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        EX      AF,AF'
        RET     P

        LD      BC,L4351
        LD      BC,08351
        LD      BC,09695
        LD      BC,08998
        INC     DE
        RST     030
        ADD     A,B
        NOP     
        LD      (BC),A
        RET     M

        LD      BC,02152
        LD      BC,06152
        LD      BC,09695
        LD      BC,08998
        INC     DE
        RST     030
        ADD     A,B
        NOP     
        LD      BC,001F4
        LD      D,D
        LD      (L5201),A
        LD      (HL),D
        LD      BC,09695
        LD      BC,08998
        INC     DE
        RST     030
        ADD     A,B
        NOP     
        LD      (BC),A
        RET     M

        LD      BC,05352
        LD      BC,09352
        LD      BC,09695
        LD      BC,08998
        INC     DE
        RST     030
        ADD     A,B
        NOP     
        INC     B
        POP     AF
        LD      BC,07052
        LD      BC,01053
        LD      BC,09695
        LD      BC,08998
        INC     DE
        RST     030
        ADD     A,B
        NOP     
        EX      AF,AF'
        JP      P,L5201
        SUB     (HL)
        LD      BC,03653
        LD      BC,09695
        LD      BC,08998
        INC     DE
        RST     030
        ADD     A,B
        NOP     
        NOP     
        NOP     
        LD      BC,05057
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        EX      AF,AF'
        JP      P,L5801
        ADD     A,H
        LD      BC,01459
        LD      BC,03582
        LD      BC,07785
        INC     C
        LD      (HL),L
        ADD     A,C
        NOP     
        LD      BC,001F4
        LD      H,B
        LD      D,H
        LD      BC,09460
        LD      BC,03582
        LD      BC,07785
        INC     C
        LD      (HL),L
        ADD     A,C
        NOP     
        INC     B
        POP     AF
        LD      BC,09460
        LD      BC,03461
        LD      BC,03582
        LD      BC,07785
        INC     C
        LD      (HL),L
        ADD     A,C
        NOP     
        LD      BC,001F4
        LD      H,C
        SCF     
        LD      BC,07761
        LD      BC,03582
        LD      BC,07785
        INC     C
        LD      (HL),L
        ADD     A,C
        NOP     
        INC     B
        POP     AF
        LD      BC,07061
        LD      BC,01062
        LD      BC,03582
        LD      BC,07785
        INC     C
        LD      (HL),L
        ADD     A,C
        NOP     
        LD      BC,001F4
        LD      H,D
        LD      (L6201),HL
        LD      H,D
        LD      BC,03582
        LD      BC,07785
        INC     C
        LD      (HL),L
        ADD     A,C
        NOP     
        INC     B
        POP     AF
        LD      BC,05462
        LD      BC,09462
        LD      BC,03582
        LD      BC,07785
        INC     C
        LD      (HL),L
        ADD     A,C
        NOP     
        LD      BC,001F4
        LD      H,E
        RLCA    
        LD      BC,04763
        LD      BC,03582
        LD      BC,07785
        INC     C
        LD      (HL),L
        ADD     A,C
        NOP     
        INC     B
        POP     AF
        LD      BC,03963
        LD      BC,07963
        LD      BC,03582
        LD      BC,07785
        INC     C
        LD      (HL),L
        ADD     A,C
        NOP     
        LD      BC,001F0
        LD      H,E
        SUB     D
        LD      BC,03264
        LD      BC,03582
        LD      BC,07785
        INC     C
        LD      (HL),L
        ADD     A,C
        NOP     
        INC     B
        RET     P

        LD      BC,02464
        LD      BC,06464
        LD      BC,03582
        LD      BC,07785
        INC     C
        LD      (HL),L
        ADD     A,C
        LD      (BC),A
        INC     DE
        LD      SP,03102
        JR      NZ,L8256                
        RLCA    
        LD      B,C

L8256:  NOP     
        NOP     
        NOP     
        LD      (L0000),A
        NOP     
        LD      (BC),A
        LD      (DE),A
        LD      B,B
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        LD      H,B
        RRCA    
        LD      (BC),A
        DEC     D
        LD      D,E
        LD      (BC),A
        DEC     D
        ADD     A,E
        LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        LD      (0825A),A
        NOP     
        NOP     
        NOP     
        LD      (BC),A
        DEC     D
        LD      (HL),B
        LD      (BC),A
        LD      D,000
        LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        LD      (0825A),A
        NOP     
        LD      H,B
        RRCA    
        LD      (BC),A
        DEC     D
        SUB     H
        LD      (BC),A
        LD      D,014

L8299:  LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        LD      (0825A),A
        NOP     
        INC     B
        RET     P

        LD      (BC),A
        LD      D,040
        LD      (BC),A

L82A9:  LD      D,070
        LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        LD      (0825A),A
        NOP     
        INC     B
        RET     P

        LD      (BC),A
        LD      D,069
        LD      (BC),A
        LD      D,099
        LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        LD      (0825A),A
        NOP     
        INC     B
        RET     P

        LD      (BC),A
        LD      D,098
        LD      (BC),A
        RLA     
        JR      Z,L82D2                 

L82D0:  INC     SP
        LD      E,B

L82D2:  LD      (BC),A
        LD      (HL),040
        LD      (0825A),A
        NOP     
        INC     B
        RET     P

        LD      (BC),A
        RLA     
        DAA     
        LD      (BC),A
        RLA     
        LD      D,A

L82E1:  LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        LD      (0825A),A
        NOP     
        LD      H,B
        RRCA    
        LD      (BC),A
        JR      L8316                   
        LD      (BC),A
        JR      L8349                   
        LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        LD      (0825A),A
        NOP     
        NOP     
        NOP     
        LD      (BC),A
        JR      L8299                
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        LD      H,B
        RRCA    
        LD      (BC),A
        JR      NZ,L8318                
        LD      (BC),A
        JR      NZ,L834B              
        LD      (BC),A

L8318:  INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        ADD     HL,HL
        CALL    M,L0082
        INC     B
        RET     P

        LD      (BC),A
        JR      NZ,L8376                
        LD      (BC),A
        JR      NZ,L82A9                
        LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        ADD     HL,HL
        CALL    M,L0082
        NOP     
        NOP     
        LD      (BC),A
        JR      NZ,L839D             
        LD      (BC),A
        JR      NZ,L82D0                7)
        LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        ADD     HL,HL
        CALL    M,L0082
        LD      H,B
        RRCA    
        LD      (BC),A
        JR      NZ,L82E1             
        LD      (BC),A

L834B:  LD      HL,00217
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        ADD     HL,HL
        CALL    M,L0082
        LD      H,B
        RRCA    
        LD      (BC),A
        LD      HL,00202
        LD      HL,00232
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        ADD     HL,HL
        CALL    M,L0082
        LD      H,B
        RRCA    
        LD      (BC),A
        LD      HL,00246
        LD      HL,00276
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        ADD     HL,HL
        CALL    M,L0082
        LD      H,B
        RRCA    
        LD      (BC),A
        LD      HL,00260
        LD      HL,00290
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        ADD     HL,HL
        CALL    M,L0082
        NOP     
        NOP     
        LD      (BC),A
        LD      (00024),HL
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     

L839D:  NOP     
        NOP     
        LD      H,B
        RRCA    
        LD      (BC),A
        LD      (00237),HL
        LD      (00267),HL
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        LD      HL,0838C
        NOP     
        NOP     
        NOP     
        LD      (BC),A
        LD      (00250),HL
        LD      (00280),HL
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        LD      HL,0838C
        NOP     
        LD      H,B
        RRCA    
        LD      (BC),A
        LD      (00264),HL
        LD      (00294),HL
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        LD      HL,0838C
        NOP     
        INC     B
        RET     P

        LD      (BC),A
        INC     HL
        LD      H,002
        INC     HL
        LD      D,(HL)
        LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        LD      HL,0838C
        NOP     
        INC     B
        RET     P

        LD      (BC),A
        INC     HL
        LD      B,L
        LD      (BC),A
        INC     HL
        LD      (HL),L
        LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        LD      HL,0838C
        NOP     
        INC     B
        RET     P

        LD      (BC),A
        INC     HL
        ADD     A,H
        LD      (BC),A
        INC     H
        INC     B
        LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        LD      HL,0838C
        NOP     
        INC     B
        RET     P

        LD      (BC),A
        INC     H
        INC     BC
        LD      (BC),A
        INC     H
        INC     SP
        LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        LD      HL,0838C
        NOP     
        LD      H,B
        RRCA    
        LD      (BC),A
        INC     H
        INC     H
        LD      (BC),A
        INC     H
        LD      D,H
        LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        LD      HL,0838C
        NOP     
        NOP     
        NOP     
        LD      (BC),A
        INC     H
        SUB     D
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        EX      AF,AF'
        RST     030
        LD      (BC),A
        INC     H
        SUB     H
        LD      (BC),A
        DEC     H
        INC     H
        LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        JR      L847F                   
        ADD     A,H
        NOP     
        LD      H,B
        RRCA    
        LD      (BC),A
        DEC     H
        NOP     
        LD      (BC),A
        DEC     H
        JR      NC,L845E                
        INC     SP
        LD      E,B

L845E:  LD      (BC),A
        LD      (HL),040
        JR      L8491                   
        ADD     A,H
        NOP     
        INC     B
        RET     P

        LD      (BC),A
        DEC     H
        JR      C,L846D                 
        DEC     H
        LD      L,B

L846D:  LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        JR      L84A3                   
        ADD     A,H
        NOP     
        NOP     
        NOP     
        LD      (BC),A
        DEC     H
        LD      D,(HL)
        LD      (BC),A
        DEC     H
        ADD     A,(HL)

L847F:  LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        JR      L84B5                   
        ADD     A,H
        NOP     
        LD      H,B
        RRCA    
        LD      (BC),A
        DEC     H
        ADD     A,B
        LD      (BC),A
        LD      H,010

L8491:  LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        JR      L84C7                   
        ADD     A,H
        NOP     
        LD      H,B
        RRCA    
        LD      (BC),A
        DEC     H

L849F:  SUB     D
        LD      (BC),A
        LD      H,022

L84A3:  LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        JR      L84D9                   
        ADD     A,H
        NOP     
        LD      H,B
        RRCA    
        LD      (BC),A
        LD      H,010
        LD      (BC),A
        LD      H,040

L84B5:  LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        JR      L84EB                   
        ADD     A,H
        NOP     
        NOP     
        NOP     
        LD      (BC),A
        LD      H,083
        NOP     
        NOP     
        NOP     

L84C7:  NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        LD      (BC),A
        LD      H,089
        LD      (BC),A
        DAA     
        ADD     HL,DE

L84D9:  LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        DJNZ    L849F                   
        ADD     A,H
        NOP     
        LD      H,B
        RRCA    
        LD      (BC),A
        DAA     

L84E7:  LD      (BC),A
        LD      (BC),A
        DAA     
        LD      (03302),A
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        DJNZ    L84B1                   
        ADD     A,H
        NOP     
        LD      H,B
        RRCA    
        LD      (BC),A
        DAA     

L84F9:  JR      NC,L84FD               
        DAA     
        LD      H,B

L84FD:  LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        DJNZ    L84C3                   
        ADD     A,H
        NOP     
        INC     B
        RET     P

        LD      (BC),A
        DAA     

L850B:  LD      D,B
        LD      (BC),A
        DAA     
        ADD     A,B
        LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        DJNZ    L84D5                   
        ADD     A,H
        NOP     
        INC     B
        RET     P

        LD      (BC),A
        DAA     
        ADD     A,H
        LD      (BC),A
        JR      Z,L8535                 
        LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        DJNZ    L84E7                   
        ADD     A,H
        NOP     
        LD      H,B
        RRCA    
        LD      (BC),A
        DAA     
        SUB     H
        LD      (BC),A
        JR      Z,L8557                 
        LD      (BC),A
        INC     SP

L8535:  LD      E,B
        LD      (BC),A
        LD      (HL),040
        DJNZ    L84F9                   
        ADD     A,H
        NOP     
        LD      H,B
        RRCA    
        LD      (BC),A
        JR      Z,L8587                 
        LD      (BC),A
        JR      Z,L85BA                 
        LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        DJNZ    L850B                   
        ADD     A,H
        NOP     
        NOP     
        NOP     
        LD      (BC),A
        ADD     HL,HL
        DEC     H
        NOP     
        NOP     
        NOP     

L8557:  NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     

L855D:  NOP     
        NOP     
        NOP     
        NOP     
        EX      AF,AF'
        RST     030
        LD      (BC),A
        ADD     HL,HL
        LD      B,C
        LD      (BC),A
        ADD     HL,HL
        LD      (HL),C
        LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        EX      AF,AF'
        LD      C,(HL)
        ADD     A,L
        NOP     
        LD      H,B
        RRCA    
        LD      (BC),A
        ADD     HL,HL
        LD      D,L
        LD      (BC),A
        ADD     HL,HL
        ADD     A,L
        LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        EX      AF,AF'
        LD      C,(HL)
        ADD     A,L
        NOP     
        INC     B
        RET     P


L8587:  LD      (BC),A
        ADD     HL,HL
        SUB     L
        LD      (BC),A
        JR      NC,L85B2                
        LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        EX      AF,AF'
        LD      C,(HL)
        ADD     A,L
        NOP     
        LD      H,B
        RRCA    
        LD      (BC),A
        JR      NC,L85AC                
        LD      (BC),A
        JR      NC,L85DF                
        LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        EX      AF,AF'
        LD      C,(HL)
        ADD     A,L
        NOP     
        LD      H,B
        RRCA    
        LD      (BC),A

L85AC:  JR      NC,L85E3               
        LD      (BC),A
        JR      NC,L8616             
        LD      (BC),A

L85B2:  INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        EX      AF,AF'
        LD      C,(HL)
        ADD     A,L

L85BA:  NOP     
        LD      H,B
        RRCA    
        LD      (BC),A
        JR      NC,L8606                
        LD      (BC),A
        JR      NC,L8639                
        LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        EX      AF,AF'
        LD      C,(HL)
        ADD     A,L
        NOP     
        LD      H,B
        RRCA    
        LD      (BC),A
        JR      NC,L862A                
        LD      (BC),A
        JR      NC,L855D                
        LD      (BC),A
        INC     SP
        LD      E,B
        LD      (BC),A
        LD      (HL),040
        EX      AF,AF'
        LD      C,(HL)
        ADD     A,L
        INC     B

L85DF:  DEC     H
        LD      D,B
        INC     B
        LD      H,D

L85E3:  JR      NZ,L85E9               
        INC     D

L85E6:  LD      (HL),004
        DEC     D

L85E9:  ADD     A,H
        LD      L,000
        NOP     
        NOP     
        INC     B

L85EF:  DEC     H
        LD      D,B
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        EX      AF,AF'
        RET     P

        INC     B
        LD      H,076
        INC     B
        DAA     
        LD      B,004
        LD      (HL),D
        ADC     A,C
        INC     B
        LD      (HL),L
        LD      A,B
        LD      L,0EB
        ADD     A,L
        NOP     
        EX      AF,AF'
        RET     P

        INC     B
        JR      Z,L863C                 
        INC     B

L8616:  JR      Z,L866F                
        INC     B
        LD      (HL),D
        ADC     A,C
        INC     B
        LD      (HL),L
        LD      A,B
        LD      L,0EB
        ADD     A,L
        NOP     
        SUB     B
        RRCA    
        INC     B
        JR      Z,L8687                 
        INC     B
        JR      Z,L85BA                 

L862A:  INC     B
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        LD      L,0EB
        ADD     A,L
        NOP     
        SUB     B
        RRCA    
        INC     B
        ADD     HL,HL
        LD      (BC),A

L8639:  INC     B
        ADD     HL,HL
        LD      (07604),A
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        LD      L,0EB
        ADD     A,L
        NOP     
        SUB     B
        RRCA    
        INC     B
        JR      NC,L86B3                4)
        INC     B
        JR      NC,L85E6                4)
        INC     B
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        LD      L,0EB
        ADD     A,L
        NOP     
        INC     B
        RET     P

        INC     B
        JR      NC,L85EF                
        INC     B
        LD      SP,00402
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        LD      L,0EB
        ADD     A,L
        NOP     
        NOP     
        NOP     
        INC     B
        LD      SP,00063
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        SUB     B
        RRCA    
        INC     B
        LD      (00461),A
        LD      (00491),A
        HALT    
        RLCA    

L8687:  INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        LD      (00486),A
        INC     SP
        LD      B,004
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        LD      (00495),A
        INC     SP
        DEC     H
        INC     B
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B

L86B3:  RRCA    
        INC     B
        INC     SP
        RLCA    
        INC     B
        INC     SP
        SCF     
        INC     B
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        INC     SP
        JR      NZ,L86CE                
        INC     SP
        LD      D,B
        INC     B
        HALT    

L86CE:  RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        INC     SP
        LD      B,L
        INC     B
        INC     SP
        LD      (HL),L
        INC     B
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        INC     SP
        LD      H,A
        INC     B
        INC     SP
        SUB     A
        INC     B
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        INC     (HL)
        INC     (HL)
        INC     B
        INC     (HL)
        LD      H,H
        INC     B
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        INC     (HL)
        LD      C,C
        INC     B
        INC     (HL)
        LD      A,C
        INC     B
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        INC     (HL)
        HALT    
        INC     B
        DEC     (HL)
        LD      B,004
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        DEC     (HL)
        DEC     D
        INC     B
        DEC     (HL)
        LD      B,L
        INC     B
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        DEC     (HL)
        LD      SP,03504
        LD      H,C
        INC     B
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        DEC     (HL)
        LD      B,C
        INC     B
        DEC     (HL)
        LD      (HL),C
        INC     B
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        DEC     (HL)
        LD      D,(HL)
        INC     B
        DEC     (HL)
        ADD     A,(HL)
        INC     B
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        DEC     (HL)
        ADD     A,B
        INC     B
        LD      (HL),010
        INC     B
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        LD      (HL),003
        INC     B
        LD      (HL),033
        INC     B
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        LD      (HL),070
        INC     B
        SCF     
        NOP     
        INC     B
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        LD      (HL),085
        INC     B
        SCF     

L87B5:  DEC     D
        INC     B
        HALT    
        RLCA    

L87B9:  INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        SCF     
        LD      (DE),A
        INC     B
        SCF     
        LD      B,D
        INC     B
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        SCF     
        LD      D,(HL)
        INC     B
        SCF     
        ADD     A,(HL)
        INC     B
        HALT    

L87DC:  RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        SCF     
        LD      (HL),C
        INC     B
        JR      C,L87ED                 
        INC     B

L87ED:  HALT    
        RLCA    
        INC     B
        LD      A,C

        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        SCF     
        ADC     A,C
        INC     B
        JR      C,L8817                 
        INC     B
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        JR      C,L8823                 
        INC     B
        JR      C,L8856                 
        INC     B
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     

L8817:  LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        JR      C,L8882                 
        INC     B
        JR      C,L87B5              
        INC     B

L8823:  HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        JR      C,L87B9                 
        INC     B
        ADD     HL,SP
        EX      AF,AF'
        INC     B
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        JR      C,L87DC                 
        INC     B
        ADD     HL,SP
        ADD     HL,HL
        INC     B
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        ADD     HL,SP
        LD      H,004

L8856:  ADD     HL,SP
        LD      D,(HL)
        INC     B
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        LD      B,C
        LD      D,C
        INC     B
        LD      B,C
        ADD     A,C
        INC     B
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        LD      B,E
        INC     B
        INC     B
        LD      B,E
        INC     (HL)
        INC     B
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C

L8882:  DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        LD      B,H
        SCF     
        INC     B
        LD      B,H
        LD      H,A
        INC     B
        HALT    
        RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        LD      H,B
        RRCA    
        INC     B
        LD      B,L
        JR      NC,L88A2                
        LD      B,L
        LD      H,B
        INC     B
        HALT    

L88A2:  RLCA    
        INC     B
        LD      A,C
        LD      L,C
        DAA     
        LD      L,C
        ADD     A,(HL)
        NOP     
        NOP     
        NOP     
        INC     B
        LD      D,B
        JR      NC,L88B0                

L88B0:  NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        NOP     
        LD      BC,004F0
        LD      D,D
        SBC     A,B
        INC     B
        LD      D,E
        JR      Z,L88C9                 
        ADD     A,A
        LD      L,B
        INC     B
        SUB     B

L88C9:  LD      D,B
        RLCA    
        XOR     C
        ADC     A,B
        NOP     
        SUB     B
        RRCA    
        INC     B
        LD      D,E
        SUB     H
        INC     B
        LD      D,H
        INC     D
        INC     B
        LD      L,C
        LD      H,B
        INC     B
        LD      (HL),D
        LD      D,(HL)
        RLCA    
        XOR     C
        ADC     A,B
        NOP     
        SUB     B
        RRCA    
        INC     B
        LD      D,L
        DEC     H
        INC     B
        LD      D,L
        LD      D,L
        INC     B
        LD      L,C
        LD      H,B
        INC     B
        LD      (HL),D
        LD      D,(HL)
        RLCA    
        XOR     C
        ADC     A,B
        NOP     
        SUB     B
        RRCA    
        INC     B
        LD      D,L
        SUB     C
        INC     B
        LD      D,(HL)
        LD      HL,09204
        DEC     H
        INC     B
        SUB     (HL)
        INC     (HL)
        RLCA    
        XOR     C
        ADC     A,B
        NOP     
        RET     P

        RRCA    
        INC     B
        LD      D,(HL)
        JR      L890E                   
        LD      D,(HL)
        LD      C,B
        INC     B
        SUB     D

L890E:  DEC     H
        INC     B
        SUB     (HL)
        INC     (HL)
        RLCA    
        XOR     C
        ADC     A,B
        NOP     
        LD      H,B
        RRCA    
        INC     B
        LD      D,(HL)
        ADD     A,L
        INC     B
        LD      D,A
        DEC     D
        INC     B
        SUB     D
        DEC     H
        INC     B
        SUB     (HL)
        INC     (HL)
        RLCA    
        XOR     C
        ADC     A,B
        LD      C,E
        LD      B,E
        LD      C,A
        LD      D,B
        LD      E,C
        LD      D,D
        LD      C,C
        LD      B,A
        LD      C,B
        LD      D,H
        LD      A,(05320)
        LD      D,H
        LD      B,L
        LD      D,D
        LD      C,(HL)
        JR      NZ,L897F                
        LD      C,H
        LD      B,L
        LD      B,E
        LD      D,H
        LD      D,D
        LD      C,A
        LD      C,(HL)
        LD      C,C
        LD      B,E
        LD      D,E
        INC     L
        JR      NZ,L8990                
        LD      C,(HL)
        LD      B,E
        LD      L,0FF
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
        0FFh,
