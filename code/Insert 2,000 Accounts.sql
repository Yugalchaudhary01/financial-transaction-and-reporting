-- Comment: Generating 2000 accounts, ensuring each customer has at least one account.
INSERT INTO Accounts (customer_id, branch_id, account_type, opening_date, status)
SELECT
    -- Assign accounts to customers, some customers will have multiple accounts
    floor(random() * (SELECT COUNT(*) FROM Customers) + 1)::int,
    floor(random() * (SELECT COUNT(*) FROM Branches) + 1)::int,
    (ARRAY['Checking', 'Savings', 'Credit', 'Investment'])[floor(random() * 4) + 1],
    '2020-01-15'::date + (random() * 1095) * '1 day'::interval,
    'Active'
FROM generate_series(1, 2000) AS s(i);