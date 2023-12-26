package com.ezen.buybuy.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import lombok.Data;

@Data
public class Products {
	private int product_idx;
	private String product_name;
	private String start_date;
	private String end_date;
	private String thumbnail_img;
	private int original_price;
	private int discount_price;
	private String discount_rate;
	private String detail_img;
	private String content_state;
	private int ctgr_idx;
	private int reg_id;
	private String ctgr_name;
	private String member_id;
	
	
	private String name;
	private String addr;
	private String detailaddr;
	private String phone;
	private String email;
}
