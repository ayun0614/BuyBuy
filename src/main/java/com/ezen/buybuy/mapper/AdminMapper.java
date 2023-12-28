package com.ezen.buybuy.mapper;

import java.util.List;
import java.util.Map;

import com.ezen.buybuy.entity.AdminChart;
import com.ezen.buybuy.entity.AdminDonut;
import com.ezen.buybuy.entity.AdminPost;
import com.ezen.buybuy.entity.AdminReq;
import com.ezen.buybuy.entity.AdminUser;
import com.ezen.buybuy.entity.Banner;
import com.ezen.buybuy.entity.Members;

public interface AdminMapper {
	
	public List<AdminPost> getList();
	public List<AdminUser> getuserInfo();
	public List<AdminReq> getuserReq();
	public void postDelete(int product_idx);
	public List<AdminDonut> donutList();
	public void updateMember(String memberId);
	public void updateStatus(Members member);
	public void disableForeignKeyChecks();
	public void insertBannerImg(Banner banner);
	public List<AdminChart> getHourlyTotal(String date);
	public List<AdminReq> searchInfo(String name);
}

