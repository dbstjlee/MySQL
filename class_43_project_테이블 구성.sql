use greencar;

create table carmanagement(
	carid varchar(30) primary key,
    carname varchar(30) not null,
    foreign key(carname)references carInfo(carname)
);

create table carInfo(
	carname varchar(30) not null primary key,
	cartype varchar(30) not null,
    brand varchar(30) not null,
    priceperday int not null,
    puel enum('전기', '수소', '가스', '디젤', '가솔린'),
    needlicence enum('1종', '2종')
);

create table recruittable(
	carid varchar(30),
    id int,
    rentDate date not null,
	returnDate date not null, 
    foreign key (carid) references carmanagement(carid),
    foreign key (id) references reservationInfo(id),
    primary key(carid, id)
);
 
 create table reservationInfo(
    id int primary key auto_increment,
    personId int,
    pay boolean not null,
    foreign key(personId) references reservationPersonInfo(personId)
);


create table reservationPersonInfo(
	personId int primary key auto_increment,
    name varchar(30) not null,
    licenseNum varchar(30) not null,
    licenseGrade enum('1종', '2종') not null,
    phoneNum varchar(30) not null unique
);


insert into carmanagement (carname, carid)
values('아반떼', '48허2748'),
('K3', '47호4827'),
('쏘나타', '46하8247'),
('K5', '49허3814'),
('카니발', '50호3827'),
('스타렉스', '51하3942'),
('모델3', '52하3362'),
('넥쏘', '53호6642');


insert into carinfo (carname, brand, cartype, priceperday, puel, needlicence)
values('아반떼', '현대', '준중형', 70000, '가솔린', '2종'),
('k3', '기아', '준중형', 70000, '가솔린', '2종'),
('쏘나타', '현대', '중형', 90000, '가스', '2종'),
('K5', '기아', '중형', 90000, '가스', '2종'),
('카니발', '기아', '대형', 130000, '디젤', '1종'),
('스타렉스', '현대', '대형', 130000, '디젤', '1종'),
('모델3', '테슬라', '중형', 150000, '전기', '2종'),
('넥쏘', '현대', '중형', 110000, '수소', '2종');


insert into reservationInfo(personId, pay) 
values(1, true),
	  (2, true),
      (3, true),
      (4, true),
      (5, true),
      (1, false),
      (2, false),
      (3, true),
      (4, true),
      (5, true),
      (1, true);


insert into reservationPersonInfo(name, licenseNum, licenseGrade, phoneNum)
values('유재석', '11-02-123456-02', '1종', '010-1111-1111'),
	  ('신동엽', '15-17-789123-01', '2종', '010-2222-2222'),
	  ('이영자', '13-09-456789-02', '2종', '010-3333-3333'),
	  ('전지현', '20-14-123789-01', '2종', '010-5555-5555'),
	  ('이병헌', '23-05-012045-02', '1종', '010-6666-6666');


insert into recruittable(carid, id, rentDate, returnDate)
values('47호4827', 1, '2024-05-10', '2024-05-28'),
      ('46하8247', 2, '2024-04-20', '2024-04-30'),
      ('47호4827', 3, '2024-06-01', '2024-06-20'),
      ('49허3814', 4, '2024-06-21', '2024-07-01'),
      ('48허2748', 5, '2024-06-05', '2024-06-17'),
      ('48허2748', 6, '2024-06-21', '2024-07-01'),
      ('48허2748', 7, '2024-07-15', '2024-07-31'),
      ('52하3362', 8, '2024-06-10', '2024-06-18'),
      ('51하3942', 9, '2024-04-10', '2024-04-15'),
      ('50호3827', 10, '2024-05-01', '2024-05-03'),
      ('53호6642', 11, '2024-05-01', '2024-05-03');



-- --------------------------------------------------------

create table carinfo(
    carname varchar(30) not null primary key,
    brand varchar(30) not null,
    cartype varchar(30) not null,
    priceperday int not null,
    puel enum('전기','수소','가스','디젤','가솔린'),
    needlicence enum('1종','2종')
    );
    
create table carmanagement(
    carid varchar(30) not null primary key,
    carname varchar(30),
    foreign key(carname) references carinfo(carname)
    );

