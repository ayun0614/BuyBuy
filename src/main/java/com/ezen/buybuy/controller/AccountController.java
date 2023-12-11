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

	@RequestMapping(value = "/personalInfo")
	public void personalInfo(HttpServletRequest request) throws Exception {
		// 네이버 로그인 접근 토큰; 여기에 복사한 토큰값을 넣어줍니다.
		String token = "AAAAPD-PZfpOw7nwk1oo3_lKhLCSm3NArZAYsjLy6LGpDSllVElkc9DWO91nTZPWdSAdenJVaeaX-wZ5CaeSNJqipqY";
		// Bearer 다음에 공백 추가
		String header = "Bearer " + token;

		try {
			String apiURL = "https://openapi.naver.com/v1/nid/me";
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Authorization", header);
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();
			System.out.println(response.toString());
		} catch (Exception e) {
			System.out.println(e);
		}
	}
}
