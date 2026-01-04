CREATE DATABASE session5bai06;
USE session5bai06;
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    price DECIMAL(10 , 2 ),
    stock INT,
    status ENUM('active', 'inactive'),
    sold_quantity INT
);
INSERT INTO products (product_id, product_name, price, stock, status, sold_quantity) VALUES
(1,'Laptop Dell Inspiron 15',18500000, 10,'active', 120),
(2,'Laptop HP Pavilion',17200000,8,'active', 95),
(3,'Chuột Logitech M331',450000,50,'active', 300),
(4,'Bàn phím cơ Keychron K6',1950000,20, 'active', 180),
(5,'Màn hình Samsung 24"',3200000,12,'active',110),
(6,'Tai nghe Sony WH-1000XM5',7990000,5,'active',90),
(7,'USB Sandisk 64GB',280000,100,'active',420),
(8,'Ổ cứng SSD Samsung 1TB',2490000,15,'active',160),
(9,'Webcam Logitech C920',2150000,18,'inactive',75),
(10,'Chuột Gaming Razer',1290000,30,'active',210),
(11,'Loa Bluetooth JBL Flip 6',2890000, 20,'active', 140),
(12,'Sạc dự phòng Anker 20000mAh',1250000, 40,'active', 260),
(13,'Cáp USB-C Anker',250000, 100,'active', 380),
(14,'Balo Laptop Xiaomi',650000, 35,'active', 190),
(15,'Đế tản nhiệt Laptop',450000, 60,'inactive', 155);
SELECT * FROM products
WHERE status = 'active' AND price BETWEEN 1000000 AND 3000000
ORDER BY price LIMIT 10 OFFSET 0;
SELECT * FROM products
WHERE status = 'active' AND price BETWEEN 1000000 AND 3000000
ORDER BY price LIMIT 10 OFFSET 10;