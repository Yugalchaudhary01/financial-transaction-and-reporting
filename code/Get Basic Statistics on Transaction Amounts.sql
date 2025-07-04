-- Comment: Provides a quick look at the distribution of transaction amounts,
-- highlighting the minimum, maximum, and average values.
SELECT
    MIN(amount) as min_transaction_amount,
    MAX(amount) as max_transaction_amount,
    AVG(amount) as avg_transaction_amount,
    STDDEV(amount) as stddev_transaction_amount
FROM Transactions;