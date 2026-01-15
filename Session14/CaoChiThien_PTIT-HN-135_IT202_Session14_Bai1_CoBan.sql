-- ss14b1CoBan

CREATE DATABASE IF NOT EXISTS banking;
USE banking;

CREATE TABLE accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    account_name VARCHAR(50) NOT NULL,
    balance DECIMAL(10,2) NOT NULL
);

INSERT INTO accounts (account_name, balance) VALUES
('Nguyễn Văn An', 1000.00),
('Trần Thị Bảy', 500.00);

DELIMITER //

CREATE PROCEDURE transfer_money(
    IN from_account INT,
    IN to_account INT,
    IN amount DECIMAL(10,2)
)
BEGIN
    DECLARE from_balance DECIMAL(10,2);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    SELECT balance
    INTO from_balance
    FROM accounts
    WHERE account_id = from_account
    FOR UPDATE;

    IF from_balance >= amount THEN

        UPDATE accounts
        SET balance = balance - amount
        WHERE account_id = from_account;

        UPDATE accounts
        SET balance = balance + amount
        WHERE account_id = to_account;

        COMMIT;
    ELSE
        ROLLBACK;
    END IF;

END//

DELIMITER ;

CALL transfer_money(1, 2, 300.00);

CALL transfer_money(1, 2, 2000.00);