-- MoM performance by ffindig percentage change
-- between current and previous month

SELECT
*,
(SalesMonth - PreviousSales) AS [MoMChange],
ROUND(100*(SalesMonth - PreviousSales)/CAST(PreviousSales AS Float), 2) AS [MoMChangePerc]
FROM (
  SELECT
    MONTH(OrderDate) AS [OrderMonth],
    SUM(Sales) AS [SalesMonth],
    LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) AS [PreviousSales]
  FROM Sales.Orders
  GROUP BY MONTH(OrderDate))t

-- Rank customer based on avg days between orders
SELECT
  CustomerID,
  --DATEDIFF(DAY,PreviousOrder, OrderDate) AS [DaysFromPrevOrder],
  AVG(DATEDIFF(DAY,PreviousOrder, OrderDate)),
  RANK() OVER(ORDER BY AVG(DATEDIFF(DAY,PreviousOrder, OrderDate)))
FROM (SELECT
  OrderID,
  CustomerID,
  OrderDate,
  LAG(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS [PreviousOrder]
FROM Sales.Orders)t
GROUP BY CustomerID

--Highest and loest sale for each product
SELECT
  ProductID,
  Sales,
  FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) [Lowest],
  LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) [HighestSale]
FROM Sales.Orders

SELECT
  ProductID,
  MAX(Sales) as High,
  MIN(Sales) as Low
FROM Sales.Orders
GROUP BY ProductID

-- Comparing current with lowest/highest

SELECT
  ProductID,
  Sales,
  (Sales - LowestSale) AS [DiffLow],
  (Sales - HighestSale) AS [DiffHigh]
FROM (SELECT
  ProductID,
  Sales,
  FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) [LowestSale],
  LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) [HighestSale]
FROM Sales.Orders)t
