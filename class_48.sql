create database if not exists db_todo2;
use db_todo2;

-- 정규화 1, 2, 3 정규 테이블 설계

-- users 테이블을 생성 tb_user 등..alter
create table if not exists users(
	id int auto_increment primary key,
    username varchar(50) not null unique,
    password varchar(255) not null,
    email varchar(100) not null, 
    created_at timestamp default current_timestamp
);

desc users;
desc todos;
alter table users add constraint unique(username);

-- todos 테이블 생성
create table if not exists todos(
	id int auto_increment primary key,
    title varchar(100) not null,
    description text,
    created_at timestamp default current_timestamp,
    due_date date,
    completed boolean default false,
    user_id int not null,
    foreign key(user_id) references users(id)
);

-- 샘플 데이터 삽입
-- users 테이블에 데이터 삽입
INSERT INTO users (username, password, email) VALUES
('홍길동', 'asd123', 'hong@example.com'),
('김철수', 'asd123', 'kim@example.com'),
('이영희', 'asd123', 'lee@example.com');

-- todos 테이블에 데이터 삽입
INSERT INTO todos (user_id, title, description, due_date, completed) VALUES
(1, '할 일 1', '할 일 1에 대한 설명입니다.', '2023-12-31', FALSE),
(1, '할 일 2', '할 일 2에 대한 설명입니다.', '2024-01-15', TRUE),
(2, '할 일 3', '할 일 3에 대한 설명입니다.', '2024-02-28', FALSE),
(3, '할 일 4', '할 일 4에 대한 설명입니다.', '2024-03-10', TRUE);

select * from users where id = 1;
select '2024-07-11' as mDate;

-- auto_increment 초기화
truncate table users;
truncate table todos;

drop table users;
drop table todos;

select * from users;
select * from todos;

