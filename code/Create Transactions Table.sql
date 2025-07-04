-- Creates the Transactions table to store individual transaction records, linked to a specific account.
CREATE TABLE Transactions (
    transaction_id SERIAL PRIMARY KEY,
    account_id INT NOT NULL,
    transaction_type VARCHAR(20) CHECK (transaction_type IN ('Deposit', 'Withdrawal', 'Transfer', 'Payment')),
    amount NUMERIC(15, 2) NOT NULL CHECK (amount > 0),
    transaction_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    description TEXT,
    category VARCHAR(50) CHECK (category IN ('Food', 'Shopping', 'Bills', 'Transfer', 'ATM', 'Salary', 'Entertainment', 'Other'))
);
COMMENT ON TABLE Transactions IS 'Stores individual transaction records, linked to a specific account.';