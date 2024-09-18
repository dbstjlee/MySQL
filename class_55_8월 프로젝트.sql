create database perfecfolio;
use perfecfolio;

CREATE TABLE user_tb(
id int auto_increment primary key,
user_name varchar(255) not null,
user_id varchar(255) not null unique,
user_password varchar(255) NOT NULL,
user_nickname    varchar(20),
user_email    varchar(255)    NOT NULL     unique,
user_birth    varchar(100)    NOT NULL,
user_gender enum('남성','여성','설정안함'),
user_tel    varchar(13) not null,
created_at timestamp default now() not null,
social_type varchar(30) not null
);


desc user_tb;

select * from user_tb;
-- drop table user_tb;

insert into user_tb (user_name, user_id, user_password, user_nickname, user_email, user_birth, user_gender, user_tel, created_at, social_type) values
('김철수', 'su12345', '$2a$10$Z8V54WwBiAZcaUaFweRKv.XFw38rH1hvBWqcEU9UWunm8e3D8s28u', 'su12345', 'su12345@naver.com', '2010-10-11', '남성', '010-1234-5678', '2024-01-03 10:22:35', 'naver'),
('강영희', 'hee1234', '$2a$10$YYAwfhhbd7W6g8xjgYawm.MgoVvJaf1KtGurDQz9hi.cpFrLmry5q', 'hee1234', 'hee1234@naver.com', '1970-05-18', '여성', '010-9123-4567', '2024-02-03 12:03:11', 'naver'),
('이민수', 'minsu3456', '$2a$10$VqljtJN/7wwlCytMGnefTuvIn/Jn1k3i7IVrj449lLacND9wQTIF.', 'minsu3456', 'minsu3456@naver.com', '1983-06-20', '남성', '010-1123-4456', '2024-03-03 21:22:40', 'naver'),
('조연희', 'yeun1234', '$2a$10$8yhDtd1V3yIKcZ8n4Zfviux56DRrd/dgp3YHIF5vDZwOHhnFVBYy.', 'yeun1234', 'yeun1234@naver.com', '1991-12-01', '여성', '010-1134-5578', '2024-04-03 20:07:22', 'naver'),
('박민철', 'min4567', '$2a$10$sHcnhkzB4ibQa9ZE3GG2e.vpPquRKVkrO87tbsg/XqsUqYCOUrPpS', 'min4567', 'min4567@naver.com', '2005-06-01', '남성', '010-7789-1123', '2024-03-03 08:08:15', 'naver');

insert into user_tb (user_name, user_id, user_password, user_nickname, user_email, user_birth, user_gender, user_tel, created_at, social_type) values
('박경훈', 'pkh7765', '$2a$10$qe4U28Wqt1SgzNtopiq7Iu40wrNGsC0Q9ZbJW3VsfzxWJysKy8HQa', 'pkh7765', 'pkh7765@naver.com', '2000-04-16', '남성', '010-3259-4422', '2024-03-28 19:44:51', 'naver'),
('이민경', 'lmk9350', '$2a$10$T0gGE2pUxuJG/XyUMH.lYObVY/r9y7GPNu7nhl3PJmOd4P1wgusru', 'lmk9350', 'lmk9350@naver.com', '2003-03-04', '여성', '010-9966-3298', '2024-03-25 20:43:41', 'naver'),
('김현재', 'khj3309', '$2a$10$JAv0GhQVlvdAkvid5LOfwukxTjK19yq6C2oRIr2YGFbNW4L6rZJbe', 'khj3309', 'khj3309@naver.com', '1998-07-08', '남성', '010-1156-9562', '2024-03-06 18:37:21', 'naver'),
('김소연', 'ksy6650', '$2a$10$qjJmukGvuc7UW7ChIvPT3eXcMt.sqSuC9Gku0gUw2nHa0BslUfIhW', 'ksy6650', 'ksy6650@naver.com', '1995-09-27', '여성', '010-4275-3242', '2024-08-16 17:38:31', 'naver'),
('강현민', 'khm0032', '$2a$10$40oxkL8LYNDdHOY2nAhbceGU9YSANfcAWFYtGEqV43qEBgIB86zCG', 'khm0032', 'khm0032@naver.com', '1994-11-29', '', '010-6698-7754', '2024-08-19 23:26:56', 'naver');

