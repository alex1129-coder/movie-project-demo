package com.aaj.movie.backend.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.aaj.movie.entity.Seat;

@Repository
public interface SeatDAO extends JpaRepository<Seat, Long> {
}
