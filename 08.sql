--list�� set���̴� set�� �ߺ��� �� ��� x ���� list�� Ű�� �־ �ߺ��� �� ���� ����
--set�� key���� -java���ϴ°���

select employee_id, job_id
from employees
union

select employee_id, job_id
from job_history; --union�Ἥ �ΰ��� ������
--���������� ���̺� ����, ������Ÿ��(Į���޶� ������� ������Ÿ�����߿�),
--�ߺ��� �ο� ����
select employee_id, job_id
from employees
union all 

select employee_id, job_id
from job_history
order by employee_id;

-- ����: ���� ������ ���� ���� �ִ� ������� ���, �̸�, ������ ��ȸ�϶�.
select employee_id, last_name, job_id
from employees e
where exists (select *
                                        from job_history j
                                        where e.employee_id = j.employee_id
                                        and e.job_id = j.job_id); --�����~
--��1
select employee_id, last_name, job_id
from employees e
where exists (select *
                                        from job_history j
                                        where e.employee_id = j.employee_id
                                        and e.job_id = j.job_id);
--��2
select employee_id, last_name, job_id
from employees e
where e.job_id in (select job_id
                                        from job_history j
                                        where e.employee_id = j.employee_id);
--��3
select e.employee_id, e.last_name, e.job_id
from employees e, job_history j
where e.employee_id = j.employee_id
and e.job_id = j.job_id;
--

select location_id, department_name --ù���� Į���� �߽����� �� ������Ÿ�� ���ƾ� ��
from departments
union
select location_id, state_province
from locations;  --�������ϰԴ� ��������� �������ϰԴ� �����ʴ� �����󿡼� ������

--����: �� ������ service �������� ���Ķ�.
--        union �� ����Ѵ�.
select location_id, department_name
from departments
union
select location_id, state_province
from locations;
--��
select location_id, department_name, null state
from departments
union
select location_id, null, state_province
from locations;
--

select employee_id, job_id, salary
from employees
union
select employee_id, job_id, 0 --0����ä��
from job_history
order by salary;