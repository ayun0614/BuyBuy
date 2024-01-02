package com.ezen.buybuy.controller;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezen.buybuy.entity.AdminChart;
import com.ezen.buybuy.entity.AdminDonut;
import com.ezen.buybuy.entity.AdminPo;
import com.ezen.buybuy.entity.AdminPost;
import com.ezen.buybuy.entity.AdminReq;
import com.ezen.buybuy.entity.AdminUser;
import com.ezen.buybuy.entity.Banner;
import com.ezen.buybuy.entity.Members;
import com.ezen.buybuy.entity.MembersRq;
import com.ezen.buybuy.entity.Product;
import com.ezen.buybuy.mapper.AdminMapper;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;



@RequestMapping("/admin")
@RestController
public class RestAdminController {

	@Autowired
	AdminMapper AdminMapper;
	
	@GetMapping("/adminchart")
	    public List<AdminChart> getHourlyTotal(@RequestParam(name = "date") String date) {
	       	System.out.println(date);
	        List<AdminChart> li = AdminMapper.getHourlyTotal(date);
	        for (AdminChart post : li) {
	        	System.out.println(li);
		    }
	        return li;
	    }
	@PostMapping("/updateStatus")
	@ResponseBody
	public String updateStatus(@RequestParam("member_id") String memberId,
	                           @RequestParam("account_status") String newStatus) {
	   
	    Members member = new Members();
	    member.setMember_id(memberId);
	    member.setAccount_status(newStatus);
	    AdminMapper.updateStatus(member);
	    return "success";
	 }
	 @PostMapping("/updateMember")
	 @ResponseBody
	 public String updateMember(@RequestParam("member_id") String memberId) {
	    AdminMapper.updateMember(memberId);
	    return "Success";
	 }
	 @GetMapping("/admindonut")
	 public List<AdminDonut> donutList() {
		List<AdminDonut> li=AdminMapper.donutList();
		for (AdminDonut post : li) {
			System.out.println(li);
	 }
		return li;
	 }
	 @GetMapping("/post")
	 public List<AdminPost> boardList() {
		List<AdminPost> li=AdminMapper.getList();
		for (AdminPost post : li) {
	        System.out.println(post);
	 }
		return li;
	 }
	@GetMapping("/search")
	public List<AdminReq> searchList(@RequestParam("name") String name) {
		List<AdminReq> li=AdminMapper.searchInfo(name);
		System.out.println(li);
		for (AdminReq post : li) {
	    }
		return li;
	}
	
	@GetMapping("/searchpost")
	public List<AdminPo> searchPost(@RequestParam("category") String category,
							@RequestParam("searchTerm") String searchTerm) {
		System.out.println(category);
		System.out.println(searchTerm);
		List<AdminPo> li=AdminMapper.searchpost(category,searchTerm);
		System.out.println(li);
		return li;
	}
	
	@GetMapping("/user")
	@ResponseBody
	public List<AdminUser> userList() {
		List<AdminUser> li=AdminMapper.getuserInfo();
		System.out.println(li);
		for (AdminUser post : li) {
	    }

		return li;
	}
	@GetMapping("/approve")
	public List<AdminReq> reqList() {
		List<AdminReq> li=AdminMapper.getuserReq();
		System.out.println(li);
		for (AdminReq post : li) {
	    }

		return li;
	}
	
	@DeleteMapping("/deleteBanner")
    public void bannerDelete(@RequestParam("image_url") String image_url) {
		System.out.println(image_url);
        try {
            AdminMapper.deleteBanner(image_url);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	
	

	
	@Transactional
    @DeleteMapping("/{product_idx}")
    public ResponseEntity<String> postDelete(@PathVariable("product_idx") int product_idx) {
        try {
            AdminMapper.disableForeignKeyChecks();
            AdminMapper.postDelete(product_idx);
            AdminMapper.disableForeignKeyChecks();

            return ResponseEntity.ok("삭제 성공");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("삭제 실패");
        }
    }
	
}

