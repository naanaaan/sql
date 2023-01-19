select hire_date
from employees
where hire_date = '2003/06/17'; --캐릭터가 date로 변환

select salary
from employees
where salary = '7000';  --캐릭터가 number로 변환

select hire_date || ''
from employees; -- date가 캐릭터로 변환

select salary || ''
from employees; -- number가 캐릭터로 변환

select to_char(hire_date)
from employees; --to_char로 다 캐릭터로 변환

select to_char(sysdate, 'yyyy-mm-dd')
from dual;  --지정한 형식으로 변환

select to_char(sysdate, 'YEAR MONTH DDsp Day(DY)')
from dual;

select to_char(sysdate, 'Year Month Ddsp Day(Dy)')
from dual;

select to_char(sysdate, 'd')
from dual; --요일을 인덱스로 전환;

select last_name, hire_date,
    to_char(hire_date, 'day'),
    to_char(hire_date, 'd')
from employees;

-- 과제: 위 테이블을 월요일부터 입사일순 오름차순 정렬하라.

select last_name, hire_date,
    to_char(hire_date, 'day'),
   replace(to_char(hire_date, 'd'), '1', '8')
from employees
order by 4, 1;

--답
select last_name, hire_date,
    to_char(hire_date, 'day') day
from employees
order by to_char(hire_date - 1, 'd');
--

select to_char(sysdate, 'hh24:mi:ss am')
from dual;

select to_char(sysdate, 'DD "of" Month')
from dual;

select to_char(hire_date, 'fmDD Month YY') --fm을 추가하면 공간이 압축된다. fill mode
from employees;

-- 과제: 사원들의 이름, 입사일, 인사평가일을 조회하라.
--      인사평가일은 입사한 지 3개월 후 첫번째 월요일 이다.
--      날짜는 YYYY.MM.DD 로 표시한다.
select last_name, hire_date, to_char(next_day(add_months(hire_date, 3),'mon'), 'YYYY.MM.DD') eva
from employees;
--답
select last_name, to_char(hire_date, 'YYYY.MM.DD'),
    to_char(next_day(add_months(hire_date, 3),'mon'), 'YYYY.MM.DD')
from employees;
--

select to_char(salary)
from employees;

select to_char(salary, '$99,999.99'), to_char(salary, '$00,000.00') --두개차이는 0은 값이없으면 0이라도채움
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

-- 과제: <이름> earns <$,월급> monthly but wants <$,월급 x 3>. 로 조회하라. <>변수 earns상수
select last_name || ' earns '||
to_char(salary, 'fm$9,999,999')||
' monthly but wants ' ||
to_char(salary * 3, 'fmL9,999,999') ||
'.'
from employees;

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon dd, yyyy'); --to_date(변수, 양식)

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon  dd yy');

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'fxMon  dd yy'); --fx하니 에러남

select to_number('1237')
from dual;

select to_number('1,237.12') --에러
from dual;

select to_number('1,237.12', '9,999.99') --형식 알려주니 에러안남
from dual;

select nvl(null, 0) 
from dual;

select job_id, nvl(commission_pct, 0) --nvl함수는 파라미터 타입이 갔아야함 하나의 칼럼이기때문
from employees;

-- 과제: 사원들의 이름, 직원, 연봉을 조회하라.
select last_name, job_id, salary * 12 + (salary * 12 * nvl(commission_pct, 0))
from employees;

-- 답
select last_name, job_id, salary * (1 + nvl(commission_pct, 0)) * 12 ann_sal
from employees
order by ann_sal desc;
--
--과제: 사원들의 이름, 커미션율을 조회하라.
-- 커미션이 없으면, No Commision 을 표시한다.
select last_name,nvl(to_char(commission_pct), 'No Commision')
from employees;

--답
select last_name, nvl(to_char(commission_pct), 'no Commission')
from employees;
--

select job_id, nvl2(commission_pct, 'SAL+COMM', 'SAL') income --nvl(파라, true, false)retrun
from employees;

select job_id, nvl2(commission_pct, 'SAL+COMM', 0) income --이때 -은 숫자
from employees;

select first_name, last_name,
    nullif(length(first_name), length(last_name)) --nullif(a, b)a = b이면 return null 아니면 return a
from employees;

--null의 타입은 그냥 null이며 캐릭터 넘버 다됨

select to_char(null), to_number(null), to_date(null)
from dual;

select last_name, job_id,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None') -- 앞에서부터 비교해서 null이나요면 none변환후 멈춤
from employees;

select last_name, salary,
    decode(trunc(salary / 2000), --decode(a, .., 기본값) a값이 0이면 0.00 1이면 0.09 마지막 기본값
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

select decode(salary, 'a', 1) --decode 기본값 null
from employees;

select decode(salary, 'a', 1, 0) dede -- salary가 형변환되어 문자가되고 'a'와 비교후 0을 리턴
from employees;

select decode(job_id, 1 ,1)
from employees;

-- 과제: 사원들의 직업, 직원별 등급을 조회하라.
--      기본 등급은 null 이다.
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
--답
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

select case job_id when '1' then 1 --값의 타입이 다 같아야함 case 변수와 when 값
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
    case when salary < 5000 then 'low' --위에서부터 차례로 계산한다 case 값이없을때 case when 조건
        when salary < 10000 then 'medium'
        when salary < 20000 then 'high'
        else 'good'
        end grade
from employees;

-- 과제: 사원들의 이름, 입사일, 입사요일부터 요일순으로 조회하라.
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
--답
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
--과제: 2005년 이전에 입사한 사원들에게 100만원 상품권,
--과제: 2005년 후에 입사한 사원들에게 10만원 상품권을 지급한다.
-- 사원들의 이름, 입사일, 상품권 금액을 조회하라.
select last_name, hire_date, case when to_char(hire_date, 'YYYY') <= 2005 then '100만원상품권'
                when to_char(hire_date, 'YYYY') > 2005 then '10만원상품권'
                end
from employees;
--답
select last_name, hire_date,
    case when hire_date <= '2005/12/31' then '100만원'
        else '10만원' end gift
from employees
order by gift, hire_date;
--