package com.ezen.buybuy.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import com.ezen.buybuy.api.GoogleLoginBO;
import com.ezen.buybuy.api.ImgurBO;
import com.ezen.buybuy.api.KakaoLoginBO;
import com.ezen.buybuy.api.NaverLoginBO;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
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
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@Controller
@RequestMapping("/account/*")
public class AccountController {

	private NaverLoginBO naverLoginBO;
	private KakaoLoginBO kakaoLoginBO;
	private GoogleLoginBO googleLoginBO;
	private ImgurBO imgurBO;
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
	public String kakaoCallBack(Model model, @RequestParam("code") String code, @RequestParam("state") String state,
			HttpSession session)
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
			memVO.setProfileimg(profile.getString("thumbnail_image_url"));

			model.addAttribute("mem", memVO);
			return "account/signUp";
		}

		session.setAttribute("mvo", check);
		return "redirect:/";
	}

	@RequestMapping("/googleCallBack")
	public String googleCallBack(Model model, @RequestParam("code") String code, @RequestParam("state") String state,
			HttpSession session)
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
			memVO.setProfileimg(full.getString("picture"));

			model.addAttribute("mem", memVO);
			return "account/signUp";
		}

		session.setAttribute("mvo", check);
		return "redirect:/";
	}

	@RequestMapping("/naverCallBack")
	public String naverCallBack(Model model, @RequestParam("code") String code, @RequestParam("state") String state,
			HttpSession session)
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
			memVO.setProfileimg(response.getString("profile_image"));
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

	@RequestMapping("/check")
	public String memLogin(Members m, RedirectAttributes rttr, HttpSession session) {
		if (m.getMember_id() == null || m.getMember_id().isEmpty() || m.getPassword() == null
				|| m.getPassword().isEmpty()) {
			rttr.addFlashAttribute("msgType", "실패");
			rttr.addFlashAttribute("msg", "값을 모두 입력하세요");
			return "redirect:/account/signIn";
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
			return "redirect:/account/signIn";
		}
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

	@RequestMapping(value = "/newPwmail", method = RequestMethod.GET)
	@ResponseBody
	public String newPwmail(@RequestParam("email") String email) throws Exception {

		{
			int serti = (int) ((Math.random() * (99999 - 10000 + 1)) + 10000);

			String from = "buybuy@naver.com";// 보내는 이 메일주소
			String to = email;
			String title = "buybuy 비밀번호 재설정에 필요한 인증번호 입니다.";
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

	@GetMapping("/membermodify")
	public String membermodify(@RequestParam("member_id") String member_id, Model model) {
		Members mvo = memberMapper.registerCheck(member_id);
		model.addAttribute("mvo", mvo);

		String id = mvo.getMember_id();
		if (id.contains("_kakao") || id.contains("_google") || id.contains("_naver")) {
			model.addAttribute("isSocial", true);
		} else {
			model.addAttribute("isSocial", false);
		}

		return "account/membermodify";
	}

	@PostMapping("/passwordmodify")
	@ResponseBody
	public String memberPasswordModify(HttpServletRequest request, Members member) {
		try {
			memberMapper.membermodify(member);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return "success";
	}

	@PostMapping("/membermodify")
	public String membermodify(HttpServletRequest request, HttpSession session, RedirectAttributes rttr)
			throws IOException {
		MultipartRequest multi = null;
		int fileSize = 40 * 1024 * 1024; // 10MB
		@SuppressWarnings("deprecation")
		String sPath = request.getRealPath("resources/upload");
		multi = new MultipartRequest(request, sPath, fileSize, "UTF-8", new DefaultFileRenamePolicy());

		File imgFile = multi.getFile("profileimg");
		System.out.println(imgFile.toString());
		String newProThumbnail = "";
		MultipartFile thumbnailFile = new MockMultipartFile("img.png", new FileInputStream(imgFile));
		Members m = (Members) session.getAttribute("mvo");
		Members mvo = new Members();

		if (thumbnailFile.isEmpty()) {
			mvo.setProfileimg(m.getProfileimg());
		} else {
			System.out.println("업로드 전");
			newProThumbnail = imgurBO.requestUpload(thumbnailFile.getBytes());
			System.out.println("업로드 후 : " + newProThumbnail);
			mvo.setProfileimg(newProThumbnail);
			System.out.println("파일설정완료");
		}

		mvo.setMember_id(multi.getParameter("member_id"));
		mvo.setName(multi.getParameter("name"));
		mvo.setPassword(multi.getParameter("password"));
		mvo.setPhone(multi.getParameter("phone"));
		mvo.setEmail(multi.getParameter("email"));
		mvo.setZipcode(Integer.parseInt(multi.getParameter("zipcode")));
		mvo.setAddr(multi.getParameter("addr"));
		mvo.setDetailaddr(multi.getParameter("detailaddr"));

		memberMapper.membermodify(mvo);

		session.setAttribute("mvo", mvo);

		return "redirect:/";
	}

	@GetMapping("/findId")
	public String finId(HttpServletRequest request) {
		request.setAttribute("pageType", "findById");
		return "account/findId"; // 이름과 이메일로 아이디 찾기 페이지로 이동하는 뷰 매핑
	}

	@GetMapping("/findMemberId")
	@ResponseBody
	public String findMemberId(@RequestParam("email") String email, @RequestParam("name") String name) {
		// 이메일과 이름으로 아이디를 찾는 메서드 구현
		// 해당하는 아이디가 있을 경우, 그 값을 모델에 추가하고 결과를 보여주는 뷰로 이동
		// 없을 경우, 사용자에게 해당하는 메시지를 보여주는 뷰로 이동
		Members findId = memberMapper.findId(email, name); // 실제로 DB에서 이름과 이메일로 아이디를 찾는 메서드 호출

		if (findId != null) {
			return findId.getMember_id();
			// return "main"; // 아이디를 찾은 결과를 보여주는 뷰로 이동
		} else {
			return "error";
			// return "account/findId";
			// 아이디를 찾지 못했을 때의 메시지를 보여주는 뷰로 이동
		}
	}

	@GetMapping("/findPw")
	public String findpw(HttpServletRequest request) {
		request.setAttribute("pageType", "findByPw");
		return "account/findPw";
	}

	@GetMapping("/findMemberPw")
	@ResponseBody
	public String findMemberPw(@RequestParam("member_id") String member_id, @RequestParam("email") String email) {
		// 이메일과 이름으로 아이디를 찾는 메서드 구현
		// 해당하는 아이디가 있을 경우, 그 값을 모델에 추가하고 결과를 보여주는 뷰로 이동
		// 없을 경우, 사용자에게 해당하는 메시지를 보여주는 뷰로 이동
		Members findPw = memberMapper.findPw(member_id, email); // 실제로 DB에서 이름과 이메일로 아이디를 찾는 메서드 호출
		System.out.println(findPw);
		if (findPw != null) {
			return "success";
			// return findPw.getPassword(); // ajax에서 return이 success로 오는 경우에만 페이지를 비밀번호 새로
			// 설정하는 페이지로 이동
			// return "main"; // 아이디를 찾은 결과를 보여주는 뷰로 이동
		} else {
			return "error";
			// return "account/findId";
			// 아이디를 찾지 못했을 때의 메시지를 보여주는 뷰로 이동
		}
	}

	@GetMapping("/newpassword")
	public String newpassword(HttpServletRequest request, @RequestParam("member_id") String member_id) {
		request.setAttribute("member_id", member_id);
		return "account/newpassword";
	}

	@GetMapping("/memberdelete")
	public String deleteMember() {
		return "account/memberdelete";
	}

	@PostMapping("/memberdelete")
	public String memberdelete(@RequestParam("password") String password, HttpSession session,
			RedirectAttributes redirectAttributes) {
		Members mem = (Members) session.getAttribute("mvo");
		System.out.println(mem);
		// 회원의 정보를 DB에서 불러옵니다.
		Members storedMember = memberMapper.registerCheck(mem.getMember_id());

		// 입력된 비밀번호와 DB에 저장된 회원 정보의 비밀번호를 비교합니다.
		if (password.equals(storedMember.getPassword())) {
			// 비밀번호가 일치하면 회원을 삭제하고 세션을 무효화합니다.
			memberMapper.memberdelete(mem);
			session.invalidate();
			return "redirect:/"; // 메인 페이지 URL로 변경 필요
		} else {
			// 비밀번호가 일치하지 않을 경우에는 에러 메시지를 리다이렉트 파라미터로 전달하여 다시 회원 탈퇴 페이지로 이동합니다.
			redirectAttributes.addAttribute("error", "password");
			return "redirect:/account/memberdelete"; // 비밀번호가 일치하지 않을 때의 처리를 위한 페이지로 변경 필요
		}
	}

	@RequestMapping("/logout")
	public String memLogout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	@RequestMapping("/myPage")
	public String myPageMain(@RequestParam("member_id") String member_id, Model mo, Model mvo, Model moo, Members mem,
			MypageMain mpm, MyPageCNT cnt,
			HttpSession session, HttpServletRequest request) {

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
	public String myOrderList(String member_id) {
		return "account/myOrderList";
	}

	@RequestMapping(value = "/myOrderInfo", method = RequestMethod.GET)
	public String myOrderInfo(@RequestParam("order_num") int order_num, @RequestParam("member_id") String member_id,
			Model mo, OrderInfo oi, HttpSession session, HttpServletRequest request) {
		oi.setMember_id(member_id);
		oi.setOrder_num(order_num);
		oi = memberInfoMapper.mypageOrderInfo(order_num, member_id);
		session.setAttribute("mo", oi);
		return "account/myOrderInfo";
	}

	@RequestMapping("/myProducts")
	public String myProducts() {
		return "account/myProducts";
	}
}
