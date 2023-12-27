package com.ezen.buybuy.controller;

import java.io.File;
import java.io.IOException;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezen.buybuy.entity.Members;
import com.ezen.buybuy.mapper.MemberMapper;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@Controller
@RequestMapping("/account/*")
public class JoinController {

	@Autowired
	MemberMapper memberMapper;
	
	@RequestMapping("/main")
	public String main() {

		return "account/main";
	}
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
		Members membermodify = memberMapper.registerCheck(member_id);
		model.addAttribute("membermodify", membermodify);
		return "account/membermodify";
	}
	
	@PostMapping("/passwordmodify")
	@ResponseBody
	public String memberPasswordModify(HttpServletRequest request, Members member) {
		try {
			memberMapper.membermodify(member);
		}catch(Exception e) {
			e.printStackTrace();
			return "error";
		}
		return "success";
	}
	
	@PostMapping("/membermodify")
	public String membermodify( HttpServletRequest request, HttpSession session, RedirectAttributes rttr) throws IOException {
	    MultipartRequest multi = null;
	    int fileSize = 40 * 1024 * 1024;
	    String sPath = request.getRealPath("resources/upload");
	    multi = new MultipartRequest(request, sPath, fileSize, "UTF-8", new DefaultFileRenamePolicy());
	    String newProThumbnail = "";
	    
	    File thumbnailFile = multi.getFile("profileimg");
	    if (thumbnailFile != null) {
	        String ext = thumbnailFile.getName().substring(thumbnailFile.getName().lastIndexOf(".") + 1);
	        ext = ext.toUpperCase();
	        if (ext.equals("PNG") || ext.equals("GIF") || ext.equals("JPG")) {
	            String old = memberMapper.registerCheck(multi.getParameter("member_id")).getProfileimg();
	            File oldFile = new File(sPath + "/" + old);
	            
	            if (oldFile.exists()) {
	                oldFile.delete();
	            }
	            newProThumbnail = thumbnailFile.getName();
	        } else {
	            if (thumbnailFile.exists()) {
	                thumbnailFile.delete();
	            }
	            return "redirect:/";
	        }
	    }
	    
	    Members m=(Members) session.getAttribute("mvo"); 
	    m.setProfileimg(newProThumbnail);
	    session.setAttribute("m", m);
	    
	    m.setMember_id(multi.getParameter("member_id"));
	    m.setProfileimg(newProThumbnail);
	    m.setName(multi.getParameter("name"));
	    m.setPassword(multi.getParameter("password"));
	    m.setPhone(multi.getParameter("phone"));
	    m.setEmail(multi.getParameter("email"));
	    m.setZipcode(multi.getParameter("zipcode"));
	    m.setAddr(multi.getParameter("addr"));
	    m.setDetailaddr(multi.getParameter("detailaddr"));

	  
	    memberMapper.membermodify(m);	 
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
			 // return findPw.getPassword(); // ajax에서 return이 success로 오는 경우에만 페이지를 비밀번호 새로 설정하는 페이지로 이동
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
	public String memberdelete(@RequestParam("password") String password, HttpSession session, RedirectAttributes redirectAttributes) {
	    Members mem = (Members) session.getAttribute("mvo");

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
		return "main";
	}

	
	

	

}
