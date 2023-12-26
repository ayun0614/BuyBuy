package com.ezen.buybuy.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ezen.buybuy.entity.ApplyDealerACT;
import com.ezen.buybuy.entity.Members;
import com.ezen.buybuy.entity.MyPagePosting;
import com.ezen.buybuy.entity.Orders;
import com.ezen.buybuy.mapper.MemberInfoMapper;

@RequestMapping("/mypage")
@RestController
public class RestAccountController {

	@Autowired
	MemberInfoMapper memberInfoMapper;
	
	@GetMapping("/all")
	public List<Orders> boardList(@RequestParam("member_id") String member_id, Members m, Orders o, HttpServletRequest request) {
		m.setMember_id(member_id);
		List<Orders> li = memberInfoMapper.mypageOrderList(member_id);
		return li; 
	}
	
	@PutMapping("/statusUpdate") 
	public void deliStatusUpdate(@RequestParam("order_num") int order_num) {
		memberInfoMapper.deliStatusUpdate(order_num);
	}
	
	@GetMapping("/postingAll")
	public List<MyPagePosting> mypagePostingList(@RequestParam("member_id") String member_id, Members m) {
		m.setMember_id(member_id);
		List<MyPagePosting> li = memberInfoMapper.mypagePostingList(member_id);
		return li; 
	}
	
	@PutMapping("/dealerRequest")
	public @ResponseBody void dealerRequest(@RequestBody ApplyDealerACT act) {
		memberInfoMapper.dealerRequest(act);  
	}
	
	@PutMapping("/deliUpdate")
	public Orders deliUpdate(@RequestBody Orders ord) {
		memberInfoMapper.deliUpdate(ord);
		return ord;
	}	
	
	@PutMapping("/productBuy")
	public void productBuy(@RequestBody Orders ord) {
		memberInfoMapper.productBuy(ord);
	}
	
	
	
	
	
	@GetMapping("/excel/download") 
    public void excelDownload(HttpServletResponse response, @RequestParam("product_idx") int product_idx) throws IOException {
      Workbook wb = new XSSFWorkbook();
      Sheet sheet = wb.createSheet("상품 구매자 리스트");
      sheet.setColumnWidth(4, 4000);
      sheet.setColumnWidth(5, 5000);
      sheet.setColumnWidth(6, 17000);
      sheet.setColumnWidth(7, 7000);
      
      Row row = null;
      Cell cell = null;
      int rowNum = 0;

      // Header
      row = sheet.createRow(rowNum++);
      cell = row.createCell(0);
      cell.setCellValue("주문 번호");
      cell = row.createCell(1);
      cell.setCellValue("회원 ID");
      cell = row.createCell(2);
      cell.setCellValue("수량");
      cell = row.createCell(3);
      cell.setCellValue("총금액");
      cell = row.createCell(4);
      cell.setCellValue("받는 사람");
      cell = row.createCell(5);
      cell.setCellValue("전화 번호");
      cell = row.createCell(6);
      cell.setCellValue("주소");
      cell = row.createCell(7);
      cell.setCellValue("배송 메모");

      
      List<Orders> orderList = memberInfoMapper.productBuyerList(product_idx);

   // Body
   for (int i = 0; i < orderList.size(); i++) {
       Orders order = orderList.get(i);
       row = sheet.createRow(rowNum++);
       
       cell = row.createCell(0);
       cell.setCellValue(order.getOrder_num()); 

       cell = row.createCell(1);
       cell.setCellValue(order.getMember_id()); 

       cell = row.createCell(2);
       cell.setCellValue(order.getOrder_pcs()); 
       
       cell = row.createCell(3);
       cell.setCellValue(order.getTotal_price()); 
       
       cell = row.createCell(4);
       cell.setCellValue(order.getDeli_name()); 
       
       cell = row.createCell(5);
       cell.setCellValue(order.getDeli_phone()); 
       
       cell = row.createCell(6);
       cell.setCellValue(order.getDeli_zipcode() + " " + order.getDeli_addr() + " " + order.getDeli_detailaddr()); 
       
       cell = row.createCell(7);
       cell.setCellValue(order.getDeli_memo()); 
       
   }
   
      // 컨텐츠 타입과 파일명 지정
      response.setContentType("ms-vnd/excel");
      // response.setHeader("Content-Disposition", "attachment;filename=example.xls");
      response.setHeader("Content-Disposition", "attachment;filename=example.xlsx");

      // Excel File Output
      wb.write(response.getOutputStream());
      wb.close();
      
  }

	
	
	
	
	
	
}
