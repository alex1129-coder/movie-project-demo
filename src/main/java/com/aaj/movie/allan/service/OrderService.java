package com.aaj.movie.allan.service;

import java.math.BigDecimal;

import com.aaj.movie.entity.Order;

//訂單的服務介面
//定義訂單相關的業務邏輯方法
//實作類別會實現這些方法來處理訂單的建立、狀態更新等操作
//create表示建立新訂單
//markPending表示將訂單標記為待處理
//markPaid表示將訂單標記為已付款
//markFailed表示將訂單標記為付款失敗
//markCancelled表示將訂單標記為已取消
//markRefunded表示將訂單標記為已退款
public interface OrderService {
    Order create(Long userId, BigDecimal totalAmount, String orderNumber);
    Order getByOrderNumber(String orderNumber);
    Order markPending(String orderNumber);
    Order markPaid(String orderNumber, String transactionId);
    Order markFailed(String orderNumber);
    Order markCancelled(String orderNumber);
    Order markRefunded(String orderNumber);
}

