-- Comment: This query confirms that the data generation was successful and gives
-- us a sense of the scale of our database.
SELECT 'Customers' as table_name, COUNT(*) FROM Customers
UNION ALL
SELECT 'Branches', COUNT(*) FROM Branches
UNION ALL
SELECT 'Accounts', COUNT(*) FROM Accounts
UNION ALL
SELECT 'Transactions', COUNT(*) FROM Transactions;