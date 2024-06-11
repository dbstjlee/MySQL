-- ctrl + s : 저장
-- ctrl + shift + s : 다른 이름으로 저장 
-- ctrl + enter : 한 줄 실행 단축키 

-- DMBS 안에 여러 개의 데이터베이스를 생성할 수 있다. 
-- 데이터 베이스 생성
CREATE DATABASE shopdb;

-- 데이터 베이스 사용 선언(Schemas에 굵은 글씨로 사용중임을 표시)
USE shopdbtb_member;

-- 주석(한줄 주석)

/*
	여러 줄 주석
*/

-- 테이블 생성
create table tb_member(
	memberID char(8) not null primary key,
	memberName char(5) not null,
	memberAddress char(20)
);

-- 테이블 구조 확인 명령어
desc tb_member;

-- 테이블 조회 명령어(DML - Data Manipulation Language) : 데이터 조작 언어
select * from tb_member; -- 결과 집합
select memberID, memberName from tb_member; 

-- 혹시나 테이블을 잘못 만들었다면 테이블 제거 명령어를 배워보자.
-- drop, update, delete 명령어는 주석을 해 두는 습관을 가지자!!
-- drop table tb_member;

-- C R U D 

-- 데이터를 입력하는 SQL(insert)
-- insert into tb_member() values (); - 기본 형태
-- 문자열 따옴표 '' , "" 구분 없이 사용 가능
INSERT INTO tb_member(memberID, memberName, memberAddress) VALUES ('M000001', '홍길동', '서울특별시강남구역삼동123-456'); 
INSERT INTO tb_member(memberID, memberName, memberAddress) VALUES ('M000002', '김철수', '서울특별시송파구잠실동789-123'); 
INSERT INTO tb_member(memberID, memberName, memberAddress) VALUES ('M000003', '이영희', '부산광역시수영구광안동456-789'); 

select * from tb_member;

-- 한번에 표기하는 방법
INSERT INTO tb_member(memberID, memberName, memberAddress) VALUES
('M000001', '홍길동', '서울특별시강남구역삼동123-456'),
('M000002', '김철수', '서울특별시송파구잠실동789-123'), 
('M000003', '이영희', '부산광역시수영구광안동456-789'); 

-- 위의 쿼리는 한번에 세 개의 레코드를 삽입하는 단일 INSERT 문입니다. 
-- INSERT 문에서 여러 개의 레코드를 한 번에 삽입하는 것은 일반적인 방법 중 하나이며, 
-- 이를 다중 행 삽입(multi-row insertion)이라고 합니다. 
-- 이렇게 하면 데이터베이스와의 통신 횟수를 줄일 수 있으므로 효율적입니다. 

-- 모든 회원 조회
SELECT * FROM tb_member;

-- 이름이 '홍길동'인 회원 조회
SELECT * FROM tb_member WHERE memberName = '홍길동';

-- 주소가 '서울특별시'인 회원 조회
SELECT * FROM tb_member WHERE memberAddress LIKE '서울특별시%';


