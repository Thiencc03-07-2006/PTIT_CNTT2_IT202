CREATE DATABASE session03Bai1;
USE session03Bai1;
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    price DECIMAL(10 , 2 ),
    stock INT,
    status ENUM('active', 'inactive')
);
INSERT INTO productS (product_id, product_name, price, stock, status) VALUES
(1, 'Laptop Dell Inspiron 15', 18500000, 10, 'active'),
(2, 'Chuột không dây Logitech', 450000, 50, 'active'),
(3, 'Bàn phím cơ Keychron K6', 1950000, 20, 'active'),
(4, 'Màn hình Samsung 24 inch', 3200000, 8, 'inactive'),
(5, 'Tai nghe Sony WH-1000XM5', 7990000, 5, 'active');
SELECT * FROM products;
SELECT * FROM products WHERE status = 'active';
SELECT * FROM products WHERE price > 1000000;
SELECT * FROM products WHERE status = 'active' ORDER BY price;