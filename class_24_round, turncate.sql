use mydb3;
CREATE TABLE tb_employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary INT NOT NULL
);

INSERT INTO tb_employeestb_employees (name, department, salary) VALUES
('John Doe', 'Sales', 48000000),
('Jane Smith', 'Sales', 55000000),
('Alice Johnson', 'Marketing', 50000000),
('Chris Lee', 'Marketing', 45000000),
('Bob Brown', 'HR', 35000000),
('Patricia Pink', 'HR', 40000000),
('Michael White', 'Engineering', 75000000),
('Anna Black', 'Engineering', 65000000),
('Linda Green', 'Engineering', 72000000),
('James Red', 'Engineering', 68000000),
('Larry Blue', 'Sales', 52000000),
('Jessica Purple', 'Sales', 51000000),
('Amber Yelow', 'Marketing', 47000000),
('Peter Orange', 'HR', 43000000),
('Lisa Teal', 'HR', 39000000);

-- 추가 설명
-- round(숫자, 반올림할 자릿수) : 자릿수까지 적고 반올림
-- turncate(숫자, 버릴 자릿수): 자릿수까지 적고 버리기

-- 문제 1 : 각 부서별 평균 급여를 계산하시오. (단 소수점은 제거)
select department, round(avg(salary)) as 평균급여
from tb_employees
group by department;

-- 문제 2 : 평균 급여가 50000000 이상인 부서를 출력하시오.
select department, truncate(avg(salary) , 0) as 평균급여
from tb_employees
group by department
having 평균급여 >= 50000000;

-- 문제 3 : 각 부서에서 가장 높은 급여를 출력하시오.
select department, MAx(salary)
from tb_employees
group by department;


-- 문제 4 : 근무하는 직원 수가 3명 이상인 부서를 출력하시오.
select department, count(*) as 부서인원수
from tb_employees
group by department
having 부서인원수 >= 3;

-- 문제 5 : 각 부서별 평균 급여와 직원 수를 출력하시오.
select department, avg(salary) as 평균급여, count(*) as 부서인원수
from tb_employees
group by department;

SELECT id, name, class, score
FROM tb_student
WHERE score > 80
ORDER BY score DESC
LIMIT 3; 
-- 3개 출력

-- offset에 의해 limit(3,10)
-- 앞에가 offset(시작의 위치), 뒤에가 limit(개수) 가 된다. 
-- 4번째부터(id 4) 출력함.

select id, name, class, score 
from tb_student
limit 5, 10;
-- 6부터 10개까지 출력(id 11부터 null 이라서 10까지만 출력됨.)