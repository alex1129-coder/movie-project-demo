package com.aaj.movie.allan.service.impl;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import com.aaj.movie.allan.config.LinePayProperties;
import com.aaj.movie.allan.service.LinePayService;
import com.aaj.movie.allan.service.OrderService;
import com.aaj.movie.allan.util.LinePaySigner;
import com.aaj.movie.allan.util.LinePaySigner.Mode;
import com.aaj.movie.entity.Order;

@Service
public class LinePayServiceImpl implements LinePayService {

    private final WebClient client;
    private final LinePayProperties props;
    private final OrderService orderService;

    public LinePayServiceImpl(WebClient linePayWebClient,
            LinePayProperties props,
            OrderService orderService) {
        this.client = linePayWebClient;
        this.props = props;
        this.orderService = orderService;
    }


    // 1) 抽一個共用：送出 + 回傳 Map（字典）
    private Map<String, Object> postJson(String path, String jsonBody) {
        return client.post()
                .uri(path)
                .contentType(org.springframework.http.MediaType.APPLICATION_JSON)
                .headers(h -> applySignedHeaders(h, path, jsonBody)) // 這裡會帶簽章
                .bodyValue(jsonBody)
                .retrieve()
                .bodyToMono(new org.springframework.core.ParameterizedTypeReference<Map<String, Object>>() {
                })
                .block();
    }

    // 2) 檢查 returnCode 是否成功，否則丟出帶細節的錯誤
    private void assertOk(Map<String, Object> resp, String apiName) {
        String code = String.valueOf(resp.get("returnCode"));
        if (!"0000".equals(code)) {
            String msg = String.valueOf(resp.get("returnMessage"));
            throw new IllegalStateException(
                    "LINE Pay " + apiName + " 失敗：returnCode=" + code + " msg=" + msg + " body=" + resp);
        }
    }

    @Override
    public String requestPayment(Order order) {
        int amt = toPayAmount(order.getTotalAmount());
        String orderNo = order.getOrderNumber();

        // products：可多個；這裡示範 1 個商品＝整筆訂單
        Map<String, Object> product = new LinkedHashMap<>();
        product.put("name", "Movie Order " + orderNo);
        product.put("quantity", 1); // 多張票就改成張數
        product.put("price", amt); // 必須是整數

        Map<String, Object> pkg = new LinkedHashMap<>();
        pkg.put("id", "pkg-" + orderNo);
        pkg.put("amount", amt); // = Σ(price * quantity)
        pkg.put("products", java.util.List.of(product));

        Map<String, Object> bodyMap = new LinkedHashMap<>();
        bodyMap.put("amount", amt); // = Σ(packages.amount)
        bodyMap.put("currency", "TWD");
        bodyMap.put("orderId", orderNo);
        bodyMap.put("packages", java.util.List.of(pkg));
        bodyMap.put("redirectUrls", Map.of(
                "confirmUrl", props.getReturnUrl(),
                "cancelUrl", props.getReturnUrl()));

        String path = "/v3/payments/request";
        String json = LinePaySigner.toCompactJson(bodyMap);

        Map<String, Object> resp = postJson(path, json);
        assertOk(resp, "request");

        @SuppressWarnings("unchecked")
        Map<String, Object> info = (Map<String, Object>) resp.get("info");
        @SuppressWarnings("unchecked")
        Map<String, Object> paymentUrl = (Map<String, Object>) info.get("paymentUrl");
        return String.valueOf(paymentUrl.get("web"));
    }

    @Override
    public boolean confirmPayment(String transactionId, Order order) {
        int amt = toPayAmount(order.getTotalAmount());
        Map<String, Object> bodyMap = new LinkedHashMap<>();
        bodyMap.put("amount", amt); // 必須與 request 時相同
        bodyMap.put("currency", "TWD");

        String path = "/v3/payments/" + transactionId + "/confirm";
        String json = LinePaySigner.toCompactJson(bodyMap);

        Map<String, Object> resp = postJson(path, json);
        assertOk(resp, "confirm");

        orderService.markPaid(order.getOrderNumber(), transactionId);
        return true;
    }

    /** 把簽章相關 header 加上（預設用 PAY_V3_A；若 sandbox 回 401，可改成 PAY_V3_B 再試） */
    private void applySignedHeaders(HttpHeaders headers, String path, String jsonBody) {
        LinePaySigner.applyHeaders(
                headers,
                props.getChannelId(),
                props.getChannelSecret(),
                path,
                jsonBody,
                Mode.PAY_V3_A);
    }

    private int toPayAmount(BigDecimal amount) {
        if (amount == null)
            throw new IllegalArgumentException("amount is null");
        // TWD/JPY 等幣別都用整數金額；四捨五入到個位數
        BigDecimal v = amount.setScale(0, RoundingMode.HALF_UP);
        if (v.signum() <= 0)
            throw new IllegalArgumentException("amount must be > 0");
        return v.intValueExact();
    }
}
