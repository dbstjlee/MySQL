create table TB_USER(
	 user_id int auto_increment,
     username varchar(50) not null,
     password varchar(50) not null,
     primary key(user_id)
);

-- 1 : 1 --> user_id에 unique 가 들어올 수 있다. 
create table tb_user_details(
	details_id int auto_increment,
    user_id int unique,
    address varchar(100), 
    phone_number varchar(15), 
    email varchar(50),
    primary key(details_id),
    foreign key(user_id) references tb_user(user_id)
);

create table tb_team(
	team_id int,
    team_name varchar(50),
    home_city varchar(50),
    established_year Year,
    primary key(team_id)
);
desc tb_team;

create table tb_player(
	player_id int,
    player_name varchar(10),
    age int,
    position varchar(10),
    birth_date date,
    team_id int,
    primary key(player_id),
    foreign key(team_id) references tb_team(team_id)
);
desc tb_player;