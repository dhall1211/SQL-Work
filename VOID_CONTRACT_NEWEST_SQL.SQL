
BEGIN
   UPDATE SS.PRICEP_CONTRACTS PC
      SET PC.CLOSE_DATE =
             TO_DATE (TO_CHAR (SYSDATE, 'MM/DD/YYYY HH24:MI:SS'),
                      'MM/DD/YYYY HH24:MI:SS')
    WHERE     PC.CONTRACT_STATUS = 'Contract Approved'
          AND PC.CONTRACT_GROUP_ID = :CONTRACT_GROUP_ID
          AND PC.OPPORTUNITY_ID = :OPPORTUNITY_ID;

   UPDATE SS.PRICEP_CONTRACTS PC
      SET PC.CONTRACT_STATUS = 'Contract Voided'
    WHERE     PC.CONTRACT_STATUS = 'Contract Approved'
          AND PC.CONTRACT_GROUP_ID = :CONTRACT_GROUP_ID
          AND PC.OPPORTUNITY_ID = :OPPORTUNITY_ID;

   UPDATE CW_SOURCE.OPPORTUNITY OP
      SET OP.SUB_STATUS_DESC = 'Contract Voided'
    WHERE OP.OPPORTUNITY_TKN = :OPPORTUNITY_ID;

   UPDATE CW_SOURCE.OPPORTUNITY OP
      SET OP.STATUS_DESC = 'Open'
    WHERE OP.OPPORTUNITY_TKN = :OPPORTUNITY_ID;

   UPDATE CW_SOURCE.OPPORTUNITY OP
      SET OP.UPDATE_TSTAMP =
             TO_DATE (TO_CHAR (SYSDATE, 'MM/DD/YYYY HH24:MI:SS'),
                      'MM/DD/YYYY HH24:MI:SS')
    WHERE OP.OPPORTUNITY_TKN = :OPPORTUNITY_ID;

   UPDATE CW_SOURCE.OPPORTUNITY_STATUS OPS
      SET OPS.UPDATE_TSTAMP =
             TO_DATE (TO_CHAR (SYSDATE, 'MM/DD/YYYY HH24:MI:SS'),
                      'MM/DD/YYYY HH24:MI:SS')
    WHERE     OPS.END_DATE IS NULL
          AND OPS.STATUS_DESC = 'Contract Approved'
          AND OPS.OPPORTUNITY_TKN = :OPPORTUNITY_ID;


   UPDATE CW_SOURCE.OPPORTUNITY_STATUS OPS
      SET OPS.END_DATE = TRUNC (SYSDATE)
    WHERE     OPS.END_DATE IS NULL
          AND OPS.STATUS_DESC = 'Contract Approved'
          AND OPS.OPPORTUNITY_TKN = :OPPORTUNITY_ID;


   UPDATE CW_SOURCE.OPPORTUNITY_STATUS OPS
      SET OPS.END_DATE = TRUNC (SYSDATE)
    WHERE     OPS.END_DATE IS NULL
          AND OPS.STATUS_DESC = 'Won'
          AND OPS.OPPORTUNITY_TKN = :OPPORTUNITY_ID;


   INSERT INTO CW_SOURCE.OPPORTUNITY_STATUS (OPPORTUNITY_TKN,
                                             OPPORTUNITY_STATUS_TKN,
                                             CREATE_TSTAMP,
                                             CREATE_USERID,
                                             UPDATE_TSTAMP,
                                             UPDATE_USERID,
                                             TYPE_DESC,
                                             STATUS_DESC,
                                             START_DATE,
                                             END_DATE,
                                             LOG_TEXT)
        VALUES ( :OPPORTUNITY_ID,
                TRUNC (DBMS_RANDOM.VALUE (1, 9999)),
                TO_DATE (TO_CHAR (SYSDATE, 'MM/DD/YYYY HH24:MI:SS'),
                      'MM/DD/YYYY HH24:MI:SS'),
                'dhall',
                TO_DATE (TO_CHAR (SYSDATE, 'MM/DD/YYYY HH24:MI:SS'),
                      'MM/DD/YYYY HH24:MI:SS'),
                'dhall',
                'Primary',
                'Open',
                TRUNC (SYSDATE),
                NULL,
                NULL);


   INSERT INTO CW_SOURCE.OPPORTUNITY_STATUS (OPPORTUNITY_TKN,
                                             OPPORTUNITY_STATUS_TKN,
                                             CREATE_TSTAMP,
                                             CREATE_USERID,
                                             UPDATE_TSTAMP,
                                             UPDATE_USERID,
                                             TYPE_DESC,
                                             STATUS_DESC,
                                             START_DATE,
                                             END_DATE,
                                             LOG_TEXT)
        VALUES ( :OPPORTUNITY_ID,
                TRUNC (DBMS_RANDOM.VALUE (1, 9999)),
                TO_DATE (TO_CHAR (SYSDATE, 'MM/DD/YYYY HH24:MI:SS'),
                      'MM/DD/YYYY HH24:MI:SS'),
                'dhall',
                TO_DATE (TO_CHAR (SYSDATE, 'MM/DD/YYYY HH24:MI:SS'),
                      'MM/DD/YYYY HH24:MI:SS'),
                'dhall',
                'Sub',
                'Contract Voided',
                TRUNC (SYSDATE),
                NULL, 
                NULL);
END;

COMMIT;