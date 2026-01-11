-- ss10b5
USE social_network_pro;

CREATE INDEX idx_hometown
ON users (hometown);
 
DROP INDEX idx_hometown ON users;

SELECT u.username, p.post_id, p.content
FROM users u
JOIN posts p ON u.user_id = p.user_id
WHERE u.hometown = 'Hà Nội'
ORDER BY u.username DESC
LIMIT 10;

EXPLAIN ANALYZE
SELECT u.username, p.post_id, p.content
FROM users u
JOIN posts p ON u.user_id = p.user_id
WHERE u.hometown = 'Hà Nội'
ORDER BY u.username DESC
LIMIT 10;

/*
trước khi dùng index
-> Limit: 10 row(s)  (cost=7.62 rows=1.18) (actual time=0.0565..0.0761 rows=10 loops=1)
    -> Nested loop inner join  (cost=7.62 rows=1.18) (actual time=0.0557..0.0745 rows=10 loops=1)
        -> Filter: (u.hometown = ''Hà Nội'')  (cost=0.1 rows=0.1) (actual time=0.0343..0.0343 rows=1 loops=1)
            -> Index scan on u using username (reverse)  (cost=0.1 rows=1) (actual time=0.0308..0.0308 rows=1 loops=1)
        -> Index lookup on p using posts_fk_users (user_id=u.user_id)  (cost=3.43 rows=11.8) (actual time=0.0204..0.0389 rows=10 loops=1)
*/

/*
sau khi dùng index
-> Limit: 10 row(s)  (cost=34.6 rows=10) (actual time=0.175..0.212 rows=10 loops=1)
    -> Nested loop inner join  (cost=34.6 rows=94.7) (actual time=0.173..0.209 rows=10 loops=1)
        -> Sort: u.username DESC  (cost=1.43 rows=8) (actual time=0.146..0.146 rows=1 loops=1)
            -> Index lookup on u using idx_hometown (hometown=''Hà Nội'')  (cost=1.43 rows=8) (actual time=0.0571..0.0826 rows=8 loops=1)
        -> Index lookup on p using posts_fk_users (user_id=u.user_id)  (cost=3.11 rows=11.8) (actual time=0.0254..0.06 rows=10 loops=1)
*/
