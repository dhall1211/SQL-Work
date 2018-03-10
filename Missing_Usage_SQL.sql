/* Formatted on 10/5/2017 8:21:35 AM (QP5 v5.256.13226.35510) */
WITH wanted_opportunity
     AS (SELECT SSO.OPPORTUNITY_ID
           FROM SS_OPPORTUNITY SSO
          WHERE SSO.OPPORTUNITY_ID = :OPPORTUNITY_ID),
     wanted_account
     AS (  SELECT DISTINCT
                  (SSO.OPPORTUNITY_ID || '-' || SSO.SS_ENTITY_NAME) CLIENT_NAME,
                  ssa.iso_ctrl_area,
                  ssa.ldc_name,
                  ssa.ldc_duns,
                  ssa.congestion_zone,
                  ssa.mkt_acct_id,
                  ssa.ss_acct_id,
                  ssa.cust_name,
                  ssa.load_profile,
                  ssa.opp_start_date,
                  ssa.cpct_oblg_qty
             FROM ss_account ssa, ss_opportunity sso, wanted_opportunity
            WHERE     SSO.OPPORTUNITY_ID = ssa.opportunity_id
                  AND SSA.OPPORTUNITY_ID NOT IN (13,
                                                 32,
                                                 34,
                                                 36,
                                                 39,
                                                 41,
                                                 42,
                                                 43,
                                                 46,
                                                 60,
                                                 61,
                                                 62,
                                                 63,
                                                 64,
                                                 67,
                                                 77,
                                                 87)
                  AND ssa.opp_start_date <=
                         TO_CHAR (TRUNC (SYSDATE - 3), 'yyyymmdd')
                  AND (   ssa.opp_end_date IS NULL
                       OR ssa.opp_end_date >=
                             TO_CHAR (TRUNC (SYSDATE + 3), 'yyyymmdd'))
                  AND NOT EXISTS
                             (SELECT NULL
                                FROM nonidrkh nidr
                               WHERE     nidr.ss_acct_id = ssa.ss_acct_id
                                     AND nidr.replace_event_id IS NULL)
                  AND NOT EXISTS
                             (SELECT NULL
                                FROM idrkh idr
                               WHERE     idr.ss_acct_id = ssa.ss_acct_id
                                     AND idr.replace_event_id IS NULL)
                  AND NOT EXISTS
                             (SELECT NULL
                                FROM ss_gas_usg gu
                               WHERE     GU.SS_ACCT_ID = SSA.SS_ACCT_ID
                                     AND GU.REPLACE_EVENT_ID IS NULL)
                  AND SSA.HU_AVAILABLE IS NULL
                  AND wanted_opportunity.opportunity_id = SSA.OPPORTUNITY_ID
         --AND SSA.ISO_CTRL_AREA = 'GAS'
         GROUP BY (SSO.OPPORTUNITY_ID || '-' || SSO.SS_ENTITY_NAME),
                  ssa.iso_ctrl_area,
                  ssa.ldc_name,
                  ssa.ldc_duns,
                  ssa.congestion_zone,
                  ssa.mkt_acct_id,
                  ssa.ss_acct_id,
                  ssa.cust_name,
                  ssa.load_profile,
                  ssa.opp_start_date,
                  ssa.cpct_oblg_qty)
SELECT DISTINCT
       (SSO.OPPORTUNITY_ID || '-' || SSO.SS_ENTITY_NAME) CLIENT_NAME,
       ssa.iso_ctrl_area,
       ssa.ldc_name,
       ssa.ldc_duns,
       ssa.congestion_zone,
       ssa.mkt_acct_id,
       ssa.ss_acct_id,
       ssa.cust_name,
       ssa.load_profile,
       ssa.opp_start_date,
       ssa.cpct_oblg_qty
  FROM ss_account ssa,
       wanted_opportunity,
       wanted_account,
       ss_opportunity sso
 WHERE     SSO.OPPORTUNITY_ID = ssa.opportunity_id
       AND SSA.OPPORTUNITY_ID NOT IN (13,
                                      32,
                                      34,
                                      36,
                                      39,
                                      41,
                                      42,
                                      43,
                                      46,
                                      60,
                                      61,
                                      62,
                                      63,
                                      64,
                                      67,
                                      77,
                                      87)
       AND ssa.opp_start_date <= TO_CHAR (TRUNC (SYSDATE - 3), 'yyyymmdd')
       AND (   ssa.opp_end_date IS NULL
            OR ssa.opp_end_date >= TO_CHAR (TRUNC (SYSDATE + 3), 'yyyymmdd'))
       AND NOT EXISTS
                  (SELECT NULL
                     FROM nonidrkh nidr
                    WHERE     nidr.ss_acct_id = ssa.ss_acct_id
                          AND nidr.replace_event_id IS NULL)
       AND NOT EXISTS
                  (SELECT NULL
                     FROM idrkh idr
                    WHERE     idr.ss_acct_id = ssa.ss_acct_id
                          AND idr.replace_event_id IS NULL)
       AND NOT EXISTS
                  (SELECT NULL
                     FROM ss_gas_usg gu
                    WHERE     GU.SS_ACCT_ID = SSA.SS_ACCT_ID
                          AND GU.REPLACE_EVENT_ID IS NULL)
       AND SSA.HU_AVAILABLE IS NULL
       AND wanted_opportunity.opportunity_id = SSA.OPPORTUNITY_ID;