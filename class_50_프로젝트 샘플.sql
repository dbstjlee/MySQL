create database db_greenboard;
use db_greenboard;

SELECT u.*,
        CASE WHEN sd.name IS NOT NULL THEN sd.name
        WHEN sf.name IS NOT NULL THEN sf.name
        WHEN p.name IS NOT NULL THEN p.name
        END AS name
        FROM user_tb AS u
        LEFT JOIN
        student_tb AS sd
        ON u.id = sd.id
        LEFT JOIN staff_tb AS sf
        ON u.id = sf.id
        LEFT JOIN professor_tb AS p
        ON u.id = p.id
        where u.id = 230001;

update user_tb set password = '123123' where id = 230001;
select * from user_tb;
select * from student_tb;
select * from professor_tb;
select * from staff_tb;

select s.id, s.name, s.birth_date, s.gender, s.address, s.tel, s.email, s.grade, s.semester, s.entrance_date, s.graduation_date, d.name as deptname, c.name as collname 
from student_tb as s join department_tb as d on s.dept_id = d.id
join college_tb as c on c.id = d.college_id where s.id = 2023000001;

select p.id, p.name, p.birth_date, p.gender, p.address, p.tel, p.email, d.name as deptname, c.name as collname
from professor_tb as p join department_tb as d on p.dept_id = d.id
join college_tb as c on c.id = d.college_id where p.id = 23000001;

select * from staff_tb WHERE id = 230001;

update student_tb set address = '부산시 남구', tel = '010-5267-1815', email = 'psw@green.com' where id = 2023000001;


select * from student_tb WHERE id = 2023000001;
select * from professor_tb WHERE id = 23000001;

SELECT * FROM staff_tb WHERE id = 230001;



update professor_tb set address = '부산시 부산진구', tel = '010-5277-0535', email = 'tenco@green.com' where id = 23000001;

select * from user_tb;
select * from student_tb;
select * from professor_tb;
select * from staff_tb;
select * from college_tb;
select * from stu_stat_tb;
select * from department_tb;
select * from stu_sub_detail_tb;
select * from stu_sch_tb;
select * from schedule_tb;

SELECT * FROM schedule_tb ORDER BY id limit 3 ;
SELECT * FROM schedule_tb limit 5; 

-- 학생의 이름, 이메일, 소속, 학년, 학기, 학적 상태 
select st.id, st.name, st.email, st.grade, st.semester, stat.status, dept.name as deptname from student_tb as st
join department_tb as dept on st.dept_id = dept.id
join stu_stat_tb as stat on st.id = stat.student_id
where stat.to_date = '9999-01-01' and st.id = 2023000001;


select student_id, status, from_date from stu_stat_tb where student_id = 2023000001;




select * from student_tb;

INSERT INTO schedule_tb(staff_id, start_day, end_day, information) values ('230001', '2024-05-06', '2024-05-06', 'DFDFD' );

-- 단과대
CREATE TABLE college_tb
(
   id INT PRIMARY KEY AUTO_INCREMENT,
   name VARCHAR (10) NOT NULL UNIQUE
);

-- 학과
CREATE TABLE department_tb
(
   id INT PRIMARY KEY AUTO_INCREMENT,
   name VARCHAR (10) NOT NULL UNIQUE,
   college_id INT NOT NULL COMMENT '단과대 id',
   FOREIGN KEY (college_id) REFERENCES college_tb (id) ON DELETE CASCADE
);
ALTER TABLE department_tb AUTO_INCREMENT = 101;

-- 사용자
CREATE TABLE user_tb
(
   id INT PRIMARY KEY,
   password VARCHAR (255) NOT NULL,
   user_role VARCHAR (10) NOT NULL
);

-- 학생
CREATE TABLE student_tb
(
   id INT PRIMARY KEY AUTO_INCREMENT COMMENT '학번',
   name VARCHAR (30) NOT NULL,
   birth_date DATE NOT NULL,
   gender CHAR (2) NOT NULL COMMENT '남성, 여성',
   address VARCHAR (100) NOT NULL,
   tel VARCHAR (13) NOT NULL,
   email VARCHAR (30) NOT NULL,
   dept_id INT NOT NULL COMMENT '학과',
   grade INT NOT NULL DEFAULT 1 COMMENT '학년',
   semester INT NOT NULL DEFAULT 1 COMMENT '학기',
   entrance_date DATE NOT NULL,
   graduation_date DATE,
   FOREIGN KEY (dept_id) REFERENCES department_tb (id) ON DELETE CASCADE
);
ALTER TABLE student_tb AUTO_INCREMENT = 2023000001;

-- 교직원
CREATE TABLE staff_tb
(
   id INT PRIMARY KEY AUTO_INCREMENT,
   name VARCHAR (30) NOT NULL,
   birth_date DATE NOT NULL,
   gender CHAR (2) NOT NULL COMMENT '남성, 여성',
   address VARCHAR (100) NOT NULL,
   tel VARCHAR (13) NOT NULL,
   email VARCHAR (30) NOT NULL,
   hire_date DATE DEFAULT (current_date)
);
ALTER TABLE staff_tb AUTO_INCREMENT = 230001;

-- 교수
CREATE TABLE professor_tb
(
   id INT PRIMARY KEY AUTO_INCREMENT,
   name VARCHAR (30) NOT NULL,
   birth_date DATE NOT NULL,
   gender CHAR (2) NOT NULL COMMENT '남성, 여성',
   address VARCHAR (100) NOT NULL,
   tel VARCHAR (13) NOT NULL,
   email VARCHAR (30) NOT NULL,
   dept_id INT NOT NULL,
   hire_date DATE DEFAULT (current_date),
   FOREIGN KEY (dept_id) REFERENCES department_tb (id) ON DELETE CASCADE
);
ALTER TABLE professor_tb AUTO_INCREMENT = 23000001;

-- 강의실
CREATE TABLE room_tb
(
   id VARCHAR (5) PRIMARY KEY,
   college_id INT NOT NULL,
   FOREIGN KEY (college_id) REFERENCES college_tb (id) ON DELETE CASCADE
);

-- 강의
CREATE TABLE subject_tb
(
   id INT PRIMARY KEY AUTO_INCREMENT,
   name VARCHAR (20) NOT NULL,
   professor_id INT NOT NULL,
   room_id VARCHAR (5),
   dept_id INT NOT NULL,
   type VARCHAR (2) NOT NULL COMMENT '강의 구분 (전공, 교양)',
   sub_year INT NOT NULL COMMENT '연도',
   semester INT NOT NULL COMMENT '학기',
   sub_day VARCHAR (1) NOT NULL COMMENT '요일',
   start_time INT NOT NULL COMMENT '시작 시간',
   end_time INT NOT NULL COMMENT '종료 시간',
   grades INT NOT NULL COMMENT '이수 학점',
   capacity INT NOT NULL COMMENT '수강 정원',
   num_of_student INT NOT NULL DEFAULT 0 COMMENT '현재 신청 인원',
   FOREIGN KEY (professor_id) REFERENCES professor_tb (id) ON DELETE CASCADE,
   FOREIGN KEY (room_id) REFERENCES room_tb (id) ON DELETE CASCADE,
   FOREIGN KEY (dept_id) REFERENCES department_tb (id) ON DELETE CASCADE
);
select * from subject_tb;

-- 과목 id 10000부터
ALTER TABLE subject_tb AUTO_INCREMENT = 10000;

-- 환산 점수
CREATE TABLE grade_tb
(
   grade VARCHAR (2) PRIMARY KEY COMMENT '학점 (평점)',
   grade_value FLOAT NOT NULL COMMENT '환산 점수'
);
select * from pre_stu_sub_tb;

-- 수강 신청
CREATE TABLE pre_stu_sub_tb
(
   student_id INT,
   subject_id INT,
   PRIMARY KEY
   (
      student_id,
      subject_id
   ),
   FOREIGN KEY (student_id) REFERENCES student_tb (id) ON DELETE CASCADE,
   FOREIGN KEY (subject_id) REFERENCES subject_tb (id) ON DELETE CASCADE
);

-- 수강 내역
CREATE TABLE stu_sub_tb(
	id INT PRIMARY KEY  AUTO_INCREMENT,
   student_id INT,
   subject_id INT,
   grade VARCHAR (2) COMMENT '신청 학점 (평점)',
   complete_grade INT COMMENT '이수 학점',
   FOREIGN KEY (student_id) REFERENCES student_tb (id) ON DELETE CASCADE,
   FOREIGN KEY (subject_id) REFERENCES subject_tb (id) ON DELETE CASCADE,
   FOREIGN KEY (grade) REFERENCES grade_tb (grade)
);

-- 단과대별 등록금
CREATE TABLE coll_tuit_tb
(
   college_id INT PRIMARY KEY,
   amount INT NOT NULL,
   FOREIGN KEY (college_id) REFERENCES college_tb (id) ON DELETE CASCADE
);

-- 장학금
CREATE TABLE scholarship_tb
(
   type INT PRIMARY KEY COMMENT '장학금 유형',
   max_amount INT NOT NULL COMMENT '최대 지원 금액'
);

-- 학생별 장학금 유형
CREATE TABLE stu_sch_tb
(
   student_id INT NOT NULL,
   sch_year INT NOT NULL COMMENT '지원 연도',
   semester INT NOT NULL COMMENT '지원 학기',
   sch_type INT COMMENT '장학금 유형',
   PRIMARY KEY
   (
      student_id,
      sch_year,
      semester
   ),
   FOREIGN KEY (sch_type) REFERENCES scholarship_tb (type)
);

-- 등록금
CREATE TABLE tuition_tb
(
   student_id INT,
   tui_year INT NOT NULL COMMENT '등록 연도',
   semester INT NOT NULL COMMENT '등록 학기',
   tui_amount INT NOT NULL COMMENT '등록금',
   sch_type INT COMMENT '장학금 유형',
   sch_amount INT COMMENT '장학금',
   status BOOLEAN DEFAULT false COMMENT '납부 여부',
   PRIMARY KEY
   (
      student_id,
      tui_year,
      semester
   ),
   FOREIGN KEY (student_id) REFERENCES student_tb (id) ON DELETE CASCADE,
   FOREIGN KEY (sch_type) REFERENCES scholarship_tb (type)
);

-- 공지사항
CREATE TABLE notice_tb
(
   id INT PRIMARY KEY AUTO_INCREMENT,
   category VARCHAR (10) NOT NULL,
   title VARCHAR (255) NOT NULL,
   content TEXT NOT NULL,
   created_time TIMESTAMP DEFAULT now(),
   views INT NOT NULL DEFAULT 0 COMMENT '조회수'
);

-- 공지사항 첨부 파일
CREATE TABLE notice_file_tb
(
   notice_id INT NOT NULL,
   origin_filename VARCHAR (100) COMMENT '기존 파일명' NOT NULL,
   uuid_filename VARCHAR (255) COMMENT '랜덤 문자열 포함 파일명' NOT NULL,
   FOREIGN KEY (notice_id) REFERENCES notice_tb (id) ON DELETE CASCADE
);

-- 휴학 신청 내역
CREATE TABLE break_app_tb
(
   id INT PRIMARY KEY AUTO_INCREMENT,
   student_id INT NOT NULL,
   student_grade INT NOT NULL,
   from_year INT NOT NULL,
   from_semester INT NOT NULL,
   to_year INT NOT NULL,
   to_semester INT NOT NULL,
   type VARCHAR (10) NOT NULL COMMENT '일반, 임신·출산·육아, 질병, 창업, 군입대',
   app_date DATE DEFAULT (current_date) NOT NULL COMMENT '신청 일자',
   status VARCHAR (3) NOT NULL DEFAULT '처리중' COMMENT '처리중, 승인, 거부',
   FOREIGN KEY (student_id) REFERENCES student_tb (id) ON DELETE CASCADE
);

-- 학적 상태
CREATE TABLE stu_stat_tb
(
   id INT PRIMARY KEY AUTO_INCREMENT,
   student_id INT NOT NULL,
   status VARCHAR (3) NOT NULL DEFAULT '재학', -- 재학, 휴학, 졸업, 자퇴
   from_date DATE,
   to_date DATE, -- 현재 속한 상태인 경우 '9999-01-01'
   break_app_id INT,
   FOREIGN KEY (student_id) REFERENCES student_tb (id) ON DELETE CASCADE,
   FOREIGN KEY (break_app_id) REFERENCES break_app_tb (id) ON DELETE CASCADE
);

CREATE TABLE stu_sub_detail_tb
(
   id INT PRIMARY KEY,
   student_id INT NOT NULL,
   subject_id INT NOT NULL,
   absent INT COMMENT '결석 횟수',
   lateness INT COMMENT '지각 횟수',
   homework INT COMMENT '과제 점수',
   mid_exam INT COMMENT '중간고사 점수',
   final_exam INT COMMENT '기말고사 점수',
   converted_mark INT COMMENT '환산점수',
   FOREIGN KEY (id) REFERENCES stu_sub_tb(id) ON DELETE CASCADE,
   FOREIGN KEY (student_id) REFERENCES student_tb(id) ON DELETE CASCADE,
   FOREIGN KEY (subject_id) REFERENCES subject_tb(id) ON DELETE CASCADE
);

CREATE TABLE syllabus_tb
(
	subject_id INT PRIMARY KEY ,
	overview VARCHAR(255) COMMENT '수업 개요',
	objective VARCHAR(255) COMMENT '강의 목표',
	textbook VARCHAR(30) COMMENT '교재',
	program TEXT COMMENT '주별 계획',
	FOREIGN KEY (subject_id) REFERENCES subject_tb(id) ON DELETE CASCADE
);

