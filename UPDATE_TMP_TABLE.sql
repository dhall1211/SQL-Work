
UPDATE CW_TITAN.ACCOUNT_CONTRACT a
   SET a.settle_up_month =
          (SELECT tmp.new_settle_up_month
             FROM ESG_TMP.ACCOUNT_CONTRACT_UPDATE tmp,
                  CW_TITAN.ACCOUNT_CONTRACT ac
            WHERE     tmp.customer_tkn = ac.customer_tkn
                  AND tmp.customer_acct_tkn = ac.customer_acct_tkn
                  AND tmp.account_pkg_tkn = ac.account_pkg_tkn
                  AND tmp.acct_contract_tkn = ac.acct_contract_tkn
                  AND tmp.new_settle_up_month != ac.settle_up_month
                  AND tmp.customer_tkn = a.customer_tkn
                  AND tmp.customer_acct_tkn = a.customer_acct_tkn
                  AND tmp.account_pkg_tkn = a.account_pkg_tkn
                  AND tmp.acct_contract_tkn = a.acct_contract_tkn)
 WHERE EXISTS
          (SELECT NULL
             FROM ESG_TMP.ACCOUNT_CONTRACT_UPDATE tmp,
                  CW_TITAN.ACCOUNT_CONTRACT ac
            WHERE     tmp.customer_tkn = ac.customer_tkn
                  AND tmp.customer_acct_tkn = ac.customer_acct_tkn
                  AND tmp.account_pkg_tkn = ac.account_pkg_tkn
                  AND tmp.acct_contract_tkn = ac.acct_contract_tkn
                  AND tmp.new_settle_up_month != ac.settle_up_month
                  AND tmp.customer_tkn = a.customer_tkn
                  AND tmp.customer_acct_tkn = a.customer_acct_tkn
                  AND tmp.account_pkg_tkn = a.account_pkg_tkn
                  AND tmp.acct_contract_tkn = a.acct_contract_tkn);