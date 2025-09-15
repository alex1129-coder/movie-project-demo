package com.aaj.movie.johnny.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.aaj.movie.entity.Showtime;
import com.aaj.movie.johnny.repository.ShowtimeRepository;

/**
 * 提供電影資料 REST API
 */
@RestController
@RequestMapping("/api/showtimes")
public class ShowtimeController {

    @Autowired
    private ShowtimeRepository showtimeRepository;

    /**
     * 取得所有電影資料
     *
     * @return 電影清單
     */
    @GetMapping
    public List<Showtime> getAllShowtime() {
        return showtimeRepository.findAll();
    }

}
