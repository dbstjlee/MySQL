use employees;
-- emp_no 가 10011 부터 10개 출력됨. 
select * from employees
limit 10, 10;

select * from employees
limit 20, 10;

-- 31부터 40까지 출력(10개)
select * from employees
limit 30, 10;