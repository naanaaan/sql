-- subquery
select last_name, salary
from employees
where salary > (select salary
                            from employees
                            where last_name = 'Abel');
                    
select last_name, job_id, salary
from employees
where job_id = (select job_id
                            from employees
                            where last_name = 'Ernst') --하나의 로우만 가능
and salary > (select salary
                        from employees
                        where last_name = 'Ernst');
                        
--과제: Kochhar 에게 보고하는 사원들의 이름, 월급를 조회하라.
select last_name, job_id, department_id
from employees e
where e.manager_id = (select employee_id
                                        from employees
                                        where last_name = 'Kochhar');
--답
select last_name, salary
from employees
where manager_id = (select employee_id
                                    from employees
                                    where last_name = 'Kochhar');
--                               

--과제: IT부서에서 일하는 사원들의 부서번호, 이름, 직업을 조회하라.
select department_id, last_name, job_id
from employees
where department_id = (select distinct department_id
                                        from employees
                                        where job_id like 'IT%');
--답
select department_id, last_name, job_id
from employees
where department_id = (select department_id
                                        from departments
                                        where department_name = 'IT');
--

-- 과제: Abel과 같은 부서에서 일하는 동료들의 이름, 입사일을 조회하라.
--          이름 오른차순 정렬한다.
select last_name, hire_date
from employees
where department_id = (select department_id
                                        from employees
                                        where last_name = 'Abel')
and last_name <> 'Abel'
order by last_name;
--답
select last_name, hire_date
from employees
where department_id = (select department_id
                                        from employees
                                        where last_name = 'Abel')
and last_name <> 'Abel'
order by last_name;
--

select last_name, salary
from employees
where salary > (select salary
                            from employees
                            where last_name = 'King');
                            
select last_name, job_id, salary
from employees
where salary = (select min(salary)
                            from employees); --그룹인데 에러안됨 결국 리턴값은 하나기때문
                            
select department_id, min(salary)
from employees
group by department_id
having min(salary) > (select min(salary)
                                        from employees
                                        where department_id = 50);
                                        
--과제: 회사 평균 월급 이상 버는 사원들의 사번, 이름, 월급을 조회하라.
-- 월급 내림차순 정렬한다.
select employee_id, last_name, salary
from employees
where salary >= (select avg(salary)
                            from employees)
order by salary desc;                            
--답
select employee_id, last_name, salary
from employees
where salary >= (select avg(salary)
                            from employees)
order by salary desc;
--

select employee_id, last_name
from employees
where salary = (select  min(salary)
                            from employees
                            group by department_id);
--과제 위쿼리를 작동되게 만들기                            
select employee_id, last_name
from employees
where salary in (select  min(salary) --in을쓰면된다
                            from employees
                            group by department_id);
--

--과제1: 이름에 u가 포함된 사원이 있는 부서에서 일하는 사원들의 사번, 이름을 조회하라.
select employee_id, last_name
from employees
where department_id in (select department_id
                                            from employees
                                            where last_name like '%u%');
--과제2: 1700번 지역에 위치한 부서에서 일하는 사원들의 이름, 직업, 부서번호를 조회하라.
select last_name, job_id, department_id
from  employees 
where department_id in (select department_id
                                            from departments
                                            where location_id = 1700);
--

select employee_id, last_name
from employees
where salary = any (select min(salary) -- any 는 in하고 뜻이 같다. = any 연산자 두개 any 다른 연산자결합가능
                                    from departments
                                    where location_id = 1700);
                                    
select employee_id, last_name, job_id, salary
from employees
where salary < any (select salary  --여러값들중에 하나라도 참이면 참임 너저분함
                                    from employees
                                    where job_id = 'IT_PROG') 
and job_id <> 'IT_PROG';          

select employee_id, last_name, job_id, salary
from employees
where salary < all (select salary  -- all은 모든것이 참이어야함
                                    from employees
                                    where job_id = 'IT_PROG') 
and job_id <> 'IT_PROG';                             

-- 과제: 60번 부서의 일부 사원보다 월급이 많은 사원들의 이름을 조회하라.
select last_name
from employees
where salary > any (select salary
                                from employees
                                where department_id = 60)
and department_id <> 60;

--과제: 회사 평균 월급보다, 그리고 모든 프로그래머보다 월급을 더 받는
--         사원들의 이름, 직업, 월급을 조회하라.
select last_name, job_id, salary
from employees
where salary > (select avg(salary)
                            from employees)
and salary > all (select salary
                            from employees
                            where job_id = 'IT_PROG');
--답
select last_name, job_id, salary
from employees
where salary > (select avg(salary)
                            from employees)
and salary > all (select salary
                            from employees
                            where job_id = 'IT_PROG');
--

select last_name
from employees
where salary = (select salary
                            from employees
                            where employee_id = 1);
                            
select last_name
from employees
where salary in (select salary
                            from employees
                            where job_id = 'IT');
                            
select last_name
from employees
where employee_id in (select manager_id
                                        from employees);
                                        
 select last_name
from employees
where employee_id not in (select manager_id
                                        from employees);       

--과제  위를 all로 리팩토링하라
 select last_name
from employees
where employee_id <>  all(select manager_id 
                                        from employees);   
                                        
 select last_name,manager_id, employee_id
from employees;

select count(*)
from departments;

select count(*)
from departments d
where exists (select *
                            from employees e
                            where e.department_id = d.department_id); 
                        --각각의 값을 대입해보고 있으면 존재한다고 본다.

select count(*)
from departments d
where exists (select *
                            from employees e
                            where e.department_id = 240);--없으니 버림
--쓰는 예는상품테이블에서 주문한 게 있던 물건을 조회할때 쓰임

--과제: 직업을 바꾼 적이 있는 사원들의 사번, 이름, 직업을 조회하라.

--답
select employee_id, last_name, job_id
from employees e
where exists (select *
                        from job_history j
                        where e.employee_id = j.employee_id);
--

