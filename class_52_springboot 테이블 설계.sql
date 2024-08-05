-- 임시
-- drop table account_tb;
-- drop table history_tb;
-- drop table user_tb;

-- 데이터 베이스 생성
-- mybank

create database mybank;
use mybank;

-- 외래키 지정 안 함. <--- 생산성 하락 때문
-- 유저 테이블 설계
create table user_tb(
	id int auto_increment primary key,
    username varchar(50) not null unique,
    password varchar(100) not null,
    fullname varchar(50) not null,
    created_at timestamp not null default now()
);
desc user_tb;

-- 계좌 정보 테이블
create table account_tb(
	id int auto_increment primary key,
    number varchar(30) not null unique, 
    password varchar(30) not null,
    balance bigint not null comment '계좌잔액',
    created_at timestamp not null default now(),
    user_id int
);
desc account_tb;

/**
필요한 것들 

거래내역에 대한 ID 값 (id)
거래 금액(key 값: amount)
출금계좌 ID
입금계좌 ID
출금 요청 후 계좌 잔액
입금 요청 후 계좌 잔액
거래 시간 
*/
create table history_tb(
	id int auto_increment primary key comment '거래내역 ID',
    amount bigint not null comment '거래금액',
    w_account_id int comment '출금 계좌 ID',
    d_account_id int comment '입금 계좌 ID',
    w_balance bigint comment '출금 요청 후 계좌 잔액',
    d_balance bigint comment '입금 요청 후 계좌 잔액',
    created_at timestamp not null default now()
);
desc history_tb;

-- 샘플 데이터 입력 
-- 유저 
insert into user_tb(username, password, fullname, created_at)
values('길동', '1234', '고', now());

insert into user_tb(username, password, fullname, created_at)
values('둘리', '1234', '애기공룡', now());

insert into user_tb(username, password, fullname, created_at)
values('마이클', '1234', '콜', now());

select * from user_tb;

-- 기본 계좌 등록 
insert into account_tb
		(number, password, balance, user_id, created_at)
values('1111', '1234', 1300, 1, now());        

insert into account_tb
		(number, password, balance, user_id, created_at)
values('2222', '1234', 1100, 2, now());        

insert into account_tb
		(number, password, balance, user_id, created_at)
values('3333', '1234', 0, 3, now());        

select * from account_tb;

-- 거래 내역 등록 연습
/**
가상 현재 잔액 

1111계좌는 1000원
2222계좌는  1000원
3333계좌는    0원
*/

-- 1. 이체 내역을 기록 
-- 1111번 계좌에서 222번 계좌로 100원 이체한다. 
insert into history_tb(amount, w_balance, d_balance, w_account_id, d_account_id, created_at)
            value(100, 900, 1100, 1, 2, now());

select * from history_tb;
select * from account_tb;

-- 2. ATM 기기에서 출금
-- 1111계좌에서 100원만 출금하는 히스토리를 만들어라.
insert into history_tb(amount, w_balance, d_balance, w_account_id, d_account_id, created_at) 
            value(100, 800, null, 1, null, now());


-- 3. ATM 기기에서 입금
-- 1111계좌로 500원만 입금하는 히스토리를 만들어라.
insert into history_tb(amount, w_balance, d_balance, w_account_id, d_account_id, created_at)
            value(500, null, 1300, null, 1, now());


