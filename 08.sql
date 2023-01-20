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
