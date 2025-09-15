package com.aaj.movie.johnny.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.aaj.movie.entity.Ticket;

import java.util.List;
import java.util.Optional;


public interface TicketRepository extends JpaRepository<Ticket, Long> {

        List<Ticket> findByShowtimeId(Long showtimeId);

}
