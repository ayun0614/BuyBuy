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
);

create table bell(
	idx int auto_increment,
	title varchar(100) not null,
	msg varchar(20) not null,
	memID varchar(20) not null,
	url varchar(200),
	state int,
	primary key(idx)
);
drop table bell;
select * from bell;



insert into bell(title,msg,memID,state) values ('abc','신청완료','bb',1);
insert into bell(title,msg,memID,url,state) values ('LCP','댓글완료','aa','www.naver.com',1);
insert into bell(title,msg,memID,url,state) values ('LCP','main1완료','aa','bellUpdate',1);
insert into bell(title,msg,memID,state) values ('LCP','aa완료','aa',1);
insert into bell(title,msg,memID,state) values ('문의','문의완료','aa',0);
insert into bell(title,msg,memID,state) values ('문의','cc완료','cc',0);
insert into bell(title,msg,memID,state) values ('문의','cc완료','cc',1);
insert into bell(title,msg,memID,state) values ('문의','cc3완료','cc',1);
insert into bell(title,msg,memID,state) values ('문의','cc4완료','aa',1);
insert into bell(title,msg,memID,state) values ('문의','cc5완료','aa',1);
insert into bell(title,msg,memID,state) values ('문의','cc5완료','aa',1);

delete from bell where idx=1;
update bell set state=0 where memID='cc';
select* from bell where memID='aa' order by idx desc



CREATE TABLE reply (
		    reply_idx INT AUTO_INCREMENT PRIMARY KEY,
		    memID VARCHAR(255),
		    content VARCHAR(255),
		    content_DT TIMESTAMP,
		    reGroup INT,
		    reSequence INT,
		    reLevel INT
		);
		
CREATE TABLE reply2 (
		    reply2_idx INT AUTO_INCREMENT PRIMARY KEY,
		    memID VARCHAR(255),
		    reply_idx INT,
		    content2 VARCHAR(255),
		    content2_DT TIMESTAMP DEFAULT CURRENT_TIMESTAMP
		   
);
		
select * from reply;
select * from reply2;
drop table reply;
drop table reply2;


CREATE TABLE alert (
    a_idx INT auto_increment PRIMARY KEY ,
    a_title VARCHAR(255) not null,
    msg VARCHAR(255) not null,
    member_id varchar(255) not null,
    a_url VARCHAR(255),
    a_state INT  
);
select * from alert where member_id='aa'
insert into alert(a_title,msg,member_id,a_url,a_state) values ('LCP','댓글완료','aa','www.naver.com',1);
insert into alert(a_title,msg,member_id,a_url,a_state) values ('LCP','댓글완료2','aa','main',1);
insert into alert(a_title,msg,member_id,a_url,a_state) values ('LCP','댓글완료2','aa','alertUpdate',1);
insert into alert(a_title,msg,member_id,a_url,a_state) values ('LCP','댓글완료3','aa','alertUpdate2',1);
insert into alert(a_title,msg,member_id,a_url,a_state) values ('LCP','댓글완료4','aa','alertUpdate3',1);
insert into alert(a_title,msg,member_id,a_url,a_state) values ('LCP','댓글완료','aa','www.naver.com',0);
drop table alert;
select * from alert;
delete from alert where a_idx =2;
CREATE TABLE members (
    member_id VARCHAR(255) PRIMARY KEY,
    password VARCHAR(255),
    name VARCHAR(255),
    nickname VARCHAR(255),
    account_iype enum('Admin', 'Dealer', 'User'),
    zipcode VARCHAR(10),
    addr VARCHAR(255),
    detailaddr VARCHAR(255),
    phone VARCHAR(20),
    join_date DATE,
    account_status enum('Activate', 'Inactivate')
);
drop table Members;
select * from members;
INSERT INTO Members (
    member_id, password, name, nickname, account_iype,
    zipcode, addr, detailaddr, phone, join_date, account_status
) VALUES (
    'aa', '1212', 'John Doe', 'johndoe', 'User',
    '12345', 'Sample Address', 'Sample Detail Address', '123-456-7890', '2023-01-01', 'Activate'
);




CREATE TABLE reply (
		    reply_idx INT AUTO_INCREMENT PRIMARY KEY,
		    product_idx int, 
		    member_id VARCHAR(255),
		    content VARCHAR(255),
		    content_date TIMESTAMP,   
		);
		
CREATE TABLE reply2 (
		    reply2_idx INT AUTO_INCREMENT PRIMARY KEY,
		    member_id VARCHAR(255),
		    reply_idx INT,
		    content2 VARCHAR(255),
		    content2_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
		   
);



