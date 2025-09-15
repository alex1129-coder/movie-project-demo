package com.aaj.movie.johnny.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.aaj.movie.entity.Seat;

import java.util.Optional;

public interface SeatRepository extends JpaRepository<Seat, Long> {
    Optional<Seat> findBySeatRowAndNumber(String seatRow, Integer number);
    
}

