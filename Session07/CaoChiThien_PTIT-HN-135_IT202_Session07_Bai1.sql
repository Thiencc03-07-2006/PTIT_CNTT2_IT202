CREATE DATABASE session07Bai1;
USE session07Bai1;

CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

INSERT INTO customers (id, name, email) VALUES
(1, 'Nguyen Van A', 'a@gmail.com'),
(2, 'Tran Thi B', 'b@gmail.com'),
(3, 'Le Van C', 'c@gmail.com'),
(4, 'Pham Thi D', 'd@gmail.com'),
(5, 'Hoang Van E', 'e@gmail.com'),
(6, 'Do Thi F', 'f@gmail.com'),
(7, 'Bui Van G', 'g@gmail.com');

INSERT INTO orders (id, customer_id, order_date, total_amount) VALUES
(101, 1, '2025-01-01', 500000),
(102, 2, '2025-01-02', 1200000),
(103, 1, '2025-01-03', 300000),
(104, 3, '2025-01-04', 800000),
(105, 5, '2025-01-05', 1500000),
(106, 2, '2025-01-06', 450000),
(107, 6, '2025-01-07', 700000);

SELECT *
FROM customers
WHERE id IN (
    SELECT customer_id
    FROM orders
);
