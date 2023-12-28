package com.ezen.buybuy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ezen.buybuy.entity.Alert;
import com.ezen.buybuy.entity.Members;
import com.ezen.buybuy.entity.Reply;
import com.ezen.buybuy.entity.Reply2;

@Mapper
public interface AlertMapper {

	public List<Alert> AlertList(String member_id);

	public Members Login(Members mvo);

	public void alertUpdate(Alert a);

	public void bellUpdate(Alert b);

	public void replyinsert(Reply r);

	public List<Reply> replyselet(Reply r);

	public void replyinsert2(Reply2 r);

	public List<Reply2> replyselet2(Reply2 r2);
	
	public void replyalert(Alert a);
	
	public void replyalert2(int product_idx);
	
	public void reply2alert(int reply_idx, int product_idx);
	
	public List<String> orderList(int product_idx);
	
	public void orderAlert(String member_id, int product_idx);
	
}
