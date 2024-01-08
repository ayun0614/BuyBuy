package com.ezen.buybuy.entity;

import lombok.Data;

@Data
public class AdminPo {
	private String category;
	private String searchTerm;
	private String member_id;      
    private int product_idx;         
    private String product_name;   
    private String ctgr_name;      
    private String start_date;   

}
