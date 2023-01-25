select tname
from tab;

create table depts(
department_id number(3) constraint depts_deptid_pk primary key,
department_name varchar2(30));
--��Ģ ���̺�� Į���� �Ű
--���Ἲ�� Ȯ���ϱ����� constraint�� ����.
--field�� value�� table������ �����ؾ��Ѵ�. �׷��� null�� ���� �ȵ� �� �ߺ� x

desc user_constraints;

select constraint_name, constraint_type, table_name
from user_constraints;

create table emps(
employee_id number(3) primary key, --nuber(3)�� 3�ڸ��� varchar2(10)�� 10byte �ѱ��������ص� 10byte�� ���� ���� �ƴ�
emp_name varchar2(10) constraint emps_empname_nn not null, --not null ��������
email varchar2(20), 
salary number(6) constraint emps_sal_ck check(salary > 1000),
department_id number(3), 
constraint emps_email_uk unique(email),
constraint emps_deptid_fk foreign key(department_id)--���Ἲ�� Ȯ���ϱ� ���ؼ� fk�� ����.
    references depts(department_id));
    
select constraint_name, constraint_type, table_name
from user_constraints;

--pk = not null + unique

insert into depts values(100, 'Development');
insert into emps values(500, 'musk', 'musk@gamil.com', 5000, 100);
insert into emps values(501, 'a', 'musk@gamil.net', 2000, 101);

drop table emps cascade constraints; --�������ǵ鵵 ���� ����

select constraint_name, constraint_type, table_name
from user_constraints;

select * from depts; --hr�������ؼ� ��ȸ�غñ⋚���� depts�� you��Ű��������