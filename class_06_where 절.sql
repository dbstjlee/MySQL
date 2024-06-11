use employees;
show tables;

select * from departments;
desc departments;

select * from employees; -- 대략 30만 개 보여줌. 
select * from employees limit 10; -- 30만 개 중에 10개만 제한하여 보여줌.
-- limit 를 하든 뭘 하든 30만 개를 미리 scan 했기 때문에 query cost는 이후에 limit를 걸어도 수치는 동일하다. 

-- 두 테이블 동시에 보기 (ctrl + shift로 영역 지정 후 누른 상태에서 enter)
select * from dept_emp;
select * from employees;

select * from departments;
select * from departments where dept_no = 'd005';

-- 직원과 연봉 관계 = 1 : N 관계
-- 일년 단위로 연봉 받은 기록이 출력됨. 
select * from salaries; -- 284만 개를 보여줌.
select * from salaries where emp_no= 10001; 

select * from titles; -- 직함(중복 있음) 
-- ERP : 회사의 모든 과정을 연산화시킴.(인사, 연봉 등등)