use mydb2;
select * from employee;

insert into employee values(6,'홍길동', 'IT', '4000000.00', now());

-- 1일 1쿼리
select * from dept_emp;
select * from dept_manager;
select * from employees;

-- 현재 재직 중인 임직원 중 부서 매니저가 있는 임직원을 조회하시오.(부서 번호, 직원의 번호, 이름, 성, 고용일)  
select m.dept_no, e.emp_no, e.first_name, e.last_name, m.from_date, m.to_date
from employees as e
join dept_manager as m
on m.emp_no = e.emp_no
group by e.emp_no
having m.to_date = '9999-01-01';





