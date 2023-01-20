-- join이란 다른 테이블을 불러오는 것인데 테이블은 row들의 집합이기때문에 row들을 가져오는 것이다.
-- 두테이블의 연결선을 relationship이라고 한다. -> FK 외래키
-- 이론 0 의 ----실선은 may있을 수도 있다. 갈고리받는 쪽은 뭐뭐가 여러개 있다라고 생각하면된다.
select department_id, department_name, location_id
from departments;

select location_id,  city
from locations;

--equi join
select department_id, department_name, location_id, city
from departments natural join locations;  --양쪽테이블의 공통 칼럼을 찾는다 -> 그 칼럼에 맞는 row를 불러온다.
--위에서 1행의 location_id 1400인 것의 공통점을 찾고 뒤에 localtions의 테이블에서 location_id가 1400인 값을 가져온다.

select department_id, department_name, location_id, city
from departments natural join locations --요건 일치하는 모든 칼럼들을 조회
where department_id in (20, 50);
--
select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);  --원하는 칼럼을 조회

-- 과제: 위에서 누락된 1인의 이름, 부서번호를 조회하라.
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

select l.city, d.department_name        --별명으로 축소
from locations l  join departments d
using (location_id)
where location_id = 1400;

select l.city, d.department_name        
from locations l  join departments d
using (location_idse
where d.location_id = 1400; --에러

select l.city, d.department_name, d.location_id --에러       
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

--과제: 위 query를 using 으로 refactoring 하라.
--답
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

-- 과제: Toronto에 위치한 부서에서 일하는 사원들의
--          이름, 직업, 부서번호, 부서명, 도시를 조회하라.
select e.last_name, e.job_id, e.department_id, l.city
from employees e join locations l
on l.city = 'Toronto';

--답
select e.last_name, e.job_id, e.department_id,
    d.department_name, l.city
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
--where l.city = 'Toronto';
and l.city = 'Toronto';  --이렇게도 가능
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
on manager_id = employee_id; --에러

select worker1.last_name emp, worker2.last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id; --에러

-- 과제: 같은 부서에서 일하는 사원들의 부서번호, 이름, 동료명을 조회하라.
select worker.last_name wor, worker.department_id worD, college.last_name cle
from employees worker join employees college
on worker.department_id = college.department_id
and worker.last_name != college.last_name;
--답
select e.department_id, e.last_name employee, c.last_name clooeague
from employees e join employees c
on e.department_id = c.department_id
and e.employee_id <> c.employee_id
order by 1, 2, 3;
--

--과제: Davies 보다 후에 입사한 사원들의 이름, 입사일을 조회하라. 2005/01/29
select c.last_name, c.hire_date
from employees e join employees c
on c.hire_date > e.hire_date
where e.last_name = 'Davies'
order by 2;
--답
select e.last_name, e.hire_date
from employees e join employees d
on d.last_name = 'Davies'
and e.hire_date > d.hire_date;
--

--과제: 매니저보다 먼저 입사한 사원들의 이름, 입사일, 매니저명, 매니저 입사일을 조회하라.
select e.last_name, e.hire_date, m.last_name, m.hire_date
from employees e join employees m
on e.hire_date < m.hire_date
join departments d
on m.department_id = d.department_id
and d.manager_id = m.employee_id;
--
--답
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
select e.last_name, e.department_id, d.department_name --join되지 않는 Grant가 포함되어있음
from employees e left outer join departments d    -- 왼쪽
on e.department_id = d.department_id;

select e.last_name, e.department_id, d.department_name 
from employees e right outer join departments d  --요건 오른쪽
on e.department_id = d.department_id;

select e.last_name, e.department_id, d.department_name 
from employees e full outer join departments d --양쪽
on e.department_id = d.department_id;

-- 과제: 사원들의 이름, 사번, 매니저명, 매니저의 사번을 조회하라.
--        King 회장도 테이블에 포함하라.
select e.last_name, e.employee_id, m.last_name, m.manager_id
from employees e   join employees m
on e.manager_id = m.employee_id
order by 3;
--답
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
where e.department_id(+) = d.department_id;  --outer join 이건 rigtht

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+); -- left 

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id(+); --과거엔 full outer join이 없음

select worker.last_name || ' works for '  || manager.last_name
from employees worker, employees manager
where worker.manager_id = manager.employee_id;