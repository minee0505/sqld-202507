
select
    USERNAME,
    REGISTRATION_DATE
    from USERS
order by REGISTRATION_DATE desc
;

-- creation_date를 기준으로 내림차순 정렬합니다.
SELECT
    post_id,
    user_id,
    content,
    creation_date
FROM
    POSTS
ORDER BY creation_date DESC
;

-- 1차: post_type 오름차순, 2차: creation_date 내림차순으로 정렬
SELECT
    post_id,
    post_type,
    creation_date
FROM
    POSTS
ORDER BY
    post_type,      -- 1차 정렬 기준 (ASC는 생략 가능)
    creation_date DESC  -- 2차 정렬 기준
;

-- 별칭으로도 정렬가능
select
    USERNAME as UNAME,
    REGISTRATION_DATE
from USERS
order by UNAME desc
;

-- 순번으로도 정렬가능, 실무에서는 사용X
select
    USERNAME as UNAME, -- 1번
    REGISTRATION_DATE  -- 2번
from USERS
order by 1 asc
;

select
    USERNAME as UNAME, -- 1번
    REGISTRATION_DATE  -- 2번
from USERS
order by UNAME desc, 2 asc
;

-- 5강에서 배운 GROUP BY를 활용해 사용자별 게시물 수를 구하고,
-- 그 결과(별명: post_count)를 기준으로 내림차순 정렬합니다.
SELECT
    user_id,
    COUNT(*) AS post_count
FROM
    POSTS
GROUP BY
    user_id
-- ORDER BY COUNT(*) DESC
ORDER BY post_count DESC, USER_ID
;

-- user_id가 1이면 1순위, 나머지는 2순위로 정렬 우선순위를 부여하고,
-- 같은 순위 내에서는 creation_date를 기준으로 내림차순 정렬합니다.
SELECT
    post_id,
    user_id,
    content,
    creation_date,
        CASE
    WHEN user_id = 21 THEN 999 -- user_id가 1이면 1순위
        ELSE 100                   -- 나머지는 2순위
        END
FROM
    POSTS
ORDER BY
    CASE
        WHEN user_id = 21 THEN 999 -- user_id가 1이면 1순위
        ELSE 100                   -- 나머지는 2순위
        END,
    CREATION_DATE desc
;



