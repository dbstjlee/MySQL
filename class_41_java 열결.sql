use demo3;
select * from user;
desc user;
insert into user(name, email) values('admin', 'admin@naver.com');

show processlist; -- 세션을 받아 connection ...
-- HikariCP를 통해 Connection pool 10개가 생성됨. 

-- DDL
-- 컬럼을 추가하는 쿼리를 만들어 보자
 drop table user; 

create table users(
	 id int auto_increment primary key,
     username varchar(100) not null unique,
     password varchar(100) not null
);

desc users;

alter table users add column email varchar(100) null;

-- 이메일에 unique 라는 제약을 추가해보자. 
alter table users add constraint unique_email unique(email);

insert into users(username, password, email) 
values('홍길동', 'asd123', 'a@naver.com'),
	  ('이순신', 'asd123', 'b@naver.com'),
	  ('박태환', 'asd123', 'c@naver.com');
      
select * from users where username = '홍길동' and password = 'asd123';

-- 1
select * from users where username = '홍길동';

-- 2
select * from users where username = '홍길동' and password = 'asd123';


select * from users;

