-- [BUSINESS PURPOSE]: To calculate a simplified Customer Lifetime Value (CLV) based on total transaction volume and customer tenure.
-- [KEY TECHNIQUES]: CTE, JOIN, Date Functions, Aggregation
WITH customer_value_data AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        c.registration_date,
        SUM(t.amount) as total_volume,
        -- Calculate tenure in years
        EXTRACT(YEAR FROM AGE(NOW(), c.registration_date)) + (EXTRACT(MONTH FROM AGE(NOW(), c.registration_date))/12.0) as tenure_years
    FROM Customers c
    JOIN Accounts a ON c.customer_id = a.customer_id
    JOIN Transactions t ON a.account_id = t.account_id
    GROUP BY c.customer_id
)
SELECT
    customer_id,
    first_name,
    last_name,
    total_volume,
    tenure_years,
    -- Simple CLV calculation: total volume divided by tenure. Avoid division by zero.
    CASE
        WHEN tenure_years > 0 THEN total_volume / tenure_years
        ELSE 0
    END as annualized_value
FROM customer_value_data
ORDER BY annualized_value DESC
LIMIT 10;