insert into user_tb (user_name, user_id, user_password, user_nickname, user_email, user_birth, user_gender, user_tel, created_at, social_type) values
('이영수', 'yengsu7788', '$2a$10$uKm/E65Vy3qo4pmN9D7zwe0f5z4J3YMYsTL9q5zawvWfbrZig.fsm', 'yengsu7788', 'yengsu7788@gmail.com', '2000-02-20', '', '010-6541-9871', '2024-05-17 18:00:33', 'google'),
('이소윤', 'soyun0305', '$2a$10$SBXhypMrHXPLgI.Wytis9uIEdLEje6TaSlxG4iCy9pbRwIyjNmF2K', 'soyun0305', 'soyun0305@gmail.com', '2002-06-29', '', '010-5641-8971', '2024-06-20 16:25:00', 'google'),
('강민준', 'minjun1216', '$2a$10$M9sQdeVHgOrT88dpomBNIe7gm2q6gn4wYrjMOqEoTfjzxQXcjVzfO', 'minjun1216', 'minjun1216@gmail.com', '1985-06-05', '남성', '010-2310-0654', '2024-07-15 17:16:56', 'google'),
('김연아', 'yeona0705', '$2a$10$cqQk9TaUJXG3X4LvpqqJnuuEQCrkiJEJlgzPTsRyzMp4aBrK1oNQ.', 'yeona0705', 'yeona0705@gmail.com', '1997-01-16', '여성', '010-9870-6781', '2024-08-01 23:16:35', 'google'),
('강형욱', 'uuu0618', '$2a$10$V9oiO/3wjG5TkyGYMqNmmuMUmZjaEYZruFurHKLif4tOVUrOIhsvO', 'uuu0618', 'uuu0618@gmail.com', '2004-11-09', '남성', '010-6091-8134', '2024-09-01 04:03:46', 'google');

insert into user_tb (user_name, user_id, user_password, user_nickname, user_email, user_birth, user_gender, user_tel, created_at, social_type) values
('김연수', 'susu1010', '$2a$10$AfZn0djKRnI7qzGvwHXJpeLrnX3n4PD0Z.XtEgt5k8iCskWndbHNS', 'susu1010', 'susu1010@naver.com', '2001-10-20', '남성', '010-9987-0789', '2024-01-08 07:21:59', 'local'),
('강민영', 'young4567', '$2a$10$4mKl7bDDa01EVZ/9GtqHvO8U481mulT0cKsIJtjtjIOzfWO2oFK3m', 'young4567', 'young4567@gmail.com', '1989-07-20', '여성', '010-8712-4560', '2024-02-17 22:07:11', 'local'),
('이민형', 'min1111', '$2a$10$qN0dpoXRp4p6kn.gD0aiKOtdThAmFKQjynMp8rFEFAIP7v3vbfwsm', 'min1111', 'min1111@kakao.com', '1985-06-05', '', '010-6530-3208', '2024-03-29 05:16:07', 'local'),
('박명희', 'hee0789', '$2a$10$SMC7NhwjkZgO/xuSqlV7uu2C1DlUYtKmzKeB4F7CAJTxbBEtE.AKi', 'hee0789', 'hee0789@naver.com', '1998-12-16', '여성', '010-7904-9805', '2024-04-27 00:31:08', 'local'),
('박현철', 'park6598', '$2a$10$QYfaMZ6gz1wFrHHVZIUMBeKk3HNV7wOJDSuaF1aRSvAA4ehsy.jca', 'park6598', 'park6598@naver.com', '2003-09-21', '남성', '010-6490-5060', '2024-03-30 20:56:46', 'local');

