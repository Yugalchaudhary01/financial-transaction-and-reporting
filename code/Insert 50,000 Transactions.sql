-- Comment: Generating 50,000 transactions with random types, amounts, and categories
-- spanning the last 3 years to enable trend analysis.
INSERT INTO Transactions (account_id, transaction_type, amount, transaction_date, category, description)
SELECT
    floor(random() * (SELECT COUNT(*) FROM Accounts) + 1)::int,
    (ARRAY['Deposit', 'Withdrawal', 'Payment', 'Transfer'])[floor(random() * 4) + 1],
    round((random() * 5000 + 10)::numeric, 2), -- Amounts from $10 to $5010
    (NOW() - '3 years'::interval) + (random() * (365*3)) * '1 day'::interval,
    (ARRAY['Food', 'Shopping', 'Bills', 'Transfer', 'ATM', 'Salary', 'Entertainment', 'Other'])[floor(random() * 8) + 1],
    'Automated sample transaction'
FROM generate_series(1, 50000) AS s(i);