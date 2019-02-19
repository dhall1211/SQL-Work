WITH wanted_event_id
     AS (SELECT EVT.EVENT_ID
           FROM SS_EVENT_LOG EVT
          WHERE EVT.TP_DUNS = :LDC_DUNS),
     wanted_opportunity
     AS (SELECT OPP.OPPORTUNITY_ID
           FROM SS_OPPORTUNITY OPP
          WHERE OPP.OPPORTUNITY_ID = :OPPORTUNITY_ID),
     wanted_account
     AS (SELECT SS_ACCT_ID,
                LDC_NAME,
                LDC_DUNS,
                CONGESTION_ZONE,
                CUST_NAME,
                MKT_ACCT_ID,
                LOAD_PROFILE
           FROM SS_ACCOUNT SSA
          WHERE ssa.ldc_duns = :LDC_DUNS AND SSA.MKT_ACCT_ID = :Account_Number),
     wanted_usage_detail
     AS (SELECT IDR.IE_0030,
                IDR.IE_0100,
                IDR.IE_0130,
                IDR.IE_0200,
                IDR.IE_0230,
                IDR.IE_0300,
                IDR.IE_0330,
                IDR.IE_0400,
                IDR.IE_0430,
                IDR.IE_0500,
                IDR.IE_0530,
                IDR.IE_0600,
                IDR.IE_0630,
                IDR.IE_0700,
                IDR.IE_0730,
                IDR.IE_0800,
                IDR.IE_0830,
                IDR.IE_0900,
                IDR.IE_0930,
                IDR.IE_1000,
                IDR.IE_1030,
                IDR.IE_1100,
                IDR.IE_1130,
                IDR.IE_1200,
                IDR.IE_1230,
                IDR.IE_1300,
                IDR.IE_1330,
                IDR.IE_1400,
                IDR.IE_1430,
                IDR.IE_1500,
                IDR.IE_1530,
                IDR.IE_1600,
                IDR.IE_1630,
                IDR.IE_1700,
                IDR.IE_1730,
                IDR.IE_1800,
                IDR.IE_1830,
                IDR.IE_1900,
                IDR.IE_1930,
                IDR.IE_2000,
                IDR.IE_2030,
                IDR.IE_2100,
                IDR.IE_2130,
                IDR.IE_2200,
                IDR.IE_2230,
                IDR.IE_2300,
                IDR.IE_2330,
                IDR.IE_2400
           FROM IDRKH_IMBALANCE idr,
                wanted_event_Id,
                wanted_opportunity,
                wanted_Account
          WHERE wanted_event_ID.EVENT_ID = IDR.EVENT_ID)
  SELECT SSA.LDC_DUNS AS "LDC_DUNS",
         SSA.LDC_NAME AS "LDC Name",
         SSA.CONGESTION_ZONE AS "Area",
         SSA.CUST_NAME AS "Customer Name",
         SSA.MKT_ACCT_ID AS "Account Number",
         SSA.LOAD_PROFILE AS "Load Profile",
         IDR.IDR_DATE AS "IDR_Date",
         SUM (
              NVL (IE_0030, 0)
            + NVL (IE_0100, 0)
            + NVL (IE_0130, 0)
            + NVL (IE_0200, 0)
            + NVL (IE_0230, 0)
            + NVL (IE_0300, 0)
            + NVL (IE_0330, 0)
            + NVL (IE_0400, 0)
            + NVL (IE_0430, 0)
            + NVL (IE_0500, 0)
            + NVL (IE_0530, 0)
            + NVL (IE_0600, 0)
            + NVL (IE_0630, 0)
            + NVL (IE_0700, 0)
            + NVL (IE_0730, 0)
            + NVL (IE_0800, 0)
            + NVL (IE_0830, 0)
            + NVL (IE_0900, 0)
            + NVL (IE_0930, 0)
            + NVL (IE_1000, 0)
            + NVL (IE_1030, 0)
            + NVL (IE_1100, 0)
            + NVL (IE_1130, 0)
            + NVL (IE_1200, 0)
            + NVL (IE_1230, 0)
            + NVL (IE_1300, 0)
            + NVL (IE_1330, 0)
            + NVL (IE_1400, 0)
            + NVL (IE_1430, 0)
            + NVL (IE_1500, 0)
            + NVL (IE_1530, 0)
            + NVL (IE_1600, 0)
            + NVL (IE_1630, 0)
            + NVL (IE_1700, 0)
            + NVL (IE_1730, 0)
            + NVL (IE_1800, 0)
            + NVL (IE_1830, 0)
            + NVL (IE_1900, 0)
            + NVL (IE_1930, 0)
            + NVL (IE_2000, 0)
            + NVL (IE_2030, 0)
            + NVL (IE_2100, 0)
            + NVL (IE_2130, 0)
            + NVL (IE_2200, 0)
            + NVL (IE_2230, 0)
            + NVL (IE_2300, 0)
            + NVL (IE_2330, 0)
            + NVL (IE_2400, 0))
            AS "Daily_Total",
         IDR.IE_0030,
         IDR.IE_0100,
         IDR.IE_0130,
         IDR.IE_0200,
         IDR.IE_0230,
         IDR.IE_0300,
         IDR.IE_0330,
         IDR.IE_0400,
         IDR.IE_0430,
         IDR.IE_0500,
         IDR.IE_0530,
         IDR.IE_0600,
         IDR.IE_0630,
         IDR.IE_0700,
         IDR.IE_0730,
         IDR.IE_0800,
         IDR.IE_0830,
         IDR.IE_0900,
         IDR.IE_0930,
         IDR.IE_1000,
         IDR.IE_1030,
         IDR.IE_1100,
         IDR.IE_1130,
         IDR.IE_1200,
         IDR.IE_1230,
         IDR.IE_1300,
         IDR.IE_1330,
         IDR.IE_1400,
         IDR.IE_1430,
         IDR.IE_1500,
         IDR.IE_1530,
         IDR.IE_1600,
         IDR.IE_1630,
         IDR.IE_1700,
         IDR.IE_1730,
         IDR.IE_1800,
         IDR.IE_1830,
         IDR.IE_1900,
         IDR.IE_1930,
         IDR.IE_2000,
         IDR.IE_2030,
         IDR.IE_2100,
         IDR.IE_2130,
         IDR.IE_2200,
         IDR.IE_2230,
         IDR.IE_2300,
         IDR.IE_2330,
         IDR.IE_2400
    FROM SS_EVENT_LOG evt,
         IDRKH_IMBALANCE IDR,
         SS_ACCOUNT SSA,
         wanted_event_ID,
         wanted_opportunity,
         wanted_account
   WHERE     IDR.EVENT_ID = EVT.EVENT_ID
         AND wanted_event_Id.event_ID = IDR.EVENT_ID
         AND SSA.SS_ACCT_ID = IDR.SS_ACCT_ID
         AND WANTED_ACCOUNT.MKT_ACCT_ID = IDR.MKT_ACCT_ID
         AND IDR.MKT_ACCT_ID = SSA.MKT_ACCT_ID
         AND WANTED_ACCOUNT.SS_ACCT_ID = IDR.SS_ACCT_ID
         AND IDR.IDR_DATE >= SYSDATE - 30
         AND IDR.PURP_CODE <> '01'
         AND IDR.PURP_CODE = '00'
