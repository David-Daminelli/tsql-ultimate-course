USE MyDatabase

-- Creating
CREATE TABLE persons(
    id          INT NOT NULL,
    person_name VARCHAR(50) NOT NULL,
    birth_date  DATE,
    phone       VARCHAR(15) NOT NULL,
    CONSTRAINT  pk_persons PRIMARY KEY(id)
)

SELECT * FROM persons

-- Alter
ALTER TABLE persons
ADD email varchar(50) NOT NULL;

SELECT * FROM persons

ALTER TABLE persons
DROP COLUMN phone;

SELECT * FROM persons

-- Drop
DROP TABLE persons; -- destroy the table