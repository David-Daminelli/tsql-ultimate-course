-- Count

-- Total number of orders
-- Overall Analysis
SELECT
  COUNT(*) TotalOrders
FROM Sales.Orders

-- provide details as order ID and date

SELECT
  OrderId,
  OrderDate,
  COUNT(*) OVER () TotalOrders
FROM Sales.Orders

-- total order for each customer

SELECT
  OrderId,
  OrderDate,
  CustomerID,
  Count(*) OVER(PARTITION BY CustomerID) TotalOrders
FROM Sales.Orders

-- total number of customers

SELECT
  *,
  COUNT(*) OVER() TotalCustomer,
  COUNT(Score) OVER() TotalScores, -- Doest count Nulls
  COUNT(Country) OVER() TotalCountry
FROM Sales.Customers

-- duplicate lines

SELECT
  OrderID,
  COUNT(*) OVER (PARTITION BY OrderID) CheckPk
FROM Sales.Orders

SELECT
  OrderID,
  COUNT(*) OVER (PARTITION BY OrderID) CheckPk
FROM Sales.OrdersArchive

SELECT *
FROM (
  SELECT
  OrderID,
  COUNT(*) OVER (PARTITION BY OrderID) CheckPk
  FROM Sales.OrdersArchive
)t
WHERE CheckPk > 1


-- Sum

SELECT
  SUM(Sales) TotalSales
FROM Sales.Orders

SELECT
  ProductID,
  SUM(Sales) OVER(PARTITION BY ProductID)
FROM Sales.Orders

-- Percentage contribution of each product sales to the total

SELECT
  ProductID,
  Sales,
  SUM(Sales) OVER() AS [TotalSales],
  ROUND(100*(CAST(Sales AS FLOAT))/(SUM(Sales) OVER()), 2) AS [PercTotal]
FROM Sales.Orders

-- AVG

-- avg sales across all orders and for each product

SELECT
  OrderID,
  ProductID,
  Sales,
  AVG(Sales) OVER() TotalAvg,
  AVG(Sales) OVER(PARTITION BY ProductID) AvgProduct
FROM Sales.Orders

-- Avg score of customers

SELECT
  *,
  AVG(Score) OVER () AS [AvgScoreNull],
  AVG(COALESCE(Score,0)) OVER () AS [AvgScore]
FROM Sales.Customers

-- Orders where sales are highr than avg


SELECT *
FROM(
  SELECT
    OrderID,
    ProductID,
    Sales,
    AVG(Sales) OVER() AS [AvgSales]
  FROM Sales.Orders
)t
WHERE Sales>AvgSales

-- max min

--highest and lowest sales all orders
-- highst lowes for each product

SELECT
  OrderID,
  ProductID,
  Sales,
  MAX(Sales) OVER() [MaxSale],
  Min(Sales) OVER() [MinSale],
  MAX(Sales) OVER(PARTITION BY ProductID) [MaxProductSale],
  Min(Sales) OVER(PARTITION BY ProductID) [MinProductSale]
FROM Sales.Orders

--
SELECT *
FROM
  (SELECT
    *,
    MAX(Salary) OVER() HighestSalary
  FROM Sales.Employees)t
WHERE Salary = HighestSalary

-- Deviation for each sales from the miinum and maxinum

SELECT
  OrderID,
  ProductID,
  Sales,
  MAX(Sales) OVER() [MaxSale],
  Min(Sales) OVER() [MinSale],
  MAX(Sales) OVER() - Sales as [DevMax],
  Sales - Min(Sales) OVER() as [DevMin]
FROM Sales.Orders

-- Moving avarage of sales for each product
SELECT
  ProductID,
  OrderDate,
  Sales,
  AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) AS [MovingAvarage]
FROM Sales.Orders

SELECT
  ProductID,
  OrderDate,
  Sales,
  AVG(Sales) OVER(PARTITION BY ProductID
                  ORDER BY OrderDate
                  ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS [MovingAvarage]
FROM Sales.Orders