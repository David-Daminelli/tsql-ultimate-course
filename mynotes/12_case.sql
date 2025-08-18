-- total sales for each category
SELECT
  Category,
  SUM(Sales) AS [Total]
FROM (
  SELECT
    OrderID,
    Sales,
    CASE
      WHEN Sales > 50 THEN 'High'
      WHEN Sales > 20 THEN 'Medium'
      ELSE 'Low'
    END AS [Category]
  FROM Sales.Orders
) t -- Alias of the subquery
GROUP BY Category
ORDER BY Total DESC

-- Gender as Full Text

SELECT
  EmployeeID,
  FirstName,
  Gender,
  CASE
    WHEN Gender = 'M' THEN 'Male'
    WHEN Gender = 'F' THEN 'Female'
    ELSE 'Not Available'
  END
FROM Sales.Employees

-- Abbreviated countries

SELECT
  CustomerID,
  FirstName,
  Country,
  CASE
    WHEN Country = 'Germany' THEN 'DE'
    WHEN Country = 'USA' THEN 'US'
    ELSE 'NA'
  END
FROM Sales.Customers

SELECT
  CustomerID,
  FirstName,
  Country,
  CASE Country -- Quick Form for Country =
    WHEN 'Germany' THEN 'DE'
    WHEN 'USA' THEN 'US'
    ELSE 'NA'
  END
FROM Sales.Customers

-- avg score of customer and Null=0

SELECT
  CustomerID,
  FirstName,
  LastName,
  AVG(
    CASE
      WHEN Score is Null THEN 0
      ELSE Score
    END
  ) OVER() AS [AvgScore]
FROM Sales.Customers

-- Count how many times each customer made order with sales >30
SELECT
  CustomerID,
  SUM(
    CASE
      WHEN Sales>30 THEN 1
      ELSE 0
    END
  ) AS [TotalHighSales],
  COUNT(*) TotalOrders
FROM Sales.Orders
GROUP BY CustomerID