-- 강의 평가 테이블
CREATE TABLE evaluation_tb
(
evaluation_id INT AUTO_INCREMENT,
student_id INT,
subject_id INT,
PRIMARY KEY
(
evaluation_id,
student_id,
subject_id
),
answer1 INT NOT NULL COMMENT '응답',
answer2 INT NOT NULL,
answer3 INT NOT NULL,
answer4 INT NOT NULL,
answer5 INT NOT NULL,
answer6 INT NOT NULL,
answer7 INT NOT NULL,
improvements VARCHAR(255) COMMENT '건의사항',
FOREIGN KEY (student_id) REFERENCES student_tb (id) ON DELETE CASCADE,
FOREIGN KEY (subject_id) REFERENCES subject_tb (id) ON DELETE CASCADE
);

-- 질문지 내용 테이블
CREATE TABLE question_tb
(
id INT PRIMARY KEY AUTO_INCREMENT,
question1 VARCHAR(100) NOT NULL COMMENT '질문 내용',
question2 VARCHAR(100) NOT NULL,
question3 VARCHAR(100) NOT NULL,
question4 VARCHAR(100) NOT NULL,
question5 VARCHAR(100) NOT NULL,
question6 VARCHAR(100) NOT NULL,
question7 VARCHAR(100) NOT NULL,
sug_content VARCHAR(255) NOT NULL
);

-- 학사일정
CREATE TABLE schedule_tb(
id INT PRIMARY KEY AUTO_INCREMENT,
staff_id INT,
start_day DATE NOT NULL,
end_day DATE NOT NULL,
information VARCHAR(50) NOT NULL,
FOREIGN KEY (staff_id) REFERENCES staff_tb(id) 
);

SELECT * FROM tuition_tb;

-- 대학
INSERT INTO college_tb VALUES (1, '공과대학');
INSERT INTO college_tb VALUES (2, '인문대학');
INSERT INTO college_tb VALUES (3, '사회과학대학');
INSERT INTO college_tb VALUES (4, '상경대학');


-- 학과
INSERT INTO department_tb (name, college_id)
VALUES 
('컴퓨터공학과', 1),
('전자공학과', 1),
('화학공학과', 1),
('기계공학과', 1),
('신소재공학과', 1);

INSERT INTO department_tb
VALUES 
(106, '철학과', 2),
(107, '국사학과', 2),
(108, '언어학과', 2),
(109, '국어국문학과', 2),
(110, '영어영문학과', 2);

INSERT INTO department_tb
VALUES
(111, '심리학과', 3),
(112, '정치외교학과', 3),
(113, '사회복지학과', 3),
(114, '언론정보학과', 3),
(115, '인류학과', 3);

INSERT INTO department_tb VALUES
(116, '경영학과', 4),
(117, '경제학과', 4),
(118, '회계학과', 4),
(119, '농업경영학과', 4),
(120, '무역학과', 4);


-- 강의실
INSERT INTO room_tb (id, college_id)
VALUES 
('E601',1), ('E602',1), ('E701',1), ('E702',1), ('E801',1),
('E802',1), ('E901',1), ('E902',1), ('E904',1), ('E905',1);

INSERT INTO room_tb
VALUES 
('H101', 2), ('H102', 2), ('H103', 2), ('H104', 2), ('H201', 2),
('H202', 2), ('H203', 2), ('H204', 2), ('H301', 2), ('H302', 2);

INSERT INTO room_tb (id, college_id)
VALUES
('S301', 3), ('S302', 3), ('S303', 3), ('S304', 3), ('S305', 3),
('S306', 3), ('S307', 3), ('S308', 3), ('S309', 3), ('S310', 3);

INSERT INTO room_tb VALUES
('C301', 4), ('C302', 4), ('C303', 4), ('C304', 4), ('C305', 4);


-- 교수
INSERT INTO professor_tb(name, birth_date, gender, address, tel, email, dept_id)
VALUES
('김근호', '1985-08-01', '남성', '부산시 부산진구', '010-5277-0535', 'tenco@green.com', 101),
('이치승', '1960-11-04', '남성', '부산시 수영구', '010-5241-7184', 'lcs@green.com', 101),
('김미정', '1971-10-19', '여성', '부산시 북구', '010-1162-9586', 'kmj@green.com', 102),
('전대영', '1962-08-30', '남성', '부산시 동래구', '010-9938-8571', 'jdy@green.com', 102),
('김효린', '1980-09-01', '여성', '부산시 해운대구', '010-8520-1748', 'khr@green.com', 103),
('김현우', '1948-11-11', '남성', '부산시 해운대구', '010-1024-7785', 'khw@green.com', 103),
('정다운', '1966-04-24', '남성', '부산시 강서구', '010-1642-9966', 'jdw@green.com', 104),
('손주이', '1973-10-09', '여성', '부산시 수영구', '010-3425-8896', 'sjy@green.com', 104),
('이현서', '1983-02-27', '남성', '부산시 영도구', '010-2025-5748', 'lhs@green.com', 105),
('이지운', '1957-01-18', '여성', '부산시 사하구', '010-1566-9486', 'ljw@green.com', 105);

INSERT INTO professor_tb
VALUES 
(23000011, '구평회', '1985-03-12', '남성', '부산시 남구', '010-6356-2325', 'asdfqwe11@nate.com', 106, '2023-01-01'),
(23000012, '김선우', '1991-12-14', '남성', '부산시 남구', '010-5234-1234', 'as5435@nate.com', 106, '2023-01-01'),
(23000013, '이유신', '1990-05-14', '남성', '부산시 남구', '010-3423-3476', 'hfgdfg44@nate.com', 107, '2023-01-01'),
(23000014, '고시근', '1981-08-21', '남성', '부산시 남구', '010-6765-6734', 'gvcfg4325@nate.com', 107, '2023-01-01'),
(23000015, '김영진', '1976-06-03', '남성', '부산시 남구', '010-6345-3654', 'hgrds455@nate.com', 108, '2023-01-01'),
(23000016, '이운식', '1979-05-04', '남성', '부산시 남구', '010-8642-9776', 'dfhyurewr444@nate.com', 108, '2023-01-01'),
(23000017, '김민수', '1978-11-07', '남성', '부산시 남구', '010-3456-7456', 'alstn134@nate.com', 109, '2023-01-01'),
(23000018, '이지환', '1987-10-25', '남성', '부산시 남구', '010-5423-6565', 'wlghks344@nate.com', 109, '2023-01-01'),
(23000019, '서원철', '1988-06-27', '남성', '부산시 남구', '010-8654-8644', 'dnjscjf345@nate.com', 110, '2023-01-01'),
(23000020, '이유신', '1991-08-30', '남성', '부산시 남구', '010-2345-4574', 'dsdfgert34@nate.com', 110, '2023-01-01');

INSERT INTO professor_tb (id, name, birth_date, gender, address, tel, email, dept_id, hire_date) 
VALUES
(23000021, '한소영', '1970-02-23', '여성', '부산시 수영구 광안동', '010-3801-2721', 'yoyo@nate.com', 111, (current_date)),
(23000022, '전혜진', '1970-02-23', '여성', '부산시 수영구 광안동', '010-5801-7542', 'dodrl10@naver.com', 111, (current_date)),
(23000023, '박두식', '1970-02-23', '남성', '부산시 수영구 광안동', '010-9901-2363', 'yola@Gmail.com', 112, (current_date)),
(23000024, '김현식', '1970-02-23', '남성', '부산시 수영구 광안동', '010-9401-3244', 'ropo@naver.com', 112, (current_date)),
(23000025, '이찬호', '1970-02-23', '남성', '부산시 수영구 광안동', '010-3801-7005', 'qpelo94@naver.com', 113, (current_date)),
(23000026, '박진영', '1970-02-23', '남성', '부산시 수영구 광안동', '010-2701-8006', 'aoco@nate.com', 113, (current_date)),
(23000027, '박준서', '1970-02-23', '남성', '부산시 수영구 광안동', '010-5901-2007', 'qpwok@naver.com', 114, (current_date)),
(23000028, '김정훈', '1970-02-23', '남성', '부산시 수영구 광안동', '010-2901-3008', 'adoo1055@naver.com', 114, (current_date)),
(23000029, '유하준', '1970-02-23', '남성', '부산시 수영구 광안동', '010-2001-6009', 'qpwo4699@naver.com', 115, (current_date)),
(23000030, '강지섭', '1970-02-23', '남성', '부산시 수영구 광안동', '010-7301-5001', 'porll@naver.com', 115, (current_date));

INSERT INTO professor_tb 
VALUES
(23000031, '마이클 포터', '1970-02-23', '남성', '부산시 동래구 사직동', '010-1212-1212', 'porter@green.ac.kr', 116, (current_date)),
(23000032, '피터 드러커', '1972-03-23', '남성', '부산시 금정구 장전동', '010-1212-1213', 'pd1@green.ac.kr', 116, (current_date)),
(23000033, '아담 스미스', '1971-05-24', '남성', '부산시 동래구 명륜동', '010-1212-1214', 'invisiblehand@green.ac.kr', 117, (current_date)),
(23000034, '존 케인즈', '1978-11-11', '남성', '양산시 덕계동', '010-1212-1222', 'neoliberal@green.ac.kr', 117, (current_date)),
(23000035, '최삼정', '1974-07-13', '여성', '부산시 금정구 청룡동 ', '010-1212-1232', 'kpmg@green.ac.kr', 118, (current_date)),
(23000036, '안진동', '1970-02-23', '남성', '부산시 금정구 구서동', '010-1212-1242', 'deloitte@green.ac.kr', 118, (current_date)),
(23000037, '우장춘', '1966-04-30', '남성', '부산시 동래구 사직동', '010-1212-1312', 'watermelon@green.ac.kr', 119, (current_date)),
(23000038, '문익점', '1971-06-23', '남성', '양산시 명동', '010-1212-1412', 'moka@green.ac.kr', 119, (current_date)),
(23000039, '김은영', '1978-09-03', '여성', '부산시 동래구 온천동', '010-1212-1512', 'silver@green.ac.kr', 120, (current_date)),
(23000040, '이선영', '1973-05-26', '여성', '부산시 동래구 안락동', '010-1212-1612', 'line@green.ac.kr', 120, (current_date));

INSERT INTO user_tb
VALUES 
(23000001, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'professor'),
(23000002, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'professor'),
(23000003, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'professor'),
(23000004, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'professor'),
(23000005, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'professor'),
(23000006, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'professor'),
(23000007, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'professor'),
(23000008, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'professor'),
(23000009, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'professor'),
(23000010, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'professor');

INSERT INTO user_tb
VALUES 
(23000011, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'professor'),
(23000012, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'professor'),
(23000013, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'professor'),
(23000014, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'professor'),
(23000015, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'professor'),
(23000016, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'professor'),
(23000017, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'professor'),
(23000018, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'professor'),
(23000019, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'professor'),
(23000020, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'professor');

INSERT INTO user_tb
VALUES
(23000021, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'professor'),
(23000022, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'professor'),
(23000023, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'professor'),
(23000024, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'professor'),
(23000025, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'professor'),
(23000026, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'professor'),
(23000027, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'professor'),
(23000028, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'professor'),
(23000029, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'professor'),
(23000030, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'professor');

INSERT INTO user_tb VALUES
(23000031, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'professor'),
(23000032, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'professor'),
(23000033, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'professor'),
(23000034, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'professor'),
(23000035, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'professor'),
(23000036, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'professor'),
(23000037, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'professor'),
(23000038, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'professor'),
(23000039, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'professor'),
(23000040, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'professor');


-- 강의
INSERT INTO subject_tb (name, professor_id, room_id, dept_id, type, sub_year, semester, sub_day, start_time, end_time, grades, capacity)
VALUES
('데이터통신', 23000001, 'E601', 101, '전공', 2023, 1, '월', 14, 17, 3, 20),
('딥러닝의 기초', 23000001, 'E601', 101, '전공', 2023, 1, '수', 9, 12, 3, 20),
('컴퓨터의 개념 및 실습', 23000002, 'E602', 101, '교양', 2023, 1, '화', 10, 12, 2, 30),
('컴퓨터 프로그래밍', 23000002, 'E602', 101, '전공', 2023, 1, '금', 15, 18, 3, 20),
('공학설계 입문', 23000003, 'E701', 102, '전공', 2023, 1, '목', 9, 12, 3, 20),
('반도체 공학', 23000003, 'E701', 102, '전공', 2023, 1, '목', 14, 17, 3, 20),
('융합전자연구', 23000004, 'E702', 102, '전공', 2023, 1, '금', 14, 17, 3, 20),
('기초 전기실험', 23000004, 'E702', 102, '전공', 2023, 1, '월', 14, 17, 3, 20),
('물리화학', 23000005, 'E801', 103, '전공', 2023, 1, '목', 12, 15, 3, 20),
('반응공학', 23000005, 'E801', 103, '전공', 2023, 1, '수', 12, 15, 3, 20),
('사고와 표현', 23000006, 'E802', 103, '교양', 2023, 1, '화', 11, 13, 2, 30),
('과학과 기술', 23000006, 'E802', 103, '교양', 2023, 1, '화', 13, 15, 2, 30),
('고체역학', 23000007, 'E901', 104, '전공', 2023, 1, '월', 13, 16, 3, 20),
('자유정의진리', 23000007, 'E901', 104, '교양', 2023, 1, '화', 9, 11, 2, 30),
('정보적 사고', 23000008, 'E902', 104, '교양', 2023, 1, '목', 9, 11, 2, 30),
('CAD기초', 23000008, 'E902', 104, '전공', 2023, 1, '화', 13, 15, 2, 20),
('에너지재료', 23000009, 'E904', 105, '전공', 2023, 1, '수', 11, 14, 3, 30),
('나노재료합성', 23000009, 'E904', 105, '전공', 2023, 1, '목', 11, 14, 3, 30),
('신소재공학개론', 23000010, 'E905', 105, '전공', 2023, 1, '월', 9, 12, 3, 30),
('신소재기초실습', 23000010, 'E905', 105, '전공', 2023, 1, '월', 13, 16, 3, 30);

