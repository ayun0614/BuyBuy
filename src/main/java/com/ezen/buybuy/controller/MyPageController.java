package com.ezen.buybuy.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ezen.buybuy.entity.Members;
import com.ezen.buybuy.entity.MyPageCNT;
import com.ezen.buybuy.entity.MypageMain;
import com.ezen.buybuy.entity.OrderInfo;
import com.ezen.buybuy.mapper.MemberInfoMapper;

@Controller
public class MyPageController {
	
	@Autowired
	MemberInfoMapper memberInfoMapper;

	@RequestMapping("/myPageMain")
	public String myPageMain(String member_id, Model mo, Model mvo, Model moo, Members mem, MypageMain mpm, MyPageCNT cnt, HttpSession session) {
		mem = memberInfoMapper.mypageInfo(member_id);
		cnt = memberInfoMapper.mypageCnt(member_id);
		mpm = memberInfoMapper.dealerRequestInfo(member_id);
		session.setAttribute("mo", mem);
		session.setAttribute("mvo", cnt);
		session.setAttribute("moo", mpm);
		return "mypage/myPageMain";
	}
	
	@RequestMapping("/myPageOrder")
	public String myPageOrder() {
		return "mypage/myPageOrderList"; 
	} 
	
	@RequestMapping(value = "/myPageOrderInfo", method = RequestMethod.GET)
	public String myPageOrderInfo(String member_id, Model mo, OrderInfo oi, HttpSession session, HttpServletRequest request) {
		oi = memberInfoMapper.mypageOrderInfo(member_id);
		String order_num = request.getParameter("order_num");
		mo.addAttribute("order_num", order_num);
		session.setAttribute("mo", oi);
		//m.addAttribute("member_id", member_id);
		return "mypage/myPageOrderInfo"; 
	}
	
	@RequestMapping("/myPagePostingProduct")
	public String myPagePostingProduct() {
		return "mypage/myPagePostingProduct"; 
	}
	
}