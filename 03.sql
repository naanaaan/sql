-- single function
desc dual
select * from dual;

select lower('SQL Course')
from dual;

select upper('SQL Course')
from dual;

select initcap('SQL Course')
from dual;

select last_name
from employees
where last_name = 'higgins';

select last_name
from employees
where last_name = 'Higgins';

select last_name
from employees
where lower(last_name) = 'higgins'; --db의 원자는 row last_name field값이 아닌 row값이 들어간것
--lower function의 리턴값과 'higgins'를 비교한다.

select concat('Hello', 'World')
from dual;

select substr('HelloWorld', 2, 5) --field 3개 2는 시작위치 5는 길이
from dual;

select substr('Hello', -1, 1)
from dual;

select length('Hello')
from dual;

select instr('Hello', 'l')
from dual; --index 3에 있따 뒤ㅣ은 검색안디고 끝냄

select instr('Hello', 'w')
from dual;

select lpad(salary, 5, '*') --공간 통일 5칸으로 통일후 부족한 빈칸은 *로채움
from employees;

select rpad(salary, 5, '*')
from employees;

select replace('JACK and JUE', 'J', 'BL')
from dual;  -- J를 BL로 바꿈

select trim('H' from 'Hello')
from dual;

select trim('l' from 'Hello')
from dual;

select trim(' ' from ' Hello ')
from dual;

--과제: 위 query에서 ' '가 trim 됐음을, 눈으로 확인할 수 있게 조회하라.
select '|' || trim(' ' from ' Hello ') || '|'
from dual;

select trim(' Hello World ')
from dual; -- ' '이 기본값

select employee_id, concat(first_name, last_name) name,
        job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG'; --4번인덱스부터 마지막 글자까지

-- 과제: 위 query에서, where 절을 like 로 refactoring 하라.
select employee_id, concat(first_name, last_name) name,
        job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '___PROG%';