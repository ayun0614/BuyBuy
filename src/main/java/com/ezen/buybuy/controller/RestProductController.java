package com.ezen.buybuy.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ezen.buybuy.entity.Orders;
import com.ezen.buybuy.mapper.MemberInfoMapper;

@RequestMapping("/product")
@RestController
public class RestProductController {

	@Autowired
	MemberInfoMapper memberInfoMapper;
	
	@PutMapping("/productBuy")
	public @ResponseBody void productBuy(@RequestBody Orders ord) {
		memberInfoMapper.productBuy(ord);
	}

	
}
