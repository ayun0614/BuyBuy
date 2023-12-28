package com.ezen.buybuy.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import com.ezen.buybuy.entity.Members;
import com.ezen.buybuy.mapper.MemberMapper;


public class LoginInterceptor implements HandlerInterceptor {

	@Autowired
    MemberMapper memberMapper;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        Members mvo = (Members) session.getAttribute("mvo");
        System.out.println(mvo);
        if (mvo == null) { // 로그인 안된 상태라면
            String con = request.getContextPath(); // 현재 경로를 알아냄
            response.sendRedirect(con + "/");
            return false;
        }
        return true;
    }
}