-- Creates the Customers table to store demographic and profile information.
CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    registration_date DATE NOT NULL DEFAULT CURRENT_DATE,
    customer_type VARCHAR(20) CHECK (customer_type IN ('Individual', 'Business', 'Premium')),
    credit_score INT CHECK (credit_score BETWEEN 300 AND 850)
);
COMMENT ON TABLE Customers IS 'Stores demographic and profile information for each customer.';