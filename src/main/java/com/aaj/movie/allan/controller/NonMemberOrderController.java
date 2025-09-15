package com.aaj.movie.allan.controller;

// 這個 Controller 專門給「非會員查詢」用。
// 做兩件事：
// 1. 顯示查詢頁（GET）
// 2. 接收帳號並查詢（POST），把結果送回同一頁面顯示


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.aaj.movie.allan.dto.OrderSummaryRow;
import com.aaj.movie.allan.service.OrderQueryService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class NonMemberOrderController {

    @Autowired
    private OrderQueryService orderQueryService; // 叫「查詢服務」幫我們撈資料

    public NonMemberOrderController(OrderQueryService orderQueryService) {
        this.orderQueryService = orderQueryService;
    }

    // 顯示查詢頁：網址 http://localhost:8080/select_order_non_member
    @GetMapping("/select_order_non_member")
    public String page() {
        // 回傳 JSP 視圖名稱（不要加斜線）
        // 這會對應到 /WEB-INF/views/frontend/select_order_non_member.jsp
        return "frontend/select_order_non_member";
    }

    // 接收表單（只有一個 account 欄位），查詢並回同一頁
    @PostMapping("/select_order_non_member")
    public String search(@RequestParam("account") String account, Model model) {
        // 請「查詢服務」幫忙用 account 找訂單清單
        List<OrderSummaryRow> rows = orderQueryService.findSummariesByAccount(account);

        if (rows.isEmpty()) {
            // 查不到我們就顯示固定訊息（不要告訴他帳號不存在，這樣比較安全）
            model.addAttribute("errorMsg", "帳號輸入錯誤");
        } else {
            // 查到了就把結果丟到頁面上
            model.addAttribute("rows", rows);
        }
        // 不論成功或失敗，都回同一頁（顯示結果或錯誤訊息）
        return "frontend/select_order_non_member";
    }
}
