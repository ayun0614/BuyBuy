package com.ezen.buybuy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ezen.buybuy.entity.ApplyDealerACT;
import com.ezen.buybuy.entity.Members;
import com.ezen.buybuy.entity.MyPageCNT;
import com.ezen.buybuy.entity.MyPagePosting;
import com.ezen.buybuy.entity.MypageMain;
import com.ezen.buybuy.entity.OrderInfo;
import com.ezen.buybuy.entity.Orders;
import com.ezen.buybuy.entity.Products;

@Mapper
public interface MemberInfoMapper {

	public Members mypageInfo(String member_id);

	public Products productInfo(int product_idx);

	public MypageMain dealerRequestInfo(String member_id);

	public MyPageCNT mypageCnt(String member_id);

	public List<Orders> mypageOrderList(String member_id);

	public void deliStatusUpdate(int order_num);

	public void dealerRequest(ApplyDealerACT act);

	public List<MyPagePosting> mypagePostingList(String member_id);

	public OrderInfo mypageOrderInfo(@Param("order_num")int order_num, @Param("member_id")String member_id);

	public void deliUpdate(Orders ord);
	
	public void productBuy(Orders ord);
	
	public List<Orders> productBuyerList(int product_idx);

}
