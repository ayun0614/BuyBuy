package com.ezen.buybuy.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ezen.buybuy.entity.Members;
import com.ezen.buybuy.entity.Product;
import com.ezen.buybuy.mapper.MemberInfoMapper;

@Controller
public class ProductConrtroller {

	@Autowired
	MemberInfoMapper memberInfoMapper;
	
	@RequestMapping("/productBuy")
	public String productBuy(String member_id, Model mo, Members m, Model moo, Product p, HttpSession session) {
		m = memberInfoMapper.mypageInfo(member_id);
		p = memberInfoMapper.productInfo();
		session.setAttribute("mo", m);
		session.setAttribute("moo", p);
		return "product/productBuy";
	} 
}