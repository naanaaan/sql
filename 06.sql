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
using (location_id)
where d.location_id = 1400; --����

select l.city, d.department_name, d.location_id --����       
from locations l  join departments d
using (location_id)
where location_id = 1400;