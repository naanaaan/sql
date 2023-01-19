select hire_date
from employees
where hire_date = '2003/06/17'; --ĳ���Ͱ� date�� ��ȯ

select salary
from employees
where salary = '7000';  --ĳ���Ͱ� number�� ��ȯ

select hire_date || ''
from employees; -- date�� ĳ���ͷ� ��ȯ

select salary || ''
from employees; -- number�� ĳ���ͷ� ��ȯ

select to_char(hire_date)
from employees; --to_char�� �� ĳ���ͷ� ��ȯ

select to_char(sysdate, 'yyyy-mm-dd')
from dual;  --������ �������� ��ȯ

select to_char(sysdate, 'YEAR MONTH DDsp Day(DY)')
from dual;

select to_char(sysdate, 'Year Month Ddsp Day(Dy)')
from dual;

select to_char(sysdate, 'd')
from dual; --������ �ε����� ��ȯ;

select last_name, hire_date,
    to_char(hire_date, 'day'),
    to_char(hire_date, 'd')
from employees;

-- ����: �� ���̺��� �����Ϻ��� �Ի��ϼ� �������� �����϶�.

select last_name, hire_date,
    to_char(hire_date, 'day'),
   replace(to_char(hire_date, 'd'), '1', '8')
from employees
order by 4, 1;

--��
select last_name, hire_date,
    to_char(hire_date, 'day') day
from employees
order by to_char(hire_date - 1, 'd');
--

select to_char(sysdate, 'hh24:mi:ss am')
from dual;

select to_char(sysdate, 'DD "of" Month')
from dual;

select to_char(hire_date, 'fmDD Month YY') --fm�� �߰��ϸ� ������ ����ȴ�. fill mode
from employees;

-- ����: ������� �̸�, �Ի���, �λ������� ��ȸ�϶�.
--      �λ������� �Ի��� �� 3���� �� ù��° ������ �̴�.
--      ��¥�� YYYY.MM.DD �� ǥ���Ѵ�.
select last_name, hire_date, to_char(next_day(add_months(hire_date, 3),'mon'), 'YYYY.MM.DD') eva
from employees;
--��
select last_name, to_char(hire_date, 'YYYY.MM.DD'),
    to_char(next_day(add_months(hire_date, 3),'mon'), 'YYYY.MM.DD')
from employees;
--

select to_char(salary)
from employees;

select to_char(salary, '$99,999.99'), to_char(salary, '$00,000.00') --�ΰ����̴� 0�� ���̾����� 0�̶�ä��
from employees
where last_name = 'Ernst';

select '|' || to_char(12.12, '9999.99') || '|',
        '|' || to_char(12.12, '0000.00') || '|'
from dual;

select '|' || to_char(12.12, 'fm9999.99') || '|',
        '|' || to_char(12.12, 'fm0000.00') || '|'
from dual;

select to_char(1237, 'L9999')
from dual;

-- ����: <�̸�> earns <$,����> monthly but wants <$,���� x 3>. �� ��ȸ�϶�. <>���� earns���
select last_name || ' earns '||
to_char(salary, 'fm$9,999,999')||
' monthly but wants ' ||
to_char(salary * 3, 'fmL9,999,999') ||
'.'
from employees;

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon dd, yyyy'); --to_date(����, ���)

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon  dd yy');

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'fxMon  dd yy'); --fx�ϴ� ������

select to_number('1237')
from dual;

select to_number('1,237.12') --����
from dual;

select to_number('1,237.12', '9,999.99') --���� �˷��ִ� �����ȳ�
from dual;

select nvl(null, 0) 
from dual;

select job_id, nvl(commission_pct, 0) --nvl�Լ��� �Ķ���� Ÿ���� ���ƾ��� �ϳ��� Į���̱⶧��
from employees;

-- ����: ������� �̸�, ����, ������ ��ȸ�϶�.
select last_name, job_id, salary * 12 + (salary * 12 * nvl(commission_pct, 0))
from employees;

-- ��
select last_name, job_id, salary * (1 + nvl(commission_pct, 0)) * 12 ann_sal
from employees
order by ann_sal desc;
--
--����: ������� �̸�, Ŀ�̼����� ��ȸ�϶�.
-- Ŀ�̼��� ������, No Commision �� ǥ���Ѵ�.
select last_name,nvl(to_char(commission_pct), 'No Commision')
from employees;

--��
select last_name, nvl(to_char(commission_pct), 'no Commission')
from employees;
--

select job_id, nvl2(commission_pct, 'SAL+COMM', 'SAL') income --nvl(�Ķ�, true, false)retrun
from employees;