INSERT INTO subject_tb 
VALUES
(10020, '칸트철학', 23000011, 'H101', 106, '전공', 2023, 1, '월', 15, 18, 3, 25, 0),
(10021, '불교철학사', 23000011, 'H101', 106, '전공', 2023, 1, '화', 09, 12, 3, 25, 0),
(10022, '대륙합리론', 23000012, 'H102', 106, '전공', 2023, 1, '수', 10, 13, 3, 20, 0),
(10023, '심리철학', 23000012, 'H102', 106, '교양', 2023, 1, '목', 14, 16, 2, 50, 0),
(10024, '역사학개론', 23000013, 'H103', 107, '전공', 2023, 1, '월', 13, 16, 3, 25, 0),
(10025, '동아시아사', 23000013, 'H103', 107, '전공', 2023, 1, '화', 11, 14, 3, 25, 0),
(10026, '한국근대사', 23000014, 'H104', 107, '전공', 2023, 1, '금', 13, 16, 3, 20, 0),
(10027, '한국사입문', 23000014, 'H104', 107, '교양', 2023, 1, '목', 10, 12, 2, 50, 0),
(10028, '의미론', 23000015, 'H201', 108, '전공', 2023, 1, '월', 10, 13, 3, 25, 0),
(10029, '형태론', 23000015, 'H201', 108, '전공', 2023, 1, '화', 14, 17, 3, 25, 0),
(10030, '컴퓨터언어학', 23000016, 'H202', 108, '전공', 2023, 1, '수', 13, 16, 3, 20, 0),
(10031, '이태리어', 23000016, 'H202', 108, '교양', 2023, 1, '금', 09, 11, 2, 50, 0),
(10032, '고전문학연습', 23000017, 'H203', 109, '전공', 2023, 1, '월', 15, 18, 3, 25, 0),
(10033, '국어정서법', 23000017, 'H203', 109, '전공', 2023, 1, '화', 12, 15, 3, 25, 0),
(10034, '한국현대작가론', 23000018, 'H204', 109, '전공', 2023, 1, '수', 09, 12, 3, 20, 0),
(10035, '국문학개론', 23000018, 'H204', 109, '교양', 2023, 1, '목', 16, 18, 2, 50, 0),
(10036, '중세영문학', 23000019, 'H301', 110, '전공', 2023, 1, '금', 13, 16, 3, 25, 0),
(10037, '영어발달사', 23000019, 'H301', 110, '전공', 2023, 1, '목', 10, 13, 3, 25, 0),
(10038, '현대영국소설론', 23000020, 'H302', 110, '전공', 2023, 1, '수', 13, 16, 3, 20, 0),
(10039, '영문학입문', 23000020, 'H302', 110, '교양', 2023, 1, '화', 15, 17, 2, 50, 0);

INSERT INTO subject_tb (id, name, professor_id, room_id, dept_id, type, sub_year, semester, sub_day, start_time, end_time, grades, capacity)
VALUES
(10040, '일반심리학', 23000021, 'S301', 111, '전공', 2023, 1, '월', 9, 12, 3, 10),
(10041, '적응심리학', 23000021, 'S301', 111, '전공', 2023, 1, '화', 9, 12, 3, 10),
(10042, '성격심리학', 23000022, 'S302', 111, '전공', 2023, 1, '수', 9, 12, 3, 10),
(10043, '인지심리학', 23000022, 'S302', 111, '전공', 2023, 1, '목', 9, 12, 3, 10),
(10044, '비교정치론', 23000023, 'S303', 112, '전공', 2023, 1, '월', 9, 12, 3, 10),
(10045, '외교정책론', 23000023, 'S303', 112, '전공', 2023, 1, '화', 9, 12, 3, 10),
(10046, '국제정치경제론', 23000024, 'S304', 112, '전공', 2023, 1, '수', 9, 12, 3, 10),
(10047, '한국정치론', 23000024, 'S304', 112, '전공', 2023, 1, '목', 9, 12, 3, 10),
(10048, '현대사회심리', 23000025, 'S305', 113, '전공', 2023, 1, '월', 9, 12, 3, 10),
(10049, '인간행동과 사회환경', 23000025, 'S305', 113, '전공', 2023, 1, '화', 9, 12, 3, 10),
(10050, '사회복지학개론', 23000026, 'S306', 113, '전공', 2023, 1, '수', 9, 12, 3, 10),
(10051, '사회복지행정론', 23000026, 'S306', 113, '전공', 2023, 1, '목', 9, 12, 3, 10),
(10052, '언론정보학개론', 23000027, 'S307', 114, '전공', 2023, 1, '월', 9, 12, 3, 10),
(10053, '방송의이해', 23000027, 'S307', 114, '전공', 2023, 1, '화', 9, 12, 3, 10),
(10054, '광고의이해', 23000028, 'S308', 114, '전공', 2023, 1, '수', 9, 12, 3, 10),
(10055, '한국언론사', 23000028, 'S308', 114, '전공', 2023, 1, '목', 9, 12, 3, 10),
(10056, '문화인류학', 23000029, 'S309', 115, '전공', 2023, 1, '월', 9, 12, 3, 10),
(10057, '세계화와 다문화주의', 23000029, 'S309', 115, '전공', 2023, 1, '화', 9, 12, 3, 10),
(10058, '의료인류학', 23000030, 'S310', 115, '전공', 2023, 1, '수', 9, 12, 3, 10),
(10059, '도시와문화', 23000030, 'S310', 115, '전공', 2023, 1, '목', 9, 12, 3, 10);

INSERT INTO subject_tb (id, name, professor_id, room_id, dept_id, type, sub_year, semester, sub_day, start_time, end_time, grades, capacity)
VALUES
(10060, '기업경영의이해', 23000031, 'C301', 116, '전공', 2023, 1, '월', 9, 12, 3, 10), 
(10061, '경영학원론', 23000031, 'C301', 116, '전공', 2023, 1, '화', 9, 12, 3, 10),
(10062, '마케팅의 이해', 23000032, 'C301', 116, '전공', 2023, 1, '수', 9, 12, 3, 10),
(10063, '마케팅 조사론', 23000032, 'C301', 116, '전공', 2023, 1, '목', 9, 12, 3, 10),
(10064, '경제학원론', 23000033, 'C302', 117, '전공', 2023, 1, '월', 9, 12, 3, 10),
(10065, '미시경제학', 23000033,'C302', 117, '전공', 2023, 1, '화', 9, 12, 3, 10),
(10066, '거시경제학', 23000034, 'C302', 117, '전공', 2023, 1, '수', 9, 12, 3, 10),
(10067, '신자유주의 경제학', 23000034, 'C302', 117, '전공', 2023, 1, '목', 9, 12, 3, 10),
(10068, '재무회계', 23000035, 'C303', 118, '전공', 2023, 1, '월', 9, 12, 3, 10),
(10069, '회계감사', 23000035, 'C303', 118, '전공', 2023, 1, '화', 9, 12, 3, 10),
(10070, '원가회계', 23000036, 'C303', 118, '전공', 2023, 1, '수', 9, 12, 3, 10),
(10071, '관리회계', 23000036, 'C303', 118, '전공', 2023, 1, '목', 9, 12, 3, 10),
(10072, '농업생산경제학', 23000037, 'C304', 119, '전공', 2023, 1, '월', 9, 12, 3, 10),
(10073, '농산물 가격분석', 23000037, 'C304', 119, '전공', 2023, 1, '화', 9, 12, 3, 10),
(10074, '농산물 유통학', 23000038, 'C304', 119, '전공', 2023, 1, '수', 9, 12, 3, 10),
(10075, '농업 정책론', 23000038, 'C304', 119, '전공', 2023, 1, '목', 9, 12, 3, 10),
(10076, '무역상무론', 23000039, 'C305', 120, '전공', 2023, 1, '월', 9, 12, 3, 10),
(10077, '국제경영학', 23000039, 'C305', 120, '전공', 2023, 1, '화', 9, 12, 3, 10),
(10078, '국제무역론 입문', 23000040, 'C305', 120, '전공', 2023, 1, '수', 9, 12, 3, 10),
(10079, '한국무역법', 23000040, 'C305', 120, '전공', 2023, 1, '목', 9, 12, 3, 10);


-- 강의계획서
INSERT INTO syllabus_tb (subject_id)
VALUES 
(10000), (10001), (10002), (10003), (10004), 
(10005), (10006), (10007), (10008), (10009), 
(10010), (10011), (10012), (10013), (10014),
(10015), (10016), (10017), (10018), (10019);

INSERT INTO syllabus_tb (subject_id)
VALUES 
(10020), (10021), (10022), (10023), (10024), 
(10025), (10026), (10027), (10028), (10029),
(10030), (10031), (10032), (10033), (10034), 
(10035), (10036), (10037), (10038), (10039);

INSERT INTO syllabus_tb (subject_id)
VALUES
(10040), (10041), (10042), (10043), (10044),
(10045), (10046), (10047), (10048), (10049), 
(10050), (10051), (10052), (10053), (10054),
(10055), (10056), (10057), (10058), (10059);

INSERT INTO syllabus_tb (subject_id) VALUES
(10060), (10061), (10062), (10063), (10064),
(10065), (10066), (10067), (10068), (10069), 
(10070), (10071), (10072), (10073), (10074),
(10075), (10076), (10077), (10078), (10079);

-- 교직원
INSERT INTO staff_tb (name, birth_date, gender, address, tel, email, hire_date)
VALUES
('박성희', '1995-09-03', '여성', '부산시 부산진구', '010-9930-2889', 'sungheepppp@gmail.com', '2023-01-01');

INSERT INTO staff_tb (name, birth_date, gender, address, tel, email, hire_date)
VALUES
('이서영', '2000-01-05', '여성', '부산시 수영구', '010-0743-3282', 'os010312@naver.com', '2023-01-01');

INSERT INTO staff_tb (name, birth_date, gender, address, tel, email, hire_date)
VALUES
('편용림','1992-07-07', '남성', '부산시 수영구 광안동', '010-2221-2221','yog4130@Gmail.com', '2023-01-01');

INSERT INTO staff_tb (name, birth_date, gender, address, tel, email, hire_date)
VALUES
('김지현', '1990-07-26', '남성', '경남 양산시', '010-9019-0369', 'jhkim900726@gmail.com', '2023-01-01');

INSERT INTO user_tb
VALUES (230001, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'staff');

INSERT INTO user_tb
VALUES (230002, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'staff');

INSERT INTO user_tb
VALUES (230003, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'staff');

INSERT INTO user_tb
VALUES (230004, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'staff');

-- 학생
INSERT INTO student_tb (name, birth_date, gender, address, tel, email, dept_id, grade, semester, entrance_date)
VALUES
('박시우', '2002-06-19', '남성', '부산시 남구', '010-5267-1815', 'psw@green.com', 101, 1, 1, '2021-03-02'),
('김예준', '2002-04-25', '남성', '부산시 북구', '010-4152-9963', 'kyj@green.com', 101, 1, 1, '2021-03-02'),
('김지우', '2002-11-15', '여성', '부산시 해운대구', '010-1526-8495', 'kjw@green.com', 101, 1, 1, '2021-03-02'),
('정수호', '2003-01-14', '남성', '부산시 북구', '010-2481-7553', 'jsh@green.com', 101, 1, 1, '2022-03-02'),
('김주원', '2003-06-19', '남성', '부산시 동구', '010-1052-4486', 'kjw2@green.com', 101, 1, 1, '2022-03-02'),
('이민서', '2003-12-29', '여성', '부산시 해운대구', '010-1096-7741', 'lms2@green.com', 101, 1, 1, '2022-03-02'),
('문건우', '2003-07-22', '남성', '부산시 해운대구', '010-0326-0926', 'mgw@green.com', 101, 1, 1, '2022-03-02'),
('정민준', '2004-06-02', '남성', '부산시 사하구', '010-0096-8196', 'jmj@green.com', 101, 1, 1, '2023-03-02'),
('전하은', '2003-04-28', '여성', '부산시 사하구', '010-7158-8852', 'jhe@green.com', 101, 1, 1, '2023-03-02'),
('김도현', '2003-09-29', '남성', '부산시 영도구', '010-1234-8592', 'kdh2@green.com', 101, 1, 1, '2023-03-02');

INSERT INTO student_tb (name, birth_date, gender, address, tel, email, dept_id, grade, semester, entrance_date)
VALUES
('차은우', '2002-07-04', '남성', '부산시 남구', '010-5267-0106', 'cew@green.com', 102, 1, 1, '2021-03-02'),
('박서준', '2002-04-26', '남성', '부산시 북구', '010-4152-9148', 'psj@green.com', 102, 1, 1, '2021-03-02'),
('이도윤', '2002-11-22', '남성', '부산시 해운대구', '010-1526-9962', 'ldw@green.com', 102, 1, 1, '2021-03-02'),
('강민지', '2003-01-01', '여성', '부산시 북구', '010-2481-7718', 'kmj11@green.com', 102, 1, 1, '2022-03-02'),
('윤진희', '2003-06-29', '여성', '부산시 동구', '010-1052-1014', 'yjh@green.com', 102, 1, 1, '2022-03-02'),
('김유준', '2003-12-30', '남성', '부산시 해운대구', '010-1096-0205', 'kyj09@green.com', 102, 1, 1, '2022-03-02'),
('이준우', '2003-07-11', '남성', '부산시 해운대구', '010-0326-7085', 'ljw@green.com', 102, 1, 1, '2022-03-02'),
('박연우', '2004-06-17', '남성', '부산시 사하구', '010-0096-1164', 'pyw@green.com', 102, 1, 1, '2023-03-02'),
('이윤서', '2003-04-03', '여성', '부산시 사하구', '010-7158-1992', 'lys08@green.com', 102, 1, 1, '2023-03-02'),
('신하윤', '2003-09-01', '여성', '부산시 영도구', '010-1234-4052', 'shy@green.com', 102, 1, 1, '2023-03-02');

