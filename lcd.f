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


: LCD_PULSE LCD_E GPIO DUP ON 5 MSEC DELAY OFF ;

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
    80 AND 80 LCD_D7 ROT ROT = IF ON ELSE OFF THEN
    DUP
    40 AND 40 LCD_D6 ROT ROT = IF ON ELSE OFF THEN
    DUP
    20 AND 20 LCD_D5 ROT ROT = IF ON ELSE OFF THEN
    DUP
    10 AND 10 LCD_D4 ROT ROT = IF ON ELSE OFF THEN
    
    DUP
    08 AND 08 LCD_D3 ROT ROT = IF ON ELSE OFF THEN
    
    DUP
    04 AND 04 LCD_D2 ROT ROT = IF ON ELSE OFF THEN
    
    DUP
    02 AND 02 LCD_D1 ROT ROT = IF ON ELSE OFF THEN
    
    DUP
    01 AND 01 LCD_D0 ROT ROT = IF ON ELSE OFF THEN
    
    DROP

    LCD_PULSE
;

: LCD_WRITE_4
    LCD_RS GPIO SWAP 0> IF ON ELSE OFF THEN 
    
    DUP
    80 AND 80 LCD_D7 ROT ROT = IF ON ELSE OFF THEN
    DUP
    40 AND 40 LCD_D6 ROT ROT = IF ON ELSE OFF THEN
    DUP
    20 AND 20 LCD_D5 ROT ROT = IF ON ELSE OFF THEN
    DUP
    10 AND 10 LCD_D4 ROT ROT = IF ON ELSE OFF THEN
    
    DUP

    LCD_PULSE

    08 AND 08 LCD_D7 ROT ROT = IF ON ELSE OFF THEN
    
    DUP
    04 AND 04 LCD_D6 ROT ROT = IF ON ELSE OFF THEN
    
    DUP
    02 AND 02 LCD_D5 ROT ROT = IF ON ELSE OFF THEN
    
    DUP
    01 AND 01 LCD_D4 ROT ROT = IF ON ELSE OFF THEN
    
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
