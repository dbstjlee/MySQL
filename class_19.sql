
use employees;
-- 테이블 복사(구조만 복사)
create table dept_emp_copy -- 복사 테이블
as select * from dept_emp -- 기본 테이블
where 1 = 0; -- 데이터를 안 가져오고 컬럼 구조만 복제

select * from dept_emp_copy;
desc dept_emp_copy;

create table employees_copy
as select * from employees;
select * from  employees_copy;

-- 제약사항은 복사되지 않으므로 alter로 추가해야 함. 

delete from dept_emp_copy;
insert into dept_emp_copy(emp_no, dept_no, from_date, to_date)
select emp_no, dept_no, from_date, to_date
from dept_emp
where emp_no > 20001;