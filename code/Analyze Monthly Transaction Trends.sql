-- [BUSINESS PURPOSE]: To analyze monthly transaction volume to identify growth and seasonal trends.
-- [KEY TECHNIQUES]: DATE_TRUNC, Window Function (SUM OVER)
WITH monthly_summary AS (
    SELECT
        DATE_TRUNC('month', transaction_date)::date as month,
        SUM(amount) as monthly_volume
    FROM Transactions
    GROUP BY month
)
SELECT
    month,
    monthly_volume,
    SUM(monthly_volume) OVER (ORDER BY month) as running_total_volume
FROM monthly_summary
ORDER BY month;