-- ss11b1
USE social_network_pro;

DELIMITER //
CREATE PROCEDURE userPost(IN user_id_in INT)
BEGIN
	SELECT post_id, content, created_at
	FROM posts
	WHERE user_id = user_id_in;
END //

CALL userPost(3);

DROP PROCEDURE IF EXISTS userPost;