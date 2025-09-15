package com.aaj.movie.allan.controller;

import java.math.BigDecimal;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aaj.movie.allan.service.LinePayService;
import com.aaj.movie.allan.service.OrderService;
import com.aaj.movie.entity.Order;

@Controller
@RequestMapping("/orders")
public class CheckoutController {

    private final OrderService orderService;
    private final LinePayService linePayService;

    public CheckoutController(OrderService orderService, LinePayService linePayService) {
        this.orderService = orderService;
        this.linePayService = linePayService;
    }

    @PostMapping("/checkout")
    @ResponseBody
    public ResponseEntity<?> checkout(@RequestParam String orderNumber) {
        Order order = orderService.getByOrderNumber(orderNumber);
        String paymentUrl = linePayService.requestPayment(order);
        return ResponseEntity.ok(Map.of("orderNumber", orderNumber, "paymentUrl", paymentUrl));
    }

    // LINE Pay 付款後回跳（注意回來的參數名稱）
    @GetMapping("/linepay/return")
    public ModelAndView returnFromLinePay(
            @RequestParam(name = "transactionId", required = false) String txId,
            @RequestParam(name = "orderId", required = false) String orderNo) {

        ModelAndView mav = new ModelAndView();
        try {
            if (txId == null || orderNo == null) {
                mav.setViewName("/payment/failed");
                mav.addObject("errorMessage", "缺少必要參數");
                return mav;
            }
            Order order = orderService.getByOrderNumber(orderNo);
            linePayService.confirmPayment(txId, order); // 成功會把訂單設為 PAID
            mav.setViewName("payment/payment-success");
            //mav.addObject("amount", order.getTotalAmount()); //把TotalAmount 塞進model 帶到成功頁面
            mav.addObject("amount", order.getTotalAmount());
            mav.addObject("orderNumber", orderNo);
            mav.addObject("transactionId", txId);
        } catch (Exception e) {
            mav.setViewName("/payment/failed");
            mav.addObject("errorMessage", e.getMessage());
        } finally {
            mav.addObject("orderNumber", orderNo);
            mav.addObject("transactionId", txId);
        }
        return mav;
    }

    
}
