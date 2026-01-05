CREATE DATABASE session06Bai2;
USE session06Bai2;

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
    total_amount DECIMAL(10 , 2 ),
    FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id)
);

INSERT INTO customers (customer_id, full_name, city) VALUES
(1, 'Nguyen Van An', 'Ha Noi'),
(2, 'Tran Thi Binh', 'Hai Phong'),
(3, 'Le Van Cuong', 'Da Nang'),
(4, 'Pham Thi Dao', 'Ha Noi'),
(5, 'Hoang Van Em', 'TP HCM');

INSERT INTO orders (order_id, customer_id, order_date, status, total_amount) VALUES
(101, 1, '2025-01-01', 'completed',1500000),
(102, 1, '2025-01-05', 'pending',2200000),
(103, 2, '2025-01-03', 'completed',800000),
(104, 3, '2025-01-07', 'cancelled',1200000),
(105, 3, '2025-01-10', 'completed',3000000);

SELECT c.customer_id,c.full_name,SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;

SELECT c.customer_id,c.full_name,MAX(o.total_amount) AS max_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name;

SELECT c.customer_id,c.full_name,SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY total_spent DESC;