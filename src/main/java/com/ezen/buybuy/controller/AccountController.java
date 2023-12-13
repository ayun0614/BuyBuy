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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ezen.buybuy.api.KakaoLoginBO;
import com.ezen.buybuy.api.NaverLoginBO;
import com.ezen.buybuy.mapper.MemberMapper;
import com.github.scribejava.core.model.OAuth2AccessToken;

@Controller
@RequestMapping("/account/*")
public class AccountController {


	
	private NaverLoginBO naverLoginBO;
	private KakaoLoginBO kakaoLoginBO;
	private String apiResult = null;

	@Autowired
	private void setKakaoLoginBO(KakaoLoginBO kakaoLoginBO) {
		this.kakaoLoginBO = kakaoLoginBO;
	}

	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	@GetMapping("/login")
	public String login(Model model, HttpSession session) throws Exception {
		// 네이버 인증 URL생성을 위한 BO에 getAuthorizationUrl 메소드 호출
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		String kakaoAuthUrl = kakaoLoginBO.requestCode(session);
		model.addAttribute("naverLoginUrl", naverAuthUrl);
		model.addAttribute("kakaoLoginUrl", kakaoAuthUrl);

		return "account/login";
	}

	@RequestMapping("/kakaoCallBack")
	public String kakaoCallBack(Model model, @RequestParam("code") String code, @RequestParam("state") String state, HttpSession session)
			throws IOException {
		String token = kakaoLoginBO.requestToken(session, code, state);
		apiResult = kakaoLoginBO.requestProfile(token);
		model.addAttribute("result", apiResult);
		
		return "account/kakaocallback";
	}

	@RequestMapping("/naverCallBack")
	public String naverCallBack(Model model, @RequestParam("code") String code, @RequestParam("state") String state, HttpSession session)
			throws IOException {
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		apiResult = naverLoginBO.getUserProfile(oauthToken);
		model.addAttribute("result", apiResult);

		return "account/navercallback";
	}
}


