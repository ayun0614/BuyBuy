package com.ezen.buybuy.entity;
import java.util.Date;
import lombok.Data;

@Data
public class Reply {
	private int reply_idx;
	private int product_idx;
	private String member_id;
	private String content;
	private Date content_date;
	
}
