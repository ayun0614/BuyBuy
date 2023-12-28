package com.ezen.buybuy.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezen.buybuy.api.GoogleLoginBO;
import com.ezen.buybuy.api.ImgurBO;
import com.ezen.buybuy.entity.Alert;
import com.ezen.buybuy.entity.Members;
import com.ezen.buybuy.entity.Products;
import com.ezen.buybuy.entity.Reply;
import com.ezen.buybuy.entity.Reply2;
import com.ezen.buybuy.entity.Reply3;
import com.ezen.buybuy.mapper.AlertMapper;
import com.ezen.buybuy.mapper.MemberInfoMapper;
import com.ezen.buybuy.mapper.ProductMapper;
import com.ezen.buybuy.mapper.ReplyMapper;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@Controller
@RequestMapping("/product/*")
public class ProductController {

	ImgurBO imgurBO;
	
	@Autowired
	ProductMapper productMapper;

	@Autowired
	ReplyMapper replyMapper;

	@Autowired
	MemberInfoMapper memberInfoMapper;
	
	@Autowired
	AlertMapper alertMapper;
	
	@Autowired
	private void setImgurBO(ImgurBO imgurBO) {
		this.imgurBO = imgurBO;
	}

	@RequestMapping("/productBuy")
	public String productBuy(@RequestParam("product_idx") int product_idx, @RequestParam("order_pcs") int order_pcs, String member_id, Model mo, Members m, Model moo, Products p, HttpSession session) {
		m = memberInfoMapper.mypageInfo(member_id);
		p = memberInfoMapper.productInfo(product_idx);
		session.setAttribute("mo", m);
		session.setAttribute("moo", p);
		session.setAttribute("order_pcs", order_pcs);
		return "product/productBuy";
	}

	@GetMapping("/ProductListInsert")
	public String ProductListInsert() {
		return "product/ProductInsert";

	}

	@PostMapping("/ProductListInsert")
	public String ProductListInsert(HttpServletRequest request, HttpSession session, RedirectAttributes rttr) throws IOException {

		MultipartRequest multi = null;
		int fileSize = 40 * 1024 * 1024; // 10MB
		@SuppressWarnings("deprecation")
		String sPath = request.getRealPath("resources/upload");

		multi = new MultipartRequest(request, sPath, fileSize, "UTF-8", new DefaultFileRenamePolicy());
		String newProThumbnail = "";
		String newProDetail = "";

		MultipartFile thumbnailFile = new MockMultipartFile("img.png", new FileInputStream(multi.getFile("thumbnail_img")));
		newProThumbnail = imgurBO.requestUpload(thumbnailFile.getBytes());
		
		MultipartFile detailFile = new MockMultipartFile("img.png", new FileInputStream(multi.getFile("detail_img")));
		newProDetail = imgurBO.requestUpload(detailFile.getBytes());

		// 이미지를 db에 업데이트
		Products mvo = new Products();
		mvo.setThumbnail_img(newProThumbnail);
		mvo.setDetail_img(newProDetail);
		mvo.setProduct_name(multi.getParameter("product_name"));
		mvo.setEnd_date(multi.getParameter("end_date"));
		mvo.setContent_state("판매중");
		mvo.setMember_id(multi.getParameter("member_id"));

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

		return "redirect:/product/ProductList";
	}

	@GetMapping("/ProductList")
	public String ProductList(Model m, @RequestParam(value = "ctgr_idx", defaultValue = "0") int ctgr_idx) {
		List<Products> productList;

		if (ctgr_idx != 0) {
			productList = productMapper.ProductListCtgr(ctgr_idx);
		} else {
			productList = productMapper.ProductList();
		}
		m.addAttribute("ProductList", productList);
		return "product/ProductList";
	}

	@GetMapping("/ProductDetail")
	public String read(@RequestParam("product_idx") int product_idx, Model model, Reply r, Reply2 r2, Reply3 r3, HttpSession session) {
		Products productDetail = productMapper.read(product_idx);
		model.addAttribute("productDetail", productDetail);
		List<Reply> ro = replyMapper.replyselet(r);
		List<Reply2> ro2 = replyMapper.replyselet2(r2);
		List<Reply3> ro3 = replyMapper.replytotal(r3);
		List<Reply3> ro4 = replyMapper.replytotal2(r3);

		session.setAttribute("ro", ro);
		session.setAttribute("ro2", ro2);
		session.setAttribute("ro3", ro3);
		session.setAttribute("ro4", ro4);
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
	public String ProductModify(@RequestParam("product_idx") int product_idx, HttpServletRequest request, HttpSession session,
			RedirectAttributes rttr) throws IOException {

		MultipartRequest multi = null;
		int fileSize = 40 * 1024 * 1024;
		@SuppressWarnings("deprecation")
		String sPath = request.getRealPath("resources/upload");
		multi = new MultipartRequest(request, sPath, fileSize, "UTF-8", new DefaultFileRenamePolicy());
		String newProThumbnail = "";
		String newProDetail = "";

		MultipartFile thumbnailFile = new MockMultipartFile("img.png", new FileInputStream(multi.getFile("thumbnail_img")));
		newProThumbnail = imgurBO.requestUpload(thumbnailFile.getBytes());
		
		MultipartFile detailFile = new MockMultipartFile("img.png", new FileInputStream(multi.getFile("detail_img")));
		newProDetail = imgurBO.requestUpload(detailFile.getBytes());

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
		mvo.setContent_state(multi.getParameter("content_state"));
		mvo.setMember_id(multi.getParameter("member_id"));

		productMapper.ProductModify(mvo);
		return "redirect:/product/ProductList";
	}

	@GetMapping("/ProductDelete")
	public String productDelete(@RequestParam("product_idx") int product_idx) {
		productMapper.ProductDelete(product_idx);

		return "redirect:/product/ProductList";
	}

	@RequestMapping("/ProductTimeout")
	public String ProductTimeout(@RequestParam("product_idx") int product_idx) {
		productMapper.ProductTimeout(product_idx);
		List<String>orderList =  alertMapper.orderList(product_idx);
		for(String member_id:orderList) {
			alertMapper.orderAlert(member_id, product_idx);
		}
		return "redirect:/product/ProductDetail?product_idx=" + product_idx;
	}

	@GetMapping("/search")
	public String ProductSearch(Model m, @RequestParam("word") String word) {
		List<Products> productList;
		productList = productMapper.ProductSearch('%' + word + '%');
		m.addAttribute("ProductList", productList);
		return "product/ProductList";
	}

	@GetMapping("/pop")
	public String ProductPop(Model m) {
		List<Products> productList;
		productList = productMapper.PopMain(9999);
		m.addAttribute("ProductList", productList);
		return "product/ProductList";
	}

	@GetMapping("/new")
	public String ProductNew(Model m) {
		List<Products> productList;
		productList = productMapper.NewMain(9999);
		m.addAttribute("ProductList", productList);
		return "product/ProductList";
	}

	@GetMapping("/soon")
	public String ProductSoon(Model m) {
		List<Products> productList;
		productList = productMapper.SoonMain();
		m.addAttribute("ProductList", productList);
		return "product/ProductList";
	}
}
