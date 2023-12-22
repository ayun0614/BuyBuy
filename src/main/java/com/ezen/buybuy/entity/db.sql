select * from products;
select * from categories;
select * from orders;
select * from members;

insert into products(member_id, product_name, original_price, discount_price, discount_rate, thumbnail_img, end_date, ctgr_idx, detail_img, content_state) 
		values('user01', 'abc',15000,500,'100', 'aa',' 2023-12-15 02:17:38.0', 1,'bb','판매중');
		