CREATE TABLE users (
    username VARCHAR(15) PRIMARY KEY,
    password VARCHAR(15) NOT NULL,
    phonenum varchar(15) not null,
    address varchar(30) not null,
    email VARCHAR(30)  not null,
    licenseGrade enum('1종', '2종') not null
);

alter table users add constraint unique(phonenum, email);

CREATE TABLE reservation (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(15) NOT NULL,
    carid VARCHAR(30) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    FOREIGN KEY (username) REFERENCES users(username),
    FOREIGN KEY (carid) REFERENCES carmanagement(carid)
);



insert into carinfo(carname, brand, cartype, priceperday, puel, needlicence)
values ('아반떼', '현대', '준중형', 70000, '가솔린', '2종'),
('K3', '기아', '준중형', 70000, '가솔린', '2종'),
('쏘나타', '현대', '중형', 90000, '가스', '2종'),
('K5', '기아', '중형', 90000, '가스', '2종'),
('카니발', '기아', '대형', 130000, '디젤', '1종'),
('스타렉스', '현대', '대형', 130000, '디젤', '1종'),
('모델3', '테슬라', '중형', 150000, '전기', '2종'),
('넥쏘', '현대', '중형', 110000, '수소', '2종');

update carinfo set carname = 'K3' where carname = 'k3';


insert into carmanagement(carid, carname)
values ('48허2748', '아반떼'),
('47호4827', 'K3'),
('46하8247', '쏘나타'),
('49허3814', 'K5'),
('50호3827', '카니발'),
('51하3942', '스타렉스'),
('52하3362', '모델3'),
('53호6642', '넥쏘');


insert into users(username, password, phonenum, address, email, licenseGrade)
values ('유재석', 'asdqwe', '010-1111-1111', '서울광역시 강서구', 'a@naver.com', '2종'),
('신동엽', 'zxcasd', '010-2222-2222', '서울광역시 종로구' , 'b@naver.com', '2종'),
('이영자', 'jkl123', '010-3333-3333', '부산광역시 부산진구', 'c@naver.com', '1종'),
('전지현', 'uio123', '010-5555-5555', '부산광역시 연제구', 'd@naver.com', '2종'),
('이병헌', 'bnm456', '010-6666-6666', '부산광연시 북구', 'e@naver.com', '1종'); 


insert into users(username, password, phonenum, address, email, licenseGrade)
values ('신동엽', 'zxcasd', '010-2222-2222', '서울특별시 종로구' , 'b@naver.com', '2종');

insert into users(username, password, phonenum, address, email, licenseGrade)
values ('유재석', 'asdqwe', '010-1111-1111', '서울특별시 강서구', 'a@naver.com', '2종');

insert into reservation(username, carid, start_date, end_date)
values('유재석', '47호4827', '2024-05-10', '2024-05-28'),
('신동엽', '46하8247', '2024-04-20', '2024-04-30'), 
('이영자', '51하3942', '2024-06-01', '2024-06-20'),
('전지현', '49허3814', '2024-06-21', '2024-07-01'),
('이병헌', '50호3827', '2024-06-05', '2024-06-17');


desc users;
desc reservation;
desc carinfo;
desc carmanagement;

delete from reservation where username = '111';
update users set address = '서울특별시 강서구' where username = '유재석';


select * from users;
select * from reservation;
select * from carinfo;
select * from carmanagement;



-- username만 조회
select username
from users
where username = '유재석';

insert into reservation(username, carid, start_date, end_date)
values('박태현', '47호4827', '2024-06-14', '2024-06-20'),
('박보검', '48허2748', '2024-06-19', '2024-07-01'),
('서치원', '53호6642', '2024-05-12', '2024-05-20');

-- '이윤서', '46하8247', '2024-05-30', '2024-06-10'



-- 로그인 --> 예약자 이름, 비밀번호로 로그인 하여 예약 조회하는 쿼리
select u.username, r.carid, ci.carname, ci.brand, ci.cartype, ci.puel, ci.priceperday, u.licenseGrade, r.start_date, r.end_date
from reservation as r
join users as u
on r.username = u.username
join carmanagement as cm
on cm.carid = r.carid
join carinfo as ci
on cm.carname = ci.carname
where u.username = ? and u.password = ?;

-- 차량이 정해져있을때 그 차량이 누가 언제부터 언제까지 빌리는지 조회 쿼리
select u.username, r.start_date, r.end_date
from carinfo as ci
join carmanagement as cm
on ci.carname = cm.carname
join reservation as r
on r.carid = cm.carid
join users as u
on u.username = r.username
where ci.carname = ?;

