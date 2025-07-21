SELECT *
FROM HASHTAGS
;

SELECT CONTENT, creation_date
FROM POSTS
;

SELECT user_id
FROM LIKES
;

SELECT 
    full_name as "전체 이름", 
    bio as "자기소개"
FROM USER_PROFILES
;

SELECT user_id || '님이' || comment_text ||'라고 댓글을 남겼습니다.' AS "댓글 알림"
FROM COMMENTS
;