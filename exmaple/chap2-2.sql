
-- 라이언이 작성한 모든 게시물을 조회
select *
from POSTS
where USER_ID = (
select USER_ID
from USERS
where USERNAME = 'ryan'
);

select USER_ID
from USERS
where USERNAME = 'ryan';

-- 우리 피드 데이터에서 평균 조회수보다 높은 조회수를 가진 게시물 조회
-- 평균 조회수를 구해봄
select avg(VIEW_COUNT)
from POSTS
;

select *
from POSTS
where VIEW_COUNT > (
    select avg(VIEW_COUNT)
    from POSTS
);

-- 카카오그룹에 있는 사용자의 모든 아이디를 조회
SELECT user_id
FROM USERS
WHERE manager_id = 1
;

-- 카카오그룹에 있는 사용자들이 작성한 모든 피드 조회
select *
from POSTS
where USER_ID in (
    SELECT user_id
    FROM USERS
    WHERE manager_id = 1
    )
;

-- ANY는 서브쿼리의 결과 중 하나라도 만족하는 경우를 찾음
select *
from POSTS
where VIEW_COUNT > Any (
    select avg(VIEW_COUNT)
    from POSTS
    group by USER_ID
);

select *
from POSTS
where VIEW_COUNT > ALL (
    select avg(VIEW_COUNT)
    from POSTS
    group by USER_ID
);

-- =, <>, <, >, <=, >= 단일 행 연산자는 단일 행 서브쿼리에만 가능
-- IN, ANY, ALL 다중 행 연산자는 다중행 서브쿼리에만 가능

select *
from POSTS
;

select TAG_ID from HASHTAGS
where TAG_NAME = '#포켓몬';

select POST_ID from POST_TAGS
where TAG_ID = 1003;

select p.*, u.USERNAME
from POSTS p
LEFT JOIN USERS u
on p.USER_ID = u.USER_ID
where POST_ID in (
    select POST_ID from POST_TAGS
    where TAG_ID = (
        select TAG_ID from HASHTAGS
        where TAG_NAME = '#포켓몬'
        )
    )
;

-- 피카츄가 올린 피드에 좋아요 찍은 사람들의 이름을 조회
select * from LIKES;

-- 피카츄가 올린 피드의 post_id를 찾음
select POST_ID
from POSTS
where USER_ID = 21;

-- 피카츄 유저 아이디 찾기
select USER_ID
from USERS
where USERNAME = 'pikachu';

-- 피카츄가 올린 피드에 좋아요 찍은 내용들을 필터링
select username
from LIKES L
join users u
on L.USER_ID = u.USER_ID
where POST_ID in (
    select POST_ID
    from POSTS
    where USER_ID = (
        select USER_ID
        from USERS
        where USERNAME = 'pikachu'
        )
    )
;

-- 인라인 뷰 서브쿼리 (FROM 절에 서브쿼리 사용)
-- 사용자별 피드 작성 개수
select
    u.USER_ID,
    u.USERNAME,
    pc.post_count
From (
    select USER_ID, count(*) as post_count
    from POSTS
    group by USER_ID
     ) PC
join users u
on pc.USER_ID = u.USER_ID
;

select u.USER_ID,
       u.USERNAME,
       pc.post_count
From users u
         join (select USER_ID, count(*) as post_count
               from POSTS
               group by USER_ID) PC
              on pc.USER_ID = u.USER_ID
;
select USER_ID, count(*) as total_likes
from LIKES
group by USER_ID
order by USER_ID
;

SELECT p.user_id, COUNT(*) AS total_likes
FROM LIKES l
         INNER JOIN POSTS p ON l.post_id = p.post_id -- LIKES와 POSTS를 먼저 조인
GROUP BY p.user_id;

select
    A.USER_ID,
    u.USERNAME,
    A.total_likes
from(
        select USER_ID, count(*) as total_likes
        from LIKES
        group by USER_ID
    ) A, users u
where a.USER_ID = u.USER_ID
;


-- 스칼라 서브쿼리 (select 절에 서브쿼리 사용)
-- 유저 정보를 조회(users + 상세 bio(user_profiles) 도 같이 조회
select * from users;
select * from USER_PROFILES;

-- 스칼라 서브쿼리 == 연관 서브쿼리
-- 연관 서브쿼리: 서브쿼리가 한 번 실행되고 끝나는게 아니라
-- 바깥쪽 메인쿼리 한 행을 실행할 때마다 반복실행
select
    u.USER_ID,
    u.USERNAME,
    (select BIO FROM USER_PROFILES up where u.USER_ID = up.USER_ID) as bio
from users u
;

select * from users;

-- 피드별로 피드의 ID와 피드의 내용과 좋아요 수를 한 번에 조회하고 싶다.
select POST_ID, CONTENT from POSTS;

select post_id, count(*) from LIKES
group by POST_ID
order by POST_ID
;

select
    POST_ID, count(*) as REPLY_COUNT
from COMMENTS
group by POST_ID
order by POST_ID
;

select
    p.POST_ID,
    p.CONTENT,
    NVL(Lc.Like_count, 0) as Like_count,
    NVL(rc.REPLY_COUNT, 0) as REPLY_COUNT
from posts p
left join (select post_id, count(*) as Like_count
      from LIKES
      group by POST_ID
      )LC
on p.POST_ID = LC.post_id
left join (
    select
        POST_ID, count(*) as REPLY_COUNT
    from COMMENTS
    group by POST_ID
) RC
on rc.POST_ID = p.POST_ID
order by p.POST_ID
;

SELECT
    p.post_id,
    p.content,
    (SELECT COUNT(*) FROM LIKES l WHERE l.post_id = p.post_id) AS "좋아요 수",
    (SELECT COUNT(*) FROM COMMENTS c WHERE c.post_id = p.post_id) AS "댓글 수"
FROM
    POSTS p
;

-- 게시물을 한 번이라도 작성한 적이 있는 모든 사용자의 이름을 알려주세요
select distinct p.USER_ID, u.username
from POSTS p
join users u
on P.USER_ID = u.USER_ID
order by USER_ID
;

SELECT
    u.username, u.USER_ID
FROM
    USERS u
WHERE
    EXISTS (SELECT 1
            FROM POSTS p
            WHERE p.user_id = u.user_id);

select
    u.username, u.USER_ID
from
    users u
order by u.USER_ID
;

select p.user_id, p.post_id
from POSTS p
order by p.USER_ID
;

SELECT
    u.username, u.USER_ID
FROM
    USERS u
WHERE
     NOT EXISTS (SELECT 1
            FROM POSTS p
            WHERE p.user_id = u.user_id)
order by u.USER_ID;

select 1 from users;