INSERT INTO student_tb (name, birth_date, gender, address, tel, email, dept_id, grade, semester, entrance_date)
VALUES
('김현민', '2002-01-04', '남성', '부산시 남구', '010-4165-0106', 'khm@green.com', 103, 1, 1, '2021-03-02'),
('하준서', '2002-01-26', '남성', '부산시 북구', '010-1152-9148', 'hjs@green.com', 103, 1, 1, '2021-03-02'),
('김우진', '2002-02-22', '남성', '부산시 해운대구', '010-8295-9962', 'kwj@green.com', 103, 1, 1, '2021-03-02'),
('김예나', '2003-11-01', '여성', '부산시 북구', '010-8844-7718', 'kyn@green.com', 103, 1, 1, '2022-03-02'),
('윤태리', '2003-12-29', '여성', '부산시 동구', '010-7154-1014', 'ytr@green.com', 103, 1, 1, '2022-03-02'),
('이민재', '2003-09-30', '남성', '부산시 해운대구', '010-1693-0205', 'lmj87@green.com', 103, 1, 1, '2022-03-02'),
('정현준', '2003-05-11', '남성', '부산시 해운대구', '010-2356-7085', 'jhj2@green.com', 103, 1, 1, '2022-03-02'),
('정지호', '2004-05-17', '남성', '부산시 사하구', '010-8520-1164', 'jjh@green.com', 103, 1, 1, '2023-03-02'),
('이수아', '2003-02-03', '여성', '부산시 사하구', '010-0215-1992', 'lsa@green.com', 103, 1, 1, '2023-03-02'),
('김채원', '2003-08-01', '여성', '부산시 영도구', '010-0369-4052', 'kcw@green.com', 103, 1, 1, '2023-03-02');

INSERT INTO student_tb (name, birth_date, gender, address, tel, email, dept_id, grade, semester, entrance_date)
VALUES
('이지후', '2002-01-10', '남성', '부산시 남구', '010-2623-0106', 'ljh@green.com', 104, 1, 1, '2021-03-02'),
('윤정우', '2002-01-11', '남성', '부산시 북구', '010-1152-1625', 'yjw@green.com', 104, 1, 1, '2021-03-02'),
('김시윤', '2002-02-24', '남성', '부산시 해운대구', '010-1195-9962', 'ksy3@green.com', 104, 1, 1, '2021-03-02'),
('최서연', '2003-11-14', '여성', '부산시 북구', '010-8844-4185', 'csy@green.com', 104, 1, 1, '2022-03-02'),
('임지유', '2003-12-27', '여성', '부산시 동구', '010-7154-1166', 'lju@green.com', 104, 1, 1, '2022-03-02'),
('김유찬', '2003-09-02', '남성', '부산시 해운대구', '010-1748-0205', 'kyc@green.com', 104, 1, 1, '2022-03-02'),
('하준영', '2003-05-01', '남성', '부산시 해운대구', '010-2356-1234', 'hjw2@green.com', 104, 1, 1, '2022-03-02'),
('차지원', '2004-05-19', '남성', '부산시 사하구', '010-1928-1164', 'cjw9@green.com', 104, 1, 1, '2023-03-02'),
('이다인', '2003-02-14', '여성', '부산시 사하구', '010-0215-1614', 'ldi@green.com', 104, 1, 1, '2023-03-02'),
('김아린', '2003-08-24', '여성', '부산시 영도구', '010-0042-4052', 'kar@green.com', 104, 1, 1, '2023-03-02');

INSERT INTO student_tb (name, birth_date, gender, address, tel, email, dept_id, grade, semester, entrance_date)
VALUES
('정윤호', '2002-07-10', '남성', '부산시 남구', '010-1235-8495', 'jyh@green.com', 105, 1, 1, '2021-03-02'),
('이태윤', '2002-11-11', '남성', '부산시 북구', '010-1624-1625', 'lty@green.com', 105, 1, 1, '2021-03-02'),
('이재민', '2002-06-24', '남성', '부산시 해운대구', '010-1162-9962', 'ljm@green.com', 105, 1, 1, '2021-03-02'),
('박시연', '2003-08-14', '여성', '부산시 북구', '010-8844-1948', 'psy@green.com', 105, 1, 1, '2022-03-02'),
('정나윤', '2003-01-27', '여성', '부산시 동구', '010-7154-1245', 'jny@green.com', 105, 1, 1, '2022-03-02'),
('하준호', '2003-05-02', '남성', '부산시 해운대구', '010-1748-7548', 'hjh3@green.com', 105, 1, 1, '2022-03-02'),
('김나은', '2003-04-01', '남성', '부산시 해운대구', '010-2356-7410', 'kne@green.com', 105, 1, 1, '2022-03-02'),
('이한결', '2004-07-19', '남성', '부산시 사하구', '010-1928-0104', 'lhg@green.com', 105, 1, 1, '2023-03-02'),
('김서진', '2003-04-14', '여성', '부산시 사하구', '010-0215-0062', 'ksj12@green.com', 105, 1, 1, '2023-03-02'),
('김다빈', '2003-09-24', '여성', '부산시 영도구', '010-0042-4015', 'kdb@green.com', 105, 1, 1, '2023-03-02');

INSERT INTO student_tb
VALUES
(2023000051, '김민지', '2004-01-01', '여성', '부산시 기장군', '010-3423-0355', 'alswl@naver.com', 106, 1, 1, '2023-03-02', NULL),
(2023000052, '임소연', '2004-04-01', '여성', '부산시 기장군', '010-2344-0452', 'thdus@naver.com', 106, 1, 1, '2023-03-02', NULL),
(2023000053, '최지혜', '2004-06-02', '여성', '부산시 기장군', '010-6564-6370', 'wlgp@naver.com', 106, 1, 1, '2023-03-02', NULL),
(2023000054, '이서연', '2004-02-03', '여성', '부산시 기장군', '010-2325-1305', 'tjdus@naver.com', 106, 1, 1, '2023-03-02', NULL),
(2023000055, '노휘정', '2004-07-06', '여성', '부산시 기장군', '010-5445-3562', 'gnlwjd@naver.com', 106, 1, 1, '2023-03-02', NULL),
(2023000056, '서지혜', '2004-12-08', '여성', '부산시 기장군', '010-6654-8865', 'wlgptj@naver.com', 106, 1, 1, '2023-03-02', NULL),
(2023000057, '김한솔', '2004-11-07', '여성', '부산시 기장군', '010-7867-8768', 'gksthf@naver.com', 106, 1, 1, '2023-03-02', NULL),
(2023000058, '백선우', '2004-10-10', '여성', '부산시 기장군', '010-5465-9975', 'tjsdn@naver.com', 106, 1, 1, '2023-03-02', NULL),
(2023000059, '권희진', '2004-05-10', '여성', '부산시 기장군', '010-7676-7478', 'gmlwls@naver.com', 106, 1, 1, '2023-03-02', NULL),
(2023000060, '백수민', '2004-07-12', '여성', '부산시 기장군', '010-5424-2596', 'tnals@naver.com', 106, 1, 1, '2023-03-02', NULL),
(2023000061, '최성민', '2004-04-12', '여성', '부산시 기장군', '010-4534-4563', 'tjdals@naver.com', 107, 1, 1, '2023-03-02', NULL),
(2023000062, '이윤정', '2004-09-14', '여성', '부산시 기장군', '010-3247-9784', 'dbswjd@naver.com', 107, 1, 1, '2023-03-02', NULL),
(2023000063, '배수연', '2004-10-19', '여성', '부산시 기장군', '010-8965-4564', 'tndus@naver.com', 107, 1, 1, '2023-03-02', NULL),
(2023000064, '강윤지', '2004-10-17', '여성', '부산시 기장군', '010-3453-6775', 'dbswl@naver.com', 107, 1, 1, '2023-03-02', NULL),
(2023000065, '김예빈', '2004-12-15', '여성', '부산시 기장군', '010-4432-2234', 'dpqls@naver.com', 107, 1, 1, '2023-03-02', NULL),
(2023000066, '김하정', '2004-11-14', '여성', '부산시 기장군', '010-8778-5452', 'gkwjd@naver.com', 107, 1, 1, '2023-03-02', NULL),
(2023000067, '김지원', '2004-11-12', '여성', '부산시 기장군', '010-5464-4311', 'wldnjs@naver.com', 107, 1, 1, '2023-03-02', NULL),
(2023000068, '김현아', '2004-06-12', '여성', '부산시 기장군', '010-2346-3423', 'gusdk@naver.com', 107, 1, 1, '2023-03-02', NULL),
(2023000069, '박수현', '2004-07-03', '여성', '부산시 기장군', '010-8644-5634', 'tngus@naver.com', 107, 1, 1, '2023-03-02', NULL),
(2023000070, '송민정', '2004-08-05', '여성', '부산시 기장군', '010-5453-2354', 'alswjd@naver.com', 107, 1, 1, '2023-03-02', NULL),
(2023000071, '우해인', '2004-05-06', '여성', '부산시 기장군', '010-8675-4653', 'godls@naver.com', 108, 1, 1, '2023-03-02', NULL),
(2023000072, '엄세희', '2004-03-05', '여성', '부산시 기장군', '010-4364-2456', 'tpgml@naver.com', 108, 1, 1, '2023-03-02', NULL),
(2023000073, '이선아', '2004-02-02', '여성', '부산시 기장군', '010-4654-2357', 'tjsdk@naver.com', 108, 1, 1, '2023-03-02', NULL),
(2023000074, '이효주', '2004-01-21', '여성', '부산시 기장군', '010-8678-2955', 'gywn@naver.com', 108, 1, 1, '2023-03-02', NULL),
(2023000075, '임희영', '2004-01-24', '여성', '부산시 기장군', '010-9865-2346', 'gmldud@naver.com', 108, 1, 1, '2023-03-02', NULL),
(2023000076, '김기범', '2004-05-19', '남성', '부산시 기장군', '010-3246-7537', 'rlqja@naver.com', 108, 1, 1, '2023-03-02', NULL),
(2023000077, '이태형', '2004-08-18', '남성', '부산시 기장군', '010-5442-2423', 'xogud@naver.com', 108, 1, 1, '2023-03-02', NULL),
(2023000078, '김민철', '2004-07-16', '남성', '부산시 기장군', '010-3245-3523', 'alscjf@naver.com', 108, 1, 1, '2023-03-02', NULL),
(2023000079, '김준우', '2004-06-15', '남성', '부산시 기장군', '010-5435-3546', 'wnsdn@naver.com', 108, 1, 1, '2023-03-02', NULL),
(2023000080, '류영환', '2004-09-12', '남성', '부산시 기장군', '010-6546-2345', 'dudghks@naver.com', 108, 1, 1, '2023-03-02', NULL),
(2023000081, '박건현', '2004-10-23', '남성', '부산시 기장군', '010-4634-6734', 'rjsgus@naver.com', 109, 1, 1, '2023-03-02', NULL),
(2023000082, '박명찬', '2004-10-23', '남성', '부산시 기장군', '010-3434-7854', 'audcks@naver.com', 109, 1, 1, '2023-03-02', NULL),
(2023000083, '박세원', '2004-05-27', '남성', '부산시 기장군', '010-4367-4356', 'tpdnjs@naver.com', 109, 1, 1, '2023-03-02', NULL),
(2023000084, '박수현', '2004-05-26', '남성', '부산시 기장군', '010-7564-9663', 'tngus@naver.com', 109, 1, 1, '2023-03-02', NULL),
(2023000085, '박재현', '2004-05-24', '남성', '부산시 기장군', '010-6988-5783', 'wogus@naver.com', 109, 1, 1, '2023-03-02', NULL),
(2023000086, '박태호', '2004-03-20', '남성', '부산시 기장군', '010-7634-8563', 'xogh33@naver.com', 109, 1, 1, '2023-03-02', NULL),
(2023000087, '배용진', '2004-02-10', '남성', '부산시 기장군', '010-4535-7567', 'dydwls@naver.com', 109, 1, 1, '2023-03-02', NULL),
(2023000088, '서재영', '2004-01-13', '남성', '부산시 기장군', '010-6754-6573', 'wodud@naver.com', 109, 1, 1, '2023-03-02', NULL),
(2023000089, '성윤석', '2004-05-11', '남성', '부산시 기장군', '010-6545-3456', 'dbstjr@naver.com', 109, 1, 1, '2023-03-02', NULL),
(2023000090, '소제웅', '2004-07-17', '남성', '부산시 기장군', '010-4654-8645', 'wpdnd@naver.com', 109, 1, 1, '2023-03-02', NULL),
(2023000091, '손휘준', '2004-06-15', '남성', '부산시 기장군', '010-6547-6772', 'gnlwns@naver.com', 110, 1, 1, '2023-03-02', NULL),
(2023000092, '신종민', '2004-08-15', '남성', '부산시 기장군', '010-4536-8862', 'whdals@naver.com', 110, 1, 1, '2023-03-02', NULL),
(2023000093, '안지훈', '2004-05-11', '남성', '부산시 기장군', '010-7634-7743', 'wlgns@naver.com', 110, 1, 1, '2023-03-02', NULL),
(2023000094, '이건민', '2004-05-05', '남성', '부산시 기장군', '010-2323-5536', 'rjsals@naver.com', 110, 1, 1, '2023-03-02', NULL),
(2023000095, '이경섭', '2004-04-21', '남성', '부산시 기장군', '010-4323-1127', 'rudtjq@naver.com', 110, 1, 1, '2023-03-02', NULL),
(2023000096, '이병권', '2004-02-22', '남성', '부산시 기장군', '010-3242-1235', 'qudrnjs@naver.com', 110, 1, 1, '2023-03-02', NULL),
(2023000097, '이연수', '2004-05-23', '남성', '부산시 기장군', '010-2323-1331', 'dustn@naver.com', 110, 1, 1, '2023-03-02', NULL),
(2023000098, '이인기', '2004-10-23', '남성', '부산시 기장군', '010-4374-4573', 'dlsrl@naver.com', 110, 1, 1, '2023-03-02', NULL),
(2023000099, '이장혁', '2004-12-23', '남성', '부산시 기장군', '010-8754-8657', 'wkdgur@naver.com', 110, 1, 1, '2023-03-02', NULL),
(2023000100, '정재민', '2004-12-23', '남성', '부산시 기장군', '010-2346-8867', 'woals@naver.com', 110, 1, 1, '2023-03-02', NULL);

