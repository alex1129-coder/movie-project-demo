package com.aaj.movie.allan.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.client.WebClient;

/*
 * 建立 WebClient 實例的配置類別
 * 它把「HTTP 用戶端的設定」抽離成可重用、可注入的 Bean，
 * 專門給 LinePayService（或其他要打 API 的服務）使用。
----目的與好處----
1.集中設定：baseUrl（sandbox/正式）、預設 Header、逾時、連線池、代理、重試、日誌…都在一處設定，之後全案共用。
2.環境切換：只改設定（yml/properties/環境變數）就能從 Sandbox 切到 Production，不改程式碼。
3.可重用/省資源：WebClient 是線程安全、具連線池的；作成 Bean 可重用同一組連線設定，避免每次 new 浪費。
4.好測試：Service 只「要一個 WebClient」，單元測試可注入假客戶端/Mock，不用真的打到 LINE Pay。
5.關注點分離：LinePayService 專心處理商業邏輯與簽章；HTTP 細節（逾時、連線）交給 Config。
 */

/*要用WebClient(呼叫Line Pay API)，要先加入 spring-boot-starter-webflux 依賴(pom.xml的dependency)
並在這裡建立 WebClient 實例，設定 baseUrl 為 Line Pay 的 API 基本網址*/
@Configuration
public class WebClientConfig {
  @Bean
    public WebClient linePayWebClient(LinePayProperties props) {
        return WebClient.builder()
                .baseUrl(props.getBaseUrl()) // 從設定檔讀取 baseUrl
                .defaultHeader("Content-Type", "application/json") // 預設 Header
                .build();
    }
}
