package com.ezen.buybuy.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ezen.buybuy.api.NaverLoginBO;
import com.github.scribejava.core.model.OAuth2AccessToken;

@Controller
@RequestMapping("/account/*")
public class AccountController {
	
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;
	
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	@GetMapping("/login")
	public String login(Model model, HttpSession session) {
		//네이버 인증 URL생성을 위한 BO에 getAuthorizationUrl 메소드 호출
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		model.addAttribute("naverLoginUrl", naverAuthUrl);
		
		return "account/login";
	}

	@RequestMapping("/naverlogin")
	public String isComplete(HttpSession session) {
		return "account/naverlogin";
	}

	@RequestMapping("/naverCallBack")
	public String naverCallBack(Model model, @RequestParam("code") String code, @RequestParam("state") String state, HttpSession session) throws IOException {
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		apiResult = naverLoginBO.getUserProfile(oauthToken);
		System.out.println(apiResult);
		model.addAttribute("result", apiResult);
		
		return "account/navercallback";
	}
}