INSERT INTO student_tb (id, name, birth_date, gender, address, tel, email, dept_id, grade, semester, entrance_date, graduation_date) 
VALUES
(2023000101, '민효린', '2003-05-15', '여성', '부산시 수영구 망미동', '010-4501-1312', 'aoao@nate.com', 111, 1, 1, '2023-03-02', NULL),
(2023000102, '윤석주', '2003-09-25', '남성', '부산시 수영구 망미동', '010-4502-1312', 'aoao2@nate.com', 111, 1, 1, '2023-03-02', NULL),
(2023000103, '김석구', '2003-03-25', '남성', '부산시 수영구 망미동', '010-4503-1312', 'aoao3@nate.com', 111, 1, 1, '2023-03-02', NULL),
(2023000104, '윤정수', '2003-02-12', '남성', '부산시 수영구 망미동', '010-4504-1312', 'aoao4@nate.com', 111, 1, 1, '2023-03-02', NULL),
(2023000105, '남우현', '2003-09-13', '남성', '부산시 수영구 망미동', '010-4505-1312', 'aoao5@nate.com', 111, 1, 1, '2023-03-02', NULL),
(2023000106, '이수근', '2003-04-17', '남성', '부산시 수영구 망미동', '010-4506-1312', 'aoao6@nate.com', 111, 1, 1, '2023-03-02', NULL),
(2023000107, '김효진', '2003-02-15', '여성', '부산시 수영구 망미동', '010-4507-1312', 'aoao7@nate.com', 111, 1, 1, '2023-03-02', NULL),
(2023000108, '박소현', '2003-07-16', '여성', '부산시 수영구 망미동', '010-4508-1312', 'aoao8@nate.com', 111, 1, 1, '2023-03-02', NULL),
(2023000109, '하석진', '2003-03-11', '남성', '부산시 수영구 망미동', '010-4509-1312', 'aoao9@nate.com', 111, 1, 1, '2023-03-02', NULL),
(2023000110, '김동준', '2003-02-02', '남성', '부산시 수영구 망미동', '010-4510-1312', 'aoao10@nate.com', 111, 1, 1, '2023-03-02', NULL),
(2023000111, '김원준', '2003-08-17', '남성', '부산시 수영구 망미동', '010-4511-1312', 'aoao11@nate.com', 112, 1, 1, '2023-03-02', NULL),
(2023000112, '김예은', '2003-02-02', '여성', '부산시 수영구 광안동', '010-4512-1312', 'aoao12@nate.com', 112, 1, 1, '2023-03-02', NULL),
(2023000113, '이세창', '2003-08-23', '남성', '부산시 수영구 광안동', '010-4513-1312', 'aoao13@nate.com', 112, 1, 1, '2023-03-02', NULL),
(2023000114, '김재원', '2003-02-16', '남성', '부산시 수영구 광안동', '010-4514-1312', 'aoao14@nate.com', 112, 1, 1, '2023-03-02', NULL),
(2023000115, '박성훈', '2003-08-05', '남성', '부산시 수영구 광안동', '010-4515-1312', 'aoao15@nate.com', 112, 1, 1, '2023-03-02', NULL),
(2023000116, '최우재', '2003-06-25', '남성', '부산시 수영구 광안동', '010-4516-1312', 'aoao16@nate.com', 112, 1, 1, '2023-03-02', NULL),
(2023000117, '서지원', '2003-03-26', '여성', '부산시 수영구 광안동', '010-4517-1312', 'aoao17@nate.com', 112, 1, 1, '2023-03-02', NULL),
(2023000118, '이천희', '2003-09-07', '남성', '부산시 수영구 광안동', '010-4518-1312', 'aoao18@nate.com', 112, 1, 1, '2023-03-02', NULL),
(2023000119, '최정훈', '2003-02-21', '남성', '부산시 수영구 광안동', '010-4519-1312', 'aoao19@nate.com', 112, 1, 1, '2023-03-02', NULL),
(2023000120, '강하늘', '2003-09-17', '남성', '부산시 수영구 광안동', '010-4520-1312', 'aoao20@nate.com', 112, 1, 1, '2023-03-02', NULL),
(2023000121, '김동현', '2003-04-02', '남성', '부산시 수영구 광안동', '010-4521-1312', 'aoao21@nate.com', 113, 1, 1, '2023-03-02', NULL),
(2023000122, '김승우', '2003-05-07', '남성', '부산시 중구 부평동', '010-4522-1312', 'aoao22@nate.com', 113, 1, 1, '2023-03-02', NULL),
(2023000123, '장인섭', '2003-03-12', '남성', '부산시 중구 부평동', '010-4523-1312', 'aoao23@nate.com', 113, 1, 1, '2023-03-02', NULL),
(2023000124, '김영철', '2003-01-21', '남성', '부산시 중구 부평동', '010-4524-1312', 'aoao24@nate.com', 113, 1, 1, '2023-03-02', NULL),
(2023000125, '유승우', '2003-04-15', '남성', '부산시 중구 부평동', '010-4525-1312', 'aoao25@nate.com', 113, 1, 1, '2023-03-02', NULL),
(2023000126, '서현진', '2003-04-01', '남성', '부산시 중구 부평동', '010-4526-1312', 'aoao26@nate.com', 113, 1, 1, '2023-03-02', NULL),
(2023000127, '장희수', '2003-05-13', '남성', '부산시 중구 부평동', '010-4527-1312', 'aoao27@nate.com', 113, 1, 1, '2023-03-02', NULL),
(2023000128, '이채원', '2003-02-17', '여성', '부산시 중구 부평동', '010-4528-1312', 'aoao28@nate.com', 113, 1, 1, '2023-03-02', NULL),
(2023000129, '조재훈', '2003-06-21', '남성', '부산시 중구 부평동', '010-4529-1312', 'aoao29@nate.com', 113, 1, 1, '2023-03-02', NULL),
(2023000130, '최태환', '2003-03-02', '남성', '부산시 중구 부평동', '010-4530-1312', 'aoao30@nate.com', 113, 1, 1, '2023-03-02', NULL),
(2023000131, '백승현', '2003-09-04', '남성', '부산시 중구 부평동', '010-4531-1312', 'aoao31@nate.com', 114, 1, 1, '2023-03-02', NULL),
(2023000132, '박진성', '2003-08-14', '남성', '부산시 부산진구 부전동', '010-4532-1312', 'aoao32@nate.com', 114, 1, 1, '2023-03-02', NULL),
(2023000133, '김영대', '2003-02-15', '남성', '부산시 부산진구 부전동', '010-4533-1312', 'aoao33@nate.com', 114, 1, 1, '2023-03-02', NULL),
(2023000134, '서승현', '2003-04-14', '남성', '부산시 부산진구 부전동', '010-4534-1312', 'aoao34@nate.com', 114, 1, 1, '2023-03-02', NULL),
(2023000135, '박현민', '2003-03-19', '남성', '부산시 부산진구 부전동', '010-4535-1312', 'aoao35@nate.com', 114, 1, 1, '2023-03-02', NULL),
(2023000136, '이장우', '2003-02-12', '남성', '부산시 부산진구 부전동', '010-4536-1312', 'aoao36@nate.com', 114, 1, 1, '2023-03-02', NULL),
(2023000137, '김찬우', '2003-09-17', '남성', '부산시 부산진구 부전동', '010-4537-1312', 'aoao37@nate.com', 114, 1, 1, '2023-03-02', NULL),
(2023000138, '송재호', '2003-08-18', '남성', '부산시 부산진구 부전동', '010-4538-1312', 'aoao38@nate.com', 114, 1, 1, '2023-03-02', NULL),
(2023000139, '박형선', '2003-04-27', '남성', '부산시 부산진구 부전동', '010-4539-1312', 'aoao39@nate.com', 114, 1, 1, '2023-03-02', NULL),
(2023000140, '김정우', '2003-02-12', '남성', '부산시 부산진구 부전동', '010-4540-1312', 'aoao40@nate.com', 114, 1, 1, '2023-03-02', NULL),
(2023000141, '김범수', '2003-05-20', '남성', '부산시 부산진구 부전동', '010-4541-1312', 'aoao41@nate.com', 115, 1, 1, '2023-03-02', NULL),
(2023000142, '이준혁', '2003-06-18', '남성', '부산시 중구 중앙동', '010-4542-1312', 'aoao42@nate.com', 115, 1, 1, '2023-03-02', NULL),
(2023000143, '윤서진', '2003-03-16', '여성', '부산시 중구 중앙동', '010-4543-1312', 'aoao43@nate.com', 115, 1, 1, '2023-03-02', NULL),
(2023000144, '정재순', '2003-02-01', '남성', '부산시 중구 중앙동', '010-4544-1312', 'aoao44@nate.com', 115, 1, 1, '2023-03-02', NULL),
(2023000145, '권태원', '2003-03-02', '남성', '부산시 중구 중앙동', '010-4545-1312', 'aoao45@nate.com', 115, 1, 1, '2023-03-02', NULL),
(2023000146, '김승현', '2003-05-17', '남성', '부산시 중구 중앙동', '010-4546-1312', 'aoao46@nate.com', 115, 1, 1, '2023-03-02', NULL),
(2023000147, '강지환', '2003-03-07', '남성', '부산시 중구 중앙동', '010-4547-1312', 'aoao47@nate.com', 115, 1, 1, '2023-03-02', NULL),
(2023000148, '김승민', '2003-04-18', '남성', '부산시 중구 중앙동', '010-4548-1312', 'aoao48@nate.com', 115, 1, 1, '2023-03-02', NULL),
(2023000149, '이재용', '2003-02-12', '남성', '부산시 중구 중앙동', '010-4549-1312', 'aoao49@nate.com', 115, 1, 1, '2023-03-02', NULL),
(2023000150, '신승훈', '2003-07-02', '남성', '부산시 중구 중앙동', '010-4550-1312', 'aoao50@nate.com', 115, 1, 1, '2023-03-02', NULL);

