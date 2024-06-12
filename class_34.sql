desc user;

insert into user (username, password, email, userRole, address, createDate) 
values(?, ?, ?, ?, ?, now());

select * from user;
select * from board;
desc board;
desc reply;
select * from reply;
