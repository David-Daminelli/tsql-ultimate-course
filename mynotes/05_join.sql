-- No Join
SELECT * FROM customers;
SELECT * FROM orders;

-- Inner Join

SELECT
    cst.id,
    cst.first_name,
    ord.order_id,
    ord.sales
FROM customers as cst
INNER JOIN orders as ord
ON cst.id = ord.customer_id;

-- Left Join

SELECT
    cst.id,
    cst.first_name,
    ord.order_id,
    ord.sales
FROM customers as cst
LEFT JOIN orders as ord
ON cst.id = ord.customer_id;

-- Right Join

SELECT
    cst.id,
    cst.first_name,
    ord.order_id,
    ord.sales
FROM customers as cst
RIGHT JOIN orders as ord
ON cst.id = ord.customer_id;


SELECT
    cst.id,
    cst.first_name,
    ord.order_id,
    ord.sales
FROM orders as ord
LEFT JOIN customers as cst
ON cst.id = ord.customer_id;

-- Full

SELECT
    cst.id,
    cst.first_name,
    ord.order_id,
    ord.sales
FROM orders as ord
FULL JOIN customers as cst
ON cst.id = ord.customer_id;

-- Left anti Join
-- Customers that have no orders
SELECT
    cst.id,
    cst.first_name
FROM customers as cst
LEFT JOIN orders as ord
ON cst.id = ord.customer_id
WHERE ord.customer_id is NULL

-- Right anti Join
-- Orders that have no costumers
SELECT ord.*
FROM customers as cst
RIGHT JOIN orders as ord
ON cst.id = ord.customer_id
WHERE cst.id is NULL

SELECT ord.*
FROM  orders as  ord
LEFT JOIN  customers as cst
ON cst.id = ord.customer_id
WHERE cst.id is NULL

-- Full anti-join
SELECT
    cst.id,
    cst.first_name,
    ord.order_id,
    ord.sales
FROM orders as ord
FULL JOIN customers as cst
ON cst.id = ord.customer_id
WHERE cst.id is NULL OR ord.customer_id is NULL;

-- Inner Join without Inner Join
SELECT
    cst.id,
    cst.first_name,
    ord.order_id,
    ord.sales
FROM orders as ord
FULL JOIN customers as cst
ON cst.id = ord.customer_id
WHERE cst.id is not NULL AND ord.customer_id is NOT NULL;

SELECT
    cst.id,
    cst.first_name,
    ord.order_id,
    ord.sales
FROM customers as cst
LEFT JOIN orders as ord
ON cst.id = ord.customer_id
WHERE ord.customer_id IS NOT NULL

-- Cross join
-- do all the combinations

SELECT *
FROM customers
CROSS JOIN orders;

-- Joining multiple tables
USE SalesDB

SELECT
    o.OrderID,
    o.Sales,
    c.FirstName as Customer,
    p.Product,
    p.Price,
    e.FirstName as 'Sales Person'
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers as c
ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products as p
ON o.ProductID = p.ProductID
LEFT JOIN Sales.Employees as e
ON o.SalesPersonID = e.EmployeeID