INSERT INTO student_tb VALUES
(2023000151, '김진기', '2003-09-12', '남성', '서울시 강남구 방배동', '010-2323-2323', 'aaa@green.ac.kr', 116, 1, 1, '2023-03-02', NULL),
(2023000152, '김진태', '2003-09-12', '남성', '서울시 동작구 방배동', '010-2323-2324', 'aab@green.ac.kr', 116, 1, 1, '2023-03-02', NULL),
(2023000153, '이민성', '2003-09-12', '남성', '서울시 중랑구 방배동', '010-2323-2325', 'aac@green.ac.kr', 116, 1, 1, '2023-03-02', NULL),
(2023000154, '최두보', '2003-09-12', '남성', '서울시 강서구 방배동', '010-2323-2326', 'aad@green.ac.kr', 116, 1, 1, '2023-03-02', NULL),
(2023000155, '이태백', '2003-09-12', '남성', '서울시 강남구 방배동', '010-2323-2327', 'aae@green.ac.kr', 116, 1, 1, '2023-03-02', NULL),
(2023000156, '김옥균', '2003-09-12', '남성', '서울시 강남구 방배동', '010-2323-2328', 'aaf@green.ac.kr', 116, 1, 1, '2023-03-02', NULL),
(2023000157, '박찬호', '2003-09-12', '남성', '서울시 강남구 방배동', '010-2323-2329', 'aag@green.ac.kr', 116, 1, 1, '2023-03-02', NULL),
(2023000158, '여인호', '2003-09-12', '남성', '서울시 강남구 방배동', '010-2323-2343', 'aah@green.ac.kr', 116, 1, 1, '2023-03-02', NULL),
(2023000159, '배기성', '2003-09-12', '남성', '서울시 강남구 방배동', '010-2323-2353', 'aai@green.ac.kr', 116, 1, 1, '2023-03-02', NULL),
(2023000160, '유재석', '2003-09-12', '남성', '서울시 강남구 방배동', '010-2323-2363', 'aaj@green.ac.kr', 116, 1, 1, '2023-03-02', NULL),
(2023000161, '이광수', '2003-09-12', '남성', '서울시 강남구 방배동', '010-2323-2373', 'aak@green.ac.kr', 117, 1, 1, '2023-03-02', NULL),
(2023000162, '우민지', '2003-09-12', '여성', '서울시 강남구 방배동', '010-2323-2383', 'aal@green.ac.kr', 117, 1, 1, '2023-03-02', NULL),
(2023000163, '장수아', '2003-09-12', '여성', '서울시 강남구 방배동', '010-2323-2393', 'aam@green.ac.kr', 117, 1, 1, '2023-03-02', NULL),
(2023000164, '김슬기', '2003-09-12', '여성', '서울시 강남구 방배동', '010-2323-2123', 'aan@green.ac.kr', 117, 1, 1, '2023-03-02', NULL),
(2023000165, '최나영', '2003-09-12', '여성', '서울시 강남구 방배동', '010-2323-2223', 'aao@green.ac.kr', 117, 1, 1, '2023-03-02', NULL),
(2023000166, '박주희', '2003-09-12', '여성', '서울시 강남구 방배동', '010-2323-2523', 'aap@green.ac.kr', 117, 1, 1, '2023-03-02', NULL),
(2023000167, '구민교', '2003-09-12', '남성', '서울시 강남구 방배동', '010-2323-2423', 'aaq@green.ac.kr', 117, 1, 1, '2023-03-02', NULL),
(2023000168, '고장환', '2003-09-12', '남성', '서울시 강남구 방배동', '010-2323-2623', 'aar@green.ac.kr', 117, 1, 1, '2023-03-02', NULL),
(2023000169, '황수민', '2003-09-12', '여성', '서울시 강남구 방배동', '010-2323-2723', 'aas@green.ac.kr', 117, 1, 1, '2023-03-02', NULL),
(2023000170, '박소영', '2003-09-12', '여성', '서울시 강남구 방배동', '010-2323-2823', 'aat@green.ac.kr', 117, 1, 1, '2023-03-02', NULL),
(2023000171, '하영지', '2003-09-12', '여성', '서울시 강남구 방배동', '010-2323-2923', 'aau@green.ac.kr', 118, 1, 1, '2023-03-02', NULL),
(2023000172, '이수연', '2003-09-12', '여성', '서울시 강남구 방배동', '010-2323-1323', 'aav@green.ac.kr', 118, 1, 1, '2023-03-02', NULL),
(2023000173, '성은채', '2003-09-12', '여성', '서울시 강남구 방배동', '010-2323-3323', 'aaw@green.ac.kr', 118, 1, 1, '2023-03-02', NULL),
(2023000174, '김세린', '2003-09-12', '여성', '서울시 강남구 방배동', '010-2323-4323', 'aax@green.ac.kr', 118, 1, 1, '2023-03-02', NULL),
(2023000175, '조효정', '2003-09-12', '여성', '서울시 강남구 방배동', '010-2323-5323', 'aay@green.ac.kr', 118, 1, 1, '2023-03-02', NULL),
(2023000176, '김진태', '2003-09-12', '남성', '서울시 강남구 방배동', '010-2323-6323', 'abz@green.ac.kr', 118, 1, 1, '2023-03-02', NULL),
(2023000177, '김인호', '2003-09-12', '남성', '서울시 강남구 방배동', '010-2323-7323', 'aca@green.ac.kr', 118, 1, 1, '2023-03-02', NULL),
(2023000178, '이소룡', '2003-09-12', '남성', '서울시 강남구 방배동', '010-2323-8323', 'ada@green.ac.kr', 118, 1, 1, '2023-03-02', NULL),
(2023000179, '최무배', '2003-09-12', '남성', '서울시 강남구 방배동', '010-2323-9323', 'aea@green.ac.kr', 118, 1, 1, '2023-03-02', NULL),
(2023000180, '박소희', '2003-09-12', '여성', '서울시 강남구 방배동', '010-2323-1123', 'afa@green.ac.kr', 118, 1, 1, '2023-03-02', NULL),
(2023000181, '황진이', '2003-09-12', '여성', '서울시 강남구 방배동', '010-2323-3523', 'aga@green.ac.kr', 119, 1, 1, '2023-03-02', NULL),
(2023000182, '홍연희', '2003-09-12', '여성', '서울시 강남구 방배동', '010-2323-2323', 'aha@green.ac.kr', 119, 1, 1, '2023-03-02', NULL),
(2023000183, '주민희', '2003-09-12', '여성', '서울시 강남구 방배동', '010-2323-4423', 'aia@green.ac.kr', 119, 1, 1, '2023-03-02', NULL),
(2023000184, '고윤서', '2003-09-12', '여성', '서울시 강남구 방배동', '010-2323-5523', 'aja@green.ac.kr', 119, 1, 1, '2023-03-02', NULL),
(2023000185, '정예원', '2003-09-12', '여성', '서울시 강남구 방배동', '010-2323-6623', 'aka@green.ac.kr', 119, 1, 1, '2023-03-02', NULL),
(2023000186, '정채은', '2003-09-12', '여성', '서울시 강남구 방배동', '010-2323-7723', 'ala@green.ac.kr', 119, 1, 1, '2023-03-02', NULL),
(2023000187, '차은채', '2003-09-12', '여성', '서울시 강남구 방배동', '010-2323-8823', 'ama@green.ac.kr', 119, 1, 1, '2023-03-02', NULL),
(2023000188, '곽예지', '2003-09-12', '여성', '서울시 강남구 방배동', '010-2323-9923', 'ana@green.ac.kr', 119, 1, 1, '2023-03-02', NULL),
(2023000189, '배서율', '2003-09-12', '여성', '서울시 강남구 방배동', '010-2323-2443', 'aoa@green.ac.kr', 119, 1, 1, '2023-03-02', NULL),
(2023000190, '박희수', '2003-09-12', '여성', '서울시 강남구 방배동', '010-2323-2553', 'apa@green.ac.kr', 119, 1, 1, '2023-03-02', NULL),
(2023000191, '나관중', '2003-09-12', '남성', '서울시 강남구 방배동', '010-2323-2663', 'aqa@green.ac.kr', 120, 1, 1, '2023-03-02', NULL),
(2023000192, '김기혁', '2003-09-12', '남성', '서울시 강남구 방배동', '010-2323-2773', 'ara@green.ac.kr', 120, 1, 1, '2023-03-02', NULL),
(2023000193, '신유성', '2003-09-12', '남성', '서울시 강남구 방배동', '010-2323-2883', 'asa@green.ac.kr', 120, 1, 1, '2023-03-02', NULL),
(2023000194, '사충기', '2003-09-12', '남성', '서울시 강남구 방배동', '010-2323-2993', 'ata@green.ac.kr', 120, 1, 1, '2023-03-02', NULL),
(2023000195, '도민준', '2003-09-12', '남성', '서울시 강남구 방배동', '010-2323-2003', 'aua@green.ac.kr', 120, 1, 1, '2023-03-02', NULL),
(2023000196, '소지섭', '2003-09-12', '남성', '서울시 강남구 방배동', '010-2323-2123', 'ava@green.ac.kr', 120, 1, 1, '2023-03-02', NULL),
(2023000197, '마광수', '2003-09-12', '남성', '서울시 강남구 방배동', '010-2323-2233', 'awa@green.ac.kr', 120, 1, 1, '2023-03-02', NULL),
(2023000198, '공서영', '2003-09-12', '여성', '서울시 강남구 방배동', '010-2323-2343', 'axa@green.ac.kr', 120, 1, 1, '2023-03-02', NULL),
(2023000199, '지진희', '2003-09-12', '남성', '서울시 강남구 방배동', '010-2323-2453', 'aya@green.ac.kr', 120, 1, 1, '2023-03-02', NULL),
(2023000200, '이서현', '2003-09-12', '여성', '서울시 강남구 방배동', '010-2323-2563', 'aza@green.ac.kr', 120, 1, 1, '2023-03-02', NULL);
INSERT INTO user_tb
VALUES 
(2023000001, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000002, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000003, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000004, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000005, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000006, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000007, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000008, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000009, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000010, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000011, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000012, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000013, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000014, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000015, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000016, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000017, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000018, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000019, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000020, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000021, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000022, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000023, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000024, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000025, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000026, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000027, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000028, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000029, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000030, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000031, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000032, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000033, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000034, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000035, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000036, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000037, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000038, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000039, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000040, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000041, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000042, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000043, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000044, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000045, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000046, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000047, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000048, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000049, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000050, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student');
	
INSERT INTO user_tb
VALUES 
(2023000051, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000052, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000053, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000054, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000055, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000056, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000057, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000058, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000059, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000060, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000061, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000062, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000063, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000064, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000065, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000066, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000067, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000068, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000069, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000070, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000071, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000072, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000073, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000074, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000075, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000076, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000077, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000078, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000079, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000080, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000081, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000082, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000083, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000084, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000085, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000086, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000087, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000088, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000089, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000090, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000091, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000092, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000093, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000094, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000095, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000096, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000097, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000098, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000099, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student'),
(2023000100, '$2a$10$hEYFZOe.PbFbVRcPZymRKuCGMU2MilAn64ZGnIqPgfwWL7JyGeKKW', 'student');

INSERT INTO user_tb (id, password, user_role)
VALUES
(2023000101, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000102, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000103, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000104, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000105, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000106, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000107, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000108, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000109, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000110, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000111, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000112, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000113, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000114, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000115, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000116, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000117, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000118, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000119, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000120, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000121, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000122, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000123, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000124, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000125, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000126, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000127, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000128, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000129, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000130, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000131, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000132, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000133, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000134, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000135, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000136, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000137, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000138, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000139, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000140, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000141, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000142, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000143, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000144, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000145, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000146, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000147, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000148, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000149, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000150, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student');

INSERT INTO user_tb VALUES
(2023000151, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000152, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000153, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000154, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000155, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000156, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000157, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000158, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000159, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000160, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000161, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000162, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000163, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000164, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000165, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000166, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000167, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000168, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000169, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000170, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000171, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000172, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000173, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000174, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000175, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000176, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000177, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000178, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000179, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000180, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000181, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000182, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000183, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000184, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000185, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000186, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000187, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000188, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000189, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000190, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000191, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000192, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000193, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000194, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000195, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000196, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000197, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000198, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000199, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student'),
(2023000200, '$2a$10$fXVPmpG.D9iVDC/Clj9MU.Jp.uQDyGu4QflOJydT/ChDT90.rdtUu', 'student');


-- 재학
INSERT INTO stu_stat_tb (student_id, status, from_date, to_date)
VALUES 
(2023000001, '재학', '2023-03-02', '9999-01-01'),
(2023000002, '재학', '2023-03-02', '9999-01-01'),
(2023000003, '재학', '2023-03-02', '9999-01-01'),
(2023000004, '재학', '2023-03-02', '9999-01-01'),
(2023000005, '재학', '2023-03-02', '9999-01-01'),
(2023000006, '재학', '2023-03-02', '9999-01-01'),
(2023000007, '재학', '2023-03-02', '9999-01-01'),
(2023000008, '재학', '2023-03-02', '9999-01-01'),
(2023000009, '재학', '2023-03-02', '9999-01-01'),
(2023000010, '재학', '2023-03-02', '9999-01-01'),
(2023000011, '재학', '2023-03-02', '9999-01-01'),
(2023000012, '재학', '2023-03-02', '9999-01-01'),
(2023000013, '재학', '2023-03-02', '9999-01-01'),
(2023000014, '재학', '2023-03-02', '9999-01-01'),
(2023000015, '재학', '2023-03-02', '9999-01-01'),
(2023000016, '재학', '2023-03-02', '9999-01-01'),
(2023000017, '재학', '2023-03-02', '9999-01-01'),
(2023000018, '재학', '2023-03-02', '9999-01-01'),
(2023000019, '재학', '2023-03-02', '9999-01-01'),
(2023000020, '재학', '2023-03-02', '9999-01-01'),
(2023000021, '재학', '2023-03-02', '9999-01-01'),
(2023000022, '재학', '2023-03-02', '9999-01-01'),
(2023000023, '재학', '2023-03-02', '9999-01-01'),
(2023000024, '재학', '2023-03-02', '9999-01-01'),
(2023000025, '재학', '2023-03-02', '9999-01-01'),
(2023000026, '재학', '2023-03-02', '9999-01-01'),
(2023000027, '재학', '2023-03-02', '9999-01-01'),
(2023000028, '재학', '2023-03-02', '9999-01-01'),
(2023000029, '재학', '2023-03-02', '9999-01-01'),
(2023000030, '재학', '2023-03-02', '9999-01-01'),
(2023000031, '재학', '2023-03-02', '9999-01-01'),
(2023000032, '재학', '2023-03-02', '9999-01-01'),
(2023000033, '재학', '2023-03-02', '9999-01-01'),
(2023000034, '재학', '2023-03-02', '9999-01-01'),
(2023000035, '재학', '2023-03-02', '9999-01-01'),
(2023000036, '재학', '2023-03-02', '9999-01-01'),
(2023000037, '재학', '2023-03-02', '9999-01-01'),
(2023000038, '재학', '2023-03-02', '9999-01-01'),
(2023000039, '재학', '2023-03-02', '9999-01-01'),
(2023000040, '재학', '2023-03-02', '9999-01-01'),
(2023000041, '재학', '2023-03-02', '9999-01-01'),
(2023000042, '재학', '2023-03-02', '9999-01-01'),
(2023000043, '재학', '2023-03-02', '9999-01-01'),
(2023000044, '재학', '2023-03-02', '9999-01-01'),
(2023000045, '재학', '2023-03-02', '9999-01-01'),
(2023000046, '재학', '2023-03-02', '9999-01-01'),
(2023000047, '재학', '2023-03-02', '9999-01-01'),
(2023000048, '재학', '2023-03-02', '9999-01-01'),
(2023000049, '재학', '2023-03-02', '9999-01-01'),
(2023000050, '재학', '2023-03-02', '9999-01-01');

INSERT INTO stu_stat_tb (student_id, status, from_date, to_date)
VALUES 
(2023000051, '재학', '2023-03-02', '9999-01-01'),
(2023000052, '재학', '2023-03-02', '9999-01-01'),
(2023000053, '재학', '2023-03-02', '9999-01-01'),
(2023000054, '재학', '2023-03-02', '9999-01-01'),
(2023000055, '재학', '2023-03-02', '9999-01-01'),
(2023000056, '재학', '2023-03-02', '9999-01-01'),
(2023000057, '재학', '2023-03-02', '9999-01-01'),
(2023000058, '재학', '2023-03-02', '9999-01-01'),
(2023000059, '재학', '2023-03-02', '9999-01-01'),
(2023000060, '재학', '2023-03-02', '9999-01-01'),
(2023000061, '재학', '2023-03-02', '9999-01-01'),
(2023000062, '재학', '2023-03-02', '9999-01-01'),
(2023000063, '재학', '2023-03-02', '9999-01-01'),
(2023000064, '재학', '2023-03-02', '9999-01-01'),
(2023000065, '재학', '2023-03-02', '9999-01-01'),
(2023000066, '재학', '2023-03-02', '9999-01-01'),
(2023000067, '재학', '2023-03-02', '9999-01-01'),
(2023000068, '재학', '2023-03-02', '9999-01-01'),
(2023000069, '재학', '2023-03-02', '9999-01-01'),
(2023000070, '재학', '2023-03-02', '9999-01-01'),
(2023000071, '재학', '2023-03-02', '9999-01-01'),
(2023000072, '재학', '2023-03-02', '9999-01-01'),
(2023000073, '재학', '2023-03-02', '9999-01-01'),
(2023000074, '재학', '2023-03-02', '9999-01-01'),
(2023000075, '재학', '2023-03-02', '9999-01-01'),
(2023000076, '재학', '2023-03-02', '9999-01-01'),
(2023000077, '재학', '2023-03-02', '9999-01-01'),
(2023000078, '재학', '2023-03-02', '9999-01-01'),
(2023000079, '재학', '2023-03-02', '9999-01-01'),
(2023000080, '재학', '2023-03-02', '9999-01-01'),
(2023000081, '재학', '2023-03-02', '9999-01-01'),
(2023000082, '재학', '2023-03-02', '9999-01-01'),
(2023000083, '재학', '2023-03-02', '9999-01-01'),
(2023000084, '재학', '2023-03-02', '9999-01-01'),
(2023000085, '재학', '2023-03-02', '9999-01-01'),
(2023000086, '재학', '2023-03-02', '9999-01-01'),
(2023000087, '재학', '2023-03-02', '9999-01-01'),
(2023000088, '재학', '2023-03-02', '9999-01-01'),
(2023000089, '재학', '2023-03-02', '9999-01-01'),
(2023000090, '재학', '2023-03-02', '9999-01-01'),
(2023000091, '재학', '2023-03-02', '9999-01-01'),
(2023000092, '재학', '2023-03-02', '9999-01-01'),
(2023000093, '재학', '2023-03-02', '9999-01-01'),
(2023000094, '재학', '2023-03-02', '9999-01-01'),
(2023000095, '재학', '2023-03-02', '9999-01-01'),
(2023000096, '재학', '2023-03-02', '9999-01-01'),
(2023000097, '재학', '2023-03-02', '9999-01-01'),
(2023000098, '재학', '2023-03-02', '9999-01-01'),
(2023000099, '재학', '2023-03-02', '9999-01-01'),
(2023000100, '재학', '2023-03-02', '9999-01-01');
	
INSERT INTO stu_stat_tb (student_id, status, from_date, to_date) 
VALUES
(2023000101 ,'재학', '2023-03-02', '9999-01-01'),
(2023000102 ,'재학', '2023-03-02', '9999-01-01'),
(2023000103 ,'재학', '2023-03-02', '9999-01-01'),
(2023000104 ,'재학', '2023-03-02', '9999-01-01'),
(2023000105 ,'재학', '2023-03-02', '9999-01-01'),
(2023000106 ,'재학', '2023-03-02', '9999-01-01'),
(2023000107 ,'재학', '2023-03-02', '9999-01-01'),
(2023000108 ,'재학', '2023-03-02', '9999-01-01'),
(2023000109 ,'재학', '2023-03-02', '9999-01-01'),
(2023000110 ,'재학', '2023-03-02', '9999-01-01'),
(2023000111 ,'재학', '2023-03-02', '9999-01-01'),
(2023000112 ,'재학', '2023-03-02', '9999-01-01'),
(2023000113 ,'재학', '2023-03-02', '9999-01-01'),
(2023000114 ,'재학', '2023-03-02', '9999-01-01'),
(2023000115 ,'재학', '2023-03-02', '9999-01-01'),
(2023000116 ,'재학', '2023-03-02', '9999-01-01'),
(2023000117 ,'재학', '2023-03-02', '9999-01-01'),
(2023000118 ,'재학', '2023-03-02', '9999-01-01'),
(2023000119 ,'재학', '2023-03-02', '9999-01-01'),
(2023000120 ,'재학', '2023-03-02', '9999-01-01'),
(2023000121 ,'재학', '2023-03-02', '9999-01-01'),
(2023000122 ,'재학', '2023-03-02', '9999-01-01'),
(2023000123 ,'재학', '2023-03-02', '9999-01-01'),
(2023000124 ,'재학', '2023-03-02', '9999-01-01'),
(2023000125 ,'재학', '2023-03-02', '9999-01-01'),
(2023000126 ,'재학', '2023-03-02', '9999-01-01'),
(2023000127 ,'재학', '2023-03-02', '9999-01-01'),
(2023000128 ,'재학', '2023-03-02', '9999-01-01'),
(2023000129 ,'재학', '2023-03-02', '9999-01-01'),
(2023000130 ,'재학', '2023-03-02', '9999-01-01'),
(2023000131 ,'재학', '2023-03-02', '9999-01-01'),
(2023000132 ,'재학', '2023-03-02', '9999-01-01'),
(2023000133 ,'재학', '2023-03-02', '9999-01-01'),
(2023000134 ,'재학', '2023-03-02', '9999-01-01'),
(2023000135 ,'재학', '2023-03-02', '9999-01-01'),
(2023000136 ,'재학', '2023-03-02', '9999-01-01'),
(2023000137 ,'재학', '2023-03-02', '9999-01-01'),
(2023000138 ,'재학', '2023-03-02', '9999-01-01'),
(2023000139 ,'재학', '2023-03-02', '9999-01-01'),
(2023000140 ,'재학', '2023-03-02', '9999-01-01'),
(2023000141 ,'재학', '2023-03-02', '9999-01-01'),
(2023000142 ,'재학', '2023-03-02', '9999-01-01'),
(2023000143 ,'재학', '2023-03-02', '9999-01-01'),
(2023000144 ,'재학', '2023-03-02', '9999-01-01'),
(2023000145 ,'재학', '2023-03-02', '9999-01-01'),
(2023000146 ,'재학', '2023-03-02', '9999-01-01'),
(2023000147 ,'재학', '2023-03-02', '9999-01-01'),
(2023000148 ,'재학', '2023-03-02', '9999-01-01'),
(2023000149 ,'재학', '2023-03-02', '9999-01-01'),
(2023000150 ,'재학', '2023-03-02', '9999-01-01');

INSERT INTO stu_stat_tb (student_id, status, from_date, to_date) VALUES
(2023000151 ,'재학', '2023-03-02', '9999-01-01'),
(2023000152 ,'재학', '2023-03-02', '9999-01-01'),
(2023000153 ,'재학', '2023-03-02', '9999-01-01'),
(2023000154 ,'재학', '2023-03-02', '9999-01-01'),
(2023000155 ,'재학', '2023-03-02', '9999-01-01'),
(2023000156 ,'재학', '2023-03-02', '9999-01-01'),
(2023000157 ,'재학', '2023-03-02', '9999-01-01'),
(2023000158 ,'재학', '2023-03-02', '9999-01-01'),
(2023000159 ,'재학', '2023-03-02', '9999-01-01'),
(2023000160 ,'재학', '2023-03-02', '9999-01-01'),
(2023000161 ,'재학', '2023-03-02', '9999-01-01'),
(2023000162 ,'재학', '2023-03-02', '9999-01-01'),
(2023000163 ,'재학', '2023-03-02', '9999-01-01'),
(2023000164 ,'재학', '2023-03-02', '9999-01-01'),
(2023000165 ,'재학', '2023-03-02', '9999-01-01'),
(2023000166 ,'재학', '2023-03-02', '9999-01-01'),
(2023000167 ,'재학', '2023-03-02', '9999-01-01'),
(2023000168 ,'재학', '2023-03-02', '9999-01-01'),
(2023000169 ,'재학', '2023-03-02', '9999-01-01'),
(2023000170 ,'재학', '2023-03-02', '9999-01-01'),
(2023000171 ,'재학', '2023-03-02', '9999-01-01'),
(2023000172 ,'재학', '2023-03-02', '9999-01-01'),
(2023000173 ,'재학', '2023-03-02', '9999-01-01'),
(2023000174 ,'재학', '2023-03-02', '9999-01-01'),
(2023000175 ,'재학', '2023-03-02', '9999-01-01'),
(2023000176 ,'재학', '2023-03-02', '9999-01-01'),
(2023000177 ,'재학', '2023-03-02', '9999-01-01'),
(2023000178 ,'재학', '2023-03-02', '9999-01-01'),
(2023000179 ,'재학', '2023-03-02', '9999-01-01'),
(2023000180 ,'재학', '2023-03-02', '9999-01-01'),
(2023000181 ,'재학', '2023-03-02', '9999-01-01'),
(2023000182 ,'재학', '2023-03-02', '9999-01-01'),
(2023000183 ,'재학', '2023-03-02', '9999-01-01'),
(2023000184 ,'재학', '2023-03-02', '9999-01-01'),
(2023000185 ,'재학', '2023-03-02', '9999-01-01'),
(2023000186 ,'재학', '2023-03-02', '9999-01-01'),
(2023000187 ,'재학', '2023-03-02', '9999-01-01'),
(2023000188 ,'재학', '2023-03-02', '9999-01-01'),
(2023000189 ,'재학', '2023-03-02', '9999-01-01'),
(2023000190 ,'재학', '2023-03-02', '9999-01-01'),
(2023000191 ,'재학', '2023-03-02', '9999-01-01'),
(2023000192 ,'재학', '2023-03-02', '9999-01-01'),
(2023000193 ,'재학', '2023-03-02', '9999-01-01'),
(2023000194 ,'재학', '2023-03-02', '9999-01-01'),
(2023000195 ,'재학', '2023-03-02', '9999-01-01'),
(2023000196 ,'재학', '2023-03-02', '9999-01-01'),
(2023000197 ,'재학', '2023-03-02', '9999-01-01'),
(2023000198 ,'재학', '2023-03-02', '9999-01-01'),
(2023000199 ,'재학', '2023-03-02', '9999-01-01'),
(2023000200 ,'재학', '2023-03-02', '9999-01-01');

INSERT INTO question_tb 
(question1, question2, question3, question4, question5, question6, question7, sug_content)
VALUES 
 (
 '강의 내용은 자신에게 학습 욕구를 불러일으킬 만큼 적절한 수준이었는가?',
 '이 강의를 통하여 다른 강의에서는 접할 수 없는 새로운 내용을 배울 수 있었는가?',
 '강의를 통하여 해당 교과목에 대한 이해(실기 능력과 기능)가 개선되었는가?',
 '교수는 주요 주제들간의 관계가 드러나도록 내용을 구조화 하여 전달하였는가?',
 '교수는 열정을 갖고 수업을 진행하였는가?',
 '수업시간은 제대로 이루어졌는가?',
 '강의 내용이 과목명에 부합하는가?',
 '기타'
 );
 
-- 단과대별 등록금
INSERT INTO coll_tuit_tb
VALUES 
(1, 4868500), (2, 3588500), (3, 3588500), (4, 3588500);

-- 장학금
INSERT INTO scholarship_tb
VALUES
(1, 5000000), (2, 2547400);

-- 점수 환산
INSERT INTO grade_tb
VALUES
('A+', 4.5),
('A0', 4.0),
('B+', 3.5),
('B0', 3.0),
('C+', 2.5),
('C0', 2.0),
('D+', 1.5),
('F', 0);

-- 학사일정
INSERT INTO schedule_tb
(staff_id, start_day, end_day, information)
VALUES
(230001, '2023-01-27', '2023-02-01', '2023-1학기 예비수강신청'),
(230001, '2023-02-13', '2023-02-17', '2023-1학기 수강신청'),
(230001, '2023-02-17', '2023-02-23', '2023-1학기 등록'),
(230001, '2023-02-22', '2023-02-22', '복학 접수 마감'),
(230001, '2023-02-26', '2023-02-26', '졸업예배'),
(230001, '2023-02-27', '2023-02-27', '학위수여식'),
(230001, '2023-03-01', '2023-03-01', '삼일절'),
(230001, '2023-03-02', '2023-03-02', '개강/교무위원회'),
(230001, '2023-03-06', '2023-03-08', '수강신청 확인 및 변경'),
(230001, '2023-03-10', '2023-03-13', '2023-1학기 추가등록'),
(230001, '2023-03-13', '2023-03-17', '조기졸업 신청'),
(230001, '2023-03-15', '2023-03-15', '미등록자 일반 휴학 접수 마감/ 등록금 전액반환 마감');

-- 공지사항
INSERT INTO notice_tb (category, title, content)
VALUES
('[학사]', '2023학년도 1학기 학생예비군 전입 신고 안내', 
'2023학년도 1학기 학생예비군 전입신고를 아래와 같이 안내하오니 대상자는 전원 기간내에 신고하여 주시기 바랍니다.<br>
 <br>
 1. 신고기간<br>                
   가. 일반 및 군제대 복학생 : 4.13(월) ~ 5. 10<br>
      ※  분할 납부생 / 학자금 대출학생 포함<br>
   나. 신입 및 편입 및 재 입학생 : 4. 20(월) ~ 5. 10<br>
      ※  GLS상 입력이 안되는 인원은 학적정리 완료 후(2.24 완료예정) 전입신청(2.27일부터) 바랍니다.<br>
   다. 신고방법 : 학교 홈페이지(GLS) → 신청 / 자격관리  → 예비군 전입신청<br>
  ※ 예비군 신고자는 대학 / 대학원(일반, 전문, 특수)에 복학 및 등록 후 GLS를 통한<br>
       전입신고를 해야만 학생예비군으로서 편성 및 교육훈련 시간단축혜택 가능<br>
 2. 신고대상 : 2015년 ~ 2023년 전역자(소집해제자)로서 복학, 신입 / 편입, 재입학한 예비군<br>
    ※ 관련근거 : 예비군법 시행령 제5조<br>
 3. 신고제외 대상 : 휴학자, 졸업유예, 유급자, 수료자 등 수업연한 초과자는 대상에서 제외되며 주소지<br>
                                   지역 예비군에 편성되어 관리(유급학기도 수업이수 학기에 포함)<br>
 4. 행정사항<br>
    가. 신고결과 확인방법 : 예비군홈페이지<br>
       ☞ 본인 군번 모를 경우 :〈예비군 홈페이지〉→ [나의 정보] →〈소속정보〉에서 확인<br>
    나. 예비군홈페이지 개인정보〈메일, 핸드폰 번호 등〉최신화 : 훈련안내 / 모바일통지서 등 문자 접수간 필요<br>
       ☞  메일, 핸드폰 번호 등 변경 시 예비군홈페이지의 "개인정보" 에서 수정 가능<br>
       ☞  예비군 소집통지서 모바일 발송 플랫폼 : 네이버, 카카오, 토스 등(추가업체 향후 선정 예정)<br>
    다. 대학 예비군훈련<br>
       1) 인사캠 : 5.1~5.4 / 4일, 교현예비군 훈련장(노고산 예비군 훈련대)<br>
       2) 자과캠 : 5.9~5.12 / 4일, 수원ㆍ화성ㆍ오산 과학화예비군훈련장(화성시 비봉면)<br>
      ※ 훈련 관련 세부적인 사항은 학교 및 예비군 홈페이지 공지(예정)<br>
    라. GLS 미 입력 및 기간이 경과한 인원은 예비군연대 방문(유선) 예비군 편입신청서 작성 제출'),
    
('[장학]', '2023학년도 보건장학회 연구지원장학생 선발 안내',
'1. 지원 요건<br>
 -국내에 소재한 보건분야의 대학,연구소 등에서 보건관련 연구를 계획하고 있는 자로서 소속학교장 이 다음의 사항에 의거하여 추천한 자<br>
 -본 연구 장학금은 과거 재단법인 보건장학회로부터 수혜 경력이 있거나, 박사 학위 소지 자 및 교수(조교수 이상)는 지원할 수 없음(대학원 과정 학생 지원 가능)<br>
  1) 본 연구와 관련하여 국비 또는 타 장학금 연구비 을 받고 있지 아니한 자<br>
 (해당 연구에 대하여 재단법인 보건장학회 이외 의 기관으로부터 지원을 받거나 수혜 예정인 연구자는 지원 불가)<br>
  2) 연구를 2025년 7월 31일까지 완료하여 연구결과를 공인 된 학술지(KCI 등재 지 SCI · SSCI 급 이상)에 게재하고 본 재단에 그 결과를 제출할 수 있는 자<br>
 (단, 본 재단의 승인을 얻을 경우 연구 결과물의 제출 일자를 2026년 7월 31일까지 연기할 수 있음)<br>
  3) 공동연구의 경우 차석연구자 이상일 것<br>
 (공동 연구자 A, B, C, D, E 중 A 가 제1저자, E가 교신 저자일 경우에는 A, B, E 까지 지원 가능)<br>
 <br>
 2. 모집학과/선발 인원/지급 금액<br>
  1) 모집학과: 의학, 약학, 치의학, 한의학, 간호학, 사회복지학<br>
 ※사회복지 학 의 경우 보건 의료 정책 분야 의 연구주제에 한함<br>
  2) 선발 인원: 최대 60명<br>
  3) 지급 금액: 1인당 500만원<br>
 <br>
 3. 접수 기간 및 방법<br>
  1) 접수 기간: 2023년 5월 1일 ~ 5월 31일 오전 11시까지<br>
  2) 접수 방법: 연구지원 장학금 지원자는 소속대학 장학 담당자에게 개별적으로 필요서류를 제출하고 장학담당자가 재 보건장학회 홈페이지 해당 대학 소속 지원자들을 일괄적으로 접수할 예정<br>
 ※접수기간 이외에(5/1 이전 및 5/31 오전 11시 이후) 제출된 서류는 접수 불가<br>
 ※누락된 서류에 대한 책임은 본인에게 있으며, 제출된 서류는 반환하지 않습니다.<br>
 <br>
 4. 장학생 선정 및 장학금 지급 : 2023년 8월 말 ~ 9월 초 예정<br>
  1) 선발된 장학생의 명단은 재 보건장학회 홈페이지(www.kr hff.or.kr) 공지사항란에 게시 및 학교 측 장학 담당자 에게 이메일로 통보<br>
  2) 장학금은 각 대학에 일괄 전달하고, 각 대학이 선발된 장학생에게 개별 지급<br>
 <br>
 5. 장학금 수여식: 8월 중 예정<br>
 -장학금 수여식에 초대받은 장학생은 참석을 원칙으로 함<br>'),
 
