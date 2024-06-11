-- 사용자 생성하기 (비밀번호 함께 설정)

-- 사용자 계정 생성은 (원격지, 로컬 환경)이 있다. 

-- 원격지에서 접근하는 사용자 계정 생성
-- 루트 권한을 제외하고 비밀번호 설정에 대한 제약이 있을 수 있다. 
-- 구분값 : @
-- % : 원격
-- identified by 뒤에 비밀번호
create user 'tenco1'@'%' identified by '1q2w3e4r5t!';

-- localhost에서 접근 가능한 계정 생성
create user 'tenco1'@'localhost' identified by '1q2w3e4r5t!';

-- => 원격에서든 로컬에서든 쓸 수 있게 만듦.

-- 사용자 계정 권한 확인
show grants for 'tenco1'@'%';
show grants for 'tenco1'@'localhost';

-- 작업별 권한 할당
grant select, update, delete on mydb2.* to 'tenco1'@'%';
grant select, update, delete on mydb2.* to 'tenco1'@'localhost';

-- root 권한으로 새로운 사용자 생성 및 권한 할당
-- 권한 바로 적용하기(세션 종료 후에 재접속하면 적용됨.)
flush privileges;

-- 현재 나의 RDBMS에 연결되어 있는 세션을 확인하는 명령어
show processlist;

use mydb2;
show grants for 'tenco2'@'localhost';
select * from tb_class;

-- root 계정에서 insert 권한을 주지 않음(오류 코드 : 1142 발생)
insert into tb_class values(2024, 'db', '야스오');
-- update, delete

-- 문제 1 : 새로운 계정 tenco2를 생성하고 각 조장이 사용하고 있는 
-- RDBMS에 tenco2라는 계정으로 접근해보세요. 

-- tip : 응용 코드에서 쿼리 장성 시에는 무조건 여기서 실행한 후에 넣자.
-- ctrl + B: edit > format > beutiful query 
SELECT * FROM employee;

-- 1일 1쿼리
-- 각 부서별 최대 연봉과 연봉이 가장 많은 매니저의 번호를 조회하시오. 
select dept_name, truncate(Max(salary), 0) as '최대 연봉', dept_manager.emp_no as '매니저 번호'
from departments
join dept_manager 
on departments.dept_no = dept_manager.dept_no
join salaries
on dept_manager.emp_no = salaries.emp_no
group by dept_name;