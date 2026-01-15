-- ss14b2CoBan

CREATE DATABASE IF NOT EXISTS shop_db;
USE shop_db;

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50),
    price DECIMAL(10,2),
    stock INT NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    quantity INT NOT NULL,
    total_price DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO products (product_name, price, stock) VALUES
('Laptop Dell', 1500.00, 10),
('iPhone 13', 1200.00, 8),
('Samsung TV', 800.00, 5),
('AirPods Pro', 250.00, 20),
('MacBook Air', 1300.00, 7);

DELIMITER //

CREATE PROCEDURE place_order(
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE v_stock INT;
    DECLARE v_price DECIMAL(10,2);
    DECLARE v_total DECIMAL(10,2);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    SELECT stock, price
    INTO v_stock, v_price
    FROM products
    WHERE product_id = p_product_id
    FOR UPDATE;

    IF v_stock < p_quantity THEN
        ROLLBACK;
    ELSE
        SET v_total = v_price * p_quantity;

        INSERT INTO orders (product_id, quantity, total_price)
        VALUES (p_product_id, p_quantity, v_total);

        UPDATE products
        SET stock = stock - p_quantity
        WHERE product_id = p_product_id;

        COMMIT;
    END IF;

END//

DELIMITER ;

CALL place_order(1, 3);

CALL place_order(1, 100);