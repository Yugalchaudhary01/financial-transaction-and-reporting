-- [BUSINESS PURPOSE]: To generate a high-level summary of key performance indicators (KPIs) for executive review.
-- [KEY TECHNIQUES]: Aggregation, Subqueries/CTEs
WITH kpis AS (
    SELECT
        (SELECT COUNT(*) FROM Customers) as total_customers,
        (SELECT COUNT(*) FROM Accounts WHERE status = 'Active') as total_active_accounts,
        (SELECT SUM(amount) FROM Transactions) as total_transaction_volume_all_time,
        (SELECT SUM(current_balance) FROM Accounts WHERE status = 'Active') as total_assets_under_management,
        (SELECT AVG(current_balance) FROM Accounts WHERE status = 'Active') as average_account_balance
)
SELECT
    'Total Customers' as kpi_name, total_customers::text as kpi_value FROM kpis
UNION ALL
SELECT 'Total Active Accounts', total_active_accounts::text FROM kpis
UNION ALL
SELECT 'Total Transaction Volume', TO_CHAR(total_transaction_volume_all_time, 'FM$999,999,999,999.00') FROM kpis
UNION ALL
SELECT 'Total Assets Under Management', TO_CHAR(total_assets_under_management, 'FM$999,999,999,999.00') FROM kpis
UNION ALL
SELECT 'Average Account Balance', TO_CHAR(average_account_balance, 'FM$999,999,999.00') FROM kpis;