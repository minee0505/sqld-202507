-- 트랜잭션 실습

-- 안전을 위해 테이블 복사 CTAS
create table user_copy as
select * from users;

select * from user_copy;

delete from user_copy;

commit;
rollback;