       IDENTIFICATION DIVISION.
       PROGRAM-ID. FRAUDMOD.
       DATA DIVISION.
       WORKING-STORAGE SECTION.


       01 I PIC 9(2) VALUE 1.
       01 MODEL_ID  PIC X(36) VALUE
                    '3442335c-c694-4e34-b7c9-af26e14cadd6'.
       01 IN_CLASS  PIC X(08) VALUE 'SnapMLIN'.
       01 OUT_CLASS PIC X(09) VALUE 'SnapMLOUT'.

       LINKAGE SECTION.
       01 DFHCOMMAREA.
           02 MODELIN.
           COPY MODELIN.
           02 MODELOUT.
           COPY MODELOUT.

       PROCEDURE DIVISION.

            DISPLAY 'AMOUNT         :' AMOUNT.
            DISPLAY 'MERCHANT CITY  :' MERCHANTXCITY.
            DISPLAY 'MERCHANT NAME  :' MERCHANTXNAME.
            DISPLAY 'MERCHANT STATE :' MERCHANTXSTATE.
            DISPLAY 'USER           :' USER.

            EXEC CICS PUT CONTAINER('ALN_DEPLOY_ID') CHANNEL('CHAN')
               CHAR
               FROM(MODEL_ID)
               END-EXEC.

            EXEC CICS PUT CONTAINER('ALN_INPUT_CLASS') CHANNEL('CHAN')
               CHAR FROM(IN_CLASS)
               END-EXEC.

            EXEC CICS PUT CONTAINER('ALN_INPUT_DATA') CHANNEL('CHAN')
               FROM(MODELIN) BIT END-EXEC.

            EXEC CICS PUT CONTAINER('ALN_OUTPUT_CLASS')
               CHANNEL('CHAN')
               CHAR FROM(OUT_CLASS)
               END-EXEC.

            EXEC CICS LINK PROGRAM('ALNSCORE') CHANNEL('CHAN')
                END-EXEC.
            EXEC CICS GET CONTAINER('ALN_OUTPUT_DATA')
                CHANNEL('CHAN')
                INTO(MODELOUT) END-EXEC.

      *   DISPLAY 'PREDICTION     :' PREDICTION.
      *   DISPLAY 'PROBABILITY    :'.

            DISPLAY 'probabilityX0X :' probabilityX0X.
            DISPLAY 'probabilityX1X :' probabilityX1X.
      *   PERFORM UNTIL I=3
      *   DISPLAY 'PROBABILITY-' I
      *   DISPLAY PROBABILITY(I)
      *   ADD 1 TO I
      *   END-PERFORM.
            EXEC CICS RETURN END-EXEC.
            STOP RUN.
