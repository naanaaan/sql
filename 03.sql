-- single function
desc dual
select * from dual;

select lower('SQL Course')
from dual;

select upper('SQL Course')
from dual;

select initcap('SQL Course')
from dual;

select last_name
from employees
where last_name = 'higgins';

select last_name
from employees
where last_name = 'Higgins';

select last_name
from employees
where lower(last_name) = 'higgins'; --db�� ���ڴ� row last_name field���� �ƴ� row���� ����
--lower function�� ���ϰ��� 'higgins'�� ���Ѵ�.

select concat('Hello', 'World')
from dual;

select substr('HelloWorld', 2, 5) --field 3�� 2�� ������ġ 5�� ����
from dual;

select substr('Hello', -1, 1)
from dual;

select length('Hello')
from dual;

select instr('Hello', 'l')
from dual; --index 3�� �ֵ� �ڤ��� �˻��ȵ�� ����

select instr('Hello', 'w')
from dual;

select lpad(salary, 5, '*') --���� ���� 5ĭ���� ������ ������ ��ĭ�� *��ä��
from employees;

select rpad(salary, 5, '*')
from employees;

select replace('JACK and JUE', 'J', 'BL')
from dual;  -- J�� BL�� �ٲ�

select trim('H' from 'Hello')
from dual;

select trim('l' from 'Hello')
from dual;

select trim(' ' from ' Hello ')
from dual;

--����: �� query���� ' '�� trim ������, ������ Ȯ���� �� �ְ� ��ȸ�϶�.
select '|' || trim(' ' from ' Hello ') || '|'
from dual;

select trim(' Hello World ')
from dual; -- ' '�� �⺻��

select employee_id, concat(first_name, last_name) name,
        job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG'; --4���ε������� ������ ���ڱ���

-- ����: �� query����, where ���� like �� refactoring �϶�.
select employee_id, concat(first_name, last_name) name,
        job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '___PROG%';