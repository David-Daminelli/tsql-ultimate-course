USE SalesDB

SELECT
  FirstName,
  LastName
FROM Sales.Customers
UNION
SELECT
  FirstName,
  LastName
FROM Sales.Employees;

-- Number of columns must match

SELECT
  CustomerID,
  FirstName,
  LastName
FROM Sales.Customers
UNION
SELECT
  FirstName,
  LastName
FROM Sales.Employees;

-- Data types must match

SELECT
  CustomerID,
  LastName
FROM Sales.Customers
UNION
SELECT
  FirstName,
  LastName
FROM Sales.Employees;

-- Aliases are defineds by the first query

SELECT
  FirstName as Primeiro,
  LastName
FROM Sales.Customers
UNION
SELECT
  FirstName as segundo,
  LastName as segsegundo
FROM Sales.Employees;

-- Union
-- All *distinct rows* from both queries
-- Remove duplicates

SELECT
  FirstName,
  LastName
FROM Sales.Customers;

SELECT
  FirstName,
  LastName
FROM Sales.Employees;

SELECT
  FirstName,
  LastName
FROM Sales.Customers
UNION
SELECT
  FirstName,
  LastName
FROM Sales.Employees;

-- Union all
-- Same as union, but keep duplicates

SELECT
  FirstName,
  LastName
FROM Sales.Customers
UNION ALL
SELECT
  FirstName,
  LastName
FROM Sales.Employees;

-- Except
-- Distinct rows from first query that are not found in second query

SELECT
  FirstName,
  LastName
FROM Sales.Employees
EXCEPT
SELECT
  FirstName,
  LastName
FROM Sales.Customers;

-- Intersect
-- Only common

SELECT
  FirstName,
  LastName
FROM Sales.Employees
INTERSECT
SELECT
  FirstName,
  LastName
FROM Sales.Customers;

--
SELECT 'Orders' AS SourceTable
      ,[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.Orders
UNION
SELECT 'OrdersArchive'
      ,[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.OrdersArchive
ORDER BY OrderID