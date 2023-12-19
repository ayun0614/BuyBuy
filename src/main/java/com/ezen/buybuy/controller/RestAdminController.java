package com.ezen.buybuy.controller;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ezen.buybuy.entity.Admin;
import com.ezen.buybuy.mapper.AdminMapper;


@RequestMapping("/admin")
@RestController
public class RestAdminController {

	@Autowired
	AdminMapper AdminMapper;
	
	@GetMapping("/all")
	public List<Admin> boardList() {
		List<Admin> li=AdminMapper.getList();
		return li;
	}
}
