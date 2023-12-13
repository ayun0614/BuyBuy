package com.ezen.buybuy.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import lombok.Data;

@Data
public class Products {
	    private int product_IDX;
	    private String product_Name;
	    private String ptart_Date;
	    private String end_Date;
	    private String thumbnail_Img;  
	    private int original_Price;
	    private int discount_Price;
	    private String discount_Rate;
	    private String detail_Img;
	    private String content_State;
	    private int ctgr_IDX;
	    private int reg_ID;

	}

