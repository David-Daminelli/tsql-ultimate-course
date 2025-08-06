-- String Functions
USE SalesDB

SELECT
  FirstName,
  Country,
  CONCAT(FirstName, ': ', Country) as Concatenation,
  LOWER(FirstName) as low_name,
  UPPER(FirstName) as up_name
FROM sales.customers

-- Trim
USE MyDatabase

SELECT *
FROM customers
WHERE First_Name != TRIM(First_Name)

SELECT
  first_name,
  LEN(first_name) - LEN(TRIM(first_name)) as flag
FROM customers
WHERE len(first_name) - LEN(TRIM(first_name)) > 0

-- Replace
SELECT
  '123-456-7890' as l,
REPLACE('123-456-7890', '-', '/')

-- Len
SELECT
  first_name,
  LEN(first_name) AS name_len
FROM customers

--left/right
SELECT
  first_name,
  LEFT(first_name, 2) AS first_2,
  RIGHT(first_name, 2) AS last_2
FROM customers

-- Substring
-- all name after the first char
SELECT
  first_name,
  SUBSTRING(TRIM(first_name), 2, 2) AS mid_2,
  SUBSTRING(TRIM(first_name), 2, LEN(first_name)) AS all_after_2
FROM customers

---- Numbers
-- Round
SELECT
  3.516,
  ROUND(3.516, 2) as r2,
  -10 neg,
  ABS(-10) abs

---- Date, Time, Timestamp
USE SalesDB

SELECT
  OrderID,
  CreationTime,
  '2025-08-20' as HardCoded,
  GETDATE() as today
FROM Sales.Orders

-- Part extraction

SELECT
  CreationTime,
  YEAR(CreationTime) as year,
  MONTH(CreationTime) as month,
  DAY(CreationTime) as day,
  DATEPART(month, CreationTime) as datepart_month,
  DATEPART(week, CreationTime) as week,
  DATEPART(QUARTER, CreationTime) as QUARTER
FROM Sales.Orders

SELECT
  CreationTime,
  DATENAME(year, CreationTime) as year,
  DATENAME(month, CreationTime) as month,
  DATENAME(weekday, CreationTime) as day
FROM Sales.Orders

SELECT
  CreationTime,
  DATETRUNC(MINUTE, CreationTime) as Minute, -- introduced on 22
FROM Sales.Orders

SELECT
  CreationTime, 
  EOMONTH(CreationTime) as Minute,
FROM Sales.Orders

--
SELECT
  YEAR(OrderDate),
  DATENAME(MONTH, OrderDate),
  COUNT(*)
FROM Sales.Orders
GROUP BY YEAR(OrderDate), DATENAME(MONTH, OrderDate)

SELECT
  OrderDate
FROM Sales.Orders
WHERE MONTH(OrderDate) = 2

SELECT
  OrderID,
  CreationTime,
  FORMAT(CreationTime, 'dddd--MMMM--yyy')
FROM Sales.Orders

SELECT
  OrderID,
  CreationTime,
  FORMAT(CreationTime, 'dd ddd MMM ') +
  'Q' + DATENAME(quarter, CreationTime) +
  ' ' + FORMAT(CreationTime, 'yyyy hh:mm:ss tt')
FROM Sales.Orders

-- Data aggregations
SELECT
  FORMAT(MIN(OrderDate), 'MMM yy') as date,
  COUNT(*) as Count
FROM Sales.Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY YEAR(OrderDate), MONTH(OrderDate);

-- 
SELECT
  --CONVERT(INT, '123'),
  --CONVERT(DATE, '2025-08-20'),
  CreationTime,
  CONVERT(DATE, CreationTime) as [Datetime to Date],
  CONVERT(VARCHAR, CreationTime, 32) as [Datetime to USA std. Style 32],
  CONVERT(VARCHAR, CreationTime, 34) as [Datetime to EU std. Style 34]
FROM Sales.Orders

-- Cast
SELECT
  CAST(CreationTime as DATE),
  CAST('2025-08-12' as DATETIME),
  CAST('123' as INT),
  CAST(123 as VARCHAR),
  CAST('2025-08-12' as DATE)
FROM Sales.Orders

-- DateADD
SELECT
  OrderID,
  OrderDate,
  DATEADD(DAY, -10, OrderDate) as [-10 days],
  DATEADD(MONTH, 3, OrderDate) as [3 month],
  DATEADD(YEAR, 2, OrderDate) as [2 years]
FROM Sales.Orders

-- DateDiff
SELECT
  OrderDate,
  ShipDate,
  DATEDIFF(DAY, OrderDate, ShipDate) as [diff days]
FROM Sales.Orders;

SELECT
  EmployeeID,
  CONCAT(FirstName, ' ', LastName) as [Name],
  BirthDate,
  DATEDIFF(YEAR, BirthDate, GETDATE())
FROM Sales.Employees;

SELECT
  OrderID,
  OrderDate,
  LAG(OrderDate) OVER (ORDER BY OrderDate) as [LagDate],
  DATEDIFF(DAY, LAG(OrderDate) OVER (ORDER BY OrderDate), OrderDate) as [Days From Last Order]
FROM Sales.Orders;

-- IsDate

SELECT
ISDATE('123') as d1,
ISDATE('2025-08-20') as d2,
ISDATE('20/07/2025') as d3,
ISDATE('20-07-2025') as d4,
ISDATE('Ago') as d5

SELECT
  OrderDate,
  ISDATE(OrderDate) as [Date?],
  CASE WHEN ISDATE(OrderDate) = 1 THEN CAST(OrderDate AS DATE)
    ELSE '06/09/0420'
  END NewOrderDate
FROM
(
  SELECT '17/11/2025' as OrderDate UNION
  SELECT '17/08/2025' UNION
  SELECT '07/03/2025' UNION
  SELECT '07/2025'
) as Dates
WHERE ISDATE(OrderDate) = 1