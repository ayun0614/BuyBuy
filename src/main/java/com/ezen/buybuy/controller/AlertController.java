package com.ezen.buybuy.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ezen.buybuy.entity.Alert;
import com.ezen.buybuy.mapper.AlertMapper;



@Controller
public class AlertController {
	@Autowired 
	AlertMapper alertMapper ;
	
	//1번페이지
	@RequestMapping("/alertUpdate")
	public String alertUpdate(Alert a) {
		alertMapper.alertUpdate(a);
		
		return "redirect:/main";
	}
	//2번페이지
	@RequestMapping("/alertUpdate2")
	public String alertUpdate2(Alert a) {
		alertMapper.alertUpdate(a);
		
		return "redirect:/";
	}
	//3번페이지
	@RequestMapping("/alertUpdate3")
	public String alertUpdate3(Alert a) {
		alertMapper.alertUpdate(a);
		
		return "redirect:/";
	}
	
	@RequestMapping("/checkForUpdates")
	@ResponseBody
	public ResponseEntity<List<Alert>> checkForUpdates(@RequestParam(value = "member_id") String member_id, HttpSession session) {
	    List<Alert> ao = alertMapper.AlertList(member_id);

	    // 최신 알림을 JSON으로 반환
	    return new ResponseEntity<>(ao, HttpStatus.OK);
	}
}
