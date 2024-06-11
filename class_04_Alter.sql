-- 데이터베이스 생성
create database mydb;
-- 데이터베이스 사용 지정
 use mydb;
 
 -- 학생 테이블 생성
 create table student(
	student_id int,
    name varchar(50) not null,  
    -- varchar : 최대 50글자까지 가능. 동적으로 줄었다가 늘었다가 함.(ex..3글자 들어오면 3칸으로 줄어듬.)
    grade int not null, 
    major varchar(50) not null
 );
 
 select * from student;
 desc student; -- 제약사항 확인
 
 -- 과목 테이블 생성
 create table subject(
	subject_id int, 
    subject_name varchar(50) not null, 
    credit int not null, -- credit : 학점
    department varchar(5), 
    professer char(50) not null
 );
 
 select * from subject;
 
-- 이미 생성된 테이블에 기본키를 추가하는 방법
alter table student add primary key(student_id);  
-- alter : 변경한다는 의미
 desc student; 
-- 사전 기반 지식
-- 데이터가 들어가 있는 상태에서 빈 값이 포함되어 있다면 기본키(primary key)를 추가할 수 없다. 
-- 즉, Null 값이 있어서는 안된다.
 
 alter table subject add primary key(subject_id);
 desc subject;
 
 -- 주문(order)
 -- row  --> id를 pk로 설정
 -- 고객 주문 내용(요구사항) - 문자
 -- 상품 이름
 -- 상품 가격
 -- 수량 
 
 -- 예약어는 기본적으로 테이블 이름을 선점할 수 없다. 
 -- 하지만 강제적으로 `` (작은 따옴표)를 사용해서 테이블 이름이라고 명시할 수 있다. 
 -- ``(1번 키의 왼쪽 키: 백틱) -> 예약어가 아니라 명칭이라고 알림. create, table은 예약어임. 
  create table `order`(
	id int primary key,
    price bigint,
    customer_order varchar(50),
    product_name varchar(20) not null,
    quantity int not null,
    order_date date not null
  ); 
  select * from `order`;
 desc `order`;
 
 -- 도전과제 : 위 형식에 맞는 insert를 진행하세요. 
 insert into `order`(id, price, customer_order, product_name, quantity, order_date)
 values (1, 15000, 'or123', '청바지', 3, '2024-05-30');
 
select * from `order`;
 
 -- 도전과제 1
 create table employee(
	employee_id int primary key,
    employee_name varchar(50) not null,
    age int,
    department varchar(50)
 );
 desc employee;
 
  -- 도전과제 2
 create table customer(
	customer_id int,
    customer_name varchar(50) not null,
    email varchar(50),
    address varchar(50) not null,
    primary key(customer_id)
 );
 desc customer;