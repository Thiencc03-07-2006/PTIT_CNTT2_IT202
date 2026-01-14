-- ss13b3
USE social_network;

DELIMITER //

CREATE TRIGGER trigger_likes_before_insert
BEFORE INSERT ON likes
FOR EACH ROW
BEGIN
    DECLARE post_owner INT;

SELECT 
    user_id
INTO post_owner FROM
    posts
WHERE
    post_id = NEW.post_id;

    IF post_owner = NEW.user_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Khong duoc like bai viet cua chinh minh';
    END IF;
END //

-- ?Bai2 C & D
DELIMITER //

CREATE TRIGGER trigger_update_CLike
AFTER UPDATE ON likes
FOR EACH ROW
BEGIN
    IF OLD.post_id <> NEW.post_id THEN
        UPDATE posts
        SET like_count = like_count - 1
        WHERE post_id = OLD.post_id;

        UPDATE posts
        SET like_count = like_count + 1
        WHERE post_id = NEW.post_id;
    END IF;
END //

INSERT INTO likes (user_id, post_id) VALUES (1, 1);

INSERT INTO likes (user_id, post_id) VALUES (2, 1);

SELECT * FROM posts;

UPDATE likes SET post_id = 4 WHERE like_id = 2;

SELECT * FROM posts;
