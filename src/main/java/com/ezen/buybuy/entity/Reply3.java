package com.ezen.buybuy.entity;
import java.util.Date;
import lombok.Data;

@Data
public class Reply3 {
	
	private String member_id;	
	private String name;
	private String nickname; 
	private String profileimg;
	
	private int reply_idx;
	private int reply2_idx;
	private int product_idx;
	
	private String content;
	private Date content_date;
	private String content2;
	private Date content2_date;
	
	private int product_IDX;

}
