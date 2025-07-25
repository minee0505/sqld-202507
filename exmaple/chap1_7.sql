DROP TABLE EMPLOYEES;
DROP TABLE DEPARTMENTS;

-- 1. 부서 테이블 (DEPARTMENTS) 생성
CREATE TABLE DEPARTMENTS
(
    id   NUMBER PRIMARY KEY,
    name VARCHAR2(50) NOT NULL
);

-- 2. 사원 테이블 (EMPLOYEES) 생성
CREATE TABLE EMPLOYEES
(
    id      NUMBER PRIMARY KEY,
    name    VARCHAR2(50) NOT NULL,
    dept_id NUMBER -- DEPARTMENTS 테이블의 id를 참조할 연결고리
);


-- 3. 각 테이블에 예시 데이터 삽입
-- 부서 테이블에는 3개의 부서를 넣어봅시다.
INSERT INTO DEPARTMENTS (id, name)
VALUES (10, '기획팀');
INSERT INTO DEPARTMENTS (id, name)
VALUES (20, '개발팀');
INSERT INTO DEPARTMENTS (id, name)
VALUES (30, '디자인팀');


-- 사원 테이블에는 4명의 사원을 넣어봅시다.
INSERT INTO EMPLOYEES (id, name, dept_id)
VALUES (101, '김철수', 10); -- 기획팀
INSERT INTO EMPLOYEES (id, name, dept_id)
VALUES (102, '박영희', 20); -- 기획팀
INSERT INTO EMPLOYEES (id, name, dept_id)
VALUES (103, '이지은', 20); -- 기획팀
INSERT INTO EMPLOYEES (id, name, dept_id)
VALUES (104, '최민준', 30);
-- 기획팀

-- 단순 테이블 조회
select *
from EMPLOYEES;
select *
from DEPARTMENTS;

-- JOIN은 두 테이블을 가로로 합치는 문법
-- 내부 조인
-- x * y 형태로 결과가 나옵니다.
SELECT EMPLOYEES.id,
       EMPLOYEES.name,
       DEPARTMENTS.name
FROM EMPLOYEES,
     DEPARTMENTS
where EMPLOYEES.dept_id = DEPARTMENTS.id
;
-- 오라클 조인
SELECT E.id,
       E.name,
       D.name as DEPT_NAME
FROM EMPLOYEES E,
     DEPARTMENTS D
where E.dept_id = D.id
;

-- 표준 조인
SELECT E.id,
       E.name,
       D.name as DEPT_NAME
FROM EMPLOYEES E
         join DEPARTMENTS D
              ON E.dept_id = D.id
;

select *
from LIKES
order by USER_ID
;

-- 피드 조회
select p.POST_ID,
       u.USERNAME,
       u.EMAIL,
       p.CONTENT
from POSTS P,
     USERS U
where P.USER_ID = U.USER_ID
;

select p.POST_ID,
       u.USERNAME,
       u.EMAIL,
       p.CONTENT
from POSTS P
         inner join USERS U
                    on P.USER_ID = U.USER_ID
;

select *
from USERS;

-- 해시태그 테이블 조회
select * from HASHTAGS;
select * from POSTS;

-- 1001번 해시태그가 붙은 게시물을 조회
select pt.POST_ID,
       p.CONTENT,
       h.TAG_NAME
from POST_TAGS PT,
     HASHTAGS H,
     posts P
where pt.TAG_ID = H.TAG_ID
  AND pt.POST_ID = p.POST_ID
  AND H.TAG_ID = 1001
order by PT.POST_ID
;

SELECT
    PT.POST_ID,
    P.CONTENT,
    H.TAG_NAME
FROM POST_TAGS PT, HASHTAGS H, POSTS P
WHERE PT.TAG_ID = H.TAG_ID
  AND PT.POST_ID = P.POST_ID
  AND H.TAG_NAME LIKE '%일상%'
ORDER BY PT.POST_ID
;

-- 일상 해시태그가 붙은 게시물의 ID, 내용, 해시태그 이름을 조회
select
    pt.POST_ID,
       p.CONTENT,
       h.TAG_NAME
from POST_TAGS PT
Inner Join HASHTAGS H
on PT.TAG_ID = H.TAG_ID
Inner join posts P
on pt.POST_ID = p.POST_ID
where H.TAG_NAME LIKE '%일상%'
order by PT.POST_ID
;

-- 댓글 테이블 조회
select * from COMMENTS;
select * from POSTS;

-- 댓글과 게시물의 피드의 내용을 함께 조회

-- 오라클 조인, 표준 조인 (DB에 따른 분류)
-- 내부 조인, 외부 조인 (디비랑 관계없이 분류)

select
    p.POST_ID,
    p.CONTENT,
    p.VIEW_COUNT,
    to_char(p.CREATION_DATE, 'YYYY-MM-DD'),
    c.COMMENT_TEXT
from POSTS P inner join Comments C
on p.POST_ID = c.POST_ID;

select
    p.USER_ID,
    u.USERNAME,
    p.POST_ID,
    p.CONTENT,
    p.VIEW_COUNT,
    to_char(p.CREATION_DATE, 'YYYY-MM-DD'),
    c.USER_ID,
    u2.USERNAME as commenter,
    c.COMMENT_TEXT
from POSTS P
inner join Comments C
on p.POST_ID = c.POST_ID
inner join users U
on P.USER_ID = U.USER_ID
inner join USERS U2
on U2.USER_ID = c.USER_ID
;

-- outer 조인 예시
select * from USERS;            -- 필수 정보
select * from USER_PROFILES;    -- 선택 정보

-- inner join의 문제점: 값이 메칭되는 경우만 조회되므로
-- 상세프로필을 안 적은 회원은 나타나지 않음.
select
    u.USER_ID,
    u.USERNAME,
    u.EMAIL,
    up.FULL_NAME,
    up.BIO
from users U
join USER_PROFILES UP
on u.USER_ID = up.USER_ID
;

-- 우선 회원정보는 모두 조회하고, 단, 상세프로필이 있으면 걔네만 같이 조회해라
-- Left outer join: 왼쪽은 다 보여주고, 오른쪽 매칭 안되면 null로 표기
select
    *
from users U
Left outer join USER_PROFILES UP
on u.USER_ID = up.USER_ID
order by u.USER_ID
;

-- 오라클 외부 조인: left -> 오른쪽 조건에 (+), Right -> 왼쪽 조건에 (-)
select
    *
from users U, USER_PROFILES UP
where u.USER_ID = up.USER_ID(+)
order by u.USER_ID
;


