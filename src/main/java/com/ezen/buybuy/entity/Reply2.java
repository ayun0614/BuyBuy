package com.ezen.buybuy.entity;
import java.util.Date;
import lombok.Data;

@Data
public class Reply2 {
	private int reply2_idx;
	private String member_id;
	private int reply_idx;
	private String content2;
	private Date content2_date;
	private int product_idx;
}
