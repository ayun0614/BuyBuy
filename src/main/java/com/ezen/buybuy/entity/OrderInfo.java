package com.ezen.buybuy.entity;


import lombok.Data;

@Data
public class OrderInfo {
	private int order_num;
	private String thumbnail_img;// 상품
	private String product_name; // 상품
	
	private int order_pcs; // 주문
	
	private String discount_price; // 상품
	
	private String name; // 회원
	private String phone; // 회원
	
	private String deli_name; // 주문
	private String deli_phone; // 주문
	private int deli_zipcode; // 주문
	private String deli_addr; // 주문
	private String deli_detailaddr; // 주문
	private String deli_memo; // 주문
	
	private String original_price; // 상품
	private String discount_rate; // 상품
	private String total_price; // 주문
	
	private String pay_type; // 주문
	

}
