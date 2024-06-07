
select * from dept_emp;

-- 부서별 직원 수를 추출
select *, count(emp_no) as '부서별 직원 수' from dept_emp
group by dept_no;

select * from employees;

-- first_name의 끝 3글자 까지만 결과 집합으로 출력하세요. 
select right(Upper(first_name), 3) as '이름' from employees;

-- 1일 1쿼리 
-- 각 부서별 매니저의 평균 근무 년차를 출력하시오. 
select dept_name, avg(year(current_date) - year(from_date) +1) as '평균 근무년차'
from dept_manager
join departments
on departments.dept_no = dept_manager.dept_no
group by dept_name;

desc dept_manager;

