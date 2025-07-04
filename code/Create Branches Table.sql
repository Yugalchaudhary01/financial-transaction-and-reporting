-- Creates the Branches table to store operational and location data for each bank branch.
CREATE TABLE Branches (
    branch_id SERIAL PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL,
    manager_name VARCHAR(100),
    opening_date DATE NOT NULL
);
COMMENT ON TABLE Branches IS 'Stores operational and location data for each bank branch.';