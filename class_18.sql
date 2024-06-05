use employees;

-- employees
-- 의미 있는 결과 집합을 만들자.(cross join 사용X)
-- 단, inner join, left join, right join 사용해서 쿼리문 만들기

select * from employees;

-- 문제 
-- 임직원의 번호와 이름, 성별, 입사 날짜와 퇴사 날짜를 조회하시오.
select e.emp_no, e.first_name, e.gender, d.from_date, d.to_date
from dept_emp as d
inner join employees as e
on d.emp_no = e.emp_no;

-- 가장 많은 연봉을 받은 임직원의 번호, 이름, 성별을 조회하시오. 
select em.emp_no, em.first_name, em.gender, max(salary) as salary
from employees as em
join salaries as s
on em.emp_no = s.emp_no;

select *
from departments as de
left join dept_emp as em
on de.dept_no = em.dept_no;

select e.first_name, s.from_date, s.to_date, s.salary
from employees as e
join salaries as s
on e.emp_no = s.emp_no
And e.first_name = 'Chirstian';