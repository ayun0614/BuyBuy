select * from products order by start_date desc limit 4;
select products.*, count(orders.product_idx) as order_pcs  from products natural join orders group by products.product_id  order by order_pcs desc limit 4;
delete from applydealeraccount
select * from applydealeraccount
select * from members;

delete from members where member_id = 'ckck'; 
desc members

select * from orders as o INNER JOIN products as p ON o.product_idx = p.product_idx where o.member_id = 'user02' order by o.order_num desc