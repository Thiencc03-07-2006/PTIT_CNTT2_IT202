-- ss11b4
USE social_network_pro;

DELIMITER //

CREATE PROCEDURE CreatePostWithValidation(
    IN p_user_id INT,
    IN p_content TEXT,
    OUT result_message VARCHAR(255)
)
BEGIN
    IF CHAR_LENGTH(p_content) < 5 THEN
        SET result_message = 'Nội dung quá ngắn';
    ELSE
        INSERT INTO posts(user_id, content, created_at)
        VALUES (p_user_id, p_content, NOW());
        SET result_message = 'Thêm bài viết thành công';
    END IF;
END //

CALL CreatePostWithValidation(1, 'Hi Thien', @msg);

SELECT @msg AS result_message;

SELECT * 
FROM posts
WHERE user_id = 1
ORDER BY created_at DESC;

DROP PROCEDURE IF EXISTS CreatePostWithValidation;