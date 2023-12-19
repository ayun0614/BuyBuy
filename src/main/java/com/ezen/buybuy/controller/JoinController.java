package com.ezen.buybuy.controller;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezen.buybuy.entity.Members;
import com.ezen.buybuy.mapper.MemberMapper;

@Controller
@RequestMapping("/account/*")
public class JoinController {

	@Autowired
	MemberMapper memberMapper;

	@RequestMapping("/signUp")
	public String signUp() {
		return "account/signUp";
	}

	@RequestMapping("/insert")
	public String insert(Members mem) {
		memberMapper.insert(mem);
		return "account/login";
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

	@Autowired
	private JavaMailSenderImpl mailSender;

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
		return "main";
	}
}
