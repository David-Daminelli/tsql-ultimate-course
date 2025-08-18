-- Total sales across all orders

SELECT
  SUM(Sales) AS [TotalSales]
FROM Sales.Orders

-- Total Sales for Each Product

SELECT
  ProductID,
  SUM(Sales) AS [ProductSales]
FROM Sales.Orders
GROUP BY ProductID

-- Total Sales for Each Product, provide order ID and data

SELECT
  OrderID,
  ProductID,
  SUM(Sales) OVER(PARTITION BY ProductID) AS [TotalSalesByProducts] -- Partition By is just like Group By
FROM Sales.Orders

-- total sales across all orders

SELECT
  OrderID,
  OrderDate,
  SUM(Sales) OVER() AS [TotalSales]
FROM Sales.Orders


SELECT
  OrderID,
  OrderDate,
  ProductID,
  SUM(Sales) OVER() AS [TotalSales],
  SUM(Sales) OVER(PARTITION BY ProductID) AS [TotalSalesByProducts] -- Partition By is just like Group By
FROM Sales.Orders

--

SELECT
  OrderID,
  OrderDate,
  ProductID,
  OrderStatus,
  Sales,
    SUM(Sales) OVER(PARTITION BY ProductID, OrderStatus)
FROM Sales.Orders

-- Rank each order based on their sales from high to low

SELECT
  OrderID,
  Sales,
  RANK() OVER(ORDER BY Sales DESC)
FROM Sales.Orders

--

SELECT
  OrderID,
  OrderDate,
  ProductID,
  OrderStatus,
  Sales,
  SUM(Sales) OVER(PARTITION BY OrderStatus
                  ORDER BY OrderDate
                  ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) TotalSales
FROM Sales.Orders

-- Rank based on total sales

SELECT
  CustomerID,
  SUM(Sales)  [TotalSales],
  RANK() OVER(ORDER BY SUM(Sales) DESC) AS RankCustomer
FROM Sales.Orders
GROUP BY CustomerID