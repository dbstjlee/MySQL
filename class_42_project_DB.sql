use greencar;

create table reservation_person_info(
	name varchar(30) not null primary key,
    license_num int not null,
    license_grade enum('1종', '2종') not null,
    phone_num varchar(30) not null
);

alter table reservation_person_info modify license_num varchar(30);
alter table reservation_person_info add unique(phone_num);

insert into reservation_info(name, pay, rent_date, return_date) 
values('유재석', true, '2024-05-10', '2024-05-30'),
('신동엽', true, '2024-04-20', '2024-04-30'),
('이영자', true, '2024-03-30', '2024-04-15'),
('전지현', true, '2024-02-05', '2024-05-06'),
('이병헌', true, '2024-06-10', '2024-07-01');

insert into reservation_person_info(name, license_num, license_grade, phone_num)
values('유재석', '11-02-123456-02', '1종', '010-1111-1111'),
('신동엽', '15-17-789123-01', '2종', '010-2222-2222'),
('이영자', '13-09-456789-02', '2종', '010-3333-3333'),
('전지현', '20-14-123789-01', '2종', '010-5555-5555'),
('이병헌', '23-05-012045-02', '1종', '010-6666-6666');

select * from reservation_info;
select * from reservation_person_info;
desc recruittable;
desc carmanagement;
desc carinfo;


