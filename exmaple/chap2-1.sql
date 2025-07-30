
-- 합집합
select USER_ID as "Likes user id"from LIKES
union all
select USER_ID as "Comments user id" from COMMENTS;

select USER_ID from LIKES
union
select USER_ID from COMMENTS
order by 1
;

-- '좋아요'를 누른 사용자의 ID 목록 (중복 제거됨)
SELECT user_id FROM LIKES
INTERSECT
-- '댓글'을 작성한 사용자의 ID 목록 (중복 제거됨)
SELECT user_id FROM COMMENTS;

-- '좋아요'를 누른 사용자의 ID 목록
SELECT user_id FROM LIKES
MINUS
-- '댓글'을 작성한 사용자의 ID 목록
SELECT user_id FROM COMMENTS;