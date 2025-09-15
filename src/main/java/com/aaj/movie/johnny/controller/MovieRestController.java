package com.aaj.movie.johnny.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.aaj.movie.entity.Movie;
import com.aaj.movie.johnny.repository.MovieRepository;

/**
 * 提供電影資料 REST API
 */
@RestController
@RequestMapping("/api/movies")
public class MovieRestController {

    @Autowired
    private MovieRepository movieRepository;

    /**
     * 取得所有電影資料
     *
     * @return 電影清單
     */
    @GetMapping
    public List<Movie> getAllMovies() {
        return movieRepository.findAll();
    }

}
