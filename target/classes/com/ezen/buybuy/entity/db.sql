select * from products;
select * from categories;
select * from orders;
select * from members;
select * from applydealeraccount
delete from applydealeraccount
select * from products where member_id = 'dealer02'

 INSERT INTO members(name, member_id, password,phone, email,zipcode, addr, detailaddr, account_type, join_date, account_status)
        VALUES(#{name},#{member_id},#{password},#{phone},#{email},#{zipcode},#{addr},#{detailaddr}, 'user', now(), 'activate')
        
update orders set status = '배송 완료' where order_num = 9
select * from members where member_id=#{member_id} and
		password=#{password}