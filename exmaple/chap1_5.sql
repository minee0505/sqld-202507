-- 1. POSTS 테이블에 숫자 타입의 view_count 컬럼을 추가합니다.
ALTER TABLE POSTS ADD (view_count NUMBER);

-- 2. 모든 게시물에 100 ~ 50000 사이의 임의의 조회수 데이터를 넣어줍니다.
UPDATE POSTS
SET view_count = TRUNC(DBMS_RANDOM.VALUE(100, 50000));

-- 3. 변경사항을 최종 저장합니다.
COMMIT;

select count(*) from users;

select USERNAME from users;

-- 모든 집계함수는 NULL 값을 무시한다.
select count(MANAGER_ID) from users;

-- POSTS 테이블에서 view_count의 최솟값과 최댓값을 찾습니다.
SELECT
    MIN(view_count) AS "최저 조회수",
    MAX(view_count) AS "최고 조회수"
FROM
    POSTS;

-- 모든 게시물의 view_count를 합산합니다.
SELECT SUM(view_count) AS "총 조회수"
FROM POSTS;

SELECT view_count AS "총 조회수"
FROM POSTS;

update POSTS
set view_count = null
where POST_ID = 2;

select sum(view_count) from POSTS
where POST_ID between 1 and 3;

SELECT
    round(AVG(VIEW_COUNT)) AS "평균 조회수",
    SUM(VIEW_COUNT) AS "총 조회수",
    COUNT(VIEW_COUNT) AS "게시물 수"
FROM POSTS
WHERE post_id BETWEEN 1 AND 3
;

select count(*) as "총 댓글수" from COMMENTS;

-- 유저별로 피드를 몇 개씩 썼는지 알고 싶다.
select
    USER_ID,
    count(*) as "유저별 피드 수"
from POSTS
group by USER_ID -- 유저 아이디가 같은 게시물끼리 묶는다.
order by USER_ID
;



select
    USER_ID,
    POST_TYPE,
    count(*) as "유저의 종류별 피드 수"
from POSTS
group by USER_ID, POST_TYPE -- 유저 아이디와 포스트타입이 같은 게시물끼리 묶는다.
order by USER_ID
;

SELECT
    user_id,
    COUNT(*) AS post_count
FROM
    POSTS
GROUP BY
    user_id
having
    COUNT(*) >= 10; -- 게시물을 10개 이상 쓴 사용자만 조회

-- posts 테이블에서 장문(20글자 이상)의 피드를 쓴 게시물들의 개수를 보고 싶다.
-- 유저별로 보고 싶음
select
    USER_ID,
    count(*) as "장문 게시물 수"
from
    POSTS
where length(CONTENT) >= 30
group by USER_ID
having count(*) >= 5
;

SELECT
    post_id,
    COUNT(*) AS like_count
FROM
    LIKES
WHERE  creation_date >= TO_DATE('2024-01-01', 'YYYY-MM-DD') -- 1. 개별 '좋아요' 데이터를 먼저 필터링
GROUP BY
    post_id -- 2. 게시물 ID 별로 그룹화
HAVING  COUNT(*) >= 20; -- 3. 그룹별 '좋아요' 수가 20개 이상인 그룹만 필터링

select
   POST_TYPE, count(*)
from POSTS
group by POST_TYPE;

select
    POST_ID,
    count(*)
from COMMENTS
group by POST_ID
;

select
    FOLLOWING_ID,
    count(*)
from FOLLOWS
group by FOLLOWING_ID;

select
    POST_ID,
    count(*) as "댓글 수"
from COMMENTS
group by POST_ID
having count(*) >= 5;

select
    USER_ID,
    count(*) as "총 게시물 수"
from POSTS
where USER_ID between 1 and 8
group by USER_ID;