package com.aaj.movie.backend.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import com.aaj.movie.backend.dao.AdminDAO;
import com.aaj.movie.backend.service.AdminService;
import com.aaj.movie.entity.Admin;

@Component
public class DataInitializer implements CommandLineRunner {

    @Autowired
    private AdminDAO adminDAO;

    @Autowired
    private AdminService adminService;

    @Override
    public void run(String... args) throws Exception {
        // 檢查資料庫中是否已有 Admin
        if (adminDAO.count() == 0) {
            // 如果沒有，則建立一個預設的 Admin
            Admin defaultAdmin = new Admin();
            defaultAdmin.setAccount("admin");
            defaultAdmin.setPassword("password"); // 密碼在 service 層會被加密
            
            adminService.createAdmin(defaultAdmin);
            System.out.println(">>> Created default admin user with account: 'admin' and password: 'password'");
        }
    }
}
