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
user_gender enum('남성','여성'),
user_tel    varchar(13),
created_at timestamp default now() not null,
social_type varchar(30) not null
);

select * from social;
select * from user_withdraw_tb;
select * from user_tb;
select * from local_login_tb;

-- drop table user_tb; 
-- delete from user_tb where id = 12;
-- delete from user_withdraw_tb where id = 19;

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
drop table age_order;


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

		SELECT CASE 
        WHEN YEAR(CURDATE()) - YEAR(user_birth) < 10 THEN '10대 미만'
        WHEN YEAR(CURDATE()) - YEAR(user_birth) BETWEEN 10 AND 19 THEN '10대'
        WHEN YEAR(CURDATE()) - YEAR(user_birth) BETWEEN 20 AND 29 THEN '20대'
        WHEN YEAR(CURDATE()) - YEAR(user_birth) BETWEEN 30 AND 39 THEN '30대'
        WHEN YEAR(CURDATE()) - YEAR(user_birth) BETWEEN 40 AND 49 THEN '40대'
        WHEN YEAR(CURDATE()) - YEAR(user_birth) <= 50 THEN '50대 이상'
        ELSE '연령 불명'
    END AS age, COUNT(*) AS count FROM user_tb 
    WHERE social_type = 'naver' GROUP BY age
    ORDER BY 
    (SELECT id FROM age_order WHERE age_order.age_group = age_group);



