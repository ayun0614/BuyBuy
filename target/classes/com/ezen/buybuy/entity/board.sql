create table mboard(
   idx int not null auto_increment,
   title varchar(100) not null,
   content varchar(2000) not null,
   writer varchar(30) not null,
   indate datetime default now(),
   count int default 0,
   primary key(idx)
);	

insert into mboard(title,content,writer)
values('게시판1','게시판1','관리자1');

insert into mboard(title,content,writer)
values('게시판2','게시판2','관리자2');

insert into mboard(title,content,writer)
values('게시판3','게시판3','관리자3');

select *from mboard;
select * from mem;
create table mem(
  memIdx int auto_increment, 
  memID varchar(20) not null,  
  memPassword varchar(20) not null,
  memName varchar(20) not null,
  memAge int,
  memGender varchar(20),
  memEmail varchar(50),
  memProfile varchar(50),
  primary key(memIdx)
  
  select * from mem;
);
d
drop table Members;
CREATE TABLE Members (
    member_ID VARCHAR(50) PRIMARY KEY,
    name VARCHAR(50), 
    password VARCHAR(50),
    phone VARCHAR(20),
    addr VARCHAR(100)
);
CREATE TABLE Members (
    member_id VARCHAR(50) PRIMARY KEY  NOT NULL,
    password VARCHAR(255) NOT NULL,
    password2 VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    nickname VARCHAR(100),
    zipcode VARCHAR(10),
    addr VARCHAR(255),
    detail_addr VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(100),
    profile_img VARCHAR(255),
    join_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    account_status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE'
);


	SHOW TABLES
select * from  members

select count(*) from members where email='hoccoma.naver.com';


DELETE FROM members WHERE email = 'hoccoma@gmail.com';
DELETE FROM members WHERE email = 'hoccoma@naver.com';

update orders set status='주문 취소' where order_num=7

DELETE FROM members;

select * from orders where member_id = 'user01'

select * from  applydealeraccount


select * from  products where member_id = 'dealer01'


delete from applydealeraccount where member_id = 'dealer01'

update orders set status='주문 완료' where order_num=7
