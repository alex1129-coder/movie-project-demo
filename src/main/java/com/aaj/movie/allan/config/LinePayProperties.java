package com.aaj.movie.allan.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/*
 * 讀取 application.properties 中以 linepay 開頭的設定
 * 並將其注入到這個類別的對應欄位中
 */
@Configuration
@ConfigurationProperties(prefix = "linepay")
public class LinePayProperties {
    private String channelId, channelSecret, baseUrl, returnUrl, notifyUrl;
    
    // getters/setters
    public String getChannelId() { return channelId; }
    public void setChannelId(String channelId) { this.channelId = channelId; }
    public String getChannelSecret() { return channelSecret; }
    public void setChannelSecret(String channelSecret) { this.channelSecret = channelSecret; }
    public String getBaseUrl() { return baseUrl; }
    public void setBaseUrl(String baseUrl) { this.baseUrl = baseUrl; }
    public String getReturnUrl() { return returnUrl; }
    public void setReturnUrl(String returnUrl) { this.returnUrl = returnUrl; }
    public String getNotifyUrl() { return notifyUrl; }
    public void setNotifyUrl(String notifyUrl) { this.notifyUrl = notifyUrl; }
}
