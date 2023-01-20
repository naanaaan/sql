-- join�̶� �ٸ� ���̺��� �ҷ����� ���ε� ���̺��� row���� �����̱⶧���� row���� �������� ���̴�.
-- �����̺��� ���ἱ�� relationship�̶�� �Ѵ�. -> FK �ܷ�Ű
-- �̷� 0 �� ----�Ǽ��� may���� ���� �ִ�. �����޴� ���� ������ ������ �ִٶ�� �����ϸ�ȴ�.
select department_id, department_name, location_id
from departments;

select location_id,  city
from locations;

--equi join
select department_id, department_name, location_id, city
from departments natural join locations;  --�������̺��� ���� Į���� ã�´� -> �� Į���� �´� row�� �ҷ��´�.
--������ 1���� location_id 1400�� ���� �������� ã�� �ڿ� localtions�� ���̺��� location_id�� 1400�� ���� �����´�.

select department_id, department_name, location_id, city
from departments natural join locations --��� ��ġ�ϴ� ��� Į������ ��ȸ
where department_id in (20, 50);
--
select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);  --���ϴ� Į���� ��ȸ

-- ����: ������ ������ 1���� �̸�, �μ���ȣ�� ��ȸ�϶�.
select last_name, department_id
from employees
where department_id is null;
--

select employee_id, last_name, department_id, location_id
from employees natural join departments;

select locations.city, departments.department_name
from locations join departments
using (location_id)
where location_id = 1400;

select l.city, d.department_name        --�������� ���
from locations l  join departments d
using (location_id)
where location_id = 1400;

select l.city, d.department_name        
from locations l  join departments d
using (location_idse
where d.location_id = 1400; --����

select l.city, d.department_name, d.location_id --����       
from locations l  join departments d
using (location_id)
where location_id = 1400;

select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where d.manager_id = 100;

select a.employee_id, a.last_name, a.department_id,
    d.department_id, d.location_id
from employees a join departments d
on (a.department_id = d.department_id);

select employee_id, city, department_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

--����: �� query�� using ���� refactoring �϶�.
--��
select employee_id, city, department_name
from employees e join departments d
using(department_id)
join locations l
using (location_id);
--

select e.employee_id, e.last_name, e.department_id,
        d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
where e.manager_id = 149;

-- ����: Toronto�� ��ġ�� �μ����� ���ϴ� �������
--          �̸�, ����, �μ���ȣ, �μ���, ���ø� ��ȸ�϶�.
select e.last_name, e.job_id, e.department_id, l.city
from employees e join locations l
on l.city = 'Toronto';

--��
select e.last_name, e.job_id, e.department_id,
    d.department_name, l.city
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
--where l.city = 'Toronto';
and l.city = 'Toronto';  --�̷��Ե� ����
--
-- non-equi join
select e.last_name, e.salary, e.job_id
from employees e join jobs j
on e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';

--self join
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id;

select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on manager_id = employee_id; --����

select worker1.last_name emp, worker2.last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id; --����

-- ����: ���� �μ����� ���ϴ� ������� �μ���ȣ, �̸�, ������� ��ȸ�϶�.
select worker.last_name wor, worker.department_id worD, college.last_name cle
from employees worker join employees college
on worker.department_id = college.department_id
and worker.last_name != college.last_name;
--��
select e.department_id, e.last_name employee, c.last_name clooeague
from employees e join employees c
on e.department_id = c.department_id
and e.employee_id <> c.employee_id
order by 1, 2, 3;
--

--����: Davies ���� �Ŀ� �Ի��� ������� �̸�, �Ի����� ��ȸ�϶�. 2005/01/29
select c.last_name, c.hire_date
from employees e join employees c
on c.hire_date > e.hire_date
where e.last_name = 'Davies'
order by 2;
--��
select e.last_name, e.hire_date
from employees e join employees d
on d.last_name = 'Davies'
and e.hire_date > d.hire_date;
--

--����: �Ŵ������� ���� �Ի��� ������� �̸�, �Ի���, �Ŵ�����, �Ŵ��� �Ի����� ��ȸ�϶�.
select e.last_name, e.hire_date, m.last_name, m.hire_date
from employees e join employees m
on e.hire_date < m.hire_date
join departments d
on m.department_id = d.department_id
and d.manager_id = m.employee_id;
--
--��
select w.last_name, w.hire_date, m.last_name, m.hire_date
from employees w join employees m
on w.manager_id = m.employee_id
and w.hire_date < m.hire_date;
--

--inner join
select e.last_name, e.department_id, d.department_name
from employees e join departments d 
on e.department_id = d.department_id;

--outer join
select e.last_name, e.department_id, d.department_name --join���� �ʴ� Grant�� ���ԵǾ�����
from employees e left outer join departments d    -- ����
on e.department_id = d.department_id;

select e.last_name, e.department_id, d.department_name 
from employees e right outer join departments d  --��� ������
on e.department_id = d.department_id;

select e.last_name, e.department_id, d.department_name 
from employees e full outer join departments d --����
on e.department_id = d.department_id;

-- ����: ������� �̸�, ���, �Ŵ�����, �Ŵ����� ����� ��ȸ�϶�.
--        King ȸ�嵵 ���̺� �����϶�.
select e.last_name, e.employee_id, m.last_name, m.manager_id
from employees e   join employees m
on e.manager_id = m.employee_id
order by 3;
--��
select w.last_name, w.employee_id, m.last_name, m.employee_id
from employees w left outer join employees m
on w.manager_id = m.employee_id
order by 2;
--

select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l --equi, inner join
where d.location_id = l.location_id
    and d.department_id in (20, 50);
    
select e.last_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;

select e.last_name, e.salary, e.job_id
from employees e, jobs j
where e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;  --outer join �̰� rigtht

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+); -- left 

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id(+); --���ſ� full outer join�� ����

select worker.last_name || ' works for '  || manager.last_name
from employees worker, employees manager
where worker.manager_id = manager.employee_id;