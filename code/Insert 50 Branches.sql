-- Comment: Generating 50 branches across various regions to simulate a national bank.
INSERT INTO Branches (branch_name, city, state, region, manager_name, opening_date)
SELECT
    'Branch ' || s.i,
    (ARRAY['New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix', 'Philadelphia', 'San Antonio', 'San Diego', 'Dallas', 'San Jose'])[floor(random() * 10) + 1],
    (ARRAY['NY', 'CA', 'IL', 'TX', 'AZ', 'PA', 'TX', 'CA', 'TX', 'CA'])[floor(random() * 10) + 1],
    (ARRAY['Northeast', 'West', 'Midwest', 'South'])[floor(random() * 4) + 1],
    'Manager ' || s.i,
    '2010-01-01'::date + (s.i * 30) * '1 day'::interval
FROM generate_series(1, 50) AS s(i);