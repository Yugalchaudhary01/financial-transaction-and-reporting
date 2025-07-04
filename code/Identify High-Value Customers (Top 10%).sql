-- [BUSINESS PURPOSE]: To identify the top 10% of customers based on their total transaction volume.
-- [KEY TECHNIQUES]: CTE, JOIN, Aggregation (SUM), Window Function (NTILE)
WITH customer_transaction_volume AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(t.amount) AS total_volume
    FROM Customers c
    JOIN Accounts a ON c.customer_id = a.customer_id
    JOIN Transactions t ON a.account_id = t.account_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT
    customer_id,
    first_name,
    last_name,
    total_volume
FROM (
    SELECT
        *,
        NTILE(10) OVER (ORDER BY total_volume DESC) as customer_percentile
    FROM customer_transaction_volume
) AS ranked_customers
WHERE customer_percentile = 1;