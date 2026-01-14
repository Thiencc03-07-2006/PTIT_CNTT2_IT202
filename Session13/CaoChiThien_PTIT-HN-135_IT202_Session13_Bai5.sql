-- ss13b5
USE social_network;

DELIMITER //

CREATE TRIGGER trigger_users_before_insert
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    IF NEW.email NOT LIKE '%@%.%' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email khong hop le';
    END IF;

    IF NEW.username NOT REGEXP '^[A-Za-z0-9_]+$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Username chi duoc chua chu cai, so va dau gach duoi';
    END IF;
END //

DELIMITER //

CREATE PROCEDURE add_user (
    IN p_username VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_created_at DATE
)
BEGIN
    INSERT INTO users (username, email, created_at)
    VALUES (p_username, p_email, p_created_at);
END //

CALL add_user('user_01', 'user01@gmail.com', '2025-01-15');

CALL add_user('user02', 'user02gmail.com', '2025-01-15');

CALL add_user('user@03', 'user03@gmail.com', '2025-01-15');

SELECT * FROM users;