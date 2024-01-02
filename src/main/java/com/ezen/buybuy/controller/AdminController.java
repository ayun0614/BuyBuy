package com.ezen.buybuy.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.ezen.buybuy.api.ImgurBO;
import com.ezen.buybuy.entity.Banner;
import com.ezen.buybuy.entity.Products;
import com.ezen.buybuy.entity.Reply;
import com.ezen.buybuy.entity.Reply2;
import com.ezen.buybuy.entity.Reply3;
import com.ezen.buybuy.mapper.AdminMapper;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
@RequestMapping("/admin/*")
@Controller
public class AdminController {
	
	ImgurBO imgurBO;
	
	@Autowired
	private void setImgurBO(ImgurBO imgurBO) {
		this.imgurBO = imgurBO;
	}
	
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
    public String bannercontrol(HttpSession session) {
		List<Banner> bo = AdminMapper.getbanner();
		session.setAttribute("bo", bo);
		
    	return "admin/bannercontrol";
    }
	
	@Autowired
	AdminMapper AdminMapper;
	
	@PostMapping("/insertBannerImg")
	public String ProductListInsert(HttpServletRequest request, HttpSession session, RedirectAttributes rttr) throws IOException {

		MultipartRequest multi = null;
		int fileSize = 40 * 1024 * 1024; // 10MB
		@SuppressWarnings("deprecation")
		String sPath = request.getRealPath("resources");

		multi = new MultipartRequest(request, sPath, fileSize, "UTF-8", new DefaultFileRenamePolicy());
		String newProThumbnail = "";

		MultipartFile thumbnailFile = new MockMultipartFile("img.png", new FileInputStream(multi.getFile("image_url")));
		newProThumbnail = imgurBO.requestUpload(thumbnailFile.getBytes());
		
		// 이미지를 db에 업데이트
		   Banner mvo = new Banner();
	       mvo.setImage_url(newProThumbnail);
	       mvo.setBanner_text(multi.getParameter("banner_text"));
	       mvo.setBanner_name(multi.getParameter("banner_name"));
	       mvo.setBanner_url(multi.getParameter("banner_url"));

	       AdminMapper.insertBannerImg(mvo);

	       // 리다이렉션을 위해 "redirect:" 접두사 사용
	       return "redirect:/admin/bannercontrol";
	}
	
	/*@PostMapping("/insertBannerImg")
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
	       return "redirect:/admin/bannercontrol";
	   }*/
	   
	
	
}
