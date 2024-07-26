drop database if exists db_tboard;
create database db_tboard;
use db_tboard;

-- user 테이블 생성
create table users(
	id int auto_increment primary key,
    username varchar(50) not null unique,
    password varchar(50) not null, 
    email varchar(50) not null unique,
    created_at timestamp default current_timestamp
);
desc users;

-- board(게시글) 테이블 생성
create table board(
	id int primary key auto_increment,
    user_id int,
    title varchar(255) not null, 
    content text not null,
    create_at timestamp default current_timestamp,
    foreign key(user_id) references users(id) on delete cascade
);
desc board;
-- 회원 탈퇴시 id 기준으로 자동으로 게시글 삭제

-- comments(댓글) 테이블 생성
-- 누가, 어느 게시글에 작성하였는지(board_id, user_id 참조)
create table comments(
	id int auto_increment primary key,
    board_id int, 
    user_id int,
    content text not null,
    created_at timestamp default current_timestamp, 
	foreign key(board_id) references board(id) on delete cascade,
    foreign key(user_id) references users(id) on delete cascade
);
desc comments;

-- 기존 데이터 삭제 - auto_increment 초기화
-- truncate table comments;
-- truncate table board;
-- truncate table users;

-- drop table board;
-- drop table users;
-- drop table comments;

-- users 테이블에 샘플 데이터 삽입
INSERT INTO users (username, password, email) VALUES ('user1', 'asd123', 'user1@example.com');
INSERT INTO users (username, password, email) VALUES ('user2', 'asd123', 'user2@example.com');
INSERT INTO users (username, password, email) VALUES ('user3', 'asd123', 'user3@example.com');

-- board 테이블에 샘플 데이터 삽입
INSERT INTO board (user_id, title, content) VALUES (1, '자바의 장점', '자바는 플랫폼 독립적이며, 풍부한 라이브러리를 제공합니다.');
INSERT INTO board (user_id, title, content) VALUES (2, '파이썬과 머신러닝', '파이썬은 머신러닝에 최적화된 언어로, 다양한 라이브러리를 지원합니다.');
INSERT INTO board (user_id, title, content) VALUES (3, '자바스크립트와 웹 개발', '자바스크립트는 웹 개발의 핵심 언어로, 프론트엔드와 백엔드 모두에서 사용됩니다.');

INSERT INTO board (user_id, title, content) VALUES (1, 'Spring 프레임워크', 'Spring은 자바 기반의 강력한 애플리케이션 프레임워크입니다.');
INSERT INTO board (user_id, title, content) VALUES (2, 'Django를 활용한 웹 개발', 'Django는 파이썬 기반의 웹 프레임워크로, 빠른 개발이 가능합니다.');
INSERT INTO board (user_id, title, content) VALUES (3, 'React로 인터랙티브 웹 만들기', 'React는 사용자 인터페이스 구축을 위한 자바스크립트 라이브러리입니다.');

INSERT INTO board (user_id, title, content) VALUES (1, 'JSP와 서블릿', 'JSP와 서블릿을 사용하여 동적인 웹 페이지를 개발할 수 있습니다.');
INSERT INTO board (user_id, title, content) VALUES (2, 'Flask의 장점', 'Flask는 가벼운 파이썬 웹 프레임워크로, 유연성과 확장성이 뛰어납니다.');
INSERT INTO board (user_id, title, content) VALUES (3, 'Node.js로 서버 개발', 'Node.js는 자바스크립트를 사용하여 서버 측 애플리케이션을 개발할 수 있습니다.');

INSERT INTO board (user_id, title, content) VALUES (1, '첫 게시글 작성', '첫 게시글을 작성했습니다. 앞으로 자주 올리겠습니다.');
INSERT INTO board (user_id, title, content) VALUES (2, '두 번째 게시글', '두 번째 게시글입니다. 댓글 많이 달아주세요.');
INSERT INTO board (user_id, title, content) VALUES (3, '안녕하세요', '안녕하세요, 오늘도 즐거운 하루 되세요.');

-- comments 테이블에 샘플 데이터 삽입
INSERT INTO comments (board_id, user_id, content) VALUES (1, 2, '자바의 장점에 대해 잘 읽었습니다.');
INSERT INTO comments (board_id, user_id, content) VALUES (1, 3, '좋은 글 감사합니다.');
INSERT INTO comments (board_id, user_id, content) VALUES (2, 1, '파이썬과 머신러닝에 관한 글 잘 봤습니다.');
INSERT INTO comments (board_id, user_id, content) VALUES (2, 3, '유익한 정보 감사합니다.');
INSERT INTO comments (board_id, user_id, content) VALUES (3, 1, '자바스크립트에 대해 더 알고 싶습니다.');
INSERT INTO comments (board_id, user_id, content) VALUES (3, 2, '도움이 많이 되었습니다.');

-- 데이터 확인
SELECT * FROM users;
SELECT * FROM board;
SELECT * FROM comments;

SELECT * FROM comments ORDER BY created_at DESC;

-- 게시글 12개 --> 3개씩 --> 4페이지

-- 페이징 처리 쿼리 만들어 보기
select * from board
order by create_at asc
limit 3 offset 3;

-- 1page 요청 시 offset 0 부터 시작(개수 3개) -- 1,2,3
-- 2page 요청 시 offset 3 부터 시작(개수 3개) -- 4,5,6
-- 3page 요청 시 offset 6 부터 시작(개수 3개) -- 7,8,9

-- 보드에 username 표시 되도록
SELECT c.*, u.username 
FROM comments as c
JOIN users as u on c.user_id = u.id
WHERE board_id = 3 
ORDER BY c.created_at DESC;

select * from board where id = 3;
select username from users where id = 1;

-- 보드에 댓글에서 댓글이 추가되도록