insert into user_tb (user_name, user_id, user_password, user_nickname, user_email, user_birth, user_gender, user_tel, created_at, social_type) values
('박현수', 'susu8855', '$2a$10$wB6WF2uTwUgx4ovgIepGk.5nxBeGnjFrEiFsbzEYJQ5IHH/CWBOzy', 'susu8855', 'susu8855@kakao.com', '2000-10-16', '남성', '010-4532-8894', '2024-06-02 02:54:11', 'kakao'),
('이연우', 'yeonu6605', '$2a$10$z.5oXl0l..0/aUwVwfHyvu6K85MPJce66qkRisjIf6I0ikDPv.Dgq', 'yeonu6605', 'yeonu6605@kakao.com', '1993-07-20', '여성', '010-6652-0032', '2024-06-01 16:55:49', 'kakao'),
('박형석', 'phs1208', '$2a$10$Vg05nj/qlQRzk1PRRYUH.uYAGlSLbK7qCjH8hBmY7Mqo6eajQmoou', 'phs1208', 'phs1208@kakao.com', '1985-12-16', '남성', '010-7725-6632', '2024-07-03 17:37:28', 'kakao'),
('김유나', 'yuna0307', '$2a$10$qTXSFNxz4jS6IegTNQNHQueH7RkNu6N51P.eE/TuQCLaKqqP1cqWC', 'yuna0307', 'yuna0307@kakao.com', '1999-01-24', '', '010-4503-9830', '2024-08-14 23:09:07', 'kakao'),
('강형석', 'khs7845', '$2a$10$MmQKuzLlIEtDyVzT8yfFYOTV1gBZHf9fwV/H/OYa3mvmcQS6VUMYi', 'khs7845', 'khs7845@kakao.com', '2003-06-13', '남성', '010-5569-2202', '2024-08-22 19:28:39', 'kakao');

select * from ad_application;
select * from deleted_question_tb;


-- 회원 관리 페이지 --> + 결제일 포함
SELECT u.id, u.user_name AS username, u.user_id AS userId, u.user_email AS userEmail,
		u.user_nickname as userNickname, u.created_at AS createdAt, DATEDIFF(CURDATE(), LEFT(approved_at,
		10)) AS orderDays
		FROM user_tb AS u
		LEFT JOIN payment_tb AS p ON u.id = p.user_id
        ORDER BY id DESC limit 10 offset 0; 



select * from payment_tb;
select * from subscribing_tb;
desc subscribing_tb;


-- 회원 정보 수정
update user_tb set user_name = '조연희', user_nickname ='yeun1234', user_birth = '1991-12-07', user_gender = '여성', user_tel = '010-1233-4569'
where id = 4;  

select * from user_tb where user_email = 'dbstjlee@gmail.com';
SELECT count(user_id) FROM user_tb WHERE user_id = 'yoon';

SELECT  u.id, u.user_name AS username, u.user_id AS userId, u.user_email AS userEmail,
		u.user_nickname as userNickname, u.created_at AS createdAt,  DATEDIFF(CURDATE(), LEFT(approved_at, 10)) AS orderDays 
FROM user_tb AS u Left JOIN payment_tb AS p ON u.id = p.user_id 
WHERE u.user_id LIKE '%12%' ORDER BY u.id DESC limit 10 offset 0;

SELECT COUNT(*) AS count FROM user_tb WHERE user_id LIKE '%su%';

SELECT  u.id, u.user_name AS username, u.user_id AS userId, u.user_email AS userEmail,
		u.user_nickname as userNickname, u.created_at AS createdAt,  DATEDIFF(CURDATE(), LEFT(approved_at, 10)) AS orderDays 
FROM user_tb AS u Left JOIN payment_tb AS p ON u.id = p.user_id 
WHERE u.user_name LIKE '%박%' ORDER BY id DESC limit 10 offset 0;

SELECT COUNT(*) AS count FROM user_tb WHERE user_name LIKE '%박%';

SELECT  u.id, u.user_name AS username, u.user_id AS userId, u.user_email AS userEmail,
		u.user_nickname as userNickname, u.created_at AS createdAt,  DATEDIFF(CURDATE(), LEFT(approved_at, 10)) AS orderDays 
FROM user_tb AS u Left JOIN payment_tb AS p ON u.id = p.user_id 
WHERE u.user_nickname LIKE '%su%' ORDER BY id DESC limit 10 offset 0;
SELECT COUNT(*) AS count FROM user_tb WHERE user_nickname LIKE '%su%';


SELECT DATEDIFF(CURDATE(), LEFT(approved_at, 10)) AS orderDays
FROM payment_tb;
-- LEFT(approved_at, 10) : 왼쪽 10자리 추출
-- DATEDIFF(): 현재 날짜와 approved_at 날짜 사이의 일 수를 계산

