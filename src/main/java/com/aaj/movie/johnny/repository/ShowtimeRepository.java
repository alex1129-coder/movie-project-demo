package com.aaj.movie.johnny.repository;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.aaj.movie.entity.Showtime;

public interface ShowtimeRepository extends JpaRepository<Showtime, Long> {
        List<Showtime> findByMovieId(Long movieId);

}
