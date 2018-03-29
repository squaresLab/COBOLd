       IDENTIFICATION DIVISION.
       PROGRAM-ID. GCD.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-A PIC 9(9).
       01 WS-B PIC 9(9).

       PROCEDURE DIVISION.
       MAIN-PARAGRAPH.
           DISPLAY 1 UPON ARGUMENT-NUMBER.
           ACCEPT WS-A FROM ARGUMENT-VALUE.
           DISPLAY 2 UPON ARGUMENT-NUMBER.
           ACCEPT WS-B FROM ARGUMENT-VALUE.
           IF WS-A = 0 THEN
               DISPLAY WS-B
           END-IF
           PERFORM WITH TEST BEFORE UNTIL WS-B = 0
               IF WS-A IS GREATER THAN WS-B THEN
                   COMPUTE WS-A =WS-A - WS-B
               ELSE
                   COMPUTE WS-B =WS-B - WS-A
               END-IF
           END-PERFORM.
           DISPLAY WS-A.
           STOP RUN.

       FIX-PARAGRAPH.
      *    IGNORE THIS, IT'S NOT HERE JUST TO SEED A FIX
           STOP RUN
           STOP RUN.
