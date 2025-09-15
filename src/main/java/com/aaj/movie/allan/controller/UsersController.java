package com.aaj.movie.allan.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.aaj.movie.allan.Repository.UsersRepository;
import com.aaj.movie.allan.entity.Users;

@Controller
public class UsersController {

    @Autowired
    private UsersRepository usersRepository;

    @GetMapping("/showUsers")
    public String showUsers(Model model) {
        List<Users> usersList = usersRepository.findAll(); // 讀取所有會員
        model.addAttribute("users", usersList);           // 放到前端
        return "showUsers";                                // 對應 showUsers.jsp
    }
}
