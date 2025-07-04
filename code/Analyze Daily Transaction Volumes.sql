-- [BUSINESS PURPOSE]: To track the daily total transaction count and monetary volume.
-- [KEY TECHNIQUES]: DATE function, GROUP BY, Aggregation
SELECT
    transaction_date::date as day,
    COUNT(transaction_id) as total_transactions,
    SUM(amount) as total_volume
FROM Transactions
GROUP BY day
ORDER BY day DESC
LIMIT 30; -- Show last 30 days for relevance