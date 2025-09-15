package com.aaj.movie.allan.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aaj.movie.allan.dao.UsersDao;
import com.aaj.movie.allan.entity.Users;

@Service
public class UsersService {

    private final UsersDao usersDao;

    // 直接手寫建構子（取代 Lombok）
    public UsersService(UsersDao usersDao) {
        this.usersDao = usersDao;
    }

    public boolean accountExists(String account) {
        return usersDao.existsByAccountIgnoreCase(account);
    }

    @Transactional(readOnly = true)
    public Users authenticate(String account, String password) {
        // 明碼比對（未加密）
        return usersDao.findByAccountIgnoreCaseAndPassword(account, password).orElse(null);
    }
}
