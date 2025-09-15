//會員的控制器(controller)類別

package com.aaj.movie.allan.action;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.aaj.movie.allan.dao.UsersDao;
import com.aaj.movie.allan.entity.Users;

@RestController
@RequestMapping("/users")
public class UsersAction {
    @Autowired
    UsersDao usersDao;

	// 即時檢查帳號
    @GetMapping("/exists")
    public Map<String, Object> exists(@RequestParam String account) {
        String normalized = account.trim().toLowerCase(); // 若你要不分大小寫
        boolean taken = usersDao.existsByAccountIgnoreCase(normalized);

        Map<String, Object> rs = new HashMap<>();
        rs.put("account", account);
        rs.put("exists", taken);
        rs.put("available", !taken);
        return rs;
    }

    // 註冊：接收 JSON，存入 DB
    @PostMapping("/register")
    public ResponseEntity<Map<String, Object>> register(@RequestBody Users req) {
        String account = req.getAccount().trim().toLowerCase(); // 同一策略
        Map<String, Object> rs = new HashMap<>();

        // 先查避免丟例外
        if (usersDao.existsByAccountIgnoreCase(account)) {
            rs.put("success", false);
            rs.put("message", "此帳號已註冊");
            return ResponseEntity.status(HttpStatus.CONFLICT).body(rs);
        }

        req.setAccount(account);
        try {
            Users saved = usersDao.save(req);
            rs.put("success", true);
            rs.put("id", saved.getId());
            return ResponseEntity.ok(rs);
        } catch (DataIntegrityViolationException e) {
            // 萬一併發撞唯一鍵
            rs.put("success", false);
            rs.put("message", "此帳號已註冊");
            return ResponseEntity.status(HttpStatus.CONFLICT).body(rs);
        }
    }
}
