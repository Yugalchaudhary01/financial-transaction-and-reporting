-- [BUSINESS PURPOSE]: To identify the highest spending categories for different customer types.
-- [KEY TECHNIQUES]: CTE, JOIN, Window Function (RANK)
WITH category_spending AS (
    SELECT
        c.customer_type,
        t.category,
        SUM(t.amount) as total_spent
    FROM Transactions t
    JOIN Accounts a ON t.account_id = a.account_id
    JOIN Customers c ON a.customer_id = c.customer_id
    WHERE t.transaction_type IN ('Withdrawal', 'Payment')
    GROUP BY c.customer_type, t.category
)
SELECT
    customer_type,
    category,
    total_spent,
    RANK() OVER (PARTITION BY customer_type ORDER BY total_spent DESC) as spending_rank
FROM category_spending
ORDER BY customer_type, spending_rank;