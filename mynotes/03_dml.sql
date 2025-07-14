USE MyDatabase

SELECT * FROM customers;

INSERT INTO customers
        (id, first_name, country, score)
VALUES  (6, 'Anna', 'USA', NULL),
        (7, 'Sam', NULL, 100)

INSERT INTO customers -- Doesnt need the column names
VALUES  (9, 'Andreas', 'Germany', NULL)

SELECT * FROM customers;

INSERT INTO customers (id, first_name)
VALUES (8,'Jorge')

INSERT INTO customers (id, first_name)
VALUES (10,'Sahra')

SELECT * FROM customers;

-- Inserting data from another table
INSERT INTO persons
        (id, person_name, birth_date, phone)
SELECT
    id,
    first_name,
    NULL,
    'Unknown'
FROM customers;
SELECT * FROM persons

-- Update
SELECT *
FROM customers
WHERE id = 6;

UPDATE customers
SET score = 0
WHERE id = 6

UPDATE customers
SET score = 0
WHERE score is NULL

select * from customers;

-- DELETE
DELETE FROM customers
WHERE id > 5;

SELECT * FROM customers

DELETE FROM persons -- Delete all data
TRUNCATE TABLE persons -- Same, but way faster

SELECT * from persons;