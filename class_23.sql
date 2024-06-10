-- group by 연습
create database mydb3;
use mydb3;

CREATE TABLE tb_student (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    class CHAR(1) NOT NULL,
    score INT NOT NULL
);
    
INSERT INTO tb_student (name, class, score) VALUES
('Alice', 'A', 85),
('Bob', 'B', 75),
('Charlie', 'A', 65),
('David', 'A', 70),
('Eve', 'B', 95),
('Frank', 'C', 88),
('Grace', 'C', 92),
('Hannah', 'B', 78),
('Ian', 'A', 85),
('Jill', 'C', 90);

select * from tb_student;

-- group by 사용해보기.
-- 1단계 : 클래스 별로 그룹화 시켜보자.
select class, avg(score) AS AVERAGESCORED
from tb_student
group by class;

-- 2단계 : 클래스별로 그룹화된 결과 집합에 필터를 적용해 보자.
-- having 절의 조건은 결과집이 먼저 생성된 후의 기준으로 필터 조건을 설정해야 한다.
select class, avg(score) as 평균 
from tb_student
group by class
having 평균 >= 80; 

-- 문제 : 각 클래스에서 가장 높은 점수와 가장 낮은 점수를 찾아라.
select class, max(score) as 고득점, min(score) as 저득점
from tb_student
group by class
having MAX(score) >= 93;

-- 참고 : 만약 낮은 버전의 db를 사용한다면 별칭의 컬럼(as)은 적용되지 않을 수 있다.
-- 추후 사용할 메모리 DB -> 프레임워크 제공이라 버전이 낮을 수 있음. 
