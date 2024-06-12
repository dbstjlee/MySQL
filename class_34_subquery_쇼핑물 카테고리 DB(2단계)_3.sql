use demo3;
create table tb_products(
	product_id int auto_increment primary key,
    product_name varchar(255),
    category_id int,
    price decimal(10,2),
    size varchar(10),
    color varchar(50),
    foreign key(category_id) references tb_categories(category_id)
);

-- 남성복 상품 입력
insert into tb_products(product_name, category_id, price, size, color)
values('남성셔츠', 4, 49000, 'L', '퍼플'),
      ('남성면바지', 7, 59000, 'M', '핑크'),
      ('남성슬랙스', 8, 105000, 'XL', '샤인');
      
-- 여성복 상품 입력      
insert into tb_products(product_name, category_id, price, size, color)
values('여성셔츠', 6, 49000, 'L', '퍼플'),
      ('여성면바지', 9, 59000, 'M', '핑크'),
      ('여성슬랙스', 10, 105000, 'XL', '샤인');

select * from tb_products;

-- 특정 카테고리에 속하는 모든 상품 조회
-- 1단계 (남성, 여성 팬츠에 속하는 상품을 모두 조회)
select p.product_name, p.price, p.size, p.color
from tb_products as p
join tb_categories as c
on p.category_id = c.category_id
where c.category_name = '면바지';


-- 2단계 (만약 여성 면바지만 출력하고 싶다면)
-- join --> subquery (쿼리 안에 쿼리)
select p.product_name, p.price, p.size, p.color, c.parent_id
from tb_products as p
join tb_categories as c
on p.category_id = c.category_id
where c.category_name = '면바지' and c.parent_id = 5;

-- c.parent_id = 5의 '5'를 select 구문(subquery)으로...
select p.product_name, p.price, p.size, p.color, c.parent_id
from tb_products as p
join tb_categories as c
on p.category_id = c.category_id
where c.category_name = '면바지' 
and c.parent_id = 
(select category_id from tb_categories where category_name = '팬츠' and parent_id = 2);

-- 여성, 남성 팬츠 모두 출력됨.(다중행으로 출력되었으나 단일행으로 들어가야 함.)
select * from tb_categories where category_name = '팬츠';

-- 여성 팬츠만 출력됨.(단일행)(여성복 -> 팬츠)
select * from tb_categories where category_name = '팬츠' and parent_id = 2;

-- 여성 팬츠의 parent_id = 2만 출력됨.
select parent_id from tb_categories where category_name = '팬츠' and parent_id = 2;

-- 여성 팬츠의  category_id = 5만 출력됨.
select category_id from tb_categories where category_name = '팬츠' and parent_id = 2;


-- 문제 1. 남성복 셔츠만 출력하시오. 
-- 예시 1
select p.product_name, p.price, p.size, p.color, c.parent_id
from tb_products as p
join tb_categories as c
on p.category_id = c.category_id
where product_name = '남성셔츠';

-- 예시2
select p.product_name, p.price, p.size, p.color, c.parent_id
from tb_products as p
join tb_categories as c
on p.category_id = c.category_id
where c.category_name = '셔츠' and c.parent_id = 1;

-- 예시3(subquery 사용)
select p.product_name, p.price, p.size, p.color, c.parent_id
from tb_products as p
join tb_categories as c
on p.category_id = c.category_id
where c.category_name = '셔츠'
and c.parent_id
= (select parent_id from tb_categories where category_name = '셔츠' and parent_id = 1);

-- 남성, 여성 셔츠 전부 출력(다중행)
select * from tb_categories where category_name = '셔츠'; 

-- 남성 셔츠만 출력(단일행) (남성복 -> 셔츠)
select * from tb_categories where category_name = '셔츠' and parent_id = 1; 

-- 남성 셔츠의 parent_id만 출력
select parent_id from tb_categories where category_name = '셔츠' and parent_id = 1; 


-- 문제 2. 여성복 슬랙스만 출력하시오.
-- 예시1
select p.product_name, p.price, p.size, p.color, c.parent_id
from tb_products as p
join tb_categories as c
on p.category_id = c.category_id
where product_name = '여성슬랙스';

