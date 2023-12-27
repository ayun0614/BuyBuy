package com.ezen.buybuy.entity;

import java.sql.Date;

import lombok.Data;

@Data
public class Product {
	private String product_name;
	private Date start_date;
	private Date end_date;
	private String thumbnail_img;
	private String original_price;
	private String discount_price;
	private String discount_rate;
	private String detail_img;
	private String content_state;
	private String ctgr_idx;
	private String member_id; 
}