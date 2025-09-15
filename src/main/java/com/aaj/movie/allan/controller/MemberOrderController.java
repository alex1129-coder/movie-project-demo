package com.aaj.movie.allan.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.aaj.movie.allan.service.OrderQueryService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MemberOrderController {

    @Autowired
    private OrderQueryService orderQueryService;

    @GetMapping("/select_order")
    public String myOrders(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("USER_ID");
        if (userId == null) userId = (Long) session.getAttribute("loginUserid"); // 相容舊鍵
        if (userId == null) return "redirect:/login"; // 沒登入就請先登入

        String name = (String) session.getAttribute("USER_NAME");
        if (name == null) {
            Object u = session.getAttribute("loginUser");
            if (u != null) try { name = (String) u.getClass().getMethod("getName").invoke(u); } catch (Exception ignore) {}
        }

        var rows = orderQueryService.findSummariesByUserId(userId);
        model.addAttribute("memberName", name != null ? name : "會員");
        model.addAttribute("rows", rows);
        return "frontend/select_order"; // 你要的一行一行列出的 JSP
    }
}
