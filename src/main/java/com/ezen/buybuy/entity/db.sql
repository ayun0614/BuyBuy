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
        
        select * from reply;