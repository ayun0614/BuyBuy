package com.ezen.buybuy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminController {
	@RequestMapping("/admin")
    public String admin() {
    	return "admin/admin";
    }
	@RequestMapping("/postmanagement")
    public String postmanagement() {
    	return "admin/postmanagement";
    }
	@RequestMapping("/usermanagement")
    public String usermanagement() {
    	return "admin/usermanagement";
    }
	@RequestMapping("/bannercontrol")
    public String bannercontrol() {
    	return "admin/bannercontrol";
    }
}