('[일반]', 'Gartner Research(IT 분야 시장분석) 서비스 지원 안내',
'기술사업화센터에서는 교내 구성원들의 연구에 도움을 드리고자 Gartner Research 서비스를 지원합니다.<br>
Gartner는 미국의 시장조사 및 컨설팅 회사로서, 전 세계의 정부기관, 다국적 IT 기업 및 투자 회사 등 다양한 고객을 대상으로 신뢰도 높은 IT 분야 연구 및 시장 분석 보고서를 제공합니다.<br>
교내 구성원들의 많은 관심과 이용 바랍니다.<br>'),

('[일반]', '2023학년도 장애 인식개선 교육(법정의무교육) 안내',
'장애학생지원센터에서는 「장애인복지법」 제 25조 및 「장애인고용촉진 및 직업재활법」제5조의2에 의거하여 장애인식개선 교육을 실시합니다.<br> 
본 교육은 보건복지부 교육 관리, 대학정보공시와 교육부 감사 등에서 이수 현황이 점검되고 있사오니, 본교의 구성원 여러분들의 적극적인 참여를 부탁드립니다.<br>
 <br>
 -  다  음  -<br>
 <br>
 가. 교육 내용: 장애인식개선 교육 (연 1회 이수)<br>
 <br>
 나. 교육 대상:<br>
 <br>
 ① 학부와 일반대학원 : 재학 중인 모든 학생<br>
 ② 편입 및 재입학 : 재학 중인 모든 학생<br>
 ③ 특수·전문대학원 : 특수·전문대학원 소속 재학생<br>
 ④ 교원 : 전임교원, 비전임교원, 강사 등 모든 교원<br>
 ⑤ 직원 : 기획관리직, 일반운영직, 기술기능직, 일반기능직 등 모든 직원<br>
 <br>
 다. 수강 기간<br>
 <br>
 ① 대학(원)생: 2023년 4월 14일(금) 09:00 ~ 2024년 2월 12일(월) 23:59<br>
 ② 교원: 2023년 4월 24일(월) 11:00 ~ 2024년 2월 9일(금) 17:00<br>
 ③ 직원: 2023년 5월 2일(화) 09:00 ~ 2023년 12월 29일(금) 17:30<br>
 <br>
 라. 수강 방법: 온라인 교육<br>
 <br>
 마. 포털 내 교육 이수 확인'),
 
('[일반]', '2023학년도 1학기 코로나 19 특별휴학 시행 안내',
'2023학년도 1학기 코로나19 특별휴학을 아래와 같이 한시적으로 시행하고자 합니다.<br> 
 ※ 코로나19 관련 사유로 인해 학업을 시작, 지속할 수 없는 경우에 한하여 심의 및 승인을 거쳐 적용<br>
  <br>
 1. 대상 : 학부 신·편입생 및 재학생이면서 다음 가, 나, 다 중 하나 이상에 해당하여 학업을 지속할 수 없으며 정상적으로 학기 이수가 어려울 경우<br>
 <br>
       가. 코로나19 확진자 중 후유증 · 합병증 발병자<br>
          - 학사운영규정 제25조 및 제30조에 따른 질병휴학 증빙서류 제출자에 한해 적용<br>
          - 단순 확진자 및 격리자는 특별휴학 적용 제한<br>
 <br>
       나. [특별휴학 신청일 기준] 해외에 체류·방문 중이면서 국내입국이 어려운 학생<br>
         - 해외에 체류 · 방문 시 코로나19 관련 봉쇄 및 출국제한 등 국내입국이 어려울 경우<br>
         - 비자발급이 지연되는 등 국내입국 여건 마련에 어려움을 겪고 있는 경우<br>
          - 관련 증빙서류 제출 필수(위 사항을 증빙하는 대사관 공지문, 신문 기사, 외교부 공식 정보 등)<br>
 <br>
       다. [특별휴학 신청일 기준] 해외 유학 중이거나 유학이 예정된 학생<br>
        - 교환학생제도, 방문학생제도, 해외현장실습, 해외인턴십 등 본교 공식 국제교류 프로그램에 선발된 학생이어야 함<br>
         - 코로나19 관련 출국 예정 국가의 봉쇄 및 입국제한 등으로 국제교류 프로그램 참여가 어려운 경우<br>
         - 관련 증빙서류 제출 필수(국제교류팀 발급 확인서 등)<br>
  <br>
  2. 시행기간 및 장소 <br>
      가. 시행기간: 2023년 1학기 한시적 시행(5월 31일 (수) 17시까지 학기 중 휴학 신청기간 동일)<br>
        ※ 등록금 반환은 등록금 반환 기준에 따라 환불<br>
      나. 신청장소 : 각 대학 행정실<br>
      다. 유의사항<br>
        1) 신청사항은 심의를 거치며, 코로나 휴학 적용 사안이 아니라고 판단 시 승인되지 않음<br>
         2) 특별 휴학원서와 지도교수 확인서 상 코로나 사유로 학업을 지속할 수 없는 내용이 상세히 기재되어야 함<br>
         3) 상기의 코로나 휴학 적용 대상별로 관련 증빙서류 제출 필수<br>
  <br>
  3. 신청서류 <br>
     가. 특별 휴학원서<br>
     나. 지도교수 확인서<br>
     다. 등록금 환불 신청서 _ 학생 계좌번호 필히 등록<br>
     라. 교환학생 확인서(해당자만)<br>
     마. 코로나19 확진자 중 후유증 · 합병증 발병자에 해당하는 경우 학사운영규정 제25조 및 제30조에 따른 증빙서류<br>
       ※ 제30조에 따라 신/편입생/재입학생의 첫 학기 휴학의 경우 <br>
         본교 부속병원장 또는 다른 종합병원장 발행 4주 이상의 입원치료 진단서 및 4주 이상의 입원확인서<br>
     바. 기타 대학 행정실 및 본부에서 코로나 특별휴학 대상 여부 확인을 위해 요청하는 서류<br>
