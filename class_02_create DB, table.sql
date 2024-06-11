-- 데이터의 집합 생성
create database db_tenco_market;

-- 사용
use db_tenco_market;

-- db 삭제 명령어
-- drop database db_denco_market; -> 데이터베이스를 통으로 삭제함. 

-- 사전 기반 지식 : mysql은 대소문자를 구별하지 않습니다. 
-- 단, 구분하는 RDBMS도 있습니다. 

-- 테이블 설계하기
-- 고객 테이블 생성
create table userTBL(
	userName char(3) not null primary key, -- 문자 3개, PK
    birthYear int not null,
    addr char(2) not null,
    mobile char(12) 
);

show tables; -- 테이블명 보기
select * from userTBL; -- 컬럼명 보기
desc userTBL; -- 테이블 설정값 보기

-- 구매 테이블 생성
create table buyTBL(
	id int not null auto_increment, 
    -- auto_increment : id 값을 컬럼의 열(세로로)에서 하나씩 자동으로 증가하여 값이 들어감.
    userName char(3) not null,
    prodName char(3) not null,
	price int not null,
    amount int,
    primary key(id), -- buyTBL 내의 컬럼명인 id라고 지정할 수 있다. -- PRI(primary key)
    foreign key(userName) references userTBL(userName) -- MUL(foreign key)
    -- 테이블명인 userTBL 내의 userName(컬럼명)을 바라보도록(참조하도록) 설계 
);

show tables; -- 테이블명 보기 
select * from buyTBL; -- 컬럼명 보기
desc buyTBL; -- 테이블 설정값 보기




