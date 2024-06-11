create database m_board;
use m_board;

create table user(
	id int primary key auto_increment,
    username varchar(100) not null unique, -- 닉네임(중복 검사 가능)
    password varchar(255) not null,
    email varchar(100) not null,
    userRole varchar(20),
    createDate timestamp
);

-- board table(게시글), reply table(댓글) (1 : N)

create table board(
	id int primary key auto_increment,
    userId int,
    title varchar(100) not null,
    content text,
    foreign key(userId) references user(id)
);

create table reply(
	id int primary key auto_increment,
    userId int,
    boardId int,
    content varchar(300) not null,
    createDate timestamp,
    foreign key(userId) references user(id),
    -- foreign key(userId) references user(id) on delete set null,
    -- 사용자가 탈퇴하면 사용자 id를 자동으로 null로 셋팅하도록 제약을 검. 
    foreign key(boardID) references board(id)
);

drop table user;
drop table board;
drop table reply;

INSERT INTO user (username, password, email, address, userRole, createDate)
VALUES
('홍길동', '1234', 'hong@example.com', '서울시 강남구', 'admin', NOW()),
('이순신', '1234', 'lee@example.com', '부산시 해운대구', 'user', NOW()),
('김유신', '1234', 'kim@example.com', '대구시 수성구', 'user', NOW());

-- 스키마 구조를 변경하는 쿼리 - DDL
-- user 테이블에 address 컬럼을 추가하기
alter table user add address varchar(100) not null; 


INSERT INTO board (userId, title, content, readCount)
VALUES
(1, '첫 번째 글입니다', '안녕하세요, 홍길동입니다. 이것은 테스트 게시글입니다.', 150),
(2, '이순신의 포스팅', '부산에서 이순신입니다. 바다가 아름다운 날입니다.', 45),
(3, '대구의 뜨거운 여름', '여름이 기승을 부리는 대구에서 김유신입니다.', 30);

alter table board add readCount int;

INSERT INTO reply (userId, boardId, content, createDate)
VALUES
(2, 1, '홍길동님의 글 잘 읽었습니다!', NOW()),
(3, 1, '저도 의견이 같네요.', NOW()),
(1, 2, '부산도 좋지만 서울도 좋아요!', NOW()),
(1, 3, '대구가 그렇게 덥군요, 조심하세요!', NOW());

select * from user;
select * from board;
select * from reply;


-- 특정 사용자의 게시글 조회(사용자 ID가 1인 홍길동의 모든 게시글을 보고 싶다면)
select b.title, b.content, b.readCount
from board as b
where b.userID = 1;

-- 1번 게시글에 대한 모든 댓글 조회
select u.username, r.content, r.createDate
from reply r 
left join user u on r.userId = u.id
where r.boardId = 1;

-- 게시글에 댓글 달기
-- 예를 들어, 사용자 ID 2가 게시글 ID 1에
-- "새로운 댓글입니다." 라는 내용의 댓글을 추가하려면 다음 쿼리를 사용합니다.
-- insert into...

insert into reply(userId, boardId, content, createDate)
values(2, 1, '새로운 댓글입니다', Now());

-- 특정 사용자의 게시글 해당 게시글의 댓글 수 조회
-- 쿼리 결과 : 제목, 내용, 작성자 이름, 댓글 수, 
-- 글 1, ..., 홍길동, 19
-- 글 2, ..., 이순신, 10

SELECT b.title, b.content, u.username, COUNT(r.id) as CommentCount
FROM board b
JOIN user u ON b.userId = u.id
LEFT JOIN reply r ON b.id = r.boardId
GROUP BY b.id;

-- 조회수가 가장 높은 게시글 상위 2개만 조회
select title, content, readCount
from board
order by readCount desc
limit 2;