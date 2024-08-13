select * from user_tb;


-- 스키마 수정
alter table user_tb add column origin_file_name varchar(200);
alter table user_tb add column upload_file_name varchar(200);
