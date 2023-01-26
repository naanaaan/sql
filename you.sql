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

--system계정
grant all on hr.departments to you;
--

drop table employees cascade constraints;
drop table employees;

create table employees(
employee_id number(6) constraint emp_empid_pk primary key,
first_name varchar2(20),
last_name varchar2(25) constraint emp_last_name_nn not null,
email varchar2(25) constraint emp_email_nn not null
                                constraint emp_email_uk unique,
phone_number varchar2(20),
hire_date date constraint emp_hiredate_nn not null,
job_id varchar2(10) constraint emp_jobid_nn not null,
salary number(8) constraint emp_salary_ck check(salary > 0 ),
commission_pct number(2, 2),
manager_id number(6) constraint emp_managerid_fk references employees(employee_id),
department_id number(4) constraint emp_dept_fk references hr.departments(department_id));


create table gu (
gu_id number(3) primary key,
gu_name char(9) not null);

create table dong(
dong_id number(4) primary key,
dong_name varchar2(12) not null,
gu_id number(3) references gu(gu_id) on delete cascade); --기본키테이블이 부모인데 
--부모테이블의 데이터가 사라지면 자식테이블에서도 사라진다 on delete casacade--row삭제

create table dong2(
dong_id number(4) primary key,
dong_name varchar2(12) not null,
gu_id number(3) references gu(gu_id) on delete set null); -- null값으로 설정하기
 
 
 insert into gu values(100, '강남구');
 insert into gu values(200, '노원구');
 
 insert into dong values(5000, '압구정동', null);
 insert into dong values(5001, '삼성동', 100);
 insert into dong values(5002, '역삼동', 100);
 insert into dong values(6001, '상계동', 200);
 insert into dong values(6002, '중계동', 200);
 
 insert into dong2
 select * from dong;
 
 delete gu
 where gu_id = 100;
 
 select * from dong;
 select * from dong2;
 
 commit;
 
 create table a (
 aid number(1) constraint a_aid_pk primary key);
 
 create table b (
 bid number(2),
 aid number(1),
 constraint b_aid_fk foreign key(aid) references a(aid));
 
 insert into a values(1);
 insert into b values(31, 1);
 insert into b values(32, 9); --alter을하니까 적용됨
 
 alter table b disable constraint b_aid_fk;
 
 alter table b enable constraint b_aid_fk;--에러
 alter table b enable novalidate constraint b_aid_fk;
 
 insert into b values(33, 8);
 
 create table sub_departments as 
        select department_id dept_id, department_name dept_name
        from hr.departments;
        
select * from sub_departments;

create table users(
user_id number(3));
desc users

alter table users add(user_name varchar2(10));
desc users;

alter table users modify(user_name number(7));
desc users;

alter table users drop column user_name;
desc users;

insert into users values(1);

alter table users read only;
insert into users values(2); --read only때매 안됨

alter table users read write;
insert into users values(2);--이제가능

commit;