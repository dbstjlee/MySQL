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
drop table notice_tb;
desc notice_tb;
insert into notice_tb(categories, title, content, created_at) values('test1', 'test1', 'test1', now()),
																						('test2', 'test2', 'test2', now()),
                                                                                        ('test3', 'test3', 'test3', now()),
                                                                                        ('test3', 'test3', 'test3', now()),
                                                                                        ('test3', 'test3', 'test3', now()),
                                                                                        ('test3', 'test3', 'test3', now()),
                                                                                        ('test3', 'test3', 'test3', now()),
                                                                                        ('test3', 'test3', 'test3', now()),
                                                                                        ('test3', 'test3', 'test3', now()),
                                                                                        ('test3', 'test3', 'test3', now());
														
                                                        
insert into notice_tb(categories, title, content, created_at) values('test1', 'test1', 'test1', now());                                           
                                                                    
SELECT * FROM notice_tb;
UPDATE notice_tb SET categories = 'test4', title = 'test4', content = 'test4' where id = 3;
DELETE FROM notice_tb WHERE id = 3;

SELECT * FROM notice_tb ORDER BY id limit 4 offset 0;
SELECT count(*) AS count FROM notice_tb;

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
drop table admin_tb;

SELECT * FROM admin_tb;
SELECT * FROM admin_tb WHERE admin_id = "admin";

INSERT INTO admin_tb(admin_name, admin_id, admin_password, admin_email, admin_gender, created_at) 
VALUES('admin', 'admin', 'admin', 'admin@naver.com', '남성', now());