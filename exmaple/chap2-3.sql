-- 계층형 쿼리
select user_id, USERNAME, MANAGER_ID
from USERS
;


SELECT
    LEVEL,
    LPAD(' ', (LEVEL-1) * 4) || username AS "사용자 (조직도)", -- LEVEL에 따라 들여쓰기
    user_id,
    manager_id
FROM
    USERS
START WITH
--     manager_id IS NULL -- 1. 시작점: 매니저가 없는 최상위 관리자 ('오박사')
    USER_ID = 11
CONNECT BY
     user_id = PRIOR manager_id
; -- 2. 연결 규칙: 나의 user_id가 다른 사람의 manager_id와 같다면, 그 사람은 나의 부하직원이다.

-- 표에 같은 값이 여러개면 부모, 값이 하나면 자식
-- prior가 자식쪽에 붙으면 순방향 전개
-- prior가 부모쪽에 붙으면 역방향 전개


select USER_ID, MANAGER_ID
from USERS
order by USER_ID
;

select * from COMMENTS;

select
    COMMENT_ID,
    COMMENT_TEXT,
    PARENT_COMMENT_ID
from COMMENTS;

SELECT
    LPAD('└> ', (LEVEL-1) * 4) || comment_text AS "댓글 내용",
    LEVEL,
    comment_id,
    parent_comment_id
FROM
    COMMENTS
START WITH
     parent_comment_id IS NULL
CONNECT BY
    PRIOR comment_id = parent_comment_id
;

