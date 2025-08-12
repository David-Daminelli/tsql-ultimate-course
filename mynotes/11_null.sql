/* TASK 1:
   Find the average scores of the customers.
   Uses COALESCE to replace NULL Score with 0.
*/
-- Média ignora o null
SELECT
  CustomerID,
  Score,
  AVG(Score) OVER () AvgScores,
  AVG(ISNULL(Score, 0)) OVER () AvgScoresNull
FROM Sales.Customers

/* TASK 2:
   Display the full name of customers in a single field by merging their
   first and last names, and add 10 bonus points to each customer's score.
*/
-- Null funciona igual no python, INT+NULL = NULL
SELECT
  FirstName,
  LastName,
  FirstName + ' ' + LastName as FullName,
  Score,
  Score + 10 as ExtendedScore
FROM Sales.Customers

SELECT
  FirstName,
  LastName,
  FirstName + ' ' + COALESCE(LastName, '') as FullName,
  Score,
  COALESCE(Score, 0) + 10 as ExtendedScore
FROM Sales.Customers

/* TASK 3:
   Sort the customers from lowest to highest scores,
   with NULL values appearing last.
*/
SELECT
  CustomerID,
  Score
FROM Sales.Customers
ORDER BY CASE WHEN Score is NULL THEN 1 ELSE 0 END, Score

-- NULLIF
-- Return NULL if data is equal
SELECT
  OrderID,
  Sales,
  Quantity,
  Sales/NULLIF(Quantity,0) as PRICE
FROM Sales.Orders

-- IS NULL

SELECT
  CustomerID,
  FirstName,
  Score
FROM Sales.Customers
WHERE Score is NULL

SELECT
  CustomerID,
  FirstName,
  Score
FROM Sales.Customers
WHERE Score is not NULL

-- left anti join

SELECT *
FROM Sales.Customers

SELECT *
FROM Sales.Orders

SELECT
  cst.CustomerID,
  cst.FirstName,
  ord.OrderID,
  ord.CustomerID
FROM Sales.Customers cst
LEFT JOIN Sales.Orders as ord
ON cst.CustomerID = ord.CustomerID
WHERE ord.CustomerID is NULL

--
WITH Orders AS (
    SELECT 1 AS Id, 'A' AS Category UNION
    SELECT 2, NULL UNION
    SELECT 3, '' UNION
    SELECT 4, '  '
)
SELECT
    *,
    DATALENGTH(Category) AS LenCategory,
    TRIM(Category) AS Policy1,
    NULLIF(TRIM(Category), '') AS Policy2,
    COALESCE(NULLIF(TRIM(Category), ''), 'unknown') AS Policy3
FROM Orders;