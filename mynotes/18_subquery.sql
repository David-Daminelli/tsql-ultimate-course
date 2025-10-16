SELECT
  ProductID,
  Price
FROM (SELECT
  ProductID,
  Price,
  AVG(Price) OVER() AS [AvgPrice]
FROM Sales.Products) t
WHERE Price > AvgPrice

-- Rank customers based on total amount of sales

SELECT
  *,
  RANK() OVER(ORDER BY TotalSales DESC) as Rank
FROM(
  SELECT
    CustomerID,
    SUM(Sales) AS [TotalSales]
  FROM Sales.Orders
  GROUP BY CustomerID)t

-- Subqueries on select can only return a single value
SELECT
  ProductID,
  Product,
  Price,
  (SELECT SUM(Sales) FROM Sales.Orders) AS [TotalSales]
FROM Sales.Products

-- product ids, names, prices and total nb of orders

-- Main query
SELECT
  ProductID,
  Product,
  Price,
  -- Subquery
  (SELECT COUNT(*) FROM Sales.Orders) AS [TotalOrders]
FROM Sales.Products

-- Show all customer detailes and find the total orders of each customer
SELECT *
FROM Sales.Customers c
LEFT JOIN ( SELECT
              CustomerID,
              COUNT(*) AS [TotalOrders]
            FROM Sales.Orders
            GROUP BY CustomerID) o
ON c.CustomerID = o.CustomerID

-- Products  that ave price higher than the avg price of all products

SELECT *
FROM Sales.Products
WHERE Price > (SELECT AVG(Price) FROM Sales.Products)

-- Orders made by customers made in Germany
SELECT *
FROM Sales.Orders
WHERE CustomerID IN ( SELECT CustomerID
                      FROM Sales.Customers
                      WHERE Country = 'Germany')

-- Opposite
SELECT *
FROM Sales.Orders
WHERE CustomerID IN ( SELECT CustomerID
                      FROM Sales.Customers
                      WHERE Country != 'Germany')

-- Female emplyes whose salaries are greater than salarie of any male employe
SELECT
  FirstName,
  LastName,
  Salary
FROM Sales.Employees
WHERE Gender = 'F' AND
      Salary > ANY( SELECT Salary
                    FROM Sales.Employees
                    WHERE Gender = 'M')

SELECT
  FirstName,
  LastName,
  Salary
FROM Sales.Employees
WHERE Gender = 'F' AND
      Salary > All( SELECT Salary
                    FROM Sales.Employees
                    WHERE Gender = 'M')