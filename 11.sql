--10장은 개발자가 안다룸 알고만 있을 것
--hr계정으로
create view empvu80 as
        select employee_id, last_name, department_id
        from employees
        where department_id = 80;
        
desc empvu80

select * from empvu80; --view에 데이터가 저장된게아니다 창문건너로 보는 것임

select * from (
        select employee_id, last_name, department_id
        from employees
        where department_id =80);
        
create or replace view empvu80 as 
        select employee_id, job_id
        from employees
        where department_id = 80;--이미 empvu80 view가 있기때문에 replace
        
desc empvu80;

--과제: 50번 부서원들의 사번, 이름, 부서번호로 구성된 DEPT50 view 를 만들어라.
--      view 구조는 EMPNO, EMPLOYEE, DEPTNO 이다.
--답
create or replace view dept50(empno, employeem, deptno) as 
    select employee_id, last_name, department_id
    from employees
    where department_id = 50;
desc dept50;
select * from dept50;
-- 과제2번째줄 별명으로도 답 가능

create or replace view dept50(empno, employee, deptno) as
    select employee_id, last_name, department_id
    from  employees
    where department_id = 50
    with check option constraint dept50_ck;--view constraint는 좀 다름
    
--view 도 insert가능한데 권장하지않음 창문의 역할이 아니게 되어버림

create table teams as
        select department_id team_id, department_name team_name
        from hr.departments;
        
create view team50 as
        select *
        from teams
        where team_id = 50;

select * from team50;

select count(*) from teams;
insert into team50
values(300, 'Marketing');

select count(*) from teams;

create or replace view team50 as
        select *
        from teams
        where team_id = 50
        with check option;

insert into team50 values(50, 'IT Support');
select count(*) from teams;
insert into team50 values(301, 'IT Support');--check option에 걸림
--with check option을 쓰면 where절의 조건에 맞게 알아서 걸러줌

create or replace view emvu10(employee_num, employee_name, job_title) as
    select employee_id, last_name, job_id
    from employees
    where department_id = 10
    with read only;
    
insert into emvu10 values(501, 'able', 'Sales');
select * from emvu10;
--view 끝

--sequence 필수!! 중요함

drop sequence team_teamid_seq;

create sequence team_teamid_seq;
--1부터시작해서 쭈욱 올랑감

select team_teamid_seq.nextval from dual;
select team_teamid_seq.nextval from dual;
select team_teamid_seq.nextval from dual;
select team_teamid_seq.nextval from dual;--새로계속만듬
select team_teamid_seq.currval from dual;--현재값

insert into teams
values(team_teamid_seq.nextval, 'Marketing');

select * from teams
where team_id < 6;

create sequence x_xid_seq
        start with 10
        increment by 5 --5씩증가
        maxvalue 20
        nocache --미리 준비안하는 작업 캐쉬안하겠따.--시퀸스를 빨리 제공하기위해 메모리에 캐쉬 지정
        --nocache 기본값20
        nocycle;  --20까지도달했을때 다시 처음부터시작하는게 cycle즉 안돌아감

select x_xid_seq.nextval from dual;

-- 과제: DEPT 테이블의 DEPARTMENT_ID 칼럼의 field value 로 쓸 sequence를 만들어라
--          sequence는 400이상 1000이하로 생성한다. 10씩 증가한다.
create sequence dept_deptid_seq
        start with 400
        increment by 10
        maxvalue 1000;
--

--과제: 위 sequence를 이용해서, DEPT 테이블에서 Education 부서를 insert 하라.
insert into dept(department_id, department_name)
values(dept_deptid_seq.nextval, 'Education');

commit;

--sequence 끝

--index
--primary키를 지정하면 인덱스 자동 지정
--특정 칼럼을 가지고 인덱스를 만드는 것이다. 칼럼을 복사해서 인덱스를 만듬
drop index emp_last_name_idx;

create index emp_lastname_idx
on employees(last_name);

select last_name, rowid
from employees; --row별 유일한 값 조회
--row아이디로 오라클에서 찾아낸다.

select last_name
from employees
where rowid = 'AAAEAbAAEAAAADNABe';
--인데스로 찾아내느 알고리즘이 위와 비슷하다.

select index_name, index_type, table_owner, table_name
from user_indexes;

-- 과제: DEPT 테이블의 DEPARTMENT_NAME 에 대해 index를 만들어라.
create index dept_dept_idx on departments(department_name);
--

--index끝

--db객체의 별명붙이기 why 테이블 인덱스 등등 이름이 길거나 구분하기 위해

drop synonym team;

create synonym team
for departments;

select * from team;

-- 과제: EMPLOYYEES 테이블에 EMPS synonym 을 만들어라.

create synonym EMPS for employees;