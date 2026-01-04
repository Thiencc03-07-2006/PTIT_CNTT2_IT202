CREATE DATABASE session5bai05;
USE session5bai05;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    total_amount DECIMAL(10 , 2 ),
    order_date DATE,
    status ENUM('pending', 'completed', 'cancelled')
);
INSERT INTO orders (order_id, customer_id, total_amount, order_date, status) VALUES
(1,  1, 1200000, '2025-01-01', 'completed'),
(2,  2,  850000, '2025-01-02', 'pending'),
(3,  3, 3400000, '2025-01-03', 'completed'),
(4,  1,  420000, '2025-01-04', 'cancelled'),
(5,  4, 5600000, '2025-01-05', 'pending'),

(6,  2, 2300000, '2025-01-06', 'completed'),
(7,  5,  990000, '2025-01-07', 'pending'),
(8,  3, 7600000, '2025-01-08', 'completed'),
(9,  6,  680000, '2025-01-09', 'cancelled'),
(10, 1, 4100000, '2025-01-10', 'pending'),

(11, 7, 1500000, '2025-01-11', 'completed'),
(12, 4,  870000, '2025-01-12', 'pending'),
(13, 8, 9800000, '2025-01-13', 'completed'),
(14, 2,  530000, '2025-01-14', 'cancelled'),
(15, 9, 2600000, '2025-01-15', 'pending');
SELECT * FROM orders
WHERE status <> 'cancelled'
ORDER BY order_date DESC
LIMIT 5 OFFSET 0;
SELECT * FROM orders
WHERE status <> 'cancelled'
ORDER BY order_date DESC
LIMIT 5 OFFSET 5;
SELECT * FROM orders
WHERE status <> 'cancelled'
ORDER BY order_date DESC
LIMIT 5 OFFSET 10;