-- ss10b3
USE social_network_pro;

SELECT *
FROM users
WHERE hometown = 'Hà Nội';

/*
-> Filter: (users.hometown = 'Hà Nội')  (cost=2.75 rows=2.5) (actual time=0.0607..0.121 rows=8 loops=1)
     -> Table scan on users  (cost=2.75 rows=25) (actual time=0.0546..0.105 rows=25 loops=1)
*/

EXPLAIN ANALYZE
SELECT *
FROM users
WHERE hometown = 'Hà Nội';

-- -> Index lookup on users using idx_hometown (hometown='Hà Nội')  (cost=1.43 rows=8) (actual time=0.0428..0.0547 rows=8 loops=1)

CREATE INDEX idx_hometown
ON users (hometown);

-- Khi không có index thì phải đọc toàn bộ bản gi và có thời gian thực thi cao hơn với hiệu năng truy vấn thấp hơn
DROP INDEX idx_hometown ON users;