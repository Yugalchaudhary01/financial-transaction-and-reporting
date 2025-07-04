-- Creates the Accounts table to store details for each customer account, linking customers to branches.
CREATE TABLE Accounts (
    account_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    branch_id INT NOT NULL,
    account_type VARCHAR(20) CHECK (account_type IN ('Checking', 'Savings', 'Credit', 'Investment')),
    opening_date DATE NOT NULL DEFAULT CURRENT_DATE,
    current_balance NUMERIC(15, 2) NOT NULL DEFAULT 0.00,
    status VARCHAR(20) CHECK (status IN ('Active', 'Closed', 'Frozen')) NOT NULL,
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE,
    CONSTRAINT fk_branch FOREIGN KEY (branch_id) REFERENCES Branches(branch_id) ON DELETE SET NULL
);
COMMENT ON TABLE Accounts IS 'Stores details for each customer account, linking customers to branches.';