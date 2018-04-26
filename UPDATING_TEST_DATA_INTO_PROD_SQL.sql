UPDATE SS.SS_ACCOUNT pa
   SET pa.LOAD_PROFILE =
          (SELECT ta.load_profile
             FROM SS.SS_ACCOUNT@SS_TESTML1 ta
            WHERE     pa.mkt_acct_id = ta.mkt_acct_id
                  AND ta.opportunity_id = '104'
                  AND ta.client_duns = '000004296'
                  AND ta.ldc_duns = 'JAPAN0006'
                  AND ta.line_loss_adjust_code = 'L'
                  AND ta.load_profile IS NOT NULL)
 WHERE     pa.opportunity_id = '104'
       AND pa.client_duns = '000004296'
       AND pa.ldc_duns = 'JAPAN0006'
       AND pa.line_loss_adjust_code = 'L'
       AND EXISTS
              (SELECT 1
                 FROM SS.SS_ACCOUNT@SS_TESTML1 ta
                WHERE     pa.mkt_acct_id = ta.mkt_acct_id
                      AND ta.opportunity_id = '104'
                      AND ta.client_duns = '000004296'
                      AND ta.ldc_duns = 'JAPAN0006'
                      AND ta.line_loss_adjust_code = 'L'
                      AND ta.load_profile IS NOT NULL);