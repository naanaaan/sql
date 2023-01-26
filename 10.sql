
drop table hire_dates;

create table hire_dates (
emp_id number(8),
hire_date date default sysdate);

-- data dictionary
select tname
from tab; --tab은 meta data를 저장되어있는 오라클의 기본 테이블이다.
-- BIN뭐시기는 쓰레기다 drop 테이블했을때 바꿔버린거임 logical하게 지워버림
--답
select tname
from tab
where tname not like 'BIN$%';
--
show recyclebin;-- recyclebin은 휴지통 purge recyclebin하면 휴지통비우기
purge recyclebin;
show recyclebin;
select tname
from tab;

insert into hire_dates values(1, to_date('2025/12/21'));
insert into hire_dates values(2, null);
insert into hire_dates(emp_id) values(3);

select * from hire_dates;

commit; --hr스키마에 저장됨
--ddl은 자동 commit이기 때문에 100번 insert하다 ddl을 쓰면 자동 commit됨
--dml 수동 commit

-- DCL (Data Control Language)
