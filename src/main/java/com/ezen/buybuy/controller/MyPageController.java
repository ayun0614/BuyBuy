package com.ezen.buybuy.controller;

import java.io.Console;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ezen.buybuy.entity.Members;
import com.ezen.buybuy.entity.MyPageCNT;
import com.ezen.buybuy.entity.MypageMain;
import com.ezen.buybuy.entity.OrderInfo;
import com.ezen.buybuy.mapper.MemberInfoMapper;
import com.ezen.buybuy.mapper.MemberMapper;

@Controller
public class MyPageController {
	
	@Autowired
	MemberInfoMapper memberInfoMapper;
	
	@Autowired
	MemberMapper memberMapper;

	@RequestMapping("/myPageMain")
	public String myPageMain(@RequestParam("member_id") String member_id, Model mo, Model mvo, Model moo, Members mem, MypageMain mpm, MyPageCNT cnt, HttpSession session, HttpServletRequest request) {
		
		cnt.setMember_id(member_id);
		 
		mem = memberInfoMapper.mypageInfo(member_id);
		cnt = memberInfoMapper.mypageCnt(member_id);
		mpm = memberInfoMapper.dealerRequestInfo(member_id);
		session.setAttribute("mo", mem);
		session.setAttribute("mvoo", cnt);
		session.setAttribute("moo", mpm);
		return "mypage/myPageMain";
	}
	
	@RequestMapping("/myPageOrder")
	public String myPageOrder(String member_id) {
		return "mypage/myPageOrderList"; 
	} 
	
	@RequestMapping("/myPageOrderInfo")
	public String myPageOrderInfo(@RequestParam("order_num") int order_num, @RequestParam("member_id") String member_id, Model mo, OrderInfo oi, HttpSession session, HttpServletRequest request) {
		oi.setMember_id(member_id); 
		oi.setOrder_num(order_num);
		oi = memberInfoMapper.mypageOrderInfo(order_num, member_id); 
		session.setAttribute("mo", oi);
		return "mypage/myPageOrderInfo"; 
	}
	
	@RequestMapping("/myPagePostingProduct")
	public String myPagePostingProduct() {
		return "mypage/myPagePostingProduct"; 
	}
}