--group function row가 그룹을 이룸
select round(avg(salary), 2), max(salary), min(salary), sum(salary)
from employees;

select min(hire_date), max(hire_date) --날짜타입은 실제로없고 보이는형식은 문자 실제 db의 데이터는 숫자
from employees;

--과제: 최고월급과 최소월급의 차액을 조회하라.
select max(salary) - min(salary)
from employees;

select count(*) --count는 row의 갯수를 구하며 *의 의미는 모든 칼럼을 의미한다.
from employees;

-- 과제: 70번 부서원이 몇명인 지 조회하라.
select count(*)
from employees
where department_id = 70;
--

select count(employee_id)
from employees;

select count(manager_id) --그룹 함수의 특징은 null값을 무시한다. primary로 지정된 칼럼을 쓰는게 좋다 왜냐 null값이 없기때문
from employees;

select avg(commission_pct) --영업사원의 commission의 평균이다.
from employees;

-- 과제: 조직의 평균 커미션율을 조회하라.
--답
select avg(nvl(commission_pct, 0))
from employees;
--

select avg(all salary) --all 생략된 기본값
from employees;

select avg(distinct salary) -- distinct 중복제거
from employees;

--과제: 직원이 배치된 부서 개수를 조회하라.
select count(distinct department_id)
from employees
where employee_id is not null;

--답
select count(distinct department_id)
from employees;
--

-- 과제: 매니저 수를 조히하라.
select count(distinct manager_id)
from employees;
--

select department_id, count(employee_id) 
from employees
group by department_id --count group function이기떄문에 그룹화시켜줘야한다. depart는 그룹이 아니고 count는 그룹이기떄문
order by department_id;-- 그룹의 제목이라고 생각하면 편하다.

select employee_id
from employees
where department_id = 30;

select department_id, job_id, count(employee_id)
from employees
group by department_id, job_id
order by department_id;

-- 과제: 직원별 사원수를 조회하라.
select job_id, count(employee_id)
from employees
group by job_id
order by count(employee_id);
--답
select job_id, count(employee_id)
from employees
group by job_id;
--

select department_id, max(salary)
from employees
group by department_id
having department_id > 50; --그룹의 조건문

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000;

select department_id, max(salary) max_sal
from employees
group by department_id
having max_sal > 10000; --에러

select department_id, max(salary)
from employees
where department_id > 50
group by department_id;

select department_id, max(salary)
from employees
where max(salary) > 10000 -- where에 그룹못씀
group by department_id;

select job_id, sum(salary) payroll
from employees
where job_id not like '%REP%'
group by job_id
having sum(salary) > 13000
order by payroll;

--과제: 매니저ID, 매니저별 관리 직원들 중 최소월급을 조회하라.
--        최소월급이 $6,000 초과여야 한다.
select manager_id, min(salary) minsal
from employees
where manager_id is not null
group by manager_id
having min(salary) > 6000
order by 2 desc;
-- 답 
select manager_id, min(salary) minsal
from employees
where manager_id is not null
group by manager_id
having min(salary) > 6000
order by 2;

select  max(avg(salary))
from employees; --에러

select  max(avg(salary))
from employees
group by department_id; --해결

select sum(max(avg(salary))) --오류 그룹함수는 최대 2번
from employees
group by department_id;

select department_id, round(avg(salary))
from employees
group by department_id;

select department_id, round(avg(salary))
from employees; --에러

-- 과제: 2001년, 2002년, 2003년도별 입사자 수를 조회하라.
select  to_char(hire_date, 'YYYY') , count(last_name) count
from employees
where  to_char(hire_date, 'YYYY') between 2001 and 2003
group by to_char(hire_date, 'YYYY')
order by 1;
--답 A
select to_char(hire_date, 'yyyy') hire_year, count(*) emp_cnt
from employees
where to_char(hire_date, 'yyyy') in (2001, 2002, 2003)
group by to_char(hire_date, 'yyyy')
order by hire_year;
--답 B
select sum(decode(to_char(hire_date, 'yyyy'), '2001', 1, 0)) "2001",
    sum(decode(to_char(hire_date, 'yyyy'), '2002', 1, 0)) "2002",
    sum(decode(to_char(hire_date, 'yyyy'), '2003', 1, 0)) "2003"
from employees;
--답 C
select count(case when hire_date like '2001%' then 1 else null end) "2001",
            count(case when hire_date like '2002%' then 1 else null end) "2002",
            count(case when hire_date like '2003%' then 1 else null end) "2003"
from employees;
--

--과제: 직업별, 부서별 월급합을 조회하라.
-- 부서는 20, 50, 80이다.
select job_id, sum(case when department_id = 20 then salary end) "20",
                        sum(case when department_id = 50 then salary end) "50",
                        sum(case when department_id = 80 then salary end) "80"
from employees
where department_id in (20, 50, 80)
group by  job_id
order by 1;
--답
select job_id, sum(decode(department_id, 20, salary)) "20",
            sum(decode(department_id, 50, salary)) "50",
            sum(decode(department_id, 80, salary)) "80"
from employees
group by job_id;
--
