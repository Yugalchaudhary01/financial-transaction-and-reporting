-- [BUSINESS PURPOSE]: To create a composite activity score for each customer based on Recency, Frequency, and Monetary value.
-- [KEY TECHNIQUES]: Multiple CTEs, Date Functions, CASE statements
WITH rfm_base AS (
    SELECT
        c.customer_id,
        MAX(t.transaction_date) as last_transaction_date,
        COUNT(t.transaction_id) as frequency,
        SUM(t.amount) as monetary_value
    FROM Customers c
    JOIN Accounts a ON c.customer_id = a.customer_id
    JOIN Transactions t ON a.account_id = t.account_id
    GROUP BY c.customer_id
),
rfm_scores AS (
    SELECT
        customer_id,
        NTILE(5) OVER (ORDER BY last_transaction_date DESC) as r_score,
        NTILE(5) OVER (ORDER BY frequency DESC) as f_score,
        NTILE(5) OVER (ORDER BY monetary_value DESC) as m_score
    FROM rfm_base
)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    r.r_score,
    r.f_score,
    r.m_score,
    (r.r_score + r.f_score + r.m_score) as total_activity_score
FROM rfm_scores r
JOIN Customers c ON r.customer_id = c.customer_id
ORDER BY total_activity_score DESC
LIMIT 20;