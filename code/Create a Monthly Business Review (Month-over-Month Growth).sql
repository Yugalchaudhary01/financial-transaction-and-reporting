-- [BUSINESS PURPOSE]: To compare key business metrics month-over-month to track performance and momentum.
-- [KEY TECHNIQUES]: CTE, DATE_TRUNC, Window Function (LAG)
WITH monthly_metrics AS (
    SELECT
        DATE_TRUNC('month', transaction_date)::date as month,
        SUM(amount) as monthly_volume,
        COUNT(DISTINCT account_id) as monthly_active_accounts
    FROM Transactions
    GROUP BY month
),
lagged_metrics AS (
    SELECT
        month,
        monthly_volume,
        monthly_active_accounts,
        LAG(monthly_volume, 1) OVER (ORDER BY month) as previous_month_volume,
        LAG(monthly_active_accounts, 1) OVER (ORDER BY month) as previous_month_active_accounts
    FROM monthly_metrics
)
SELECT
    month,
    monthly_volume,
    previous_month_volume,
    -- Calculate MoM growth percentage
    (monthly_volume - previous_month_volume) * 100.0 / previous_month_volume as volume_growth_pct,
    monthly_active_accounts,
    previous_month_active_accounts,
    (monthly_active_accounts - previous_month_active_accounts) * 100.0 / previous_month_active_accounts as active_accounts_growth_pct
FROM lagged_metrics
WHERE previous_month_volume IS NOT NULL -- Exclude the first month as it has no prior data
ORDER BY month DESC;