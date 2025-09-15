package com.aaj.movie.allan.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.aaj.movie.allan.entity.Users;
import com.aaj.movie.allan.service.UsersService;
import com.aaj.movie.johnny.repository.UserRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class FrontendLoginController {

    private final UsersService usersService;

    @Autowired
    private UserRepository userRepository;


    // 直接手寫建構子（先不用 Lombok）
    public FrontendLoginController(UsersService usersService) {
        this.usersService = usersService;
    }

    // 顯示登入頁
    @GetMapping("/login")
    public String loginPage(@RequestParam(value = "account", required = false) String account,
                            Model model) {
        Map<String, String> form = new HashMap<>();
        form.put("account", account == null ? "" : account);
        model.addAttribute("form", form);
        return "frontend/login"; // 對應 /WEB-INF/views/frontend/login.jsp
    }

    // 提交登入
    @PostMapping("/login")
    public String doLogin(@RequestParam("account") String account,
                          @RequestParam("password") String password,
                          Model model,
                          HttpSession session) {

        Map<String, String> errors = new HashMap<>();
        Map<String, String> form = new HashMap<>();
        String acc = account == null ? "" : account.trim();
        form.put("account", acc);

        // 1) 基本驗證
        if (acc.isEmpty()) errors.put("account", "請輸入帳號");
        if (password == null || password.trim().isEmpty()) errors.put("password", "請輸入密碼");
        if (!errors.isEmpty()) {
            model.addAttribute("errors", errors);
            model.addAttribute("form", form);
            return "frontend/login";
        }

        // 2) 帳號是否存在
        if (!usersService.accountExists(acc)) {
            errors.put("account", "帳號不存在");
            model.addAttribute("errors", errors);
            model.addAttribute("form", form);
            return "frontend/login";
        }

        // 3) 明碼驗證（未加密）
        Users user = usersService.authenticate(acc, password);
        if (user == null) {
            errors.put("password", "密碼錯誤");
            model.addAttribute("errors", errors);
            model.addAttribute("form", form);
            return "frontend/login";
        }

        //注入介面
        Long userId = user.getId();
        System.out.println(userId);
        session.setAttribute("loginUserid", userId);

        // 4) 登入成功 → 存 session、跳轉
            // 舊鍵（為了相容你現有程式）
        session.setAttribute("loginUserid", user.getId());
        session.setAttribute("loginUser", user);
            // 新鍵（建議未來都用這三個）
        session.setAttribute("USER_ID", user.getId());               // 建議：統一使用
        session.setAttribute("USER_NAME", user.getName());           // 用來顯示 Hi, xxx
        session.setAttribute("USER_ACCOUNT", user.getAccount());     // 需要帳號時用
        
        // 登入成功就回會員首頁
        // return "redirect:/member_menu"; 
        // 登入成功就回首頁，並顯示 Hi!XXX
        return "redirect:/?login_success=true";
        //-----技術總結-----
        //小學生版：把重要資料（學號=USER_ID、名字=USER_NAME）放進書包（Session），之後走到哪一頁都拿得到!
    }

    // 登出
    @PostMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
