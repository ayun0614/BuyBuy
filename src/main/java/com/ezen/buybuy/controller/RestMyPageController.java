package com.ezen.buybuy.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ezen.buybuy.entity.ApplyDealerACT;
import com.ezen.buybuy.entity.MyPagePosting;
import com.ezen.buybuy.entity.Orders;
import com.ezen.buybuy.mapper.MemberInfoMapper;

@RequestMapping("/mypage")
@RestController
public class RestMyPageController {

	@Autowired
	MemberInfoMapper memberInfoMapper;
	
	@GetMapping("/all")
	public List<Orders> boardList(String member_id) {
		List<Orders> li = memberInfoMapper.mypageOrderList(member_id);
		return li;
	}
	
	@PutMapping("/statusUpdate") 
	public void deliStatusUpdate(@RequestParam("order_num") int order_num) {
		memberInfoMapper.deliStatusUpdate(order_num);
		System.out.println(order_num);
		System.out.println("안녕");
	}
	
	@GetMapping("/postingAll")
	public List<MyPagePosting> mypagePostingList(String member_id) {
		List<MyPagePosting> li = memberInfoMapper.mypagePostingList(member_id);
		return li; 
	}
	
	@PutMapping("/dealerRequest")
	public void dealerRequest(@RequestBody ApplyDealerACT act) {
		memberInfoMapper.dealerRequest(act);  
	}
	
	@PutMapping("/deliUpdate")
	public Orders deliUpdate(@RequestBody Orders ord) {
		memberInfoMapper.deliUpdate(ord);
		return ord;
	}	
	
	@PutMapping("/productBuy")
	public void productBuy(@RequestBody Orders ord) {
		memberInfoMapper.productBuy(ord);
	}
}
