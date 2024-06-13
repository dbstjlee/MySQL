use demo3;

-- 제 2정규화(2NF)
-- 복합키 생성 방법 확인
create table 수강정보(
	 학생ID int,
     과목코드 varchar(10),
     과목명 varchar(10),
     담당교수 varchar(10),
     primary key(학생ID, 과목코드)
);

desc 수강정보;
drop table 수강정보;
-- 과목명과 담당교수는 과목코드에 부분적으로 종속되어 있어서 2NF를 만족하지 않음.

-- 수강정보 테이블 만들기
create table 수강정보(
	학생ID int,
    과목코드 varchar(10),
    primary key(학생ID, 과목코드)
);

-- 과목정보 테이블 만들기
create table 과목정보(
	과목코드 varchar(10),
    과목명 varchar(10),
    담당교수 varchar(10)
);

desc 수강정보;
desc 과목정보;

-- 영화와 관련된 데이터 베이스를 구축하자. 
-- 영화 제목, 개봉연도, 매출액, 평점, 관객 수, 
-- 배우, 배우 이름, 배우 개인정보(키, 나이), 
-- 출연 배우 (영화에 누가 출연했는지)

-- 영화, 배우, 출연 테이블 설계(정규화를 만족해서 설계해보자)

-- 영화 테이블 설계(영화 id, 제목, 줄거리, 개봉일, 장르, 관객 수, 매출액, 평점, 리뷰)
create table Movie(
	id int primary key auto_increment,
    title varchar(20) not null,
    description text,
    release_date date not null,
    genre varchar(10) not null,
    Client_count int,
    revenue double,
    rate double,
    review text
);

-- 감독 테이블 설계(영화 id, 감독 id, 감독 이름)
-- => 영화 : 감독 = N : 1 
create table director(
	Movie_id int,
    director_id int primary key auto_increment,
    director_name varchar(10),
    foreign key(Movie_id) references Movie(id)
);


-- 배우 테이블 설계(배우 id, 이름, 나이, 성별, 키, 몸무게, 데뷔일)
create table Actor(
	id int primary key auto_increment,
    name varchar(10) not null,
    age int,
    gender enum('M', 'F'),
    height decimal(3,1),
    weight decimal(3,1),
    debut_date date
);


-- 출연 배우 테이블 설계(영화 id, 배우 id, 비중, 배역) 
-- => 영화 : 배우 = N : M 관계라서 테이블 추가
create table M_Actor(
	Movie_id int,
    Actor_id int,
    importance varchar(10),
    role varchar(10),
    foreign key(Movie_id) references Movie(id),
    foreign key(Actor_id) references Actor(id)
);

drop table Actor;
drop table director;
drop table Movie;



