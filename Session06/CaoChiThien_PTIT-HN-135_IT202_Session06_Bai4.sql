CREATE DATABASE session06Bai4;
USE session06Bai4;

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

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0)
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity > 0),
    PRIMARY KEY (order_id , product_id),
    FOREIGN KEY (order_id)
        REFERENCES orders (order_id),
    FOREIGN KEY (product_id)
        REFERENCES products (product_id)
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

INSERT INTO products (product_id, product_name, price) VALUES
(1, 'Laptop Dell', 20000000),
(2, 'Chuột Logitech', 500000),
(3, 'Bàn phím cơ', 1500000),
(4, 'Màn hình LG', 5000000),
(5, 'Tai nghe Sony', 3000000);

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(101, 1, 1),
(101, 2, 2),
(102, 3, 1),
(103, 4, 2),
(105, 5, 2);

SELECT p.product_id,p.product_name,SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name;

SELECT p.product_id,p.product_name,SUM(oi.quantity * p.price) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name;

SELECT p.product_id,p.product_name,SUM(oi.quantity * p.price) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity * p.price) > 5000000;