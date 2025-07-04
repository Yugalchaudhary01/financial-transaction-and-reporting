-- [BUSINESS PURPOSE]: To measure the performance of each branch based on total transaction volume.
-- [KEY TECHNIQUES]: Multiple JOINs, Aggregation
SELECT
    b.branch_id,
    b.branch_name,
    b.city,
    b.region,
    COUNT(DISTINCT a.customer_id) as number_of_customers,
    SUM(t.amount) as total_transaction_volume,
    SUM(t.amount) / COUNT(DISTINCT a.customer_id) as volume_per_customer
FROM Branches b
JOIN Accounts a ON b.branch_id = a.branch_id
JOIN Transactions t ON a.account_id = t.account_id
GROUP BY b.branch_id, b.branch_name, b.city, b.region
ORDER BY total_transaction_volume DESC;