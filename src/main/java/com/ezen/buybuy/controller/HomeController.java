package com.ezen.buybuy.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ezen.buybuy.entity.Banner;
import com.ezen.buybuy.entity.Products;
import com.ezen.buybuy.mapper.AdminMapper;
import com.ezen.buybuy.mapper.ProductMapper;

@Controller
public class HomeController {

   @Autowired
   ProductMapper productVAO;

   @Autowired
   AdminMapper adminVAO;

   @RequestMapping(value = "/", method = RequestMethod.GET)
   public String home(Model model) {
      List<Products> popList, newList;
      List<Banner> bannerList;
      popList = productVAO.PopMain(4);
      newList = productVAO.NewMain(4);
      bannerList = adminVAO.getbanner();

      model.addAttribute("popList", popList);
      model.addAttribute("newList", newList);
      model.addAttribute("bannerList", bannerList);
      model.addAttribute("bannerCount", bannerList.size());
      
      return "main";
   }
}