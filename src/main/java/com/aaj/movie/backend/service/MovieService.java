package com.aaj.movie.backend.service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aaj.movie.backend.dao.MovieDAO;
import com.aaj.movie.backend.dto.MovieDTO;
import com.aaj.movie.backend.mapper.EntityDTOMapper;
import com.aaj.movie.entity.Movie;

@Service
public class MovieService {
     
    @Autowired
    MovieDAO movieDAO;

    // 查詢所有電影
    public List<MovieDTO> findAll(){
        return movieDAO.findAll().stream()
                        .map(EntityDTOMapper::toMovieDTO)
                        .collect(Collectors.toList());
    }

    // 透過 ID 查詢單一電影
    public Optional<MovieDTO> findMovieById(Long id){
        return movieDAO.findById(id)
                        .map(EntityDTOMapper::toMovieDTO);
    }

    // [新增一個方法] 為了給 update 和 delete 使用，保留一個返回 Entity 的方法
    public Optional<Movie> findMovieEntityById(Long id) {
        return movieDAO.findById(id);
    }

    // 新增或更新電影
    public Movie saveMovie(Movie movie){
        return movieDAO.save(movie);
    }

    // 刪除電影
    public void deleteMovie(Long id){
        movieDAO.deleteById(id);
    }
}
