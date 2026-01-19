-- Xóa CSDL nếu đã tồn tại để tránh lỗi khi chạy lại
DROP DATABASE IF EXISTS quanlybanhang;

-- Tạo cơ sở dữ liệu mới
CREATE DATABASE quanlybanhang;

-- Sử dụng CSDL vừa tạo
USE quanlybanhang;

CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY, 
    -- Khóa chính, tự tăng, định danh duy nhất mỗi khách hàng

    customer_name VARCHAR(100) NOT NULL,
    -- Tên khách hàng, bắt buộc nhập

    phone VARCHAR(20) NOT NULL UNIQUE,
    -- Số điện thoại, không được trùng

    address VARCHAR(255)
    -- Địa chỉ, cho phép NULL
);

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    -- Mã sản phẩm, khóa chính

    product_name VARCHAR(100) NOT NULL UNIQUE,
    -- Tên sản phẩm, không được trùng

    price DECIMAL(10,2) NOT NULL,
    -- Giá sản phẩm, 2 chữ số thập phân

    quantity INT NOT NULL CHECK (quantity >= 0),
    -- Số lượng tồn kho, không được âm

    category VARCHAR(50) NOT NULL
    -- Loại sản phẩm
);

CREATE TABLE Employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    -- Mã nhân viên

    employee_name VARCHAR(100) NOT NULL,
    -- Tên nhân viên

    birthday DATE,
    -- Ngày sinh (sẽ bị xóa ở câu sau)

    position VARCHAR(50) NOT NULL,
    -- Chức vụ

    salary DECIMAL(10,2) NOT NULL,
    -- Lương nhân viên

    revenue DECIMAL(10,2) DEFAULT 0
    -- Doanh thu nhân viên quản lý, mặc định = 0
);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    -- Mã đơn hàng

    customer_id INT,
    -- Mã khách hàng đặt đơn

    employee_id INT,
    -- Nhân viên phụ trách đơn

    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    -- Ngày đặt hàng, mặc định thời điểm hiện tại

    total_amount DECIMAL(10,2) DEFAULT 0,
    -- Tổng tiền đơn hàng

    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    -- Ràng buộc khóa ngoại tới Customers

    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
    -- Ràng buộc khóa ngoại tới Employees
);

CREATE TABLE OrderDetails (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    -- Mã chi tiết đơn hàng

    order_id INT,
    -- Đơn hàng liên quan

    product_id INT,
    -- Sản phẩm trong đơn

    quantity INT NOT NULL CHECK (quantity > 0),
    -- Số lượng mua, phải lớn hơn 0

    unit_price DECIMAL(10,2) NOT NULL,
    -- Giá tại thời điểm mua

    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    -- Khóa ngoại tới Orders

    FOREIGN KEY (product_id) REFERENCES Products(product_id)
    -- Khóa ngoại tới Products
);

-- Câu 3
ALTER TABLE Customers
ADD email VARCHAR(100) NOT NULL UNIQUE;
-- Thêm email, không null và không trùng

ALTER TABLE Employees
DROP COLUMN birthday;
-- Xóa cột ngày sinh

-- Câu 4 là các file Data

-- Câu 5
SELECT customer_id, customer_name, email, phone, address
FROM Customers;
-- Lấy thông tin cơ bản của khách hàng

UPDATE Products
SET product_name = 'Laptop Dell XPS',
    price = 99.99
WHERE product_id = 1;
-- Cập nhật tên và giá sản phẩm có id = 1

SELECT o.order_id,
       c.customer_name,
       e.employee_name,
       o.total_amount,
       o.order_date
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Employees e ON o.employee_id = e.employee_id;
-- Lấy thông tin những đơn đặt hàng

-- Câu 6
SELECT c.customer_id,
       c.customer_name,
       COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;
-- Đếm số lượng đơn hàng của mỗi khách hàng

SELECT e.employee_id,
       e.employee_name,
       SUM(o.total_amount) AS revenue
FROM Employees e
JOIN Orders o ON e.employee_id = o.employee_id
WHERE YEAR(o.order_date) = YEAR(CURDATE())
GROUP BY e.employee_id;
-- Thống kê doanh thu theo năm hiện tại

SELECT p.product_id,
       p.product_name,
       SUM(od.quantity) AS total_quantity
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
JOIN Orders o ON od.order_id = o.order_id
WHERE MONTH(o.order_date) = MONTH(CURDATE())
  AND YEAR(o.order_date) = YEAR(CURDATE())
GROUP BY p.product_id
HAVING total_quantity > 100
ORDER BY total_quantity DESC;
-- Thống kê những sản phẩm có số lượng đặt hàng lớn hơn 100 trong tháng hiện tại

-- Câu 7
SELECT c.customer_id,
       c.customer_name
FROM Customers c
LEFT JOIN Orders o 
       ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
