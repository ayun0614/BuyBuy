package com.ezen.buybuy.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezen.buybuy.mapper.ProductMapper;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


import com.ezen.buybuy.entity.Products;

import com.ezen.buybuy.entity.*;

@Controller
public class ProductController {

	@Autowired
	ProductMapper productMapper;

	@PostMapping("/ProductListInsert")
	public String ProductListInsert(HttpServletRequest request, HttpSession session,
			RedirectAttributes rttr) throws IOException {
		
		MultipartRequest multi = null;
		int fileSize = 40 * 1024 * 1024; // 10MB
		String sPath = request.getRealPath("resources/upload");
		
		multi = new MultipartRequest(request, sPath, fileSize, "UTF-8", new DefaultFileRenamePolicy());
		String newPro="";
		File file = multi.getFile("thumbnail_Img");
		if (file != null) {
			
			String ext = file.getName().substring(file.getName().lastIndexOf(".") + 1);
			ext = ext.toUpperCase();
			if (ext.equals("PNG") || ext.equals("GIF") || ext.equals("JPG")) {

				newPro = file.getName();
				
			}else {
				return "redirect:/ProductList";
			}
			}
		
		// 이미지를 db에 업데이트
		Products mvo = new Products();
		mvo.setThumbnail_Img(newPro);
		mvo.setProduct_Name(multi.getParameter("product_Name"));
		mvo.setEnd_Date(multi.getParameter("end_Date"));

		// Check if parameters are not null before parsing
		String originalPriceStr = multi.getParameter("original_Price");
		String discountPriceStr = multi.getParameter("discount_Price");

		if (originalPriceStr != null && discountPriceStr != null) {
		    try {
		        int originalPrice = Integer.parseInt(originalPriceStr);
		        int discountPrice = Integer.parseInt(discountPriceStr);

		        mvo.setOriginal_Price(originalPrice);
		        mvo.setDiscount_Price(discountPrice);
		    } catch (NumberFormatException e) {
		        // Handle the exception (e.g., log it or return an error response)
		        e.printStackTrace();
		    }
		}

		mvo.setDiscount_Rate(multi.getParameter("discount_Rate"));
		
		
		productMapper.ProductListInsert(mvo);

		rttr.addFlashAttribute("msgType", "성공");
		rttr.addFlashAttribute("msg", "사진이 등록되었습니다.");


	return"redirect:/ProductList";
	 	
	}
	
	
	@GetMapping("/ProductList")
	public String ProductList ( Model m ) {
		List<Products> ProductList = productMapper.ProductList();
		m.addAttribute("ProductList",ProductList);
		return "product/ProductList";
	}



	@GetMapping("/ProductDetail")
	public String read(@RequestParam("product_IDX") int product_IDX, Model model) {
		Products productDetail = productMapper.read(product_IDX);
		model.addAttribute("productDetail", productDetail);
		return "product/ProductDetail";
	}

	@GetMapping("/OrderPage")
	public String Order(@RequestParam("product_IDX") int product_IDX, Model model) {
		Products ProductOrder = productMapper.read(product_IDX);
		model.addAttribute("ProductOrder", ProductOrder);
		return "product/OrderPage";
	}

}
