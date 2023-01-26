--10���� �����ڰ� �ȴٷ� �˰� ���� ��
--hr��������
create view empvu80 as
        select employee_id, last_name, department_id
        from employees
        where department_id = 80;
        
desc empvu80

select * from empvu80; --view�� �����Ͱ� ����ȰԾƴϴ� â���ǳʷ� ���� ����

select * from (
        select employee_id, last_name, department_id
        from employees
        where department_id =80);
        
create or replace view empvu80 as 
        select employee_id, job_id
        from employees
        where department_id = 80;--�̹� empvu80 view�� �ֱ⶧���� replace
        
desc empvu80;

--����: 50�� �μ������� ���, �̸�, �μ���ȣ�� ������ DEPT50 view �� ������.
--      view ������ EMPNO, EMPLOYEE, DEPTNO �̴�.
--��
create or replace view dept50(empno, employeem, deptno) as 
    select employee_id, last_name, department_id
    from employees
    where department_id = 50;
desc dept50;
select * from dept50;
-- ����2��°�� �������ε� �� ����

create or replace view dept50(empno, employee, deptno) as
    select employee_id, last_name, department_id
    from  employees
    where department_id = 50
    with check option constraint dept50_ck;--view constraint�� �� �ٸ�
    
--view �� insert�����ѵ� ������������ â���� ������ �ƴϰ� �Ǿ����

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
insert into team50 values(301, 'IT Support');--check option�� �ɸ�
--with check option�� ���� where���� ���ǿ� �°� �˾Ƽ� �ɷ���

create or replace view emvu10(employee_num, employee_name, job_title) as
    select employee_id, last_name, job_id
    from employees
    where department_id = 10
    with read only;
    
insert into emvu10 values(501, 'able', 'Sales');
select * from emvu10;
--view ��

--sequence �ʼ�!! �߿���

drop sequence team_teamid_seq;

create sequence team_teamid_seq;
--1���ͽ����ؼ� �޿� �ö���

select team_teamid_seq.nextval from dual;
select team_teamid_seq.nextval from dual;
select team_teamid_seq.nextval from dual;
select team_teamid_seq.nextval from dual;--���ΰ�Ӹ���
select team_teamid_seq.currval from dual;--���簪

insert into teams
values(team_teamid_seq.nextval, 'Marketing');

select * from teams
where team_id < 6;

create sequence x_xid_seq
        start with 10
        increment by 5 --5������
        maxvalue 20
        nocache --�̸� �غ���ϴ� �۾� ĳ�����ϰڵ�.--�������� ���� �����ϱ����� �޸𸮿� ĳ�� ����
        --nocache �⺻��20
        nocycle;  --20�������������� �ٽ� ó�����ͽ����ϴ°� cycle�� �ȵ��ư�

select x_xid_seq.nextval from dual;

-- ����: DEPT ���̺��� DEPARTMENT_ID Į���� field value �� �� sequence�� ������
--          sequence�� 400�̻� 1000���Ϸ� �����Ѵ�. 10�� �����Ѵ�.
create sequence dept_deptid_seq
        start with 400
        increment by 10
        maxvalue 1000;
--

--����: �� sequence�� �̿��ؼ�, DEPT ���̺��� Education �μ��� insert �϶�.
insert into dept(department_id, department_name)
values(dept_deptid_seq.nextval, 'Education');

commit;

--sequence ��

--index
--primaryŰ�� �����ϸ� �ε��� �ڵ� ����
--Ư�� Į���� ������ �ε����� ����� ���̴�. Į���� �����ؼ� �ε����� ����
drop index emp_last_name_idx;

create index emp_lastname_idx
on employees(last_name);

select last_name, rowid
from employees; --row�� ������ �� ��ȸ
--row���̵�� ����Ŭ���� ã�Ƴ���.

select last_name
from employees
where rowid = 'AAAEAbAAEAAAADNABe';
--�ε����� ã�Ƴ��� �˰����� ���� ����ϴ�.

select index_name, index_type, table_owner, table_name
from user_indexes;

-- ����: DEPT ���̺��� DEPARTMENT_NAME �� ���� index�� ������.
create index dept_dept_idx on departments(department_name);
--

--index��

--db��ü�� ������̱� why ���̺� �ε��� ��� �̸��� ��ų� �����ϱ� ����

drop synonym team;

create synonym team
for departments;

select * from team;

-- ����: EMPLOYYEES ���̺� EMPS synonym �� ������.

create synonym EMPS for employees;