package com.aaj.movie.backend.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.aaj.movie.entity.Ticket;

public interface TicketDAO extends JpaRepository<Ticket, Long> {

    // 根據方法名稱，Spring Data JPA 會自動產生查詢來檢查是否存在符合條件的票券
    boolean existsByShowtimeId(Long showtimeId);
}
