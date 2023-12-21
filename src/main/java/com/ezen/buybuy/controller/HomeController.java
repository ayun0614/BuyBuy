package com.ezen.buybuy.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ezen.buybuy.entity.Products;
import com.ezen.buybuy.mapper.MemberMapper;
import com.ezen.buybuy.mapper.ProductMapper;

@Controller
public class HomeController {

	@Autowired
	ProductMapper productVAO;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		List<Products> popList, newList;
		popList = productVAO.PopMain();
		newList = productVAO.NewMain();
		
		model.addAttribute("popList", popList);
		model.addAttribute("newList", newList);
		return "main";
	}
}