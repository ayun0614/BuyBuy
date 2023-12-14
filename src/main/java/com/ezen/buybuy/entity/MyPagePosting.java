package com.ezen.buybuy.entity;


import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class MyPagePosting {
	
	private String member_id;
	private int product_idx;
	
	private String thumbnail_img;
	private String product_name;
	
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date end_date;
	
	private String original_price;
	private String discount_price;
	
	private int view_count;
	
	
	
}
