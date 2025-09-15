package com.aaj.movie.johnny.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home() {
        return "frontend/index";
    }

    @GetMapping("/test")
    public String testseat() {
        return "frontend/member_menu";
    }

    @GetMapping("/checkMember")
    public String checkMember() {
        return "frontend/checkMember";
    }

}
