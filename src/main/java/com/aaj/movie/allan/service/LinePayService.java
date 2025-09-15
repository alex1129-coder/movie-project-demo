package com.aaj.movie.allan.service;

import com.aaj.movie.entity.Order;

public interface LinePayService {
    /** 建立支付，回傳導轉到 LINE Pay 的網址 */
    String requestPayment(Order order);

    /** 確認付款（用 LINE Pay 回傳的 txId 與 DB 的訂單資訊） */
    boolean confirmPayment(String transactionId, Order order);
}
