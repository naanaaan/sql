--group function row�� �׷��� �̷�
select round(avg(salary), 2), max(salary), min(salary), sum(salary)
from employees;

select min(hire_date), max(hire_date) --��¥Ÿ���� �����ξ��� ���̴������� ���� ���� db�� �����ʹ� ����
from employees;

--����: �ְ���ް� �ּҿ����� ������ ��ȸ�϶�.
select max(salary) - min(salary)
from employees;

select count(*) --count�� row�� ������ ���ϸ� *�� �ǹ̴� ��� Į���� �ǹ��Ѵ�.
from employees;

-- ����: 70�� �μ����� ����� �� ��ȸ�϶�.
select count(*)
from employees
where department_id = 70;
--

select count(employee_id)
from employees;

select count(manager_id) --�׷� �Լ��� Ư¡�� null���� �����Ѵ�. primary�� ������ Į���� ���°� ���� �ֳ� null���� ���⶧��
from employees;

select avg(commission_pct) --��������� commission�� ����̴�.
from employees;

-- ����: ������ ��� Ŀ�̼����� ��ȸ�϶�.
--��
select avg(nvl(commission_pct, 0))
from employees;
--

select avg(all salary) --all ������ �⺻��
from employees;

select avg(distinct salary) -- distinct �ߺ�����
from employees;

--����: ������ ��ġ�� �μ� ������ ��ȸ�϶�.
select count(distinct department_id)
from employees
where employee_id is not null;

--��
select count(distinct department_id)
from employees;
--

-- ����: �Ŵ��� ���� �����϶�.
select count(distinct manager_id)
from employees;
--

select department_id, count(employee_id) 
from employees
group by department_id --count group function�̱⋚���� �׷�ȭ��������Ѵ�. depart�� �׷��� �ƴϰ� count�� �׷��̱⋚��
order by department_id;-- �׷��� �����̶�� �����ϸ� ���ϴ�.

select employee_id
from employees
where department_id = 30;

select department_id, job_id, count(employee_id)
from employees
group by department_id, job_id
order by department_id;

-- ����: ������ ������� ��ȸ�϶�.
select job_id, count(employee_id)
from employees
group by job_id
order by count(employee_id);
--��
select job_id, count(employee_id)
from employees
group by job_id;
--

select department_id, max(salary)
from employees
group by department_id
having department_id > 50; --�׷��� ���ǹ�

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000;

select department_id, max(salary) max_sal
from employees
group by department_id
having max_sal > 10000; --����

select department_id, max(salary)
from employees
where department_id > 50
group by department_id;

select department_id, max(salary)
from employees
where max(salary) > 10000 -- where�� �׷����
group by department_id;

select job_id, sum(salary) payroll
from employees
where job_id not like '%REP%'
group by job_id
having sum(salary) > 13000
order by payroll;

--����: �Ŵ���ID, �Ŵ����� ���� ������ �� �ּҿ����� ��ȸ�϶�.
--        �ּҿ����� $6,000 �ʰ����� �Ѵ�.
select manager_id, min(salary) minsal
from employees
where manager_id is not null
group by manager_id
having min(salary) > 6000
order by 2 desc;
-- �� 
select manager_id, min(salary) minsal
from employees
where manager_id is not null
group by manager_id
having min(salary) > 6000
order by 2;

select  max(avg(salary))
from employees; --����

select  max(avg(salary))
from employees
group by department_id; --�ذ�

select sum(max(avg(salary))) --���� �׷��Լ��� �ִ� 2��
from employees
group by department_id;

select department_id, round(avg(salary))
from employees
group by department_id;

select department_id, round(avg(salary))
from employees; --����

-- ����: 2001��, 2002��, 2003�⵵�� �Ի��� ���� ��ȸ�϶�.
select  to_char(hire_date, 'YYYY') , count(last_name) count
from employees
where  to_char(hire_date, 'YYYY') between 2001 and 2003
group by to_char(hire_date, 'YYYY')
order by 1;
--�� A
select to_char(hire_date, 'yyyy') hire_year, count(*) emp_cnt
from employees
where to_char(hire_date, 'yyyy') in (2001, 2002, 2003)
group by to_char(hire_date, 'yyyy')
order by hire_year;
--�� B
select sum(decode(to_char(hire_date, 'yyyy'), '2001', 1, 0)) "2001",
    sum(decode(to_char(hire_date, 'yyyy'), '2002', 1, 0)) "2002",
    sum(decode(to_char(hire_date, 'yyyy'), '2003', 1, 0)) "2003"
from employees;
--�� C
select count(case when hire_date like '2001%' then 1 else null end) "2001",
            count(case when hire_date like '2002%' then 1 else null end) "2002",
            count(case when hire_date like '2003%' then 1 else null end) "2003"
from employees;
--

--����: ������, �μ��� �������� ��ȸ�϶�.
-- �μ��� 20, 50, 80�̴�.
select job_id, sum(case when department_id = 20 then salary end) "20",
                        sum(case when department_id = 50 then salary end) "50",
                        sum(case when department_id = 80 then salary end) "80"
from employees
where department_id in (20, 50, 80)
group by  job_id
order by 1;
--��
select job_id, sum(decode(department_id, 20, salary)) "20",
            sum(decode(department_id, 50, salary)) "50",
            sum(decode(department_id, 80, salary)) "80"
from employees
group by job_id;
--
