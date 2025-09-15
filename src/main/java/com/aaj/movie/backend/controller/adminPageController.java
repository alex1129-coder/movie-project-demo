package com.aaj.movie.backend.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class adminPageController {

    @GetMapping("/login")
    public String toLogin(){
        return "backend/admin-login";
    }
    
    @GetMapping("/dashboard")
    public String toDashboard(){
        return "backend/admin-dashboard";
    }

    @GetMapping("/movie")
    public String toMovie(){
        return "backend/admin-movie";
    }

    @GetMapping("/showtime")
    public String toShowtime(){
        return "backend/admin-showtime";
    }

    @GetMapping("/order")
    public String toOrder(){
        return "backend/admin-order";
    }

    @GetMapping("/user")
    public String toUser(){
        return "backend/admin-user";
    }
}