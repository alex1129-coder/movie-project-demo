package com.aaj.movie.allan.util;

import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Objects;
import java.util.UUID;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.http.HttpHeaders;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;

/**
 * 產生 LINE Pay 的 X-LINE-Authorization 簽章。
 * 用法（建議）：LinePaySigner.applyHeaders(headers, channelId, channelSecret, path, jsonBody, Mode.PAY_V3_A)
 */
public final class LinePaySigner {

    /** 兩種常見簽章模式（擇一能通過 sandbox 的就固定使用） */
    public enum Mode {
        // stringToSign = channelSecret + path + body + nonce; key = channelSecret
        PAY_V3_A,
        // stringToSign = path + body + nonce; key = channelSecret
        PAY_V3_B
    }

    private static final ObjectMapper MAPPER = new ObjectMapper()
            .configure(SerializationFeature.ORDER_MAP_ENTRIES_BY_KEYS, true);

    private LinePaySigner() {}

    /** 一次把 HTTP 簽章相關 header 都塞好，回傳本次 nonce（可用於除錯） */
    public static String applyHeaders(HttpHeaders headers,
                                      String channelId,
                                      String channelSecret,
                                      String requestPath,   // ex: "/v3/payments/request"（若有 query 一併含上）
                                      Object body,          // Map / DTO / String(JSON) / null
                                      Mode mode) {
        String nonce = UUID.randomUUID().toString();
        String auth = buildAuthorization(channelSecret, requestPath, body, nonce, mode);

        headers.add(HttpHeaders.CONTENT_TYPE, "application/json");
        headers.add("X-LINE-ChannelId", channelId);
        headers.add("X-LINE-Authorization-Nonce", nonce);
        headers.add("X-LINE-Authorization", auth);
        return nonce;
    }

    /** 回傳 X-LINE-Authorization 簽章字串（Base64(HMAC-SHA256(...))） */
    public static String buildAuthorization(String channelSecret,
                                            String requestPath,
                                            Object body,
                                            String nonce,
                                            Mode mode) {
        Objects.requireNonNull(channelSecret, "channelSecret");
        Objects.requireNonNull(requestPath, "requestPath");
        Objects.requireNonNull(nonce, "nonce");

        String normalizedBody = toCompactJson(body); // null -> ""
        String stringToSign = switch (mode) {
            case PAY_V3_A -> channelSecret + requestPath + normalizedBody + nonce;
            case PAY_V3_B ->                 requestPath + normalizedBody + nonce;
        };

        byte[] hmac = hmacSha256(channelSecret, stringToSign);
        return Base64.getEncoder().encodeToString(hmac);
    }

    /** 將 body 轉成「無多餘空白」的 JSON 字串；若 body 為 null 則回空字串 */
    public static String toCompactJson(Object body) {
        if (body == null) return "";
        if (body instanceof CharSequence cs) {
            String s = cs.toString().trim();
            return s.isEmpty() ? "" : s;
        }
        try {
            return MAPPER.writeValueAsString(body); // 緊湊 JSON
        } catch (JsonProcessingException e) {
            throw new IllegalArgumentException("Failed to serialize body to JSON", e);
        }
    }

    /** HMAC-SHA256(message) with key=channelSecret */
    private static byte[] hmacSha256(String channelSecret, String message) {
        try {
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(new SecretKeySpec(channelSecret.getBytes(StandardCharsets.UTF_8), "HmacSHA256"));
            return mac.doFinal(message.getBytes(StandardCharsets.UTF_8));
        } catch (Exception e) {
            throw new RuntimeException("Failed to compute HMAC-SHA256", e);
        }
    }
}
