CREATE DATABASE session07Bai2;
USE session07Bai2;

CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10 , 2 ),
    FOREIGN KEY (customer_id)
        REFERENCES customers (id)
);

CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10 , 2 ) NOT NULL
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT CHECK (quantity > 0),
    FOREIGN KEY (order_id)
        REFERENCES orders (id),
    FOREIGN KEY (product_id)
        REFERENCES products (id)
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

INSERT INTO products (id, name, price) VALUES
(1, 'Laptop', 15000000),
(2, 'Smartphone', 8000000),
(3, 'Headphone', 500000),
(4, 'Keyboard', 700000),
(5, 'Mouse', 300000),
(6, 'Monitor', 4000000),
(7, 'Printer', 3500000);

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(101, 1, 2),
(101, 3, 1),
(102, 2, 1),
(103, 1, 1),
(104, 5, 3),
(105, 6, 1),
(106, 2, 2);

SELECT *
FROM products
WHERE id IN (
    SELECT product_id
    FROM order_items
);