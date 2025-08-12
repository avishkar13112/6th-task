Create Database Customers8;
Use Customers8;
-- Customers Table
CREATE TABLE Customers8 (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

-- Orders Table
CREATE TABLE Orders8 (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers8(customer_id)
);

INSERT INTO Customers8 VALUES
(1, 'Alice', 'Mumbai'),
(2, 'Bob', 'Delhi'),
(3, 'Charlie', 'Pune'),
(4, 'David', 'Mumbai');

INSERT INTO Orders8 VALUES
(101, 1, '2025-08-01', 1200.50),
(102, 2, '2025-08-02', 800.00),
(103, 1, '2025-08-03', 600.00),
(104, 3, '2025-08-04', 1500.00),
(105, 4, '2025-08-05', 500.00);

SELECT 
    name,
    (SELECT SUM(amount) 
     FROM Orders8
     WHERE Orders8.customer_id = Customers8.customer_id) AS total_spent
FROM Customers8;

SELECT name
FROM Customers8
WHERE customer_id IN (
    SELECT customer_id
    FROM Orders8
    WHERE amount > 1000
);

SELECT name
FROM Customers8 c
WHERE EXISTS (
    SELECT 1
    FROM Orders8 o
    WHERE o.customer_id = c.customer_id
);

SELECT name, max_amount
FROM (
    SELECT c.name, MAX(o.amount) AS max_amount
    FROM Customers8 c
    JOIN Orders8 o ON c.customer_id = o.customer_id
    GROUP BY c.name
) AS sub
WHERE max_amount > 1000;