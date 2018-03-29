       IDENTIFICATION DIVISION.
       PROGRAM-ID. ZUNEBUG.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-YEAR PIC 9(9) VALUE 1980.
       01 WS-DAYS PIC 9(9).
       01 WS-Q PIC 9(9).
       01 WS-R1 PIC 9(9).
       01 WS-R2 PIC 9(9).
       01 WS-R3 PIC 9(9).

       PROCEDURE DIVISION.
       MAIN-PARAGRAPH.
           DISPLAY 1 UPON ARGUMENT-NUMBER.
           ACCEPT WS-DAYS FROM ARGUMENT-VALUE.
           PERFORM WITH TEST BEFORE UNTIL WS-DAYS <= 365
      *        LEAP YEAR COMPUTATION
               DIVIDE WS-YEAR BY 4 GIVING WS-Q REMAINDER WS-R1
               DIVIDE WS-YEAR BY 100 GIVING WS-Q REMAINDER WS-R2
               DIVIDE WS-YEAR BY 400 GIVING WS-Q REMAINDER WS-R3
               IF (WS-R1 = 0 AND WS-R2 NOT = 0) OR WS-R3 = 0 THEN
                   IF WS-DAYS IS GREATER THAN 366 THEN
                       SUBTRACT 366 FROM WS-DAYS
                       ADD 1 TO WS-YEAR
                   END-IF
               ELSE
                   SUBTRACT 365 FROM WS-DAYS
                   ADD 1 TO WS-YEAR
               END-IF
           END-PERFORM.
           DISPLAY WS-YEAR.
           STOP RUN.               
