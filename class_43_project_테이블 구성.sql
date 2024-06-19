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
    name varchar(30),
    pay boolean not null,
    foreign key(name) references reservationPersonInfo(name)
);

create table reservationPersonInfo(
    name varchar(30) not null primary key,
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

insert into carinfo (carname, cartype, brand, priceperday, puel, needlicence)
values('아반떼', '현대', '준중형', 70000, '가솔린', '2종'),
('k3', '기아', '준중형', 70000, '가솔린', '2종'),
('쏘나타', '현대', '중형', 90000, '가스', '2종'),
('K5', '기아', '중형', 90000, '가스', '2종'),
('카니발', '기아', '대형', 130000, '디젤', '1종'),
('스타렉스', '현대', '대형', 130000, '디젤', '1종'),
('모델3', '테슬라', '중형', 150000, '전기', '2종'),
('넥쏘', '현대', '중형', 110000, '수소', '2종');


insert into reservationInfo(name, pay) 
values('유재석', true),
	  ('신동엽', true),
      ('이영자', true),
      ('전지현', true),
      ('이병헌', true),
      ('유재석', false),
      ('신동엽', false),
      ('이영자', true),
      ('전지현', true),
      ('이병헌', true),
      ('유재석', true);

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


select * from carmanagement;
select * from carinfo;
select * from recruittable;
select * from reservationInfo;
select * from reservationPersonInfo;

drop table carinfo;
drop table carmanagement;
drop table reservationInfo;
drop table reservationPersonInfo;
drop table recruittable;


-- 예약 번호로 예약 조회하는 쿼리
SELECT ri.id, ri.name, cm.carname, ci.cartype, ci.brand, 
ci.puel , rp.PhoneNum, re.rentDate, re.returnDate, 
datediff(re.returnDate,re.rentDate)*ci.priceperday as totalprice, ri.pay as paymentOrNot /*결제 여부*/ 
from reservationInfo as ri
join reservationPersonInfo as rp on ri.name = rp.name
join recruittable as re on re.id = ri.id
join carmanagement as cm on cm.carid = re.carid
join carinfo as ci on ci.carname = cm.carname
where ri.id = ?;

-- 예약자 이름으로 예약 조회하는 쿼리예약자
SELECT ri.id, ri.name, cm.carname, ci.cartype, ci.brand, 
ci.puel , rp.PhoneNum, re.rentDate, re.returnDate, 
datediff(re.returnDate,re.rentDate)*ci.priceperday as totalprice, ri.pay as paymentOrNot /*결제 여부*/
from reservationInfo as ri
join reservationPersonInfo as rp on ri.name = rp.name
join recruittable as re on re.id = ri.id
join carmanagement as cm on cm.carid = re.carid
join carinfo as ci on ci.carname = cm.carname
where ri.name = ?
order by re.rentDate;

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
