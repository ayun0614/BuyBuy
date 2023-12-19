package com.ezen.buybuy.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ezen.buybuy.mapper.MemberMapper;
import com.ezen.buybuy.mapper.ProductMapper;
import com.ezen.buybuy.mapper.ReplyMapper;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;



import com.ezen.buybuy.entity.*;

@Controller
public class ProductController {

	@Autowired
	ProductMapper productMapper;
	
	@Autowired
	ReplyMapper replyMapper;

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
	public String read(@RequestParam("product_idx") int product_idx, Model model,Reply r,Reply2 r2,Reply3 r3, HttpSession session) {
		Products productDetail = productMapper.read(product_idx);
		model.addAttribute("productDetail", productDetail);
		
		List<Reply> ro=replyMapper.replyselet(r);
		List<Reply2> ro2=replyMapper.replyselet2(r2);
		List<Reply3> ro3=replyMapper.replytotal(r3);
		List<Reply3> ro4=replyMapper.replytotal2(r3);

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
	
	@GetMapping("/ProductDelete")
	public String productDelete(@RequestParam("product_idx") int product_idx, RedirectAttributes rttr) {
		productMapper.ProductDelete(product_idx);
		
		return "redirect:/ProductList";
	}
	
	@RequestMapping("/uploadImage")
	public class ImageUploadController {

	    @PostMapping
	    public ResponseEntity<Object> handleImageUpload(MultipartFile upload) {
	        try {
	            if (!upload.isEmpty()) {
	                // 디렉토리가 없다면 생성
	                Path uploadDir = Paths.get("uploads");
	                if (!Files.exists(uploadDir)) {
	                    Files.createDirectories(uploadDir);
	                }

	                // 파일 이름을 고유하게 만들기
	                String originalFileName = upload.getOriginalFilename();
	                String uniqueFileName = UUID.randomUUID().toString() + "_" + originalFileName;

	                // 파일 저장 경로
	                Path filePath = uploadDir.resolve(uniqueFileName);

	                // 파일 저장
	                Files.copy(upload.getInputStream(), filePath);

	                // ResponseEntity로 JSON 응답 반환
	                return ResponseEntity.ok()
	                        .body("{\"uploaded\": 1, \"fileName\": \"" + uniqueFileName + "\", \"url\": \"/uploads/" + uniqueFileName + "\"}");
	            } else {
	                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
	                        .body("{\"uploaded\": 0, \"error\": \"File is empty\"}");
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                    .body("{\"uploaded\": 0, \"error\": \"" + e.getMessage() + "\"}");
	        }
	    }
	}
	
	

}
	
	/*@PostMapping("/uploadImage")
    public ModelAndView handleFileUpload(@RequestParam("file") MultipartFile file) {
        ModelAndView modelAndView = new ModelAndView();

        // 이미지를 저장할 디렉토리 경로
        String uploadDir = "C:/upload/ckupload";  // 예: "C:/uploads/"

        try {
            // 업로드 디렉토리가 없으면 생성
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            // 파일 저장
            String fileName = file.getOriginalFilename();
            String filePath = uploadDir + fileName;
            File dest = new File(filePath);
            file.transferTo(dest);
            
            

            // CKEditor에서 요구하는 형식으로 응답
            modelAndView.addObject("uploaded", 1);
            modelAndView.addObject("fileName", fileName);
            modelAndView.addObject("url", "/resources/upload/" + fileName);
        } catch (IOException e) {
            modelAndView.addObject("uploaded", 0);
            modelAndView.addObject("error", e.getMessage());
        }

        modelAndView.setViewName("jsonView");  // ViewResolver에 의해 JSON 응답으로 변환

        return modelAndView;
    }*/
	