select * from payment_tb;
select * from user_tb;
select * from user_withdraw_tb;
desc user_tb;
select * from order_tb;
select * from user_withdraw_tb;
select * from notice_tb;

delete from user_tb where id = 28;
SELECT * FROM user_tb WHERE id = 25;
SELECT * FROM user_tb;
SELECT * FROM admin_tb;



-- ----------------------------------------------------

select * from user_withdraw_tb;
select * from withdraw_reason_tb;
desc withdraw_reason_tb;
create table withdraw_reason_tb(
	id int auto_increment primary key,
    user_id varchar(255) not null,
    reason varchar(255) not null,
	reason_detail varchar(255)
);
desc withdraw_reason_tb;
select * from withdraw_reason_tb;
insert into withdraw_reason_tb(user_id, reason, reason_detail) values
('Seoyeon1', '멤버십이 마음에 들지 않아요.', null),
('Jihoon9', '사이트를 자주 방문하지 않아요.', null),
('Minjun7', '멤버십이 마음에 들지 않아요.', null),
('Jimin4', '가격이 비싸요.', null),
('Woosung2', '멤버십이 마음에 들지 않아요.', null),
('Yujin3', '기타 사유', 'test1'),
('Sungyeon5', '기타 사유', 'test2'),
('Haneul6', '기타 사유', 'test3'),
('Dongwon8', '기타 사유', 'test4'),
('Jiyoung7', '기타 사유', 'test5'),
('Taehun9', '사이트를 자주 방문하지 않아요.', null),
('Areum1', '사이트를 자주 방문하지 않아요.', null),
('Hankil2', '기타 사유', 'test6'),
('Seojin3', '사이트를 자주 방문하지 않아요.', null),
('Minhyuk4', '가격이 비싸요.', null),
('Sumin5', '가격이 비싸요.', null),
('Dohyeon7', '기타 사유', 'test7'),
('Hayoung6', '새 계정을 만들고 싶어요.', null),
('Eunji8', '새 계정을 만들고 싶어요.', null),
('Junho9', '가격이 비싸요.', null);


-- ('새 계정을 만들고 싶어요.'),
-- ('사이트를 자주 방문하지 않아요.'),
-- ('멤버십이 마음에 들지 않아요.'),
-- ('가격이 비싸요.'),
-- ('기타(추가 입력)');

select * from withdraw_reason_tb;
select * from user_withdraw_tb;

SELECT * FROM user_withdraw_tb
WHERE withdraw_at < NOW() - INTERVAL 3 YEAR;




CREATE TABLE user_withdraw_tb(
id int auto_increment primary key,
user_name varchar(255) not null,
user_id varchar(255) not null,
user_password varchar(255) NOT NULL,
user_nickname    varchar(20),
user_email    varchar(255)    NOT NULL,
user_birth    varchar(255)    NOT NULL,
user_gender enum('남성','여성','설정안함'),
user_tel    varchar(13) not null,
created_at varchar(30) not null,
social_type varchar(30) not null,
withdraw_at timestamp default now() not null
);


desc user_withdraw_tb;
drop table user_withdraw_tb;

