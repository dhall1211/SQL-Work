SELECT pa.mkt_acct_id,
       ta.load_profile AS "Test Load_Profile",
       pa.load_profile AS "PROD Load_Profile"
             
  FROM (SELECT mkt_acct_id, load_profile
          FROM SS.SS_ACCOUNT
         WHERE     opportunity_id = '104'
               AND client_duns = '000004296'
               AND ldc_duns = 'JAPAN0006'
               AND line_loss_adjust_code = 'L') pa,
       (SELECT mkt_acct_id, load_profile
          FROM SS.SS_ACCOUNT@SS_TESTML1
         WHERE     opportunity_id = '104'
               AND client_duns = '000004296'
               AND ldc_duns = 'JAPAN0006'
               AND line_loss_adjust_code = 'L') ta
WHERE pa.mkt_acct_id = ta.mkt_acct_id;
