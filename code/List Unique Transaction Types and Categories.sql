-- Comment: This reveals the diversity of transactions and spending behaviors,
-- forming the basis for more detailed analysis.
(SELECT 'Transaction Types' as item, ARRAY_AGG(DISTINCT transaction_type) FROM Transactions)
UNION ALL
(SELECT 'Transaction Categories', ARRAY_AGG(DISTINCT category) FROM Transactions);