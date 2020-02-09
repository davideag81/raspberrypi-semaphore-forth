\ include gpio.f
\ inlcude time.f

DECIMAL

20 CONSTANT RCAR
21 CONSTANT YCAR
26 CONSTANT GCAR

19 CONSTANT RPED
13 CONSTANT YPED
6  CONSTANT GPED

5  CONSTANT BUTTON

: WAIT_TIME 5 SEC ;

: RED RCAR RPED ;
: YELLOW YCAR YPED ;
: GREEN GCAR GPED ;

: CAR DROP ;
: PEDESTRIAN SWAP DROP ;

\ SEMSETUP ( -- ) set the output state to the semaphore's GPIO.
: SEMSETUP 
    RED CAR GPFSELOUT!
    YELLOW CAR GPFSELOUT!
    GREEN CAR GPFSELOUT!
    RED PEDESTRIAN GPFSELOUT!
    YELLOW PEDESTRIAN GPFSELOUT!
    GREEN PEDESTRIAN GPFSELOUT!
;

\ SEMINIT ( -- ) initializes the state of the semaphore's LEDs.
: SEMINIT  
    RED CAR GPON! 
    YELLOW CAR GPOFF! 
    GREEN CAR GPOFF! 
    RED PEDESTRIAN GPOFF!
    YELLOW PEDESTRIAN GPOFF! 
    GREEN PEDESTRIAN GPON! 
;

: SEMAPHORE_ROUTINE 
    ." PEDESTRIAN YELLOW " CR
    GREEN PEDESTRIAN GPOFF! YELLOW PEDESTRIAN GPON! WAIT_TIME DELAY 
    ." PEDESTRIAN RED " CR 
    RED PEDESTRIAN GPON! YELLOW PEDESTRIAN GPOFF! RED CAR GPOFF! GREEN CAR GPON! WAIT_TIME DELAY  
    ." CAR YELLOW " CR
    GREEN CAR GPOFF! YELLOW CAR GPON! WAIT_TIME DELAY  
    ." PEDESTRIAN GREEN " CR
    RED CAR GPON! YELLOW CAR GPOFF! RED PEDESTRIAN OFF GREEN PEDESTRIAN ON WAIT_TIME DELAY  
;

\ CHECK ( n -- ) busy wait until GPIO level passed as input is up and then start SEMAPHORE_ROUTINE
: CHECK ." Waiting for input... " CR BEGIN DUP GPLEV@ 0= UNTIL DROP SEMAPHORE_ROUTINE ;

: MAIN SEMINIT BUTTON CHECK ;

SEMSETUP

MAIN
