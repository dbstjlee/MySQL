-- 집계 함수 문제

-- 문제 1 : 모든 직원의 평균 급여를 계산하세요. 
-- 단, 주의 AVG()  평균의 합계와 다른 컬럼을 적는다면 관계가 없는 데이터 결과를 집합니다. 
-- (name 추가 입력 시 제일 위의 이름만 출력됨 - 데이터가 옳지 않음)
select AVG(salary) from employee;
select AVG(salary), name, id from employee;
-- 연산된 결과 집합 (기본 타입인 double 형식이 들어옴.)

-- 문제 2: 각 부서별로 직원 수를 세고, 부서별 급여의 합을 계산하세요.
-- 부서별, 부서별 직원수, 부서별 직원수의 급여의 합계 금액
-- 그룹화 시켜야 한다. 
select department, count(*) as '직원 수', sum(salary) as '급여'
from employee
group by department; -- 부서별로 그룹화 시킴.


-- 문자열 함수 문제

-- 문제 3 : 모든 직원의 이름을 대문자로 변환하고, 이름 앞에 "Mr/Ms'를 추가하세요.
-- concat() : 두 개 이상의 문자열을 하나로 결합
-- upper() : 문자열을 전부 대문자로 변환 
select concat('Mr/Ms', upper(name)) as '이름' from employee;

-- 문제 4 : 직원 이름에서 첫 2글자만 추출하세요.
-- substring() : 문자열의 특정 부분을 추출 
-- substring(컬럼명, 첫번째 글자에서, 2글자만)
select substring(name, 1, 2) as '이름' from employee;

-- 문제 4-1 : 직원 이름에서 끝 2글자만 추출하세요.
select substring(name, 2, 2) as '이름'from employee;
select right(Upper(name), 2) as '이름' from employee;


-- 논리 및 조건 함수 문제

-- 문제 5 : 각 직원에 대한 급여가 3백만원 이상이면 'HIGHT', 'LOW"라고 표시하시오. 
select name, salary, 
case when salary >= 3000000 
then 'HIGHT' else 'LOW' 
end as '평가'
-- case when ~ 이 연산이 true라면 then 'HIGHT' 그렇지 않으면 'LOW' end (구문의 끝)
from employee;

-- 날짜 및 시간 함수 문제

-- 문제 6 : 오늘 날짜를 반환하세요. (from 사용 안 함)
select current_date as today;
select '안녕 반가워' as a;

-- 문제 7 : 각 직원이 고용된 날로부터 몇 년이 지났는지 계산하세요. 
-- 식: 오늘 날짜 - 고용일자 = 몇 년차
select name, hire_date, 
year(current_date) - year(hire_date) as '근무년도'
from employee; 

select name, hire_date, 
(year(current_date) - year(hire_date)) + 1 as '년차'
from employee; 

-- 문제 8 : 각 직원의 고용 월을 반환하세요.
-- extract() : 날짜나 시간에서 특정 부분을 추출
select name, extract(month from hire_date) as hire_month
from employee; 

-- 문제 9 : 각 직원의 급여를 문자열 형태로 표시하세요.
-- cast() : 형변환 함수(문자 -> 숫자 or 날짜 -> 숫자)
-- decimal 을 char로 형변환
select name, cast(salary as char) as salary_text
from employee;

-- 문제 10 : 문자열로 저장된 날짜 '2024-06-07'을 Date 타입으로 변환하세요.
select cast('2025-06-07' as DATE) as date;

select * from employee;