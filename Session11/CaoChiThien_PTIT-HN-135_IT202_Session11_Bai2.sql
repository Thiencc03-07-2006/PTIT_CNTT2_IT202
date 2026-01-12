-- ss11b2
USE social_network_pro;

DELIMITER //

CREATE PROCEDURE CalculatePostLikes(
    IN p_post_id INT,
    OUT total_likes INT
)
BEGIN
    SELECT COUNT(*) 
    INTO total_likes
    FROM likes
    WHERE post_id = p_post_id;
END //

SET @total_likes = 0;

CALL CalculatePostLikes(103, @total_likes);

SELECT @total_likes AS total_likes;

DROP PROCEDURE IF EXISTS CalculatePostLikes;