INSERT INTO  user_withdraw_tb(user_name, user_id, user_password, user_nickname, user_email, user_birth, user_gender, user_tel, social_type, created_at, withdraw_at) VALUES
('이서연', 'Seoyeon1', 'Seoyeon1*', 'Seoyeon1', 'Seoyeon1@kakao.com', '1997-01-05', '여성', '010-1145-5678', 'kakao', '2024-01-05 14:23:45', '2024-01-12 09:15:30'),
('박지훈', 'Jihoon9', 'Jihoon9*', 'Jihoon9', 'Jihoon9@naver.com', '1998-01-11', '남성', '010-2345-6789', 'naver', '2024-02-14 11:00:00', '2024-02-13 16:30:10'),
('김민준', 'Minjun7', 'Minjun7*', 'Minjun7', 'Minjun7@gmail.com', '1991-01-19', '남성', '010-3456-7890', 'google', '2024-03-25 10:10:15', '2024-03-14 18:20:55'),
('한지민', 'Jimin4', 'Jimin4!', 'Jimin4', 'Jimin4@naver.com', '1990-01-25', '여성', '010-4567-8901', 'local', '2024-04-12 13:32:10', '2024-04-15 14:22:33'),
('정우성', 'Woosung2', 'Woosung2*', 'Woosung2', 'Woosung2@kakao.com', '1980-01-30', '', '010-5678-9012', 'kakao', '2024-05-03 08:45:25', '2024-05-08 13:05:40'),
('최유진', 'Yujin3', 'Yujin3*', 'Yujin3', 'Yujin3@naver.com', '1970-02-01', '여성', '010-6789-0123', 'naver', '2024-06-21 09:55:10', '2024-06-25 17:15:30'),
('조성현', 'Sungyeon5', 'Sungyeon5*', 'Sungyeon5', 'Sungyeon5@gmail.com', '1990-02-08', '남성', '010-7890-1234', 'google', '2024-07-10 12:22:05', '2024-07-15 08:00:50'),
('송하늘', 'Haneul6', 'Haneul6!', 'Haneul6', 'Haneul6@naver.com', '2000-02-14', '', '010-8901-2345', 'local', '2024-08-02 15:00:00', '2024-08-10 20:20:00'),
('강동원', 'Dongwon8', 'Dongwon8*', 'Dongwon8', 'Dongwon8@kakao.com', '2001-02-22', '남성', '010-9012-3456', 'kakao', '2024-08-20 16:18:30', '2024-08-25 19:45:10'),
('오지영', 'Jiyoung7', 'Jiyoung7*', 'Jiyoung7', 'Jiyoung7@naver.com', '2004-02-28', '여성', '010-0123-4567', 'naver', '2024-09-01 10:30:15', '2024-09-05 21:30:25'),
('임태훈', 'Taehun9', 'Taehun9*', 'Taehun9', 'Taehun9@gmail.com', '1995-03-02', '남성', '010-7778-9988', 'google', '2024-01-12 15:45:45', '2024-01-20 11:00:20'),
('윤아름', 'Areum1', 'Areum1!', 'Areum1', 'Areum1@naver.com', '1996-03-08', '', '010-4456-7753', 'local', '2024-02-05 10:55:10', '2024-02-10 07:50:30'),
('류한길', 'Hankil2', 'Hankil2*', 'Hankil2', 'Hankil2@kakao.com', '1995-03-15', '여성', '010-8824-7890', 'kakao', '2024-03-18 12:20:05', '2024-03-25 15:30:25'),
('문서진', 'Seojin3', 'Seojin3*', 'Seojin3', 'Seojin3@naver.com', '1996-03-21', '남성', '010-0035-8901', 'naver', '2024-04-01 11:55:30', '2024-04-08 13:40:15'),
('서민혁', 'Minhyuk4', 'Minhyuk4*', 'Minhyuk4', 'Minhyuk4@gmail.com', '1999-03-29', '', '010-9950-9012', 'google', '2024-05-10 08:25:10', '2024-05-20 14:00:30'),
('한수민', 'Sumin5', 'Sumin5!', 'Sumin5', 'Sumin5@gmail.com', '1999-04-02', '여성', '010-3364-0123', 'local', '2024-06-15 14:10:55', '2024-06-20 16:30:10'),
('김도현', 'Dohyeon7', 'Dohyeon7*', 'Dohyeon7', 'Dohyeon7@kakao.com', '1983-04-10', '남성', '010-9924-7865', 'kakao', '2024-07-05 09:30:25', '2024-07-12 12:45:55'),
('강하영', 'Hayoung6', 'Hayoung6*', 'Hayoung6', 'Hayoung6@naver.com', '1985-04-15', '', '010-1123-9987', 'naver', '2024-08-10 10:15:20', '2024-08-15 15:55:00'),
('장은지', 'Eunji8', 'Eunji8*', 'Eunji8', 'Eunji8@gmail.com', '1973-04-22', '여성', '010-4532-8875', 'google', '2024-09-01 14:00:00', '2024-09-03 17:20:10'),
('이준호', 'Junho9', 'Junho9!', 'Junho9', 'Junho9@gmail.com', '1972-04-28', '남성', '010-6657-9980', 'local', '2024-09-05 11:35:45', '2024-09-10 18:05:30');



SELECT reason, COUNT(*) AS count FROM
		withdraw_reason_tb GROUP BY reason;
        
 select * from user_tb;
 
        
        
        
