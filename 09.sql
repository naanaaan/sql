drop table dept; --테이블 삭제




create table dept(
department_id number(4),
department_name varchar2(30),
manager_id number(6),
location_id number(4)
);
--위가 ddl작업
--data definition language -> auto commit임

create table emp (
employee_id number(6),
first_name varchar2(20),
last_name varchar2(25),
email varchar2(25),
phone_number varchar2(20),
hire_date date,
job_id varchar2(10),
salary number(8, 2),
commission_pct number(2, 2),
manager_id number(6),
department_id number(4));

insert into dept(department_id, department_name, manager_id, location_id)
values (100, 'Public Relation', 100, 1700);

insert into dept(department_id, department_name)
values (310, 'Purchasing');

select *
from dept;

commit; --transaction끝

insert into emp(employee_id, first_name, last_name,
                                email, phone_number, hire_date,
                                job_id, salary, commission_pct,
                                manager_id, department_id)
values(300, 'Louis', 'Pop',
            'Pop@gmail.com', '010-378-1278', sysdate,
            'AC_ACCOUNT', 6900, null,
            205, 110);
            
insert into emp
values(320, 'Terry', 'Benard',
            'Benard@gmail.com', '010-637-0972', '2022/07/20',
            'AD_PRES', 5000, .2,
            100, 310);

commit; --메모리 cpu할당된 거 더이상 안씀 그래서 꼭 commit해서 끝을 내줘야함
--테이블은 하나의 데이터타입이며 로우들은 데이터라고 본다.
select * from emp;

create table sa_reps (
rep_id number(6),
rep_name varchar2(25),
salary number(8, 2),
commission_pct number(2, 2)
);

insert all
        into sa_reps values(1, '최한석', 20000, .1)
        into sa_reps values(2, '한아름', 30000, .12)
select * from dual;

commit;

select * from sa_reps;

--아래부터 굳이 외울필요없다
--procedure
declare --변수선언
    base number(6) := 400; 
begin
    for i in 1..10 loop--(시작1 끝10 총 10번)
            insert into sa_reps(rep_id, rep_name, salary, commission_pct)
            values (base + i, 'n' || (base + i), base * i, i * 0.01);
    end loop;
end;
/

--슬래쉬 있어야 컴파일함
--function 과 procedure의 차이는 function은 이름이 있고 procedure은 없음
--즉 function은 n번을 사용하는 것이다. procedure은 없어서 일회용이다.

select *
from sa_reps
where rep_id > 400;

commit;

--쓰고 있는 테이블을 직접적으로 insert를 하면 나중에 문제가 생길 수 있으므로
--백업처럼 임의의 테이블에 원하는 테이블 데이터를 insert를 한다.
--구조가 같아야함
insert into sa_reps(rep_id, rep_name, salary, commission_pct)
    select employee_id, last_name, salary, commission_pct
    from employees
    where job_id like '%REP%';

commit;

update emp
set job_id = 'IT_PROG', 
        salary = 30000
where employee_id = 300;

select job_id, salary
from emp
where employee_id = 300;

update emp
set salary = null
where employee_id = 300;

select job_id, salary
from emp
where employee_id = 300;

rollback;
--마지막에 커밋한 값을 반환한다.
select job_id, salary
from emp
where employee_id = 300;

--중복된게 많아 나쁜코드
update emp
set job_id = (select job_id
                        from employees
                        where employee_id = 205),
    salary = (select salary
                       from employees
                       where employee_id = 205)
where employee_id = 300; --where안쓰면 다 실행되니 꼭 쓰자!

select job_id, salary
from emp
where employee_id = 300;

rollback;

select job_id, salary
from emp
where employee_id = 300;

--좋은코드
update emp
set (job_id, salary) = (
        select job_id, salary
        from employees
        where employee_id = 205)
where employee_id = 300;        

select job_id, salary
from emp
where employee_id = 300;

commit;
--현장에서 row의 갯수로 잘 됐는지 확인할 수 있따.

delete dept
where department_id = 310;

select * from dept;

rollback; --transaction이 취소됐따.

select * from emp;


delete emp
where department_id = (
    select department_id
    from departments
    where department_name = 'Purchasing');

select * from emp;

commit;