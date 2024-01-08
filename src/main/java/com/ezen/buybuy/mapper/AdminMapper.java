package com.ezen.buybuy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.ezen.buybuy.entity.AdminChart;
import com.ezen.buybuy.entity.AdminDonut;
import com.ezen.buybuy.entity.AdminPo;
import com.ezen.buybuy.entity.AdminPost;
import com.ezen.buybuy.entity.AdminReq;
import com.ezen.buybuy.entity.AdminUser;
import com.ezen.buybuy.entity.Banner;


public interface AdminMapper {
   
   public List<AdminPost> getList();
   public List<AdminUser> getuserInfo();
   public List<AdminReq> getuserReq();
   public void postDelete(int product_idx);
   public List<AdminDonut> donutList();
   public void updateMember(String memberId);
   public void disableForeignKeyChecks();
   public void insertBannerImg(Banner banner);
   public List<AdminChart> getHourlyTotal(String date);
   public List<AdminReq> searchInfo(String name);
   public List<AdminPo> searchpost(@Param("category") String category, @Param("searchTerm") String searchTerm);
   public List<Banner> getbanner();
   public void deleteBanner(String image_url);
   public void enableForeignKeyChecks();
   public void updateStatus(String name, String account_status);
   public void refuseUser(String member_id);
   public List<AdminChart> getTodayTotal();
}
