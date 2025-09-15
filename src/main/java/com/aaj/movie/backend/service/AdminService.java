package com.aaj.movie.backend.service;

import java.util.Collections;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.aaj.movie.backend.dao.AdminDAO;
import com.aaj.movie.entity.Admin;

@Service
public class AdminService implements UserDetailsService {

    private final AdminDAO adminDAO;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public AdminService(AdminDAO adminDAO, PasswordEncoder passwordEncoder) {
        this.adminDAO = adminDAO;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Optional<Admin> adminOptional = adminDAO.findByAccount(username);
        if (adminOptional.isEmpty()) {
            throw new UsernameNotFoundException("找不到管理員帳號: " + username);
        }
        Admin admin = adminOptional.get();
        // 將 Admin 物件轉換為 Spring Security 需要的 UserDetails 物件
        return new User(admin.getAccount(), admin.getPassword(), Collections.singletonList(new SimpleGrantedAuthority("ROLE_ADMIN")));
    }

    public Admin createAdmin(Admin admin) {
        // 將原始密碼加密
        String encodedPassword = passwordEncoder.encode(admin.getPassword());
        admin.setPassword(encodedPassword);
        // 儲存到資料庫
        return adminDAO.save(admin);
    }

    public Optional<Admin> findByAccount(String account) {
        return adminDAO.findByAccount(account);
    }
}