-- LEFT JOIN để lấy tất cả khách hàng
-- order_id IS NULL => khách chưa có đơn hàng nào

SELECT product_id,
       product_name,
       price
FROM Products
WHERE price > (
    SELECT AVG(price)
    FROM Products
);
-- Subquery tính giá trung bình của tất cả sản phẩm
-- Lấy các sản phẩm có giá cao hơn mức trung bình

SELECT c.customer_id,
       c.customer_name,
       SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o 
     ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING total_spent = (
    SELECT MAX(total)
    FROM (
        SELECT SUM(total_amount) AS total
        FROM Orders
        GROUP BY customer_id
    ) t
);
-- Tính tổng chi tiêu theo từng khách hàng
-- Lấy mức chi tiêu lớn nhất
-- Nếu nhiều khách cùng mức cao nhất => lấy hết

-- Câu 8
CREATE VIEW view_order_list AS
SELECT o.order_id,
       c.customer_name,
       e.employee_name,
       o.total_amount,
       o.order_date
FROM Orders o
JOIN Customers c 
     ON o.customer_id = c.customer_id
JOIN Employees e 
     ON o.employee_id = e.employee_id
ORDER BY o.order_date DESC;
-- View lưu câu SELECT
-- Hiển thị thông tin tổng hợp đơn hàng
-- Sắp xếp theo ngày đặt mới nhất

CREATE VIEW view_order_detail_product AS
SELECT od.order_detail_id,
       p.product_name,
       od.quantity,
       od.unit_price
FROM OrderDetails od
JOIN Products p 
     ON od.product_id = p.product_id
ORDER BY od.quantity DESC;
-- View hiển thị chi tiết sản phẩm trong đơn hàng
-- Sắp xếp theo số lượng giảm dần

-- Câu 9
DELIMITER //

CREATE PROCEDURE proc_insert_employee(
    IN p_employee_name VARCHAR(100),
    IN p_position VARCHAR(50),
    IN p_salary DECIMAL(10,2),
    OUT p_employee_id INT
)
BEGIN
    -- Thêm mới nhân viên (không truyền employee_id, revenue)
    INSERT INTO Employees(employee_name, position, salary)
    VALUES (p_employee_name, p_position, p_salary);

    -- Lấy mã nhân viên vừa thêm
    SET p_employee_id = LAST_INSERT_ID();
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE proc_get_orderdetails(
    IN p_order_id INT
)
BEGIN
    SELECT od.order_detail_id,
           p.product_name,
           od.quantity,
           od.unit_price
    FROM OrderDetails od
    JOIN Products p 
         ON od.product_id = p.product_id
    WHERE od.order_id = p_order_id;
    -- Lọc chi tiết đơn hàng theo order_id truyền vào
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE proc_cal_total_amount_by_order(
    IN p_order_id INT,
    OUT p_total_product INT
)
BEGIN
    SELECT COUNT(DISTINCT product_id)
    INTO p_total_product
    FROM OrderDetails
    WHERE order_id = p_order_id;
    -- COUNT DISTINCT để đếm số loại sản phẩm
END //

DELIMITER ;

-- Câu 10
DELIMITER //

CREATE TRIGGER trigger_after_insert_order_details
-- Ở đây em thấy dùng before để ngăn cập nhật bảng chứ không nên sài after
BEFORE INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    DECLARE current_quantity INT;

    -- Lấy số lượng tồn kho hiện tại
    SELECT quantity INTO current_quantity
    FROM Products
    WHERE product_id = NEW.product_id;

    -- Nếu tồn kho không đủ thì báo lỗi
    IF current_quantity < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số lượng sản phẩm trong kho không đủ';
    ELSE
        -- Trừ số lượng tồn kho
        UPDATE Products
        SET quantity = quantity - NEW.quantity
        WHERE product_id = NEW.product_id;
    END IF;
END //

DELIMITER ;

-- Câu 11
DELIMITER //

CREATE PROCEDURE proc_insert_order_details(
    IN p_order_id INT,
    IN p_product_id INT,
    IN p_quantity INT,
    IN p_price DECIMAL(10,2)
)
BEGIN
    DECLARE order_count INT;

    START TRANSACTION;
    -- Bắt đầu giao dịch

    -- Kiểm tra đơn hàng có tồn tại hay không
    SELECT COUNT(*) INTO order_count
    FROM Orders
    WHERE order_id = p_order_id;

    IF order_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'không tồn tại mã hóa đơn';
    END IF;

    -- Thêm chi tiết đơn hàng
    INSERT INTO OrderDetails(order_id, product_id, quantity, unit_price)
    VALUES (p_order_id, p_product_id, p_quantity, p_price);

    -- Cập nhật tổng tiền đơn hàng
    UPDATE Orders
    SET total_amount = total_amount + (p_quantity * p_price)
    WHERE order_id = p_order_id;

    COMMIT;
    -- Xác nhận giao dịch
END //

DELIMITER ;
