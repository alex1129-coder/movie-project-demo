package com.aaj.movie.backend.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.aaj.movie.backend.service.AdminService;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationProvider authenticationProvider(AdminService adminService) { // 直接將需要的 Service 作為參數傳入
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setUserDetailsService(adminService); // 指定 UserDetailsService
        provider.setPasswordEncoder(passwordEncoder()); // 指定密碼編碼器
        return provider;
    }

    @Bean
    @Order(1) // Admin 的安全設定優先級較高
    public SecurityFilterChain adminFilterChain(HttpSecurity http) throws Exception {
        http
            .securityMatcher("/admin/**") // 此設定只作用於 /admin/ 開頭的路徑
            .authorizeHttpRequests(authz -> authz
                .requestMatchers("/admin/login").permitAll() // 登入頁面公開
                .anyRequest().hasRole("ADMIN") // 其他 /admin/ 路徑需要 ADMIN 角色
            )
            .formLogin(form -> form
                .loginPage("/admin/login") // 我們自訂的登入頁面
                .loginProcessingUrl("/admin/login") // 表單提交的位址
                .usernameParameter("account") // 自訂帳號欄位的名稱
                .passwordParameter("password") // 自訂密碼欄位的名稱
                .defaultSuccessUrl("/admin/dashboard", true) // 登入成功後強制導向到儀表板
                .permitAll()
            )
            .logout(logout -> logout
                .logoutUrl("/admin/logout")
                .logoutSuccessUrl("/admin/login?logout")
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID")
            )
            .csrf(csrf -> csrf.disable()) // 暫時禁用 CSRF 以進行測試
            .headers(headers -> headers.cacheControl(cache -> cache.disable())); // 關閉快取

        return http.build();
    }

    @Bean
    @Order(2) // 一般使用者的安全設定
    public SecurityFilterChain appFilterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(authz -> authz
                .anyRequest().permitAll() // 暫時允許所有非 admin 的請求
            )
            .csrf(csrf -> csrf.disable()); // 為了方便測試，暫時關閉 CSRF

        return http.build();
    }
}
