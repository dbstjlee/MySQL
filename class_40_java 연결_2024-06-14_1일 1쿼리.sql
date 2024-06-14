-- 데이터베이스 생성
create database quizdb;
use quizdb;

create table quiz(
	id int auto_increment primary key,
    question varchar(500) not null,
    answer varchar(500) not null
);

desc quiz;

-- 기본 샘플 데이터 입력
insert into quiz(question, answer) 
values('대한민국의 수도는?', '서울'),
('한반도의 남쪽에 위치한 나라는?', '대한민국'),
('세계에서 가장 높은 산은?', '에베레스트'),
('태양계의 세 번째 행성은?', '지구'),
('한국의 전통 명절 중 하나로, 음력 8월 15일에 해당하는 날은?', '추석'),
('임진왜란 종전 년도는?', '1598'),
('고기압과 저기압에서 바람이 부는 방향은?', '고기압');

select * from quiz;
select distinct(question), answer from quiz order by rand() limit 1;

-- order by rand()
-- 랜덤으로 출력

-- distinct : 중복 제거

-- 1일 1쿼리
select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles; 

-- Development 부서에서 재직중인 매니저인 직원의 최대 연봉을 조회하시오. (직원 번호, 이름, 부서명, 최대 연봉)
select sa.emp_no, em.first_name, de.dept_name, Max(sa.salary) as max_salary
from salaries as sa
join dept_manager as ma
on sa.emp_no = ma.emp_no and ma.to_date = '9999-01-01'
join employees as em
on em.emp_no = ma.emp_no
join departments as de
on de.dept_no = ma.dept_no and dept_name = 'Development'
group by sa.emp_no;

select avg(salary) from salaries; -- 6381.07448 전체 급여 평균

-- 자신의 평균급여가 전체의 평균급여보다 많은 사원을 랜덤으로 10명 출력하시오.(사원 번호, 성, 이름, 평균 급여)
select e.emp_no, e.first_name, e.last_name , avg(salary)
from employees as e
join salaries as s on e.emp_no = s.emp_no
group by e.emp_no
having avg(salary) >= (select avg(salary) from salaries)
order by rand()
limit 10;

select * from salaries where emp_no = '10007';
select avg(salary) from salaries where emp_no = '10007'; -- 52431.5882 자신의 급여의 평균