SELECT * FROM reservation 
WHERE carid = ? AND ((start_date <= ? AND end_date >= ?) 
OR (start_date <= ? AND end_date >= ?) OR (start_date >= ? AND end_date <= ?)) ;


-- 예약 날짜 변경 쿼리 
-- (대여일)
UPDATE reservation
SET start_date = ?
WHERE reservation_id = ?;

-- (반납일)
UPDATE reservation
SET end_date = ?
WHERE reservation_id = ?;

-- 예약 차량 변경 
Update reservation set carid = ?
where reservation_id = ?;

-- 예약 취소하기
DELETE from reservation
WHERE reservation_id = ?;

-- 회원가입
insert into users(username, password, phonenum, address, email, licenseGrade)
values (?, ?, ?, ?, ?, ?);

-- 날짜가 정해져 있을 때 변경가능한 차량 목록 조회
select ci.carname, ci.brand, ci.cartype, ci.puel, ci.needlicence, ci.priceperday
from carinfo as ci
join carmanagement as cm
on ci.carname = cm.carname
join reservation as r
on r.carid = cm.carid
join users as u
on u.username = r.username
where r.start_date > ?/*클라이언트가 선택한 빌리는 날짜*/ or r.end_date < ?/*클라이언트가 선택한 반납 날짜*/;

-- 날짜가 정해져 있을 때 그 날짜에 이미 예약되어 있는 차량 조회
select ci.carname, ci.brand, ci.cartype, ci.puel, ci.needlicence, ci.priceperday
from carinfo as ci
join carmanagement as cm
on ci.carname = cm.carname
join reservation as r
on r.carid = cm.carid
join users as u
on u.username = r.username
where r.start_date > ?/*클라이언트가 선택한 빌리는 날짜*/ and r.end_date < ?/*클라이언트가 선택한 반납 날짜*/;


-- 날짜랑 차량 이름 받아서 차량 조회로 전환
update reservation set carid = ? and start_date = ? and end_date = ? 
where username = ?;


select * from users;
select * from reservation;
select * from carinfo;
select * from carmanagement;

select *
from reservation as r
join users as u
on r.username = u.username
join carmanagement as cm
on cm.carid = r.carid
join carinfo as ci
on cm.carname = ci.carname;

SELECT ri.id, rp.name, cm.carname, ci.cartype, ci.brand, 
ci.puel , rp.PhoneNum, re.rentDate, re.returnDate, 
datediff(re.returnDate, re.rentDate)*ci.priceperday as totalprice, ri.pay as paymentOrNot /*결제 여부*/ 
from reservationInfo as ri
join reservationPersonInfo as rp on ri.personid = rp.personid
join recruittable as re on re.id = ri.id
join carmanagement as cm on cm.carid = re.carid
join carinfo as ci on ci.carname = cm.carname
where ri.id = ?;

-- 예약자 이름으로 예약 조회하는 쿼리예약자
SELECT ri.id, rp.name, cm.carname, ci.cartype, ci.brand, 
ci.puel , rp.PhoneNum, re.rentDate, re.returnDate, 
datediff(re.returnDate,re.rentDate)*ci.priceperday as totalprice, ri.pay as paymentOrNot /*결제 여부*/
from reservationInfo as ri
join reservationPersonInfo as rp on ri.personid = rp.personid
join recruittable as re on re.id = ri.id
join carmanagement as cm on cm.carid = re.carid
join carinfo as ci on ci.carname = cm.carname
where rp.name = ?
order by re.rentDate desc;


-- 차량 id 를 입력 받았을 때 이미 그 차량이 예약이 잡혀있는 날짜 조회 쿼리 
-- (달력, 반납일이 오늘보다 이전인 예약은 조회하지 않음 )
select cm.carid, re.rentDate, re.returnDate
from carmanagement as cm
join recruittable as re on cm.carid = re.carid
where re.returnDate > date(curdate()) and cm.carid = ?;


-- 예약 희망 날짜를 입력 받았을 때 그날에 예약이 가능한 차량을 모두 조회하는 쿼리 
select cm.carname, cm.carid, ci.cartype, ci.brand, ci.puel, ci.needlicence, ci.priceperday, re.rentdate, re.returndate
from carmanagement as cm
join carinfo as ci on cm.carname = ci.carname
join recruittable as re on re.carid = cm.carid
where re.returnDate < ?/*클라이언트가 선택한 빌리는 날짜*/ or re.rentDate > ?/*클라이언트가 선택한 반납 날짜*/;

