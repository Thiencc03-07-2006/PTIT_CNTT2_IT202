-- ss10b4
-- 1
USE social_network_pro;

SELECT post_id, content, created_at
FROM posts
WHERE user_id = 1
AND created_at BETWEEN '2026-01-01' AND '2026-12-31';

-- 2
EXPLAIN ANALYZE
SELECT post_id, content, created_at
FROM posts
WHERE user_id = 1
AND created_at BETWEEN '2026-01-01' AND '2026-12-31';

CREATE INDEX idx_created_at_user_id
ON posts (created_at, user_id);

/*
Tiêu chí       | Trước index | Sau index
Kiểu truy vấn  | Table Scan  | Index Scan
Số bản ghi đọc | Nhiều       | Ít
Hiệu năng      | Thấp        | Cao
*/

-- 3
SELECT user_id, username, email
FROM users
WHERE email = 'an@gmail.com';

EXPLAIN ANALYZE
SELECT user_id, username, email
FROM users
WHERE email = 'an@gmail.com';

CREATE UNIQUE INDEX idx_email
ON users (email);

/*
Tiêu chí   | Trước index | Sau index
Kiểu quét  | Table Scan  | Index Lookup
Số bản ghi | Nhiều       | 1
Hiệu năng  | Thấp        | Rất cao
*/

-- 4

DROP INDEX idx_created_at_user_id ON posts;

DROP INDEX idx_email ON users;