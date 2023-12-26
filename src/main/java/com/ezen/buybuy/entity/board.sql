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

SHOW COLUMNS from orders

alter table orders modify order_date datetime

select * from orders

update orders set order_date = now()



select * from orders where member_id = 'user01'
select * from products
select * from orders


select * from members

SHOW COLUMNS from applydealeraccount

select * from applydealeraccount

ALTER TABLE members DROP applydealer_status

delete from applydealeraccount


INSERT INTO categories(ctgr_name)
   VALUES("의류")
INSERT INTO categories(ctgr_name)
   VALUES("홈데코")
INSERT INTO categories(ctgr_name)
   VALUES("컴퓨터")
INSERT INTO categories(ctgr_name)
   VALUES("건강")
INSERT INTO categories(ctgr_name)
   VALUES("화장품")
INSERT INTO categories(ctgr_name)
   VALUES("문구")
INSERT INTO categories(ctgr_name)
   VALUES("모바일")
INSERT INTO categories(ctgr_name)
   VALUES("공구")
INSERT INTO categories(ctgr_name)
   VALUES("식품")
INSERT INTO categories(ctgr_name)
   VALUES("취미")
INSERT INTO categories(ctgr_name)
   VALUES("가전제품")
INSERT INTO categories(ctgr_name)
   VALUES("기타")
INSERT INTO categories(ctgr_name)
   VALUES("생필품")
INSERT INTO categories(ctgr_name)
   VALUES("반려용품")
INSERT INTO categories(ctgr_name)
   VALUES("스포츠")



select * from members

update categories set ctgr_idx = 15 where ctgr_idx = 30


INSERT INTO members(member_id, password, name, nickname, account_type, zipcode, addr, detailaddr, phone, email, join_date, account_status)
   VALUES("user01", "1234", "유저01", "닉네임01", "user", "22131", "서울특별시 서대문구 00로 14", "00빌라", "010-3421-6324", "user01@gmail.com", now(), "activate")
INSERT INTO members(member_id, password, name, nickname, account_type, zipcode, addr, detailaddr, phone, email, join_date, account_status)
   VALUES("user02","1234","유저02","닉네임02","user","20131","서울특별시 마포구 00대로 15","00아파트","010-2315-1231","user02@gmail.com",now(),"activate", 0)
INSERT INTO members(member_id, password, name, nickname, account_type, zipcode, addr, detailaddr, phone, email, join_date, account_status, applydealer_status)
   VALUES("dealer01", "1234", "딜러01", "닉네임03", "dealer", "12532", "서울특별시 서초구 00대로 4", "00빌라", "010-2624-7235", "dealer01@gmail.com", now(), "activate", 0)
INSERT INTO members(member_id, password,name, nickname, account_type, zipcode, addr, detailaddr, phone, email, join_date, account_status, applydealer_status)
   VALUES("dealer02", "1234", "딜러02", "닉네임04", "dealer", "17464", "서울특별시 노원구 00로 12", "00아파트", "010-7395-1273", "dealer02@gmail.com", now(), "activate", 0)

   
   INSERT INTO products(product_name, start_date, end_date, original_price, discount_price, discount_rate, content_state, ctgr_idx, member_id)
   VALUES("겨울 양말 10개 세트", now(), "2023-12-24 12:14:00", "19900", "10800", "46%", "판매중", 1, "dealer01")
INSERT INTO products(product_name, start_date, end_date, original_price, discount_price, discount_rate, content_state, ctgr_idx, member_id)
   VALUES("온열 진동 마사지 매트", now(), "2023-12-21 12:11:32", "24900", "16700", "33%", "배송중", 4, "dealer02")
INSERT INTO products(product_name, start_date, end_date, original_price, discount_price, discount_rate, content_state, ctgr_idx, member_id)
   VALUES("밤쌀당 알밤 밤식빵 (1+1)", now(), "2024-01-24 06:12:00", "17400", "11400", "32%", "배송 완료", 9, "dealer01")
INSERT INTO products(product_name, start_date, end_date, original_price, discount_price, discount_rate, content_state, ctgr_idx, member_id)
   VALUES("하운드체크 캐시미어 롱머플러 (1+1 추가할인)", now(), "2024-01-14 09:28:00", "19000", "9800", "66%", "판매중", 1, "dealer02")
INSERT INTO products(product_name, start_date, end_date, original_price, discount_price, discount_rate, content_state, ctgr_idx, member_id)
   VALUES("[1+1] [스윗홈] 안전한 국산 16A 멀티탭 모음전 2구/3구/4구/5구/6구", now(), "2024-01-17 12:37:00", "7800", "4900", "37%", "판매중", 11, "dealer02")
INSERT INTO products(product_name, start_date, end_date, original_price, discount_price, discount_rate, content_state, ctgr_idx, member_id)
   VALUES("[굿츄] 츄르 짜먹는 고양이 간식 1box(15g) 30개입", now(), "2024-03-15 11:18:00", "15000", "9900", "34%", "판매중", 14, "dealer01")

   select * from orders
delete from orders
   
   INSERT INTO reviewproducts
   VALUES(161, 1221)
INSERT INTO reviewproducts
   VALUES(162, 8235)
INSERT INTO reviewproducts
   VALUES(163, 362)
INSERT INTO reviewproducts
   VALUES(164, 184)
INSERT INTO reviewproducts
   VALUES(165, 2773)
INSERT INTO reviewproducts
   VALUES(166, 1129)


