-- ss11b5
USE social_network_pro;

DELIMITER //

CREATE PROCEDURE CalculateUserActivityScore(
    IN p_user_id INT,
    OUT activity_score INT,
    OUT activity_level VARCHAR(50)
)
BEGIN
    DECLARE post_count INT DEFAULT 0;
    DECLARE comment_count INT DEFAULT 0;
    DECLARE like_count INT DEFAULT 0;

    SELECT COUNT(*) 
    INTO post_count
    FROM posts
    WHERE user_id = p_user_id;

    SELECT COUNT(*) 
    INTO comment_count
    FROM comments
    WHERE user_id = p_user_id;

    SELECT COUNT(*)
    INTO like_count
    FROM likes l
    JOIN posts p ON l.post_id = p.post_id
    WHERE p.user_id = p_user_id;

    SET activity_score = post_count * 10 + comment_count * 5 + like_count * 3;

    SET activity_level = CASE
        WHEN activity_score > 500 THEN 'Rất tích cực'
        WHEN activity_score BETWEEN 200 AND 500 THEN 'Tích cực'
        ELSE 'Bình thường'
    END;
END //

CALL CalculateUserActivityScore(3, @score, @level);

SELECT @score AS score, @level AS evel;
    
DROP PROCEDURE IF EXISTS CalculateUserActivityScore;