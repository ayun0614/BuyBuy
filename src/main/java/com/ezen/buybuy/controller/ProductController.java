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
import org.springframework.web.bind.annotation.ModelAttribute;
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
	public String ProductListInsert(HttpServletRequest request, HttpSession session, RedirectAttributes rttr)
			throws IOException {

		MultipartRequest multi = null;
		int fileSize = 40 * 1024 * 1024; // 10MB
		String sPath = request.getRealPath("resources/upload");

		multi = new MultipartRequest(request, sPath, fileSize, "UTF-8", new DefaultFileRenamePolicy());
		String newProThumbnail = "";
		String newProDetail = "";

		File thumbnailFile = multi.getFile("thumbnail_img");
		if (thumbnailFile != null) {
			String ext = thumbnailFile.getName().substring(thumbnailFile.getName().lastIndexOf(".") + 1);
			ext = ext.toUpperCase();
			if (ext.equals("PNG") || ext.equals("GIF") || ext.equals("JPG")) {
				newProThumbnail = thumbnailFile.getName();
			} else {
				return "redirect:/ProductList";
			}
		}

		File detailFile = multi.getFile("detail_img");
		if (detailFile != null) {
			String ext = detailFile.getName().substring(detailFile.getName().lastIndexOf(".") + 1);
			ext = ext.toUpperCase();
			if (ext.equals("PNG") || ext.equals("GIF") || ext.equals("JPG")) {
				newProDetail = detailFile.getName();
			} else {
				return "redirect:/ProductList";
			}
		}
 
		// 이미지를 db에 업데이트
		Products mvo = new Products();
		mvo.setThumbnail_img(newProThumbnail);
		mvo.setDetail_img(newProDetail);
		mvo.setProduct_name(multi.getParameter("product_name"));
		mvo.setEnd_date(multi.getParameter("end_date"));

		// Check if parameters are not null before parsing
		String originalPriceStr = multi.getParameter("original_price");
		String discountPriceStr = multi.getParameter("discount_price");
		String ctgrIdxStr = multi.getParameter("ctgr_idx");

		if (originalPriceStr != null && discountPriceStr != null && ctgrIdxStr != null) {
			try {
				int originalPrice = Integer.parseInt(originalPriceStr);
				int discountPrice = Integer.parseInt(discountPriceStr);
				int ctgrIdx = Integer.parseInt(ctgrIdxStr);

				mvo.setOriginal_price(originalPrice);
				mvo.setDiscount_price(discountPrice);
				mvo.setCtgr_idx(ctgrIdx);
			} catch (NumberFormatException e) {
				// Handle the exception (e.g., log it or return an error response)
				e.printStackTrace();
			}
		}

		mvo.setDiscount_rate(multi.getParameter("discount_rate"));

		productMapper.ProductListInsert(mvo);

		rttr.addFlashAttribute("msgType", "성공");
		rttr.addFlashAttribute("msg", "사진이 등록되었습니다.");

		return "redirect:/ProductList";

	}

	@GetMapping("/ProductList")
	public String ProductList(Model m) {
		List<Products> ProductList = productMapper.ProductList();
		m.addAttribute("ProductList", ProductList);
		return "product/ProductList";
	}

	@GetMapping("/ProductDetail")
	public String read(@RequestParam("product_idx") int product_idx, Model model) {
		Products productDetail = productMapper.read(product_idx);
		model.addAttribute("productDetail", productDetail);
		return "product/ProductDetail";
	}

	@GetMapping("/OrderPage")
	public String Order(@RequestParam("product_idx") int product_idx, Model model) {
		Products ProductOrder = productMapper.read(product_idx);
		model.addAttribute("ProductOrder", ProductOrder);
		return "product/OrderPage";
	}
	
	@GetMapping("/ProductModify")
	public String Modify(@RequestParam("product_idx") int product_idx, Model model) {
		Products productModify = productMapper.read(product_idx);
		model.addAttribute("ProductModify", productModify);
		return "product/ProductModify";
	}

	@PostMapping("/ProductModify")
	public String ProductModify(@RequestParam("product_idx") int product_idx,HttpServletRequest request, HttpSession session, RedirectAttributes rttr) throws IOException {
		 
		MultipartRequest multi = null;
		    int fileSize = 40 * 1024 * 1024;
		    String sPath = request.getRealPath("resources/upload");
		    multi = new MultipartRequest(request, sPath, fileSize, "UTF-8", new DefaultFileRenamePolicy());
		    String newProThumbnail = "";
		    String newProDetail = "";
		    
		    File thumbnailFile = multi.getFile("thumbnail_img");
		    if (thumbnailFile != null) {
		        String ext = thumbnailFile.getName().substring(thumbnailFile.getName().lastIndexOf(".") + 1);
		        ext = ext.toUpperCase();
		        if (ext.equals("PNG") || ext.equals("GIF") || ext.equals("JPG")) {
		            String old = productMapper.read(Integer.parseInt(multi.getParameter("product_idx"))).getThumbnail_img(); 
		            File oldFile = new File(sPath + "/" + old);
		            
		            if (oldFile.exists()) {
		                oldFile.delete();
		            }
		            newProThumbnail = thumbnailFile.getName();
		        } else {
		            if (thumbnailFile.exists()) {
		                thumbnailFile.delete();
		            }
		            return "redirect:/ProductModify";
		        }
		    }

		    File detailFile = multi.getFile("detail_img");
		    if (detailFile != null) {
		        String ext = detailFile.getName().substring(detailFile.getName().lastIndexOf(".") + 1);
		        ext = ext.toUpperCase();
		        if (ext.equals("PNG") || ext.equals("GIF") || ext.equals("JPG")) {
		            String old = productMapper.read(Integer.parseInt(multi.getParameter("product_idx"))).getDetail_img(); 
		            File oldFile = new File(sPath + "/" + old);
		            if (oldFile.exists()) {
		                oldFile.delete();
		            }
		            newProDetail = detailFile.getName();
		        } else {
		            if (detailFile.exists()) {
		                detailFile.delete();
		            }
		            return "redirect:/ProductModify";
		        }
		    }

		    Products mvo = new Products();
		    mvo.setThumbnail_img(newProThumbnail);
		    mvo.setDetail_img(newProDetail);
		    mvo.setProduct_idx(Integer.parseInt(multi.getParameter("product_idx")));
		    mvo.setProduct_name(multi.getParameter("product_name"));
		    mvo.setEnd_date(multi.getParameter("end_date"));
		    mvo.setDiscount_rate(multi.getParameter("discount_rate"));
		    mvo.setOriginal_price(Integer.parseInt(multi.getParameter("original_price")));
			mvo.setDiscount_price(Integer.parseInt(multi.getParameter("discount_price")));
			mvo.setCtgr_idx(Integer.parseInt(multi.getParameter("ctgr_idx")));
			
	
			productMapper.ProductModify(mvo);
			return "redirect:/ProductList";
	}
	

	/*@PostMapping("/ProductModify")
	public String ProductModify(@ModelAttribute Products products) {
		System.out.println(products);
	
		 
		productMapper.ProductModify(products);
	

		return "redirect:/ProductList";

	}*/
	




}
