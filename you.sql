select tname
from tab;

create table depts(
department_id number(3) constraint depts_deptid_pk primary key,
department_name varchar2(30));
--규칙 테이블명 칼럼명 어떤키
--무결성을 확보하기위해 constraint를 쓴다.
--field의 value가 table내에서 유일해야한다. 그래서 null값 오면 안됨 즉 중복 x

desc user_constraints;

select constraint_name, constraint_type, table_name
from user_constraints;

create table emps(
employee_id number(3) primary key, --nuber(3)은 3자릿수 varchar2(10)은 10byte 한글자저장해도 10byte다 쓰느 ㄴ거 아님
emp_name varchar2(10) constraint emps_empname_nn not null, --not null 제약조건
email varchar2(20), 
salary number(6) constraint emps_sal_ck check(salary > 1000),
department_id number(3), 
constraint emps_email_uk unique(email),
constraint emps_deptid_fk foreign key(department_id)--무결성을 확보하기 위해서 fk를 쓴다.
    references depts(department_id));
    
select constraint_name, constraint_type, table_name
from user_constraints;

--pk = not null + unique

insert into depts values(100, 'Development');
insert into emps values(500, 'musk', 'musk@gamil.com', 5000, 100);
insert into emps values(501, 'a', 'musk@gamil.net', 2000, 101);

drop table emps cascade constraints; --제약조건들도 같이 삭제

select constraint_name, constraint_type, table_name
from user_constraints;

select * from depts; --hr로접속해서 조회해봤기떄문에 depts는 you스키마에있음