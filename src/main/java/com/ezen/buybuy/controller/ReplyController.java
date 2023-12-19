package com.ezen.buybuy.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezen.buybuy.entity.Reply;
import com.ezen.buybuy.entity.Reply2;
import com.ezen.buybuy.entity.Reply3;
import com.ezen.buybuy.mapper.ReplyMapper;

@Controller
public class ReplyController {
	@Autowired
	ReplyMapper replyMapper;

	@RequestMapping("/reply")
	public String reply(Reply r,RedirectAttributes rttr,Reply3 r3) {
		replyMapper.replyinsert(r);
		rttr.addAttribute("product_idx", r3.getProduct_idx());
		return "redirect:/product/ProductDetail";
	}
	@RequestMapping("/reply2")
	public String reply2(Reply2 r,RedirectAttributes rttr,Reply3 r3) {
		replyMapper.replyinsert2(r);
		rttr.addAttribute("product_idx", r3.getProduct_idx());
		return "redirect:/product/ProductDetail";
	}
	
	@RequestMapping("/replydelete")
	public String replydelete(Reply r,@RequestParam("reply_idx")int reply_idx, RedirectAttributes rttr,Reply3 r3) {
		replyMapper.replydelete(reply_idx);
		rttr.addAttribute("product_idx", r.getProduct_idx());
		return "redirect:/product/ProductDetail";
	}
	
	@RequestMapping("/replydelete2")
	public String replydelete2(Reply2 r2,@RequestParam("reply2_idx")int reply2_idx, RedirectAttributes rttr,Reply3 r3) {
		replyMapper.replydelete2(reply2_idx);
		rttr.addAttribute("product_idx", r2.getProduct_idx());
		return "redirect:/product/ProductDetail";
	}
}
