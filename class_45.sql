create database demo5;
use demo5;

create table users (
	id bigint auto_increment primary key,
	name varchar(100) not null comment '사용자 이름',
    email varchar(255) not null comment '사용자 이메일'
);
desc users;
select * from users;

create database demo6;
use demo6;

create table users (
	id bigint auto_increment primary key,
	name varchar(100) not null comment '사용자 이름',
    password varchar(255) not null comment '사용자 비밀번호'
);
desc users;
select * from users;