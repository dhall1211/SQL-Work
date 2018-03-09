WITH wanted_event_id
AS (   SELECT EVT.EVENT_ID
        FROM SS_EVENT_LOG EVT
         WHERE EVT.EVENT_DESC = 'procurement submission'
          AND EVT.TP_DUNS = : LDC_DUNS),            
     wanted_opportunity
AS (  SELECT OPP.OPPORTUNITY_ID
       FROM SS_OPPORTUNITY OPP    
        WHERE OPP.OPPORTUNITY_ID = :OPPORTUNITY_ID),
procurement_plan_send 
AS(  SELECT PP.OPERATING_DATE
      FROM PROCUREMENT_PLAN pp, wanted_event_Id, wanted_opportunity
       WHERE wanted_event_ID.EVENT_ID = PP.EVENT_ID
        AND PP.GROUP_ID = wanted_opportunity.OPPORTUNITY_ID
         AND PP.OPERATING_DATE = :OPERATING_DATE
          GROUP BY PP.OPERATING_DATE)               
SELECT DISTINCT   
        PP.EVENT_ID,
        PP.GROUP_ID, 
        PP.OPERATING_DATE AS PROCUREMENT_DATE,  
        PP.FILENAME AS XML_FILENAME,
        EVT.EVENT_ID,
        EVT.CLIENT_DUNS,
        EVT.EVENT_DESC,
        EVT.EVENT_TIMESTAMP AS ACTUAL_SEND,
        EVT.SRC_USER AS SUBMITTER,
        PP.RESULT_STATUS_DESC,
        PP.RESULT_STATUS_CODE
FROM PROCUREMENT_PLAN pp, SS_EVENT_LOG evt, procurement_plan_send, wanted_event_ID, wanted_opportunity
 WHERE PP.EVENT_ID = EVT.EVENT_ID
  AND wanted_event_Id.event_ID = PP.EVENT_ID
  AND PP.GROUP_ID = wanted_opportunity.OPPORTUNITY_ID
  AND procurement_plan_send.Operating_date = PP.OPERATING_DATE
  AND EVT.EVENT_DESC = 'procurement submission'
  AND PP.PLAN_TYPE = 'DAILY';
 
          