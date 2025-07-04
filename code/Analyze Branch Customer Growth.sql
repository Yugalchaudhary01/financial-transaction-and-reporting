-- [BUSINESS PURPOSE]: To track new customer acquisition for each branch on a monthly basis.
-- [KEY TECHNIQUES]: JOIN, DATE_TRUNC, GROUP BY
SELECT
    b.branch_name,
    DATE_TRUNC('month', c.registration_date)::date as acquisition_month,
    COUNT(DISTINCT c.customer_id) as new_customers
FROM Branches b
JOIN Accounts a ON b.branch_id = a.branch_id
JOIN Customers c ON a.customer_id = c.customer_id
GROUP BY b.branch_name, acquisition_month
ORDER BY b.branch_name, acquisition_month;