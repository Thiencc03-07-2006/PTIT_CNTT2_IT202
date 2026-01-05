CREATE DATABASE session06Bai3;
USE session06Bai3;

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
(105, 3, '2025-01-10', 'completed',30000000);

SELECT order_date,SUM(total_amount) AS daily_revenue
FROM orders
WHERE status = 'completed'
GROUP BY order_date;

SELECT order_date,COUNT(order_id) AS total_orders
FROM orders
WHERE status = 'completed'
GROUP BY order_date;

SELECT order_date,SUM(total_amount) AS daily_revenue,COUNT(order_id) AS total_orders
FROM orders
WHERE status = 'completed'
GROUP BY order_date
HAVING SUM(total_amount) > 10000000;