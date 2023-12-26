package com.ezen.buybuy.controller;

import java.io.IOException;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezen.buybuy.api.GoogleLoginBO;
import com.ezen.buybuy.api.KakaoLoginBO;
import com.ezen.buybuy.api.NaverLoginBO;
import com.ezen.buybuy.entity.Members;
import com.ezen.buybuy.entity.MyPageCNT;
import com.ezen.buybuy.entity.MypageMain;
import com.ezen.buybuy.entity.OrderInfo;
import com.ezen.buybuy.mapper.MemberInfoMapper;
import com.ezen.buybuy.mapper.MemberMapper;
import com.github.scribejava.core.model.OAuth2AccessToken;

@Controller
@RequestMapping("/account/*")
public class AccountController {

	private NaverLoginBO naverLoginBO;
	private KakaoLoginBO kakaoLoginBO;
	private GoogleLoginBO googleLoginBO;
	private String apiResult = null;
	private Members memVO;

	@Autowired
	MemberMapper memberMapper;

	@Autowired
	MemberInfoMapper memberInfoMapper;

	@Autowired
	private JavaMailSenderImpl mailSender;

	@Autowired
	private void setKakaoLoginBO(KakaoLoginBO kakaoLoginBO) {
		this.kakaoLoginBO = kakaoLoginBO;
	}

	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	@Autowired
	private void setGoogleLoginBO(GoogleLoginBO googleLoginBO) {
		this.googleLoginBO = googleLoginBO;
	}

	@GetMapping("/signIn")
	public String signIn() throws Exception {
		return "account/signIn";
	}

	@GetMapping("/kakaoLogin")
	public String kakaoLogin(HttpSession session) throws Exception {
		String kakaoAuthUrl = kakaoLoginBO.requestCode(session);
		return "redirect:" + kakaoAuthUrl;
	}

	@GetMapping("/naverLogin")
	public String naverLogin(HttpSession session) throws Exception {
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		return "redirect:" + naverAuthUrl;
	}

	@GetMapping("/googleLogin")
	public String googleLogin(HttpSession session) throws Exception {
		String googleAuthUrl = googleLoginBO.requestCode(session);
		return "redirect:" + googleAuthUrl;
	}

	@RequestMapping("/kakaoCallBack")
	public String kakaoCallBack(Model model, @RequestParam("code") String code, @RequestParam("state") String state, HttpSession session)
			throws IOException {
		String token = kakaoLoginBO.requestToken(session, code, state);
		apiResult = kakaoLoginBO.requestProfile(token);

		JSONObject full = new JSONObject(apiResult);
		JSONObject kakao_account = full.getJSONObject("kakao_account");
		JSONObject profile = kakao_account.getJSONObject("profile");

		memVO = new Members();
		memVO.setMember_id(full.getBigInteger("id").toString() + "_kakao");

		Members check = memberMapper.registerCheck(memVO.getMember_id());

		if (check == null || check.getMember_id().equals("")) {
			memVO.setPassword(full.getBigInteger("id").toString());
			memVO.setName(profile.getString("nickname"));
			memVO.setEmail(kakao_account.getString("email"));
			memVO.setProfileImg(profile.getString("thumbnail_image_url"));

			model.addAttribute("mem", memVO);
			return "account/signUp";
		}

		session.setAttribute("mvo", check);
		return "redirect:/";
	}

	@RequestMapping("/googleCallBack")
	public String googleCallBack(Model model, @RequestParam("code") String code, @RequestParam("state") String state, HttpSession session)
			throws IOException {
		String token = googleLoginBO.requestToken(session, code, state);
		apiResult = googleLoginBO.requestProfile(token);
		JSONObject full = new JSONObject(apiResult);

		memVO = new Members();
		memVO.setMember_id(full.getBigInteger("id").toString() + "_google");

		Members check = memberMapper.registerCheck(memVO.getMember_id());

		if (check == null || check.getMember_id().equals("")) {
			memVO.setPassword(full.getBigInteger("id").toString());
			memVO.setName(full.getString("name"));
			memVO.setEmail(full.getString("email"));
			memVO.setProfileImg(full.getString("picture"));

			model.addAttribute("mem", memVO);
			return "account/signUp";
		}

		session.setAttribute("mvo", check);
		return "redirect:/";
	}

	@RequestMapping("/naverCallBack")
	public String naverCallBack(Model model, @RequestParam("code") String code, @RequestParam("state") String state, HttpSession session)
			throws IOException {
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		apiResult = naverLoginBO.getUserProfile(oauthToken);
		JSONObject full = new JSONObject(apiResult);
		JSONObject response = full.getJSONObject("response");

		memVO = new Members();
		memVO.setMember_id(response.getString("id") + "_naver");

		Members check = memberMapper.registerCheck(memVO.getMember_id());

		if (check == null || check.getMember_id().equals("")) {
			memVO.setPassword(response.getString("id"));
			memVO.setName(response.getString("name"));
			memVO.setEmail(response.getString("email"));
			memVO.setProfileImg(response.getString("profile_image"));
			memVO.setPhone(response.getString("mobile"));

			model.addAttribute("mem", memVO);
			return "account/signUp";
		}

		session.setAttribute("mvo", check);
		return "redirect:/";
	}

