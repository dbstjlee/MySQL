use greencar;

create table reservation_info(
    id int primary key auto_increment,
    name varchar(30),
    pay boolean not null,
    foreign key(name) references reservation_person_info(name)
);

alter table reservation_info drop rent_date;
alter table reservation_info drop return_date;

create table reservation_person_info(
	name varchar(30) not null primary key,
    license_num varchar(30) not null,
    license_grade enum('1종', '2종') not null,
    phone_num varchar(30) not null unique
);

alter table reservation_person_info modify license_num varchar(30);
alter table reservation_person_info add unique(phone_num);

insert into reservation_info(name, pay) 
values('유재석', true),
('신동엽', true),
('이영자', true),
('전지현', true),
('이병헌', true);

insert into reservation_person_info(name, license_num, license_grade, phone_num)
values('유재석', '11-02-123456-02', '1종', '010-1111-1111'),
('신동엽', '15-17-789123-01', '2종', '010-2222-2222'),
('이영자', '13-09-456789-02', '2종', '010-3333-3333'),
('전지현', '20-14-123789-01', '2종', '010-5555-5555'),
('이병헌', '23-05-012045-02', '1종', '010-6666-6666');

select * from reservation_info;
desc reservation_info;
select * from reservation_person_info;
desc reservation_person_info;
select * from recruittable;
desc recruittable;
select * from carmanagement;
desc carmanagement;
select * from carinfo;
desc carinfo;

insert into recruittable(carid, id, rent_date, return_date)
values('47호4827', 1, '2024-05-10', '2024-05-28'),
      ('46하8247', 2, '2024-04-20', '2024-04-30'),
      ('47호4827', 3, '2024-06-01', '2024-06-20'),
      ('49허3814', 4, '2024-06-21', '2024-07-01'),
      ('48허2748', 5, '2024-06-05', '2024-06-17'),
      ('48허2748', 6, '2024-06-21', '2024-07-01'),
      ('53호6642', 7, '2024-05-20', '2024-05-28'),
      ('52하3362', 8, '2024-06-10', '2024-06-18'),
      ('51하3942', 9, '2024-04-10', '2024-04-15'),
      ('50호3827', 10, '2024-05-01', '2024-05-03');

select * from reservation_info;
select * from reservation_person_info;
select * from recruittable;
select * from carmanagement;
select * from carinfo;

-- 차량 id를 입력받았을 때 이미 그 차량이 예약이 잡혀 있는 날짜 조회 쿼리(달력, 반납일이 오늘보다 이전인 예약은 조회하지 않음)
select * from recruittable as rc
join carmanagement as cm on cm.carid = rc.carid
where dm.carid = '47호 4827';


