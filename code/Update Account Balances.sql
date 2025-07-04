-- Comment: After inserting transactions, we must update the `current_balance` in the
-- Accounts table to reflect the sum of all transactions for data consistency.
WITH transaction_summary AS (
    SELECT
        account_id,
        SUM(
            CASE
                WHEN transaction_type IN ('Deposit', 'Salary') THEN amount
                ELSE -amount
            END
        ) as net_change
    FROM Transactions
    GROUP BY account_id
)
UPDATE Accounts a
SET current_balance = COALESCE(ts.net_change, 0.00)
FROM transaction_summary ts
WHERE a.account_id = ts.account_id;