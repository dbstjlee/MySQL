create database demo6;
use demo6;

create table posts(
	id int auto_increment primary key,
    title varchar(255) not null,
    content text not null,
    created_at timestamp default current_timestamp
);

select * from posts;
select * FROM posts WHERE id = 5;
