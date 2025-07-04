-- [BUSINESS PURPOSE]: To reconstruct the balance history of a specific account over time.
-- [KEY TECHNIQUES]: Window Function (SUM OVER with PARTITION BY)
WITH transaction_flow AS (
  SELECT
    account_id,
    transaction_date,
    transaction_type,
    -- Make withdrawals/payments negative for summation
    CASE WHEN transaction_type IN ('Deposit', 'Salary') THEN amount ELSE -amount END as signed_amount
  FROM Transactions
  WHERE account_id = 10 -- Analyzing a single account for clarity
)
SELECT
  account_id,
  transaction_date,
  transaction_type,
  signed_amount,
  SUM(signed_amount) OVER (PARTITION BY account_id ORDER BY transaction_date) as running_balance
FROM transaction_flow
ORDER BY transaction_date;