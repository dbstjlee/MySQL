-- 데이터 입력하기
/*
insert into usertbl(userName, birthYear, addr, mobile)
 values ('이승기', 1987, '서울', '011-111-1111');
*/

-- userTBL 데이터 한번에 입력 
insert into usertbl(userName, birthYear, addr, mobile)
 values ('이승기', 1987, '서울', '011-111-1111'),
		('김경호', 1971, '전남', '019-333-3333'),
		('윤종신', 1969, '경남', ''),
		('임재범', 1963, '서울', '011-222-2222'),
		('은지원', 1978, '경북', '011-444-4444'),
		('조관우', 1965, '경기', '011-555-5555'),
		('김범수', 1987, '경남', '011-111-1111'),
		('조용필', 1987, '경기', '011-111-1111'),
		('바비킴', 1987, '서울', '011-111-1111'),
		('성시경', 1987, '경남', null);
        
desc usertbl;
select * from usertbl;

/*
delete from ~~ where ~~: 데이터를 삭제하는 명령어다. 
delete from usertbl where userName = '이승기'; -> 먼저 추가한 data 삭제 구문
delete from usertbl;

-- 다른 테이블로부터 참조되고 있는 테이블을 삭제하고자 한다면 
-- 테이블 삭제가 바로 안된다. (굳이 삭제하고 싶다면 참조하고 있는 테이블을 먼저 삭제해야 한다.)
-- drop table 테이블명 --
1) drop table buytbl; (참조하고 있는 테이블)
2) drop table usertbl; -- 테이블을 통으로 날림.  
=> buytbl에서 참조하고 있기 때문에 (제약) 삭제 못하도록 막고 있음.
*/

-- buyTBL 데이터 한번에 입력 
insert into buytbl(userName, prodName, price, amount)
values  ('김범수', '운동화', 30, 2),
		('김범수', '노트북', 1000, 1),
        ('조용필', '모니터', 200, 1),
        ('바비킴', '모니터', 200, 5),
        ('김범수', '청바지', 50, 3),
        ('바비킴', '메모리', 80, 10),
        ('성시경', '책', 15, 5),
        ('은지원', '책', 15, 2),
        ('은지원', '청바지', 50, 1),
        ('바비킴', '운동화', 30, 2),
        ('은지원', '책', 15, 1),
        ('바비킴', '운동화', 30, 2);

select * from buytbl;
desc buytbl;

-- 홍길동은 현재 usertbl 테이블에 존재하지 않는 값이다. 
-- 그러므로 buytbl row(행) 값으로 들어올 수 없다.(제약 때문에)
insert into buytbl(userName, prodName, price, amount)
values  ('홍길동', '운동화', 30, 2); 

-- 특정 데이터를 조회하고 싶다면 --> 필터를 건다. (WHERE)
SELECT * FROM usertbl WHERE userName = '이승기'; -- 단일행
select * from buytbl where userName = '김범수'; -- 다중행



