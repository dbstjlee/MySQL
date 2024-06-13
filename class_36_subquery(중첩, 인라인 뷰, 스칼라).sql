use employees;

-- 사전 데이터 확인
select * from  employees;
select * from  dept_manager
where to_date = '9999-01-01';

-- 직원 테이블에 매니저인 사원을 출력하자.
-- 중첩 서브쿼리(where 절에 사용)
select * from employees
where emp_no in
(select emp_no from dept_manager where to_date = '9999-01-01');
-- in : 포함 연산자
-- *(All) 을 출력하여 in에 담기에는 데이터가 너무 많아서 담을 수 없음.
-- 모든 dept_manager의 emp_no를 employees의 emp_no에 담는다.

-- 인라인 뷰(from 절) 사용
-- 문제 : 현재 다니고 있는 매니저들의 평균 연봉 구하기

-- 1. 사전 데이터 확인
select * from dept_manager where to_date = '9999-01-01';
select * from salaries where emp_no = 10001;

-- 2. 전체 직원의 평균 연봉, emp_no를 그룹 짓기 위해 group by 처리
select emp_no, avg(salary) as 평균연봉
from salaries as s
group by emp_no;

-- 3. 인라인 뷰 사용(from 절)
select emp_no, 평균연봉
from (select emp_no, avg(salary) as 평균연봉
       from salaries as s
       group by emp_no) as avg_salary
       where emp_no = '10001';
-- 인라인 뷰 내의 조회 컬럼을 select 와 where 절에 꺼내 쓸 수 있음.


 -- 인라인 뷰, 중첩 서브쿼리 동시 사용
 -- 재직 중인 매니저의 평균 연봉 조회
select emp_no, 평균연봉
from (select emp_no, avg(salary) as 평균연봉
       from salaries as s
       group by emp_no) as avg_salary
where emp_no in (select emp_no 
                from dept_manager 
                where to_date = '9999-01-01');
                
-- 23847.66 비용 발생

-- 위와 같은 결과 집합을 INNER JOIN을 활용해서 만들어 보자.
select s.emp_no, avg(s.salary) as 평균연봉
from salaries as s
join dept_manager as m
on s.emp_no = m.emp_no and m.to_date = '9999-01-01'
group by m.emp_no;

-- 7.21 비용 발생

-- join을 먼저 사용해보고 너무 복잡하면 서브쿼리도 생각해보자!!

-- 스칼라 서브 쿼리(select 절)
-- 각 직원의 평균 연봉 구하기
select emp_no as outer_emp_no, (select avg(salary) 
								from salaries 
                                where emp_no = outer_emp_no) as 평균연봉
from employees;