update user_tb set user_gender = 'null' where id = 12;



select w.id, user_name, w.user_id, user_email, created_at, withdraw_at, reason, reason_detail 
from user_withdraw_tb AS w
left join withdraw_reason_tb AS r on w.user_id = r.user_id
order by w.id desc;

SELECT w.id, user_name, w.user_id, user_password, 
		user_email, created_at, withdraw_at, 
		reason, reason_detail
		FROM user_withdraw_tb AS w
		left join withdraw_reason_tb AS r on w.user_id =
		r.user_id
		order by w.id DESC ;

select w.id, user_name, w.user_id, user_password, user_nickname, user_email, user_birth, user_gender, user_tel, social_type, created_at, withdraw_at, reason, reason_detail 
from user_withdraw_tb AS w
left join withdraw_reason_tb AS r on w.user_id = r.user_id
order by w.id desc;

SELECT COUNT(*) FROM user_withdraw_tb;

desc withdraw_reason_tb;


SELECT w.id, w.user_id,
		created_at, withdraw_at, reason,
		reason_detail
		FROM user_withdraw_tb AS w
		JOIN withdraw_reason_tb AS r ON
		w.user_id = r.user_id
		WHERE r.reason ='기타 사유'
		ORDER BY r.id DESC;
        
        SELECT w.id, w.user_id,
		created_at, withdraw_at, reason,
		reason_detail
		FROM user_withdraw_tb AS w
		left join withdraw_reason_tb AS
		r on w.user_id =
		r.user_id
		order by
		w.id DESC;

SELECT reason, COUNT(*) AS count
        FROM withdraw_reason_tb
        GROUP BY reason;



-- ----------------------------------------------------------
-- 공지사항

create table notice_tb(
	id int auto_increment primary key,
    categories varchar(30) not null,
    title varchar(255) not null,
    content varchar(255) not null,
    created_at timestamp default now() not null,
    views int default 0 not null
);
-- drop table notice_tb;
desc notice_tb;
insert into notice_tb(categories, title, content, created_at) values('[업데이트]', '제목1', '내용1', now()),
																						('test2', 'test2', 'test2', now()),
                                                                                        ('test3', 'test3', 'test3', now()),
                                                                                        ('test3', 'test3', 'test3', now()),
                                                                                        ('test3', 'test3', 'test3', now()),
                                                                                        ('test3', 'test3', 'test3', now()),
                                                                                        ('test3', 'test3', 'test3', now()),
                                                                                        ('test3', 'test3', 'test3', now()),
                                                                                        ('test3', 'test3', 'test3', now()),
                                                                                        ('test3', 'test3', 'test3', now());
														
                                                        
insert into notice_tb(categories, title, content, created_at) values('[업데이트]', '제목1', '내용1', now());                                           
insert into notice_tb(categories, title, content, created_at) values('[업데이트]', '제목2', '내용2', now());                                           
insert into notice_tb(categories, title, content, created_at) values('[구독/결제]', '제목1', '내용1', now());                                           
insert into notice_tb(categories, title, content, created_at) values('[구독/결제]', '제목2', '내용2', now());                                           
insert into notice_tb(categories, title, content, created_at) values('[회원]', '제목1', '내용1', now());                                           
insert into notice_tb(categories, title, content, created_at) values('[회원]', '제목2', '내용2', now());    

                                       
insert into notice_tb(categories, title, content, created_at) values('1', '1', '1', now());                                           
desc notice_tb;
SELECT * FROM notice_tb;
UPDATE notice_tb SET categories = 'test4', title = 'test4', content = 'test4' where id = 3;
DELETE FROM notice_tb WHERE id = 3;

SELECT * FROM notice_tb ORDER BY id limit 4 offset 0;
SELECT count(*) AS count FROM notice_tb;


SELECT * FROM notice_tb;
-- 조회수 상승
UPDATE notice_tb SET views = views +1 where id = 1;

SELECT * FROM notice_tb WHERE categories LIKE '1' ORDER BY id DESC limit 4 offset 0;
SELECT COUNT(*) AS count FROM notice_tb WHERE categories LIKE '1' ORDER BY id DESC limit 4 offset 0;


