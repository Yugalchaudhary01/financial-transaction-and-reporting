-- [BUSINESS PURPOSE]: To analyze customer activity by counting monthly transactions per customer.
-- [KEY TECHNIQUES]: CTE, JOIN, DATE_TRUNC, Window Function (RANK)
WITH monthly_activity AS (
    SELECT
        c.customer_id,
        DATE_TRUNC('month', t.transaction_date)::date as activity_month,
        COUNT(t.transaction_id) as transaction_count
    FROM Customers c
    JOIN Accounts a ON c.customer_id = a.customer_id
    JOIN Transactions t ON a.account_id = t.account_id
    GROUP BY c.customer_id, activity_month
)
SELECT
    customer_id,
    activity_month,
    transaction_count,
    RANK() OVER (PARTITION BY activity_month ORDER BY transaction_count DESC) as activity_rank
FROM monthly_activity
ORDER BY activity_month, activity_rank
LIMIT 20; -- Limit for brevity