GROUP BY SSA.LDC_DUNS,
         SSA.LDC_NAME,
         SSA.CONGESTION_ZONE,
         SSA.CUST_NAME,
         SSA.MKT_ACCT_ID,
         SSA.LOAD_PROFILE,
         IDR.IDR_DATE,
         IDR.IE_0030,
         IDR.IE_0100,
         IDR.IE_0130,
         IDR.IE_0200,
         IDR.IE_0230,
         IDR.IE_0300,
         IDR.IE_0330,
         IDR.IE_0400,
         IDR.IE_0430,
         IDR.IE_0500,
         IDR.IE_0530,
         IDR.IE_0600,
         IDR.IE_0630,
         IDR.IE_0700,
         IDR.IE_0730,
         IDR.IE_0800,
         IDR.IE_0830,
         IDR.IE_0900,
         IDR.IE_0930,
         IDR.IE_1000,
         IDR.IE_1030,
         IDR.IE_1100,
         IDR.IE_1130,
         IDR.IE_1200,
         IDR.IE_1230,
         IDR.IE_1300,
         IDR.IE_1330,
         IDR.IE_1400,
         IDR.IE_1430,
         IDR.IE_1500,
         IDR.IE_1530,
         IDR.IE_1600,
         IDR.IE_1630,
         IDR.IE_1700,
         IDR.IE_1730,
         IDR.IE_1800,
         IDR.IE_1830,
         IDR.IE_1900,
         IDR.IE_1930,
         IDR.IE_2000,
         IDR.IE_2030,
         IDR.IE_2100,
         IDR.IE_2130,
         IDR.IE_2200,
         IDR.IE_2230,
         IDR.IE_2300,
         IDR.IE_2330,
         IDR.IE_2400
ORDER BY  ssa.MKT_ACCT_ID ,IDR_DATE DESC;