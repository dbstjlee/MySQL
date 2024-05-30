-- 테이블을 삭제하는 명령
-- drop table student;

-- 테이블 생성 시에 default(디폴트) 값을 제약 설정하는 방법 
create table student(
	student_id int primary key, -- 명명 표기법 언더바(_) : snake case
    name varchar(50) not null,
    grade int not null,
    major varchar(50) default '미정' not null
    -- '미정' : 디폴트 값(미정이라는 문자열 값이 들어감)
);
desc student;

-- 기본 문구 모양 
-- INSERT INTO 테이블명(컬럼명1, 컬럼명2, ...) VALUES(값1, 값2, ...);
-- INSERT INTO 테이블명 VALUES(값1, 값2, ...);  - 컬럼명 생략 버전

insert into student(student_id, name, grade, major)
values(1, '홍길동', 3, '컴퓨터공학과');

-- 디폴트 제약을 사용했을 때 값을 넣는 방법 1
-- major 지우고 입력 안 하기 
insert into student(student_id, name, grade)
values(2, '김철수', 1); -- 값을 넣지 않았지만 디폴트 값으로 '미정'이 들어감. 

-- 컬럼명 생략 버전
insert into student values(3, '이영희', 4, '경영학과');
select * from student;

-- 디폴트 제약을 사용했을 때 값을 넣는 방법 2
insert into student(student_id, name, grade, major)
values(4, '야스오', 2, default);

-- delete from 구문을 사용할 때는 반드시 필터(where)를 걸자
delete from student where student_id = 4;
-- delete from student -- 테이블 데이터가 전부 날라감. 백업하지 않은 이상 복원 불가능

-- date 타입 형식을 사용할 때 연습
drop table `order`;
 create table `order`(
	id int primary key,
    customer_order varchar(50),
    product_name varchar(20) not null,
    quantity int not null,
    order_date date not null
  ); 

-- date 타입
insert into `order` values(1, '빠른 배송', '신라면', 2, '2024-05-30');
insert into `order` values(2, '느린 배송', '신라면', 3, '20240530');
-- 알아서 하이픈을 내어서 보여줌.

-- 오류 발생 상황
-- 월에 0이 빠졌을 때 
insert into `order` values(3, '느린 배송', '신라면', 4, '2024530');

-- 1년은 12개월이기 때문에 13이 들어갈 수 없다. 
insert into `order` values(4, '너무 느린 배송', '신라면', 4, '20241330');

-- 문자형이 아닌 숫자형으로 입력 시 
insert into `order` values(2, '느린 배송', '신라면', 3, 2024-05-30);
insert into `order` values(2, '느린 배송', '신라면', 3, 20240530);

select * from `order`;