'),
('[장학]', '2023학년도 교외장학재단 신규장학생 선발 결과 안내',
' ※ 장학금 공지에 올라온 학교지원 교외장학재단만 해당<br>
 ※ 각 심사 단계마다 합격자에 한하여 문자 발송<br>
 ※ 심사 단계 : 접수 중 -> 서류심사 중 -> 면접심사 중 -> 최종선발<br>
 ※ 완료된 심사 단계만 업데이트 됨<br>
 <br>
 ○ 2023학년도 1학기<br>
   - 관정이종환교육재단 : 접수중 - 서류심사중 - 면접심사중 - 최종선발 <br>
   - KC미래장학재단 : 접수중 - 서류심사중 - 최종선발<br>
   - 운경재단 : 접수중 - 서류심사중 - 최종선발 <br>
   - 송원김영환장학재단 : 접수중 - 서류심사중 - 최종선발 <br>
   - KT랜선야학 : 접수중 - 서류심사중  - 최종선발 <br>
   - 운해장학재단 : 접수중 - 서류심사중 - 최종선발 <br>
   - 성옥문화재단 : 접수중 - 서류심사중 - 최종선발 <br>
   - 보담장학회 : 접수중 - 서류심사중 - 최종선발 <br>
   - 김희경유럽정신문화장학재단 : 접수중 - 서류심사중 - 최종선발 <br>
   - 양천장학회 : 접수중 - 서류심사중 - 면접심사중  - 최종선발<br>');
   
UPDATE subject_tb 
SET capacity = 5, num_of_student = 5
WHERE id = 10000;

INSERT INTO pre_stu_sub_tb (student_id, subject_id)
VALUES 
(2023000011, 10000),
(2023000012, 10000),
(2023000013, 10000),
(2023000014, 10000),
(2023000015, 10000);

