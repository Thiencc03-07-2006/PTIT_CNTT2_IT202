-- ss13b4
USE social_network;

CREATE TABLE post_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    old_content TEXT,
    new_content TEXT,
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    changed_by_user_id INT,
    CONSTRAINT fk_history_posts 
		FOREIGN KEY (post_id)
        REFERENCES posts (post_id)
        ON DELETE CASCADE
);

DELIMITER //

CREATE TRIGGER trigger_posts_before_update
BEFORE UPDATE ON posts
FOR EACH ROW
BEGIN
    IF OLD.content <> NEW.content THEN
        INSERT INTO post_history (
            post_id,
            old_content,
            new_content,
            changed_at,
            changed_by_user_id
        ) VALUES
        (OLD.post_id,OLD.content,NEW.content,NOW(),OLD.user_id);
    END IF;
END //

UPDATE posts
SET content = 'Noi dung bai viet da duoc chinh sua lan 1'
WHERE post_id = 1;

UPDATE posts
SET content = 'Cap nhat lan 2 cho bai viet'
WHERE post_id = 1;

SELECT * FROM post_history;

INSERT INTO likes (user_id, post_id) VALUES (2, 1);
SELECT * FROM posts;