-- [BUSINESS PURPOSE]: To verify the correctness of the `current_balance` by recalculating it from scratch.
-- [KEY TECHNIQUES]: Subquery, JOIN, CASE statement
SELECT
    a.account_id,
    a.current_balance as stored_balance,
    (SELECT SUM(CASE WHEN t.transaction_type IN ('Deposit', 'Salary') THEN t.amount ELSE -t.amount END)
     FROM Transactions t
     WHERE t.account_id = a.account_id) as calculated_balance
FROM Accounts a
ORDER BY a.account_id
LIMIT 20; -- Limit for brevity