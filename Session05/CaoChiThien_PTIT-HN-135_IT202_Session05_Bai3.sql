CREATE DATABASE session5bai03;
USE session5bai03;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    total_amount DECIMAL(10 , 2 ),
    order_date DATE,
    status ENUM('pending', 'completed', 'cancelled')
);
INSERT INTO orders (order_id, customer_id, total_amount, order_date, status) VALUES
(1, 1, 1500000.00, '2025-01-05', 'completed'),
(2, 2, 750000.00,  '2025-01-10', 'pending'),
(3, 3, 3200000.00, '2025-01-12', 'completed'),
(4, 1, 450000.00,  '2025-01-15', 'cancelled'),
(5, 4, 9870000.00,  '2025-01-18', 'pending');
select * from orders where status='completed';
select * from orders where total_amount > 5000000;
select * from orders order by order_date desc limit 5;
select * from orders order by total_amount desc;