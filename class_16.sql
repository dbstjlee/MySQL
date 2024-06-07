
create table tb_student(
	 no int not null primary key,
     name varchar(20) not null,
     gender enum('F', 'M') not null,
     grade char(1),
     foreign key(grade) references tb_grade(grade)
);
desc tb_student;

create table tb_grade(
	grade char(1) primary key,
    score int 
);
desc tb_grade;

-- 테이블은 정보의 최소 단위이다. 
insert into tb_grade() values ('A', 100);
insert into tb_grade() values ('B', 80);
insert into tb_grade() values ('C', 60);
insert into tb_grade() values ('D', 40);
insert into tb_grade() values ('E', 20);
insert into tb_grade() values ('F', 0);

-- 오류 발생! 아래에서 스키마 추가
insert into tb_student(no, name, gender, grade, age) values('100','길동', 'F','B', 25);
select * from tb_student;

-- 스키마 구조 변경이 필요하다.
-- alter table 테이블명 행동(add) 컬럼명 제약사항;
alter table tb_student add age int;

insert into tb_student(no, name, gender, grade, age) values('100','길동', 'F','A', 35);
insert into tb_student(no, name, gender, grade, age) values('200','둘리', 'M','B', 25);
insert into tb_student(no, name, gender, grade, age) values('300','마이콜', 'F','B', 15);
insert into tb_student(no, name, gender, grade, age) values('400','야스오', 'M','C', 25);
insert into tb_student(no, name, gender, grade, age) values('500','티모', 'F','E', 25);

-- join 연산에 on 절 사용x --> cross join이 된다. 
select * from tb_student
join tb_grade;

select * from tb_grade
join tb_student;

-- join 연산은 가능한 on 절과 함께 사용하자. 
-- join --> inner join, outer join
-- inner join = join

-- 1단계
select * from tb_student
join tb_grade
on tb_student.grade = tb_grade.grade;

-- 2단계(필요한 부분만 가져오기)
select s.no, s.name, s.grade, s.age, g.score 
from tb_student as s
join tb_grade as g
on s.grade = g.grade;