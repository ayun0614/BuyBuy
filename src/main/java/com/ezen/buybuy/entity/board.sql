select * from products order by start_date desc limit 4;
select products.*, count(orders.product_idx) as order_pcs  from products natural join orders group by products.product_id  order by order_pcs desc limit 4;
select * from orders