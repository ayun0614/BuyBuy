select * from products;
select * from categories;
select * from orders;
select * from members;
select * from members;
select * from reply;
select * from reply2;

SELECT
    r.reply_idx,
    r2.reply2_idx,
    r.product_idx,
    p.*,
    m.member_id AS member_id,
    m.name AS member_name,
    m.nickname AS member_nickname,
    m.profileimg AS member_profileimg
FROM
    reply AS r
INNER JOIN
    reply2 AS r2 ON r.reply_idx = r2.reply_idx
INNER JOIN
    products AS p ON r.product_idx = p.product_IDX
INNER JOIN
    members AS m ON r.member_id = m.member_id;
    
    select m.*, r.* from reply as r inner join members as m on r.member_id=m.member_id
   
    select m.*, r2.* from reply2 as r2 inner join members as m on r2.member_id=m.member_id 
SELECT m.*, r.*, r2.reply2_idx
FROM reply AS r
INNER JOIN members AS m ON r.member_id = m.member_id
INNER JOIN reply2 AS r2 ON r.reply_idx = r2.reply_idx;