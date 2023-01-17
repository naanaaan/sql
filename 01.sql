select *
from departments;

select department_id, location_id
from departments;

select location_id, department_id
from departments;

desc departments 
--위는 언어가 아니라 커맨드이다.

select last_name, salary, salary + 300
from employees;

--과제: 사원들의 월급, 연봉을 조회하라.
desc employees;
select salary, salary * 12
from employees;

select last_name, salary, 12 * salary + 100
from employees;

select last_name, salary, 12 * (salary + 100)
from employees;

select last_name, job_id, commission_pct
from employees; --job_id의 풀네임을 알고 싶으면 테이브 jobs의 데이터들어 가면 있음

select last_name, job_id, 12 * salary + (12 * salary * commission_pct)
from employees; --expression에 null값이 있으면 null이다.

select last_name as name, commission_pct comm --as생략가능 칼럼 이름 별명 정함
from employees;

select last_name "Name", salary * 12 "Annual Salary"
from employees; --대소문자 구분이 안되어 "를 써서 원하는 대로 칼럼을 만들어준다.

--과제: 사원들의 사번, 이름 , 직업, 입사일(STARTDATE)을 조회하라.
desc employees
select employee_id, last_name, job_id, hire_date startdate
from employees;
--과제: 사원들의 사번(Emp #), 이름(Name), 직업(Job), 입사일(Hire Date)를 조회하라.
select employee_id "Emp #", last_name "Name", job_id "Job", hire_date "Hire Date"
from employees;

select last_name || job_id --붙이기 연산자
from employees;

select last_name || ' is ' || job_id --job_id는 변수
from employees;
--'는 상수를 의미한다

select last_name || ' is ' || job_id employee
from employees;

select last_name || null
from employees;

select last_name || commission_pct --데이터타입을 바꿈 넘버를 캐릭터로(last_name)0
from employees;

select last_name || salary
from employees;

select last_name || hire_date
from employees;  -- date타입이 캐릭터타입으로

select last_name || (salary * 12)
from employees;

-- 과제: 사원들의 '이름, 직업'(Emp and Title)을 조회하라.
select last_name || ', ' ||job_id "Emp and Title"
from employees;