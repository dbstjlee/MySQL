create database mydb2;
use mydb2;

create table tb_student(
	student_id int auto_increment primary key,
    student_name varchar(100) not null
);
desc tb_student;

create table tb_class(
	 class_id int auto_increment,
     class_name varchar(100) not null,
     teacher varchar(20) not null,
     primary key(class_id)
     
);
desc tb_class;

-- 학생과 수업 테이블은 N : M 관계가 형성된다. 
-- 중간 테이블 설계(수강 등록 테이블)
create table tb_registration(
	student_id int,
    class_id int,
    registration_date date,
    primary key(student_id, class_id),
    foreign key(student_id) references tb_student(student_id),
    foreign key(class_id) references tb_class(class_id)
);
desc tb_registration;