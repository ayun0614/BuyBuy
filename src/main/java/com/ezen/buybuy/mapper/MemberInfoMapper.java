package com.ezen.buybuy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ezen.buybuy.entity.Members;
import com.ezen.buybuy.entity.MyPageCNT;
import com.ezen.buybuy.entity.MypageMain;
import com.ezen.buybuy.entity.OrderInfo;
import com.ezen.buybuy.entity.Orders;


@Mapper
public interface MemberInfoMapper {

	public Members mypageInfo(String member_id);
	public MypageMain dealerRequestInfo(String member_id);
	public MyPageCNT mypageCnt(String member_id);
	
	public List<Orders> mypageOrderList(String member_id);
	
	public void deliStatusUpdate(Orders ord); 
	
	public void dealerRequest(String member_id);
	
	public List<Orders> mypagePostingList(String member_id);
	public OrderInfo mypageOrderInfo(String member_id);
	
	public void deliUpdate(Orders ord);
	
} 