-- 차량을 유종으로 조회하는 쿼리
select cm.carname, cm.carid, ci.cartype, ci.brand, ci.puel, ci.needlicence, ci.priceperday
from carmanagement as cm
join carinfo as ci on cm.carname = ci.carname
where ci.puel = ?;


-- 차량을 차종으로 정렬해서 조회하는 쿼리(전체 차량조회)
select cm.carname, ci.cartype, ci.brand, ci.puel, ci.needlicence, ci.priceperday
from carmanagement as cm
join carinfo as ci on cm.carname = ci.carname
order by ci.cartype asc;


-- 차량을 이름으로 조회하는 쿼리(특정 차량 찾기)
select cm.carname, ci.cartype, ci.brand, ci.puel, ci.needlicence, ci.priceperday
from carmanagement as cm
join carinfo as ci on cm.carname = ci.carname
where cm.carname = ?;

-- 차량을 브랜드로 조회하는 쿼리
select cm.carname, ci.cartype, ci.brand, ci.puel, ci.needlicence, ci.priceperday
from carmanagement as cm
join carinfo as ci on cm.carname = ci.carname
where ci.brand = ?;


-- 차량을 요구면허로 조회하는 쿼리
select cm.carname, ci.cartype, ci.brand, ci.puel, ci.needlicence, ci.priceperday
from carmanagement as cm
join carinfo as ci on cm.carname = ci.carname
where ci.needlicence = ?;

-- 차량을 1일당 가격 순으로 오름차순 정렬하는 쿼리(최저가 정렬)
select cm.carname, ci.cartype, ci.brand, ci.puel, ci.needlicence, ci.priceperday
from carmanagement as cm
join carinfo as ci on cm.carname = ci.carname
order by ci.priceperday;

-- 차량을 1일당 가격 순으로 내림차순 정렬하는 쿼리(최고가 정렬)
select cm.carname, ci.cartype, ci.brand, ci.puel, ci.needlicence, ci.priceperday
from carmanagement as cm
join carinfo as ci on cm.carname = ci.carname
order by ci.priceperday desc;

-- 예약 날짜 변경 쿼리 
-- (대여일)
UPDATE recruittable
SET rentDate = ?
WHERE id = ?;

-- (반납일)
UPDATE recruittable
SET returnDate = ?
WHERE id = ?;

-- 예약 차량 변경 
Update recruittable set carid = ?
where id = ?;

-- 예약 취소하기
DELETE from recruittable
WHERE id = ?;

-- 예약 진행 쿼리
-- 예약 1단계 (먼저 이름, 면허증 번호, 면허 등급(1종,2종) , 휴대전화 번호 를 클라이언트 한테 받아서 입력, 새 유저 생성
-- 자바에서 방어코드 (phoneNum 으로 select 쿼리 보내서 next가 있으면 insert하지 않기 , 전화번호는 같은데 이름이 다른 경우 에러 메세지? 고민) 
INSERT INTO reservationpersoninfo(name, licensenum, licensegrade, phoneNum) 
values(?, ?, ?, ?);

-- 롤백

-- 1.5단계 auto increment 로 생성된 person id를 받아오기 , 재이용객이라면 이미 생성된 personid 받아오기
select reservationpersoninfo.personid
from reservationpersoninfo
where phoneNum = ?; 

-- 롤백

-- 예약 2단계 (기존 입력받은 이름과 지불 여부를 입력함 , 여기 들어갈때 예약 id 생성)
INSERT INTO reservationinfo(personId, pay)
values(?,?);

-- 롤백

-- 예약 2.5단계 (입력받은 값으로 예약 id를 받아옴)
SELECT reservationinfo.id 
FROM reservationinfo
WHERE personid = ?
order by reservationinfo.id desc
limit 1;

-- 롤백

-- 예약 3단계 (예약 정보 입력) -- 예약할때 선택했던 차량 번호, 2.5단계에서 받아온 예약 id, 입력받은 대여일, 반납일
INSERT INTO recruittable(carid, id, rentDate, returnDate)
values(?, ?, ?, ?); 