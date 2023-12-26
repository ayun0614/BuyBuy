package com.ezen.buybuy.entity;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class Orders {
	private int product_idx;
	private String member_id;
	private int order_num;
	private int order_pcs;
	private String total_price;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	private Date order_date;
	private String deli_name;
	private String deli_phone;
	private int deli_zipcode;
	private String deli_addr;
	private String deli_detailaddr;
	private String deli_memo;
	private String pay_type;
	private String status;
}