	@RequestMapping("/signUp")
	public String signUp() {
		return "account/signUp";
	}

	@RequestMapping("/insert")
	public String insert(Members mem) {
		memberMapper.insert(mem);
		return "account/signIn";
	}

	@RequestMapping("/registerCheck")
	public @ResponseBody int registerCheck(@RequestParam("member_id") String member_id) {
		Members m = memberMapper.registerCheck(member_id);
		if (m != null || member_id.equals("")) {
			return 0; // 이미 존재하는 회원, 입력불가
		}
		return 1; // 사용가능한 아이디
	}

	@RequestMapping(value = "/mailCheck", method = RequestMethod.GET)
	@ResponseBody
	public String mailCheck(@RequestParam("email") String email) throws Exception {
		int m = memberMapper.emailCheck(email);
		System.out.println("email :" + email + "\ncount :" + m);
		if (m > 0) {
			System.out.println("using_email");
			return "using_email";
		} else {
			int serti = (int) ((Math.random() * (99999 - 10000 + 1)) + 10000);

			String from = "buybuy@naver.com";// 보내는 이 메일주소
			String to = email;
			String title = "buybuy 회원가입시 필요한 인증번호 입니다.";
			String content = "[인증번호] " + serti + " 입니다. <br/> 인증번호 확인란에 기입해주십시오.";
			try {
				MimeMessage mail = mailSender.createMimeMessage();
				MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
				mailHelper.setFrom(from);
				mailHelper.setTo(to);
				mailHelper.setSubject(title);
				mailHelper.setText(content, true);
				mailSender.send(mail);
			} catch (Exception e) {
				e.printStackTrace();
				return "error";
			}
			System.out.println("=======" + serti);
			return String.valueOf(serti);
		}
	}

	@RequestMapping("/logout")
	public String memLogout(HttpSession session) {
		session.invalidate();
		return "redirect:/main";
	}

	@RequestMapping("/myPage")
	public String myPageMain(@RequestParam("member_id") String member_id, Model mo, Model mvo, Model moo, Members mem, MypageMain mpm, MyPageCNT cnt, HttpSession session, HttpServletRequest request) {
		
		cnt.setMember_id(member_id);
		
		mem = memberInfoMapper.mypageInfo(member_id);
		cnt = memberInfoMapper.mypageCnt(member_id);
		mpm = memberInfoMapper.dealerRequestInfo(member_id);
		session.setAttribute("mo", mem);
		session.setAttribute("mvoo", cnt);
		session.setAttribute("moo", mpm);
		return "account/myPage";
	}

	@RequestMapping("/myOrderList")
	public String myPageOrder(String member_id) {
		return "account/myOrderList"; 
	} 
	@RequestMapping("/myOrderInfo")
	public String myPageOrderInfo(@RequestParam("order_num") int order_num, @RequestParam("member_id") String member_id, Model mo, OrderInfo oi, HttpSession session, HttpServletRequest request) {
		oi.setMember_id(member_id); 
		oi.setOrder_num(order_num);
		oi = memberInfoMapper.mypageOrderInfo(order_num, member_id); 
		session.setAttribute("mo", oi);
		return "account/myOrderInfo"; 
	}

	@RequestMapping("/myProducts")
	public String myPagePostingProduct() {
		return "account/myProducts"; 
	}

	@RequestMapping("/check")
	public String memLogin(Members m, RedirectAttributes rttr, HttpSession session) {
		if (m.getMember_id() == null || m.getMember_id().isEmpty() || m.getPassword() == null || m.getPassword().isEmpty()) {
			rttr.addFlashAttribute("msgType", "실패");
			rttr.addFlashAttribute("msg", "값을 모두 입력하세요");
			return "redirect:/account/login";
		}

		// 아이디나 비밀번호 길이 등 추가적인 유효성 검사 가능

		Members mvo = memberMapper.check(m);
		if (mvo != null) {
			// 로그인 성공
			rttr.addFlashAttribute("msgType", "성공");
			rttr.addFlashAttribute("msg", "로그인 되었습니다");
			session.setAttribute("mvo", mvo);
			return "redirect:/";
		} else {
			// 로그인 실패
			rttr.addFlashAttribute("msgType", "실패");
			rttr.addFlashAttribute("msg", "아이디 또는 비밀번호가 올바르지 않습니다");
			return "redirect:/account/login";
		}
	}
}
