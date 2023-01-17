-- where
select employee_id, last_name, department_id
from employees
where department_id = 50;

-- ����: 176�� ����� ���, �̸�, �μ���ȣ�� ��ȸ�϶�.
select employee_id, last_name, department_id
from employees
where employee_id = 176;

select employee_id, last_name, department_id
from employees
where last_name = 'Whalen';

select employee_id, last_name, hire_date
from employees
where hire_date = '2008/02/06';

select last_name, salary
from employees
where salary <= 3000;

-- ����: �� $12,000 �̻� ���� ������� �̸�, ������ ��ȸ�϶�.
select last_name, salary
from employees
where salary >= 12000;

select last_name, job_id
from employees
where job_id != 'IT_PROG';

select last_name, salary
from employees
where salary between 2500 and 3500; --�̻� ����

select last_name
from employees
where last_name between 'King' and 'Smith';

--����: 'King' ����� frist_name, last_name, ����, ������ ��ȸ�϶�.
select first_name, last_name, job_id, salary
from employees
where last_name = 'King';

select last_name, hire_date
from employees
where hire_date between '2002/01/01' and '2002/12/31';

select employee_id, last_name, manager_id
from employees
where manager_id in (100, 101, 201); --()���ȿ� �ϳ��� ������ ���

select employee_id, last_name, manager_id
from employees
where manager_id = 100 or
    manager_id = 101 or
    manager_id = 201;
    
select employee_id, last_name
from employees
where last_name in ('Hartstein', 'Vargars');

select last_name, hire_date
from employees
where hire_date in ('2003/06/17', '2005/09/21');

select last_name
from employees
where last_name like 'S%'; --S�� ���� %�� ���ϵ�ī�� �ƹ��ų�

select last_name
from employees
where last_name like '%r';

-- ����: �̸��� s �� ���Ե� ������� �̸��� ��ȸ�϶�.
select last_name
from employees
where last_name like '%s%';

-- ����: 2005�⿡ �Ի��� ������� �̸�, �Ի����� ��ȸ�϶�.
select last_name, hire_date
from employees
where hire_date like '2005%'; --%�� ������ ��������

select last_name
from employees
where last_name like 'K___'; -- _������ �ѱ���

--����: �̸��� �ι�° ���ڰ� o �� ����� �̸��� ��ȸ�϶�.
select last_name
from employees
where last_name like '_o%';

select job_id
from employees;

select last_name, job_id
from employees
where job_id like 'I_\_%' escape '\'; -- escape���ڷ� \�� ���ϰ� \_�� �ϸ� _�� ���ڰ� �ȴ�.
-- \�ڿ� _�� ���ڰ���
-- ����: ������ _R�� ���յ� ������� �̸�, ������ ��ȸ�϶�.
select last_name, job_id
from employees
where job_id like '%\_R%' escape '\';

select employee_id, last_name, manager_id
from employees;

select last_name, manager_id
from employees
where manager_id = null;  --expression�� null�� ������ null�� ǥ���Ѵ�.

select last_name, manager_id
from employees
where manager_id is null;

select last_name, job_id, salary
from employees
where salary >= 5000 and job_id like '%IT%';

select last_name, job_id, salary
from employees
where salary >= 5000 or job_id like '%IT%';

--����: ������ $5000 �̻� $120000 �����̴�. �׸���,
--      20���̳� 50�� �μ����� ���ϴ� ������� �̸�, ����, �μ���ȣ�� ��ȸ�϶�.
select last_name, salary, department_id
from employees
where (salary between 5000 and 12000) and department_id in(20, 50);

-- ����: �̸��� a�� e�� ���Ե� ������� �̸��� ��ȸ�϶�.
select last_name
from employees
where last_name like '%a%' and last_name like '%e%';

select last_name, job_id
from employees
where job_id not in ('IT_PROG', 'SA_REP'); --not�� ���� �����ϰ� �ǹ��Ѵ�.

select last_name, salary
from employees
where salary not between 1000 and 15000;

select last_name, job_id
from employees
where job_id not like '%IT%';

select last_name, job_id
from employees
where commission_pct is not null;

select last_name, salary
from employees
where not (manager_id is null and salary >= 20000);

-- ����: ������ �����̴�. �׸���, ������ %2500, $3500�� �ƴϴ�.
--      �� ������� �̸�, ����, ������ ��ȸ�϶�.
select last_name, job_id, salary
from employees
where salary not in(2500, 3500) and job_id like 'SA%';

select last_name, department_id
from employees
order by department_id desc; --�������� desc������ �������� null�� ����

select last_name, department_id
from employees
order by 2; --sql�� index 1���ͽ����Ѵ�.

select last_name, department_id dept_id
from employees
order by dept_id;

select last_name, hire_date
from employees
where department_id = 100
order by hire_date; --order by�� �������� ����

select last_name, department_id, salary
from employees
where department_id > 80
order by department_id asc, salary desc;