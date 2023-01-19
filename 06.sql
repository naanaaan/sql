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
using (location_id)
where d.location_id = 1400; --에러

select l.city, d.department_name, d.location_id --에러       
from locations l  join departments d
using (location_id)
where location_id = 1400;