package com.ezen.buybuy.entity;

import java.sql.Date;

import lombok.Data;

@Data
public class Members {
	private String member_id;
	private String password;
	private String name;
	private String nickname;
	private String account_type;
	private int zipcode;
	private String addr;
	private String detailaddr;
	private String phone;
	private String email;
	private String profileImg;
	private Date join_date;
	private String account_status;

	private int applydealer_status;
}
