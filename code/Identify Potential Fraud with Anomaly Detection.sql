-- [BUSINESS PURPOSE]: To identify transactions that are significantly larger than a customer's average, which could indicate fraud.
-- [KEY TECHNIQUES]: CTE, Window Functions (AVG, STDDEV), JOIN
WITH customer_stats AS (
    SELECT
        a.customer_id,
        AVG(t.amount) as avg_amount,
        STDDEV(t.amount) as stddev_amount
    FROM Transactions t
    JOIN Accounts a ON t.account_id = a.account_id
    GROUP BY a.customer_id
)
SELECT
    t.transaction_id,
    c.customer_id,
    a.account_id,
    t.transaction_date,
    t.amount as transaction_amount,
    cs.avg_amount,
    cs.stddev_amount
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id
JOIN Customers c ON a.customer_id = c.customer_id
JOIN customer_stats cs ON c.customer_id = cs.customer_id
-- Anomaly rule: transaction is larger than the average + 3 standard deviations
WHERE t.amount > cs.avg_amount + (3 * cs.stddev_amount)
AND cs.stddev_amount > 0 -- Avoid flagging for customers with no variation
ORDER BY t.transaction_date DESC;