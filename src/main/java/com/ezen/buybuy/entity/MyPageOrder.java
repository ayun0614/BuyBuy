package com.ezen.buybuy.entity;

import java.sql.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

@Data
public class MyPageOrder {
	private int order_num;
	private String member_id;
	private int product_idx;
	private String status;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	private Date order_date;
	private String product_name;
	private String thumbnail_img;
	private int order_pcs;
	private String discount_price;
}