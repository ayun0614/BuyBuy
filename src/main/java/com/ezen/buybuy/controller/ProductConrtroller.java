package com.ezen.buybuy.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ezen.buybuy.entity.OrderInfo;
import com.ezen.buybuy.mapper.MemberInfoMapper;

@Controller
public class ProductConrtroller {

	@Autowired
	MemberInfoMapper memberInfoMapper;
	
	@RequestMapping("/productBuy")
	public String productBuy(String member_id, Model mo, OrderInfo oi, HttpSession session) {
		oi = memberInfoMapper.mypageOrderInfo(member_id);
		session.setAttribute("mo", oi);
		return "product/productBuy";
	} 

	
}