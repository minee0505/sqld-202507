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




