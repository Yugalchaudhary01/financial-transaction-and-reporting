-- Comment: Generating 1000 customers with varied registration dates and types.
INSERT INTO Customers (first_name, last_name, email, phone, registration_date, customer_type, credit_score)
SELECT
    'User' || s.i,
    'Test' || s.i,
    'user' || s.i || '@example.com',
    '555-0100' + s.i,
    '2020-01-01'::date + (random() * 1095) * '1 day'::interval, -- spread over 3 years
    (ARRAY['Individual', 'Business', 'Premium'])[floor(random() * 3) + 1],
    floor(random() * (850 - 500 + 1) + 500)::int
FROM generate_series(1, 1000) AS s(i);