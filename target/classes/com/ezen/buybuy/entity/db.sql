select * from products;
select * from categories;
select * from orders;
select * from members;
alter table reply modify r1state int default'1';
alter table reply2 add r2state int default'1';
select * from reply;
rollback;
delete from reply
select * from alert;
insert into alert(a_title,msg,member_id,a_url,a_state)
		values('댓글','달렸습니다',(select p.member_id from reply as r inner join products as p on r.product_idx=p.product_idx where member_id='user02'),'alertUpdate',1);
		
		
INSERT INTO alert (a_title, msg, member_id, a_url, a_state)
VALUES ('댓글', '달렸습니다',
        (SELECT p.member_id 
         FROM reply AS r 
         INNER JOIN products AS p ON r.product_idx = p.product_idx 
         WHERE r.reply_idx = '33'),
        'alertUpdate', 1);	

insert into alert(a_title,msg,member_id,a_url,a_state)
values('댓글','달렸습니다',
(select DISTINCT p.member_id
from reply as r inner join products as p 
on r.product_idx=p.product_idx
where p.product_idx=1),
'alertUpdate',1);        
        
select * from reply2;
select * from alert;
select * from products;
alter table alert add product_idx int ;

SELECT DISTINCT p.member_id
FROM reply AS r
INNER JOIN products AS p ON r.product_idx = p.product_idx
WHERE r.member_id = 'user01'
LIMIT 1;

select DISTINCT member_id from reply2 where reply_idx=28


select DISTINCT a.member_id,a.a_idx,a.a_title,a.msg,a.a_url,a.a_state,a.product_idx, p.thumbnail_img from alert as a inner join products as p on a.product_idx=p.product_idx 
where a.member_id='user02' and a.a_idx=28 order by a_idx desc


insert into
alert(a_title,msg,member_id,a_url,a_state,product_idx)
values('주문','주문신청이 마감되었습니다',(select member_id from orders where product_idx=1),'alertUpdate',1)