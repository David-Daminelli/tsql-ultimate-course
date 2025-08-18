-- rank orders based on sales high to low
SELECT
  OrderID,
  Sales,
  ROW_NUMBER() OVER(ORDER BY Sales DESC) AS [RankRow]
FROM Sales.Orders

-- Rank
-- same values have same rank

SELECT
  OrderID,
  Sales,
  ROW_NUMBER() OVER(ORDER BY Sales DESC) AS [RankRow],
  Rank() OVER(ORDER BY Sales DESC) AS [Rank]
FROM Sales.Orders

SELECT
  OrderID,
  Sales,
  ROW_NUMBER() OVER(ORDER BY Sales DESC) AS [RankRow],
  Rank() OVER(ORDER BY Sales DESC) AS [Rank],
  DENSE_RANK() OVER(ORDER BY Sales DESC) AS [Rank]
FROM Sales.Orders

-- top sales for each product
SELECT *
FROM (
  SELECT
    OrderID,
    ProductID,
    Sales,
    ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) SalesRank
  FROM Sales.Orders)t
WHERE SalesRank = 1

-- lowest 2 customers
SELECT *
FROM (
  SELECT
    CustomerID,
    SUM(Sales) SalesSum,
    ROW_NUMBER() OVER(ORDER BY SUM(Sales) ASC) SalesRank
  FROM Sales.Orders
  GROUP BY CustomerID
  )t
WHERE SalesRank <= 2

-- Delete duplicates
SELECT *
FROM (
  SELECT
    OrderID,
    CreationTime,
    ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) Rank
  FROM Sales.OrdersArchive
)t
WHERE Rank = 1

-- NTILE

SELECT
  OrderID,
  Sales,
  NTILE(3) OVER (ORDER BY Sales DESC) OneBucket
FROM Sales.Orders

-- segment into 3 categs, hguh mdium and low

SELECT
  *,
  CASE
  WHEN rank = 1 THEN 'High'
  WHEN rank = 2 THEN 'Medium'
  WHEN rank = 3 THEN 'Low'
  END AS [Rank]
FROM(
SELECT
  OrderID,
  Sales,
  NTILE(3) OVER(ORDER BY Sales DESC) rank
FROM Sales.Orders)t