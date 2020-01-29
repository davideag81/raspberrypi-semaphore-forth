\ include gpio.f
\ inlcude time.f

DECIMAL

\ VSS     GND
\ VDD     +5V
\ VO      POT
25 CONSTANT LCD_RS      
\ RW      GND
24 CONSTANT LCD_E       
12 CONSTANT LCD_D0      
4  CONSTANT LCD_D1      
27 CONSTANT LCD_D2      
16 CONSTANT LCD_D3      
23 CONSTANT LCD_D4      
17 CONSTANT LCD_D5      
18 CONSTANT LCD_D6      
22 CONSTANT LCD_D7      
\ A       +5V
\ K       GND

1 CONSTANT LCD_CHR 
0 CONSTANT LCD_CMD 

: LCD_SETUP 
    LCD_E  GPIO MODE OUTPUT
    LCD_RS GPIO MODE OUTPUT
    LCD_D0 GPIO MODE OUTPUT
    LCD_D1 GPIO MODE OUTPUT
    LCD_D2 GPIO MODE OUTPUT
    LCD_D3 GPIO MODE OUTPUT
    LCD_D4 GPIO MODE OUTPUT
    LCD_D5 GPIO MODE OUTPUT
    LCD_D6 GPIO MODE OUTPUT
    LCD_D7 GPIO MODE OUTPUT
;


: +ENABLE_SIGNAL LCD_E GPIO ON ;

: -ENABLE_SIGNAL LCD_E GPIO OFF ;

: LCD_PULSE -ENABLE_SIGNAL 100 USEC DELAY +ENABLE_SIGNAL 100 USEC DELAY -ENABLE_SIGNAL ;

: LCD_D_RESET
    LCD_E GPIO OFF
    LCD_D0 GPIO OFF
    LCD_D1 GPIO OFF
    LCD_D2 GPIO OFF
    LCD_D3 GPIO OFF
    LCD_D4 GPIO OFF
    LCD_D5 GPIO OFF
    LCD_D6 GPIO OFF
    LCD_D7 GPIO OFF
;


HEX
: LCD_WRITE
    LCD_RS GPIO SWAP 0> IF ON ELSE OFF THEN 
    
    DUP
    LCD_D7 GPIO SWAP 80 AND 80 = IF ON ELSE OFF THEN
    DUP
    LCD_D6 GPIO SWAP 40 AND 40 = IF ON ELSE OFF THEN
    DUP
    LCD_D5 GPIO SWAP 20 AND 20 = IF ON ELSE OFF THEN
    DUP
    LCD_D4 GPIO SWAP 10 AND 10 = IF ON ELSE OFF THEN
    
    DUP
    LCD_D3 GPIO SWAP 08 AND 08 = IF ON ELSE OFF THEN
    
    DUP
    LCD_D2 GPIO SWAP 04 AND 04 = IF ON ELSE OFF THEN
    
    DUP
    LCD_D1 GPIO SWAP 02 AND 02 = IF ON ELSE OFF THEN
    
    DUP
    LCD_D0 GPIO SWAP 01 AND 01 = IF ON ELSE OFF THEN
    
    DROP

    LCD_PULSE
;

: LCD_WRITE_4
    LCD_RS GPIO SWAP 0> IF ON ELSE OFF THEN 
    
    DUP
    LCD_D7 GPIO SWAP 80 AND 80 = IF ON ELSE OFF THEN
    DUP
    LCD_D6 GPIO SWAP 40 AND 40 = IF ON ELSE OFF THEN
    DUP
    LCD_D5 GPIO SWAP 20 AND 20 = IF ON ELSE OFF THEN
    DUP
    LCD_D4 GPIO SWAP 10 AND 10 = IF ON ELSE OFF THEN
    
    DUP

    LCD_PULSE

    LCD_D7 GPIO SWAP 08 AND 08 = IF ON ELSE OFF THEN
    
    DUP
    LCD_D6 GPIO SWAP 04 AND 04 = IF ON ELSE OFF THEN
    
    DUP
    LCD_D5 GPIO SWAP 02 AND 02 = IF ON ELSE OFF THEN
    
    DUP
    LCD_D4 GPIO SWAP 01 AND 01 = IF ON ELSE OFF THEN
    
    DROP

    LCD_PULSE
;

HEX
: INIT
    33 LCD_CMD LCD_WRITE
    32 LCD_CMD LCD_WRITE
    6 LCD_CMD LCD_WRITE
    C LCD_CMD LCD_WRITE
    28 LCD_CMD LCD_WRITE
    1 LCD_CMD LCD_WRITE
;