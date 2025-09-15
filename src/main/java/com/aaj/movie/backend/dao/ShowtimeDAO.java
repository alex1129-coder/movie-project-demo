package com.aaj.movie.backend.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.aaj.movie.entity.Showtime;

public interface  ShowtimeDAO extends JpaRepository<Showtime, Long>{
    
}
