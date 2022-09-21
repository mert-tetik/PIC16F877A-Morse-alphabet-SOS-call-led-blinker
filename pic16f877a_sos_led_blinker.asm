list		p=16f877A	; List Directive To Define Processor
#include	"p16f877A.inc"	; Processor Specific Variable Definitions
__CONFIG _CP_OFF & _WDT_OFF & _LVP_ON & _FOSC_XT & _PWRTE_ON & _CPD_OFF & _WRT_OFF

;TIME1 EQU 0x10
;TIME2 EQU 0x11

;OUTPUT PIN = RB5

org 0x0000

goto INIT
INIT 
    bcf STATUS, RP1
    bsf STATUS, RP0 ;bank 1
    movlw 0xDF ;11011111
    movwf TRISB ;RB5 Output
    bcf STATUS, RP0 ;bank 0 
    movlw 0x04 ;4
    movwf 12;Count Fast Blinks
    movlw 0x04;4
    movwf 13;Count Slow Blinks
    movlw 0x08;8
    movwf 14;Count All Blinks
LOOP;Fast Blinks
    decfsz 14
    goto SKIPXX
    goto SEPARATOR_DELAY
    SKIPXX
    decfsz 12,F
    goto SKIP
    goto LOOP2_TRANSITION_DELAY
SKIP
    movlw 0x20 ;00100000
    movwf PORTB ;RB5 HIGH
    call LOAD_FAST
    movlw 0x00 ;00000000
    movwf PORTB ;RB5 LOW
    call LOAD_FAST 
    goto LOOP
SEPARATOR_DELAY;Separate Lines
    movlw 0x08
    movwf 14
    movlw 0x04
    movwf 12
    movlw 0x04
    movwf 13
    call LOAD_FAST
    call LOAD_FAST
    call LOAD_FAST
    call LOAD_FAST
    call LOAD_FAST
    call LOAD_FAST
    goto LOOP
LOOP2_TRANSITION_DELAY
    call LOAD_SLOW
    goto LOOP2
LOOP2;Slow Blinks
    decfsz 13
    goto SKIPX
    goto UPDATE
SKIPX
    movlw 0x20 ;00100000
    movwf PORTB ;RB5 HIGH
    call LOAD_SLOW
    movlw 0x00 ;00000000
    movwf PORTB ;RB5 LOW
    call LOAD_SLOW
    GOTO LOOP2
UPDATE;Back to fast blinks
    movlw 0x04
    movwf 12
    movlw 0x04
    movwf 13
    call LOAD_SLOW
    goto LOOP
LOAD_SLOW;195075
    movlw 0xFF ;255
    movwf 10
    movlw 0xFF ;255
    movwf 11
    movlw 0x03
    movwf 15
    goto DELAY
LOAD_FAST;20400
    movlw 0xFF ;255
    movwf 10
    movlw 0x28 ;40
    movwf 11
    movlw 0x02 
    movwf 15
DELAY 
    decfsz 10, F
    goto DELAY
    decfsz 11, F
    goto DELAY
    decfsz 15, F
    goto DELAY
    RETLW 0x00
   
    
END
