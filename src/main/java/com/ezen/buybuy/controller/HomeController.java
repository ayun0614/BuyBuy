package com.ezen.buybuy.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezen.buybuy.entity.Alert;
import com.ezen.buybuy.entity.Members;
import com.ezen.buybuy.mapper.AlertMapper;





@Controller
public class HomeController {
	@Autowired 
	AlertMapper alertMapper ;
	
	@RequestMapping("/")
	public String home(Members m,Alert a, RedirectAttributes rttr, HttpSession session) {
		
		Members mvo = alertMapper.Login(m);
		
		
		session.setAttribute("mvo", mvo);
		
		return "main";
	}
}