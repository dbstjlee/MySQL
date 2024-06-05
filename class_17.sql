-- left join 은 먼저 접근하는 테이블이 기준 테이블이 된다. 
-- 1단계(tb_student 테이블 먼저 접근 - null 값 존재X)
select * from tb_student as s
left join tb_grade as g
on s.grade = g.grade;

-- 2단계(tb_grade 테이블 먼저 접근 - null 값 존재O)
select * from tb_grade as g
left join tb_student as s
on g.grade = s.grade;

desc tb_student;

-- right outer join
-- (먼저 접근한 테이블은 tb_student이지만 right 기준)
select * from tb_student as s
right join tb_grade as g
on s.grade = g.grade;