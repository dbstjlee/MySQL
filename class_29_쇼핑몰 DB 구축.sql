
-- 쇼핑몰 서비스의 DB 구축

 create table User(
	id int primary key auto_increment,
    username varchar(50) not null, 
    email varchar(100) not null unique,
    password varchar(255) not null, -- 보안 생각해서 255(암호화해야 함)
    address varchar(255),
    created_at timestamp default current_timestamp
 );

create table Product(
	id int primary key auto_increment,
    name varchar(100) not null,
    description text,
    price decimal(10, 2) not null,
    stock int default 0,
    created_at timestamp default current_timestamp
);

create table `Order`(
	id int primary key auto_increment,  -- 주문 id(PK)
    user_id int not null, -- 주문한 고객의 id(FK)
    total_price decimal(10, 2) not null, -- 총 주문 금액
    created_at timestamp default current_timestamp, -- 주문 시간
    foreign key(user_id) references User(id)
);

create table Order_detail(
	id int primary key auto_increment, -- 주문 상세 고유 ID(PK)
    order_id int not null, -- 주문 ID(FK)
	product_id int not null, -- 주문한 상품 id(FK)
    count int not null, -- 주문 수량
    price decimal(10, 2) not null, -- 상품의 주문 가격
    foreign key(order_id) references `Order`(id),
    foreign key(product_id) references Product(id)
);

drop table Order_detail;
drop table `Order`;
desc Order_detail;
desc `Order`;


-- 유저측에서 정보를 받는 오더테이블 : 판매자측 에서 정보를 받는 오더테이블
-- 유저 테이블과 물품 테이블에서 기본적인 정보는 받아 오게 설계.
-- 1:n 관계 
create table userorder(
    order_id int auto_increment primary key, -- 주문id pk
    user_id int, -- 포린키, 유저 테이블 매칭
    description text, -- 배송 메세지 ex): 문앞에 놔두고 가주세요 벨X
    payment boolean, -- 결제 여부
    orderTime TIMESTAMP, -- 주문 시간
    Deliveryavailability boolean, -- 배송 여부 
    orderprice DECIMAL(10, 2) not null, -- 해당 주문의 총 가격
    foreign key(user_id) references user(id) -- 포린키 설정 유저 -> 유저오더
);

create table productorder(
    order_id int, -- 포린키, 오더측 주문 테이블 매칭
    product_id int, -- 포린키, 물품 테이블 매칭
    count int not null , -- 물품 주문 수량
    deliveryfee decimal(10, 2), -- 배송비 , 금액에 따라 0원이 될수 있으므로 null 허용 
    foreign key(order_id) references userorder(order_id), -- 포린키 설정 유저오더 -> 물품오더
    foreign key(product_id) references product(id) -- 포린키 설정 물품 -> 물품오더
);