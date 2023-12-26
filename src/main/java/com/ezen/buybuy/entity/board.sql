select * from products order by start_date desc limit 4;
select products.*, count(orders.product_idx) as order_pcs  from products natural join orders group by products.product_id  order by order_pcs desc limit 4;


SELECT *
FROM products
INNER JOIN categories ON products.ctgr_idx = categories.ctgr_idx
INNER JOIN members ON products.member_id = members.member_id
WHERE products.product_idx = 148;

select *from members;


  SELECT *
    FROM products
    INNER JOIN categories ON products.ctgr_idx = categories.ctgr_idx
    INNER JOIN members ON products.member_id = members.member_id
    WHERE products.product_idx = 148;
    
      SELECT members.name
    FROM products
    INNER JOIN categories ON products.ctgr_idx = categories.ctgr_idx
    INNER JOIN members ON products.member_id = members.member_id
    WHERE products.product_idx = 148