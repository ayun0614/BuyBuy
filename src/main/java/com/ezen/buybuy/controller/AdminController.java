package com.ezen.buybuy.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezen.buybuy.entity.Banner;
import com.ezen.buybuy.mapper.AdminMapper;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@Controller
public class AdminController {
	@RequestMapping("/admin")
    public String admin() {
    	return "admin/admin";
    }
	@RequestMapping("/postmanagement")
    public String postmanagement() {
    	return "admin/postmanagement";
    }
	@RequestMapping("/usermanagement")
    public String usermanagement() {
    	return "admin/usermanagement";
    }
	@RequestMapping("/bannercontrol")
    public String bannercontrol() {
    	return "admin/bannercontrol";
    }
	
	@Autowired
	AdminMapper AdminMapper;
	
	
	@PostMapping("/insertBannerImg")
	public String ProductListInsert(
	        HttpServletRequest request,
	        HttpSession session,
	        RedirectAttributes rttr
	) throws IOException {
	    MultipartRequest multi = null;
	    int fileSize = 40 * 1024 * 1024; // 10MB
	    @SuppressWarnings("deprecation")
	    String sPath = request.getRealPath("resources/upload");

	    multi = new MultipartRequest(request, sPath, fileSize, "UTF-8", new DefaultFileRenamePolicy());
	    String newProThumbnail = "";

	    File thumbnailFile = multi.getFile("image_url");

	    if (thumbnailFile != null) {
	        String ext = thumbnailFile.getName().substring(thumbnailFile.getName().lastIndexOf(".") + 1);
	        ext = ext.toUpperCase();
	        if (ext.equals("PNG") || ext.equals("GIF") || ext.equals("JPG")) {
	            newProThumbnail = thumbnailFile.getName();
	        }
	    }

	    // 이미지를 db에 업데이트
	    Banner mvo = new Banner();
	    mvo.setImage_url(newProThumbnail);
	    mvo.setBanner_text(multi.getParameter("banner_text"));
	    mvo.setBanner_name(multi.getParameter("banner_name"));
	    mvo.setBanner_url(multi.getParameter("banner_url"));

	    AdminMapper.insertBannerImg(mvo);

	    // 리다이렉션을 위해 "redirect:" 접두사 사용
	    return "redirect:/bannercontrol";
	}
	
	
	
}