SELECT * FROM notice_tb WHERE title AND content LIKE '1' ORDER BY id DESC limit 4 offset 0;
SELECT COUNT(*) AS count FROM notice_tb WHERE title AND content LIKE '1' ORDER BY id DESC limit 4 offset 0;

SELECT * FROM notice_tb WHERE title LIKE '1' ORDER BY id DESC limit 4 offset 0;
SELECT COUNT(*) AS count WHERE title LIKE '1' ORDER BY id DESC limit 4 offset 0;

select * from user_withdraw_tb;


SELECT * FROM notice_tb WHERE title LIKE '%1%' ORDER BY id DESC limit 10 offset 0;
SELECT * FROM notice_tb WHERE title LIKE '%2%' OR content LIKE '%2%' ORDER BY id DESC limit 10 offset 0;
SELECT * FROM notice_tb WHERE title LIKE '%2%' AND content LIKE '%2%' ORDER BY id DESC limit 10 offset 0;
SELECT * FROM notice_tb WHERE categories LIKE '%1%' ORDER BY id DESC limit 10 offset 0;

SELECT IFNULL(COUNT(*), 0) AS count FROM notice_tb WHERE title LIKE '%1%';

SELECT * FROM notice_tb;



select * from user_withdraw_tb;


create table admin_tb(
	id int auto_increment primary key,
    admin_name varchar(255) not null,
    admin_id varchar(255) not null unique,
    admin_password varchar(255) not null, 
    admin_email varchar(255) not null unique,
    admin_gender enum('남성', '여성'),
    created_at timestamp default now() not null
);
desc admin_tb;
-- drop table admin_tb;

SELECT * FROM admin_tb;
SELECT * FROM admin_tb WHERE admin_id = "admin";

INSERT INTO admin_tb(admin_name, admin_id, admin_password, admin_email, admin_gender, created_at) 
VALUES('admin', 'admin', 'admin', 'admin@naver.com', '남성', now());


update admin_tb set admin_password = '$2a$10$flHqm7OtGC644Qa0l3Bn6OA5OFBTQ2H/e9IwsakR0Sh5Y8RUC90W6';
update admin_tb set admin_password = 'admin' WHERE admin_id = 'admin';
select * from admin_tb where admin_id = 'admin'; 



-- ------------------------------------------------------------
-- 관리자 대시보드

-- 전체 사용자의 수
SELECT COUNT(*) FROM user_tb;
SELECT * FROM user_tb;
desc user_tb;

-- 전체 사용자 수(월별)
SELECT YEAR(created_at) AS year, MONTH(created_at) AS month, COUNT(*) AS userCount
FROM user_tb
GROUP BY YEAR(created_at), MONTH(created_at)
ORDER BY year, month;

-- 남/여 수
SELECT user_gender, COUNT(*) AS COUNT FROM user_tb GROUP BY user_gender;

-- 남/여 성비(보류)
SELECT SUM(CASE WHEN user_gender = '남성' THEN 1 ELSE 0 END) / SUM(CASE WHEN user_gender = '여성' THEN 1 ELSE 0 END)
AS male_female_ratio FROM user_tb;
-- 남성 : 여성 = 0.4 : 1

select * from payment_tb;
select * from refund_tb;
select * from admin_tb;

-- 소셜 로그인 타입
SELECT social_type AS socialType, COUNT(*) AS count FROM user_tb GROUP BY social_type;


delete from user_tb where id = 73;
select * from user_tb;

select user_birth from user_tb;
select YEAR(user_birth) AS year, COUNT(*) AS userCount from user_tb
GROUP BY YEAR(user_birth);


SELECT CASE 
        WHEN YEAR(CURDATE()) - YEAR(user_birth) < 10 THEN '10대 미만'
        WHEN YEAR(CURDATE()) - YEAR(user_birth) BETWEEN 10 AND 19 THEN '10대'
        WHEN YEAR(CURDATE()) - YEAR(user_birth) BETWEEN 20 AND 29 THEN '20대'
        WHEN YEAR(CURDATE()) - YEAR(user_birth) BETWEEN 30 AND 39 THEN '30대'
        WHEN YEAR(CURDATE()) - YEAR(user_birth) BETWEEN 40 AND 49 THEN '40대'
        WHEN YEAR(CURDATE()) - YEAR(user_birth) >= 50 THEN '50대 이상'
        ELSE '연령 불명'
    END AS age, COUNT(*) AS count FROM user_tb 
    WHERE social_type = 'naver'
    GROUP BY age ORDER BY FIELD(age, '10대 미만', '10대', '20대', '30대', '40대', '50대 이상');


