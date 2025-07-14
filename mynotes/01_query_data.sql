-- 34:01 Query Data (SELECT)
USE MyDatabase; -- Select the correct DataBase

-- Select all columns
SELECT *
FROM customers;

SELECT *
FROM orders;

-- Select few columns
SELECT
  country,
  first_name,
  score
FROM customers;

-- Where
SELECT *          -- 3
FROM customers    -- 1
WHERE score != 0; -- 2

SELECT *          -- 3
FROM customers    -- 1
WHERE country = 'Germany'; -- 2

SELECT
  first_name,
  country
FROM customers    -- 1
WHERE country = 'Germany'; -- 2

-- Order By
SELECT *
FROM customers
ORDER BY score ASC

SELECT *
FROM customers
ORDER BY
  country ASC,  -- Here the country is sorted
  score DESC    -- first

-- Group by
SELECT
  country,
  SUM(score) as total_score
FROM customers
GROUP BY country;

SELECT
  country,
  COUNT(id) as count,
  SUM(score) as total_score
FROM customers
GROUP BY country;

SELECT *
FROM customers;

-- Having
SELECT
  country,
  avg(score) as avg_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING avg(score) > 430

-- Distinct
SELECT DISTINCT country
FROM customers;

-- TOP
SELECT TOP 3 *
FROM customers
ORDER BY score DESC;

SELECT TOP 2 *
FROM orders
ORDER BY order_date DESC;