-- Comment: This query helps understand the time span of our transaction data,
-- which is crucial for any time-series analysis.
SELECT
    MIN(transaction_date)::date as oldest_transaction,
    MAX(transaction_date)::date as newest_transaction
FROM Transactions;