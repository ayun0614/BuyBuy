package com.ezen.buybuy.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ezen.buybuy.entity.Orders;
import com.ezen.buybuy.mapper.MemberInfoMapper;

@RequestMapping("/account")
@RestController
public class RestAccountController {

	@Autowired
	MemberInfoMapper memberInfoMapper;
	
	@GetMapping("/all")
	public List<Orders> boardList(String member_id) {
		List<Orders> li = memberInfoMapper.mypageOrderList(member_id);
		return li;
	}
	
	@PutMapping("/statusUpdate") 
	public void deliStatusUpdate(@RequestBody Orders ord) {
		memberInfoMapper.deliStatusUpdate(ord);
	}
	
	@GetMapping("/postingAll")
	public List<Orders> mypagePostingList(String member_id) {
		List<Orders> li = memberInfoMapper.mypagePostingList(member_id);
		return li;
	}
	
	@PutMapping("/dealerRequest")
	public void boardInsert(String member_id) {
		memberInfoMapper.dealerRequest(member_id); 
	}
	
	@PutMapping("/deliUpdate")
	public Orders deliUpdate(@RequestBody Orders ord) {
		memberInfoMapper.deliUpdate(ord);
		return ord;
	}	
}
