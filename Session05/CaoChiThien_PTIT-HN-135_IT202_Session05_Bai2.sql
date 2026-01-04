CREATE DATABASE session5bai02;
USE session5bai02;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    full_name VARCHAR(255),
    email VARCHAR(255),
    city VARCHAR(255),
    status ENUM('active', 'inactive')
);
INSERT INTO customers (customer_id, full_name, email, city, status) VALUES
(1, 'Nguyễn Văn An', 'an.nguyen@gmail.com', 'Hà Nội', 'active'),
(2, 'Trần Thị Bình', 'binh.tran@gmail.com', 'TP.HCM', 'active'),
(3, 'Lê Minh Châu', 'chau.le@gmail.com', 'Đà Nẵng', 'inactive'),
(4, 'Phạm Quốc Dũng', 'dung.pham@gmail.com', 'Cần Thơ', 'active'),
(5, 'Hoàng Thị Lan', 'lan.hoang@gmail.com', 'Hà Nội', 'inactive');
SELECT * FROM customers;
SELECT * FROM customers WHERE city = 'TP.HCM';
SELECT * FROM customers WHERE city = 'Hà Nội' AND status = 'active';
SELECT * FROM customers ORDER BY full_name;