create table age_order(
	id int primary key auto_increment,
    age_group varchar(30)
);



INSERT INTO age_order (age_group) VALUES
    ('10대 미만'),
    ('10대'),
    ('20대'),
    ('30대'),
    ('40대'),
    ('50대 이상'),
    ('연령 불명');
    
select * from age_order;
SELECT id FROM age_order WHERE age_order.age_group = age_group;
select * from origin_change_jsonl limit 100 offset 599;

		SELECT CASE 
        WHEN YEAR(CURDATE()) - YEAR(user_birth) < 10 THEN '10대 미만'
        WHEN YEAR(CURDATE()) - YEAR(user_birth) BETWEEN 10 AND 19 THEN '10대'
        WHEN YEAR(CURDATE()) - YEAR(user_birth) BETWEEN 20 AND 29 THEN '20대'
        WHEN YEAR(CURDATE()) - YEAR(user_birth) BETWEEN 30 AND 39 THEN '30대'
        WHEN YEAR(CURDATE()) - YEAR(user_birth) BETWEEN 40 AND 49 THEN '40대'
        WHEN YEAR(CURDATE()) - YEAR(user_birth) <= 50 THEN '50대 이상'
        ELSE '연령 불명'
    END AS age, COUNT(*) AS count FROM user_tb 
    WHERE social_type = 'naver' GROUP BY age;




-- ----------------------------------------------------

-- 기업용 회원 유저 정보 >> 기존 유저 테이블에 com 타입 추가
select * from user_tb;
insert into user_tb(user_name, user_id, user_password, user_nickname, user_email, user_gender, user_tel, social_type)
values ('(주) 그린아카데미', 'asd123', 'asd123', '(주) 그린아카데미', 'green@green.com', '설정 안함', '051-123-4567', 'com');
-- 기업용 결제 아이템 테이블 >> 10개 9900원, 30개 28900원, 50개 46500원, 100개 89900원 가격 설정 >> 입사제안서 1개 당 1000원
-- 결제 정보 테이블 >> 아이템 갯수 표현, 차감 식으로 사용
CREATE TABLE co_goods_tb (
    id INT NOT NULL,
    goods_num INT NOT NULL,
    used_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_user_id FOREIGN KEY (id) REFERENCES user_tb(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT check_positive_value CHECK (goods_num >= 0)
);
insert into co_goods_tb(id, goods_num) values (40, 50);
update co_goods_tb set goods_num = 49, used_date = now() where id = 40;
select * from co_goods_tb;
-- 결제 내역 테이블 >> 기업 사용자에게 보여줄 결제 내역 ex) 50개 언제 결제 등등
create table co_payment_history_tb(
id int auto_increment primary key,
    user_id int not null,
    goods_each int not null,
    goods_price int not null,
    payment_date timestamp default current_timestamp,
     CONSTRAINT fk_user_id_payment FOREIGN KEY (user_id) REFERENCES user_tb(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
insert into co_payment_history_tb (user_id, goods_each, goods_price)
values (40, 50, 46500);
select * from co_payment_history_tb;
-- 이력서 조회한 유저 내역 테이블 >> 조회 수 많은 유저들 노출을 통한 <<많이 찾는 인재>> 까지 활용 가능(count, date 조건.. 최근 7일, 30일)
create table co_search_user_history(
id int auto_increment primary key,
    com_id int not null,
    user_id int not null,
    search_date timestamp default current_timestamp
);
insert into co_search_user_history(com_id, user_id)
values(40, 26);
select * from co_search_user_history;
-- 검색 필터 테이블 >> 필터 정보를 통해 최근 많이 찾는 인재 유형 차트 제공 가능
-- 즐겨찾기 한 유저 정보 테이블 >> 유저 테이블과 연계, 중간 테이블 성향 多
create table co_bookmark(
id int auto_increment primary key,
    com_id int not null,
    user_id int not null,
    bookmark_date timestamp default current_timestamp
);
insert into co_bookmark(com_id, user_id)
values(40, 27);
select * from co_bookmark;








