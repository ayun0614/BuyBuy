package com.ezen.buybuy.entity;

import lombok.Data;

@Data
public class Alert {
	private int a_idx;
	private String a_title;
	private String msg;
	private String member_id;
	private String a_url;
	private int a_state;
	private int product_idx;
	private int reply_idx;
	private String thumbnail_img;
}
