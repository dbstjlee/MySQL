create database db_movie;

drop table Movie_title;
use db_movie;

create table Movie_title(
	id int primary key auto_increment,
    title varchar(50) unique,
    director varchar(50) not null, 
    release_dat varchar(50) not null,
    genre varchar(50) not null,
    rating double not null
);
desc Movie_title;

insert into Movie_title (title, director, release_dat, genre, rating)
values
('괴물', '봉준호', '2006-07-27', '드라마', 8.28),
('극한직업', '이병헌', '2019-01-23', '코미디', 9.20),
('명량', '김한민', '2014-07-30', '사극', 9.17),
('신과함께-죄와 벌', '김용화', '2017-12-20', '판타지', 7.56),
('밀양', '임권택', '2016-09-07', '드라마', 7.76),
('반도', '연상호', '2020-07-15', '액션', 6.71),
('베테랑', '류승완', '2015-08-05', '액션', 8.49),
('변호인', '양우석', '2013-12-18', '드라마', 8.41),
('군함도', '류승완', '2017-07-26', '사극', 8.01),
('암살', '최동훈', '2015-07-22', '액션', 8.37);

select * from Movie_title;

-- 문제 1 : id가 9인 영화의 장르를 드라마로 수정하시오. 
update Movie_title set genre = '드라마' where id = 9;

-- 문제 2 :  id가 4인 영화의 장르와 평점을 조회하시오. 
select genre, rating from Movie_title 
where id = 4;

-- 문제 3: 장르가 액션이며 평점이 8.40 이상인 영화의 출시일을 '2024-06-04'로 변경하시오.
update Movie_title set release_dat = '2024-06-04' 
where genre = '액션' and rating > 8.40;

-- 문제 4: 장르가 드라마, 액션을 제외한 감독이 김씨가 아닌 작품 조회
select * from Movie_title
where genre != '드라마' and genre != '액션'
and director not like '김%';