select job_id, nvl2(commission_pct, 'SAL+COMM', 0) income --�̶� -�� ����
from employees;

select first_name, last_name,
    nullif(length(first_name), length(last_name)) --nullif(a, b)a = b�̸� return null �ƴϸ� return a
from employees;

--null�� Ÿ���� �׳� null�̸� ĳ���� �ѹ� �ٵ�

select to_char(null), to_number(null), to_date(null)
from dual;

select last_name, job_id,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None') -- �տ������� ���ؼ� null�̳���� none��ȯ�� ����
from employees;

select last_name, salary,
    decode(trunc(salary / 2000), --decode(a, .., �⺻��) a���� 0�̸� 0.00 1�̸� 0.09 ������ �⺻��
        0, 0.00,
        1, 0.09,
        2, 0.20,
        3, 0.30,
        4, 0.40,
        5, 0.42,
        6, 0.44,
        0.45) tax_rate
from employees
where department_id = 80;

select decode(salary, 'a', 1) --decode �⺻�� null
from employees;

select decode(salary, 'a', 1, 0) dede -- salary�� ����ȯ�Ǿ� ���ڰ��ǰ� 'a'�� ���� 0�� ����
from employees;

select decode(job_id, 1 ,1)
from employees;

-- ����: ������� ����, ������ ����� ��ȸ�϶�.
--      �⺻ ����� null �̴�.
--      IT_PROG   A
--      AD_PRES   B
--      ST_MAN    C
--      ST_CLERK  D
select job_id, decode(job_id, 'IT_PROG', 'A',
    'AD_PRES', 'B',
    'ST_MAN', 'C',
    'ST_CLERK', 'D', null) ranking
from employees
order by ranking;
--��
select job_id, decode(job_id,
    'IT_PROG', 'A',
    'AD_PRES', 'B',
    'ST_MAN' , 'C',
    'ST_CLERK', 'D') grade
from employees;
--

select last_name, job_id, salary,
    case job_id when 'IT_PROG' then 1.10 * salary
                when 'AD_PRES' then 1.05 * salary
    else salary end revised_salary
from employees;

select case job_id when '1' then 1
                    when '2' then 2
                    else 0
                    end grade
from employees;

select case job_id when '1' then 1 --���� Ÿ���� �� ���ƾ��� case ������ when ��
                    when '2' then 2
                    else 0
                    end grade
from employees;

select case salary when 1 then '1' 
                    when 2 then '2'
                    else '0'
                    end grade
from employees;

select last_name, salary,
    case when salary < 5000 then 'low' --���������� ���ʷ� ����Ѵ� case ���̾����� case when ����
        when salary < 10000 then 'medium'
        when salary < 20000 then 'high'
        else 'good'
        end grade
from employees;

-- ����: ������� �̸�, �Ի���, �Ի���Ϻ��� ���ϼ����� ��ȸ�϶�.
select last_name, hire_date, 
    case 
        when to_char(hire_date, 'd') = 2 then 'mon'
        when to_char(hire_date, 'd') = 3 then 'tues'
        when to_char(hire_date, 'd') = 4 then 'wen'
        when to_char(hire_date, 'd') = 5 then 'thues'
        when to_char(hire_date, 'd') = 6 then 'fri'
        when to_char(hire_date, 'd') = 7 then 'sat'
        when replace(to_char(hire_date, 'd'), 1, 8) = 8 then 'sun'
         end dayday
from employees
order by replace(to_char(hire_date, 'd'), 1, 8);
--��
select last_name, hire_date, to_char(hire_date, 'fmday') day
from employees
order by case day
            when 'monday' then 1
            when 'tuesday' then 2
            when 'wednesday' then 3
            when 'thursday' then 4
            when 'friday' then 5
            when 'saturday' then 6
            when 'sunday' then 7
            end;
--
--����: 2005�� ������ �Ի��� ����鿡�� 100���� ��ǰ��,
--����: 2005�� �Ŀ� �Ի��� ����鿡�� 10���� ��ǰ���� �����Ѵ�.
-- ������� �̸�, �Ի���, ��ǰ�� �ݾ��� ��ȸ�϶�.
select last_name, hire_date, case when to_char(hire_date, 'YYYY') <= 2005 then '100������ǰ��'
                when to_char(hire_date, 'YYYY') > 2005 then '10������ǰ��'
                end
from employees;
--��
select last_name, hire_date,
    case when hire_date <= '2005/12/31' then '100����'
        else '10����' end gift
from employees
order by gift, hire_date;
--