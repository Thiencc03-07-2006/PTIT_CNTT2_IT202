CREATE DATABASE session06Bai1;
USE session06Bai1;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    city VARCHAR(255)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status ENUM('pending', 'completed', 'cancelled'),
    FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id)
);

INSERT INTO customers (customer_id, full_name, city) VALUES
(1, 'Nguyen Van An', 'Ha Noi'),
(2, 'Tran Thi Binh', 'Hai Phong'),
(3, 'Le Van Cuong', 'Da Nang'),
(4, 'Pham Thi Dao', 'Ha Noi'),
(5, 'Hoang Van Em', 'TP HCM');

INSERT INTO orders (order_id, customer_id, order_date, status) VALUES
(101, 1, '2025-01-01', 'completed'),
(102, 1, '2025-01-05', 'pending'),
(103, 2, '2025-01-03', 'completed'),
(104, 3, '2025-01-07', 'cancelled'),
(105, 3, '2025-01-10', 'completed');

SELECT o.order_id,o.order_date,o.status,c.full_name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

SELECT c.customer_id,c.full_name,COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;

SELECT c.customer_id,c.full_name,COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;