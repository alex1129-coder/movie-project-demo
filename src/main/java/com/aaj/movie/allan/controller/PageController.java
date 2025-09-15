package com.aaj.movie.allan.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

    // /WEB-INF/views/frontend/register.jsp
    @GetMapping("/register")
    public String registerPage() {
        return "frontend/register"; // 會對應到 /WEB-INF/views/frontend/register.jsp,小心 我的依賴是/WEB-INF/views/
    }

    // /WEB-INF/views/cart/cart.jsp
    @GetMapping("/cart")
    public String cart() {
        return "cart/cart";
    }

    // /WEB-INF/views/product/prod.jsp
    @GetMapping("/prod")
    public String productPage() {
        return "product/prod";
    }

    // 這兩個通常不是手動開，而是付款流程成功/失敗後由 Controller return
    // /WEB-INF/views/payment/payment-success.jsp
    @GetMapping("/payment/success")
    public String paymentSuccess() {
        return "payment/payment-success";
    }

    // /WEB-INF/views/payment/payment-failed.jsp
    @GetMapping("/payment/failed")
    public String paymentFailed() {
        return "payment/payment-failed";
    }
}
