create table members(
  member_id varchar(20) not null,  
  password varchar(20) not null,
  name varchar(20) not null,
  nickname varchar(20),
  account_type varchar(20),
  zipcode int,
  addr varchar(50),
  detailaddr varchar(50),
  phone varchar(20),
  email varchar(50),
  profileImg varchar(50),
  join_date date,
  account_status varchar(50),
  primary key(member_id)
);

insert into members(member_id,password,name,nickname,account_type,zipcode,addr, detailaddr, phone, email, join_date, account_status)
		values("cc","cc","크리스틴","닉","dealer","22131","서울특별시 서대문구 연세대로 14","무슨 빌라","010-3421-6324","cc@gmail.com",now(),"activate")

insert into members(member_id,password,name,nickname,account_type,zipcode,addr, detailaddr, phone, email, join_date, account_status)
		values("bb","bb","팬텀","닉닉","user","20131","서울특별시 마포구 연희대로 15","무슨 아파트","010-2315-1231","bb@gmail.com",now(),"activate")

drop table members;
select * from members;

drop table products;
drop table orders;

select * from applydealeraccount as a INNER JOIN members as m ON a.member_id = m.member_id where m.member_id='bb'

create table products(
  product_idx int not null auto_increment,
  product_name varchar(100) not null,
  start_date datetime,
  end_date datetime,
  thumbnail_img varchar(50),
  original_price varchar(20),
  discount_price varchar(20),
  discount_rate varchar(20),
  detail_img varchar(50),
  content_state varchar(20),
  ctgr_idx varchar(20),
  member_id varchar(20),
  primary key(product_idx),
  foreign key(member_id) references members(member_id)
);

insert into products(product_name,start_date,end_date,original_price,discount_price,discount_rate,content_state, member_id)
		values("겨울 양말 10개 세트",now(),"2023-12-24 12:14:00","19,900","10,800","46%","판매중","cc")

insert into products(product_name,start_date,end_date,original_price,discount_price,discount_rate,content_state, member_id)
		values("온열 진동 마사지 매트",now(),"2023-12-21 12:11:00","24,900","16,700","33%","배송중","cc")

insert into products(product_name,start_date,end_date,original_price,discount_price,discount_rate,content_state, member_id)
		values("밤쌀당 알밤 밤식빵 (1+1)",now(),"2024-01-24 06:12:00","17400","11400","32%","배송완료","cc")

		
select * from products;
		
CREATE TABLE orders (
    order_num INT not null auto_increment,
    product_idx INT,
    member_id VARCHAR(255),
    order_pcs INT,
    total_price VARCHAR(255),
    order_date DATE,
    deli_name VARCHAR(255),
    deli_phone VARCHAR(255),
    deli_zipcode int,
    deli_addr VARCHAR(255),
    deli_detailaddr VARCHAR(255),
    deli_memo VARCHAR(255),
    pay_type VARCHAR(255),
    status VARCHAR(255),
    primary key(order_num),
    FOREIGN KEY (product_idx) REFERENCES products(product_idx),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);





select count(case when o.status = '주문 완료' then o.status end) as count_orderend, count(case when o.status = '배송중' then o.status end) as count_ing, count(case when o.status = '배송 완료' then o.status end) as count_end  from orders as o INNER JOIN members as m ON m.member_id = o.member_id where m.member_id = 'bb'





select * from members

INSERT INTO orders (product_idx, member_id, order_pcs, total_price, order_date,deli_name,deli_phone, deli_zipcode, deli_addr, deli_detailaddr, deli_memo, pay_type, status)
VALUES (1, 'bb', 2, "21,600", now(),'팬텀','010-2315-1231', '20131', '서울특별시 마포구 연희대로 15', '무슨 아파트', '문앞에 놔주세요', '카드 결제', '주문 완료');

INSERT INTO orders (product_idx, member_id, order_pcs, total_price, order_date,deli_name,deli_phone, deli_zipcode, deli_addr, deli_detailaddr, deli_memo, pay_type, status)
VALUES (2, 'bb', 1, "16,700", now(),'팬텀','010-2315-1231', '20131', '서울특별시 마포구 연희대로 15', '무슨 아파트', '문앞에 놔주세요', '무통장 결제', '배송중');

INSERT INTO orders (product_idx, member_id, order_pcs, total_price, order_date,deli_name,deli_phone, deli_zipcode, deli_addr, deli_detailaddr, deli_memo, pay_type, status)
VALUES (2, 'cc', 1, "16,700", now(),'팬텀','010-2315-1231', '20131', '서울특별시 마포구 연희대로 15', '무슨 아파트', '문앞에 놔주세요', '무통장 결제', '배송중');

INSERT INTO orders (product_idx, member_id, order_pcs, total_price, order_date,deli_name,deli_phone, deli_zipcode, deli_addr, deli_detailaddr, deli_memo, pay_type, status)
VALUES (3, 'bb', 1, "11400", now(),'팬텀','010-2315-1231', '20131', '서울특별시 마포구 연희대로 15', '무슨 아파트', '문앞에 놔주세요', '무통장 결제', '배송 완료');

update orders set status = '배송중' where member_id = 'bb' and order_num = 4

select * from products;
select * from orders;
delete from orders where order_num = 3
drop table orders;

ALTER TABLE products MODIFY original_price int;
ALTER TABLE members ADD applydealer_status int;
update members set applydealer_status = 0 where member_id = 'bb'
update members set applydealer_status = 0 where member_id = 'cc'

select * from orders as o INNER JOIN products as p ON o.product_idx = p.product_idx where o.member_id = 'bb'

update orders set status='주문 완료' where order_num=1

select * from orders as o INNER JOIN products as p ON o.product_idx = p.product_idx INNER JOIN members as m ON m.member_id = o.member_id where o.member_id = 'bb' and o.order_num = '1'
select * from orders as o INNER JOIN products as p ON o.product_idx = p.product_idx INNER JOIN members as m ON m.member_id = p.member_id where m.member_id = 'bb' and o.order_num = '1'

create table reviewproducts(
  product_idx int,
  member_id VARCHAR(255),
  view_count int,
  foreign key(member_id) references members(member_id),
  foreign key(product_idx) references products(product_idx)
);

create table applydealeraccount(
  member_id VARCHAR(255),
  status int,
  foreign key(member_id) references members(member_id)
);

insert into applydealeraccount
values('bb', 1)

select * from applydealeraccount
delete from applydealeraccount
drop table applydealeraccount

insert into reviewproducts
values(1, 'cc', 1221)

insert into reviewproducts
values(2, 'cc', 5324)

insert into reviewproducts
values(3, 'cc', 124)

select * from products as p INNER JOIN reviewproducts as r ON p.product_idx = r.product_idx where p.member_id = 'cc'

update orders set status = '주문 완료' where order_num = 4
select * from orders

select * from applydealeraccount as a INNER JOIN members as m ON a.member_id = m.member_id where a.member_id='bb'
delete from applydealeraccount where member_id = 'bb'

ALTER TABLE applydealeraccount ADD UNIQUE KEY(member_id)
select * from applydealeraccount
delete from applydealeraccount

