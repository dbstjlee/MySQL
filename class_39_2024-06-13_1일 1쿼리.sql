-- 2024-06-13 1일 1쿼리
-- 중첩, 인라인 뷰 서브쿼리

-- Engineer 직급 중 최고 연봉을 가진 직원 5명을 조회하시오.
select t.title, e.emp_no, e.first_name, s.salary
from titles as t
join salaries as s
on t.emp_no = s.emp_no
join employees as e
on e.emp_no = t.emp_no
where t.title = 'Engineer'
order by s.salary desc
limit 5;

-- 직급이 Engineer인 현재 재직 중인 직원들의 연봉이 높은 순으로 5명 조회하시오.
-- 단, 중첩 서브쿼리와 인라인 뷰 서브쿼리를 동시에 사용하여 출력하시오. 
select emp_no, salary
from (select emp_no, salary
	  from salaries as s
      group by emp_no) as 연봉
where emp_no in (select emp_no 
                 from titles as t 
                 where title = 'Engineer' and to_date = "9999-01-01")
order by salary desc
limit 5;

select * from titles where title = 'Engineer';
select * from salaries;