--list와 set차이는 set는 중복된 값 허용 x 와이 list는 키가 있어서 중복된 값 구분 가능
--set은 key없음 -java말하는거임

select employee_id, job_id
from employees
union

select employee_id, job_id
from job_history; --union써서 두개가 합쳐짐
--전제조건은 테이블 구조, 데이터타입(칼럼달라도 상관없음 데이터타입이중요),
--중복된 로우 없음
select employee_id, job_id
from employees
union all 

select employee_id, job_id
from job_history
order by employee_id;

-- 과제: 과거 직업을 현재 갖고 있는 사원들의 사번, 이름, 직업을 조회하라.
select employee_id, last_name, job_id
from employees e
where exists (select *
                                        from job_history j
                                        where e.employee_id = j.employee_id
                                        and e.job_id = j.job_id); --답맞춤~
--답1
select employee_id, last_name, job_id
from employees e
where exists (select *
                                        from job_history j
                                        where e.employee_id = j.employee_id
                                        and e.job_id = j.job_id);
--답2
select employee_id, last_name, job_id
from employees e
where e.job_id in (select job_id
                                        from job_history j
                                        where e.employee_id = j.employee_id);
--답3
select e.employee_id, e.last_name, e.job_id
from employees e, job_history j
where e.employee_id = j.employee_id
and e.job_id = j.job_id;
--

select location_id, department_name --첫쿼리 칼럼을 중심으로 단 데이터타입 같아야 함
from departments
union
select location_id, state_province
from locations;  --피지컬하게는 상관없지만 로지컬하게는 좋지않다 업무상에선 별로임

--과제: 위 문장을 service 관점에서 고쳐라.
--        union 을 사용한다.
select location_id, department_name
from departments
union
select location_id, state_province
from locations;
--답
select location_id, department_name, null state
from departments
union
select location_id, null, state_province
from locations;
--

select employee_id, job_id, salary
from employees
union
select employee_id, job_id, 0 --0으로채움
from job_history
order by salary;