       IDENTIFICATION DIVISION.
       PROGRAM-ID. FRAUDMOD.
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 I PIC 9(2) VALUE 1.
       01 MODEL_ID  PIC X(36) VALUE
                    'fdcb0f06-6949-4076-8196-34f7927ffc23'.
       01 IN_CLASS  PIC X(16) VALUE 'FraudMLInWrapper'.
       01 OUT_CLASS PIC X(17) VALUE 'FraudMLOutWrapper'.

       01 COUTPUT.
         03 SCORE-RC                   PIC 9(4) COMP VALUE 0.
         03 SCORE-ERR-ID                  PIC X(8).
         03 SCORE-ERR-MSG                 PIC X(255).
         03 SCORE-ERR-MSG-LEN             PIC S9999 COMP-5 SYNC.
         03 MODELOUT.
             06 prob OCCURS 2          COMP-2 SYNC.
             06 pred                    COMP-2 SYNC.

       LINKAGE SECTION.
       01 DFHCOMMAREA.
           02 FRADMLIN.
           COPY MODELIN.
           02 FRADMLOT.
           COPY MODELOUT.

       PROCEDURE DIVISION.

            DISPLAY 'AMOUNT         :' AMOUNT.
            DISPLAY 'MERCHANT CITY  :' MERCHANTXCITY.
            DISPLAY 'MERCHANT NAME  :' MERCHANTXNAME.
            DISPLAY 'MERCHANT STATE :' MERCHANTXSTATE.
            DISPLAY 'CARD           :' CARD.
            DISPLAY 'ERROSX         :' ERRORSX.
            DISPLAY 'USEXCHIP       :' USEXCHIP.
            DISPLAY 'MCC            :' MCC.
            DISPLAY 'ZIP            :' ZIP.

            EXEC CICS PUT CONTAINER('ALN_DEPLOY_ID') CHANNEL('CHAN')
               CHAR
               FROM(MODEL_ID)
               END-EXEC.

            EXEC CICS PUT CONTAINER('ALN_INPUT_CLASS') CHANNEL('CHAN')
               CHAR FROM(IN_CLASS)
               END-EXEC.

            EXEC CICS PUT CONTAINER('ALN_INPUT_DATA') CHANNEL('CHAN')
               FROM(FRADMLIN) BIT END-EXEC.

            EXEC CICS PUT CONTAINER('ALN_OUTPUT_CLASS')
               CHANNEL('CHAN')
               CHAR FROM(OUT_CLASS)
               END-EXEC.
            DISPLAY FRADMLIN.

            EXEC CICS LINK PROGRAM('ALNSCORE') CHANNEL('CHAN')
                END-EXEC.
            EXEC CICS GET CONTAINER('ALN_OUTPUT_DATA')
                CHANNEL('CHAN')
                INTO(COUTPUT) END-EXEC.

      *   DISPLAY 'PREDICTION     :' PREDICTION.
      *   DISPLAY 'PROBABILITY    :'.
      *      MOVE MODEl_ID TO RES_ID.

      *     DISPLAY 'probabilityX0X :' PREDICTION.
      *     DISPLAY 'probabilityX1X :' PROBABILITY(1).
      *      PERFORM UNTIL I=3
      *      DISPLAY 'PROBABILITY-' I
      *      DISPLAY PROBABILITY(I)
      *      ADD 1 TO I
      *      END-PERFORM.
            DISPLAY "RC =" SCORE-RC.

     
            MOVE MODEL_ID TO RES_ID.
            IF SCORE-RC > 0 THEN 
               DISPLAY "Scoring failed with return code:" 
                        SCORE-RC                  
               DISPLAY "Scoring error message ID: " 
                        SCORE-ERR-ID                                      
               DISPLAY "Scoring error message content: " 
                        SCORE-ERR-MSG                               
            ELSE 
               MOVE MODELOUT TO MODELOUP.
         
               DISPLAY 'PREDICTION     :' PREDICTION 
               DISPLAY 'PROBABILITY    :' 
               PERFORM UNTIL I=3  
               DISPLAY 'PROBABILITY-' I  
               DISPLAY probability(I)  
               ADD 1 TO I  
               END-PERFORM 
            END-IF. 

            EXEC CICS RETURN END-EXEC.
            STOP RUN.
