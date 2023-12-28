package com.ezen.buybuy.entity;

import lombok.Data;

@Data
public class AdminReq {
	private String account_type;
    private String member_id;      
    private String name;           
    private String phone;          
    private String join_date;      
    private String account_status;
}