-- 예시2
select p.product_name, p.price, p.size, p.color, c.parent_id
from tb_products as p
join tb_categories as c
on p.category_id = c.category_id
where c.category_name = '슬랙스' and c.parent_id = 5;

-- 예시3(subquery 사용)
select p.product_name, p.price, p.size, p.color, c.parent_id
from tb_products as p
join tb_categories as c
on p.category_id = c.category_id
where c.category_name = '슬랙스'
and c.parent_id
= (select parent_id from tb_categories where category_name = '슬랙스' and parent_id = 5);

-- 남성, 여성 슬랙스 전부 출력(다중행)
select * from tb_categories where category_name = '슬랙스';

-- 여성 슬랙스만 출력(단일행) (여성복 -> 팬츠 -> 슬랙스)
select * from tb_categories where category_name = '슬랙스' and parent_id = 5;

-- 여성 슬랙스의 parent_id = 5 만 출력됨.
select parent_id from tb_categories where category_name = '슬랙스' and parent_id = 5;


-- c.parent_id -> c.category_id 기준(여성 슬랙스만 출력)
select p.product_name, p.price, p.size, p.color, c.category_id
from tb_products as p
join tb_categories as c
on p.category_id = c.category_id
where c.category_name = '슬랙스'
and c.category_id
= (select category_id from tb_categories where category_name = '슬랙스' and category_id = 10);


use demo3;
select * from tb_categories;
select * from tb_products;

-- 문제 3. 특정 색상의 상품이 있는 모든 카테고리 조회
-- 예를 들어, 퍼플 상품이 있는 모든 카테고리를 조회하는 쿼리 
select p.product_name, p.price, p.size, p.color, c.parent_id
from tb_products as p
join tb_categories as c
on p.category_id = c.category_id
where p.color = '퍼플';


-- 문제 4. 가장 비싼 상품을 가진 카테고리 찾기(서브쿼리 사용할 필요 없음)
-- 각 카테고리 중 가장 비싼 상품을 가지고 있는 카테고리와 그 상품의 정보를 조회하는 쿼리
select p.product_name, Max(p.price), p.size, p.color
from tb_products as p
join tb_categories as c
on p.category_id = c.category_id
group by p.product_name
having Max(p.price) >= 100000;

-- subquery
-- 3가지 중 스칼라? 말고는 사용 가능
-- 장점: 코드 분석이 간결하고 가독성 있음.
-- 단점: 속도 느림.
-- join으로 대부분 대체 가능, 안 되는 경우 서브쿼리 사용


-- 1일 1쿼리
select * from titles where title = 'staff';
select * from titles where title = 'Senior Engineer';
select * from titles;
select * from dept_emp;
select * from departments;
select * from salaries;
select * from employees;

-- 다음에 써야지..
-- Engineer 직급 중 최고 연봉을 가진 직원 5명을 조회하시오.
select t.title, e.emp_no, e.first_name, s.salary
from titles as t
join salaries as s
on t.emp_no = s.emp_no
join employees as e
on e.emp_no = t.emp_no
where t.title = 'Engineer'
order by s.salary desc
limit 5;


-- 서브쿼리....
-- 부서 번호가 d009인 부서에서 재직중이며 매니저가 있는 직원을 조회하여라.(직원 번호, 이름, 부서명)
-- 단, 서브쿼리를 사용하여 departments 테이블의 dept_name에 담아서 출력하여라.
select e.emp_no,  e.first_name, d.dept_name
from employees as e
join dept_manager as m
on e.emp_no = m.emp_no
join departments as d
on d.dept_no = m.dept_no
where m.to_date = '9999-01-01'
and d.dept_name = (select dept_name from departments where dept_no = 'd009');

select e.emp_no,  e.first_name, d.dept_name
from employees as e
join dept_manager as m
on e.emp_no = m.emp_no
join departments as d
on d.dept_no = m.dept_no
where d.dept_name = 'Customer Service'
and m.to_date = '9999-01-01';

select e.emp_no,  e.first_name, d.dept_name
from employees as e
join dept_manager as m
on e.emp_no = m.emp_no
join departments as d
on d.dept_no = m.dept_no
where m.to_date = '9999-01-01'
and d.dept_no = 'd009';


select dept_name from departments where dept_no = 'd009';
select parent_id from tb_categories where category_name = '슬랙스';
select * from departments;
select * from dept_manager;