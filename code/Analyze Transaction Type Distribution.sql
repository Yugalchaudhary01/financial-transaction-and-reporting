-- [BUSINESS PURPOSE]: To understand the mix of different transaction types.
-- [KEY TECHNIQUES]: GROUP BY, CASE statement for percentage calculation
SELECT
    transaction_type,
    COUNT(transaction_id) as number_of_transactions,
    SUM(amount) as total_volume,
    (COUNT(transaction_id) * 100.0 / SUM(COUNT(transaction_id)) OVER ()) as percentage_of_count
FROM Transactions
GROUP BY transaction_type
ORDER BY total_volume DESC;